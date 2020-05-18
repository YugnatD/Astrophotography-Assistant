/*===========================================================================*=
	Master_Telescope - Tanguy Dietrich
  =============================================================================
   Descriptif: 
   Gestion de moteur d'une monture NEQ5.
   Le moteur R.A a une vitesse constante correspondant a la vitesse sideral.
   Le moteur DEC est activer lorsque la pin p2.2 ou P2.3(ST4) sont a 0
   Le tout est commander avec un port ST4
=*===========================================================================*/

#include <reg51f380.h>     // registres 51f38C
#include "Vitesse_Moteur.h"
#include "Delay48M.h"
#include "SmBus0.h"
#include "string.h"

#define CONFIG_PAGE 0x0F
#define LEGACY_PAGE 0x00
#define BAUD_UART0 247 //247=57600

//PCB
sbit STEP_RA = P1^3;
sbit DIR_RA = P1^2;
sbit NSLEEP_RA = P1^0;
sbit NFAULT_RA = P1^1;

sbit STEP_DEC = P1^7;
sbit DIR_DEC = P1^6;
sbit NSLEEP_DEC = P1^4;
sbit NFAULT_DEC = P1^5;

sbit ST4_RA_NEG = P2^0;
sbit ST4_RA_POS = P2^1;
sbit ST4_DEC_NEG = P2^2;
sbit ST4_DEC_POS = P2^3;

sbit SDA = P0^0;
sbit SCL = P0^1;


// ==== FONCTIONS PROTOTYPES===================================================
void ClockInit ();         // init. clock syst�me
void PortInit ();          // init. config des ports
void TimerInit();
void Init_int();
void SMBus_Init (void);
void Timer3_Init (void);
void Timer2_Init (void);
void SMB_Write (void);
void SMB_Read (void);
void UART_Init();
void decodeUartRaspberryPi();
void setMotorRA(unsigned char vitesse,bit direction);
void setMotorDEC(unsigned char vitesse,bit direction);
void stopMotorDec();
void configMCP23008(unsigned char input);
unsigned char read_i2c_port();
void reset_i2c();
// ==== MAIN ==================================================================

//SMBus0
unsigned char gSMBNumBytesToWR = 2; // Number of bytes to write
                                    // Master -> Slave
unsigned char gSMBNumBytesToRD = 3; // Number of bytes to read
                                    // Master <- Slave

// Global holder for SMBus data
// All receive data is written here
unsigned char gSMBDataIN[NUM_BYTES_MAX_RD];

// Global holder for SMBus data.
// All transmit data is read from here
unsigned char gSMBDataOUT[NUM_BYTES_MAX_WR];

unsigned char gTarget;                  // gTarget SMBus slave address

bit SMB_BUSY;                          // Software flag to indicate when the
                                       // SMB_Read() or SMB_Write() functions
                                       // have claimed the SMBus

bit SMB_RW;                            // Software flag to indicate the
                                       // direction of the current transfer

unsigned long NUM_ERRORS;              // Counter for the number of errors.




//Gestion Moteur
unsigned char gVitesseRAH=VITESSE_RA_SIDERAL_HIGH;
unsigned char gVitesseRAL=VITESSE_RA_SIDERAL_LOW;
unsigned int gVitesseDEC=VITESSE_DEC_MAX;
unsigned char gVitesseDeplacement=VITESSE_MAX;

//Uart
xdata unsigned char gUart0Tx[10]="";
xdata unsigned char gUart0Rx[10];
unsigned char gUart0NbrByteTx=0;
unsigned char gUart0NbrByteRx=0;
bit gUart0FlagReceive;

xdata unsigned char gUart1Tx[10]="";
xdata unsigned char gUart1Rx[10];
unsigned char gUart1NbrByteTx=0;
unsigned char gUart1NbrByteRx=0;
bit gUart1FlagReceive;
bit gDirRa=0;
bit gDirDec=0;
unsigned char gAstrSuivi=0;
bit gFlagMovingRA=0;

void main () 
{
   unsigned char portExtender;
	unsigned char memoAstreSuivi=0;
	bit waitEndMove=0;
   PCA0MD &= ~0x40;     // WDTE = 0 (disable watchdog timer)
   ClockInit ();        // init. clock syst�me
   PortInit ();         // init. config des ports
	SDA=1;
   reset_i2c();
   Init_int();
   Timer3_Init();                      // Configure Timer3 for use with SMBus
                                       // low timeout detect
   Timer2_Init();

   SMBus_Init ();                      // Configure and enable SMBus
   UART_Init();
   TimerInit();
   EA=1;//Autorise toutes les interruption
   EIE1      |= 0x81;
    EIE2      |= 0x12;
    IE        |= 0x97;
   TR0 = 1;//lance le timer 0
   TR1=1;
   NSLEEP_RA=1;//Active le chip drv8825
   NSLEEP_DEC=0;
   DIR_RA=0;
   DIR_DEC=0;
   
   SDA=1;
   Delay_1ms (20);
   configMCP23008(0xFF);
	portExtender=read_i2c_port();
   gAstrSuivi=(portExtender>>4);
	//memoAstreSuivi=gAstrSuivi;
   while (1)
   {
		memoAstreSuivi=gAstrSuivi;
      gVitesseDeplacement=(P2>>4)+VITESSE_X05;
      portExtender=read_i2c_port();
      gAstrSuivi=(portExtender>>4);
      gDirRa=(portExtender&0x04)>>2;
      gDirDec=(portExtender&0x08)>>3;
		
		if((memoAstreSuivi!=gAstrSuivi)||(waitEndMove==1))
		{
			waitEndMove=1;
			if(gFlagMovingRA==0)
			{
				setMotorRA(gAstrSuivi,gDirRa);
				waitEndMove=0;
			}
		}
		
      if((NFAULT_RA==0)&&(NSLEEP_RA==1))//probleme sur le DRV8825 de l'axe R.A
      {
         NSLEEP_RA=0;
         Delay_1ms (10);
         NSLEEP_RA=1;
         Delay_1ms (10);//1.7ms necessaire au rallumage
      }
      
      if((NFAULT_DEC==0)&&(NSLEEP_DEC==1))//probleme sur le DRV8825 de l'axe DEC
      {
         NSLEEP_DEC=0;//Eteint
         Delay_1ms (10);
         NSLEEP_DEC=1;//Allume
         Delay_1ms (10);
      }
      
      if(gUart0FlagReceive)
      {
         gUart0FlagReceive=0;
			while(gUart0NbrByteTx!=0);
         decodeUartRaspberryPi();
      }
		
      if(gUart1FlagReceive)
      {
			while(gUart0NbrByteTx!=0);
			gUart1FlagReceive=0;
			strcpy(gUart0Tx,gUart1Rx);
			TI0=1;
      }
      
   } // End while (1)
} // main =====================================================================

//INTERRUPTION
/*---------------------------------------------------------------------------*-
interruption0()
-----------------------------------------------------------------------------
Descriptif: Fonction d'interruption INT0 vecteur 0
            Pin :P0.6 - Descendant
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void interruption_ST4_RA() interrupt 0
{
   IT01CF=IT01CF^0x08;
   if((!ST4_RA_POS)&&(!ST4_RA_NEG))
   {
      setMotorRA(gAstrSuivi,gDirRa);
		gFlagMovingRA=0;
   }
   else if((ST4_RA_POS)&&(ST4_RA_NEG))
   {
      setMotorRA(gAstrSuivi,gDirRa);
		gFlagMovingRA=0;
   }
   else if((ST4_RA_POS)&&(!ST4_RA_NEG))
   {
      setMotorRA(gVitesseDeplacement,!gDirRa);
		gFlagMovingRA=1;
   }
   else if((!ST4_RA_POS)&&(ST4_RA_NEG))
   {
      setMotorRA(gVitesseDeplacement,gDirRa);
		gFlagMovingRA=1;
   }
}
/*---------------------------------------------------------------------------*-
interruption1()
-----------------------------------------------------------------------------
Descriptif: Fonction d'interruption 1 vecteur 2
            Pin :P0.7 - Descendant
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void interruption_ST4_DEC() interrupt 2
{
   IT01CF=IT01CF^0x80;
   if((!ST4_DEC_POS)&&(!ST4_DEC_NEG))//00
   {
      stopMotorDec();
   }
   else if((ST4_DEC_POS)&&(ST4_DEC_NEG))//11
   {
      stopMotorDec();
   }
   else if((ST4_DEC_POS)&&(!ST4_DEC_NEG))//10
   {
      setMotorDEC(gVitesseDeplacement,gDirDec);
   }
   else if((!ST4_DEC_POS)&&(ST4_DEC_NEG))//01
   {
      setMotorDEC(gVitesseDeplacement,!gDirDec);
   }
}

/*---------------------------------------------------------------------------*-
timer0()
-----------------------------------------------------------------------------
Descriptif: Fonction d'interruption Timer0 vecteur 1
          Temporisation de 51,94milli
          Mode : 16bit
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void timer0() interrupt 1
{
   TR0=0;
   TH0=gVitesseRAH ;//Charge la valeur dans le registre MSB du timer 0
   TL0=gVitesseRAL;//Charge la valeur dans le registre LSB du timer 0
   TR0=1;
   STEP_RA=!STEP_RA;
}

///*---------------------------------------------------------------------------*-
//timer1()
//-----------------------------------------------------------------------------
//Descriptif: Fonction d'interruption Timer1 vecteur 3
//          Mode : 8 bit 9600baud
//Entree    : --
//Sortie    : --
//-*---------------------------------------------------------------------------*/
//void timer1() interrupt 3
//{
//   
//}

/*---------------------------------------------------------------------------*-
timer4()
-----------------------------------------------------------------------------
Descriptif: Fonction d'interruption Timer4 vecteur 19
          Mode : 16bit autoreload
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void timer4() interrupt 19
{
   static unsigned int cpt=0;
   SFRPAGE   = CONFIG_PAGE;
   TMR4CN &=~0xC0;//Clear pending flag
   SFRPAGE   = LEGACY_PAGE;
   cpt++;
   if(cpt>=gVitesseDEC)
   {
      STEP_DEC=!STEP_DEC;
      cpt=0;
   }
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
			 gUart0Rx[gUart0NbrByteRx+1]=0;
          gUart0NbrByteRx=0;
       }
       else
       {
          gUart0NbrByteRx=(gUart0NbrByteRx+1)%20;
       }
   }
}

/*---------------------------------------------------------------------------*-
uart1()
-----------------------------------------------------------------------------
Descriptif: Fonction d'interruption de l'uart1 vecteur 16
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void uart1() interrupt 16
{
   if(SCON1&0x02)//TI1
   {
      SCON1=SCON1&~0x02;
      if(gUart1Tx[gUart1NbrByteTx]!=0)
      {
         SBUF1=gUart1Tx[gUart1NbrByteTx];
         gUart1NbrByteTx++;
      }
      else
      {
         gUart1NbrByteTx=0;
      }
   }
   
   if(SCON1&0x01)//RI1
   {
      SCON1=SCON1&~0x01;
      gUart1Rx[gUart1NbrByteRx]=SBUF1;
      if(gUart1Rx[gUart1NbrByteRx]=='\n')
       {
          gUart1FlagReceive=1;
			 gUart1Rx[gUart1NbrByteRx+1]=0;
          gUart1NbrByteRx=0;
       }
       else
       {
          gUart1NbrByteRx=(gUart1NbrByteRx+1)%20;
       }
   }
}

//FONCTION

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
		//Desactive tout l'I2C
		P0SKIP    = 0x03;//skip les pin SCL SDA
		XBR0      = 0x01;//desactive l'I2C
		//force le slave a sortir des donnee
		while(!SDA)
		{
			// Provide clock pulses to allow the slave to advance out
			// of its current state. This will allow it to release SDA.
			SCL = 0;                         // Drive the clock low
			for(i = 0; i < 100; i++);        // Hold the clock low
			SCL = 1;                         // Release the clock
			for(i = 0; i < 100; i++);        // Hold the clock low
		}
		P0SKIP	 = 0x00;//Enleve les skip de pin SDA et SCL
		XBR0      = 0x05;//reactive l'i2c
	}
}

/*---------------------------------------------------------------------------*-
configMCP23008()
-----------------------------------------------------------------------------
Descriptif: 
Entree    : unsigned char input (0 ... 255) - choix de pins a mettre en sortie
Sortie    : --
-*---------------------------------------------------------------------------*/
void configMCP23008(unsigned char input)
{
   gTarget = MCP23008_ADDR;       // gTarget the Slave for next SMBus transfer
   gSMBDataOUT[0]  = MCP23008_IODIR;
   gSMBDataOUT[1]  = input;       // Set as INPUT
   gSMBNumBytesToWR = 2;
   SMB_Write();  // Initiate SMBus write
}

/*---------------------------------------------------------------------------*-
read_i2c_port()
-----------------------------------------------------------------------------
Descriptif: Lis le port du MCP23008
Entree    : --
Sortie    : unsigend char (0 ... 255)
-*---------------------------------------------------------------------------*/
unsigned char read_i2c_port()
{
   while(SMB_BUSY);
   gTarget = MCP23008_ADDR;
   gSMBDataOUT[0]  = MCP23008_GPIO;
   gSMBNumBytesToWR = 1;
   SMB_Write();  // Initiate SMBus write
   while(SMB_BUSY);
   gTarget = MCP23008_ADDR;
   gSMBNumBytesToRD = 1;
   SMB_Read();  // Initiate SMBus write
   return gSMBDataIN[0];
}

/*---------------------------------------------------------------------------*-
setMotorRA()
-----------------------------------------------------------------------------
Descriptif: Applique une vitesse predefinit au moteur et une direction
Entree    : 
            - unsigned char vitesse (0 ... 8)
            - bit direction         (0 ... 1)
Sortie    : --
-*---------------------------------------------------------------------------*/
void setMotorRA(unsigned char vitesse,bit direction)
{
	unsigned int i=0;
	TR0=0;
	for(i=0;i<50000;i++);//voire figure 1
   DIR_RA=direction;
	for(i=0;i<50000;i++);//voire figure 1
   switch(vitesse)
   {
      case VITESSE_RA_SIDERAL://suivi sideral
         gVitesseRAH=VITESSE_RA_SIDERAL_HIGH;
         gVitesseRAL=VITESSE_RA_SIDERAL_LOW;
      break;
      case VITESSE_RA_LUNE://suivi Lune
         gVitesseRAH=VITESSE_RA_LUNE_HIGH;
         gVitesseRAL=VITESSE_RA_LUNE_LOW;
      break;
      case VITESSE_RA_SOLEIL://suivi Soleil-Planete generale
         gVitesseRAH=VITESSE_RA_SOLEIL_HIGH;//
         gVitesseRAL=VITESSE_RA_SOLEIL_LOW;
      break;
      case VITESSE_RA_SATURNE://suivi Soleil-Planete generale
         gVitesseRAH=VITESSE_RA_SATURNE_HIGH;//
         gVitesseRAL=VITESSE_RA_SATURNE_LOW;
      break;
      case VITESSE_RA_JUPITER://suivi Soleil-Planete generale
         gVitesseRAH=VITESSE_RA_JUPITER_HIGH;//
         gVitesseRAL=VITESSE_RA_JUPITER_LOW;
      break;
      case VITESSE_RA_ISS://suivi ISS
         gVitesseRAH=VITESSE_RA_ISS_HIGH;
         gVitesseRAL=VITESSE_RA_ISS_LOW;
      break;
      case VITESSE_X05://x0,5
         gVitesseRAH=VITESSE_RA_X05_HIGH;
         gVitesseRAL=VITESSE_RA_X05_LOW;
      break;
      case VITESSE_X2://x2
         gVitesseRAH=VITESSE_RA_X2_HIGH;
         gVitesseRAL=VITESSE_RA_X2_LOW;
      break;
      case VITESSE_X8://x8
         gVitesseRAH=VITESSE_RA_X8_HIGH;
         gVitesseRAL=VITESSE_RA_X8_LOW;
      break;
      case VITESSE_X16://x16
         gVitesseRAH=VITESSE_RA_X16_HIGH;
         gVitesseRAL=VITESSE_RA_X16_LOW;
      break;
      case VITESSE_MAX://max
         gVitesseRAH=VITESSE_RA_MAX_HIGH;
         gVitesseRAL=VITESSE_RA_MAX_LOW;
      break;
      default://suivi sideral
         gVitesseRAH=VITESSE_RA_SIDERAL_HIGH;
         gVitesseRAL=VITESSE_RA_SIDERAL_LOW;      
      break;
   }
	TH0=gVitesseRAH ;//Charge la valeur dans le registre MSB du timer 0
   TL0=gVitesseRAL;//Charge la valeur dans le registre LSB du timer 0
   TR0=1;
}

/*---------------------------------------------------------------------------*-
setMotorDEC()
-----------------------------------------------------------------------------
Descriptif: Applique une vitesse predefinit au moteur et une direction
Entree    :
            - unsigned char vitesse (4 ... 8)
            - bit direction         (0 ... 1)
Sortie    : --
-*---------------------------------------------------------------------------*/
void setMotorDEC(unsigned char vitesse,bit direction)
{
	unsigned int i=0;
	SFRPAGE   = CONFIG_PAGE;
   TMR4CN&=~0x04;
   SFRPAGE   = LEGACY_PAGE;
	for(i=0;i<50000;i++);//voire figure 1
   NSLEEP_DEC=1;//Attention il faut 1.7ms au chip pour se rallumer
   DIR_DEC=direction;
	for(i=0;i<50000;i++);//voire figure 1
   switch(vitesse)
   {
      case VITESSE_X05://x0,5
         gVitesseDEC=VITESSE_DEC_X05;
         SFRPAGE   = CONFIG_PAGE;
         TMR4CN|=0x04;
         SFRPAGE   = LEGACY_PAGE;
      break;
      case VITESSE_X2://x2
         gVitesseDEC=VITESSE_DEC_X2;
         SFRPAGE   = CONFIG_PAGE;
         TMR4CN|=0x04;
         SFRPAGE   = LEGACY_PAGE;
      break;
      case VITESSE_X8://x8
         gVitesseDEC=VITESSE_DEC_X8;
         SFRPAGE   = CONFIG_PAGE;
         TMR4CN|=0x04;
         SFRPAGE   = LEGACY_PAGE;
      break;
      case VITESSE_X16://x16
         gVitesseDEC=VITESSE_DEC_X16;
         SFRPAGE   = CONFIG_PAGE;
         TMR4CN|=0x04;
         SFRPAGE   = LEGACY_PAGE;
      break;
      case VITESSE_MAX://max
         gVitesseDEC=VITESSE_DEC_MAX;
         SFRPAGE   = CONFIG_PAGE;
         TMR4CN|=0x04;
         SFRPAGE   = LEGACY_PAGE;
      break;
      default://suivi sideral
        stopMotorDec(); 
      break;
   }
}

/*---------------------------------------------------------------------------*-
stopMotorDec()
-----------------------------------------------------------------------------
Descriptif: Stop le moteur de declinaison et met le drv8825 en sommeil
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void stopMotorDec()
{
   SFRPAGE   = CONFIG_PAGE;
   TMR4CN&=~0x04;
   SFRPAGE   = LEGACY_PAGE;
   NSLEEP_DEC=0;
}

/*---------------------------------------------------------------------------*-
decodeUartRaspberryPi()
-----------------------------------------------------------------------------
Descriptif: Decode les message envoyer par la raspberry PI
Entree    : -- (Utilisation de varible globale)
Sortie    : --
-*---------------------------------------------------------------------------*/
void decodeUartRaspberryPi()
{
   if((gUart0Rx[0]=='R')&&(gUart0Rx[1]=='A'))
   {
      if((gUart0Rx[2]=='+'))
      {
         setMotorRA(gVitesseDeplacement,gDirRa);
      }
      else if (gUart0Rx[2]=='-')
      {
         setMotorRA(gVitesseDeplacement,!gDirRa);
      }
      else//=='0'
      {
         setMotorRA(gAstrSuivi,gDirRa);
      }
   }
   else if((gUart0Rx[0]=='D')&&(gUart0Rx[1]=='E')&&(gUart0Rx[2]=='C'))
   {
      if((gUart0Rx[3]=='+'))
      {
         setMotorDEC(gVitesseDeplacement,gDirDec);
      }
      else if (gUart0Rx[3]=='-')
      {
         setMotorDEC(gVitesseDeplacement,!gDirDec);
      }
      else//=='0'
      {
         stopMotorDec();
      }
   }
	else//Ne reconnait pas la commande, fais suivre au slave
	{
		//gUart1Tx[0]
		strcpy(gUart1Tx,gUart0Rx);
		SCON1|=0x02;
	}
}

/*---------------------------------------------------------------------------*-
   UART_Init ()
  -----------------------------------------------------------------------------
   Descriptif: Configure l'UART par ces valeur par defaut
               (il ne fait rien)
   Entr�e    : --
   Sortie    : --
-*---------------------------------------------------------------------------*/
void UART_Init()
{
    SCON0     = 0x10;
    //SBRLL1    = 0x3C;
    //SBRLH1    = 0xF6;
    //SCON1     = 0x10;
    //SBCON1    = 0x43;
	
	//57600 Uart1
	 SBRLL1    = 0x5F;
    SBRLH1    = 0xFE;
    SCON1     = 0x10;
    SBCON1    = 0x43;
	
	//115200 Uart1
//	SBRLL1    = 0x30;
//    SBRLH1    = 0xFF;
//    SCON1     = 0x10;
//    SBCON1    = 0x43;
}

/*---------------------------------------------------------------------------*-
Init_int ()
-----------------------------------------------------------------------------
Descriptif:
Interruption 0 : P0.6 - Descendant
Interruption 1 : P0.7 - Descendant
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void Init_int()
{
   EX0=0;//Autorise l'interruption externe 0
   EX1=0;//Autorise l'interruption externe 1
   IT0=1;//interruption 0 sur flanc
   IT1=1;//interruption 1 sur flanc
   IT01CF= IT01CF &~ 0xFF;//Clear le registre des interruption
                         // +-------- INT1 Polarite
                         // |+++----- Selection du canal P0.x de l'interruption 1
                         // ||||+---- INT0 Polarite
                         // |||||+++- Selection du canal P0.x de l'interruption 0
                         // ||||||||  (000: Select P0.0)
                         // ||||||||  ...
                         // ||||||||  ...
                         // ||||||||  (111: Select P0.7)  
   IT01CF= IT01CF | 0x76;// 01110110

   IE0=0; IE0=0; IE0=0;//clear du flag d'interruption 0 (3* pour eviter les bug)
   IE1=0; IE1=0; IE1=0;//clear du flag d'interruption 1 (3* pour eviter les bug)
   EX0=1;//Active l'interruption 0
   EX1=1;//Active l'interruption 1
}

/*---------------------------------------------------------------------------*-
TimerInit ()
-----------------------------------------------------------------------------
Descriptif:
Timer 0 : Mode 16bit - Prediv 48 - vitesse definit par gVitesseRAH-L
Timer 1 : Mode 8bit - Prediv 48 - baudrate 57600
Entree    : --
Sortie    : --
-*---------------------------------------------------------------------------*/
void TimerInit()
{
   //Timer 0 et 1
   TR0 = 0;//Stop le timer 0
   TR1 = 0;
   ET0 = 0;//Desactive l'interruption du timer 0
   ET1=0;
   TMOD &= ~0x0F;//Clear le registre du mode 0
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
   TMOD |= 0x21;// 00000001
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
   TH0=gVitesseRAH;//Charge la valeur dans le registre MSB du timer 0
   TL0=gVitesseRAL;//Charge la valeur dans le registre LSB du timer 0
   TH1=TL1=BAUD_UART0;//Charge la valeur dans le registre LSB du timer 0
   TF0 = 0;//clear le flag d'interruption du timer 0
   TF1 = 0;
   ET0 = 1;//Autorise l'interruption du timer 0
   //ET1 = 1;
   
   //Init Timer 4 
   SFRPAGE   = CONFIG_PAGE;
   TMR4CN = 0x00;//Mode 16 bit auto reload
   TMR4RLH=0xF9;
   TMR4RLL=0x1F;
   SFRPAGE   = LEGACY_PAGE;
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
   TMR2CN    |= 0x0C;//0x0C
   TMR2RLH   |= 0xD4;//0x7B
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
   PortInit ()
  -----------------------------------------------------------------------------
   Descriptif: autorise le fonctionnement du crossbar et de l'uart0
   Entr�e    : --
   Sortie    : --
-*---------------------------------------------------------------------------*/
void PortInit () 
{
   // P0.0  -  SDA (SMBus0), Open-Drain, Digital
    // P0.1  -  SCL (SMBus0), Push-Pull,  Digital
    // P0.2  -  TX1 (UART1), Push-Pull,  Digital
    // P0.3  -  RX1 (UART1), Open-Drain, Digital
    // P0.4  -  TX0 (UART0), Push-Pull,  Digital
    // P0.5  -  RX0 (UART0), Open-Drain, Digital
    // P0.6  -  Unassigned,  Open-Drain, Digital
    // P0.7  -  Unassigned,  Open-Drain, Digital

    // P1.0  -  Skipped,     Push-Pull,  Digital
    // P1.1  -  Skipped,     Push-Pull,  Digital
    // P1.2  -  Skipped,     Push-Pull,  Digital
    // P1.3  -  Skipped,     Open-Drain, Digital
    // P1.4  -  Skipped,     Push-Pull,  Digital
    // P1.5  -  Skipped,     Push-Pull,  Digital
    // P1.6  -  Skipped,     Push-Pull,  Digital
    // P1.7  -  Skipped,     Open-Drain, Digital

    // P2.0  -  Skipped,     Open-Drain, Digital
    // P2.1  -  Skipped,     Open-Drain, Digital
    // P2.2  -  Skipped,     Open-Drain, Digital
    // P2.3  -  Skipped,     Open-Drain, Digital
    // P2.4  -  Unassigned,  Open-Drain, Digital
    // P2.5  -  Unassigned,  Open-Drain, Digital
    // P2.6  -  Unassigned,  Open-Drain, Digital
    // P2.7  -  Unassigned,  Open-Drain, Digital

    // P3.0  -  Unassigned,  Open-Drain, Digital

    P0MDOUT   = 0x16;
    P1MDOUT   = 0xDD;//0xFF = schema
    P1SKIP    = 0xFF;
    P2SKIP    = 0x0F;
    XBR0      |= 0x05;
    XBR1      |= 0x40;
    XBR2      |= 0x01;

} // PortInit ----------------------------------------------------------------