EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr B 17000 11000
encoding utf-8
Sheet 20 27
Title "rev02_18"
Date "15 10 2016"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 4700 4100 0    60   ~ 12
*) FPGA Power Subsystem -- AUX and I/O
Text Notes 7500 5100 0    60   ~ 12
*) VCCAUX = 0.75V x (1 + 205 / 147) = 1.796V\n*) VCCO = 0.75V x (1 + 205 / 59) = 3.356\n*) Minimal load current is 2 mA:\n1.8V / 470 Ohm = ~~4mA\n3.3V /  470 Ohm = ~~7mA\n*) Light-load mode is enabled
Text Notes 6700 8500 0    60   ~ 12
This is the 3V3 rail that powers\nboth the FPGA and the ARM as well\nas various other components.
Text Notes 8450 10220 0    66   ~ 12
FPGA voltage regulators
Text Notes 1160 5190 0    60   ~ 12
C113
Text Notes 1160 5390 0    60   ~ 12
22~uF
Text Notes 1710 6350 0    60   ~ 12
R53
Text Notes 1690 5170 0    60   ~ 12
R52
Text Notes 4040 5090 0    60   ~ 12
R56
Text Notes 4400 5700 0    60   ~ 12
R57
Text Notes 5630 5560 0    60   ~ 12
R60
Text Notes 1160 8390 0    60   ~ 12
C114
Text Notes 1160 8590 0    60   ~ 12
22~uF
Text Notes 1730 9530 0    60   ~ 12
R55
Text Notes 1660 8390 0    60   ~ 12
R54
Text Notes 4040 8270 0    60   ~ 12
R58
Text Notes 4070 8880 0    60   ~ 12
R59
Text Notes 5600 8690 0    60   ~ 12
R61
Text Notes 2160 6390 0    60   ~ 12
C115
Text Notes 2160 6590 0    60   ~ 12
0.047~uF
Text Notes 2160 9590 0    60   ~ 12
C116
Text Notes 2160 9790 0    60   ~ 12
0.047~uF
Text Notes 4660 8190 0    60   ~ 12
C118
Text Notes 4660 8390 0    60   ~ 12
27pF
Text Notes 4660 4990 0    60   ~ 12
C117
Text Notes 4660 5190 0    60   ~ 12
27pF
Text Notes 5060 5490 0    60   ~ 12
C119
Text Notes 5060 5690 0    60   ~ 12
47uF
Text Notes 5060 8690 0    60   ~ 12
C120
Text Notes 5060 8890 0    60   ~ 12
47uF
$Comp
L power:GND GND_109
U 1 1 58023F2B
P 2800 6700
F 0 "GND_109" H 2800 6700 20  0000 C CNN
F 1 "+GND" H 2800 6630 30  0000 C CNN
F 2 "" H 2800 6700 70  0000 C CNN
F 3 "" H 2800 6700 70  0000 C CNN
	1    2800 6700
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_110
U 1 1 58023F2A
P 3300 6700
F 0 "GND_110" H 3300 6700 20  0000 C CNN
F 1 "+GND" H 3300 6630 30  0000 C CNN
F 2 "" H 3300 6700 70  0000 C CNN
F 3 "" H 3300 6700 70  0000 C CNN
	1    3300 6700
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_111
U 1 1 58023F29
P 2100 6700
F 0 "GND_111" H 2100 6700 20  0000 C CNN
F 1 "+GND" H 2100 6630 30  0000 C CNN
F 2 "" H 2100 6700 70  0000 C CNN
F 3 "" H 2100 6700 70  0000 C CNN
	1    2100 6700
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_112
U 1 1 58023F28
P 1100 5600
F 0 "GND_112" H 1100 5600 20  0000 C CNN
F 1 "+GND" H 1100 5530 30  0000 C CNN
F 2 "" H 1100 5600 70  0000 C CNN
F 3 "" H 1100 5600 70  0000 C CNN
	1    1100 5600
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_113
U 1 1 58023F27
P 1600 6700
F 0 "GND_113" H 1600 6700 20  0000 C CNN
F 1 "+GND" H 1600 6630 30  0000 C CNN
F 2 "" H 1600 6700 70  0000 C CNN
F 3 "" H 1600 6700 70  0000 C CNN
	1    1600 6700
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_114
U 1 1 58023F26
P 4300 6000
F 0 "GND_114" H 4300 6000 20  0000 C CNN
F 1 "+GND" H 4300 5930 30  0000 C CNN
F 2 "" H 4300 6000 70  0000 C CNN
F 3 "" H 4300 6000 70  0000 C CNN
	1    4300 6000
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_115
U 1 1 58023F25
P 5000 6000
F 0 "GND_115" H 5000 6000 20  0000 C CNN
F 1 "+GND" H 5000 5930 30  0000 C CNN
F 2 "" H 5000 6000 70  0000 C CNN
F 3 "" H 5000 6000 70  0000 C CNN
	1    5000 6000
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_116
U 1 1 58023F24
P 5500 6000
F 0 "GND_116" H 5500 6000 20  0000 C CNN
F 1 "+GND" H 5500 5930 30  0000 C CNN
F 2 "" H 5500 6000 70  0000 C CNN
F 3 "" H 5500 6000 70  0000 C CNN
	1    5500 6000
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_117
U 1 1 58023F23
P 2800 9900
F 0 "GND_117" H 2800 9900 20  0000 C CNN
F 1 "+GND" H 2800 9830 30  0000 C CNN
F 2 "" H 2800 9900 70  0000 C CNN
F 3 "" H 2800 9900 70  0000 C CNN
	1    2800 9900
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_118
U 1 1 58023F22
P 3300 9900
F 0 "GND_118" H 3300 9900 20  0000 C CNN
F 1 "+GND" H 3300 9830 30  0000 C CNN
F 2 "" H 3300 9900 70  0000 C CNN
F 3 "" H 3300 9900 70  0000 C CNN
	1    3300 9900
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_119
U 1 1 58023F21
P 2100 9900
F 0 "GND_119" H 2100 9900 20  0000 C CNN
F 1 "+GND" H 2100 9830 30  0000 C CNN
F 2 "" H 2100 9900 70  0000 C CNN
F 3 "" H 2100 9900 70  0000 C CNN
	1    2100 9900
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_120
U 1 1 58023F20
P 1100 8800
F 0 "GND_120" H 1100 8800 20  0000 C CNN
F 1 "+GND" H 1100 8730 30  0000 C CNN
F 2 "" H 1100 8800 70  0000 C CNN
F 3 "" H 1100 8800 70  0000 C CNN
	1    1100 8800
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_121
U 1 1 58023F1F
P 1600 9900
F 0 "GND_121" H 1600 9900 20  0000 C CNN
F 1 "+GND" H 1600 9830 30  0000 C CNN
F 2 "" H 1600 9900 70  0000 C CNN
F 3 "" H 1600 9900 70  0000 C CNN
	1    1600 9900
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_122
U 1 1 58023F1E
P 4300 9200
F 0 "GND_122" H 4300 9200 20  0000 C CNN
F 1 "+GND" H 4300 9130 30  0000 C CNN
F 2 "" H 4300 9200 70  0000 C CNN
F 3 "" H 4300 9200 70  0000 C CNN
	1    4300 9200
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_123
U 1 1 58023F1D
P 5000 9200
F 0 "GND_123" H 5000 9200 20  0000 C CNN
F 1 "+GND" H 5000 9130 30  0000 C CNN
F 2 "" H 5000 9200 70  0000 C CNN
F 3 "" H 5000 9200 70  0000 C CNN
	1    5000 9200
	1    0    0    -1  
$EndComp
$Comp
L power:GND GND_124
U 1 1 58023F1C
P 5500 9200
F 0 "GND_124" H 5500 9200 20  0000 C CNN
F 1 "+GND" H 5500 9130 30  0000 C CNN
F 2 "" H 5500 9200 70  0000 C CNN
F 3 "" H 5500 9200 70  0000 C CNN
	1    5500 9200
	1    0    0    -1  
$EndComp
$Comp
L Cryptech_Alpha:VCC_5V0 VCC_5V0
U 1 1 58023F1B
P 1100 4600
F 0 "VCC_5V0" H 1100 4600 20  0000 C CNN
F 1 "+VCC_5V0" H 1100 4530 30  0000 C CNN
F 2 "" H 1100 4600 70  0000 C CNN
F 3 "" H 1100 4600 70  0000 C CNN
	1    1100 4600
	1    0    0    -1  
$EndComp
$Comp
L Cryptech_Alpha:VCC_5V0 VCC_5V0_2
U 1 1 58023F1A
P 1100 7800
F 0 "VCC_5V0_2" H 1100 7800 20  0000 C CNN
F 1 "+VCC_5V0" H 1100 7730 30  0000 C CNN
F 2 "" H 1100 7800 70  0000 C CNN
F 3 "" H 1100 7800 70  0000 C CNN
	1    1100 7800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 6600 2800 6700
