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
Sheet 3 3
Title "Carte Temperature"
Date ""
Rev "2"
Comp "CFPT Electronique"
Comment1 "Tanguy Dietrich"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L EEH210 U1
U 1 1 5CD06306
P 2400 2100
F 0 "U1" H 2600 2400 60  0000 C CNN
F 1 "EEH210" H 2250 2400 60  0000 C CNN
F 2 "Carte_Temperature:EEH210_1.5mm" H 2450 2450 60  0001 C CNN
F 3 "" H 2450 2450 60  0001 C CNN
	1    2400 2100
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 5CD06307
P 1700 2350
F 0 "C1" H 1725 2450 50  0000 L CNN
F 1 "C" H 1725 2250 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206_HandSoldering" H 1738 2200 50  0001 C CNN
F 3 "" H 1700 2350 50  0001 C CNN
	1    1700 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 1900 2850 2100
Connection ~ 2850 2000
Wire Wire Line
	2850 2000 3000 2000
NoConn ~ 2000 1900
NoConn ~ 2000 2000
NoConn ~ 2000 2100
NoConn ~ 2000 2300
$Comp
L GND #PWR016
U 1 1 5CD0639B
P 3000 2600
F 0 "#PWR016" H 3000 2350 50  0001 C CNN
F 1 "GND" H 3000 2450 50  0000 C CNN
F 2 "" H 3000 2600 50  0001 C CNN
F 3 "" H 3000 2600 50  0001 C CNN
	1    3000 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 2000 3000 2600
Wire Wire Line
	1550 2200 2000 2200
Wire Wire Line
	1700 2500 3150 2500
Connection ~ 3000 2500
Text HLabel 1550 2200 0    60   Input ~ 0
VDD(3.3V)
Text HLabel 3150 2500 2    60   Input ~ 0
GND
Text HLabel 3150 2300 2    60   Input ~ 0
SDA
Text HLabel 3150 2200 2    60   Input ~ 0
SCL
Wire Wire Line
	3150 2200 2850 2200
Wire Wire Line
	3150 2300 2850 2300
Connection ~ 1700 2200
$EndSCHEMATC
