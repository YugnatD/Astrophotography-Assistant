EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:Carte_Principale
LIBS:SamacSys_Parts
LIBS:Carte_Principale-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 3
Title "Carte Moteur"
Date "2017-02-09"
Rev "2"
Comp "CFPT Electronique"
Comment1 "Tanguy Dietrich"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L HEADER_10P J12
U 1 1 588A1581
P 3200 4500
F 0 "J12" H 3200 4800 60  0000 C CNN
F 1 "HEADER_10P" H 3200 4200 50  0000 C CNN
F 2 "Carte_Principale:JTAG" H 3200 4500 60  0001 C CNN
F 3 "" H 3200 4500 60  0000 C CNN
	1    3200 4500
	1    0    0    -1  
$EndComp
$Comp
L POUSSOIR_ON BP1
U 1 1 588A1722
P 1600 4500
F 0 "BP1" H 1750 4610 50  0000 C CNN
F 1 "POUSSOIR_ON" H 1600 4420 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_PUSH_6mm" H 1600 4500 60  0001 C CNN
F 3 "" H 1600 4500 60  0000 C CNN
	1    1600 4500
	1    0    0    -1  
$EndComp
$Comp
L R R15
U 1 1 588A1775
P 2050 4250
F 0 "R15" V 2130 4250 50  0000 C CNN
F 1 "1K" V 2050 4250 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1980 4250 50  0001 C CNN
F 3 "" H 2050 4250 50  0000 C CNN
	1    2050 4250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR024
U 1 1 588A7E21
P 5150 5200
F 0 "#PWR024" H 5150 4950 50  0001 C CNN
F 1 "GND" H 5150 5050 50  0000 C CNN
F 2 "" H 5150 5200 50  0000 C CNN
F 3 "" H 5150 5200 50  0000 C CNN
	1    5150 5200
	1    0    0    -1  
$EndComp
$Comp
L R R17
U 1 1 588A80CE
P 4000 4500
F 0 "R17" V 4080 4500 50  0000 C CNN
F 1 "1K" V 4000 4500 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 3930 4500 50  0001 C CNN
F 3 "" H 4000 4500 50  0000 C CNN
	1    4000 4500
	0    1    1    0   
$EndComp
$Comp
L R R16
U 1 1 588A8163
P 2450 4050
F 0 "R16" V 2530 4050 50  0000 C CNN
F 1 "1K" V 2450 4050 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 2380 4050 50  0001 C CNN
F 3 "" H 2450 4050 50  0000 C CNN
	1    2450 4050
	0    1    1    0   
$EndComp
$Comp
L C C11
U 1 1 588A84D0
P 2050 4750
F 0 "C11" H 2075 4850 50  0000 L CNN
F 1 "1uF" H 2075 4650 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 2088 4600 50  0001 C CNN
F 3 "" H 2050 4750 50  0000 C CNN
	1    2050 4750
	1    0    0    -1  
$EndComp
NoConn ~ 4350 3500
NoConn ~ 4350 3600
NoConn ~ 4350 3700
$Comp
L GND #PWR025
U 1 1 588A9545
P 3750 4700
F 0 "#PWR025" H 3750 4450 50  0001 C CNN
F 1 "GND" H 3750 4550 50  0000 C CNN
F 2 "" H 3750 4700 50  0000 C CNN
F 3 "" H 3750 4700 50  0000 C CNN
	1    3750 4700
	1    0    0    -1  
$EndComp
NoConn ~ 3600 4600
NoConn ~ 3600 4700
$Comp
L GND #PWR026
U 1 1 588AA13C
P 2750 4750
F 0 "#PWR026" H 2750 4500 50  0001 C CNN
F 1 "GND" H 2750 4600 50  0000 C CNN
F 2 "" H 2750 4750 50  0000 C CNN
F 3 "" H 2750 4750 50  0000 C CNN
	1    2750 4750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR027
U 1 1 588AB990
P 1250 4600
F 0 "#PWR027" H 1250 4350 50  0001 C CNN
F 1 "GND" H 1250 4450 50  0000 C CNN
F 2 "" H 1250 4600 50  0000 C CNN
F 3 "" H 1250 4600 50  0000 C CNN
	1    1250 4600
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG028
U 1 1 589339EC
P 1250 4450
F 0 "#FLG028" H 1250 4545 50  0001 C CNN
F 1 "PWR_FLAG" H 1250 4630 50  0000 C CNN
F 2 "" H 1250 4450 50  0000 C CNN
F 3 "" H 1250 4450 50  0000 C CNN
	1    1250 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 5150 5150 5200
Wire Wire Line
	3600 4400 4350 4400
Wire Wire Line
	3600 4500 3850 4500
Wire Wire Line
	4150 4500 4250 4500
Wire Wire Line
	4250 4500 4250 4400
Connection ~ 4250 4400
Wire Wire Line
	3750 4700 3750 4300
Wire Wire Line
	3750 4300 3600 4300
Wire Wire Line
	2600 4050 4350 4050
Wire Wire Line
	2800 4600 2650 4600
Wire Wire Line
	2650 4600 2650 4050
Connection ~ 2650 4050
Wire Wire Line
	2800 4400 2750 4400
Wire Wire Line
	2750 4400 2750 4750
Wire Wire Line
	2750 4700 2800 4700
Connection ~ 2750 4700
Wire Wire Line
	2300 4050 2250 4050
Wire Wire Line
	2250 4050 2250 4500
Wire Wire Line
	1900 4500 2800 4500
Wire Wire Line
	2750 4300 2800 4300
Wire Wire Line
	2050 4400 2050 4600
Connection ~ 2250 4500
Connection ~ 2050 4500
Wire Wire Line
	2050 4900 2050 4950
Wire Wire Line
	1250 4450 1250 4600
Wire Wire Line
	1250 4500 1300 4500
Wire Wire Line
	2050 4100 2050 4000
Connection ~ 1250 4500
$Comp
L GND #PWR029
U 1 1 588AB94F
P 2050 4950
F 0 "#PWR029" H 2050 4700 50  0001 C CNN
F 1 "GND" H 2050 4800 50  0000 C CNN
F 2 "" H 2050 4950 50  0000 C CNN
F 3 "" H 2050 4950 50  0000 C CNN
	1    2050 4950
	1    0    0    -1  
$EndComp
$Comp
L C8051F38C U7
U 1 1 588A1467
P 5150 3450
F 0 "U7" H 4800 4850 60  0000 C CNN
F 1 "C8051F38C" H 5150 3850 60  0000 C CNN
F 2 "Carte_Principale:C8051F38C" H 5150 3450 60  0001 C CNN
F 3 "" H 5150 3450 60  0000 C CNN
	1    5150 3450
	1    0    0    -1  
$EndComp
Text HLabel 4150 2550 0    60   Input ~ 0
VCC(5V)
Text HLabel 5150 1750 1    60   Output ~ 0
VDD(3.3V)
Wire Wire Line
	5150 1750 5150 1850
Wire Wire Line
	4150 2550 4350 2550
Wire Wire Line
	2950 1800 5150 1800
Connection ~ 5150 1800
Wire Wire Line
	2950 4000 2950 1800
Wire Wire Line
	2050 4000 2950 4000
Wire Wire Line
	2750 4000 2750 4300
Connection ~ 2750 4000
Text HLabel 6100 2250 2    60   BiDi ~ 0
P0.0
Text HLabel 6100 2350 2    60   BiDi ~ 0
P0.1
Text HLabel 6100 2450 2    60   BiDi ~ 0
P0.2
Text HLabel 6100 2550 2    60   BiDi ~ 0
P0.3
Text HLabel 6100 2650 2    60   BiDi ~ 0
P0.4
Text HLabel 6100 2750 2    60   BiDi ~ 0
P0.5
Text HLabel 6100 2850 2    60   BiDi ~ 0
P0.6
Text HLabel 6100 2950 2    60   BiDi ~ 0
P0.7
Text HLabel 6100 3150 2    60   BiDi ~ 0
P1.0
Text HLabel 6100 3250 2    60   BiDi ~ 0
P1.1
Text HLabel 6100 3350 2    60   BiDi ~ 0
P1.2
Text HLabel 6100 3450 2    60   BiDi ~ 0
P1.3
Text HLabel 6100 3550 2    60   BiDi ~ 0
P1.4
Text HLabel 6100 3650 2    60   BiDi ~ 0
P1.5
Text HLabel 6100 3750 2    60   BiDi ~ 0
P1.6
Text HLabel 6100 3850 2    60   BiDi ~ 0
P1.7
Text HLabel 6100 4050 2    60   BiDi ~ 0
P2.0
Text HLabel 6100 4150 2    60   BiDi ~ 0
P2.1
Text HLabel 6100 4250 2    60   BiDi ~ 0
P2.2
Text HLabel 6100 4350 2    60   BiDi ~ 0
P2.3
Text HLabel 6100 4450 2    60   BiDi ~ 0
P2.4
Text HLabel 6100 4550 2    60   BiDi ~ 0
P2.5
Text HLabel 6100 4650 2    60   BiDi ~ 0
P2.6
Text HLabel 6100 4750 2    60   BiDi ~ 0
P2.7
Wire Wire Line
	6100 4050 5950 4050
Wire Wire Line
	6100 4150 5950 4150
Wire Wire Line
	6100 4250 5950 4250
Wire Wire Line
	6100 4350 5950 4350
Wire Wire Line
	6100 4450 5950 4450
Wire Wire Line
	6100 4550 5950 4550
Wire Wire Line
	6100 4650 5950 4650
Wire Wire Line
	6100 4750 5950 4750
Wire Wire Line
	5950 3850 6100 3850
Wire Wire Line
	6100 3750 5950 3750
Wire Wire Line
	5950 3650 6100 3650
Wire Wire Line
	6100 3550 5950 3550
Wire Wire Line
	5950 3450 6100 3450
Wire Wire Line
	5950 3250 6100 3250
Wire Wire Line
	6100 3150 5950 3150
Wire Wire Line
	5950 2950 6100 2950
Wire Wire Line
	6100 2850 5950 2850
Wire Wire Line
	5950 2750 6100 2750
Wire Wire Line
	6100 2650 5950 2650
Wire Wire Line
	5950 2550 6100 2550
Wire Wire Line
	6100 2450 5950 2450
Wire Wire Line
	5950 2350 6100 2350
Wire Wire Line
	6100 2250 5950 2250
Text HLabel 5150 5200 2    60   Input ~ 0
GND
Wire Wire Line
	6100 3350 5950 3350
$EndSCHEMATC