Wire Wire Line
	3300 6600 3300 6700
Wire Wire Line
	2100 6600 2100 6700
Wire Wire Line
	1100 5400 1100 5600
Wire Wire Line
	1600 6600 1600 6700
Wire Wire Line
	4300 5900 4300 6000
Wire Wire Line
	5000 5700 5000 6000
Wire Wire Line
	5500 5800 5500 6000
Wire Wire Line
	2800 9800 2800 9900
Wire Wire Line
	3300 9800 3300 9900
Wire Wire Line
	2100 9800 2100 9900
Wire Wire Line
	1100 8600 1100 8800
Wire Wire Line
	1600 9800 1600 9900
Wire Wire Line
	4300 9100 4300 9200
Wire Wire Line
	5000 8900 5000 9200
Wire Wire Line
	5500 9000 5500 9200
Wire Wire Line
	7000 4800 6000 4800
Text Label 7000 4800 2 48 ~ 0
FPGA_VCCAUX_1V8
Wire Wire Line
	7000 8000 6000 8000
Text Label 7000 8000 0 48 ~ 0
VCCO_3V3
Wire Wire Line
	2100 6200 2100 6300
Wire Wire Line
	2300 6200 2100 6200
Wire Wire Line
	2300 4800 2100 4800
Wire Wire Line
	2100 4800 1600 4800
Wire Wire Line
	1600 4800 1100 4800
Wire Wire Line
	1100 4600 1100 4800
Wire Wire Line
	2300 5000 2100 5000
Wire Wire Line
	2100 4800 2100 5000
Wire Wire Line
	1100 4800 1100 5100
Wire Wire Line
	1600 4800 1600 5000
Connection ~ 2100 4800
Connection ~ 1100 4800
Connection ~ 1600 4800
Wire Wire Line
	2300 8000 2100 8000
Wire Wire Line
	2100 8000 1600 8000
Wire Wire Line
	1600 8000 1100 8000
Wire Wire Line
	1100 7800 1100 8000
Wire Wire Line
	2300 8200 2100 8200
Wire Wire Line
	2100 8000 2100 8200
Wire Wire Line
	1100 8000 1100 8300
Wire Wire Line
	1600 8000 1600 8200
Connection ~ 2100 8000
Connection ~ 1100 8000
Connection ~ 1600 8000
Wire Wire Line
	2300 5200 1900 5200
Wire Wire Line
	1900 4150 1900 5200
Text GLabel 1900 4150 0 48 Input ~ 0
PWR_ENA_VCCAUX
Wire Wire Line
	1600 5800 1600 6200
Wire Wire Line
	2300 5800 1600 5800
Wire Wire Line
	2300 5600 1600 5600
Wire Wire Line
	1600 5400 1600 5600
Wire Wire Line
	4300 4800 3900 4800
Wire Wire Line
	4300 4800 4300 4900
Wire Wire Line
	4600 4800 4600 4900
Wire Wire Line
	4600 4800 4300 4800
Wire Wire Line
	5000 4800 5000 5400
Wire Wire Line
	5000 4800 4600 4800
Wire Wire Line
	5500 4800 5500 5400
Wire Wire Line
	5500 4800 5000 4800
Wire Wire Line
	5600 4800 5500 4800
Connection ~ 4300 4800
Connection ~ 4600 4800
Connection ~ 5000 4800
Connection ~ 5500 4800
Wire Wire Line
	4300 5300 4300 5400
Wire Wire Line
	4300 5400 3900 5400
Wire Wire Line
	4600 5200 4600 5400
Wire Wire Line
	4600 5400 4300 5400
Wire Wire Line
	4300 5400 4300 5500
Connection ~ 4300 5400
Wire Wire Line
	2100 9400 2100 9500
Wire Wire Line
	2300 9400 2100 9400
Wire Wire Line
	1600 9000 1600 9400
Wire Wire Line
	2300 9000 1600 9000
Wire Wire Line
	2300 8800 1600 8800
Wire Wire Line
	1600 8600 1600 8800
Wire Wire Line
	4010 8000 3900 8000
Wire Wire Line
	4300 8000 4010 8000
Wire Wire Line
	4300 8000 4300 8100
Wire Wire Line
	4600 8000 4600 8100
Wire Wire Line
	4600 8000 4300 8000
Wire Wire Line
	5000 8000 5000 8600
Wire Wire Line
	5000 8000 4600 8000
Wire Wire Line
	5500 8000 5500 8600
Wire Wire Line
	5500 8000 5000 8000
Wire Wire Line
	5600 8000 5500 8000
Connection ~ 4300 8000
Connection ~ 4600 8000
Connection ~ 5000 8000
Connection ~ 5500 8000
Wire Wire Line
	4300 8500 4300 8600
Wire Wire Line
	4300 8600 3900 8600
Wire Wire Line
	4600 8400 4600 8600
Wire Wire Line
	4600 8600 4300 8600
Wire Wire Line
	4300 8600 4300 8700
Connection ~ 4300 8600
Wire Wire Line
	2300 8400 1900 8400
Wire Wire Line
	1900 7500 1900 8400
Wire Wire Line
	1900 7500 1800 7500
Text GLabel 1400 7500 0 48 Input ~ 0
PWR_ENA_VCCO
Wire Wire Line
	4000 6200 3900 6200
Wire Wire Line
	4000 6200 4000 6500
Text GLabel 4000 6500 2 48 Output ~ 0
POK_VCCAUX
Wire Wire Line
	4000 9400 3900 9400
Wire Wire Line
	4000 9400 4000 9700
Text GLabel 4000 9700 2 48 Output ~ 0
POK_VCCO
Text Notes 2700 4440 0    60   ~ 12
U14
Text Notes 3090 4420 0    60   ~ 12
EN6347QI
Wire Wire Line
	2300 4700 2300 4600
Wire Wire Line
	2300 4800 2300 4700
Wire Wire Line
	3900 4700 3900 4600
Wire Wire Line
	3900 4800 3900 4700
Wire Wire Line
	3900 4900 3900 4800
Wire Wire Line
	3900 5000 3900 4900
Wire Wire Line
	3900 5100 3900 5000
Wire Wire Line
	3900 5200 3900 5100
Text Notes 2700 7640 0    60   ~ 12
U14
Text Notes 3090 7630 0    60   ~ 12
EN6347QI
Wire Wire Line
	2100 7800 2300 7800
Wire Wire Line
	2100 7900 2100 7800
Wire Wire Line
	2100 8000 2100 7900
Wire Wire Line
	2100 7900 2300 7900
Wire Wire Line
	4010 7800 3900 7800
Wire Wire Line
	4010 7900 4010 7800
Wire Wire Line
	4010 8000 4010 7900
Wire Wire Line
	4010 7900 3900 7900
Wire Wire Line
	4010 8100 3900 8100
Wire Wire Line
	4010 8000 4010 8100
Wire Wire Line
	4010 8200 3900 8200
Wire Wire Line
	4010 8100 4010 8200
Wire Wire Line
	4010 8300 3900 8300
Wire Wire Line
	4010 8200 4010 8300
Wire Wire Line
	4010 8400 3900 8400
Wire Wire Line
	4010 8300 4010 8400
Wire Wire Line
	1400 7500 1800 7500
