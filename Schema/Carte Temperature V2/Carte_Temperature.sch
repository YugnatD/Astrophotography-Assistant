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
LIBS:Carte_Temperature
LIBS:Carte_Temperature-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title "Carte Temperature"
Date "2019-06-09"
Rev "2"
Comp "CFPT Electronique"
Comment1 "Tanguy Dietrich"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 4350 2050 1000 2150
U 5CCEA650
F0 "C8051F38C" 60
F1 "C8051F38C.sch" 60
F2 "VCC(5V)" I L 4350 2100 60 
F3 "VDD(3.3V)" O L 4350 2200 60 
F4 "P0.0" B R 5350 2250 60 
F5 "P0.1" B R 5350 2350 60 
F6 "P0.2" B R 5350 2450 60 
F7 "P0.3" B R 5350 2550 60 
F8 "P0.4" B R 5350 2650 60 
F9 "P0.5" B R 5350 2750 60 
F10 "P0.6" B R 5350 2850 60 
F11 "P0.7" B R 5350 2950 60 
F12 "P1.0" B L 4350 2350 60 
F13 "P1.1" B L 4350 2450 60 
F14 "P1.2" B L 4350 2550 60 
F15 "P1.3" B L 4350 2650 60 
F16 "P1.4" B L 4350 2750 60 
F17 "P1.5" B L 4350 2850 60 
F18 "P1.6" B L 4350 2950 60 
F19 "P1.7" B L 4350 3050 60 
F20 "P2.0" B R 5350 3200 60 
F21 "P2.1" B R 5350 3300 60 
F22 "P2.2" B R 5350 3400 60 
F23 "P2.3" B R 5350 3500 60 
F24 "P2.4" B R 5350 3600 60 
F25 "P2.5" B R 5350 3700 60 
F26 "P2.6" B R 5350 3800 60 
F27 "P2.7" B R 5350 3900 60 
F28 "GND" I L 4350 4150 60 
$EndSheet
$Comp
L Conn_01x03 J1
U 1 1 5CCF747D
P 1000 2250
F 0 "J1" H 1000 2450 50  0000 C CNN
F 1 "Conn_01x03" H 1000 2050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 1000 2250 50  0001 C CNN
F 3 "" H 1000 2250 50  0001 C CNN
	1    1000 2250
	-1   0    0    1   
$EndComp
Text GLabel 4250 4150 0    60   Input ~ 0
GND
Text GLabel 4350 2100 0    60   Input ~ 0
VCC(5V)
Text GLabel 4350 2200 0    60   Input ~ 0
VDD(3.3V)
Text GLabel 6800 1550 0    60   Input ~ 0
VCC(5V)
Text GLabel 6900 1350 1    60   Input ~ 0
GND
$Comp
L Conn_01x03 J5
U 1 1 5CCFC72B
P 10650 2800
F 0 "J5" H 10650 3000 50  0000 C CNN
F 1 "Conn_01x03" H 10650 2600 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 10650 2800 50  0001 C CNN
F 3 "" H 10650 2800 50  0001 C CNN
	1    10650 2800
	1    0    0    -1  
$EndComp
Text GLabel 10450 2700 0    60   Input ~ 0
VDD(3.3V)
Text GLabel 10450 2800 0    60   Input ~ 0
GND
$Comp
L Conn_01x03 J6
U 1 1 5CCFC733
P 10650 2300
F 0 "J6" H 10650 2500 50  0000 C CNN
F 1 "Conn_01x03" H 10650 2100 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 10650 2300 50  0001 C CNN
F 3 "" H 10650 2300 50  0001 C CNN
	1    10650 2300
	1    0    0    -1  
$EndComp
Text GLabel 10450 2200 0    60   Input ~ 0
VDD(3.3V)
Text GLabel 10450 2300 0    60   Input ~ 0
GND
$Comp
L Conn_01x03 J7
U 1 1 5CCFC73B
P 10650 1800
F 0 "J7" H 10650 2000 50  0000 C CNN
F 1 "Conn_01x03" H 10650 1600 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 10650 1800 50  0001 C CNN
F 3 "" H 10650 1800 50  0001 C CNN
	1    10650 1800
	1    0    0    -1  
$EndComp
Text GLabel 10450 1700 0    60   Input ~ 0
VDD(3.3V)
Text GLabel 10450 1800 0    60   Input ~ 0
GND
$Comp
L Conn_01x03 J8
U 1 1 5CCFC743
P 10650 1300
F 0 "J8" H 10650 1500 50  0000 C CNN
F 1 "Conn_01x03" H 10650 1100 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 10650 1300 50  0001 C CNN
F 3 "" H 10650 1300 50  0001 C CNN
	1    10650 1300
	1    0    0    -1  
$EndComp
Text GLabel 10450 1200 0    60   Input ~ 0
VDD(3.3V)
Text GLabel 10450 1300 0    60   Input ~ 0
GND
$Comp
L Conn_01x02 J10
U 1 1 5CD04C15
P 5700 2650
F 0 "J10" H 5700 2750 50  0000 C CNN
F 1 "Conn_01x02" V 5850 2650 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 5700 2650 50  0001 C CNN
F 3 "" H 5700 2650 50  0001 C CNN
	1    5700 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 2650 5350 2650
Wire Wire Line
	5500 2750 5350 2750
$Comp
L Conn_01x03 J9
U 1 1 5CD04F09
P 5700 2350
F 0 "J9" H 5700 2550 50  0000 C CNN
F 1 "Conn_01x03" V 5800 2400 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 5700 2350 50  0001 C CNN
F 3 "" H 5700 2350 50  0001 C CNN
	1    5700 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 2250 5350 2250
Wire Wire Line
	5500 2350 5350 2350
Wire Wire Line
	5500 2450 5350 2450
$Comp
L Conn_01x01 J11
U 1 1 5CD05D61
P 6150 2550
F 0 "J11" H 6150 2650 50  0000 C CNN
F 1 "Conn_01x01" H 6100 2750 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 6150 2550 50  0001 C CNN
F 3 "" H 6150 2550 50  0001 C CNN
	1    6150 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 2550 5350 2550
$Sheet
S 6850 2700 750  550 
U 5CD061A5
F0 "EEH210" 60
F1 "EEH210.sch" 60
F2 "VDD(3.3V)" I L 6850 2800 60 
F3 "GND" I L 6850 3100 60 
F4 "SDA" I L 6850 2900 60 
F5 "SCL" I L 6850 3000 60 
$EndSheet
Text GLabel 6750 2400 2    60   Input ~ 0
VDD(3.3V)
Text GLabel 6650 3100 0    60   Input ~ 0
GND
Wire Wire Line
	6650 3100 6850 3100
Wire Wire Line
	6850 2900 5600 2900
Wire Wire Line
	5600 2900 5600 2850
Wire Wire Line
	5600 2850 5350 2850
Wire Wire Line
	6850 3000 5550 3000
Wire Wire Line
	5550 3000 5550 2950
Wire Wire Line
	5550 2950 5350 2950
$Comp
L Conn_01x03 J13
U 1 1 5CD0A9A7
P 7100 1550
F 0 "J13" H 7100 1750 50  0000 C CNN
F 1 "Conn_01x03" H 7100 1350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 7100 1550 50  0001 C CNN
F 3 "" H 7100 1550 50  0001 C CNN
	1    7100 1550
	1    0    0    -1  
$EndComp
Text GLabel 6800 1750 0    60   Input ~ 0
V(12V)
$Comp
L D D1
U 1 1 5CD3D216
P 1850 2400
F 0 "D1" H 1850 2500 50  0000 C CNN
F 1 "D" H 1850 2300 50  0000 C CNN
F 2 "Diodes_THT:D_DO-15_P10.16mm_Horizontal" H 1850 2400 50  0001 C CNN
F 3 "" H 1850 2400 50  0001 C CNN
	1    1850 2400
	0    -1   -1   0   
$EndComp
$Comp
L R R1
U 1 1 5CD3D51C
P 2000 2300
F 0 "R1" V 2080 2300 50  0000 C CNN
F 1 "18k" V 2000 2300 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1930 2300 50  0001 C CNN
F 3 "" H 2000 2300 50  0001 C CNN
	1    2000 2300
	1    0    0    -1  
$EndComp
$Comp
L IRL3705 Q2
U 1 1 5CD3DD22
P 9300 5650
F 0 "Q2" H 9500 5725 50  0000 L CNN
F 1 "IRL3705" H 9500 5650 50  0000 L CNN
F 2 "Carte_Temperature:TO254P1052X465X1989-3-IRL3705" H 9500 5550 50  0001 L CIN
F 3 "" H 9300 5650 50  0001 L CNN
	1    9300 5650
	1    0    0    -1  
$EndComp
$Comp
L RCJ-041 J19
U 1 1 5CD3F187
P 9600 5200
F 0 "J19" H 9378 5361 50  0000 L BNN
F 1 "RCJ-041" H 9399 4978 50  0000 L BNN
F 2 "Carte_Temperature:CUI_RCJ-041_Graveuse" H 9400 5400 50  0001 L BNN
F 3 "RCJ-041" H 9400 4950 50  0001 L BNN
	1    9600 5200
	-1   0    0    1   
$EndComp
Text GLabel 5350 3600 2    60   Input ~ 0
PCA0
Text GLabel 5350 3700 2    60   Input ~ 0
PCA1
Text GLabel 5350 3800 2    60   Input ~ 0
PCA2
Text GLabel 5350 3900 2    60   Input ~ 0
PCA3
$Comp
L GND #PWR01
U 1 1 5CD41741
P 4300 4300
F 0 "#PWR01" H 4300 4050 50  0001 C CNN
F 1 "GND" H 4300 4150 50  0000 C CNN
F 2 "" H 4300 4300 50  0001 C CNN
F 3 "" H 4300 4300 50  0001 C CNN
	1    4300 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 4150 4350 4150
Wire Wire Line
	4300 4150 4300 4300
Connection ~ 4300 4150
Wire Wire Line
	9400 5300 9400 5450
Text GLabel 9400 5000 0    60   Input ~ 0
V(12V)
Wire Wire Line
	9400 5000 9400 5100
$Comp
L GND #PWR02
U 1 1 5CD42AF3
P 9400 5950
F 0 "#PWR02" H 9400 5700 50  0001 C CNN
F 1 "GND" H 9400 5800 50  0000 C CNN
F 2 "" H 9400 5950 50  0001 C CNN
F 3 "" H 9400 5950 50  0001 C CNN
	1    9400 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 5850 9400 5950
Text GLabel 9000 5650 0    60   Input ~ 0
PCA0
Text GLabel 10150 5650 0    60   Input ~ 0
PCA1
Text GLabel 9000 4100 0    60   Input ~ 0
PCA2
Text GLabel 10150 4100 0    60   Input ~ 0
PCA3
Wire Wire Line
	9000 5650 9100 5650
$Comp
L Conn_01x01 J15
U 1 1 5CD43EE0
P 9050 5900
F 0 "J15" H 9050 6000 50  0000 C CNN
F 1 "Conn_01x01" H 9050 5800 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 9050 5900 50  0001 C CNN
F 3 "" H 9050 5900 50  0001 C CNN
	1    9050 5900
	0    1    1    0   
$EndComp
$Comp
L Conn_01x01 J17
U 1 1 5CD440C3
P 9150 5400
F 0 "J17" H 9150 5500 50  0000 C CNN
F 1 "Conn_01x01" H 9150 5300 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 9150 5400 50  0001 C CNN
F 3 "" H 9150 5400 50  0001 C CNN
	1    9150 5400
	-1   0    0    1   
$EndComp
Wire Wire Line
	9350 5400 9400 5400
Connection ~ 9400 5400
Wire Wire Line
	9050 5700 9050 5650
Connection ~ 9050 5650
$Comp
L IRL3705 Q4
U 1 1 5CD4503C
P 10450 5650
F 0 "Q4" H 10650 5725 50  0000 L CNN
F 1 "IRL3705" H 10650 5650 50  0000 L CNN
F 2 "Carte_Temperature:TO254P1052X465X1989-3-IRL3705" H 10650 5550 50  0001 L CIN
F 3 "" H 10450 5650 50  0001 L CNN
	1    10450 5650
	1    0    0    -1  
$EndComp
$Comp
L RCJ-041 J25
U 1 1 5CD45042
P 10750 5200
F 0 "J25" H 10528 5361 50  0000 L BNN
F 1 "RCJ-041" H 10549 4978 50  0000 L BNN
F 2 "Carte_Temperature:CUI_RCJ-041_Graveuse" H 10550 5400 50  0001 L BNN
F 3 "RCJ-041" H 10550 4950 50  0001 L BNN
	1    10750 5200
	-1   0    0    1   
$EndComp
Wire Wire Line
	10550 5300 10550 5450
Text GLabel 10550 5000 0    60   Input ~ 0
V(12V)
Wire Wire Line
	10550 5000 10550 5100
$Comp
L GND #PWR03
U 1 1 5CD4504B
P 10550 5950
F 0 "#PWR03" H 10550 5700 50  0001 C CNN
F 1 "GND" H 10550 5800 50  0000 C CNN
F 2 "" H 10550 5950 50  0001 C CNN
F 3 "" H 10550 5950 50  0001 C CNN
	1    10550 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	10550 5850 10550 5950
Wire Wire Line
	10150 5650 10250 5650
$Comp
L Conn_01x01 J21
U 1 1 5CD45053
P 10200 5900
F 0 "J21" H 10200 6000 50  0000 C CNN
F 1 "Conn_01x01" H 10200 5800 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 10200 5900 50  0001 C CNN
F 3 "" H 10200 5900 50  0001 C CNN
	1    10200 5900
	0    1    1    0   
$EndComp
$Comp
L Conn_01x01 J23
U 1 1 5CD45059
P 10300 5400
F 0 "J23" H 10300 5500 50  0000 C CNN
F 1 "Conn_01x01" H 10300 5300 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 10300 5400 50  0001 C CNN
F 3 "" H 10300 5400 50  0001 C CNN
	1    10300 5400
	-1   0    0    1   
$EndComp
Wire Wire Line
	10500 5400 10550 5400
Connection ~ 10550 5400
Wire Wire Line
	10200 5700 10200 5650
Connection ~ 10200 5650
$Comp
L IRL3705 Q1
U 1 1 5CD4540F
P 9300 4100
F 0 "Q1" H 9500 4175 50  0000 L CNN
F 1 "IRL3705" H 9500 4100 50  0000 L CNN
F 2 "Carte_Temperature:TO254P1052X465X1989-3-IRL3705" H 9500 4000 50  0001 L CIN
F 3 "" H 9300 4100 50  0001 L CNN
	1    9300 4100
	1    0    0    -1  
$EndComp
$Comp
L RCJ-041 J18
U 1 1 5CD45415
P 9600 3650
F 0 "J18" H 9378 3811 50  0000 L BNN
F 1 "RCJ-041" H 9399 3428 50  0000 L BNN
F 2 "Carte_Temperature:CUI_RCJ-041_Graveuse" H 9400 3850 50  0001 L BNN
F 3 "RCJ-041" H 9400 3400 50  0001 L BNN
	1    9600 3650
	-1   0    0    1   
$EndComp
Wire Wire Line
	9400 3750 9400 3900
Text GLabel 9400 3450 0    60   Input ~ 0
V(12V)
Wire Wire Line
	9400 3450 9400 3550
$Comp
L GND #PWR04
U 1 1 5CD4541E
P 9400 4400
F 0 "#PWR04" H 9400 4150 50  0001 C CNN
F 1 "GND" H 9400 4250 50  0000 C CNN
F 2 "" H 9400 4400 50  0001 C CNN
F 3 "" H 9400 4400 50  0001 C CNN
	1    9400 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 4300 9400 4400
Wire Wire Line
	9000 4100 9100 4100
$Comp
L Conn_01x01 J14
U 1 1 5CD45426
P 9050 4350
F 0 "J14" H 9050 4450 50  0000 C CNN
F 1 "Conn_01x01" H 9050 4250 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 9050 4350 50  0001 C CNN
F 3 "" H 9050 4350 50  0001 C CNN
	1    9050 4350
	0    1    1    0   
$EndComp
$Comp
L Conn_01x01 J16
U 1 1 5CD4542C
P 9150 3850
F 0 "J16" H 9150 3950 50  0000 C CNN
F 1 "Conn_01x01" H 9150 3750 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 9150 3850 50  0001 C CNN
F 3 "" H 9150 3850 50  0001 C CNN
	1    9150 3850
	-1   0    0    1   
$EndComp
Wire Wire Line
	9350 3850 9400 3850
Connection ~ 9400 3850
Wire Wire Line
	9050 4150 9050 4100
Connection ~ 9050 4100
$Comp
L IRL3705 Q3
U 1 1 5CD45436
P 10450 4100
F 0 "Q3" H 10650 4175 50  0000 L CNN
F 1 "IRL3705" H 10650 4100 50  0000 L CNN
F 2 "Carte_Temperature:TO254P1052X465X1989-3-IRL3705" H 10650 4000 50  0001 L CIN
F 3 "" H 10450 4100 50  0001 L CNN
	1    10450 4100
	1    0    0    -1  
$EndComp
$Comp
L RCJ-041 J24
U 1 1 5CD4543C
P 10750 3650
F 0 "J24" H 10528 3811 50  0000 L BNN
F 1 "RCJ-041" H 10549 3428 50  0000 L BNN
F 2 "Carte_Temperature:CUI_RCJ-041_Graveuse" H 10550 3850 50  0001 L BNN
F 3 "RCJ-041" H 10550 3400 50  0001 L BNN
	1    10750 3650
	-1   0    0    1   
$EndComp
Wire Wire Line
	10550 3750 10550 3900
Text GLabel 10550 3450 0    60   Input ~ 0
V(12V)
Wire Wire Line
	10550 3450 10550 3550
$Comp
L GND #PWR05
U 1 1 5CD45445
P 10550 4400
F 0 "#PWR05" H 10550 4150 50  0001 C CNN
F 1 "GND" H 10550 4250 50  0000 C CNN
F 2 "" H 10550 4400 50  0001 C CNN
F 3 "" H 10550 4400 50  0001 C CNN
	1    10550 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	10550 4300 10550 4400
Wire Wire Line
	10150 4100 10250 4100
$Comp
L Conn_01x01 J20
U 1 1 5CD4544D
P 10200 4350
F 0 "J20" H 10200 4450 50  0000 C CNN
F 1 "Conn_01x01" H 10200 4250 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 10200 4350 50  0001 C CNN
F 3 "" H 10200 4350 50  0001 C CNN
	1    10200 4350
	0    1    1    0   
$EndComp
$Comp
L Conn_01x01 J22
U 1 1 5CD45453
P 10300 3850
F 0 "J22" H 10300 3950 50  0000 C CNN
F 1 "Conn_01x01" H 10300 3750 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 10300 3850 50  0001 C CNN
F 3 "" H 10300 3850 50  0001 C CNN
	1    10300 3850
	-1   0    0    1   
$EndComp
Wire Wire Line
	10500 3850 10550 3850
Connection ~ 10550 3850
Wire Wire Line
	10200 4150 10200 4100
Connection ~ 10200 4100
Text GLabel 5350 3200 2    60   Input ~ 0
POT_0
Text GLabel 5350 3300 2    60   Input ~ 0
POT_1
Text GLabel 5350 3400 2    60   Input ~ 0
POT_2
Text GLabel 5350 3500 2    60   Input ~ 0
POT_3
Text GLabel 10450 1400 0    60   Input ~ 0
POT_0
Text GLabel 10450 1900 0    60   Input ~ 0
POT_1
Text GLabel 10450 2400 0    60   Input ~ 0
POT_2
Text GLabel 10450 2900 0    60   Input ~ 0
POT_3
Text GLabel 4250 2350 0    60   Input ~ 0
LM35_0_POS
Text GLabel 4250 2450 0    60   Input ~ 0
LM35_0_NEG
Text GLabel 4250 2550 0    60   Input ~ 0
LM35_1_POS
Text GLabel 4250 2650 0    60   Input ~ 0
LM35_1_NEG
Text GLabel 4250 2750 0    60   Input ~ 0
LM35_2_POS
Text GLabel 4250 2850 0    60   Input ~ 0
LM35_2_NEG
Text GLabel 4250 2950 0    60   Input ~ 0
LM35_3_POS
Text GLabel 4250 3050 0    60   Input ~ 0
LM35_3_NEG
$Comp
L GND #PWR06
U 1 1 5CD54390
P 2000 2550
F 0 "#PWR06" H 2000 2300 50  0001 C CNN
F 1 "GND" H 2000 2400 50  0000 C CNN
F 2 "" H 2000 2550 50  0001 C CNN
F 3 "" H 2000 2550 50  0001 C CNN
	1    2000 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 2450 2000 2550
Wire Wire Line
	1850 2250 1200 2250
Wire Wire Line
	2000 2550 1850 2550
Wire Wire Line
	1200 2150 2100 2150
Wire Wire Line
	4250 2350 4350 2350
Wire Wire Line
	4250 2450 4350 2450
Wire Wire Line
	4250 2550 4350 2550
Wire Wire Line
	4250 2650 4350 2650
Wire Wire Line
	4250 2750 4350 2750
Wire Wire Line
	4250 2850 4350 2850
Wire Wire Line
	4250 2950 4350 2950
Wire Wire Line
	4250 3050 4350 3050
$Comp
L Conn_01x03 J2
U 1 1 5CD57674
P 1000 3000
F 0 "J2" H 1000 3200 50  0000 C CNN
F 1 "Conn_01x03" H 1000 2800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 1000 3000 50  0001 C CNN
F 3 "" H 1000 3000 50  0001 C CNN
	1    1000 3000
	-1   0    0    1   
$EndComp
$Comp
L D D2
U 1 1 5CD5767B
P 1850 3150
F 0 "D2" H 1850 3250 50  0000 C CNN
F 1 "D" H 1850 3050 50  0000 C CNN
F 2 "Diodes_THT:D_DO-15_P10.16mm_Horizontal" H 1850 3150 50  0001 C CNN
F 3 "" H 1850 3150 50  0001 C CNN
	1    1850 3150
	0    -1   -1   0   
$EndComp
$Comp
L R R2
U 1 1 5CD57681
P 2000 3050
F 0 "R2" V 2080 3050 50  0000 C CNN
F 1 "18k" V 2000 3050 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1930 3050 50  0001 C CNN
F 3 "" H 2000 3050 50  0001 C CNN
	1    2000 3050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 5CD57687
P 2000 3300
F 0 "#PWR07" H 2000 3050 50  0001 C CNN
F 1 "GND" H 2000 3150 50  0000 C CNN
F 2 "" H 2000 3300 50  0001 C CNN
F 3 "" H 2000 3300 50  0001 C CNN
	1    2000 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 3200 2000 3300
Wire Wire Line
	1850 3000 1200 3000
Wire Wire Line
	2000 3300 1850 3300
Wire Wire Line
	1200 2900 2100 2900
$Comp
L Conn_01x03 J3
U 1 1 5CD57D42
P 1000 3700
F 0 "J3" H 1000 3900 50  0000 C CNN
F 1 "Conn_01x03" H 1000 3500 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 1000 3700 50  0001 C CNN
F 3 "" H 1000 3700 50  0001 C CNN
	1    1000 3700
	-1   0    0    1   
$EndComp
$Comp
L D D3
U 1 1 5CD57D49
P 1850 3850
F 0 "D3" H 1850 3950 50  0000 C CNN
F 1 "D" H 1850 3750 50  0000 C CNN
F 2 "Diodes_THT:D_DO-15_P10.16mm_Horizontal" H 1850 3850 50  0001 C CNN
F 3 "" H 1850 3850 50  0001 C CNN
	1    1850 3850
	0    -1   -1   0   
$EndComp
$Comp
L R R3
U 1 1 5CD57D4F
P 2000 3750
F 0 "R3" V 2080 3750 50  0000 C CNN
F 1 "18k" V 2000 3750 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1930 3750 50  0001 C CNN
F 3 "" H 2000 3750 50  0001 C CNN
	1    2000 3750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5CD57D55
P 2000 4000
F 0 "#PWR08" H 2000 3750 50  0001 C CNN
F 1 "GND" H 2000 3850 50  0000 C CNN
F 2 "" H 2000 4000 50  0001 C CNN
F 3 "" H 2000 4000 50  0001 C CNN
	1    2000 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 3900 2000 4000
Wire Wire Line
	1850 3700 1200 3700
Wire Wire Line
	2000 4000 1850 4000
Wire Wire Line
	1200 3600 2100 3600
$Comp
L Conn_01x03 J4
U 1 1 5CD57D5F
P 1000 4450
F 0 "J4" H 1000 4650 50  0000 C CNN
F 1 "Conn_01x03" H 1000 4250 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 1000 4450 50  0001 C CNN
F 3 "" H 1000 4450 50  0001 C CNN
	1    1000 4450
	-1   0    0    1   
$EndComp
$Comp
L D D4
U 1 1 5CD57D66
P 1850 4600
F 0 "D4" H 1850 4700 50  0000 C CNN
F 1 "D" H 1850 4500 50  0000 C CNN
F 2 "Diodes_THT:D_DO-15_P10.16mm_Horizontal" H 1850 4600 50  0001 C CNN
F 3 "" H 1850 4600 50  0001 C CNN
	1    1850 4600
	0    -1   -1   0   
$EndComp
$Comp
L R R4
U 1 1 5CD57D6C
P 2000 4500
F 0 "R4" V 2080 4500 50  0000 C CNN
F 1 "18k" V 2000 4500 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1930 4500 50  0001 C CNN
F 3 "" H 2000 4500 50  0001 C CNN
	1    2000 4500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 5CD57D72
P 2000 4750
F 0 "#PWR09" H 2000 4500 50  0001 C CNN
F 1 "GND" H 2000 4600 50  0000 C CNN
F 2 "" H 2000 4750 50  0001 C CNN
F 3 "" H 2000 4750 50  0001 C CNN
	1    2000 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 4650 2000 4750
Wire Wire Line
	1850 4450 1200 4450
Wire Wire Line
	2000 4750 1850 4750
Wire Wire Line
	1200 4350 2100 4350
Text GLabel 2100 2150 2    60   Input ~ 0
LM35_0_POS
Text GLabel 2100 1950 2    60   Input ~ 0
LM35_0_NEG
Connection ~ 2000 2150
Wire Wire Line
	2100 1950 1850 1950
Wire Wire Line
	1850 1950 1850 2250
Text GLabel 2100 2900 2    60   Input ~ 0
LM35_1_POS
Text GLabel 2100 2750 2    60   Input ~ 0
LM35_1_NEG
Connection ~ 2000 2900
Wire Wire Line
	2100 2750 1850 2750
Wire Wire Line
	1850 2750 1850 3000
Text GLabel 2100 3600 2    60   Input ~ 0
LM35_2_POS
Text GLabel 2100 3450 2    60   Input ~ 0
LM35_2_NEG
Text GLabel 2100 4350 2    60   Input ~ 0
LM35_3_POS
Text GLabel 2100 4200 2    60   Input ~ 0
LM35_3_NEG
Connection ~ 2000 3600
Wire Wire Line
	2100 3450 1850 3450
Wire Wire Line
	1850 3450 1850 3700
Wire Wire Line
	2100 4200 1850 4200
Wire Wire Line
	1850 4200 1850 4450
Connection ~ 2000 4350
$Comp
L Conn_01x01 J29
U 1 1 5CD5D1BB
P 6850 2000
F 0 "J29" H 6850 2100 50  0000 C CNN
F 1 "Conn_01x01" V 6750 2250 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 6850 2000 50  0001 C CNN
F 3 "" H 6850 2000 50  0001 C CNN
	1    6850 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	6800 1750 6850 1750
Wire Wire Line
	6850 1650 6850 1800
Wire Wire Line
	6850 1650 6900 1650
Connection ~ 6850 1750
$Comp
L Conn_01x01 J28
U 1 1 5CD5D755
P 6300 1450
F 0 "J28" H 6300 1550 50  0000 C CNN
F 1 "Conn_01x01" H 6300 1350 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 6300 1450 50  0001 C CNN
F 3 "" H 6300 1450 50  0001 C CNN
	1    6300 1450
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x01 J30
U 1 1 5CD5D898
P 7300 1350
F 0 "J30" H 7300 1450 50  0000 C CNN
F 1 "Conn_01x01" H 7300 1250 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 7300 1350 50  0001 C CNN
F 3 "" H 7300 1350 50  0001 C CNN
	1    7300 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 1450 6800 1450
Wire Wire Line
	6800 1450 6800 1550
Wire Wire Line
	6800 1550 6900 1550
Wire Wire Line
	6900 1350 6900 1450
Wire Wire Line
	6900 1350 7100 1350
$Comp
L R R5
U 1 1 5CD5FAA9
P 6400 2700
F 0 "R5" V 6480 2700 50  0000 C CNN
F 1 "R" V 6400 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6330 2700 50  0001 C CNN
F 3 "" H 6400 2700 50  0001 C CNN
	1    6400 2700
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 5CD5FBE6
P 6600 2700
F 0 "R6" V 6680 2700 50  0000 C CNN
F 1 "R" V 6600 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6530 2700 50  0001 C CNN
F 3 "" H 6600 2700 50  0001 C CNN
	1    6600 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 2850 6400 2900
Connection ~ 6400 2900
Wire Wire Line
	6600 2850 6600 3000
Connection ~ 6600 3000
Wire Wire Line
	6850 2800 6750 2800
Wire Wire Line
	6750 2800 6750 2400
Wire Wire Line
	6400 2550 6750 2550
Connection ~ 6750 2550
Connection ~ 6600 2550
$Comp
L Conn_01x01 J26
U 1 1 5CD62ED4
P 6000 3300
F 0 "J26" H 6000 3400 50  0000 C CNN
F 1 "Conn_01x01" H 6000 3200 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 6000 3300 50  0001 C CNN
F 3 "" H 6000 3300 50  0001 C CNN
	1    6000 3300
	0    1    1    0   
$EndComp
$Comp
L Conn_01x01 J27
U 1 1 5CD6341A
P 6250 3300
F 0 "J27" H 6250 3400 50  0000 C CNN
F 1 "Conn_01x01" H 6250 3200 50  0000 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 6250 3300 50  0001 C CNN
F 3 "" H 6250 3300 50  0001 C CNN
	1    6250 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	6000 3100 6000 2900
Connection ~ 6000 2900
Wire Wire Line
	6250 3100 6250 3000
Connection ~ 6250 3000
Text GLabel 1200 2350 2    60   Input ~ 0
VCC(5V)
Text GLabel 1200 3100 2    60   Input ~ 0
VCC(5V)
Text GLabel 1200 3800 2    60   Input ~ 0
VCC(5V)
Text GLabel 1200 4550 2    60   Input ~ 0
VCC(5V)
$EndSCHEMATC
