EESchema Schematic File Version 2
LIBS:BASE_V2
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
LIBS:LM2575HVS-ADJ
LIBS:Charge_active_Dietrich-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Charge Active Dietrich"
Date ""
Rev "1.0"
Comp "CFPT - Ecole d'électronique"
Comment1 "Dietrich Tanguy T.EL-E2A"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R2
U 1 1 5B8CF7FB
P 5750 2900
F 0 "R2" H 5850 2900 39  0000 C CNN
F 1 "0" V 5750 2900 39  0000 C CNN
F 2 "base_V2:SM_R_1206" H 5750 2900 39  0001 C CNN
F 3 "" H 5750 2900 39  0000 C CNN
	1    5750 2900
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5B8CF858
P 5750 3450
F 0 "R1" H 5850 3450 39  0000 C CNN
F 1 "NC" V 5750 3450 39  0000 C CNN
F 2 "base_V2:SM_R_1206" H 5750 3450 39  0001 C CNN
F 3 "" H 5750 3450 39  0000 C CNN
	1    5750 3450
	1    0    0    -1  
$EndComp
$Comp
L C Cin1
U 1 1 5B8CF8AB
P 2700 2900
F 0 "Cin1" H 2800 3000 39  0000 C CNN
F 1 "100uF" H 2800 2800 39  0000 C CNN
F 2 "Capacitors_SMD:CP_Elec_8x10" H 2700 2900 39  0001 C CNN
F 3 "" H 2700 2900 39  0000 C CNN
	1    2700 2900
	1    0    0    -1  
$EndComp
$Comp
L C Cout1
U 1 1 5B8CF8FA
P 5300 2850
F 0 "Cout1" H 5400 2950 39  0000 C CNN
F 1 "1000uF" H 5400 2750 39  0000 C CNN
F 2 "Capacitors_SMD:CP_Elec_8x10" H 5300 2850 39  0001 C CNN
F 3 "" H 5300 2850 39  0000 C CNN
	1    5300 2850
	1    0    0    -1  
$EndComp
$Comp
L D_Schottky D1
U 1 1 5B8CF9DC
P 4750 3700
F 0 "D1" H 4750 3800 50  0000 C CNN
F 1 "MBR340" H 4750 3600 50  0000 C CNN
F 2 "Diodes_SMD:D_SMA" H 4750 3700 50  0001 C CNN
F 3 "" H 4750 3700 50  0001 C CNN
	1    4750 3700
	0    1    1    0   
$EndComp
$Comp
L L L1
U 1 1 5B8CFA35
P 4950 2650
F 0 "L1" H 5050 2650 39  0000 C CNN
F 1 "100uH" V 4900 2650 39  0000 C CNN
F 2 "DR127-221-R:INDM125125X800N" H 4950 2650 39  0001 C CNN
F 3 "" H 4950 2650 39  0000 C CNN
	1    4950 2650
	0    -1   -1   0   
$EndComp
$Comp
L LM2575HVS-ADJ U1
U 1 1 5B8CFDCF
P 3850 2850
F 0 "U1" H 3663 3344 50  0000 L BNN
F 1 "LM2576" H 3350 2300 50  0000 L BNN
F 2 "LM2575HVS-ADJ:TO170P1435X457-6N" H 3500 2650 50  0001 L BNN
F 3 "TO-263-5 Texas Instruments" H 3450 2750 50  0001 L BNN
F 4 "Texas Instruments" H 3600 2850 50  0001 L BNN "Champ4"
F 5 "4.76 USD" H 4000 2400 50  0001 L BNN "Champ5"
F 6 "LM2575HVS-ADJ" H 3350 3250 50  0001 L BNN "Champ6"
F 7 "Warning" H 4050 2300 50  0001 L BNN "Champ7"
F 8 "Conv DC-DC 4V to 60V Step Down Single-Out 1.23V to 57V 1A 6-Pin_5+Tab_ TO-263 Tube" H 3350 2150 50  0001 L BNN "Champ8"
	1    3850 2850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5B8D0540
P 3050 3800
F 0 "#PWR01" H 3050 3550 50  0001 C CNN
F 1 "GND" H 3050 3650 50  0000 C CNN
F 2 "" H 3050 3800 50  0001 C CNN
F 3 "" H 3050 3800 50  0001 C CNN
	1    3050 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 2650 3150 2650
Wire Wire Line
	2700 2650 2700 2700
Connection ~ 2700 2650
Wire Wire Line
	2950 2550 2950 2650
Connection ~ 2950 2650
Wire Wire Line
	3150 3150 3150 3250
Wire Wire Line
	2100 3200 3150 3200
Connection ~ 3150 3200
Wire Wire Line
	2700 3100 2700 3300
Connection ~ 2700 3200
Wire Wire Line
	3050 2850 3050 3800
Connection ~ 3050 3200
$Comp
L CON2 J1
U 1 1 5B8D1EC5
P 1800 2650
F 0 "J1" H 1800 2850 40  0000 C CNN
F 1 "CON2" V 1800 2650 40  0001 C CNN
F 2 "base_V2:TSC_CON2_SIL" H 1800 2650 60  0001 C CNN
F 3 "" H 1800 2650 60  0000 C CNN
	1    1800 2650
	-1   0    0    1   
$EndComp
$Comp
L CON2 J2
U 1 1 5B8D2004
P 1800 3200
F 0 "J2" H 1800 3400 40  0000 C CNN
F 1 "CON2" V 1800 3200 40  0001 C CNN
F 2 "base_V2:TSC_CON2_SIL" H 1800 3200 60  0001 C CNN
F 3 "" H 1800 3200 60  0000 C CNN
	1    1800 3200
	-1   0    0    1   
$EndComp
$Comp
L CON2 J4
U 1 1 5B8D209C
P 6350 2750
F 0 "J4" H 6350 2950 40  0000 C CNN
F 1 "CON2" V 6350 2750 40  0001 C CNN
F 2 "base_V2:TSC_CON2_SIL" H 6350 2750 60  0001 C CNN
F 3 "" H 6350 2750 60  0000 C CNN
	1    6350 2750
	1    0    0    -1  
$EndComp
$Comp
L CON2 J3
U 1 1 5B8D20D9
P 6300 4050
F 0 "J3" H 6300 4250 40  0000 C CNN
F 1 "CON2" V 6300 4050 40  0001 C CNN
F 2 "base_V2:TSC_CON2_SIL" H 6300 4050 60  0001 C CNN
F 3 "" H 6300 4050 60  0000 C CNN
	1    6300 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 2550 2100 2750
Connection ~ 2100 2650
Wire Wire Line
	2100 3100 2100 3300
Connection ~ 2100 3200
Connection ~ 3050 3600
Wire Wire Line
	3150 2850 3050 2850
Wire Wire Line
	4550 2650 4750 2650
Wire Wire Line
	5150 2650 6050 2650
Connection ~ 5300 2650
Wire Wire Line
	5750 2700 5750 2650
Connection ~ 5750 2650
Wire Wire Line
	5750 3100 5750 3250
Wire Wire Line
	6000 3950 6000 4150
Wire Wire Line
	6000 4050 3200 4050
Wire Wire Line
	3200 4050 3200 3600
Wire Wire Line
	3200 3600 3050 3600
Connection ~ 6000 4050
Wire Wire Line
	5750 3650 5750 4050
Connection ~ 5750 4050
Wire Wire Line
	5300 3050 5300 4050
Connection ~ 5300 4050
Wire Wire Line
	6050 2850 5950 2850
Wire Wire Line
	5950 2650 5950 3000
Connection ~ 5950 2650
Wire Wire Line
	4750 2650 4750 3550
Wire Wire Line
	4750 3850 4750 4050
Connection ~ 4750 4050
Wire Wire Line
	4550 2750 5000 2750
Wire Wire Line
	5000 2750 5000 3200
Wire Wire Line
	5000 3200 5750 3200
Connection ~ 5750 3200
$Comp
L CON1 J7
U 1 1 5B962AF5
P 4650 2950
F 0 "J7" H 4730 2950 40  0000 L CNN
F 1 "CON1" H 4650 3005 30  0001 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 4650 2950 60  0001 C CNN
F 3 "" H 4650 2950 60  0000 C CNN
	1    4650 2950
	0    1    1    0   
$EndComp
$Comp
L CON1 J5
U 1 1 5B962C76
P 2700 3450
F 0 "J5" H 2780 3450 40  0000 L CNN
F 1 "CON1" H 2700 3505 30  0001 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 2700 3450 60  0001 C CNN
F 3 "" H 2700 3450 60  0000 C CNN
	1    2700 3450
	0    1    1    0   
$EndComp
$Comp
L CON1 J6
U 1 1 5B962DE6
P 4650 2450
F 0 "J6" H 4730 2450 40  0000 L CNN
F 1 "CON1" H 4650 2505 30  0001 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 4650 2450 60  0001 C CNN
F 3 "" H 4650 2450 60  0000 C CNN
	1    4650 2450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4650 2600 4650 2650
Connection ~ 4650 2650
Wire Wire Line
	4650 2800 4650 2750
Connection ~ 4650 2750
$Comp
L C C2
U 1 1 5B96302D
P 6300 3400
F 0 "C2" H 6400 3500 39  0000 C CNN
F 1 "NC" H 6400 3300 39  0000 C CNN
F 2 "base_V2:SM_C_1206" H 6300 3400 39  0001 C CNN
F 3 "" H 6300 3400 39  0000 C CNN
	1    6300 3400
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 5B963126
P 6000 3400
F 0 "C1" H 6100 3500 39  0000 C CNN
F 1 "NC" H 6100 3300 39  0000 C CNN
F 2 "base_V2:SM_C_1206" H 6000 3400 39  0001 C CNN
F 3 "" H 6000 3400 39  0000 C CNN
	1    6000 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 3200 6000 3200
Wire Wire Line
	6000 3600 6300 3600
Wire Wire Line
	6100 3600 6100 3800
Wire Wire Line
	6100 3800 5900 3800
Wire Wire Line
	5900 3800 5900 4050
Connection ~ 5900 4050
Connection ~ 6100 3600
Wire Wire Line
	6150 3200 6150 3000
Wire Wire Line
	6150 3000 5950 3000
Connection ~ 5950 2850
Connection ~ 6150 3200
$Comp
L CON1 J8
U 1 1 5B98F8EF
P 2950 2400
F 0 "J8" H 3030 2400 40  0000 L CNN
F 1 "CON1" H 2950 2455 30  0001 C CNN
F 2 "base_V2:TSC_CON1_poignard" H 2950 2400 60  0001 C CNN
F 3 "" H 2950 2400 60  0000 C CNN
	1    2950 2400
	0    -1   -1   0   
$EndComp
$EndSCHEMATC