Connection ~ 2100 7900
Connection ~ 2300 4800
Connection ~ 2300 4700
Connection ~ 3900 5100
Connection ~ 3900 5000
Connection ~ 3900 4900
Connection ~ 3900 4800
Connection ~ 3900 4700
Connection ~ 4010 8300
Connection ~ 4010 8200
Connection ~ 4010 8100
Connection ~ 4010 8000
Connection ~ 4010 7900
$Comp
L Cryptech_Alpha:C-EUC1210 C113
U 1 1 58023F19
P 1100 5200
F 0 "C113" H 1180 5010 60  0000 L BNN
	1    1100 5200
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:C_1210" H 1180 5010 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R54
U 1 1 58023F18
P 1600 8400
F 0 "R54" V 1510 8355 60  0000 R TNN
F 1 "4.7k" V 1490 8350 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 1490 8350 60  0001 C CNN
F 3 "" H 1490 8350 60  0000 C CNN
	1    1600 8400
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R58
U 1 1 58023F17
P 4300 8300
F 0 "R58" V 4210 8255 60  0000 R TNN
F 1 "205k" V 4250 8560 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 4250 8560 60  0001 C CNN
F 3 "" H 4250 8560 60  0000 C CNN
	1    4300 8300
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R59
U 1 1 58023F16
P 4300 8900
F 0 "R59" V 4210 8855 60  0000 R TNN
F 1 "59k" V 4240 9130 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 4240 9130 60  0001 C CNN
F 3 "" H 4240 9130 60  0000 C CNN
	1    4300 8900
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R61
U 1 1 58023F15
P 5500 8800
F 0 "R61" V 5410 8755 60  0000 R TNN
F 1 "470" V 5520 8700 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 5520 8700 60  0001 C CNN
F 3 "" H 5520 8700 60  0000 C CNN
	1    5500 8800
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:BLM31PG330SN1_1206 FB6
U 1 1 58023F14
P 5800 8100
F 0 "FB6" H 5650 8300 60  0000 L BNN
F 1 "BLM31PG330SN1" H 5630 8010 60  0000 L BNN
F 2 "Cryptech_Alpha_Footprints:L_1206" H 5630 8010 60  0001 C CNN
F 3 "" H 5630 8010 60  0000 C CNN
	1    5800 8100
	1    0    0    -1
$EndComp
$Comp
L Cryptech_Alpha:C-EUC0402 C115
U 1 1 58023F13
P 2100 6400
F 0 "C115" H 2180 6210 60  0000 L BNN
	1    2100 6400
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:C_0402" H 2180 6210 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:C-EUC0402 C116
U 1 1 58023F12
P 2100 9600
F 0 "C116" H 2180 9410 60  0000 L BNN
	1    2100 9600
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:C_0402" H 2180 9410 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:C-EUC0402 C118
U 1 1 58023F11
P 4600 8200
F 0 "C118" H 4680 8010 60  0000 L BNN
	1    4600 8200
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:C_0402" H 4680 8010 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:C-EUC0402 C117
U 1 1 58023F10
P 4600 5000
F 0 "C117" H 4680 4810 60  0000 L BNN
	1    4600 5000
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:C_0402" H 4680 4810 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:C-EUC1210 C119
U 1 1 58023F0F
P 5000 5500
F 0 "C119" H 5080 5310 60  0000 L BNN
	1    5000 5500
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:C_1210" H 5080 5310 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R53
U 1 1 58023F0E
P 1600 6400
F 0 "R53" V 1510 6355 60  0000 R TNN
F 1 "62k" V 1550 6290 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 1550 6290 60  0001 C CNN
F 3 "" H 1550 6290 60  0000 C CNN
	1    1600 6400
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:C-EUC1210 C120
U 1 1 58023F0D
P 5000 8700
F 0 "C120" H 5080 8510 60  0000 L BNN
	1    5000 8700
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:C_1210" H 5080 8510 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:EN6347QI U14
U 1 1 58023F0C
P 3100 5500
F 0 "U14" H 2740 6590 60  0000 L BNN
	1    3100 5500
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:QFN38" H 2740 6590 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:EN6347QI U15
U 1 1 58023F0B
P 3100 8700
F 0 "U15" H 2740 9790 60  0000 L BNN
	1    3100 8700
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:QFN38" H 2740 9790 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R52
U 1 1 58023F0A
P 1600 5200
F 0 "R52" V 1510 5155 60  0000 R TNN
F 1 "4.7k" V 1540 5120 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 1540 5120 60  0001 C CNN
F 3 "" H 1540 5120 60  0000 C CNN
	1    1600 5200
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R56
U 1 1 58023F09
P 4300 5100
F 0 "R56" V 4210 5055 60  0000 R TNN
F 1 "205k" V 4220 5360 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 4220 5360 60  0001 C CNN
F 3 "" H 4220 5360 60  0000 C CNN
	1    4300 5100
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R57
U 1 1 58023F08
P 4300 5700
F 0 "R57" V 4210 5655 60  0000 R TNN
F 1 "147k" V 4210 5610 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 4210 5610 60  0001 C CNN
F 3 "" H 4210 5610 60  0000 C CNN
	1    4300 5700
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R60
U 1 1 58023F07
P 5500 5600
F 0 "R60" V 5410 5555 60  0000 R TNN
F 1 "470" V 5450 5470 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 5450 5470 60  0001 C CNN
F 3 "" H 5450 5470 60  0000 C CNN
	1    5500 5600
	0    -1   -1   0
$EndComp
$Comp
L Cryptech_Alpha:BLM31PG330SN1_1206 FB5
U 1 1 58023F06
P 5800 4900
F 0 "FB5" H 5650 5100 60  0000 L BNN
F 1 "BLM31PG330SN1" H 5640 4810 60  0000 L BNN
F 2 "Cryptech_Alpha_Footprints:L_1206" H 5640 4810 60  0001 C CNN
F 3 "" H 5640 4810 60  0000 C CNN
	1    5800 4900
	1    0    0    -1
$EndComp
$Comp
L Cryptech_Alpha:C-EUC1210 C114
U 1 1 58023F05
P 1100 8400
F 0 "C114" H 1180 8210 60  0000 L BNN
	1    1100 8400
	1    0    0    -1
F 2 "Cryptech_Alpha_Footprints:C_1210" H 1180 8210 60  0001 C CNN
$EndComp
$Comp
L Cryptech_Alpha:R-EU_R0402 R55
U 1 1 58023F04
P 1600 9600
F 0 "R55" V 1510 9555 60  0000 R TNN
F 1 "62k" V 1570 9470 60  0000 R TNN
F 2 "Cryptech_Alpha_Footprints:R_0402" H 1570 9470 60  0001 C CNN
F 3 "" H 1570 9470 60  0000 C CNN
	1    1600 9600
	0    -1   -1   0
$EndComp
NoConn ~ 3900 5800
NoConn ~ 3900 9000
Wire Wire Line
      7000 4800 7000 4500
$Comp
L Cryptech_Alpha:FPGA_VCCAUX_1V8 #PWR?
U 1 1 5AF45C1F
P 7000 4500
F 0 "#PWR?" H 7000 4350 50  0001 C CNN
F 1 "FPGA_VCCAUX_1V8" H 7015 4673 50  0000 C CNN
F 2 "" H 7000 4500 60  0000 C CNN
F 3 "" H 7000 4500 60  0000 C CNN
      1    7000 4500
      1    0    0    -1
$EndComp
Wire Wire Line
      7000 8000 7000 7800
$Comp
L Cryptech_Alpha:VCCO_3V3 #PWR?
U 1 1 5AF49BC2
P 7000 7800
F 0 "#PWR?" H 7000 7650 50  0001 C CNN
F 1 "VCCO_3V3" H 7015 7973 50  0000 C CNN
F 2 "" H 7000 7800 60  0000 C CNN
F 3 "" H 7000 7800 60  0000 C CNN
      1    7000 7800
      1    0    0    -1
$EndComp
$Comp
L power:PWR_FLAG #FLG?
U 1 1 5AFA31D0
P 6050 4800
F 0 "#FLG?" H 6050 4875 50  0001 C CNN
F 1 "PWR_FLAG" H 6050 4974 50  0000 C CNN
F 2 "" H 6050 4800 50  0001 C CNN
F 3 "~" H 6050 4800 50  0001 C CNN
       1    6050 4800
       1    0    0    -1  
$EndComp
Connection ~ 6050 4800
$Comp
L power:PWR_FLAG #FLG?
U 1 1 5AFB3F33
P 6050 8000
F 0 "#FLG?" H 6050 8075 50  0001 C CNN
F 1 "PWR_FLAG" H 6050 8174 50  0000 C CNN
F 2 "" H 6050 8000 50  0001 C CNN
F 3 "~" H 6050 8000 50  0001 C CNN
       1    6050 8000
       1    0    0    -1  
$EndComp
Connection ~ 6050 8000
$EndSCHEMATC