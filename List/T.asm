
;CodeVisionAVR C Compiler V2.03.4 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 4.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : Yes
;char is unsigned       : Yes
;global const stored in FLASH  : No
;8 bit enums            : Yes
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
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

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
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

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
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

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRD
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

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _wb=R4
	.DEF _r=R6
	.DEF _count_byte=R8
	.DEF _count_bit=R10
	.DEF _i=R12

	.CSEG
	.ORG 0x00

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_compa_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_comp_isr
	JMP  0x00

_font1:
	.DB  0x70,0x0,0x48,0x0,0xC8,0x0,0xCC,0x0
	.DB  0xCC,0x0,0xCC,0x0,0xC8,0x0,0x58,0x0
	.DB  0x70,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x60,0x0,0xE0,0x0,0x60,0x0,0x60,0x0
	.DB  0x60,0x0,0x60,0x0,0x60,0x0,0x60,0x0
	.DB  0xF0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0x98,0x0,0x18,0x0,0x8,0x0
	.DB  0x18,0x0,0x10,0x0,0x20,0x0,0x64,0x0
	.DB  0xF8,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0xD8,0x0,0x18,0x0,0x10,0x0
	.DB  0x78,0x0,0x18,0x0,0x8,0x0,0x18,0x0
	.DB  0xF0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0xC,0x0,0xC,0x0,0x1C,0x0,0x2C,0x0
	.DB  0x2C,0x0,0x4C,0x0,0x7E,0x0,0xC,0x0
	.DB  0xC,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x38,0x0,0x40,0x0,0x60,0x0,0x30,0x0
	.DB  0x18,0x0,0x8,0x0,0x8,0x0,0x18,0x0
	.DB  0xF0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x18,0x0,0x30,0x0,0x60,0x0,0xF8,0x0
	.DB  0xC8,0x0,0xCC,0x0,0xCC,0x0,0x48,0x0
	.DB  0x70,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x78,0x0,0x8,0x0,0x8,0x0,0x18,0x0
	.DB  0x10,0x0,0x10,0x0,0x10,0x0,0x20,0x0
	.DB  0x20,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0x48,0x0,0xC8,0x0,0x78,0x0
	.DB  0x70,0x0,0x58,0x0,0xC8,0x0,0xC8,0x0
	.DB  0x78,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0xD8,0x0,0xC8,0x0,0xCC,0x0
	.DB  0xCC,0x0,0x78,0x0,0x18,0x0,0x30,0x0
	.DB  0xE0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0x48,0x0,0xC8,0x0,0xCD,0x0
	.DB  0xCC,0x0,0xCC,0x0,0xC8,0x0,0x58,0x0
	.DB  0x71,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x60,0x0,0xE0,0x0,0x60,0x0,0x62,0x0
	.DB  0x60,0x0,0x60,0x0,0x60,0x0,0x60,0x0
	.DB  0xF2,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0x98,0x0,0x18,0x0,0x9,0x0
	.DB  0x18,0x0,0x10,0x0,0x20,0x0,0x64,0x0
	.DB  0xF9,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0xD8,0x0,0x18,0x0,0x11,0x0
	.DB  0x78,0x0,0x18,0x0,0x8,0x0,0x18,0x0
	.DB  0xF1,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0xC,0x0,0xC,0x0,0x1C,0x0,0x2C,0x0
	.DB  0x2C,0x0,0x4C,0x0,0x7E,0x0,0xC,0x0
	.DB  0xC,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x38,0x0,0x40,0x0,0x60,0x0,0x31,0x0
	.DB  0x18,0x0,0x8,0x0,0x8,0x0,0x18,0x0
	.DB  0xF1,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x18,0x0,0x30,0x0,0x60,0x0,0xF9,0x0
	.DB  0xC8,0x0,0xCC,0x0,0xCC,0x0,0x48,0x0
	.DB  0x71,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x78,0x0,0x8,0x0,0x8,0x0,0x19,0x0
	.DB  0x10,0x0,0x10,0x0,0x10,0x0,0x20,0x0
	.DB  0x21,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0x48,0x0,0xC8,0x0,0x79,0x0
	.DB  0x70,0x0,0x58,0x0,0xC8,0x0,0xC8,0x0
	.DB  0x79,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x70,0x0,0xD8,0x0,0xC8,0x0,0xCD,0x0
	.DB  0xCC,0x0,0x78,0x0,0x18,0x0,0x30,0x0
	.DB  0xE1,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0

