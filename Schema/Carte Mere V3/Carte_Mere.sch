EESchema Schematic File Version 2
LIBS:power
LIBS:device
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
LIBS:Carte_Mere
LIBS:Carte_Mere-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Carte Mere"
Date ""
Rev "3"
Comp "CFPT Electronique"
Comment1 "Tanguy Dietrich"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Raspberry_Pi_2_3 J3
U 1 1 5CC47015
P 4300 3950
F 0 "J3" H 5000 2700 50  0000 C CNN
F 1 "Raspberry_Pi_2_3" H 3900 4850 50  0000 C CNN
F 2 "Carte Mere:RaspberryPI3_V2" H 5300 5200 50  0001 C CNN
F 3 "" H 4350 3800 50  0001 C CNN
	1    4300 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 5250 4600 5250
Connection ~ 4000 5250
Connection ~ 4100 5250
Connection ~ 4200 5250
Connection ~ 4300 5250
Connection ~ 4400 5250
Connection ~ 4500 5250
$Comp
L GND #PWR01
U 1 1 5CC47208
P 4250 5400
F 0 "#PWR01" H 4250 5150 50  0001 C CNN
F 1 "GND" H 4250 5250 50  0000 C CNN
F 2 "" H 4250 5400 50  0001 C CNN
F 3 "" H 4250 5400 50  0001 C CNN
	1    4250 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 5400 4250 5250
Connection ~ 4250 5250
Wire Wire Line
	4100 2650 4200 2650
NoConn ~ 4400 2650
NoConn ~ 4500 2650
$Comp
L Conn_01x05 J7
U 1 1 5CC473AD
P 8550 4300
F 0 "J7" H 8550 4600 50  0000 C CNN
F 1 "Conn_01x05" V 8650 4300 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 8550 4300 50  0001 C CNN
F 3 "" H 8550 4300 50  0001 C CNN
	1    8550 4300
	-1   0    0    1   
$EndComp
NoConn ~ 5200 3250
NoConn ~ 5200 3450
NoConn ~ 5200 3550
NoConn ~ 5200 3750
NoConn ~ 5200 3850
NoConn ~ 5200 3950
NoConn ~ 5200 4050
NoConn ~ 5200 4150
NoConn ~ 5200 4350
NoConn ~ 5200 4450
NoConn ~ 3400 3250
NoConn ~ 3400 3350
NoConn ~ 3400 3450
NoConn ~ 3400 3550
NoConn ~ 3400 3650
NoConn ~ 3400 3750
NoConn ~ 3400 3850
NoConn ~ 3400 3950
NoConn ~ 3400 4050
NoConn ~ 3400 4150
NoConn ~ 3400 4250
NoConn ~ 3400 4350
NoConn ~ 3400 4650
NoConn ~ 3400 4750
$Comp
L Jumper JP1
U 1 1 5CC47CDA
P 4100 2200
F 0 "JP1" H 4100 2350 50  0000 C CNN
F 1 "Jumper" H 4100 2120 50  0000 C CNN
F 2 "Carte Mere:Pin_alimentation" H 4100 2200 50  0001 C CNN
F 3 "" H 4100 2200 50  0001 C CNN
	1    4100 2200
	0    1    1    0   
$EndComp
Wire Wire Line
	4100 2500 4100 2650
$Comp
L Carte_Moteur U1
U 1 1 5CC48EF3
P 9650 3350
F 0 "U1" H 9950 5050 60  0000 C CNN
F 1 "Carte_Moteur" H 9450 5050 60  0000 C CNN
F 2 "Carte Mere:Carte_Moteur_V2" H 9400 4650 60  0001 C CNN
F 3 "" H 9400 4650 60  0001 C CNN
	1    9650 3350
	1    0    0    -1  
$EndComp
Text GLabel 8650 4700 0    60   Input ~ 0
VCC(5V)
Text GLabel 8650 4850 0    60   Input ~ 0
VCC(12V)
Text GLabel 8650 5000 0    60   Input ~ 0
GND
Text GLabel 3000 1200 2    60   Input ~ 0
VCC(5V)
Text GLabel 1700 1100 1    60   Input ~ 0
VCC(12V)
Text GLabel 5400 4650 2    60   Input ~ 0
TX_RPI
Text GLabel 5400 4750 2    60   Input ~ 0
RX_RPI
Text GLabel 8450 2300 0    60   Input ~ 0
TX_RPI
Text GLabel 8450 2150 0    60   Input ~ 0
RX_RPI
Wire Wire Line
	5400 4650 5200 4650
Wire Wire Line
	5200 4750 5400 4750
Wire Wire Line
	8450 2150 8950 2150
Wire Wire Line
	8450 2300 8950 2300
Wire Wire Line
	8950 2300 8950 2250
Wire Wire Line
	7700 3500 8950 3500
Wire Wire Line
	7700 3600 8950 3600
Wire Wire Line
	7700 3700 8950 3700
Wire Wire Line
	7700 3800 8950 3800
Wire Wire Line
	7700 3900 8950 3900
Wire Wire Line
	8750 4100 8950 4100
Wire Wire Line
	8750 4200 8950 4200
Wire Wire Line
	8950 4300 8750 4300
Wire Wire Line
	8750 4400 8950 4400
Wire Wire Line
	8950 4500 8750 4500
Wire Wire Line
	8650 5000 8950 5000
Wire Wire Line
	8950 5000 8950 4900
Wire Wire Line
	8650 4850 8800 4850
Wire Wire Line
	8800 4850 8800 4800
Wire Wire Line
	8800 4800 8950 4800
Wire Wire Line
	8650 4700 8950 4700
$Comp
L GND #PWR02
U 1 1 5CC4A0E2
P 8900 5100
F 0 "#PWR02" H 8900 4850 50  0001 C CNN
F 1 "GND" H 8900 4950 50  0000 C CNN
F 2 "" H 8900 5100 50  0001 C CNN
F 3 "" H 8900 5100 50  0001 C CNN
	1    8900 5100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 5CC4A1C5
P 8900 4550
F 0 "#PWR03" H 8900 4300 50  0001 C CNN
F 1 "GND" H 8900 4400 50  0000 C CNN
F 2 "" H 8900 4550 50  0001 C CNN
F 3 "" H 8900 4550 50  0001 C CNN
	1    8900 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 5CC4A22A
P 8850 3350
F 0 "#PWR04" H 8850 3100 50  0001 C CNN
F 1 "GND" H 8700 3300 50  0000 C CNN
F 2 "" H 8850 3350 50  0001 C CNN
F 3 "" H 8850 3350 50  0001 C CNN
	1    8850 3350
	-1   0    0    1   
$EndComp
Wire Wire Line
	8900 4550 8900 4500
Connection ~ 8900 4500
Wire Wire Line
	8900 5000 8900 5100
Connection ~ 8900 5000
$Comp
L R R6
U 1 1 5CD0647D
P 6650 3400
F 0 "R6" V 6730 3400 50  0000 C CNN
F 1 "R" V 6650 3400 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6580 3400 50  0001 C CNN
F 3 "" H 6650 3400 50  0001 C CNN
	1    6650 3400
	1    0    0    -1  
$EndComp
$Comp
L R R8
U 1 1 5CD06528
P 6800 3400
F 0 "R8" V 6880 3400 50  0000 C CNN
F 1 "R" V 6800 3400 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6730 3400 50  0001 C CNN
F 3 "" H 6800 3400 50  0001 C CNN
	1    6800 3400
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 5CD0659C
P 6500 3400
F 0 "R4" V 6580 3400 50  0000 C CNN
F 1 "R" V 6500 3400 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6430 3400 50  0001 C CNN
F 3 "" H 6500 3400 50  0001 C CNN
	1    6500 3400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5CD065D5
P 6350 3400
F 0 "R2" V 6430 3400 50  0000 C CNN
F 1 "R" V 6350 3400 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6280 3400 50  0001 C CNN
F 3 "" H 6350 3400 50  0001 C CNN
	1    6350 3400
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x05 J6
U 1 1 5CD0689F
P 6050 2600
F 0 "J6" H 6050 2900 50  0000 C CNN
F 1 "Conn_01x05" V 6150 2550 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 6050 2600 50  0001 C CNN
F 3 "" H 6050 2600 50  0001 C CNN
	1    6050 2600
	-1   0    0    1   
$EndComp
Wire Wire Line
	6250 2500 8950 2500
Wire Wire Line
	6250 2600 8950 2600
Wire Wire Line
	6250 2700 8950 2700
Wire Wire Line
	6250 2800 8950 2800
Text GLabel 8800 4000 0    60   Input ~ 0
VCC(3.3V)
Wire Wire Line
	8800 4000 8850 4000
Wire Wire Line
	8850 4000 8850 3900
Connection ~ 8850 3900
Text GLabel 7900 2400 2    60   Input ~ 0
VCC(3.3V)
Wire Wire Line
	6250 2400 7900 2400
$Comp
L GND #PWR05
U 1 1 5CD06F55
P 6650 3700
F 0 "#PWR05" H 6650 3450 50  0001 C CNN
F 1 "GND" H 6650 3550 50  0000 C CNN
F 2 "" H 6650 3700 50  0001 C CNN
F 3 "" H 6650 3700 50  0001 C CNN
	1    6650 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	8950 3400 8850 3400
Wire Wire Line
	8850 3400 8850 3350
$Comp
L Conn_01x05 J5
U 1 1 5CD076D3
P 7500 3700
F 0 "J5" H 7500 4000 50  0000 C CNN
F 1 "Conn_01x05" H 7500 3400 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 7500 3700 50  0001 C CNN
F 3 "" H 7500 3700 50  0001 C CNN
	1    7500 3700
	-1   0    0    1   
$EndComp
$Comp
L R R1
U 1 1 5CD07780
P 7800 4200
F 0 "R1" V 7880 4200 50  0000 C CNN
F 1 "R" V 7800 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7730 4200 50  0001 C CNN
F 3 "" H 7800 4200 50  0001 C CNN
	1    7800 4200
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 5CD077CD
P 7950 4200
F 0 "R3" V 8030 4200 50  0000 C CNN
F 1 "R" V 7950 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7880 4200 50  0001 C CNN
F 3 "" H 7950 4200 50  0001 C CNN
	1    7950 4200
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 5CD07804
P 8100 4200
F 0 "R5" V 8180 4200 50  0000 C CNN
F 1 "R" V 8100 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 8030 4200 50  0001 C CNN
F 3 "" H 8100 4200 50  0001 C CNN
	1    8100 4200
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 5CD07841
P 8250 4200
F 0 "R7" V 8330 4200 50  0000 C CNN
F 1 "R" V 8250 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 8180 4200 50  0001 C CNN
F 3 "" H 8250 4200 50  0001 C CNN
	1    8250 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 4050 8250 3500
Wire Wire Line
	8100 4050 8100 3600
Wire Wire Line
	7950 4050 7950 3700
Wire Wire Line
	7800 3800 7800 4050
Connection ~ 7800 3800
Connection ~ 7950 3700
Connection ~ 8100 3600
Connection ~ 8250 3500
$Comp
L GND #PWR06
U 1 1 5CD07CF1
P 7600 4400
F 0 "#PWR06" H 7600 4150 50  0001 C CNN
F 1 "GND" H 7600 4250 50  0000 C CNN
F 2 "" H 7600 4400 50  0001 C CNN
F 3 "" H 7600 4400 50  0001 C CNN
	1    7600 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 4400 7600 4350
Wire Wire Line
	7600 4350 8250 4350
Connection ~ 7800 4350
Connection ~ 7950 4350
Connection ~ 8100 4350
$Comp
L Carte_Temperature U3
U 1 1 5CD94AF0
P 1750 2050
F 0 "U3" H 2600 2150 60  0000 C CNN
F 1 "Carte_Temperature" H 2050 2150 60  0000 C CNN
F 2 "Carte Mere:Carte_Temperature" H 1800 1850 60  0001 C CNN
F 3 "" H 1800 1850 60  0001 C CNN
	1    1750 2050
	-1   0    0    -1  
$EndComp
$Comp
L Conn_01x03_Male J13
U 1 1 5CD95038
P 2250 5600
F 0 "J13" H 2150 5600 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2250 5400 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 5600 50  0001 C CNN
F 3 "" H 2250 5600 50  0001 C CNN
	1    2250 5600
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x03_Male J12
U 1 1 5CD9514B
P 2250 5250
F 0 "J12" H 2150 5250 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2250 5050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 5250 50  0001 C CNN
F 3 "" H 2250 5250 50  0001 C CNN
	1    2250 5250
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x03_Male J11
U 1 1 5CD95214
P 2250 4900
F 0 "J11" H 2150 4900 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2250 4700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 4900 50  0001 C CNN
F 3 "" H 2250 4900 50  0001 C CNN
	1    2250 4900
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x03_Male J10
U 1 1 5CD95278
P 2250 4550
F 0 "J10" H 2150 4550 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2250 4350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 4550 50  0001 C CNN
F 3 "" H 2250 4550 50  0001 C CNN
	1    2250 4550
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x03_Male J9
U 1 1 5CD95351
P 2250 4200
F 0 "J9" H 2100 4150 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2250 4000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 4200 50  0001 C CNN
F 3 "" H 2250 4200 50  0001 C CNN
	1    2250 4200
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x03_Male J8
U 1 1 5CD95402
P 2250 3850
F 0 "J8" H 2100 3800 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2250 3650 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 3850 50  0001 C CNN
F 3 "" H 2250 3850 50  0001 C CNN
	1    2250 3850
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x03_Male J4
U 1 1 5CD954B1
P 2250 3500
F 0 "J4" H 2100 3550 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2250 3300 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 3500 50  0001 C CNN
F 3 "" H 2250 3500 50  0001 C CNN
	1    2250 3500
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x03_Male J2
U 1 1 5CD95581
P 2250 3150
F 0 "J2" H 2100 3150 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2250 2950 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2250 3150 50  0001 C CNN
F 3 "" H 2250 3150 50  0001 C CNN
	1    2250 3150
	-1   0    0    1   
$EndComp
Text GLabel 8750 1950 0    60   Input ~ 0
TX1_Master
Text GLabel 8750 2050 0    60   Input ~ 0
RX1_Master
Wire Wire Line
	8750 1950 8950 1950
Wire Wire Line
	8750 2050 8950 2050
Text GLabel 2050 2550 2    60   Input ~ 0
TX1_Master
Wire Wire Line
	2050 2550 1950 2550
Text GLabel 2050 2450 2    60   Input ~ 0
RX1_Master
Wire Wire Line
	2050 2450 1950 2450
$Comp
L R R9
U 1 1 5CD96A28
P 2650 3100
F 0 "R9" V 2730 3100 50  0000 C CNN
F 1 "R" V 2650 3100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 2580 3100 50  0001 C CNN
F 3 "" H 2650 3100 50  0001 C CNN
	1    2650 3100
	1    0    0    -1  
$EndComp
$Comp
L R R10
U 1 1 5CD96AA5
P 2800 3100
F 0 "R10" V 2880 3100 50  0000 C CNN
F 1 "R" V 2800 3100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 2730 3100 50  0001 C CNN
F 3 "" H 2800 3100 50  0001 C CNN
	1    2800 3100
	1    0    0    -1  
$EndComp
$Comp
L R R11
U 1 1 5CD96AF4
P 2950 3100
F 0 "R11" V 3030 3100 50  0000 C CNN
F 1 "R" V 2950 3100 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 2880 3100 50  0001 C CNN
F 3 "" H 2950 3100 50  0001 C CNN
	1    2950 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 2900 2700 2900
Wire Wire Line
	2650 2900 2650 2950
Wire Wire Line
	1950 2800 2800 2800
Wire Wire Line
	2800 2550 2800 2950
Wire Wire Line
	1950 2700 2950 2700
Wire Wire Line
	2950 2700 2950 2950
Wire Wire Line
	2650 3250 2950 3250
Connection ~ 2800 3250
$Comp
L GND #PWR07
U 1 1 5CD96EF7
P 2800 3350
F 0 "#PWR07" H 2800 3100 50  0001 C CNN
F 1 "GND" H 2800 3200 50  0000 C CNN
F 2 "" H 2800 3350 50  0001 C CNN
F 3 "" H 2800 3350 50  0001 C CNN
	1    2800 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 3250 2800 3350
$Comp
L Conn_01x03_Male J14
U 1 1 5CD970FC
P 2800 2350
F 0 "J14" H 2800 2550 50  0000 C CNN
F 1 "Conn_01x03_Male" H 2700 2550 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 2800 2350 50  0001 C CNN
F 3 "" H 2800 2350 50  0001 C CNN
	1    2800 2350
	0    1    1    0   
$EndComp
Wire Wire Line
	2900 2550 2900 2700
