/*===========================================================================*=
	Slave_telescope - Tanguy Dietrich
  =============================================================================
   Descriptif: Permet de reguler la temperature des miroir ou des lentille
   			   d'un telescope en utilisant la temperature du point de rose
   			   ou des potentiometre
   
=*===========================================================================*/

#include <reg51f380.h>     // registres 51f38C
#include "SmBus0.h"
#include "PID.h"
#include "Delay48M.h"
#include "math.h"

#define LOADVALUE_T0 15536
#define LOADVALUE_BAUD 247

// ==== FONCTIONS PROTOTYPES===================================================
void ClockInit ();         // init. clock syst�me
void PortInit ();          // init. config des ports
void SMBus_Init (void);
void Timer3_Init (void);
void Timer2_Init (void);
void Uart0Init();
void SMB_Write (void);
void SMB_Read (void);
void PCA_Init();
void decodeUart0();
void TimerInit();
void ADCInit();
void configEeh210(unsigned char mode);
long convertToTemp_i2c(unsigned int value);
unsigned int convertToHumi(unsigned int value);
long getTempAmbiante();
unsigned int GetHumidite();
void actu_Pca0_Pid(int tempCapt,int consigne);
void actu_Pca1_Pid(int tempCapt,int consigne);
void actu_Pca2_Pid(int tempCapt,int consigne);
void actu_Pca3_Pid(int tempCapt,int consigne);
int convertLm35ToTemp(unsigned int adc_pos,unsigned int adc_neg);
void reset_i2c();
int calculRose(float t_ambiante, float humidite);
unsigned char ConvertToPca(unsigned int adc);
void ActuAvgMesure(unsigned int tabMesure[12][NMESURE], unsigned int tabSortie[]);
sbit SDA = P0^6;
sbit SCL= P0^7;
// ==== MAIN ==================================================================

//SMBus0
unsigned char gSMBNumBytesToWR = 2; // Number of bytes to write
                                    // Master -> Slave
unsigned char gSMBNumBytesToRD = 3; // Number of bytes to read
                                    // Master <- Slave

// Global holder for SMBus data
// All receive data is written here
xdata unsigned char gSMBDataIN[NUM_BYTES_MAX_RD];

// Global holder for SMBus data.
// All transmit data is read from here
xdata unsigned char gSMBDataOUT[NUM_BYTES_MAX_WR];

unsigned char gTarget;                  // gTarget SMBus slave address

bit SMB_BUSY;                          // Software flag to indicate when the
                                       // SMB_Read() or SMB_Write() functions
                                       // have claimed the SMBus

bit SMB_RW;                            // Software flag to indicate the
                                       // direction of the current transfer

xdata unsigned long NUM_ERRORS;              // Counter for the number of errors.



//Uart
xdata unsigned char gUart0Tx[15]="";
xdata unsigned char gUart0Rx[15];
unsigned char gUart0NbrByteTx=0;
unsigned char gUart0NbrByteRx=0;
bit gUart0FlagReceive;

//Mesure ADC
xdata unsigned int gMesure[12][NMESURE];
xdata unsigned int gMesureAvg[12];
bit gFlagMesureAvg=0;

bit gFlagActuI2c=0;
long gTempAmbiante=0;
unsigned int gHumidite=0;
unsigned char gModeRegulation=MODE_UART;
bit gFlagPot=0;
void main () 
{
   //unsigned char i=0;
   //unsigned char temp_pwm=0;
   int tempSensor;
   int temp_rose=0;
   PCA0MD &= ~0x40;     // WDTE = 0 (disable watchdog timer)
   ClockInit ();        // init. clock syst�me
   PortInit ();         // init. config des ports
   Timer3_Init();                      // Configure Timer3 for use with SMBus
                                       // low timeout detect
   Timer2_Init();
   SMBus_Init ();                      // Configure and enable SMBus
   PCA_Init();
   TimerInit();
   Uart0Init();
   ADCInit();
   
   EA=1;//Autorise toutes les interruption
   IE|=0x90;
   EIE1 |= 0x09;
   TR1=1;
   TR0=1;
	SDA=1;
   reset_i2c();
   configEeh210(0);
   gHumidite=GetHumidite();
   gTempAmbiante=getTempAmbiante();
   while (1)
   {
      gModeRegulation=P0&0x07;
      if(gUart0FlagReceive)
      {
         gUart0FlagReceive=0;
         decodeUart0();
      }
      
      if(gFlagMesureAvg)
      {
         gFlagMesureAvg=0;
         ActuAvgMesure(gMesure,gMesureAvg);
         if(gModeRegulation==MODE_PID)
         {
            tempSensor=convertLm35ToTemp(gMesureAvg[LM35_0_POS],gMesureAvg[LM35_0_NEG]);
            actu_Pca0_Pid(tempSensor,temp_rose);
            
            tempSensor=convertLm35ToTemp(gMesureAvg[LM35_1_POS],gMesureAvg[LM35_1_NEG]);
            actu_Pca1_Pid(tempSensor,temp_rose);
            
            tempSensor=convertLm35ToTemp(gMesureAvg[LM35_2_POS],gMesureAvg[LM35_2_NEG]);
            actu_Pca2_Pid(tempSensor,temp_rose);
            
            tempSensor=convertLm35ToTemp(gMesureAvg[LM35_3_POS],gMesureAvg[LM35_3_NEG]);
            actu_Pca3_Pid(tempSensor,temp_rose);
         }
      }
      
      if(gFlagPot)
      {
         gFlagPot=0;
         if(gModeRegulation==MODE_POT)
         {
            PCA0CPH0=ConvertToPca(gMesure[POT_0][0]);
            PCA0CPH1=ConvertToPca(gMesure[POT_1][0]);
            PCA0CPH2=ConvertToPca(gMesure[POT_2][0]);
            PCA0CPH3=ConvertToPca(gMesure[POT_3][0]);
         }
      }
      
      if(gFlagActuI2c)
      {
         gHumidite=GetHumidite();
         gTempAmbiante=getTempAmbiante();
         temp_rose=calculRose(gTempAmbiante, gHumidite);
         temp_rose+=CORRECTION_TEMPERATURE;
         //temp_rose=DEMO_CONSIGNE;
         gFlagActuI2c=0;
         //temp_rose=calculRose(300, 60);
      }
   } // End while (1)
} // main =====================================================================