_0x30:
	.DB  0x4,0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x04
	.DW  _0x30*2

_0xFFFFFFFF:
	.DW  0

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
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
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
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x160)
	LDI  R29,HIGH(0x160)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V1.24.8d Professional
;Automatic Program Generator
;© Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : LED MATRIX MODUL 16X32(V701CE)
;Version : 0.0.0
;Date    : 1/2/2011
;Author  : DESIGN BY NGUYEN VAN THIEN
;Company : HOC VIEN CN BCVT
;Comments:
;
;
;Chip type           : ATmega16
;Program type        : Application
;Clock frequency     : 4.000000 MHz
;Memory model        : Small
;External SRAM size  : 0
;Data Stack size     : 256
;*****************************************************/
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;
;#include <khaibao.c>
;//*****************************************************************************
;#define ROW            PORTB         // chon hang khi quet man hinh led
;#define R                   PORTB.5     // chan
;#define SCLK           PORTB.3
;#define CKL             PORTB.7
;#define OE                PORTB.4
;#define CASE_EFF  PORTD.0
;#define CASE_MSG  PORTD.5
;
;// Khai bao cac bien su dung trong CT
;bit load_effect; // "0" khong cho phep load du lieu cho hieu ung, "1" cho phép load
;bit status_buf;   // "0" chon buf_screen_0[64], "1" chon buf_screen_1[64]
;bit b_shift=0 ; // b_shift=0 Mac dinh dich du lieu tu man hinh led ra ngoai va tu flash vao man hinh led
;                        // b_shift=1 Luon chi dich du lieu tu man hinh led ra ngoai, không dich du lieu tu flash vao man hinh
;unsigned  int    wb=4;   // do rong byte man hinh led
;unsigned  int    r;
;unsigned  int    count_byte;
;unsigned  int    count_bit;
;unsigned  int    i,j,k;
;unsigned  int    effect;
;unsigned  int    check_effect;
;unsigned  int    b_data;
;unsigned  int    row;
;unsigned char hour,min,sec;
;// khai bao mang du lieu bo dem man hinh
;unsigned char buf_screen_0[64];   // gia tri "64" la kich thuoc byte cho 1 modul 16x32 pixel
;unsigned char buf_screen_1[64];   //  Man hinh led co n modul thi gia tri tuong ung la n*64
;unsigned char gio1[16],gio2[16],phut1[16],phut2[16];
;
;//******************************************************************************************
;#include <bitmap_flash.c>
;// FONT LED MATRIX
;
;//********************************************************************************
;flash unsigned  int msg[]=
;{
;0x30, 0xF0, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0xFC, 0x00, 0x00,
;0x00,0x00,0x00,0x70,0x88,0x08,0x08,0x10,0x10,0x20,0x48,0xF8,0x00,0x00,0x00,0x00,
;};
;flash unsigned int font1[]={
;0x70, 0x48, 0xC8, 0xCC, 0xCC, 0xCC, 0xC8, 0x58, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //0
;0x60, 0xE0, 0x60, 0x60, 0x60, 0x60, 0x60, 0x60, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //1
;0x70, 0x98, 0x18, 0x08, 0x18, 0x10, 0x20, 0x64, 0xF8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //2
;0x70, 0xD8, 0x18, 0x10, 0x78, 0x18, 0x08, 0x18, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //3
;0x0C, 0x0C, 0x1C, 0x2C, 0x2C, 0x4C, 0x7E, 0x0C, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //4
;0x38, 0x40, 0x60, 0x30, 0x18, 0x08, 0x08, 0x18, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //5
;0x18, 0x30, 0x60, 0xF8, 0xC8, 0xCC, 0xCC, 0x48, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //6
;0x78, 0x08, 0x08, 0x18, 0x10, 0x10, 0x10, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //7
;0x70, 0x48, 0xC8, 0x78, 0x70, 0x58, 0xC8, 0xC8, 0x78, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //8
;0x70, 0xD8, 0xC8, 0xCC, 0xCC, 0x78, 0x18, 0x30, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //9
;
;0x70, 0x48, 0xC8, 0xCD, 0xCC, 0xCC, 0xC8, 0x58, 0x71, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x60, 0xE0, 0x60, 0x62, 0x60, 0x60, 0x60, 0x60, 0xF2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x70, 0x98, 0x18, 0x09, 0x18, 0x10, 0x20, 0x64, 0xF9, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x70, 0xD8, 0x18, 0x11, 0x78, 0x18, 0x08, 0x18, 0xF1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x0C, 0x0C, 0x1C, 0x2C, 0x2C, 0x4C, 0x7E, 0x0C, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x38, 0x40, 0x60, 0x31, 0x18, 0x08, 0x08, 0x18, 0xF1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x18, 0x30, 0x60, 0xF9, 0xC8, 0xCC, 0xCC, 0x48, 0x71, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x78, 0x08, 0x08, 0x19, 0x10, 0x10, 0x10, 0x20, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x70, 0x48, 0xC8, 0x79, 0x70, 0x58, 0xC8, 0xC8, 0x79, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x70, 0xD8, 0xC8, 0xCD, 0xCC, 0x78, 0x18, 0x30, 0xE1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;};
;#include <SpiMem.c>
;// chuong trinh con spi mem
;
;/*----------------------------------------------------------------------------*/
;// ctc chot du lieu
;void latch_data(void)
; 0000 001D {

	.CSEG
_latch_data:
;  CKL=0;
	CBI  0x18,7
;  CKL=1;
	SBI  0x18,7
;}
	RET
