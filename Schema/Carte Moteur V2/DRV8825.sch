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
Sheet 2 3
Title "Carte Moteur"
Date ""
Rev "2"
Comp "CFPT Electronique"
Comment1 "Tanguy Dietrich"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L DRV8825 U4
U 1 1 5CB712F5
P 5450 4950
F 0 "U4" H 5250 5600 60  0000 C CNN
F 1 "DRV8825" H 5400 4850 60  0000 C CNN
F 2 "Carte_Principale:DRV8825" H 5450 4950 60  0001 C CNN
F 3 "" H 5450 4950 60  0000 C CNN
	1    5450 4950
	1    0    0    -1  
$EndComp
$Comp
L C C10
U 1 1 5CB71307
P 6250 4600
F 0 "C10" H 6275 4700 50  0000 L CNN
F 1 "C" H 6275 4500 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 6288 4450 50  0001 C CNN
F 3 "" H 6250 4600 50  0001 C CNN
	1    6250 4600
	1    0    0    -1  
$EndComp
$Comp
L R R8
U 1 1 5CB7130E
P 5650 4100
F 0 "R8" V 5600 4100 50  0000 C CNN
F 1 "1M" V 5650 4100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5580 4100 50  0001 C CNN
F 3 "" H 5650 4100 50  0001 C CNN
	1    5650 4100
	0    1    1    0   
$EndComp
Wire Wire Line
	6250 4450 5800 4450
Wire Wire Line
	5800 4450 5800 4550
Wire Wire Line
	6250 4750 6050 4750
Wire Wire Line
	6050 4750 6050 4600
Wire Wire Line
	6050 4600 5800 4600
$Comp
L R R10
U 1 1 5CB71321
P 5850 5700
F 0 "R10" V 5930 5700 50  0000 C CNN
F 1 "10k" V 5850 5700 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5780 5700 50  0001 C CNN
F 3 "" H 5850 5700 50  0001 C CNN
	1    5850 5700
	1    0    0    -1  
$EndComp
$Comp
L R R14
U 1 1 5CB71328
P 6250 5300
F 0 "R14" V 6330 5300 50  0000 C CNN
F 1 "5.6" V 6250 5300 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6180 5300 50  0001 C CNN
F 3 "" H 6250 5300 50  0001 C CNN
	1    6250 5300
	1    0    0    -1  
$EndComp
$Comp
L R R12
U 1 1 5CB7132F
P 6050 5350
F 0 "R12" V 6130 5350 50  0000 C CNN
F 1 "5.6" V 6050 5350 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5980 5350 50  0001 C CNN
F 3 "" H 6050 5350 50  0001 C CNN
	1    6050 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 5150 6250 5150
Wire Wire Line
	5800 5200 6050 5200
Wire Wire Line
	5000 5150 5000 5350
Connection ~ 5000 5300
$Comp
L C C2
U 1 1 5CB7133A
P 4600 5300
F 0 "C2" H 4625 5400 50  0000 L CNN
F 1 "C" H 4625 5200 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 4638 5150 50  0001 C CNN
F 3 "" H 4600 5300 50  0001 C CNN
	1    4600 5300
	1    0    0    -1  
$EndComp
$Comp
L C C8
U 1 1 5CB71341
P 6650 4050
F 0 "C8" H 6675 4150 50  0000 L CNN
F 1 "100uF" H 6675 3950 50  0000 L CNN
F 2 "Carte_Principale:CP_Radial_D5.0mm_P2.00mm" H 6688 3900 50  0001 C CNN
F 3 "" H 6650 4050 50  0001 C CNN
	1    6650 4050
	-1   0    0    1   
$EndComp
$Comp
L C C5
U 1 1 5CB71348
P 5650 3900
F 0 "C5" H 5675 4000 50  0000 L CNN
F 1 "0.1uF" H 5600 3800 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 5688 3750 50  0001 C CNN
F 3 "" H 5650 3900 50  0001 C CNN
	1    5650 3900
	0    1    1    0   