/*---------------------------------------------------------------------------*-
timer0()
-----------------------------------------------------------------------------
Descriptif: Fonction d'interruption Timer0 vecteur 1
          Temporisation de 50milli
          Mode : 16bit
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void timer0() interrupt 1
{
   static unsigned char cpt_i2c=0;
   static unsigned char cpt_adc=0;
   TR0=0;
   TH0=LOADVALUE_T0/256;//Charge la valeur dans le registre MSB du timer 0
   TL0=LOADVALUE_T0%256;//Charge la valeur dans le registre LSB du timer 0
   //TR0=1;
   if(cpt_adc>=DELAI_MESURE)
   {
      cpt_adc=0;
      AD0BUSY=1;
   }
   cpt_adc++;
   if(cpt_i2c>=20)
   {
      cpt_i2c=0;
      gFlagActuI2c=1;
   }
   cpt_i2c++;
   TR0=1;
}

/*---------------------------------------------------------------------------*-
ADCComplete()
-----------------------------------------------------------------------------
Descriptif: fonction d'interruption de fin de conversion de l'ADC vecteur 10
Pin + : P1.1
Pin - : GND
Aligner a Droite
Conversion sur : AD0BUSY=1;
Clock SAR : 2000000
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void ADCComplete() interrupt 10
{
   unsigned char i=0;
   static unsigned char cptMesure=0;
   gMesure[AMX0P][cptMesure]=ADC0L+(ADC0H<<8);
   if(AMX0P<=0x0A)
   {
      AMX0P++;//change le canal de l'ADC a P2.3
      for(i=0;i<25;i++)//Attend que les condensateur se decharge
      {
         
      }
      AD0BUSY=1;//lance une conversion
   }
   else
   {
      AMX0P=0x00;//remet le canal P2.0
      //MovingAvg(gMesure,gAvgMesure);
      cptMesure++;
      gFlagPot=1;
      if(cptMesure==NMESURE)
      {
         gFlagMesureAvg=1;//Mets le flag a 1 pour signifier au main d'actualiser
         cptMesure=0;
      }
   }
	AD0INT=0;
}

/*---------------------------------------------------------------------------*-
uart0()
-----------------------------------------------------------------------------
Descriptif: Fonction d'interruption de l'uart0 vecteur 4
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void uart0() interrupt 4
{
   if(TI0)
   {
      TI0=0;
      if(gUart0Tx[gUart0NbrByteTx]!=0)
      {
         SBUF0=gUart0Tx[gUart0NbrByteTx];
         gUart0NbrByteTx++;
      }
      else
      {
         gUart0NbrByteTx=0;
      }
   }
   
   if(RI0)
   {
      RI0=0;
      gUart0Rx[gUart0NbrByteRx]=SBUF0;
      if(gUart0Rx[gUart0NbrByteRx]=='#')
       {
          gUart0FlagReceive=1;
          gUart0NbrByteRx=0;
       }
       else
       {
          gUart0NbrByteRx=(gUart0NbrByteRx+1)%20;
       }
   }
}

/*---------------------------------------------------------------------------*-
   ActuAvgMesure ()
  -----------------------------------------------------------------------------
   Descriptif: Calcul la moyenne de mesure effectuer par l'ADC
   Entrée    : 
               - unsigned int tabMesure[12][NMESURE] - tableau de mesure
               - unsigend int tabSortie[] - tableau de sortie pour les moyenne
   Sortie    : --
-*---------------------------------------------------------------------------*/
void ActuAvgMesure(unsigned int tabMesure[12][NMESURE], unsigned int tabSortie[])
{
   unsigned char canal=0;
   unsigned char nMesure=0;
   unsigned long somme;
   for(canal=0;canal<12;canal++)
   {
      somme=0;
      for(nMesure=0;nMesure<NMESURE;nMesure++)
      {
         somme+=tabMesure[canal][nMesure];
      }
      tabSortie[canal]=somme/NMESURE;
   }
}

/*---------------------------------------------------------------------------*-
   ConvertToPca ()
  -----------------------------------------------------------------------------
   Descriptif: Convertie une valeur entre 0 et 1023, de 0 a 255
   Entrée    : unsigend int adc (0 ... 1023)
   Sortie    : unsigend char (0 ... 255)
-*---------------------------------------------------------------------------*/
unsigned char ConvertToPca(unsigned int adc)
{
   return 255-((unsigned long)adc*255)/1023;
}

/*---------------------------------------------------------------------------*-
   calculRose ()
  -----------------------------------------------------------------------------
   Descriptif: 
   Entrée    : 
               - float t_ambiante
               - float humidite
   Sortie    : int (-32767 ... +32767) la temperature du point de rosé
               Ex : -2767 --> -27.67[C]
-*---------------------------------------------------------------------------*/
int calculRose(float t_ambiante, float humidite)
{
   float tRose=0;
   tRose=pow(((float)humidite/100),0.125);
   tRose=tRose*(112+(9*t_ambiante)/1000);
   tRose+=((t_ambiante)/1000)-112;
   return tRose*10;
}

/*---------------------------------------------------------------------------*-
   convertLm35ToTemp ()
  -----------------------------------------------------------------------------
   Descriptif: 
   Entrée    : --
   Sortie    : --
-*---------------------------------------------------------------------------*/
int convertLm35ToTemp(unsigned int adc_pos,unsigned int adc_neg)
{
   int temp=0;
   temp=adc_pos-adc_neg;
   temp=((long)temp*REF_ADC)/100;
   return temp;
}

/*---------------------------------------------------------------------------*-
   actu_Pca0_Pid ()
  -----------------------------------------------------------------------------
   Descriptif: calul le pwm a appliquer sur la resistance en fonction du PID
   Entrée    : 
               - int tempCapt
               - int consigne
   Sortie    : --
-*---------------------------------------------------------------------------*/
void actu_Pca0_Pid(int tempCapt,int consigne)
{
   static int pwm1=0;
   static unsigned char old_error=0;
   int error=0;
   if(tempCapt<consigne)
   {
      error=consigne-tempCapt;
      pwm1=255-((int)error*KP)+((old_error-error)*KD);
      //pwm1=0;//mode tout ou rien
   }
   else
   {
      pwm1=255;//0%
      error=0;
   }
   old_error=error;
   if(pwm1<=0)
   {
      PCA0CPM0|=0x40;//reactive le pca0 si il a ete desactiver
      PCA0CPH0=0;
   }
   else if(pwm1>=255)
   {
      PCA0CPH0=255;
      PCA0CPM0&=~0x40;//Clear ecom0 afin d'obtenir 0%
   }
   else
   {
      PCA0CPH0=pwm1;
   }
}

/*---------------------------------------------------------------------------*-
   actu_Pca1_Pid ()
  -----------------------------------------------------------------------------
   Descriptif: calul le pwm a appliquer sur la resistance en fonction du PID
   Entrée    : 
               - int tempCapt
               - int consigne
   Sortie    : --
-*---------------------------------------------------------------------------*/
void actu_Pca1_Pid(int tempCapt,int consigne)
{
   static int pwm1=0;
   static unsigned char old_error=0;
   int error=0;
   if(tempCapt<consigne)
   {
      error=consigne-tempCapt;
      pwm1=255-((int)error*KP)+((old_error-error)*KD);
      //pwm1=0;//mode tout ou rien
   }
   else
   {
      pwm1=255;//0%
      error=0;
   }
   old_error=error;
   if(pwm1<=0)
   {
      PCA0CPM1|=0x40;//reactive la pca0 si il a ete desactiver
      PCA0CPH1=0;
   }
   else if(pwm1>=255)
   {
      PCA0CPH1=255;
      PCA0CPM1&=~0x40;//Clear ecom0 afin d'obtenir 0%
   }
   else
   {
      PCA0CPH1=pwm1;
   }
}

/*---------------------------------------------------------------------------*-
   actu_Pca2_Pid ()
  -----------------------------------------------------------------------------
   Descriptif: calul le pwm a appliquer sur la resistance en fonction du PID
   Entrée    : 
               - int tempCapt
               - int consigne
   Sortie    : --
-*---------------------------------------------------------------------------*/
void actu_Pca2_Pid(int tempCapt,int consigne)
{
   static int pwm1=0;
   static unsigned char old_error=0;
   int error=0;
   if(tempCapt<consigne)
   {
      error=consigne-tempCapt;
      pwm1=255-((int)error*KP)+((old_error-error)*KD);
      //pwm1=0;//mode tout ou rien
   }
   else
   {
      pwm1=255;//0%
      error=0;
   }
   old_error=error;
   if(pwm1<=0)
   {
      PCA0CPM2|=0x40;//reactive la pca0 si il a ete desactiver
      PCA0CPH2=0;
   }
   else if(pwm1>=255)
   {
      PCA0CPH2=255;
      PCA0CPM2&=~0x40;//Clear ecom0 afin d'obtenir 0%
   }
   else
   {
      PCA0CPH2=pwm1;
   }
}

/*---------------------------------------------------------------------------*-
   actu_Pca3_Pid ()
  -----------------------------------------------------------------------------
   Descriptif: calul le pwm a appliquer sur la resistance en fonction du PID
   Entrée    : 
               - int tempCapt
               - int consigne
   Sortie    : --
-*---------------------------------------------------------------------------*/
void actu_Pca3_Pid(int tempCapt,int consigne)
{
   static int pwm1=0;
   static unsigned char old_error=0;
   int error=0;
   if(tempCapt<consigne)
   {
      error=consigne-tempCapt;
      pwm1=255-((int)error*KP)+((old_error-error)*KD);
      //pwm1=0;//mode tout ou rien
   }
   else
   {
      pwm1=255;//0%
      error=0;
   }
   old_error=error;
   if(pwm1<=0)
   {
      PCA0CPM3|=0x40;//reactive la pca0 si il a ete desactiver
      PCA0CPH3=0;
   }
   else if(pwm1>=255)
   {
      PCA0CPH3=255;
      PCA0CPM3&=~0x40;//Clear ecom0 afin d'obtenir 0%
   }
   else
   {
      PCA0CPH3=pwm1;
   }
}

/*---------------------------------------------------------------------------*-
reset_i2c()
-----------------------------------------------------------------------------
Descriptif: Verifie si le bus I2C est bloquer, et effectue un reset du bus
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void reset_i2c()
{
   unsigned char i=0;
	if(!SDA)
	{
		P0SKIP    = 0xCF;
		XBR0      = 0x01;
		// If slave is holding SDA low because of an improper SMBus reset or error
		while(!SDA)
		{
			// Provide clock pulses to allow the slave to advance out
			// of its current state. This will allow it to release SDA.
			SCL = 0;                         // Drive the clock low
			for(i = 0; i < 100; i++);        // Hold the clock low
			SCL = 1;                         // Release the clock
			for(i = 0; i < 100; i++);        // Hold the clock low
		}
		P0SKIP    = 0x0F;
		XBR0      = 0x05;
	}
}

/*---------------------------------------------------------------------------*-
   getTempAmbiante ()
  -----------------------------------------------------------------------------
   Descriptif: demande la temperature au capteur EEH210
   Entrée    : --
   Sortie    : long
-*---------------------------------------------------------------------------*/
long getTempAmbiante()
{
   while(SMB_BUSY);
			gTarget = 0x80;//0x81    (0x40 7 bit + 1 bit = 0x81 1 == read 
         gSMBDataOUT[0]  = 0xF3;//E3 = Hold master / F3 = no hold master
         gSMBNumBytesToWR = 1;
         SMB_Write();  // Initiate SMBus write
		//TEST=~TEST;
			while(SMB_BUSY);
		Delay_1ms(20);//attend la fin de mesure 
      gTarget = 0x81;
      gSMBNumBytesToRD = 4;
      SMB_Read();  // Initiate SMBus read
		//Delay_1ms(20);//attend la fin de mesure 
		
   return convertToTemp_i2c(((unsigned int )gSMBDataIN[1]<<8)+gSMBDataIN[2]);
}