;/*----------------------------------------------------------------------------*/
;
;/*----------------------------------------------------------------------------*/
;// ctc dich du lieu
;void Shift_data(void)
;{
_Shift_data:
;  SCLK=0;
	CBI  0x18,3
;  SCLK=1;
	SBI  0x18,3
;}
	RET
;/*----------------------------------------------------------------------------*/
;
;void spi_mem(unsigned char data)
;{
_spi_mem:
;        unsigned char n;
;        for(n=0x80;n!=0;n>>=1)  // SPI Data Order: MSB First
	ST   -Y,R17
;	data -> Y+1
;	n -> R17
	LDI  R17,LOW(128)
_0xC:
	CPI  R17,0
	BREQ _0xD
;        {
;                R=data&n;       //  ='0' khi data&n=0, ='1' khi data&n!=0
	LDD  R26,Y+1
	CLR  R27
	MOV  R30,R17
	LDI  R31,0
	AND  R30,R26
	AND  R31,R27
	CPI  R30,0
	BRNE _0xE
	CBI  0x18,5
	RJMP _0xF
_0xE:
	SBI  0x18,5
_0xF:
;                Shift_data();   // dich bit
	RCALL _Shift_data
;        };
	MOV  R26,R17
	LDI  R27,0
	MOVW R30,R26
	ASR  R31
	ROR  R30
	MOV  R17,R30
	RJMP _0xC
_0xD:
;}
	LDD  R17,Y+0
	ADIW R28,2
	RET
;
;
;#include <ScreenScan.c>
;//*****************************************************************************
;
;
;
;/*----------------------------------------------------------------------------*/
;// ctc hien thi du lieu ra man hinh
;void scan_screen(void)
; 0000 001E {
_scan_screen:
;  OE=1;  //  "0" thi enalbe 74138, "1" disable 74138
	SBI  0x18,4
;  for(i=0;i<wb;i++)
	CLR  R12
	CLR  R13
_0x13:
	__CPWRR 12,13,4,5
	BRLO PC+3
	JMP _0x14
; {
;   if(i==0)
	MOV  R0,R12
	OR   R0,R13
	BRNE _0x15
;  {
;    spi_mem(buf_screen_1[(r+12)+i+1]);
	CALL SUBOPT_0x0
	CALL SUBOPT_0x1
;    spi_mem(buf_screen_1[(r+8)+i+1]);
	ADIW R30,8
	ADD  R30,R12
	ADC  R31,R13
	CALL SUBOPT_0x1
;    spi_mem(buf_screen_1[(r+4)+i+1]);
	ADIW R30,4
	ADD  R30,R12
	ADC  R31,R13
	CALL SUBOPT_0x1
;    spi_mem(buf_screen_1[(r+0)+i+1]);
	ADIW R30,0
	ADD  R30,R12
	ADC  R31,R13
	__ADDW1MN _buf_screen_1,1
	CALL SUBOPT_0x2
;  }
;   if(i==1)
_0x15:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x16
;  {
;    spi_mem(buf_screen_1[(r+12)+i+16]);
	CALL SUBOPT_0x0
	CALL SUBOPT_0x3
;    spi_mem(buf_screen_1[(r+8)+i+16]);
	CALL SUBOPT_0x4
	CALL SUBOPT_0x3
;    spi_mem(buf_screen_1[(r+4)+i+16]);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x3
;    spi_mem(buf_screen_1[(r+0)+i+16]);
	CALL SUBOPT_0x6
	CALL SUBOPT_0x3
;  }
;     if(i==2)
_0x16:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x17
;  {
;    spi_mem(buf_screen_1[(r+12)+i+31]);
	CALL SUBOPT_0x0
	CALL SUBOPT_0x7
;    spi_mem(buf_screen_1[(r+8)+i+31]);
	CALL SUBOPT_0x4
	CALL SUBOPT_0x7
;    spi_mem(buf_screen_1[(r+4)+i+31]);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x7
;    spi_mem(buf_screen_1[(r+0)+i+31]);
	CALL SUBOPT_0x6
	CALL SUBOPT_0x7
;  }
;      if(i==3)
_0x17:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R12
	CPC  R31,R13
	BRNE _0x18
;  {
;    spi_mem(buf_screen_1[(r+12)+i+46]);
	CALL SUBOPT_0x0
	CALL SUBOPT_0x8
;    spi_mem(buf_screen_1[(r+8)+i+46]);
	CALL SUBOPT_0x4
	CALL SUBOPT_0x8
;    spi_mem(buf_screen_1[(r+4)+i+46]);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x8
;    spi_mem(buf_screen_1[(r+0)+i+46]);
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
;  }
; };
_0x18:
	MOVW R30,R12
	ADIW R30,1
	MOVW R12,R30
	RJMP _0x13
_0x14:
; latch_data();
	RCALL _latch_data
; ROW=r; // hang thu r duoc hien thi
	MOVW R30,R6
	OUT  0x18,R30
; OE=0; // enable 74138
	CBI  0x18,4
; r++;
	ADIW R30,1
	MOVW R6,R30
; if (r==4)
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R6
	CPC  R31,R7
	BRNE _0x1B
; {
;   r=0;
	CLR  R6
	CLR  R7
; }
;}
_0x1B:
	RET
;
;/*----------------------------------------------------------------------------*/
;
;//*******************************************************************************
;#include <delay.h>
;// I2C Bus functions
;#asm
   .equ __i2c_port=0x15 ;PORTC
   .equ __sda_bit=1
   .equ __scl_bit=0