$EndComp
$Comp
L C C6
U 1 1 5CB7134F
P 5150 4150
F 0 "C6" H 5175 4250 50  0000 L CNN
F 1 "0.1uF" H 5175 4050 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 5188 4000 50  0001 C CNN
F 3 "" H 5150 4150 50  0001 C CNN
	1    5150 4150
	0    1    1    0   
$EndComp
$Comp
L GND #PWR012
U 1 1 5CB71356
P 4850 4400
F 0 "#PWR012" H 4850 4150 50  0001 C CNN
F 1 "GND" H 4850 4250 50  0000 C CNN
F 2 "" H 4850 4400 50  0001 C CNN
F 3 "" H 4850 4400 50  0001 C CNN
	1    4850 4400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 5CB7135C
P 5450 5600
F 0 "#PWR013" H 5450 5350 50  0001 C CNN
F 1 "GND" H 5450 5450 50  0000 C CNN
F 2 "" H 5450 5600 50  0001 C CNN
F 3 "" H 5450 5600 50  0001 C CNN
	1    5450 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 5500 5500 5500
Connection ~ 5450 5500
Wire Wire Line
	5450 5600 5450 5500
Wire Wire Line
	4600 5150 5000 5150
Wire Wire Line
	4850 4400 5000 4400
$Comp
L GND #PWR014
U 1 1 5CB71367
P 3550 5400
F 0 "#PWR014" H 3550 5150 50  0001 C CNN
F 1 "GND" H 3550 5250 50  0000 C CNN
F 2 "" H 3550 5400 50  0001 C CNN
F 3 "" H 3550 5400 50  0001 C CNN
	1    3550 5400
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR015
U 1 1 5CB7136D
P 4600 4500
F 0 "#PWR015" H 4600 4350 50  0001 C CNN
F 1 "VCC" H 4600 4650 50  0000 C CNN
F 2 "" H 4600 4500 50  0001 C CNN
F 3 "" H 4600 4500 50  0001 C CNN
	1    4600 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 4500 5000 4500
Wire Wire Line
	4900 4700 5000 4700
Wire Wire Line
	4900 4150 4900 4700
Connection ~ 4900 4400
NoConn ~ 5800 5350
Wire Wire Line
	4600 5600 5450 5600
Wire Wire Line
	4600 5600 4600 5450
Wire Wire Line
	5450 5500 6250 5500
Wire Wire Line
	6250 5500 6250 5450
Connection ~ 6050 5500
Wire Wire Line
	5800 5300 5850 5300
Wire Wire Line
	5850 5300 5850 5550
$Comp
L GS3 J11
U 1 1 5CB7138C
P 4200 5050
F 0 "J11" H 4400 5150 50  0000 C CNN
F 1 "GS3" H 4250 4851 50  0000 C CNN
F 2 "Connectors:GS3" V 4288 4976 50  0001 C CNN
F 3 "" H 4200 5050 50  0001 C CNN
	1    4200 5050
	1    0    0    -1  
$EndComp
$Comp
L GS3 J10
U 1 1 5CB71393
P 4200 4650
F 0 "J10" H 4250 4850 50  0000 C CNN
F 1 "GS3" H 4250 4451 50  0000 C CNN
F 2 "Connectors:GS3" V 4288 4576 50  0001 C CNN
F 3 "" H 4200 4650 50  0001 C CNN
	1    4200 4650
	1    0    0    -1  
$EndComp
$Comp
L GS3 J7
U 1 1 5CB7139A
P 3850 4850
F 0 "J7" H 3900 5050 50  0000 C CNN
F 1 "GS3" H 3900 4651 50  0000 C CNN
F 2 "Connectors:GS3" V 3938 4776 50  0001 C CNN
F 3 "" H 3850 4850 50  0001 C CNN
	1    3850 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 4650 4750 4650
Wire Wire Line
	4750 4650 4750 4850
Wire Wire Line
	4750 4850 5000 4850
Wire Wire Line
	4000 4850 4650 4850
Wire Wire Line
	4650 4850 4650 4900
Wire Wire Line
	4650 4900 5000 4900
Wire Wire Line
	4350 5050 4900 5050
Wire Wire Line
	4900 5050 4900 4950
Wire Wire Line
	4900 4950 5000 4950
Wire Wire Line
	3550 5150 4050 5150
Wire Wire Line
	3550 4950 3550 5400
Wire Wire Line
	3700 4950 3550 4950
Connection ~ 3550 5150
Wire Wire Line
	4050 4750 3950 4750
Wire Wire Line
	3950 4750 3950 5150
Connection ~ 3950 5150
$Comp
L VCC #PWR016
U 1 1 5CB713B4
P 3850 4400
F 0 "#PWR016" H 3850 4250 50  0001 C CNN
F 1 "VCC" H 3850 4550 50  0000 C CNN
F 2 "" H 3850 4400 50  0001 C CNN
F 3 "" H 3850 4400 50  0001 C CNN
	1    3850 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 4550 4050 4550
Wire Wire Line
	3850 4550 3850 4400
Wire Wire Line
	3700 4550 3700 4750
Connection ~ 3850 4550
Wire Wire Line
	4050 4950 4000 4950
Wire Wire Line
	4000 4950 4000 4550
Connection ~ 4000 4550
$Comp
L DRV8825 U3
U 1 1 5CB713C1
P 5350 2700
F 0 "U3" H 5150 3350 60  0000 C CNN
F 1 "DRV8825" H 5300 2600 60  0000 C CNN
F 2 "Carte_Principale:DRV8825" H 5350 2700 60  0001 C CNN
F 3 "" H 5350 2700 60  0000 C CNN
	1    5350 2700
	1    0    0    -1  
$EndComp
$Comp
L C C9
U 1 1 5CB713D3
P 6150 2350
F 0 "C9" H 6175 2450 50  0000 L CNN
F 1 "C" H 6175 2250 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 6188 2200 50  0001 C CNN
F 3 "" H 6150 2350 50  0001 C CNN
	1    6150 2350
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 5CB713DA
P 5500 1600
F 0 "R7" V 5580 1600 50  0000 C CNN
F 1 "1M" V 5500 1600 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5430 1600 50  0001 C CNN
F 3 "" H 5500 1600 50  0001 C CNN
	1    5500 1600
	0    1    1    0   
$EndComp
Wire Wire Line
	6150 2200 5700 2200
Wire Wire Line
	5700 2200 5700 2300
Wire Wire Line
	6150 2500 5950 2500
Wire Wire Line
	5950 2500 5950 2350
Wire Wire Line
	5950 2350 5700 2350
$Comp
L R R9
U 1 1 5CB713ED
P 5750 3450
F 0 "R9" V 5830 3450 50  0000 C CNN
F 1 "10k" V 5750 3450 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5680 3450 50  0001 C CNN
F 3 "" H 5750 3450 50  0001 C CNN
	1    5750 3450
	1    0    0    -1  
$EndComp
$Comp
L R R13
U 1 1 5CB713F4
P 6150 3050
F 0 "R13" V 6230 3050 50  0000 C CNN
F 1 "5.6" V 6150 3050 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6080 3050 50  0001 C CNN
F 3 "" H 6150 3050 50  0001 C CNN
	1    6150 3050
	1    0    0    -1  
$EndComp
$Comp
L R R11
U 1 1 5CB713FB
P 5950 3100
F 0 "R11" V 6030 3100 50  0000 C CNN
F 1 "5.6" V 5950 3100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 5880 3100 50  0001 C CNN
F 3 "" H 5950 3100 50  0001 C CNN
	1    5950 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 2900 6150 2900
Wire Wire Line
	5700 2950 5950 2950
Wire Wire Line
	4900 2900 4900 3100
Connection ~ 4900 3050
$Comp
L C C1
U 1 1 5CB71406
P 4500 3050
F 0 "C1" H 4525 3150 50  0000 L CNN
F 1 "C" H 4525 2950 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 4538 2900 50  0001 C CNN
F 3 "" H 4500 3050 50  0001 C CNN
	1    4500 3050
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 5CB7140D
P 5500 1800
F 0 "C7" H 5525 1900 50  0000 L CNN
F 1 "0.1uF" H 5525 1700 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 5538 1650 50  0001 C CNN
F 3 "" H 5500 1800 50  0001 C CNN
	1    5500 1800
	0    1    1    0   
$EndComp
$Comp
L C C3
U 1 1 5CB71414
P 5050 1650
F 0 "C3" H 5075 1750 50  0000 L CNN
F 1 "0.1uF" H 5075 1550 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 5088 1500 50  0001 C CNN
F 3 "" H 5050 1650 50  0001 C CNN
	1    5050 1650
	0    1    1    0   
$EndComp
$Comp
L C C4
U 1 1 5CB7141B
P 5050 1900
F 0 "C4" H 5075 2000 50  0000 L CNN
F 1 "0.1uF" H 5075 1800 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 5088 1750 50  0001 C CNN
F 3 "" H 5050 1900 50  0001 C CNN
	1    5050 1900
	0    1    1    0   
$EndComp
$Comp
L GND #PWR017
U 1 1 5CB71422
P 4750 2150
F 0 "#PWR017" H 4750 1900 50  0001 C CNN
F 1 "GND" H 4750 2000 50  0000 C CNN
F 2 "" H 4750 2150 50  0001 C CNN
F 3 "" H 4750 2150 50  0001 C CNN
	1    4750 2150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 5CB71428
P 5350 3400
F 0 "#PWR018" H 5350 3150 50  0001 C CNN
F 1 "GND" H 5350 3250 50  0000 C CNN
F 2 "" H 5350 3400 50  0001 C CNN
F 3 "" H 5350 3400 50  0001 C CNN
	1    5350 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 3250 5400 3250
Connection ~ 5350 3250
Wire Wire Line
	5350 3250 5350 3400
Wire Wire Line
	4500 2900 4900 2900
Wire Wire Line
	4900 2150 4750 2150
$Comp
L GND #PWR019
U 1 1 5CB71433
P 3450 3150
F 0 "#PWR019" H 3450 2900 50  0001 C CNN
F 1 "GND" H 3450 3000 50  0000 C CNN
F 2 "" H 3450 3150 50  0001 C CNN
F 3 "" H 3450 3150 50  0001 C CNN
	1    3450 3150
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR020
U 1 1 5CB71439
P 4500 2250
F 0 "#PWR020" H 4500 2100 50  0001 C CNN
F 1 "VCC" H 4500 2400 50  0000 C CNN
F 2 "" H 4500 2250 50  0001 C CNN
F 3 "" H 4500 2250 50  0001 C CNN
	1    4500 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 2250 4900 2250
Wire Wire Line
	4900 2450 4800 2450
Wire Wire Line
	4800 2450 4800 2150
Connection ~ 4800 2150
NoConn ~ 5700 3100
Wire Wire Line
	5350 1450 5350 2000
Wire Wire Line
	4900 1650 4900 2150
Connection ~ 4900 1900
Wire Wire Line
	5400 1900 5400 2000
Wire Wire Line
	5350 1650 5200 1650
Connection ~ 5350 1650
Wire Wire Line
	5350 3350 4500 3350
Wire Wire Line
	4500 3350 4500 3200
Wire Wire Line
	5350 3250 6150 3250
Wire Wire Line
	6150 3250 6150 3200
Connection ~ 5950 3250
Wire Wire Line
	5700 3050 5750 3050
Wire Wire Line
	5750 3050 5750 3300
$Comp
L GS3 J9
U 1 1 5CB71458
P 4100 2800
F 0 "J9" H 4150 3000 50  0000 C CNN
F 1 "GS3" H 4150 2601 50  0000 C CNN
F 2 "Connectors:GS3" V 4188 2726 50  0001 C CNN
F 3 "" H 4100 2800 50  0001 C CNN
	1    4100 2800
	1    0    0    -1  
$EndComp
$Comp
L GS3 J8
U 1 1 5CB7145F
P 4100 2400
F 0 "J8" H 4150 2600 50  0000 C CNN
F 1 "GS3" H 4150 2201 50  0000 C CNN
F 2 "Connectors:GS3" V 4188 2326 50  0001 C CNN
F 3 "" H 4100 2400 50  0001 C CNN
	1    4100 2400
	1    0    0    -1  
$EndComp
$Comp
L GS3 J6
U 1 1 5CB71466
P 3750 2600
F 0 "J6" H 3800 2800 50  0000 C CNN
F 1 "GS3" H 3800 2401 50  0000 C CNN
F 2 "Connectors:GS3" V 3838 2526 50  0001 C CNN
F 3 "" H 3750 2600 50  0001 C CNN
	1    3750 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 2400 4650 2400
Wire Wire Line
	4650 2400 4650 2600
Wire Wire Line
	4650 2600 4900 2600
Wire Wire Line
	3900 2600 4550 2600
Wire Wire Line
	4550 2600 4550 2650
Wire Wire Line
	4550 2650 4900 2650
Wire Wire Line
	4250 2800 4800 2800
Wire Wire Line
	4800 2800 4800 2700
Wire Wire Line
	4800 2700 4900 2700
Wire Wire Line
	3450 2900 3950 2900
Wire Wire Line
	3450 2700 3450 3150
Wire Wire Line
	3600 2700 3450 2700
Connection ~ 3450 2900
Wire Wire Line
	3950 2500 3850 2500
Wire Wire Line
	3850 2500 3850 2900
Connection ~ 3850 2900
$Comp
L VCC #PWR021
U 1 1 5CB71480
P 3750 2150
F 0 "#PWR021" H 3750 2000 50  0001 C CNN
F 1 "VCC" H 3750 2300 50  0000 C CNN
F 2 "" H 3750 2150 50  0001 C CNN
F 3 "" H 3750 2150 50  0001 C CNN
	1    3750 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 2300 3950 2300
Wire Wire Line
	3750 2300 3750 2150
Wire Wire Line
	3600 2300 3600 2500
Connection ~ 3750 2300
Wire Wire Line
	3950 2700 3900 2700
Wire Wire Line
	3900 2700 3900 2300
Connection ~ 3900 2300
Text HLabel 3150 1600 0    60   Input ~ 0
VCC(3.3V)
Text HLabel 3150 1850 0    60   Input ~ 0
STEP_RA
Text HLabel 3150 1950 0    60   Input ~ 0
DIR_RA
Text HLabel 3150 2050 0    60   Input ~ 0
NSLEEP_RA
Text HLabel 6200 3300 2    60   Output ~ 0
nFault_RA
Text HLabel 2550 6300 0    60   Input ~ 0
GND
Wire Wire Line
	3150 1600 4550 1600
Wire Wire Line
	4550 1600 4550 2250
Connection ~ 4550 2250
Wire Wire Line
	2500 6300 5100 6300
Wire Wire Line
	5100 6300 5100 5600
Connection ~ 5100 5600
Wire Wire Line
	3150 1850 4250 1850
Wire Wire Line
	4250 1850 4250 2300
Wire Wire Line
	4250 2300 4900 2300
Wire Wire Line
	4900 2300 4900 2350
Wire Wire Line
	3150 1950 4200 1950
Wire Wire Line
	4200 1950 4200 2350
Wire Wire Line
	4200 2350 4750 2350
Wire Wire Line
	4750 2350 4750 2400
Wire Wire Line
	4750 2400 4900 2400
Wire Wire Line
	4900 2200 4650 2200
Wire Wire Line
	4650 2200 4650 2050
Wire Wire Line
	4650 2050 3150 2050
Connection ~ 5350 3350
Text HLabel 3150 4050 0    60   Input ~ 0
STEP_DEC
Text HLabel 3150 4150 0    60   Input ~ 0
DIR_DEC
Text HLabel 3150 4250 0    60   Input ~ 0
nSLEEP_DEC
Text HLabel 6300 5600 2    60   Output ~ 0
nFault_DEC
Wire Wire Line
	3150 4050 4500 4050
Wire Wire Line
	4500 4050 4500 4600
Wire Wire Line
	4500 4600 5000 4600
Wire Wire Line
	3150 4150 4450 4150
Wire Wire Line
	4450 4150 4450 4700
Wire Wire Line
	4450 4700 4850 4700
Wire Wire Line
	4850 4700 4850 4650
Wire Wire Line
	4850 4650 5000 4650
Wire Wire Line
	3150 4250 4750 4250
Wire Wire Line
	4750 4250 4750 4450
Wire Wire Line
	4750 4450 5000 4450
Text HLabel 5350 1450 1    60   Input ~ 0
VCC(12V)
Wire Wire Line
	5200 1900 5400 1900
Connection ~ 5350 1900
Connection ~ 5350 1800
Wire Wire Line
	7500 3700 7500 1550
Wire Wire Line
	6300 5600 5900 5600
Wire Wire Line
	5900 5600 5900 5550
Wire Wire Line
	5900 5550 5850 5550
Wire Wire Line
	5850 5850 4900 5850
Wire Wire Line
	4900 5850 4900 5150
Connection ~ 4900 5150
Wire Wire Line
	5750 3600 4750 3600
Wire Wire Line
	4750 3600 4750 2900
Connection ~ 4750 2900
Wire Wire Line
	5750 3300 6200 3300
Wire Wire Line
	5500 4250 5450 4250
$Comp
L GND #PWR022
U 1 1 5CC037D6
P 6650 4350
F 0 "#PWR022" H 6650 4100 50  0001 C CNN
F 1 "GND" H 6650 4200 50  0000 C CNN
F 2 "" H 6650 4350 50  0001 C CNN
F 3 "" H 6650 4350 50  0001 C CNN
	1    6650 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 4200 6650 4350
Wire Wire Line
	5800 3900 5800 4400
Wire Wire Line
	5500 3850 5500 4250
Connection ~ 5500 4100
Connection ~ 5800 4100
Connection ~ 5800 3900
Wire Wire Line
	5500 3700 7500 3700
$Comp
L C C12
U 1 1 5CC04BC3
P 5150 3850
F 0 "C12" H 5175 3950 50  0000 L CNN
F 1 "0.1uF" H 5175 3750 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 5188 3700 50  0001 C CNN
F 3 "" H 5150 3850 50  0001 C CNN
	1    5150 3850
	0    1    1    0   
$EndComp
Wire Wire Line
	5300 4150 5500 4150
Connection ~ 5500 4150
Wire Wire Line
	5300 3850 5500 3850
Connection ~ 5500 3900
Wire Wire Line
	5000 3850 5000 4150
Wire Wire Line
	5000 4150 4900 4150
$Comp
L C C13
U 1 1 5CC05733
P 6050 1750
F 0 "C13" H 6075 1850 50  0000 L CNN
F 1 "100uF" H 6075 1650 50  0000 L CNN
F 2 "Carte_Principale:CP_Radial_D5.0mm_P2.00mm" H 6088 1600 50  0001 C CNN
F 3 "" H 6050 1750 50  0001 C CNN
	1    6050 1750
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR023
U 1 1 5CC058D3
P 6050 1950
F 0 "#PWR023" H 6050 1700 50  0001 C CNN
F 1 "GND" H 6050 1800 50  0000 C CNN
F 2 "" H 6050 1950 50  0001 C CNN
F 3 "" H 6050 1950 50  0001 C CNN
	1    6050 1950
	1    0    0    -1  
$EndComp
Connection ~ 5350 1600
Wire Wire Line
	5500 3700 5500 3900
Wire Wire Line
	7500 1550 5350 1550
Connection ~ 5350 1550
Wire Wire Line
	6650 3900 6650 3700
Connection ~ 6650 3700
Wire Wire Line
	5650 1600 5650 2050
Wire Wire Line
	5650 2050 5700 2050
Wire Wire Line
	5700 2050 5700 2150
Connection ~ 5650 1800
Wire Wire Line
	6050 1900 6050 1950
Wire Wire Line
	6050 1600 6050 1550
Connection ~ 6050 1550
$Comp
L 95009-7441 J18
U 1 1 5CC09301
P 6250 4850
F 0 "J18" H 6900 5150 50  0000 L CNN
F 1 "95009-7441" H 6900 5050 50  0000 L CNN
F 2 "Carte_Principale:RJ11-95009-7441" H 6900 4950 50  0001 L CNN
F 3 "https://componentsearchengine.com/Datasheets/1/95009-7441.pdf" H 6900 4850 50  0001 L CNN
F 4 "RJ11 R/A PCB modular jack, w/panel stops Molex 4P4C Right Angle PCB Mount RJ11 Modular Jack Connector 95009" H 6900 4750 50  0001 L CNN "Description"
F 5 "" H 6900 4650 50  0001 L CNN "Height"
F 6 "538-95009-7441" H 6900 4550 50  0001 L CNN "Mouser Part Number"
F 7 "https://www.mouser.com/Search/Refine.aspx?Keyword=538-95009-7441" H 6900 4450 50  0001 L CNN "Mouser Price/Stock"
F 8 "Molex" H 6900 4350 50  0001 L CNN "Manufacturer_Name"
F 9 "95009-7441" H 6900 4250 50  0001 L CNN "Manufacturer_Part_Number"
	1    6250 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 4950 6050 4950
Wire Wire Line
	6050 4950 6050 4900
Wire Wire Line
	6050 4900 5800 4900
Wire Wire Line
	5800 4950 6000 4950
Wire Wire Line
	6000 4950 6000 5050
Wire Wire Line
	6000 5050 7150 5050
Wire Wire Line
	7150 5050 7150 4850
Wire Wire Line
	7150 4850 7050 4850
Wire Wire Line
	5800 4800 6400 4800
Wire Wire Line
	6400 4800 6400 4700
Wire Wire Line
	6400 4700 7100 4700
Wire Wire Line
	7100 4700 7100 4950
Wire Wire Line
	7100 4950 7050 4950
Wire Wire Line
	6250 4850 5950 4850
Wire Wire Line
	5950 4850 5950 4750
Wire Wire Line
	5950 4750 5800 4750
$Comp
L 95009-7441 J17
U 1 1 5CC0BD91
P 6250 2600
F 0 "J17" H 6900 2900 50  0000 L CNN
F 1 "95009-7441" H 6900 2800 50  0000 L CNN
F 2 "Carte_Principale:RJ11-95009-7441" H 6900 2700 50  0001 L CNN
F 3 "https://componentsearchengine.com/Datasheets/1/95009-7441.pdf" H 6900 2600 50  0001 L CNN
F 4 "RJ11 R/A PCB modular jack, w/panel stops Molex 4P4C Right Angle PCB Mount RJ11 Modular Jack Connector 95009" H 6900 2500 50  0001 L CNN "Description"
F 5 "" H 6900 2400 50  0001 L CNN "Height"
F 6 "538-95009-7441" H 6900 2300 50  0001 L CNN "Mouser Part Number"
F 7 "https://www.mouser.com/Search/Refine.aspx?Keyword=538-95009-7441" H 6900 2200 50  0001 L CNN "Mouser Price/Stock"
F 8 "Molex" H 6900 2100 50  0001 L CNN "Manufacturer_Name"
F 9 "95009-7441" H 6900 2000 50  0001 L CNN "Manufacturer_Part_Number"
	1    6250 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 2700 5950 2700
Wire Wire Line
	5950 2700 5950 2650
Wire Wire Line
	5950 2650 5700 2650
Wire Wire Line
	6250 2600 5850 2600
Wire Wire Line
	5850 2600 5850 2500
Wire Wire Line
	5850 2500 5700 2500
Wire Wire Line
	7050 2600 7250 2600
Wire Wire Line
	7250 2600 7250 2850
Wire Wire Line
	7250 2850 5700 2850
Wire Wire Line
	5700 2850 5700 2700
Wire Wire Line
	7050 2700 7050 2700
Wire Wire Line
	7050 2700 7050 2750
Wire Wire Line
	7050 2750 5800 2750
Wire Wire Line
	5800 2750 5800 2550
Wire Wire Line
	5800 2550 5700 2550
$EndSCHEMATC