/*---------------------------------------------------------------------------*-
   GetHumidite ()
  -----------------------------------------------------------------------------
   Descriptif: demande l'humidite ambiante au capteur EEH210
   Entrée    : --
   Sortie    : --
-*---------------------------------------------------------------------------*/
unsigned int GetHumidite()
{
   gTarget = 0x80;//0x81    (0x40 7 bit + 1 bit = 0x81 1 == read 
         gSMBDataOUT[0]  = 0xF5;
         gSMBNumBytesToWR = 1;
         SMB_Write();  // Initiate SMBus write
			while(SMB_BUSY);
		Delay_1ms(20);//attend la fin de mesure 
      gTarget = 0x81;
      gSMBNumBytesToRD = 4;
      SMB_Read();  // Initiate SMBus read
   return convertToHumi(((unsigned int )gSMBDataIN[1]<<8)+gSMBDataIN[2]);
}


/*---------------------------------------------------------------------------*-
configEeh210()
-----------------------------------------------------------------------------
Descriptif: Configure le capteur EEH210 
			fonction incomplete, il faut lire les parametre avant d'�crire
			dessus
Entree    : unsigned char tab[] - la chaine de caractere a decoder
Sortie    : --
-*---------------------------------------------------------------------------*/
void configEeh210(unsigned char mode)
{
	while(SMB_BUSY);
	gTarget = 0x80;//0x81    (0x40 7 bit + 1 bit = 0x81 1 == read 
  gSMBDataOUT[0]  = 0xE6;
	switch(mode)
	{
		case 0 :
			gSMBDataOUT[1]  = 0x3A;
		break;
		case 1 :
			gSMBDataOUT[1]  = 0x3B;
		break;
		case 2 :
			gSMBDataOUT[1]  = 0xBA;
		break;
		case 3 :
			gSMBDataOUT[1]  = 0xBB;
		break;
	}
	
  gSMBNumBytesToWR = 2;
  SMB_Write();  // Initiate SMBus write
}

/*---------------------------------------------------------------------------*-
convertToTemp()
-----------------------------------------------------------------------------
Descriptif: Convertie une valeur sur 16 bit en temperature
Entree    : unsigned int value - la donne a convertir
Sortie    : long - la temperature convertie avec un facteur 100
-*---------------------------------------------------------------------------*/
long convertToTemp_i2c(unsigned int value)
{
	value = value &~ 0x03;
	return (((long)value*17572)>>16)-4685;
}

/*---------------------------------------------------------------------------*-
convertToHumi()
-----------------------------------------------------------------------------
Descriptif: Convertie une valeur sur 16 bit en humidit�
Entree    : unsigned int value - la donne a convertir
Sortie    : unsigned int - la temperature convertie
-*---------------------------------------------------------------------------*/
unsigned int convertToHumi(unsigned int value)
{
	value = value &~ 0x03;
	return (((unsigned long)value*125)>>16)-6;;
}

/*---------------------------------------------------------------------------*-
ADCInit()
-----------------------------------------------------------------------------
Descriptif:
Pin + : P1.1
Pin - : GND
Aligner a Droite
Conversion sur : AD0BUSY=1;
Clock SAR : 2000000
ref sur 
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void ADCInit()
{

   AMX0P=0x00;//Entree positive sur P2.0
   AMX0N=0x1f;//Entree negative sur GND
            // +++++----- ADC0 SAR Conversion Clock Period Bits.
            // |||||+---- AD0LJST ajustement a droite
            // ||||||++-- Reserver
            // ||||||||  
   ADC0CF=0xb8;// 10111000 - clk SAR de 2000000Hz aligner a droite
               // +--------  ADC0 Enable Bit
               // |+-------  ADC0 Track Mode Bit.
               // ||+------- AD0INT ADC0 Conversion Complete Interrupt Flag
               // |||+------ AD0BUSY
               // ||||+----- ADC0 Window Compare Interrupt Flag
               // |||||+++-- ADC0 Start of Conversion Mode Select
               // ||||||||  
   ADC0CN=0x80;// 10000000
               // +--------- Reference Buffer Gain Select.
               // |++------- Unused
               // |||+------ Regulator Reference Override
               // ||||+----- Voltage Reference Select.
               // |||||+---- Temperature Sensor Enable Bit
               // ||||||+--- Internal Analog Bias Generator Enable Bit.
               // |||||||+-- On-chip Reference Buffer Enable Bit.
               // ||||||||  
   REF0CN=0x08;// 00010000

   EIE1|=0x08;
}


void decodeUart0()
{
   unsigned int testPwm=0;
   int temp=0;
   //PCA0
   if((gUart0Rx[0]=='R')&&(gUart0Rx[1]=='0')&&(gUart0Rx[2]=='_'))
   {                                                             
      testPwm=(gUart0Rx[3]-'0')*100;
      testPwm+=(gUart0Rx[4]-'0')*10;
      testPwm+=gUart0Rx[5]-'0';
      if(testPwm>255)
      {
         //Erreur
         testPwm=255;
      }
      testPwm=255-testPwm;
      if(testPwm==255)//0%
      {
         PCA0CPH0=0xFF;
         PCA0CPM0&=~0x40;//RAZ de ECOMn pour forcer le pwm a 0%
      }
      else
      {
         PCA0CPH0=testPwm;
         PCA0CPM0|=0x40;//ECOMn a 1 pour autoriser le fonctionnement
      }
   }
   
   //PCA1
   if((gUart0Rx[0]=='R')&&(gUart0Rx[1]=='1')&&(gUart0Rx[2]=='_'))
   {                                                             
      testPwm=(gUart0Rx[3]-'0')*100;
      testPwm+=(gUart0Rx[4]-'0')*10;
      testPwm+=gUart0Rx[5]-'0';
      if(testPwm>255)
      {
         //Erreur
         testPwm=255;
      }
      testPwm=255-testPwm;
      if(testPwm==255)//0%
      {
         PCA0CPH1=0xFF;
         PCA0CPM1&=~0x40;//RAZ de ECOMn pour forcer le pwm a 0%
      }
      else
      {
         PCA0CPH1=testPwm;
         PCA0CPM1|=0x40;//ECOMn a 1 pour autoriser le fonctionnement
      }
   }
   
   //PCA2
   if((gUart0Rx[0]=='R')&&(gUart0Rx[1]=='2')&&(gUart0Rx[2]=='_'))
   {                                                             //maximum 255
      testPwm=(gUart0Rx[3]-'0')*100;
      testPwm+=(gUart0Rx[4]-'0')*10;
      testPwm+=gUart0Rx[5]-'0';
      if(testPwm>255)
      {
         //Erreur
         testPwm=255;
      }
      testPwm=255-testPwm;
      if(testPwm==255)//0%
      {
         PCA0CPH2=0xFF;
         PCA0CPM2&=~0x40;//RAZ de ECOMn pour forcer le pwm a 0%
      }
      else
      {
         PCA0CPH2=testPwm;
         PCA0CPM2|=0x40;//ECOMn a 1 pour autoriser le fonctionnement
      }
   }
   
   //PCA3
   if((gUart0Rx[0]=='R')&&(gUart0Rx[1]=='3')&&(gUart0Rx[2]=='_'))
   {                                                             //maximum 255
      testPwm=(gUart0Rx[3]-'0')*100;
      testPwm+=(gUart0Rx[4]-'0')*10;
      testPwm+=gUart0Rx[5]-'0';
      if(testPwm>255)
      {
         //Erreur
         testPwm=255;
      }
      testPwm=255-testPwm;
      if(testPwm==255)//0%
      {
         PCA0CPH3=0xFF;
         PCA0CPM3&=~0x40;//RAZ de ECOMn pour forcer le pwm a 0%
      }
      else
      {
         PCA0CPH3=testPwm;
         PCA0CPM3|=0x40;//ECOMn a 1 pour autoriser le fonctionnement
      }
   }
   
   if((gUart0Rx[0]=='G')&&(gUart0Rx[1]=='E')&&(gUart0Rx[2]=='T')&&(gUart0Rx[3]=='_')&&(gUart0Rx[4]=='T'))
   {
      if(gUart0Rx[5]=='0')//Capteur_i2c
      {
         temp=getTempAmbiante();
         temp=temp/10;
      }
      else if(gUart0Rx[5]=='1')//LM35_0
      {
         temp=convertLm35ToTemp(gMesureAvg[LM35_0_POS],gMesureAvg[LM35_0_NEG]);
      }
      else if(gUart0Rx[5]=='2')//LM35_1
      {
         temp=convertLm35ToTemp(gMesureAvg[LM35_1_POS],gMesureAvg[LM35_1_NEG]);
      }
      else if(gUart0Rx[5]=='3')//LM35_2
      {
         temp=convertLm35ToTemp(gMesureAvg[LM35_2_POS],gMesureAvg[LM35_2_NEG]);
      }
      else if(gUart0Rx[5]=='4')//LM35_3
      {
         temp=convertLm35ToTemp(gMesureAvg[LM35_3_POS],gMesureAvg[LM35_3_NEG]);
      }
      else if(gUart0Rx[5]=='R')//LM35_3
      {
         temp=calculRose(getTempAmbiante(), GetHumidite());
      }
      else
      {
         temp=999;//Erreur
      }
      
      //envoie sur l'uart0
      if(temp>=0)
      {
         gUart0Tx[0]='+';
      }
      else
      {
         gUart0Tx[0]='-';
         temp=temp*(-1);
      }
      //ex pour 28.3�C --> 283
      //gUart0Tx[1]=(temp/1000)+'0';//2
      gUart0Tx[1]=(temp/100)+'0';//2
      gUart0Tx[2]=((temp%100)/10)+'0';//8
      gUart0Tx[3]='.';                       //.
      gUart0Tx[4]=((temp%10))+'0';//3
      gUart0Tx[5]='\n';
      gUart0Tx[6]=0;
      gUart0NbrByteTx=0;
      TI0=1;
   }
   
   if((gUart0Rx[0]=='G')&&(gUart0Rx[1]=='E')&&(gUart0Rx[2]=='T')&&(gUart0Rx[3]=='_')&&(gUart0Rx[4]=='H'))
   {
      temp=GetHumidite();
      gUart0Tx[0]=(temp/100)+'0';
      gUart0Tx[1]=(temp/10)+'0';
      gUart0Tx[2]=((temp%10))+'0';
      gUart0Tx[3]='\n';
      gUart0Tx[4]=0;
      gUart0NbrByteTx=0;
      TI0=1;
   }
}

/*---------------------------------------------------------------------------*-
TimerInit ()
-----------------------------------------------------------------------------
Descriptif:
Timer 0 : Mode 16bit - Prediv 48 - tempo 50milli
Timer 1 : Mode 8bit - Prediv 48 - vitesse : 57600bit/s
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void TimerInit()
{
TR0 = 0;//Stop le timer 0
TR1 = 0;//Stop le timer 1
ET0 = 0;//Desactive l'interruption du timer 0
ET1 = 0;//Desactive l'interruption du timer 1
TMOD &= ~0xFF;//Clear le registre des mode
             // +-------- Timer 1 Gate Control
             // |+------- Counter/Timer1 Select
             // ||++----- choix du mode du timer 1
             // ||||+---- Timer 0 Gate Control
             // |||||+--- Counter/Timer0 Select
             // ||||||++- choix du mode du timer 0
             // ||||||||  (00 : Mode 0, 13-bit Counter/Timer)
             // ||||||||  (01 : Mode 1, 16-bit Counter/Timer)
             // ||||||||  (10 : Mode 2, 8-bit Counter/Timer with Auto-Reload)
             // ||||||||  (11 : Mode 3, Two 8-bit Counter/Timers)  
TMOD |= 0x21;// 00100001
CKCON &= ~0x07;//clear les bit de selection pour les timer 0 et 1 et le prescalaire
              // +-------- Timer 3 High Byte Clock Select.
              // |+------- Timer 3 Low Byte Clock Select.
              // ||+------ Timer 2 High Byte Clock Select
              // |||+----- Timer 2 Low Byte Clock Select.
              // ||||+---- Timer 1 Clock Select.
              // |||||+--- Timer 0 Clock Select.
              // ||||||++- Timer 0/1 Prescale Bits.
              // ||||||||  (00: System clock divided by 12)
              // ||||||||  (01: System clock divided by 4)
              // ||||||||  (10: System clock divided by 48)
              // ||||||||  (11: External clock divided by 8 (synchronized with the system clock))  
CKCON |= 0x02;// 00000010
TH0=LOADVALUE_T0/256;//Charge la valeur dans le registre MSB du timer 0
TL0=LOADVALUE_T0%256;//Charge la valeur dans le registre LSB du timer 0
TL1=TH1=LOADVALUE_BAUD;//Charge la valeur du timer 1
TF0 = 0;//clear le flag d'interruption du timer 0
TF1 = 0;//clear le flag d'interruption du timer 1
ET0 = 1;//Autorise l'interruption du timer 0
ET1 = 0;//Autorise l'interruption du timer 1
}



void PCA_Init()
{
    PCA0CN    = 0x40;//Active le PCA
    PCA0MD    |= 0x02;//PCA SYSCLK Prediv
    PCA0CPM0  = 0x42;//active le mode PWM et le comparateur du PCA0
    PCA0CPM1  = 0x42;//active le mode PWM et le comparateur du PCA1
   PCA0CPM2  = 0x42;//active le mode PWM et le comparateur du PCA0
    PCA0CPM3  = 0x42;//active le mode PWM et le comparateur du PCA1
	PCA0CPH0  = 0xFF;//valeur a charger pour obtenir %
	PCA0CPH1  = 0xFF;//valeur a charger pour obtenir %
   PCA0CPH2  = 0xFF;//valeur a charger pour obtenir %
	PCA0CPH3  = 0xFF;//valeur a charger pour obtenir %
}

/*---------------------------------------------------------------------------*-
   ClockInit ()
  -----------------------------------------------------------------------------
   Descriptif: Initialisation du mode de fonctionnement du clock syst�me 
         choix : SYSCLK : oscillateur HF interne � 48 MHz

   Entr�e    : --
   Sortie    : --
-*---------------------------------------------------------------------------*/
void ClockInit()
{  
   
                     // +--------- clock interne LF
                     // | (1 : oscillateur LF : enable)
                     // | (0 : oscillateur LF: desable)
                     // |+-------- en lecture seule 1 : signal que oscillateur 
                     // ||         interne fonctionne � sa valeur de prog.
                     // ||++++---- r�glage fin de la fr�quence de l'osc. LF
                     // ||||||++-- choix du diviseur :
                     // ||||||||       (00 : Osc LF /8 -> f = 10 KHz)
                     // ||||||||       (01 : Osc LF /4 -> f = 20 KHz)
                     // ||||||||       (10 : Osc LF /2 -> f = 40 KHz)
                     // ||||||||       (11 : Osc LF /1 -> f = 80 KHz)
   OSCLCN |= 0x00;   // 00000000 

                     // +--------- non utilis�
                     // |+++------ S�lection du clock USB 
                     // ||||           (010 : Oscil ext. : limiter la conso.)
                     // ||||+----- clock out select
                     // |||||          (0 : sortie sysclk non synchronis�e)
                     // |||||          (1 : sortie sysclk synchronis�e)
                     // |||||+++-- choix du clock syst�me
                     // ||||||||       (000 : Oscil interne 48/4  = 1.5, 3, 6 ou
                     // ||||||||              12 MHz selon le choix du diviseur 
                     // ||||||||              dans OSCICN
                     // ||||||||       (001 : Oscil externe  = x  MHz)
                     // ||||||||       (010 : Oscil interne 48/2 = 24 MHz)
                     // ||||||||       (011 : Oscil interne 48/1 = 48 MHz)    
                     // ||||||||       (100 : Oscil interne LF = 80 KHz max)   
                     // ||||||||       (101 � 111 : r�serv�s)   
   CLKSEL = 0x03;    // 00000011  

                     // +--------- clock interne HF
                     // |              (1 : oscillateur LF : enable)
                     // |              (0 : oscillateur LF: desable)
                     // |+-------- en lecture seule 1 : signal que oscillateur 
                     // ||              interne fonctionne � sa valeur de prog.
                     // ||+------- 1 : suspend l'oscillateur interne
                     // |||+++---- non utilis�s
                     // ||||||++-- choix du diviseur :
                     // ||||||||       (00 : 12/8 -> f =  1.5 MHz)
                     // ||||||||       (01 : 12/4 -> f =  3   MHz)
                     // ||||||||       (10 : 12/2 -> f =  6   MHz)
                     // ||||||||       (11 : 12/1 -> f = 12   MHz)
   OSCICN = 0xC3;    // 11000011 
   
   FLSCL = 0x90;     // A utiliser si le clock system est � 48 MHz

} // ClockInit ----------------------------------------------------------------