; 0000 0025 #endasm
;#include <i2c.h>
;// DS1307 Real Time Clock functions
;#include <ds1307.h>
;
;// Cac chuong trinh tao hieu ung cho led matrix
;//#include <ShiftLeft.c>
;//#include <ShiftRight.c>
;//#include <ShiftUp.c>
;//#include <ShiftDown.c>
;//#include <CheckEffect.c>
;
;
;
;
;/*----------------------------------------------------------------------------*/
;// ctc lua chon hieu ung hien thi
;/*
;void case_effect(void)
;{
;  switch (effect)
;  {
;    case 0:
;             check_effect=1;
;             effect_3();
;             break;
;
;   case 1:
;             check_effect=0;
;             effect_1();
;             break;
;   case 2:
;             check_effect=1;
;             effect_4();
;             break;
;
;   case 3:
;             check_effect=0;
;             effect_2();
;             break;
;   default:
;            if(effect==4)
;            {
;             effect=0;
;            }
;  };
;}  */
;/*----------------------------------------------------------------------------*/
;
;
;/*----------------------------------------------------------------------------*/
;// ctc lua chon hieu ung hien thi
;/*void case_check_effect(void)
;{
;  switch (check_effect)
;  {
;    case 0:
;             check_effect_12(msg[2]+4);
;             break;
;   case 1:
;             check_effect_34(msg[1]+16);
;             break;
;
;   default:
;  };
;}  */
;/*----------------------------------------------------------------------------*/
;
;
;
; /*----------------------------------------------------------------------------*/
; // Declare your global variables here
;unsigned char giaima(unsigned char so)
; 0000 006E {
_giaima:
; 0000 006F switch(so)
;	so -> Y+0
	LD   R30,Y
	LDI  R31,0
; 0000 0070 {
; 0000 0071 case 0 : return 0;
	SBIW R30,0
	BRNE _0x1F
	LDI  R30,LOW(0)
	RJMP _0x2040001
; 0000 0072 case 1 : return 15;
_0x1F:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x20
	LDI  R30,LOW(15)
	RJMP _0x2040001
; 0000 0073 case 2 : return 31;
_0x20:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x21
	LDI  R30,LOW(31)
	RJMP _0x2040001
; 0000 0074 case 3 : return 47;
_0x21:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x22
	LDI  R30,LOW(47)
	RJMP _0x2040001
; 0000 0075 case 4 : return 63;
_0x22:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x23
	LDI  R30,LOW(63)
	RJMP _0x2040001
; 0000 0076 case 5 : return 79;
_0x23:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x24
	LDI  R30,LOW(79)
	RJMP _0x2040001
; 0000 0077 case 6 : return 95;
_0x24:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x25
	LDI  R30,LOW(95)
	RJMP _0x2040001
; 0000 0078 case 7 : return 111;
_0x25:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x26
	LDI  R30,LOW(111)
	RJMP _0x2040001
; 0000 0079 case 8 : return 127;
_0x26:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x27
	LDI  R30,LOW(127)
	RJMP _0x2040001
; 0000 007A case 9 : return 143;
_0x27:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x1E
	LDI  R30,LOW(143)
; 0000 007B }
_0x1E:
; 0000 007C }
_0x2040001:
	ADIW R28,1
	RET
;// Timer 0 output compare interrupt service routine
;interrupt [TIM0_COMP] void timer0_comp_isr(void)
; 0000 007F {
_timer0_comp_isr:
; 0000 0080  // Place your code here
; 0000 0081   //case_check_effect();
; 0000 0082 
; 0000 0083 
; 0000 0084 }
	RETI
;/*----------------------------------------------------------------------------*/
;
;
;
;/*----------------------------------------------------------------------------*/
;// Timer 1 output compare A interrupt service routine
;// Dung timer 1 de scan led matrix
;interrupt [TIM1_COMPA] void timer1_compa_isr(void)
; 0000 008D {
_timer1_compa_isr:
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
; 0000 008E  // Place your code here
; 0000 008F   scan_screen();
	RCALL _scan_screen
; 0000 0090 }
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
;/*----------------------------------------------------------------------------*/
;
;
;void main(void)
; 0000 0095 {
_main:
; 0000 0096 
; 0000 0097 #include <ConfigSet.c>
;//////////////////
;PORTA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1B,R30
;DDRA=0xFF;
	OUT  0x1A,R30
;
;PORTB=0xFF;
	OUT  0x18,R30
;DDRB=0xFF;    // PORTB lam dau ra
	OUT  0x17,R30
;
;PORTC=0xFF;
	OUT  0x15,R30
;DDRC=0xFF;    // PORTC lam dau ra
	OUT  0x14,R30
;
;PORTD=0xFF;
	OUT  0x12,R30
;DDRD=0xFF;
	OUT  0x11,R30
;
;// Timer/Counter 0 initialization
;// Clock source: System Clock
;// Clock value: 3.906 kHz
;// Mode: CTC top=OCR0
;// OC0 output: Disconnected
;TCCR0=0x0D;
	LDI  R30,LOW(13)
	OUT  0x33,R30
;TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
;OCR0=0xAF;
	LDI  R30,LOW(175)
	OUT  0x3C,R30
;
;// Timer/Counter 1 initialization
;// Clock source: System Clock
;// Clock value: 3.906 kHz
;// Mode: CTC top=OCR1A
;// OC1A output: Discon.
;// OC1B output: Discon.
;// Noise Canceler: Off
;// Input Capture on Falling Edge
;// Timer 1 Overflow Interrupt: Off
;// Input Capture Interrupt: Off
;// Compare A Match Interrupt: On
;// Compare B Match Interrupt: Off
;TCCR1A=0x00;
	LDI  R30,LOW(0)
	OUT  0x2F,R30
;TCCR1B=0x0D;
	LDI  R30,LOW(13)
	OUT  0x2E,R30
;TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;TCNT1L=0x00;
	OUT  0x2C,R30
;ICR1H=0x00;
	OUT  0x27,R30
;ICR1L=0x00;
	OUT  0x26,R30
;OCR1AH=0x00;
	OUT  0x2B,R30
;OCR1AL=0x0F;
	LDI  R30,LOW(15)
	OUT  0x2A,R30
;OCR1BH=0x00;
	LDI  R30,LOW(0)
	OUT  0x29,R30
;OCR1BL=0x00;
	OUT  0x28,R30
;
;// Timer(s)/Counter(s) Interrupt(s) initialization
;TIMSK=0x12;
	LDI  R30,LOW(18)
	OUT  0x39,R30
;
;// Analog Comparator initialization
;// Analog Comparator: Off
;// Analog Comparator Input Capture by Timer/Counter 1: Off
;ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;/*
;// SPI initialization
;// SPI Type: Master
;// SPI Clock Rate: 2*1000.000 kHz
;// SPI Clock Phase: Cycle Half
;// SPI Clock Polarity: Low
;// SPI Data Order: MSB First
;SPCR=0x50;
;SPSR=0x01;
;*/
;// Global enable interrupts
;i2c_init();
	CALL _i2c_init
;rtc_init(0,1,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _rtc_init
;#asm("sei")
	sei
; 0000 0098 while (1)
_0x29:
; 0000 0099       {
; 0000 009A              rtc_get_time(&hour,&min,&sec);                   // Doc gio, phut, giay tu ds1307
	LDI  R30,LOW(_hour)
	LDI  R31,HIGH(_hour)
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
; 0000 009B               for(k=0;k<16;k++)
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _k,R30
	STS  _k+1,R31
_0x2D:
	CALL SUBOPT_0x9
	SBIW R26,16
	BRLO PC+3
	JMP _0x2E
; 0000 009C             {
; 0000 009D                 buf_screen_1[k]=font1[giaima(hour/10)+k];
	CALL SUBOPT_0xA
	SUBI R30,LOW(-_buf_screen_1)
	SBCI R31,HIGH(-_buf_screen_1)
	PUSH R31
	PUSH R30
	LDS  R30,_hour
	CALL SUBOPT_0xB
	POP  R26
	POP  R27
	ST   X,R30
; 0000 009E                 buf_screen_1[k+16]=font1[giaima(hour%10)+k+160];
	CALL SUBOPT_0xA
	__ADDW1MN _buf_screen_1,16
	PUSH R31
	PUSH R30
	LDS  R26,_hour
	CALL SUBOPT_0xC
	LSL  R30
	ROL  R31
	__ADDW1FN _font1,320
	LPM  R30,Z
	POP  R26
	POP  R27
	ST   X,R30
; 0000 009F                 buf_screen_1[k+32]=font1[giaima(min/10)+k];
	CALL SUBOPT_0xA
	__ADDW1MN _buf_screen_1,32
	PUSH R31
	PUSH R30
	LDS  R30,_min
	CALL SUBOPT_0xB
	POP  R26
	POP  R27
	ST   X,R30
; 0000 00A0                 buf_screen_1[k+48]=font1[giaima(min%10)+k];
	CALL SUBOPT_0xA
	__ADDW1MN _buf_screen_1,48
	PUSH R31
	PUSH R30
	LDS  R26,_min
	CALL SUBOPT_0xC
	LDI  R26,LOW(_font1*2)
	LDI  R27,HIGH(_font1*2)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	POP  R26
	POP  R27
	ST   X,R30
; 0000 00A1             }
	LDI  R26,LOW(_k)
	LDI  R27,HIGH(_k)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RJMP _0x2D
_0x2E:
; 0000 00A2       };
	RJMP _0x29
; 0000 00A3 
; 0000 00A4 }
_0x2F:
	RJMP _0x2F
;
;
;

	.CSEG
_rtc_init:
	CALL SUBOPT_0xD
	ANDI R30,LOW(0x3)
	ANDI R31,HIGH(0x3)
	STD  Y+2,R30
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x2000003
	CALL SUBOPT_0xD
	ORI  R30,0x10
	STD  Y+2,R30
_0x2000003:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x2000004
	CALL SUBOPT_0xD
	ORI  R30,0x80
	STD  Y+2,R30
_0x2000004:
	CALL SUBOPT_0xE
	LDI  R30,LOW(7)
	ST   -Y,R30
	CALL _i2c_write
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_stop
	ADIW R28,3
	RET
_rtc_get_time:
	CALL SUBOPT_0xE
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_start
	LDI  R30,LOW(209)
	ST   -Y,R30
	CALL _i2c_write
	CALL SUBOPT_0xF
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	CALL SUBOPT_0xF
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	RCALL _bcd2bin
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	CALL _i2c_stop
	ADIW R28,6
	RET

	.CSEG
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

	.DSEG
_k:
	.BYTE 0x2
_hour:
	.BYTE 0x1
_min:
	.BYTE 0x1
_sec:
	.BYTE 0x1
_buf_screen_1:
	.BYTE 0x40

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	MOVW R30,R6
	ADIW R30,12
	ADD  R30,R12
	ADC  R31,R13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	__ADDW1MN _buf_screen_1,1
	LD   R30,Z
	ST   -Y,R30
	CALL _spi_mem
	MOVW R30,R6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x2:
	LD   R30,Z
	ST   -Y,R30
	JMP  _spi_mem

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	__ADDW1MN _buf_screen_1,16
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	MOVW R30,R6
	ADIW R30,8
	ADD  R30,R12
	ADC  R31,R13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	MOVW R30,R6
	ADIW R30,4
	ADD  R30,R12
	ADC  R31,R13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	MOVW R30,R6
	ADIW R30,0
	ADD  R30,R12
	ADC  R31,R13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	__ADDW1MN _buf_screen_1,31
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	__ADDW1MN _buf_screen_1,46
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9:
	LDS  R26,_k
	LDS  R27,_k+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA:
	LDS  R30,_k
	LDS  R31,_k+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:20 WORDS
SUBOPT_0xB:
	LDI  R31,0
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	ST   -Y,R30
	CALL _giaima
	LDI  R31,0
	RCALL SUBOPT_0x9
	ADD  R30,R26
	ADC  R31,R27
	LDI  R26,LOW(_font1*2)
	LDI  R27,HIGH(_font1*2)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xC:
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	ST   -Y,R30
	CALL _giaima
	LDI  R31,0
	RCALL SUBOPT_0x9
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	LDD  R30,Y+2
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	CALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	JMP  _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xF:
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	JMP  _bcd2bin


	.CSEG
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

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

;END OF CODE MARKER
__END_OF_CODE:
