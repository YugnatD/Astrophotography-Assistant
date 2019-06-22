/*===========================================================================*=
	Slave_Telescope - PID - Tanguy Dietrich
  =============================================================================
   Descriptif: 

=*===========================================================================*/

#define DEMO_CONSIGNE -200//45°C
#define CORRECTION_TEMPERATURE 50 //temperature a ajouter au dessus du point de rose

#define LM35_0_POS 0
#define LM35_0_NEG 1

#define LM35_1_POS 2
#define LM35_1_NEG 3

#define LM35_2_POS 4
#define LM35_2_NEG 5

#define LM35_3_POS 6
#define LM35_3_NEG 7

#define POT_0 8
#define POT_1 9
#define POT_2 10
#define POT_3 11



//Define Temperature
#define REF_ADC 322

#define MODE_UART 3
#define MODE_PID 2
#define MODE_POT 6

#define NMESURE 10 //nombre de mesure a faire pour une moyenne
#define DELAI_MESURE 10//temps entre chaque mesure * 50[ms]

#define KP 30
#define KI 0
#define KD 15