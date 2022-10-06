
;CodeVisionAVR C Compiler V1.25.9 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega32
;Program type           : Application
;Clock frequency        : 4.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : Yes
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: Yes
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega32
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "td.vec"
	.INCLUDE "td.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x800)
	LDI  R25,HIGH(0x800)
	LDI  R26,0x60
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x85F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x85F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x260)
	LDI  R29,HIGH(0x260)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V2.03.4 Standard
;       4 Automatic Program Generator
;       5 © Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 
;       8 Project :
;       9 Version :
;      10 Date    : 11/8/2013
;      11 Author  :
;      12 Company :
;      13 Comments:
;      14 
;      15 
;      16 Chip type           : ATmega32
;      17 Program type        : Application
;      18 Clock frequency     : 4.000000 MHz
;      19 Memory model        : Small
;      20 External RAM size   : 0
;      21 Data Stack size     : 512
;      22 *****************************************************/
;      23 
;      24 #include <mega32.h>
;      25 	#ifndef __SLEEP_DEFINED__
	#ifndef __SLEEP_DEFINED__
;      26 	#define __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
;      27 	.EQU __se_bit=0x80
	.EQU __se_bit=0x80
;      28 	.EQU __sm_mask=0x70
	.EQU __sm_mask=0x70
;      29 	.EQU __sm_powerdown=0x20
	.EQU __sm_powerdown=0x20
;      30 	.EQU __sm_powersave=0x30
	.EQU __sm_powersave=0x30
;      31 	.EQU __sm_standby=0x60
	.EQU __sm_standby=0x60
;      32 	.EQU __sm_ext_standby=0x70
	.EQU __sm_ext_standby=0x70
;      33 	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_adc_noise_red=0x10
;      34 	.SET power_ctrl_reg=mcucr
	.SET power_ctrl_reg=mcucr
;      35 	#endif
	#endif
;      36 #include <delay.h>
;      37 unsigned char setting=0,dem=0,mode=0,dem1=0,daucham=2;
;      38 bit set_old;
;      39 bit up_old;
;      40 #include <khaibao.c>
;      41 //*****************************************************************************
;      42 #define ROW            PORTB         // chon hang khi quet man hinh led
;      43 #define R                   PORTB.5     // chan
;      44 #define SCLK           PORTB.3
;      45 #define CKL             PORTB.7
;      46 #define OE                PORTB.4
;      47 #define CASE_EFF  PORTD.0
;      48 #define CASE_MSG  PORTD.5
;      49 
;      50 // Khai bao cac bien su dung trong CT
;      51 bit load_effect; // "0" khong cho phep load du lieu cho hieu ung, "1" cho phép load
;      52 bit status_buf;   // "0" chon buf_screen_0[64], "1" chon buf_screen_1[64]
;      53 bit b_shift=0 ; // b_shift=0 Mac dinh dich du lieu tu man hinh led ra ngoai va tu flash vao man hinh led
;      54                         // b_shift=1 Luon chi dich du lieu tu man hinh led ra ngoai, không dich du lieu tu flash vao man hinh
;      55 unsigned  int    wb=4;   // do rong byte man hinh led
;      56 unsigned  int    r;
;      57 unsigned  int    count_byte;
_count_byte:
	.BYTE 0x2
;      58 unsigned  int    count_bit;
_count_bit:
	.BYTE 0x2
;      59 unsigned  int    i,j,k;
_i:
	.BYTE 0x2
_j:
	.BYTE 0x2
_k:
	.BYTE 0x2
;      60 unsigned  int    effect;
_effect:
	.BYTE 0x2
;      61 unsigned  int    check_effect;
_check_effect:
	.BYTE 0x2
;      62 unsigned  int    b_data;
_b_data:
	.BYTE 0x2
;      63 unsigned  int    row;
_row:
	.BYTE 0x2
;      64 unsigned char hour,min,sec,month,day,year;
_min:
	.BYTE 0x1
_sec:
	.BYTE 0x1
_month:
	.BYTE 0x1
_day:
	.BYTE 0x1
_year:
	.BYTE 0x1
;      65 // khai bao mang du lieu bo dem man hinh
;      66 unsigned char buf_screen_0[64];   // gia tri "64" la kich thuoc byte cho 1 modul 16x32 pixel
_buf_screen_0:
	.BYTE 0x40
;      67 unsigned char buf_screen_1[64];   //  Man hinh led co n modul thi gia tri tuong ung la n*64
_buf_screen_1:
	.BYTE 0x40
;      68 
;      69 //******************************************************************************************
;      70 #include <bitmap_flash.c>
;      71 // FONT LED MATRIX
;      72 flash unsigned  int msg1[]=

	.CSEG
;      73 {
;      74 /*------------------------------------------------------------------------------
;      75 ; If font display distortion, please check Fonts format of setup.
;      76 ; Source file / text :Khong gi la khong the
;      77 ; Width x Height (pixels) :122X16
;      78 ;  Font Format/Size : Monochrome LCD Fonts ,Horizontal scan ,Big endian order/256Byte
;      79 ;  Font make date  : 4/16/2013 4:59:36 PM
;      80 ------------------------------------------------------------------------------*/
;      81 0x7A,0x10,0x10,//Width pixels,Height pixels,Width bytes
;      82 0x00,0x00,0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x80,
;      83 0x00,0x00,0x40,0x00,0x00,0x08,0x02,0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x00,0x40,
;      84 0x01,0x00,0xA0,0x00,0x00,0x00,0x09,0x00,0x82,0x01,0x40,0x00,0x00,0x10,0x0C,0x80,
;      85 0x85,0x01,0x10,0x00,0x00,0x02,0x08,0x80,0x82,0x02,0x20,0x00,0x01,0x10,0x12,0x00,
;      86 0x89,0x00,0x00,0x00,0x00,0x00,0x08,0x00,0x82,0x00,0x00,0x00,0x01,0x10,0x00,0x00,
;      87 0x91,0x71,0xE5,0xC7,0xC0,0xFA,0x09,0xC0,0x8A,0xE3,0xCB,0x8F,0x83,0xD7,0x1E,0x00,
;      88 0xA1,0x8A,0x16,0x28,0x41,0x0A,0x08,0x20,0x93,0x14,0x2C,0x50,0x81,0x18,0xA1,0x00,
;      89 0xC1,0x0A,0x14,0x28,0x41,0x0A,0x08,0x20,0xA2,0x14,0x28,0x50,0x81,0x10,0xA1,0x00,
;      90 0xA1,0x0A,0x14,0x28,0x41,0x0A,0x09,0xE0,0xC2,0x14,0x28,0x50,0x81,0x10,0xBF,0x00,
;      91 0x91,0x0A,0x14,0x28,0x41,0x0A,0x0A,0x20,0xA2,0x14,0x28,0x50,0x81,0x10,0xA0,0x00,
;      92 0x89,0x0A,0x14,0x28,0xC1,0x1A,0x0A,0x20,0x92,0x14,0x28,0x51,0x81,0x10,0xA1,0x00,
;      93 0x85,0x09,0xE4,0x27,0x40,0xEA,0x09,0xE0,0x8A,0x13,0xC8,0x4E,0x80,0xD0,0x9E,0x00,
;      94 0x00,0x00,0x00,0x00,0x40,0x08,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x00,0x00,0x00,
;      95 0x00,0x00,0x00,0x07,0x80,0xF0,0x00,0x00,0x00,0x00,0x00,0x0F,0x00,0x00,0x00,0x00,
;      96 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
;      97 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
;      98 };
;      99 
;     100 //********************************************************************************
;     101 flash unsigned  int msg[]=
;     102 {
;     103  0x68, 0x98, 0x88, 0x60, 0x10, 0x88, 0xC8, 0xB0,//S
;     104  0xF8, 0x48, 0x50, 0x70, 0x50, 0x40, 0x48, 0xF8, //E
;     105 0x34, 0x4C, 0x84, 0x80, 0x80, 0x80, 0x44, 0x38, //C
;     106 
;     107 
;     108  0x88, 0xD8, 0xD8, 0xD8, 0xA8, 0xA8, 0xA8, 0x88, //M
;     109  0xE0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0xE0, //I
;     110 0xC8, 0x68,  0x68, 0x68, 0x58, 0x58, 0x58, 0xC8, //N
;     111 
;     112  0xD8, 0x50, 0x50, 0x70, 0x50, 0x50, 0x50, 0xD8, // H
;     113  0x70, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x70,  //O
;     114  0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x70, //U
;     115  0xF0, 0x48, 0x48, 0x70, 0x50, 0x50, 0x48, 0xC8, //R
;     116 
;     117  0x88, 0xD8, 0xD8, 0xD8, 0xA8, 0xA8, 0xA8, 0x88, //M
;     118  0x70, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x70,  //O
;     119  0xF0, 0x48, 0x48, 0x48, 0x48, 0x48, 0x48, 0xF0  //D
;     120  };
;     121 flash unsigned int font1[]={
;     122 0x70, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x70,  //0
;     123 0x20, 0xE0, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, //1
;     124 0x70, 0x88, 0x88, 0x10, 0x20, 0x40, 0x80, 0xF8,  //2
;     125 0x70, 0x88, 0x08, 0x70, 0x08, 0x08, 0x88, 0x70,  //3
;     126 0x30, 0x30, 0x50, 0x50, 0x90, 0xF8, 0x10, 0x10,  //4
;     127 0xF8, 0x80, 0x80, 0xF0, 0x08, 0x08, 0x88, 0x70,// 5
;     128 0x70, 0x88, 0x80, 0xF0, 0x88, 0x88, 0x88, 0x70,
;     129 0xF8, 0x08, 0x10, 0x10, 0x10, 0x20, 0x20, 0x20,
;     130 0x70, 0x88, 0x88, 0x70, 0x88, 0x88, 0x88, 0x70,
;     131 0x70, 0x88, 0x88, 0x88, 0x78, 0x08, 0x88, 0x70,
;     132 
;     133 0x00, 0x38, 0x44, 0x44, 0x44, 0x44, 0x44, 0x38,  //0
;     134 0x00, 0x20, 0x60, 0x20, 0x20, 0x20, 0x20, 0x70, //1
;     135 0x00, 0x38, 0x44, 0x04, 0x08, 0x10, 0x20, 0x7c,  //2
;     136 0x00, 0x38, 0x44, 0x04, 0x18, 0x04, 0x44, 0x38,  //3
;     137 0x00, 0x0c, 0x14, 0x24, 0x44, 0x7c, 0x04, 0x04,  //4
;     138 0x00, 0x7c, 0x40, 0x78, 0x04, 0x04, 0x44, 0x38,// 5
;     139 0x00, 0x38, 0x44, 0x40, 0x78, 0x44, 0x44, 0x38,
;     140 0x00, 0x7c, 0x44, 0x04, 0x08, 0x10, 0x10, 0x10,
;     141 0x00, 0x38, 0x44, 0x44, 0x38, 0x44, 0x44, 0x38,
;     142 0x00, 0x38, 0x44, 0x44, 0x3c, 0x04, 0x44, 0x38
;     143  };
;     144 #include <SpiMem.c>
;     145 // chuong trinh con spi mem
;     146 
;     147 /*----------------------------------------------------------------------------*/
;     148 // ctc chot du lieu
;     149 void latch_data(void)
;     150 {
_latch_data:
;     151   CKL=0;
	CBI  0x18,7
;     152   CKL=1;
	SBI  0x18,7
;     153 }
	RET