Connection ~ 2900 2700
Connection ~ 2800 2800
Wire Wire Line
	2700 2900 2700 2550
Connection ~ 2650 2900
Wire Wire Line
	2850 1200 3000 1200
$Comp
L GND #PWR08
U 1 1 5CD97E02
P 1900 1350
F 0 "#PWR08" H 1900 1100 50  0001 C CNN
F 1 "GND" H 1900 1200 50  0000 C CNN
F 2 "" H 1900 1350 50  0001 C CNN
F 3 "" H 1900 1350 50  0001 C CNN
	1    1900 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 1350 1900 1300
$Comp
L GND #PWR09
U 1 1 5CD97F0D
P 2900 1350
F 0 "#PWR09" H 2900 1100 50  0001 C CNN
F 1 "GND" H 2900 1200 50  0000 C CNN
F 2 "" H 2900 1350 50  0001 C CNN
F 3 "" H 2900 1350 50  0001 C CNN
	1    2900 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 1300 2900 1300
Wire Wire Line
	2900 1300 2900 1350
$Comp
L GND #PWR010
U 1 1 5CD9827B
P 2000 2000
F 0 "#PWR010" H 2000 1750 50  0001 C CNN
F 1 "GND" H 2000 1850 50  0000 C CNN
F 2 "" H 2000 2000 50  0001 C CNN
F 3 "" H 2000 2000 50  0001 C CNN
	1    2000 2000
	-1   0    0    1   
$EndComp
Wire Wire Line
	2000 2000 2000 2100
Wire Wire Line
	2000 2100 1950 2100
Text GLabel 2050 2200 2    60   Input ~ 0
VCC(5V)
Wire Wire Line
	2050 2200 1950 2200
Text GLabel 2050 2300 2    60   Input ~ 0
VCC(12V)
Wire Wire Line
	2050 2300 1950 2300
Text GLabel 4100 1750 1    60   Input ~ 0
VCC(5V)
Wire Wire Line
	4100 1750 4100 1900
$Comp
L Jack-DC J1
U 1 1 5CD98A79
P 900 1300
F 0 "J1" H 900 1510 50  0000 C CNN
F 1 "Jack-DC" H 900 1125 50  0000 C CNN
F 2 "Carte Mere:JACK_ALIM" H 950 1260 50  0001 C CNN
F 3 "" H 950 1260 50  0001 C CNN
	1    900  1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 1300 1200 1400
Connection ~ 1900 1300
Wire Wire Line
	1700 1100 1700 1200
Connection ~ 1700 1200
Wire Wire Line
	2050 3050 1950 3050
Wire Wire Line
	1950 3150 2050 3150
Wire Wire Line
	2050 3250 1950 3250
Wire Wire Line
	1950 3400 2050 3400
Wire Wire Line
	2050 3500 1950 3500
Wire Wire Line
	1950 3600 2050 3600
Wire Wire Line
	2050 3750 1950 3750
Wire Wire Line
	2050 3850 1950 3850
Wire Wire Line
	1950 3950 2050 3950
Wire Wire Line
	2050 4100 1950 4100
Wire Wire Line
	1950 4200 2050 4200
Wire Wire Line
	2050 4300 1950 4300
Wire Wire Line
	2050 4450 1950 4450
Wire Wire Line
	1950 4550 2050 4550
Wire Wire Line
	2050 4650 1950 4650
Wire Wire Line
	1950 4800 2050 4800
Wire Wire Line
	2050 4900 1950 4900
Wire Wire Line
	1950 5000 2050 5000
Wire Wire Line
	2050 5150 1950 5150
Wire Wire Line
	1950 5250 2050 5250
Wire Wire Line
	2050 5350 1950 5350
Wire Wire Line
	1950 5500 2050 5500
Wire Wire Line
	2050 5600 1950 5600
Wire Wire Line
	1950 5700 2050 5700
$Comp
L R R12
U 1 1 5CD9B0A4
P 6950 3400
F 0 "R12" V 7030 3400 50  0000 C CNN
F 1 "R" V 6950 3400 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6880 3400 50  0001 C CNN
F 3 "" H 6950 3400 50  0001 C CNN
	1    6950 3400
	1    0    0    -1  
$EndComp
$Comp
L R R13
U 1 1 5CD9B15F
P 7100 3400
F 0 "R13" V 7180 3400 50  0000 C CNN
F 1 "R" V 7100 3400 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 7030 3400 50  0001 C CNN
F 3 "" H 7100 3400 50  0001 C CNN
	1    7100 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 3250 6350 2500
Connection ~ 6350 2500
Wire Wire Line
	6500 3250 6500 2600
Connection ~ 6500 2600
Wire Wire Line
	6650 3250 6650 2700
Connection ~ 6650 2700
Wire Wire Line
	6800 3250 6800 2800
Connection ~ 6800 2800
$Comp
L Conn_01x02 J15
U 1 1 5CD9C199
P 6050 3050
F 0 "J15" H 6050 3150 50  0000 C CNN
F 1 "Conn_01x02" V 6200 3000 50  0000 C CNN
F 2 "Carte Mere:Pin_alimentation" H 6050 3050 50  0001 C CNN
F 3 "" H 6050 3050 50  0001 C CNN
	1    6050 3050
	-1   0    0    1   
$EndComp
Wire Wire Line
	6250 2950 8400 2950
Wire Wire Line
	8400 2950 8400 2900
Wire Wire Line
	8400 2900 8950 2900
Wire Wire Line
	8950 3000 8400 3000
Wire Wire Line
	8400 3000 8400 3050
Wire Wire Line
	8400 3050 6250 3050
Wire Wire Line
	6950 3250 6950 2950
Connection ~ 6950 2950
Wire Wire Line
	7100 3250 7100 3050
Connection ~ 7100 3050
Wire Wire Line
	6650 3550 6650 3700
Wire Wire Line
	6350 3550 7100 3550
Connection ~ 6500 3550
Connection ~ 6650 3550
Connection ~ 6800 3550
Connection ~ 6950 3550
$Comp
L Conn_01x01 J16
U 1 1 5CD9D5F0
P 8050 3150
F 0 "J16" H 8050 3250 50  0000 C CNN
F 1 "Conn_01x01" H 8050 3050 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 8050 3150 50  0001 C CNN
F 3 "" H 8050 3150 50  0001 C CNN
	1    8050 3150
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x01 J17
U 1 1 5CD9D695
P 8050 3300
F 0 "J17" H 8050 3400 50  0000 C CNN
F 1 "Conn_01x01" H 8050 3200 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 8050 3300 50  0001 C CNN
F 3 "" H 8050 3300 50  0001 C CNN
	1    8050 3300
	-1   0    0    1   
$EndComp
Wire Wire Line
	8950 3100 8250 3100
Wire Wire Line
	8250 3100 8250 3150
Wire Wire Line
	8250 3300 8600 3300
Wire Wire Line
	8600 3300 8600 3200
Wire Wire Line
	8600 3200 8950 3200
Wire Wire Line
	1200 1300 1950 1300
Wire Wire Line
	1200 1200 1950 1200
$Comp
L LM2576 U2
U 1 1 5CD982C8
P 2400 1050
F 0 "U2" H 2600 1000 60  0000 C CNN
F 1 "LM2576" H 2300 1000 60  0000 C CNN
F 2 "Carte Mere:Alimentation_V2" H 2400 1050 60  0001 C CNN
F 3 "" H 2400 1050 60  0001 C CNN
	1    2400 1050
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x04_Male J18
U 1 1 5CD99663
P 5500 2250
F 0 "J18" H 5500 2450 50  0000 C CNN
F 1 "Conn_01x04_Male" H 5500 1950 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 5500 2250 50  0001 C CNN
F 3 "" H 5500 2250 50  0001 C CNN
	1    5500 2250
	0    1    1    0   
$EndComp
$Comp
L GND #PWR011
U 1 1 5CD99888
P 5600 2550
F 0 "#PWR011" H 5600 2300 50  0001 C CNN
F 1 "GND" H 5600 2400 50  0000 C CNN
F 2 "" H 5600 2550 50  0001 C CNN
F 3 "" H 5600 2550 50  0001 C CNN
	1    5600 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 2550 5600 2450
Wire Wire Line
	5400 2450 5400 3050
Wire Wire Line
	5400 3050 5200 3050
Wire Wire Line
	5500 2450 5500 3150
Wire Wire Line
	5500 3150 5200 3150
Wire Wire Line
	5300 2450 5300 2550
Wire Wire Line
	5300 2550 4100 2550
Connection ~ 4100 2550
$Comp
L C C1
U 1 1 5CDA694C
P 4600 2300
F 0 "C1" H 4625 2400 50  0000 L CNN
F 1 "C" H 4625 2200 50  0000 L CNN
F 2 "Capacitors_THT:CP_Radial_D5.0mm_P2.00mm" H 4638 2150 50  0001 C CNN
F 3 "" H 4600 2300 50  0001 C CNN
	1    4600 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 2450 4600 2550
Connection ~ 4600 2550
$Comp
L GND #PWR012
U 1 1 5CDA6B4C
P 4850 2200
F 0 "#PWR012" H 4850 1950 50  0001 C CNN
F 1 "GND" H 4850 2050 50  0000 C CNN
F 2 "" H 4850 2200 50  0001 C CNN
F 3 "" H 4850 2200 50  0001 C CNN
	1    4850 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 2150 4850 2150
Wire Wire Line
	4850 2150 4850 2200
$Comp
L Conn_01x01 J21
U 1 1 5CDAD7CD
P 5300 5000
F 0 "J21" H 5300 5100 50  0000 C CNN
F 1 "Conn_01x01" H 5300 4900 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 5300 5000 50  0001 C CNN
F 3 "" H 5300 5000 50  0001 C CNN
	1    5300 5000
	0    1    1    0   
$EndComp
$Comp
L Conn_01x01 J22
U 1 1 5CDADC65
P 5350 4300
F 0 "J22" H 5350 4400 50  0000 C CNN
F 1 "Conn_01x01" H 5350 4200 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 5350 4300 50  0001 C CNN
F 3 "" H 5350 4300 50  0001 C CNN
	1    5350 4300
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J23
U 1 1 5CDADD7E
P 8750 1500
F 0 "J23" H 8750 1600 50  0000 C CNN
F 1 "Conn_01x01" H 8750 1400 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 8750 1500 50  0001 C CNN
F 3 "" H 8750 1500 50  0001 C CNN
	1    8750 1500
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J24
U 1 1 5CDADE01
P 9000 1500
F 0 "J24" H 9000 1600 50  0000 C CNN
F 1 "Conn_01x01" H 9000 1400 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 9000 1500 50  0001 C CNN
F 3 "" H 9000 1500 50  0001 C CNN
	1    9000 1500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8750 1700 8750 1950
Wire Wire Line
	9000 1700 9000 1850
Wire Wire Line
	9000 1850 8950 1850
Wire Wire Line
	8950 1850 8950 2050
Wire Wire Line
	5350 4500 5350 4600
Wire Wire Line
	5350 4600 5300 4600
Wire Wire Line
	5300 4600 5300 4650
Connection ~ 5300 4650
Wire Wire Line
	5300 4800 5300 4750
Connection ~ 5300 4750
$Comp
L Conn_01x01 J19
U 1 1 5CDAE732
P 1500 950
F 0 "J19" H 1500 1050 50  0000 C CNN
F 1 "Conn_01x01" H 1500 850 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 1500 950 50  0001 C CNN
F 3 "" H 1500 950 50  0001 C CNN
	1    1500 950 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1500 1150 1500 1200
Connection ~ 1500 1200
$Comp
L Conn_01x01 J20
U 1 1 5CDAE9A0
P 3150 1000
F 0 "J20" H 3150 1100 50  0000 C CNN
F 1 "Conn_01x01" H 3150 900 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 3150 1000 50  0001 C CNN
F 3 "" H 3150 1000 50  0001 C CNN
	1    3150 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 1000 2900 1000
Wire Wire Line
	2900 1000 2900 1200
Connection ~ 2900 1200
$Comp
L Conn_01x01 J25
U 1 1 5CDAF166
P 4650 5400
F 0 "J25" H 4650 5500 50  0000 C CNN
F 1 "Conn_01x01" H 4650 5300 50  0000 C CNN
F 2 "Carte Mere:TSC_CON1_poignard" H 4650 5400 50  0001 C CNN
F 3 "" H 4650 5400 50  0001 C CNN
	1    4650 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 5400 4350 5400
Wire Wire Line
	4350 5400 4350 5250
Connection ~ 4350 5250
$EndSCHEMATC