//-----------------------------------------------------------------------------
// SMBus_Init
//-----------------------------------------------------------------------------
//
// Return Value : None
// Parameters   : None
//
// SMBus configured as follows:
// - SMBus enabled
// - Slave mode inhibited
// - Timer2 used as clock source. The maximum SCL frequency will be
//   approximately 1/3 the Timer1 overflow rate
// - Setup and hold time extensions enabled
// - Bus Free and SCL Low timeout detection enabled
//
void SMBus_Init (void)
{
   SMB0CF = 0x5E;                      // Use Timer2 overflows as SMBus clock
                                       // source;
                                       // Disable slave mode;
                                       // Enable setup & hold time
                                       // extensions;
                                       // Enable SMBus Free timeout detect;
                                       // Enable SCL low timeout detect;

   SMB0CF |= 0x80;                     // Enable SMBus;
}


//-----------------------------------------------------------------------------
// Timer2_Init
//-----------------------------------------------------------------------------
//
// Return Value : None
// Parameters   : None
//
// Timer2 configured as the SMBus clock source as follows:
// - Timer2 in 8-bit auto-reload mode
// - SYSCLK or SYSCLK / 4 as Timer1 clock source
// - Timer2 overflow rate => 3 * SMB_FREQUENCY
// - The resulting SCL clock rate will be ~1/3 the Timer2 overflow rate
// - Timer2 enabled
//
void Timer2_Init (void)
{
   TMR2CN    |= 0x0C;
   TMR2RLH   |= 0xD4;
}

//-----------------------------------------------------------------------------
// Timer3_Init
//-----------------------------------------------------------------------------
//
// Return Value : None
// Parameters   : None
//
// Timer3 configured for use by the SMBus low timeout detect feature as
// follows:
// - Timer3 in 16-bit auto-reload mode
// - SYSCLK/12 as Timer3 clock source
// - Timer3 reload registers loaded for a 25ms overflow period
// - Timer3 pre-loaded to overflow after 25ms
// - Timer3 enabled
//
void Timer3_Init (void)
{
   TMR3CN = 0x00;                      // Timer3 configured for 16-bit auto-
                                       // reload, low-byte interrupt disabled

   CKCON &= ~0x40;                     // Timer3 uses SYSCLK/12

   TMR3RL = -(SYSCLK/12/40);           // Timer3 configured to overflow after
   TMR3 = TMR3RL;                      // ~25ms (for SMBus low timeout detect):
                                       // 1/.025 = 40

   EIE1 |= 0x80;                       // Timer3 interrupt enable
   TMR3CN |= 0x04;                     // Start Timer3
}

//-----------------------------------------------------------------------------
// SMBus Interrupt Service Routine (ISR)
//-----------------------------------------------------------------------------
//
// SMBus ISR state machine
// - Master only implementation - no slave or arbitration states defined
// - All incoming data is written to global variable array <gSMBDataIN>
// - All outgoing data is read from global variable array <gSMBDataOUT>
//
void SMBus_ISR (void) interrupt 7
{
   bit FAIL = 0;                       // Used by the ISR to flag failed
                                       // transfers

   static unsigned char sent_byte_counter;
   static unsigned char rec_byte_counter;

   if (ARBLOST0 == 0)                   // Check for errors
   {
      // Normal operation
      switch (SMB0CN & 0xF0)           // Status vector
      {
         // Master Transmitter/Receiver: START condition transmitted.
         case SMB_MTSTA:
            SMB0DAT = gTarget;          // Load address of the gTarget slave
            SMB0DAT &= 0xFE;           // Clear the LSB of the address for the
                                       // R/W bit
            SMB0DAT |= SMB_RW;         // Load R/W bit
            STA0 = 0;                   // Manually clear START bit
            rec_byte_counter = 1;      // Reset the counter
            sent_byte_counter = 1;     // Reset the counter
            break;

         // Master Transmitter: Data byte transmitted
         case SMB_MTDB:
            if (ACK0)                   // Slave ACK0?
            {
               if (SMB_RW == WRITE)    // If this transfer is a WRITE,
               {
                  if (sent_byte_counter <= gSMBNumBytesToWR)
                  {
                     // send data byte
                     SMB0DAT = gSMBDataOUT[sent_byte_counter-1];
                     sent_byte_counter++;
                  }
                  else
                  {
                     STO0 = 1;          // Set STO0 to terminate transfer
                     SMB_BUSY = 0;     // And free SMBus interface
                  }
               }
               else {}                 // If this transfer is a READ,
                                       // proceed with transfer without
                                       // writing to SMB0DAT (switch
                                       // to receive mode)


            }
            else                       // If slave NACK,
            {
               STO0 = 1;                // Send STOP condition, followed
               STA0 = 1;                // By a START
               NUM_ERRORS++;           // Indicate error
            }
            break;

         // Master Receiver: byte received
         case SMB_MRDB:
            if (rec_byte_counter < gSMBNumBytesToRD)
            {
               gSMBDataIN[rec_byte_counter-1] = SMB0DAT; // Store received
                                                          // byte
               ACK0 = 1;                // Send ACK0 to indicate byte received
               rec_byte_counter++;     // Increment the byte counter
            }
            else
            {
               gSMBDataIN[rec_byte_counter-1] = SMB0DAT; // Store received
                                                          // byte
               SMB_BUSY = 0;           // Free SMBus interface
               ACK0 = 0;                // Send NACK to indicate last byte
                                       // of this transfer

               STO0 = 1;                // Send STOP to terminate transfer
            }
            break;

         default:
            FAIL = 1;                  // Indicate failed transfer
                                       // and handle at end of ISR
            break;

      } // end switch
   }
   else
   {
      // ARBLOST = 1, error occurred... abort transmission
      FAIL = 1;
   } // end ARBLOST if

   if (FAIL)                           // If the transfer failed,
   {
      SMB0CF &= ~0x80;                 // Reset communication
      SMB0CF |= 0x80;
      STA0 = 0;
      STO0 = 0;
      ACK0 = 0;

      SMB_BUSY = 0;                    // Free SMBus

      FAIL = 0;
      //LED = 0;

      NUM_ERRORS++;                    // Indicate an error occurred
   }

   SI0 = 0;                             // Clear interrupt flag
}

//-----------------------------------------------------------------------------
// Timer3 Interrupt Service Routine (ISR)
//-----------------------------------------------------------------------------
//
// A Timer3 interrupt indicates an SMBus SCL low timeout.
// The SMBus is disabled and re-enabled here
//
void Timer3_ISR (void) interrupt 14
{
   SMB0CF &= ~0x80;                    // Disable SMBus
   SMB0CF |= 0x80;                     // Re-enable SMBus
   TMR3CN &= ~0x80;                    // Clear Timer3 interrupt-pending
                                       // flag
   STA0 = 0;
   SMB_BUSY = 0;                       // Free SMBus
}


//-----------------------------------------------------------------------------
// Support Functions
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// SMB_Write
//-----------------------------------------------------------------------------
//
// Return Value : None
// Parameters   : None
//
// Writes a single byte to the slave with address specified by the <gTarget>
// variable.
// Calling sequence:
// 1) Write gTarget slave address to the <gTarget> variable
// 2) Write outgoing data to the <gSMBDataOUT> variable array
// 3) Call SMB_Write()
//
void SMB_Write (void)
{
   while (SMB_BUSY);                   // Wait for SMBus to be free.
   SMB_BUSY = 1;                       // Claim SMBus (set to busy)
   SMB_RW = 0;                         // Mark this transfer as a WRITE
   STA0 = 1;                            // Start transfer
}

//-----------------------------------------------------------------------------
// SMB_Read
//-----------------------------------------------------------------------------
//
// Return Value : None
// Parameters   : None
//
// Reads a single byte from the slave with address specified by the <gTarget>
// variable.
// Calling sequence:
// 1) Write gTarget slave address to the <gTarget> variable
// 2) Call SMB_Write()
// 3) Read input data from <gSMBDataIN> variable array
//
void SMB_Read (void)
{
   while (SMB_BUSY);                   // Wait for bus to be free.
   SMB_BUSY = 1;                       // Claim SMBus (set to busy)
   SMB_RW = 1;                         // Mark this transfer as a READ

   STA0 = 1;                            // Start transfer

   while (SMB_BUSY);                   // Wait for transfer to complete
}

/*---------------------------------------------------------------------------*-
   Uart0Init()
  -----------------------------------------------------------------------------
   Descriptif:  Active la reception de l'UART0 - Mode 8 bit
   Entree    : --
   Sortie    : --
-*---------------------------------------------------------------------------*/
void Uart0Init()
{  
   //Les bit font partie du registre SCON0

   //Serial Port 0 Operation Mode.
   //0: 8-bit UART with Variable Baud Rate.
   //1: 9-bit UART with Variable Baud Rate.
   S0MODE=0;

   //Multiprocessor Communication Enable.
   //The function of this bit is dependent on the Serial Port 0 Operation Mode:
   //Mode 0: Checks for valid stop bit.
   //0: Logic level of stop bit is ignored.
   //1: RI0 will only be activated if stop bit is logic level 1.
   //Mode 1: Multiprocessor Communications Enable.
   //0: Logic level of ninth bit is ignored.
   //1: RI0 is set and an interrupt is generated only when the ninth bit is logic 1.
   MCE0=0;

   //Receive Enable.
   //0: UART0 reception disabled.
   //1: UART0 reception enabled.
   REN0=1;

   //Ninth Transmission Bit.
   //The logic level of this bit will be sent as the ninth transmission bit in 9-bit UART Mode 
   //(Mode 1). Unused in 8-bit mode (Mode 0).
   TB80=0;

   //Ninth Receive Bit.
   //RB80 is assigned the value of the STOP bit in Mode 0; it is assigned the value of the
   //9th data bit in Mode 1.
   RB80=0;

   //Transmit Interrupt Flag.
   TI0=0;

   //Receive Interrupt Flag. 
   RI0=0;
} // Uart0Init ----------------------------------------------------------------


/*---------------------------------------------------------------------------*-
   PortInit ()
  -----------------------------------------------------------------------------
   Descriptif: autorise le fonctionnement du crossbar et de l'uart0
   Entrée    : --
   Sortie    : --
-*---------------------------------------------------------------------------*/
void PortInit () 
{
   // P0.0  -  Skipped,     Open-Drain, Digital
    // P0.1  -  Skipped,     Open-Drain, Digital
    // P0.2  -  Skipped,     Open-Drain, Digital
    // P0.3  -  Skipped,     Open-Drain, Digital
    // P0.4  -  TX0 (UART0), Push-Pull,  Digital
    // P0.5  -  RX0 (UART0), Open-Drain, Digital
    // P0.6  -  SDA (SMBus0), Open-Drain, Digital
    // P0.7  -  SCL (SMBus0), Push-Pull,  Digital

    // P1.0  -  Skipped,     Open-Drain, Analog
    // P1.1  -  Skipped,     Open-Drain, Analog
    // P1.2  -  Skipped,     Open-Drain, Analog
    // P1.3  -  Skipped,     Open-Drain, Analog
    // P1.4  -  Skipped,     Open-Drain, Analog
    // P1.5  -  Skipped,     Open-Drain, Analog
    // P1.6  -  Skipped,     Open-Drain, Analog
    // P1.7  -  Skipped,     Open-Drain, Analog

    // P2.0  -  Skipped,     Open-Drain, Analog
    // P2.1  -  Skipped,     Open-Drain, Analog
    // P2.2  -  Skipped,     Open-Drain, Analog
    // P2.3  -  Skipped,     Open-Drain, Analog
    // P2.4  -  CEX0  (PCA), Push-Pull,  Digital
    // P2.5  -  CEX1  (PCA), Push-Pull,  Digital
    // P2.6  -  CEX2  (PCA), Push-Pull,  Digital
    // P2.7  -  CEX3  (PCA), Push-Pull,  Digital

    // P3.0  -  Unassigned,  Open-Drain, Digital

    P1MDIN    = 0x00;
    P2MDIN    = 0xF0;
    P0MDOUT   = 0x90;
    P2MDOUT   = 0xF0;
    P0SKIP    = 0x0F;
    P1SKIP    = 0xFF;
    P2SKIP    = 0x0F;
    XBR0      = 0x05;
    XBR1      = 0x44;

} // PortInit ----------------------------------------------------------------