;     154 /*----------------------------------------------------------------------------*/
;     155 
;     156 /*----------------------------------------------------------------------------*/
;     157 // ctc dich du lieu
;     158 void Shift_data(void)
;     159 {
_Shift_data:
;     160   SCLK=0;
	CBI  0x18,3
;     161   SCLK=1;
	SBI  0x18,3
;     162 }
	RET
;     163 /*----------------------------------------------------------------------------*/
;     164 
;     165 void spi_mem(unsigned char data)
;     166 {
_spi_mem:
;     167         unsigned char n;
;     168         for(n=0x80;n!=0;n>>=1)  // SPI Data Order: MSB First
	ST   -Y,R17
;	data -> Y+1
;	n -> R17
	LDI  R17,LOW(128)
_0xE:
	CPI  R17,0
	BREQ _0xF
;     169         {
;     170                 R=~data&n;       //  ='0' khi data&n=0, ='1' khi data&n!=0
	LDD  R30,Y+1
	COM  R30
	MOV  R26,R30
	MOV  R30,R17
	CALL SUBOPT_0x0
	AND  R30,R26
	AND  R31,R27
	CPI  R30,0
	BRNE _0x10
	CBI  0x18,5
	RJMP _0x11
_0x10:
	SBI  0x18,5
_0x11:
;     171                 Shift_data();   // dich bit
	CALL _Shift_data
;     172         };
	LSR  R17
	RJMP _0xE
_0xF:
;     173 }
	LDD  R17,Y+0
	ADIW R28,2
	RET
;     174 
;     175 
;     176 #include <ScreenScan.c>
;     177 //*****************************************************************************
;     178 
;     179 
;     180 
;     181 /*----------------------------------------------------------------------------*/
;     182 // ctc hien thi du lieu ra man hinh
;     183 void scan_screen(void)
;     184 {
_scan_screen:
;     185   OE=1;  //  "0" thi enalbe 74138, "1" disable 74138
	SBI  0x18,4
;     186 if(dem==0)
	TST  R4
	BREQ PC+3
	JMP _0x14
;     187   for(i=0;i<wb;i++)
	LDI  R30,0
	STS  _i,R30
	STS  _i+1,R30
_0x16:
	CALL SUBOPT_0x1
	CP   R26,R10
	CPC  R27,R11
	BRLO PC+3
	JMP _0x17
;     188  {
;     189    if(i==0)
	CALL SUBOPT_0x2
	SBIW R30,0
	BRNE _0x18
;     190   {
;     191     spi_mem(buf_screen_1[(r+12)+i]);
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
;     192     spi_mem(buf_screen_1[(r+8)+i]);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x4
;     193     spi_mem(buf_screen_1[(r+4)+i]);
	CALL SUBOPT_0x6
	CALL SUBOPT_0x4
;     194     spi_mem(buf_screen_1[(r+0)+i]);
	CALL SUBOPT_0x7
	CALL SUBOPT_0x8
;     195   }
;     196    if(i==1)
_0x18:
	CALL SUBOPT_0x1
	SBIW R26,1
	BRNE _0x19
;     197   {
;     198     spi_mem(buf_screen_1[(r+12)+i+15]);
	CALL SUBOPT_0x3
	CALL SUBOPT_0x9
;     199     spi_mem(buf_screen_1[(r+8)+i+15]);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x9
;     200     spi_mem(buf_screen_1[(r+4)+i+15]);
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
;     201     spi_mem(buf_screen_1[(r+0)+i+15]);
	CALL SUBOPT_0x7
	__ADDW1MN _buf_screen_1,15
	CALL SUBOPT_0xA
;     202   }
;     203   if(i==2)
_0x19:
	CALL SUBOPT_0x1
	SBIW R26,2
	BRNE _0x1A
;     204   {
;     205     spi_mem(buf_screen_1[(r+12)+i+30]);
	CALL SUBOPT_0x3
	CALL SUBOPT_0xB
;     206     spi_mem(buf_screen_1[(r+8)+i+30]);
	MOVW R30,R12
	CALL SUBOPT_0x5
	CALL SUBOPT_0xB
;     207     spi_mem(buf_screen_1[(r+4)+i+30]);
	MOVW R30,R12
	CALL SUBOPT_0x6
	CALL SUBOPT_0xB
;     208     spi_mem(buf_screen_1[(r+0)+i+30]);
	MOVW R30,R12
	CALL SUBOPT_0x7
	CALL SUBOPT_0xB
;     209   }
;     210       if(i==3)
_0x1A:
	CALL SUBOPT_0x1
	SBIW R26,3
	BRNE _0x1B
;     211   {
;     212     spi_mem(buf_screen_1[(r+12)+i+45]);
	CALL SUBOPT_0x3
	CALL SUBOPT_0xC
;     213     spi_mem(buf_screen_1[(r+8)+i+45]);
	MOVW R30,R12
	CALL SUBOPT_0x5
	CALL SUBOPT_0xC
;     214     spi_mem(buf_screen_1[(r+4)+i+45]);
	MOVW R30,R12
	CALL SUBOPT_0x6
	CALL SUBOPT_0xC
;     215     spi_mem(buf_screen_1[(r+0)+i+45]);
	MOVW R30,R12
	CALL SUBOPT_0x7
	CALL SUBOPT_0xC
;     216   }
;     217  };
_0x1B:
	CALL SUBOPT_0xD
	RJMP _0x16
_0x17:
_0x14:
;     218  if(dem==1)
	LDI  R30,LOW(1)
	CP   R30,R4
	BRNE _0x1C
;     219  for(i=0;i<wb;i++)
	LDI  R30,0
	STS  _i,R30
	STS  _i+1,R30
_0x1E:
	CALL SUBOPT_0x1
	CP   R26,R10
	CPC  R27,R11
	BRSH _0x1F
;     220  {
;     221    if(status_buf)
	SBRS R2,3
	RJMP _0x20
;     222   {
;     223     spi_mem(buf_screen_1[(r+12)*wb+i]);
	CALL SUBOPT_0xE
	CALL SUBOPT_0x8
;     224     spi_mem(buf_screen_1[(r+8)*wb+i]);
	CALL SUBOPT_0xF
	CALL SUBOPT_0x8
;     225     spi_mem(buf_screen_1[(r+4)*wb+i]);
	CALL SUBOPT_0x10
	CALL SUBOPT_0x8
;     226     spi_mem(buf_screen_1[(r+0)*wb+i]);
	CALL SUBOPT_0x11
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	RJMP _0xA4
;     227   }
;     228   else
_0x20:
;     229   {
;     230     spi_mem(buf_screen_0[(r+12)*wb+i]);
	CALL SUBOPT_0xE
	CALL SUBOPT_0x12
;     231     spi_mem(buf_screen_0[(r+8)*wb+i]);
	CALL SUBOPT_0xF
	CALL SUBOPT_0x12
;     232     spi_mem(buf_screen_0[(r+4)*wb+i]);
	CALL SUBOPT_0x10
	CALL SUBOPT_0x12
;     233     spi_mem(buf_screen_0[(r+0)*wb+i]);
	CALL SUBOPT_0x11
	SUBI R30,LOW(-_buf_screen_0)
	SBCI R31,HIGH(-_buf_screen_0)
_0xA4:
	LD   R30,Z
	ST   -Y,R30
	CALL _spi_mem
;     234   };
;     235  };
	CALL SUBOPT_0xD
	RJMP _0x1E
_0x1F:
_0x1C:
;     236  latch_data();
	CALL _latch_data
;     237  ROW=r; // hang thu r duoc hien thi
	MOVW R30,R12
	OUT  0x18,R30
;     238  OE=0; // enable 74138
	CBI  0x18,4
;     239  r++;
	ADIW R30,1
	MOVW R12,R30
;     240  if (r==4)
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x24
;     241  {
;     242    r=0;
	CLR  R12
	CLR  R13
;     243  }
;     244 }
_0x24:
	RET
;     245 
;     246 /*----------------------------------------------------------------------------*/
;     247 
;     248 //*******************************************************************************
;     249 #include <delay.h>
;     250 #define SET  PINC.4
;     251 #define UP   PINC.3
;     252 // I2C Bus functions
;     253 #asm
;     254    .equ __i2c_port=0x15 ;PORTC
   .equ __i2c_port=0x15 ;PORTC
;     255    .equ __sda_bit=1
   .equ __sda_bit=1
;     256    .equ __scl_bit=0
   .equ __scl_bit=0
;     257 #endasm
;     258 #include <i2c.h>
;     259 // DS1307 Real Time Clock functions
;     260 #include <ds1307.h>
;     261 
;     262 // Cac chuong trinh tao hieu ung cho led matrix
;     263 #include <ShiftLeft.c>
;     264 //******************************************************************
;     265 // Hieu ung dich trai msg
;     266 /*----------------------------------------------------------------------------*/
;     267  // ctc cap nhat byte du lieu de dich trai
;     268  void up_data_1(void)
;     269  {
_up_data_1:
;     270  // b_shift=0: dich du lieu man hinh ra ngoai, va tu flash vao trong man hinh
;     271  // b_shft=1: chi dich du lieu man hinh ra ngoai => b_data luôn luôn=0
;     272    if ((b_shift==1)||(count_byte>=msg1[2]))
	SBRC R2,4
	RJMP _0x26
	CALL SUBOPT_0x13
	BRLO _0x25
_0x26:
;     273    {
;     274      b_data=0;
	LDI  R30,0
	STS  _b_data,R30
	STS  _b_data+1,R30
;     275    }
;     276    else
	RJMP _0x28
_0x25:
;     277    {
;     278      if ((b_shift==0)&&(count_byte<msg1[2]))
	SBRC R2,4
	RJMP _0x2A
	CALL SUBOPT_0x13
	BRLO _0x2B
_0x2A:
	RJMP _0x29
_0x2B:
;     279      {
;     280        b_data=(msg1[row*msg1[2]+count_byte+3]<<count_bit);
	__POINTW1FN _msg1,4
	CALL __GETW1PF
	CALL SUBOPT_0x14
	CALL __MULW12U
	LDS  R26,_count_byte
	LDS  R27,_count_byte+1
	ADD  R30,R26
	ADC  R31,R27
	LSL  R30
	ROL  R31
	__ADDW1FN _msg1,6
	CALL __GETW1PF
	MOVW R26,R30
	LDS  R30,_count_bit
	LDS  R31,_count_bit+1
	CALL __LSLW12
	STS  _b_data,R30
	STS  _b_data+1,R31
;     281      }
;     282    };
_0x29:
_0x28:
;     283  }
	RET
;     284  /*----------------------------------------------------------------------------*/
;     285 
;     286  /*----------------------------------------------------------------------------*/
;     287  // ctc dich trai chuoi msg tren led matrix
;     288  void effect_1(void)
;     289  {
_effect_1:
;     290    /*******************************************************************************
;     291     -Thuat giai dich trai chuoi tren led matrix: coi msg la phan man hinh ao ben phai man hinh led thuc
;     292     +  Moi byte tren 1 hang dich sang trai 1 bit
;     293     +  Bit 0 cua byte bat ki duoc thay boi bit 7 cua byte lien truoc (khi chua dich)
;     294    *******************************************************************************/
;     295   if(load_effect)
	SBRS R2,2
	RJMP _0x2C
;     296   {
;     297     if(status_buf)  // khi dang quet hien thi o bo dem 1 thi sap sep du lieu o bo dem 0
	SBRS R2,3
	RJMP _0x2D
;     298     {
;     299       // Gia su man hinh led co kich thuoc ngang wb byte
;     300       for(row=0; row<16; row++)
	LDI  R30,0
	STS  _row,R30
	STS  _row+1,R30
_0x2F:
	CALL SUBOPT_0x14
	SBIW R26,16
	BRSH _0x30
;     301       {
;     302         // chuyen du lieu giua cac byte trong bo dem man hinh
;     303         for(j=0;j<wb-1;j++)
	LDI  R30,0
	STS  _j,R30
	STS  _j+1,R30
_0x32:
	CALL SUBOPT_0x15
	BRSH _0x33
;     304         {
;     305           buf_screen_0[row*wb+j]=(buf_screen_1[row*wb+j]<<1)|(buf_screen_1[row*wb+j+1]>>7);
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
	SUBI R30,LOW(-_buf_screen_0)
	SBCI R31,HIGH(-_buf_screen_0)
	__PUTW1R 23,24
	MOVW R30,R26
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	LD   R30,Z
	LSL  R30
	MOV  R22,R30
	MOVW R30,R0
	__ADDW1MN _buf_screen_1,1
	CALL SUBOPT_0x18
;     306         };
	CALL SUBOPT_0x19
	RJMP _0x32
_0x33:
;     307         //chuyen du lieu tu msg vao bo dem man hinh
;     308         up_data_1(); //   update du lieu cho b_data o hieu ung 1
	CALL _up_data_1
;     309         buf_screen_0[row*wb+wb-1]=(buf_screen_1[row*wb+wb-1]<<1)|(b_data>>7);
	CALL SUBOPT_0x16
	ADD  R30,R10
	ADC  R31,R11
	SBIW R30,1
	MOVW R26,R30
	SUBI R30,LOW(-_buf_screen_0)
	SBCI R31,HIGH(-_buf_screen_0)
	MOVW R22,R30
	MOVW R30,R26
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	CALL SUBOPT_0x1A
;     310       };
	CALL SUBOPT_0x1B
	RJMP _0x2F
_0x30:
;     311     }
;     312      // khi dang quet hien thi o bo dem 1 thi sap sep du lieu o bo dem 0
;     313     else
	RJMP _0x34
_0x2D:
;     314     {
;     315       // Gia su man hinh led co kich thuoc ngang wb byte
;     316       for(row=0; row<16; row++)
	LDI  R30,0
	STS  _row,R30
	STS  _row+1,R30
_0x36:
	CALL SUBOPT_0x14
	SBIW R26,16
	BRSH _0x37
;     317       {
;     318         // chuyen du lieu giua cac byte trong bo dem man hinh
;     319         for(j=0;j<wb-1;j++)
	LDI  R30,0
	STS  _j,R30
	STS  _j+1,R30
_0x39:
	CALL SUBOPT_0x15
	BRSH _0x3A
;     320         {
;     321           buf_screen_1[row*wb+j]=(buf_screen_0[row*wb+j]<<1)|(buf_screen_0[row*wb+j+1]>>7);
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	__PUTW1R 23,24
	MOVW R30,R26
	SUBI R30,LOW(-_buf_screen_0)
	SBCI R31,HIGH(-_buf_screen_0)
	LD   R30,Z
	LSL  R30
	MOV  R22,R30
	MOVW R30,R0
	__ADDW1MN _buf_screen_0,1
	CALL SUBOPT_0x18
;     322         };
	CALL SUBOPT_0x19
	RJMP _0x39
_0x3A:
;     323         //chuyen du lieu tu msg vao bo dem man hinh
;     324         up_data_1(); //   update du lieu cho b_data o hieu ung 1
	CALL _up_data_1
;     325         buf_screen_1[row*wb+wb-1]=(buf_screen_0[row*wb+wb-1]<<1)|(b_data>>7);
	CALL SUBOPT_0x16
	ADD  R30,R10
	ADC  R31,R11
	SBIW R30,1
	MOVW R26,R30
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	MOVW R22,R30
	MOVW R30,R26
	SUBI R30,LOW(-_buf_screen_0)
	SBCI R31,HIGH(-_buf_screen_0)
	CALL SUBOPT_0x1A
;     326       };
	CALL SUBOPT_0x1B
	RJMP _0x36
_0x37:
;     327      };
_0x34:
;     328      load_effect=0; // Da load xong du lieu moi, tam khoa load du lieu cho lan tiep theo
	CLT
	BLD  R2,2
;     329    }
;     330  }
_0x2C:
	RET
;     331 /*----------------------------------------------------------------------------*/
;     332 
;     333 
;     334 //******************************************************************
;     335 //#include <ShiftRight.c>
;     336 //#include <ShiftUp.c>
;     337 //#include <ShiftDown.c>
;     338 #include <CheckEffect.c>
;     339 //************************************************************************
;     340 
;     341 /*----------------------------------------------------------------------------*/
;     342  // ctc kiem tra su  dich chuyen hieu ung trai & phai
;     343  void check_effect_12(unsigned int stop_byte)
;     344  {
_check_effect_12:
;     345    // doan ctc kiem soát so bit chuyen dich
;     346    k++;
;	stop_byte -> Y+0
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1D
;     347    if(k==1)  // thoi gian dich hieu ung
	CALL SUBOPT_0x1E
	SBIW R26,1
	BRNE _0x3B
;     348    {
;     349      if(load_effect==0)    // Du lieu moi da load
	SBRC R2,2
	RJMP _0x3C
;     350      {
;     351       count_bit++;
	LDS  R30,_count_bit
	LDS  R31,_count_bit+1
	ADIW R30,1
	STS  _count_bit,R30
	STS  _count_bit+1,R31
;     352       if(count_bit==8)
	LDS  R26,_count_bit
	LDS  R27,_count_bit+1
	SBIW R26,8
	BRNE _0x3D
;     353       {
;     354         count_bit=0;
	LDI  R30,0
	STS  _count_bit,R30
	STS  _count_bit+1,R30
;     355         count_byte++;
	LDS  R30,_count_byte
	LDS  R31,_count_byte+1
	ADIW R30,1
	STS  _count_byte,R30
	STS  _count_byte+1,R31
;     356         if(count_byte==stop_byte)  // stop_byte=so byte can dich cua msg+wb(so byte man hinh led)
	LD   R30,Y
	LDD  R31,Y+1
	LDS  R26,_count_byte
	LDS  R27,_count_byte+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x3E
;     357         {
;     358           count_byte=0;
	LDI  R30,0
	STS  _count_byte,R30
	STS  _count_byte+1,R30
;     359           effect++;
	LDS  R30,_effect
	LDS  R31,_effect+1
	ADIW R30,1
	STS  _effect,R30
	STS  _effect+1,R31
;     360           dem=0;
	CLR  R4
;     361         }
;     362       }
_0x3E:
;     363       status_buf=~status_buf;  // dao man hinh hien thi
_0x3D:
	LDI  R30,LOW(8)
	EOR  R2,R30
;     364       load_effect=1; // tiêp tuc cho phep load du lieu cho hieu ung
	SET
	BLD  R2,2
;     365       k=0;
	CALL SUBOPT_0x1F
;     366 
;     367      }
;     368    }
_0x3C:
;     369  }
_0x3B:
	ADIW R28,2
	RET
;     370  /*----------------------------------------------------------------------------*/
;     371 
;     372 
;     373 
;     374 
;     375 void timedeal(void);
;     376 
;     377 /*----------------------------------------------------------------------------*/
;     378 // ctc lua chon hieu ung hien thi
;     379 /*
;     380 void case_effect(void)
;     381 {
;     382   switch (effect)
;     383   {
;     384     case 0:
;     385              check_effect=1;
;     386              effect_3();
;     387              break;
;     388 
;     389    case 1:
;     390              check_effect=0;
;     391              effect_1();
;     392              break;
;     393    case 2:
;     394              check_effect=1;
;     395              effect_4();
;     396              break;
;     397 
;     398    case 3:
;     399              check_effect=0;
;     400              effect_2();
;     401              break;
;     402    default:
;     403             if(effect==4)
;     404             {
;     405              effect=0;
;     406             }
;     407   };
;     408 }  */
;     409 /*----------------------------------------------------------------------------*/
;     410 
;     411 
;     412 /*----------------------------------------------------------------------------*/
;     413 // ctc lua chon hieu ung hien thi
;     414 void case_check_effect(void)
;     415 {
_case_check_effect:
;     416   check_effect_12(msg1[2]+4);
	__POINTW1FN _msg1,4
	CALL __GETW1PF
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	CALL _check_effect_12
;     417 }
	RET
;     418 /*----------------------------------------------------------------------------*/
;     419 
;     420 
;     421 
;     422  /*----------------------------------------------------------------------------*/
;     423  // Declare your global variables here
;     424 unsigned char giaima(unsigned char so)
;     425 {
_giaima:
;     426 switch(so)
;	so -> Y+0
	LD   R30,Y
	LDI  R31,0
;     427 {
;     428 case 0 : return 0;
	SBIW R30,0
	BRNE _0x42
	LDI  R30,LOW(0)
	RJMP _0xA3
;     429 case 1 : return 8;
_0x42:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x43
	LDI  R30,LOW(8)
	RJMP _0xA3
;     430 case 2 : return 16;
_0x43:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x44
	LDI  R30,LOW(16)
	RJMP _0xA3
;     431 case 3 : return 24;
_0x44:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x45
	LDI  R30,LOW(24)
	RJMP _0xA3
;     432 case 4 : return 32;
_0x45:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x46
	LDI  R30,LOW(32)
	RJMP _0xA3
;     433 case 5 : return 40;
_0x46:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x47
	LDI  R30,LOW(40)
	RJMP _0xA3
;     434 case 6 : return 48;
_0x47:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x48
	LDI  R30,LOW(48)
	RJMP _0xA3
;     435 case 7 : return 56;
_0x48:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x49
	LDI  R30,LOW(56)
	RJMP _0xA3
;     436 case 8 : return 64;
_0x49:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x4A
	LDI  R30,LOW(64)
	RJMP _0xA3
;     437 case 9 : return 72;
_0x4A:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x41
	LDI  R30,LOW(72)
;     438 }
_0x41:
;     439 }
_0xA3:
	ADIW R28,1
	RET
;     440 // Timer 0 output compare interrupt service routine
;     441 interrupt [TIM0_COMP] void timer0_comp_isr(void)
;     442 {
_timer0_comp_isr:
	CALL SUBOPT_0x20
;     443 dem1++;
	INC  R6
;     444 dem1=dem1%20;
	MOV  R26,R6
	LDI  R30,LOW(20)
	CALL __MODB21U
	MOV  R6,R30
;     445 if(dem1<10) {
	LDI  R30,LOW(10)
	CP   R6,R30
	BRSH _0x4C
;     446 daucham=0;
	CLR  R9
;     447 }
;     448 else  daucham=2;
	RJMP _0x4D
_0x4C:
	LDI  R30,LOW(2)
	MOV  R9,R30
;     449  // Place your code here
;     450 if(dem==1)case_check_effect();
_0x4D:
	LDI  R30,LOW(1)
	CP   R30,R4
	BRNE _0x4E
	CALL _case_check_effect
;     451 else
	RJMP _0x4F
_0x4E:
;     452 {
;     453 if(!SET && SET!=set_old) //check the set key
	SBIC 0x13,4
	RJMP _0x51
	LDI  R30,0
	SBIC 0x13,4
	LDI  R30,1
	MOV  R26,R30
	LDI  R30,0
	SBRC R2,0
	LDI  R30,1
	CALL SUBOPT_0x0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x52
_0x51:
	RJMP _0x50
_0x52:
;     454 {
;     455 setting++;
	INC  R5
;     456 if(setting==5){
	LDI  R30,LOW(5)
	CP   R30,R5
	BRNE _0x53
;     457 setting=0;
	CLR  R5
;     458 }
;     459 rtc_set_time(hour,min,sec);
_0x53:
	ST   -Y,R8
	LDS  R30,_min
	ST   -Y,R30
	LDS  R30,_sec
	ST   -Y,R30
	RCALL _rtc_set_time
;     460 rtc_set_date(day,month,year);
	LDS  R30,_day
	ST   -Y,R30
	LDS  R30,_month
	ST   -Y,R30
	LDS  R30,_year
	ST   -Y,R30
	RCALL _rtc_set_date
;     461 }
;     462 if(setting==0)
_0x50:
	TST  R5
	BRNE _0x54
;     463 {
;     464 
;     465 rtc_get_time(&hour,&min,&sec);
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_min)
	LDI  R31,HIGH(_min)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sec)
	LDI  R31,HIGH(_sec)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _rtc_get_time
;     466 rtc_get_date(&day,&month,&year);
	LDI  R30,LOW(_day)
	LDI  R31,HIGH(_day)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_month)
	LDI  R31,HIGH(_month)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_year)
	LDI  R31,HIGH(_year)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _rtc_get_date
;     467 }
;     468 if(setting==1)
_0x54:
	LDI  R30,LOW(1)
	CP   R30,R5
	BRNE _0x55
;     469 {
;     470 if(!UP && UP!=up_old) //check the up key
	SBIC 0x13,3
	RJMP _0x57
	CALL SUBOPT_0x21
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x58
_0x57:
	RJMP _0x56
_0x58:
;     471 {
;     472 sec++;
	CALL SUBOPT_0x22
;     473 timedeal();
;     474 }
;     475 if(!UP && UP!=up_old) //check the up key
_0x56:
	SBIC 0x13,3
	RJMP _0x5A
	CALL SUBOPT_0x21
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x5B
_0x5A:
	RJMP _0x59
_0x5B:
;     476 {
;     477 sec++;
	CALL SUBOPT_0x22
;     478 timedeal();
;     479 }
;     480 }else if(setting==2)
_0x59:
	RJMP _0x5C
_0x55:
	LDI  R30,LOW(2)
	CP   R30,R5
	BRNE _0x5D
;     481 {
;     482 if(!UP && UP!=up_old) //check the up key
	SBIC 0x13,3
	RJMP _0x5F
	CALL SUBOPT_0x21
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x60
_0x5F:
	RJMP _0x5E
_0x60:
;     483 {
;     484 min++;
	LDS  R30,_min
	SUBI R30,-LOW(1)
	STS  _min,R30
;     485 timedeal();
	RCALL _timedeal
;     486 }
;     487 }else if(setting==3)
_0x5E:
	RJMP _0x61
_0x5D:
	LDI  R30,LOW(3)
	CP   R30,R5
	BRNE _0x62
;     488 {
;     489 if(!UP && UP!=up_old) //check the up key
	SBIC 0x13,3
	RJMP _0x64
	CALL SUBOPT_0x21
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x65
_0x64:
	RJMP _0x63
_0x65:
;     490 {
;     491 hour++;
	INC  R8
;     492 timedeal();
	RCALL _timedeal
;     493 }
;     494 }
_0x63:
;     495 else if(setting==4)
	RJMP _0x66
_0x62:
	LDI  R30,LOW(4)
	CP   R30,R5
	BRNE _0x67
;     496 {
;     497 if(!UP && UP!=up_old) //check the up key
	SBIC 0x13,3
	RJMP _0x69
	CALL SUBOPT_0x21
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x6A
_0x69:
	RJMP _0x68
_0x6A:
;     498 {
;     499 mode++;
	INC  R7
;     500 if(mode>2) mode=0;
	LDI  R30,LOW(2)
	CP   R30,R7
	BRSH _0x6B
	CLR  R7
;     501 }
_0x6B:
;     502 }
_0x68:
;     503 set_old=SET;
_0x67:
_0x66:
_0x61:
_0x5C:
	CLT
	SBIC 0x13,4
	SET
	BLD  R2,0
;     504 up_old=UP;
	CLT
	SBIC 0x13,3
	SET
	BLD  R2,1
;     505 }
_0x4F:
;     506 }
	RJMP _0xA5
;     507 /*----------------------------------------------------------------------------*/
;     508 
;     509 
;     510 
;     511 /*----------------------------------------------------------------------------*/
;     512 // Timer 1 output compare A interrupt service routine
;     513 // Dung timer 1 de scan led matrix
;     514 interrupt [TIM1_COMPA] void timer1_compa_isr(void)
;     515 {
_timer1_compa_isr:
	CALL SUBOPT_0x20
;     516  // Place your code here
;     517    // Doc gio, phut, giay tu ds1307
;     518   scan_screen();
	CALL _scan_screen
;     519 
;     520 }
_0xA5:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;     521 /*----------------------------------------------------------------------------*/
;     522 
;     523 
;     524 void main(void)
;     525 {
_main:
;     526 #include <ConfigSet.c>
;     527 //////////////////
;     528 PORTA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1B,R30
;     529 DDRA=0xFF;
	OUT  0x1A,R30
;     530 
;     531 PORTB=0xFF;
	OUT  0x18,R30
;     532 DDRB=0xFF;    // PORTB lam dau ra
	OUT  0x17,R30
;     533 
;     534 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     535 DDRC=0x00;    // PORTC lam dau ra
	OUT  0x14,R30
;     536 
;     537 PORTD=0xFF;
	LDI  R30,LOW(255)
	OUT  0x12,R30
;     538 DDRD=0xFF;
	OUT  0x11,R30
;     539 
;     540 // Timer/Counter 0 initialization
;     541 // Clock source: System Clock
;     542 // Clock value: 3.906 kHz
;     543 // Mode: CTC top=OCR0
;     544 // OC0 output: Disconnected
;     545 TCCR0=0x0D;
	LDI  R30,LOW(13)
	OUT  0x33,R30
;     546 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
;     547 OCR0=0xAF;
	LDI  R30,LOW(175)
	OUT  0x3C,R30
;     548 
;     549 // Timer/Counter 1 initialization
;     550 // Clock source: System Clock
;     551 // Clock value: 3.906 kHz
;     552 // Mode: CTC top=OCR1A
;     553 // OC1A output: Discon.
;     554 // OC1B output: Discon.
;     555 // Noise Canceler: Off
;     556 // Input Capture on Falling Edge
;     557 // Timer 1 Overflow Interrupt: Off
;     558 // Input Capture Interrupt: Off
;     559 // Compare A Match Interrupt: On
;     560 // Compare B Match Interrupt: Off
;     561 TCCR1A=0x00;
	LDI  R30,LOW(0)
	OUT  0x2F,R30
;     562 TCCR1B=0x0D;
	LDI  R30,LOW(13)
	OUT  0x2E,R30
;     563 TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;     564 TCNT1L=0x00;
	OUT  0x2C,R30
;     565 ICR1H=0x00;
	OUT  0x27,R30
;     566 ICR1L=0x00;
	OUT  0x26,R30
;     567 OCR1AH=0x00;
	OUT  0x2B,R30
;     568 OCR1AL=0x0F;
	LDI  R30,LOW(15)
	OUT  0x2A,R30
;     569 OCR1BH=0x00;
	LDI  R30,LOW(0)
	OUT  0x29,R30
;     570 OCR1BL=0x00;
	OUT  0x28,R30
;     571 
;     572 // Timer(s)/Counter(s) Interrupt(s) initialization
;     573 TIMSK=0x12;
	LDI  R30,LOW(18)
	OUT  0x39,R30
;     574 
;     575 // Analog Comparator initialization
;     576 // Analog Comparator: Off
;     577 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     578 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     579 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;     580 /*
;     581 // SPI initialization
;     582 // SPI Type: Master
;     583 // SPI Clock Rate: 2*1000.000 kHz
;     584 // SPI Clock Phase: Cycle Half
;     585 // SPI Clock Polarity: Low
;     586 // SPI Data Order: MSB First
;     587 SPCR=0x50;
;     588 SPSR=0x01;
;     589 */
;     590 // Global enable interrupts
;     591 i2c_init();
	CALL _i2c_init
;     592 rtc_init(0,1,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _rtc_init
;     593 #asm("sei")
	sei
;     594 dem=1;
	LDI  R30,LOW(1)
	MOV  R4,R30
;     595 //rtc_set_date(17,8,13);
;     596 while (1)
_0x6C:
;     597       {
;     598   if(dem==1)
	LDI  R30,LOW(1)
	CP   R30,R4
	BRNE _0x6F
;     599   {
;     600        check_effect=0;
	LDI  R30,0
	STS  _check_effect,R30
	STS  _check_effect+1,R30
;     601        effect_1();
	CALL _effect_1
;     602        }
;     603    else
	RJMP _0x70
_0x6F:
;     604    {
;     605          if(setting==0)
	TST  R5
	BREQ PC+3
	JMP _0x71
;     606          {
;     607             if(mode==0)
	TST  R7
	BREQ PC+3
	JMP _0x72
;     608               for(k=0;k<8;k++)
	CALL SUBOPT_0x1F
_0x74:
	CALL SUBOPT_0x1E
	SBIW R26,8
	BRLO PC+3
	JMP _0x75
;     609             {
;     610                 buf_screen_1[k]=font1[giaima(hour/10)+k];
	CALL SUBOPT_0x23
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	POP  R26
	POP  R27
	CALL SUBOPT_0x26
;     611                 buf_screen_1[k+8]=0x00;
;     612                 buf_screen_1[k+16]=font1[giaima(hour%10)+k];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x27
	CALL SUBOPT_0x25
	POP  R26
	POP  R27
	CALL SUBOPT_0x28
;     613                 buf_screen_1[k+24]=font1[giaima(sec/10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x29
	POP  R26
	POP  R27
	CALL SUBOPT_0x2A
;     614                 buf_screen_1[k+32]=font1[giaima(min/10)+k];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x25
	POP  R26
	POP  R27
	CALL SUBOPT_0x2C
;     615                 buf_screen_1[k+40]=font1[giaima(sec%10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2D
	POP  R26
	POP  R27
	CALL SUBOPT_0x2E
;     616                 buf_screen_1[k+48]=font1[giaima(min%10)+k];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x25
	POP  R26
	POP  R27
	CALL SUBOPT_0x30
;     617                 buf_screen_1[k+56]=0x00;
;     618                 if((k+16)==17)buf_screen_1[17]+=daucham;
	BRNE _0x76
	CALL SUBOPT_0x31
	CALL SUBOPT_0x32
;     619                 if((k+16)==18)buf_screen_1[18]+=daucham;
_0x76:
	CALL SUBOPT_0x33
	BRNE _0x77
	CALL SUBOPT_0x34
	CALL SUBOPT_0x32
;     620                 if((k+16)==21)buf_screen_1[21]+=daucham;
_0x77:
	CALL SUBOPT_0x35
	BRNE _0x78
	CALL SUBOPT_0x36
	CALL SUBOPT_0x32
;     621                 if((k+16)==22)buf_screen_1[22]+=daucham;
_0x78:
	CALL SUBOPT_0x37
	BRNE _0x79
	CALL SUBOPT_0x38
	CALL SUBOPT_0x32
;     622             }
_0x79:
	CALL SUBOPT_0x39
	RJMP _0x74
_0x75:
;     623              if(mode==1)
_0x72:
	LDI  R30,LOW(1)
	CP   R30,R7
	BREQ PC+3
	JMP _0x7A
;     624               for(k=0;k<8;k++)
	CALL SUBOPT_0x1F
_0x7C:
	CALL SUBOPT_0x1E
	SBIW R26,8
	BRLO PC+3
	JMP _0x7D
;     625             {
;     626                 buf_screen_1[k]=font1[giaima(hour/10)+k+80];
	CALL SUBOPT_0x23
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x24
	CALL SUBOPT_0x3A
	POP  R26
	POP  R27
	CALL SUBOPT_0x26
;     627                 buf_screen_1[k+8]=0x00;
;     628                 buf_screen_1[k+16]=font1[giaima(hour%10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x27
	CALL SUBOPT_0x3A
	POP  R26
	POP  R27
	CALL SUBOPT_0x28
;     629                 buf_screen_1[k+24]=0x00;
	CALL SUBOPT_0x3B
;     630                 buf_screen_1[k+32]=font1[giaima(min/10)+k+80];
	__ADDW1MN _buf_screen_1,32
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x3A
	POP  R26
	POP  R27
	CALL SUBOPT_0x2C
;     631                 buf_screen_1[k+40]=0x00;
	CALL SUBOPT_0x3B
;     632                 buf_screen_1[k+48]=font1[giaima(min%10)+k+80];
	__ADDW1MN _buf_screen_1,48
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x3A
	POP  R26
	POP  R27
	CALL SUBOPT_0x30
;     633                 buf_screen_1[k+56]=0x00;
;     634                 if((k+16)==17)buf_screen_1[17]+=daucham;
	BRNE _0x7E
	CALL SUBOPT_0x31
	CALL SUBOPT_0x32
;     635                 if((k+16)==18)buf_screen_1[18]+=daucham;
_0x7E:
	CALL SUBOPT_0x33
	BRNE _0x7F
	CALL SUBOPT_0x34
	CALL SUBOPT_0x32
;     636                 if((k+16)==21)buf_screen_1[21]+=daucham;
_0x7F:
	CALL SUBOPT_0x35
	BRNE _0x80
	CALL SUBOPT_0x36
	CALL SUBOPT_0x32
;     637                 if((k+16)==22)buf_screen_1[22]+=daucham;
_0x80:
	CALL SUBOPT_0x37
	BRNE _0x81
	CALL SUBOPT_0x38
	CALL SUBOPT_0x32
;     638             }
_0x81:
	CALL SUBOPT_0x39
	RJMP _0x7C
_0x7D:
;     639             if(mode==2)
_0x7A:
	LDI  R30,LOW(2)
	CP   R30,R7
	BREQ PC+3
	JMP _0x82
;     640              for(k=0;k<8;k++)
	CALL SUBOPT_0x1F
_0x84:
	CALL SUBOPT_0x1E
	SBIW R26,8
	BRLO PC+3
	JMP _0x85
;     641             {
;     642                 buf_screen_1[k]=font1[giaima(hour/10)+k];
	CALL SUBOPT_0x23
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	POP  R26
	POP  R27
	ST   X,R30
;     643                 buf_screen_1[k+8]=font1[giaima(day/10)+k+80];
	CALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,8
	PUSH R31
	PUSH R30
	LDS  R26,_day
	CALL SUBOPT_0x3C
	POP  R26
	POP  R27
	ST   X,R30
;     644                 buf_screen_1[k+16]=font1[giaima(hour%10)+k];
	CALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,16
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x27
	CALL SUBOPT_0x25
	POP  R26
	POP  R27
	CALL SUBOPT_0x28
;     645                 buf_screen_1[k+24]=font1[giaima(day%10)+k+80];
	PUSH R31
	PUSH R30
	LDS  R26,_day
	CALL SUBOPT_0x3D
	POP  R26
	POP  R27
	CALL SUBOPT_0x2A
;     646                 buf_screen_1[k+32]=font1[giaima(min/10)+k];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x25
	POP  R26
	POP  R27
	CALL SUBOPT_0x2C
;     647                 buf_screen_1[k+40]=font1[giaima(month/10)+k+80];
	PUSH R31
	PUSH R30
	LDS  R26,_month
	CALL SUBOPT_0x3C
	POP  R26
	POP  R27
	CALL SUBOPT_0x2E
;     648                 buf_screen_1[k+48]=font1[giaima(min%10)+k];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x25
	POP  R26
	POP  R27
	ST   X,R30
;     649                 buf_screen_1[k+56]=font1[giaima(month%10)+k+80];
	CALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,56
	PUSH R31
	PUSH R30
	LDS  R26,_month
	CALL SUBOPT_0x3D
	POP  R26
	POP  R27
	ST   X,R30
;     650                 if((k+16)==17)buf_screen_1[17]+=daucham;
	CALL SUBOPT_0x1C
	ADIW R30,16
	SBIW R30,17
	BRNE _0x86
	CALL SUBOPT_0x31
	CALL SUBOPT_0x32
;     651                 if((k+16)==18)buf_screen_1[18]+=daucham;
_0x86:
	CALL SUBOPT_0x33
	BRNE _0x87
	CALL SUBOPT_0x34
	CALL SUBOPT_0x32
;     652                 if((k+16)==21)buf_screen_1[21]+=daucham;
_0x87:
	CALL SUBOPT_0x35
	BRNE _0x88
	CALL SUBOPT_0x36
	CALL SUBOPT_0x32
;     653                 if((k+16)==22)buf_screen_1[22]+=daucham;
_0x88:
	CALL SUBOPT_0x37
	BRNE _0x89
	CALL SUBOPT_0x38
	CALL SUBOPT_0x32
;     654                 if((k+24)==28)buf_screen_1[28]+=3;
_0x89:
	CALL SUBOPT_0x1C
	ADIW R30,24
	SBIW R30,28
	BRNE _0x8A
	__POINTW1MN _buf_screen_1,28
	MOVW R26,R30
	LD   R30,X
	SUBI R30,-LOW(3)
	ST   X,R30
;     655             }
_0x8A:
	CALL SUBOPT_0x39
	RJMP _0x84
_0x85:
;     656 
;     657             }
_0x82:
;     658        if(setting==1)
_0x71:
	LDI  R30,LOW(1)
	CP   R30,R5
	BRNE _0x8B
;     659            for(k=0;k<8;k++)
	CALL SUBOPT_0x1F
_0x8D:
	CALL SUBOPT_0x1E
	SBIW R26,8
	BRSH _0x8E
;     660             {
;     661                 buf_screen_1[k]=msg[k];
	CALL SUBOPT_0x23
	MOVW R22,R30
	CALL SUBOPT_0x1C
	LDI  R26,LOW(_msg*2)
	LDI  R27,HIGH(_msg*2)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETW1PF
	MOVW R26,R22
	CALL SUBOPT_0x26
;     662                 buf_screen_1[k+8]=0x00;
;     663                 buf_screen_1[k+16]=msg[k+8];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,16
	CALL SUBOPT_0x3F
;     664                 buf_screen_1[k+24]=font1[giaima(sec/10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x29
	POP  R26
	POP  R27
	CALL SUBOPT_0x2A
;     665                 buf_screen_1[k+32]=msg[k+16];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,32
	CALL SUBOPT_0x40
;     666                 buf_screen_1[k+40]=font1[giaima(sec%10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2D
	POP  R26
	POP  R27
	CALL SUBOPT_0x2E
;     667                 buf_screen_1[k+48]=0x00;
	CALL SUBOPT_0x3B
;     668                 buf_screen_1[k+56]=0x00;
	CALL SUBOPT_0x41
;     669 
;     670             }
	CALL SUBOPT_0x39
	RJMP _0x8D
_0x8E:
;     671         if(setting==2)
_0x8B:
	LDI  R30,LOW(2)
	CP   R30,R5
	BRNE _0x8F
;     672            for(k=0;k<8;k++)
	CALL SUBOPT_0x1F
_0x91:
	CALL SUBOPT_0x1E
	SBIW R26,8
	BRSH _0x92
;     673             {
;     674                 buf_screen_1[k]=msg[k+24];
	CALL SUBOPT_0x42
	__ADDW1FN _msg,48
	CALL SUBOPT_0x43
;     675                 buf_screen_1[k+8]=0x00;
;     676                 buf_screen_1[k+16]=msg[k+32];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,64
	CALL SUBOPT_0x3F
;     677                 buf_screen_1[k+24]=font1[giaima(min/10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x3A
	POP  R26
	POP  R27
	CALL SUBOPT_0x2A
;     678                 buf_screen_1[k+32]=msg[k+40];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,80
	CALL SUBOPT_0x40
;     679                 buf_screen_1[k+40]=font1[giaima(min%10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x3A
	POP  R26
	POP  R27
	CALL SUBOPT_0x2E
;     680                 buf_screen_1[k+48]=0x00;
	CALL SUBOPT_0x3B
;     681                 buf_screen_1[k+56]=0x00;
	CALL SUBOPT_0x41
;     682 
;     683             }
	CALL SUBOPT_0x39
	RJMP _0x91
_0x92:
;     684          if(setting==3)
_0x8F:
	LDI  R30,LOW(3)
	CP   R30,R5
	BRNE _0x93
;     685            for(k=0;k<8;k++)
	CALL SUBOPT_0x1F
_0x95:
	CALL SUBOPT_0x1E
	SBIW R26,8
	BRSH _0x96
;     686             {
;     687                 buf_screen_1[k]=msg[k+48];
	CALL SUBOPT_0x42
	__ADDW1FN _msg,96
	CALL SUBOPT_0x43
;     688                 buf_screen_1[k+8]=0x00;
;     689                 buf_screen_1[k+16]=msg[k+56];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,112
	CALL SUBOPT_0x3F
;     690                 buf_screen_1[k+24]=font1[giaima(hour/10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x24
	CALL SUBOPT_0x3A
	POP  R26
	POP  R27
	CALL SUBOPT_0x2A
;     691                 buf_screen_1[k+32]=msg[k+64];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,128
	CALL SUBOPT_0x40
;     692                 buf_screen_1[k+40]=font1[giaima(hour%10)+k+80];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x27
	CALL SUBOPT_0x3A
	POP  R26
	POP  R27
	CALL SUBOPT_0x2E
;     693                 buf_screen_1[k+48]=msg[k+72];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,144
	CALL __GETW1PF
	ST   X,R30
;     694                 buf_screen_1[k+56]=0x00;
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x41
;     695 
;     696             }
	CALL SUBOPT_0x39
	RJMP _0x95
_0x96:
;     697                if(setting==4)
_0x93:
	LDI  R30,LOW(4)
	CP   R30,R5
	BRNE _0x97
;     698            for(k=0;k<8;k++)
	CALL SUBOPT_0x1F
_0x99:
	CALL SUBOPT_0x1E
	SBIW R26,8
	BRSH _0x9A
;     699             {
;     700                 buf_screen_1[k]=msg[k+80];
	CALL SUBOPT_0x42
	__ADDW1FN _msg,160
	CALL SUBOPT_0x43
;     701                 buf_screen_1[k+8]=0x00;
;     702                 buf_screen_1[k+16]=msg[k+88];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,176
	CALL SUBOPT_0x3F
;     703                 buf_screen_1[k+24]=font1[giaima(mode/10)+k+80];
	PUSH R31
	PUSH R30
	MOV  R26,R7
	CALL SUBOPT_0x3C
	POP  R26
	POP  R27
	CALL SUBOPT_0x2A
;     704                 buf_screen_1[k+32]=msg[k+96];
	CALL SUBOPT_0x3E
	__ADDW1FN _msg,192
	CALL SUBOPT_0x40
;     705                 buf_screen_1[k+40]=font1[giaima(mode%10)+k+80];
	PUSH R31
	PUSH R30
	MOV  R26,R7
	CALL SUBOPT_0x3D
	POP  R26
	POP  R27
	CALL SUBOPT_0x2E
;     706                 buf_screen_1[k+48]=0X00;
	CALL SUBOPT_0x3B
;     707                 buf_screen_1[k+56]=0x00;
	CALL SUBOPT_0x41
;     708             }
	CALL SUBOPT_0x39
	RJMP _0x99
_0x9A:
;     709             }
_0x97:
_0x70:
;     710       };
	RJMP _0x6C
;     711 
;     712 }
_0x9B:
	RJMP _0x9B
;     713 void timedeal(void)
;     714 {
_timedeal:
;     715 if(sec>=60)
	LDS  R26,_sec
	CPI  R26,LOW(0x3C)
	BRLO _0x9C
;     716 {
;     717 sec=0;
	LDI  R30,LOW(0)
	STS  _sec,R30
;     718 }
;     719 if(min>=60)
_0x9C:
	LDS  R26,_min
	CPI  R26,LOW(0x3C)
	BRLO _0x9D
;     720 {
;     721 min=0;
	LDI  R30,LOW(0)
	STS  _min,R30
;     722 }
;     723 if(hour>=24)
_0x9D:
	LDI  R30,LOW(24)
	CP   R8,R30
	BRLO _0x9E
;     724 hour=0;
	CLR  R8
;     725 /*if(year>=99)
;     726 {
;     727 year=10;
;     728 }
;     729 if(month>=13)
;     730 {
;     731 month=1;
;     732 }
;     733 if(day>=32)
;     734 day=0;
;     735 if(a_min>=60)
;     736 {
;     737 a_min=0;
;     738 }
;     739 if(a_hour>=24)
;     740 a_hour=0; */
;     741 }
_0x9E:
	RET
;     742 
;     743 
;     744 

_rtc_init:
	LDD  R30,Y+2
	ANDI R30,LOW(0x3)
	STD  Y+2,R30
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x9F
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x9F:
	LD   R30,Y
	CPI  R30,0
	BREQ _0xA0
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0xA0:
	CALL SUBOPT_0x44
	LDI  R30,LOW(7)
	CALL SUBOPT_0x45
	CALL SUBOPT_0x46
	RJMP _0xA1
_rtc_get_time:
	CALL SUBOPT_0x44
	LDI  R30,LOW(0)
	CALL SUBOPT_0x47
	LD   R26,Y
	LDD  R27,Y+1
	CALL SUBOPT_0x48
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	CALL _i2c_stop
	RJMP _0xA2
_rtc_set_time:
	CALL SUBOPT_0x44
	LDI  R30,LOW(0)
	CALL SUBOPT_0x49
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x45
	CALL _bin2bcd
	ST   -Y,R30
	CALL SUBOPT_0x46
	RJMP _0xA1
_rtc_get_date:
	CALL SUBOPT_0x44
	LDI  R30,LOW(4)
	CALL SUBOPT_0x47
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL SUBOPT_0x48
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	CALL _i2c_stop
_0xA2:
	ADIW R28,6
	RET
_rtc_set_date:
	CALL SUBOPT_0x44
	LDI  R30,LOW(4)
	CALL SUBOPT_0x45
	CALL _bin2bcd
	ST   -Y,R30
	CALL SUBOPT_0x4A
	CALL SUBOPT_0x49
	CALL SUBOPT_0x46
_0xA1:
	ADIW R28,3
	RET
_bcd2bin:
    ld   r30,y
    swap r30
    andi r30,0xf
    mov  r26,r30
    lsl  r26
    lsl  r26
    add  r30,r26
    lsl  r30
    ld   r26,y+
    andi r26,0xf
    add  r30,r26
    ret
_bin2bcd:
    ld   r26,y+
    clr  r30
bin2bcd0:
    subi r26,10
    brmi bin2bcd1
    subi r30,-16
    rjmp bin2bcd0
bin2bcd1:
    subi r26,-10
    add  r30,r26
    ret

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:69 WORDS
SUBOPT_0x0:
	LDI  R31,0
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 29 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0x1:
	LDS  R26,_i
	LDS  R27,_i+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDS  R30,_i
	LDS  R31,_i+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3:
	MOVW R30,R12
	ADIW R30,12
	RCALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4:
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	LD   R30,Z
	ST   -Y,R30
	CALL _spi_mem
	MOVW R30,R12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x5:
	ADIW R30,8
	RCALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x6:
	ADIW R30,4
	RCALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x7:
	ADIW R30,0
	RCALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x8:
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	LD   R30,Z
	ST   -Y,R30
	JMP  _spi_mem

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x9:
	__ADDW1MN _buf_screen_1,15
	LD   R30,Z
	ST   -Y,R30
	CALL _spi_mem
	MOVW R30,R12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0xA:
	LD   R30,Z
	ST   -Y,R30
	JMP  _spi_mem

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	__ADDW1MN _buf_screen_1,30
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	__ADDW1MN _buf_screen_1,45
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xD:
	RCALL SUBOPT_0x2
	ADIW R30,1
	STS  _i,R30
	STS  _i+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xE:
	MOVW R26,R12
	ADIW R26,12
	MOVW R30,R10
	CALL __MULW12U
	RCALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xF:
	MOVW R26,R12
	ADIW R26,8
	MOVW R30,R10
	CALL __MULW12U
	RCALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x10:
	MOVW R26,R12
	ADIW R26,4
	MOVW R30,R10
	CALL __MULW12U
	RCALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x11:
	MOVW R26,R12
	ADIW R26,0
	MOVW R30,R10
	CALL __MULW12U
	RCALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	SUBI R30,LOW(-_buf_screen_0)
	SBCI R31,HIGH(-_buf_screen_0)
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x13:
	__POINTW1FN _msg1,4
	CALL __GETW1PF
	LDS  R26,_count_byte
	LDS  R27,_count_byte+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x14:
	LDS  R26,_row
	LDS  R27,_row+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	MOVW R30,R10
	SBIW R30,1
	LDS  R26,_j
	LDS  R27,_j+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x16:
	MOVW R30,R10
	RCALL SUBOPT_0x14
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	LDS  R26,_j
	LDS  R27,_j+1
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x18:
	LD   R30,Z
	ROL  R30
	LDI  R30,0
	ROL  R30
	LDI  R31,0
	OR   R30,R22
	__GETW2R 23,24
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x19:
	LDS  R30,_j
	LDS  R31,_j+1
	ADIW R30,1
	STS  _j,R30
	STS  _j+1,R31
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1A:
	LD   R30,Z
	LSL  R30
	MOV  R1,R30
	LDS  R26,_b_data
	LDS  R27,_b_data+1
	LDI  R30,LOW(7)
	CALL __LSRW12
	OR   R30,R1
	MOVW R26,R22
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1B:
	LDS  R30,_row
	LDS  R31,_row+1
	ADIW R30,1
	STS  _row,R30
	STS  _row+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 113 TIMES, CODE SIZE REDUCTION:221 WORDS
SUBOPT_0x1C:
	LDS  R30,_k
	LDS  R31,_k+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x1D:
	ADIW R30,1
	STS  _k,R30
	STS  _k+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x1E:
	LDS  R26,_k
	LDS  R27,_k+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x1F:
	LDI  R30,0
	STS  _k,R30
	STS  _k+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x20:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x21:
	LDI  R30,0
	SBIC 0x13,3
	LDI  R30,1
	MOV  R26,R30
	LDI  R30,0
	SBRC R2,1
	LDI  R30,1
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x22:
	LDS  R30,_sec
	SUBI R30,-LOW(1)
	STS  _sec,R30
	JMP  _timedeal

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x23:
	RCALL SUBOPT_0x1C
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x24:
	MOV  R26,R8
	LDI  R30,LOW(10)
	CALL __DIVB21U
	ST   -Y,R30
	CALL _giaima
	MOV  R26,R30
	RCALL SUBOPT_0x1C
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x25:
	LDI  R26,LOW(_font1*2)
	LDI  R27,HIGH(_font1*2)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETW1PF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x26:
	ST   X,R30
	RCALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,8
	LDI  R26,LOW(0)
	STD  Z+0,R26
	RCALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x27:
	MOV  R26,R8
	LDI  R30,LOW(10)
	CALL __MODB21U
	ST   -Y,R30
	CALL _giaima
	MOV  R26,R30
	RCALL SUBOPT_0x1C
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x28:
	ST   X,R30
	RCALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,24
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x29:
	LDS  R26,_sec
	LDI  R30,LOW(10)
	CALL __DIVB21U
	ST   -Y,R30
	CALL _giaima
	MOV  R26,R30
	RCALL SUBOPT_0x1C
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	LSL  R30
	ROL  R31
	__ADDW1FN _font1,160
	CALL __GETW1PF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x2A:
	ST   X,R30
	RCALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,32
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x2B:
	LDS  R26,_min
	LDI  R30,LOW(10)
	CALL __DIVB21U
	ST   -Y,R30
	CALL _giaima
	MOV  R26,R30
	RCALL SUBOPT_0x1C
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x2C:
	ST   X,R30
	RCALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,40
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x2D:
	LDS  R26,_sec
	LDI  R30,LOW(10)
	CALL __MODB21U
	ST   -Y,R30
	CALL _giaima
	MOV  R26,R30
	RCALL SUBOPT_0x1C
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	LSL  R30
	ROL  R31
	__ADDW1FN _font1,160
	CALL __GETW1PF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x2E:
	ST   X,R30
	RCALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,48
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x2F:
	LDS  R26,_min
	LDI  R30,LOW(10)
	CALL __MODB21U
	ST   -Y,R30
	CALL _giaima
	MOV  R26,R30
	RCALL SUBOPT_0x1C
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x30:
	ST   X,R30
	RCALL SUBOPT_0x1C
	__ADDW1MN _buf_screen_1,56
	LDI  R26,LOW(0)
	STD  Z+0,R26
	RCALL SUBOPT_0x1C
	ADIW R30,16
	SBIW R30,17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x31:
	__POINTW1MN _buf_screen_1,17
	MOVW R0,R30
	LD   R30,Z
	MOV  R26,R30
	MOV  R30,R9
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x32:
	ADD  R30,R26
	ADC  R31,R27
	MOVW R26,R0
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x33:
	RCALL SUBOPT_0x1C
	ADIW R30,16
	SBIW R30,18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x34:
	__POINTW1MN _buf_screen_1,18
	MOVW R0,R30
	LD   R30,Z
	MOV  R26,R30
	MOV  R30,R9
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x35:
	RCALL SUBOPT_0x1C
	ADIW R30,16
	SBIW R30,21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x36:
	__POINTW1MN _buf_screen_1,21
	MOVW R0,R30
	LD   R30,Z
	MOV  R26,R30
	MOV  R30,R9
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x37:
	RCALL SUBOPT_0x1C
	ADIW R30,16
	SBIW R30,22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x38:
	__POINTW1MN _buf_screen_1,22
	MOVW R0,R30
	LD   R30,Z
	MOV  R26,R30
	MOV  R30,R9
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x39:
	RCALL SUBOPT_0x1C
	RJMP SUBOPT_0x1D

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:49 WORDS
SUBOPT_0x3A:
	LSL  R30
	ROL  R31
	__ADDW1FN _font1,160
	CALL __GETW1PF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3B:
	LDI  R26,LOW(0)
	STD  Z+0,R26
	RJMP SUBOPT_0x1C

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x3C:
	LDI  R30,LOW(10)
	CALL __DIVB21U
	ST   -Y,R30
	CALL _giaima
	MOV  R26,R30
	RCALL SUBOPT_0x1C
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RJMP SUBOPT_0x3A

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x3D:
	LDI  R30,LOW(10)
	CALL __MODB21U
	ST   -Y,R30
	CALL _giaima
	MOV  R26,R30
	RCALL SUBOPT_0x1C
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RJMP SUBOPT_0x3A

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x3E:
	MOVW R26,R30
	RCALL SUBOPT_0x1C
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3F:
	CALL __GETW1PF
	RJMP SUBOPT_0x28

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x40:
	CALL __GETW1PF
	RJMP SUBOPT_0x2C

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x41:
	__ADDW1MN _buf_screen_1,56
	LDI  R26,LOW(0)
	STD  Z+0,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x42:
	RCALL SUBOPT_0x1E
	SUBI R26,LOW(-_buf_screen_1)
	SBCI R27,HIGH(-_buf_screen_1)
	RCALL SUBOPT_0x1C
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x43:
	CALL __GETW1PF
	RJMP SUBOPT_0x26

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x44:
	CALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	JMP  _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x45:
	ST   -Y,R30
	CALL _i2c_write
	LDD  R30,Y+2
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x46:
	CALL _i2c_write
	JMP  _i2c_stop

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x47:
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_start
	LDI  R30,LOW(209)
	ST   -Y,R30
	CALL _i2c_write
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	JMP  _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x48:
	ST   X,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	CALL _bcd2bin
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	JMP  _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x49:
	ST   -Y,R30
	CALL _i2c_write
	LD   R30,Y
	ST   -Y,R30
	CALL _bin2bcd
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4A:
	CALL _i2c_write
	LDD  R30,Y+1
	ST   -Y,R30
	JMP  _bin2bcd

	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2
_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,7
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,13
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	ld   r23,y+
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ld   r30,y+
	ldi  r23,8
__i2c_write0:
	lsl  r30
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	ret

__LSLW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
	RET

__LSRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSRW12R
__LSRW12L:
	LSR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRW12L
__LSRW12R:
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__DIVB21U:
	CLR  R0
	LDI  R25,8
__DIVB21U1:
	LSL  R26
	ROL  R0
	SUB  R0,R30
	BRCC __DIVB21U2
	ADD  R0,R30
	RJMP __DIVB21U3
__DIVB21U2:
	SBR  R26,1
__DIVB21U3:
	DEC  R25
	BRNE __DIVB21U1
	MOV  R30,R26
	MOV  R26,R0
	RET

__MODB21U:
	RCALL __DIVB21U
	MOV  R30,R26
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

;END OF CODE MARKER
__END_OF_CODE:
