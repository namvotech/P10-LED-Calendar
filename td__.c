/*****************************************************
This program was produced by the
CodeWizardAVR V2.03.4 Standard
Automatic Program Generator
© Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project :
Version :
Date    : 11/8/2013
Author  :
Company :
Comments:


Chip type           : ATmega32
Program type        : Application
Clock frequency     : 4.000000 MHz
Memory model        : Small
External RAM size   : 0
Data Stack size     : 512
*****************************************************/

#include <mega32.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
#include <delay.h>
unsigned char setting=0,dem=0,mode=0,dem1=0,daucham=2;
bit set_old;
bit up_old;
#include <khaibao.c>
//*****************************************************************************
#define ROW            PORTB         // chon hang khi quet man hinh led
#define R                   PORTB.5     // chan
#define SCLK           PORTB.3
#define CKL             PORTB.7
#define OE                PORTB.4
#define CASE_EFF  PORTD.0
#define CASE_MSG  PORTD.5

// Khai bao cac bien su dung trong CT
bit load_effect; // "0" khong cho phep load du lieu cho hieu ung, "1" cho phép load
bit status_buf;   // "0" chon buf_screen_0[64], "1" chon buf_screen_1[64]
bit b_shift=0 ; // b_shift=0 Mac dinh dich du lieu tu man hinh led ra ngoai va tu flash vao man hinh led
                        // b_shift=1 Luon chi dich du lieu tu man hinh led ra ngoai, không dich du lieu tu flash vao man hinh
unsigned  int    wb=4;   // do rong byte man hinh led
unsigned  int    r;
unsigned  int    count_byte;
unsigned  int    count_bit;
unsigned  int    i,j,k;
unsigned  int    effect;
unsigned  int    check_effect;
unsigned  int    b_data;
unsigned  int    row;
unsigned char hour,min,sec,month,day,year;
// khai bao mang du lieu bo dem man hinh
unsigned char buf_screen_0[64];   // gia tri "64" la kich thuoc byte cho 1 modul 16x32 pixel
unsigned char buf_screen_1[64];   //  Man hinh led co n modul thi gia tri tuong ung la n*64

//******************************************************************************************
#include <bitmap_flash.c>
// FONT LED MATRIX
flash unsigned  int msg1[]=
{
/*------------------------------------------------------------------------------
; If font display distortion, please check Fonts format of setup.
; Source file / text :Khong gi la khong the
; Width x Height (pixels) :122X16
;  Font Format/Size : Monochrome LCD Fonts ,Horizontal scan ,Big endian order/256Byte
;  Font make date  : 4/16/2013 4:59:36 PM
------------------------------------------------------------------------------*/
0x7A,0x10,0x10,//Width pixels,Height pixels,Width bytes
0x00,0x00,0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x80,
0x00,0x00,0x40,0x00,0x00,0x08,0x02,0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x00,0x40,
0x01,0x00,0xA0,0x00,0x00,0x00,0x09,0x00,0x82,0x01,0x40,0x00,0x00,0x10,0x0C,0x80,
0x85,0x01,0x10,0x00,0x00,0x02,0x08,0x80,0x82,0x02,0x20,0x00,0x01,0x10,0x12,0x00,
0x89,0x00,0x00,0x00,0x00,0x00,0x08,0x00,0x82,0x00,0x00,0x00,0x01,0x10,0x00,0x00,
0x91,0x71,0xE5,0xC7,0xC0,0xFA,0x09,0xC0,0x8A,0xE3,0xCB,0x8F,0x83,0xD7,0x1E,0x00,
0xA1,0x8A,0x16,0x28,0x41,0x0A,0x08,0x20,0x93,0x14,0x2C,0x50,0x81,0x18,0xA1,0x00,
0xC1,0x0A,0x14,0x28,0x41,0x0A,0x08,0x20,0xA2,0x14,0x28,0x50,0x81,0x10,0xA1,0x00,
0xA1,0x0A,0x14,0x28,0x41,0x0A,0x09,0xE0,0xC2,0x14,0x28,0x50,0x81,0x10,0xBF,0x00,
0x91,0x0A,0x14,0x28,0x41,0x0A,0x0A,0x20,0xA2,0x14,0x28,0x50,0x81,0x10,0xA0,0x00,
0x89,0x0A,0x14,0x28,0xC1,0x1A,0x0A,0x20,0x92,0x14,0x28,0x51,0x81,0x10,0xA1,0x00,
0x85,0x09,0xE4,0x27,0x40,0xEA,0x09,0xE0,0x8A,0x13,0xC8,0x4E,0x80,0xD0,0x9E,0x00,
0x00,0x00,0x00,0x00,0x40,0x08,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x00,0x00,0x00,
0x00,0x00,0x00,0x07,0x80,0xF0,0x00,0x00,0x00,0x00,0x00,0x0F,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
};

//********************************************************************************
flash unsigned  int msg[]=
{
 0x68, 0x98, 0x88, 0x60, 0x10, 0x88, 0xC8, 0xB0,//S
 0xF8, 0x48, 0x50, 0x70, 0x50, 0x40, 0x48, 0xF8, //E
0x34, 0x4C, 0x84, 0x80, 0x80, 0x80, 0x44, 0x38, //C


 0x88, 0xD8, 0xD8, 0xD8, 0xA8, 0xA8, 0xA8, 0x88, //M
 0xE0, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0xE0, //I
0xC8, 0x68,  0x68, 0x68, 0x58, 0x58, 0x58, 0xC8, //N

 0xD8, 0x50, 0x50, 0x70, 0x50, 0x50, 0x50, 0xD8, // H
 0x70, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x70,  //O
 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x70, //U
 0xF0, 0x48, 0x48, 0x70, 0x50, 0x50, 0x48, 0xC8, //R

 0x88, 0xD8, 0xD8, 0xD8, 0xA8, 0xA8, 0xA8, 0x88, //M
 0x70, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x70,  //O
 0xF0, 0x48, 0x48, 0x48, 0x48, 0x48, 0x48, 0xF0  //D
 };
flash unsigned int font1[]={
0x70, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x70,  //0
0x20, 0xE0, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, //1
0x70, 0x88, 0x88, 0x10, 0x20, 0x40, 0x80, 0xF8,  //2
0x70, 0x88, 0x08, 0x70, 0x08, 0x08, 0x88, 0x70,  //3
0x30, 0x30, 0x50, 0x50, 0x90, 0xF8, 0x10, 0x10,  //4
0xF8, 0x80, 0x80, 0xF0, 0x08, 0x08, 0x88, 0x70,// 5
0x70, 0x88, 0x80, 0xF0, 0x88, 0x88, 0x88, 0x70,
0xF8, 0x08, 0x10, 0x10, 0x10, 0x20, 0x20, 0x20,
0x70, 0x88, 0x88, 0x70, 0x88, 0x88, 0x88, 0x70,
0x70, 0x88, 0x88, 0x88, 0x78, 0x08, 0x88, 0x70,

0x00, 0x38, 0x44, 0x44, 0x44, 0x44, 0x44, 0x38,  //0
0x00, 0x20, 0x60, 0x20, 0x20, 0x20, 0x20, 0x70, //1
0x00, 0x38, 0x44, 0x04, 0x08, 0x10, 0x20, 0x7c,  //2
0x00, 0x38, 0x44, 0x04, 0x18, 0x04, 0x44, 0x38,  //3
0x00, 0x0c, 0x14, 0x24, 0x44, 0x7c, 0x04, 0x04,  //4
0x00, 0x7c, 0x40, 0x78, 0x04, 0x04, 0x44, 0x38,// 5
0x00, 0x38, 0x44, 0x40, 0x78, 0x44, 0x44, 0x38,
0x00, 0x7c, 0x44, 0x04, 0x08, 0x10, 0x10, 0x10,
0x00, 0x38, 0x44, 0x44, 0x38, 0x44, 0x44, 0x38,
0x00, 0x38, 0x44, 0x44, 0x3c, 0x04, 0x44, 0x38
 };
#include <SpiMem.c>
// chuong trinh con spi mem

/*----------------------------------------------------------------------------*/
// ctc chot du lieu
void latch_data(void)
{
  CKL=0;
  CKL=1;
}
/*----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
// ctc dich du lieu
void Shift_data(void)
{
  SCLK=0;
  SCLK=1;
}
/*----------------------------------------------------------------------------*/

void spi_mem(unsigned char data)
{
        unsigned char n;
        for(n=0x80;n!=0;n>>=1)  // SPI Data Order: MSB First
        {
                R=~data&n;       //  ='0' khi data&n=0, ='1' khi data&n!=0
                Shift_data();   // dich bit
        };
}


#include <ScreenScan.c>
//*****************************************************************************



/*----------------------------------------------------------------------------*/
// ctc hien thi du lieu ra man hinh
void scan_screen(void)
{
  OE=1;  //  "0" thi enalbe 74138, "1" disable 74138
if(dem==0)
  for(i=0;i<wb;i++)
 {
   if(i==0)
  {
    spi_mem(buf_screen_1[(r+12)+i]);
    spi_mem(buf_screen_1[(r+8)+i]);
    spi_mem(buf_screen_1[(r+4)+i]);
    spi_mem(buf_screen_1[(r+0)+i]);
  }
   if(i==1)
  {
    spi_mem(buf_screen_1[(r+12)+i+15]);
    spi_mem(buf_screen_1[(r+8)+i+15]);
    spi_mem(buf_screen_1[(r+4)+i+15]);
    spi_mem(buf_screen_1[(r+0)+i+15]);
  }
  if(i==2)
  {
    spi_mem(buf_screen_1[(r+12)+i+30]);
    spi_mem(buf_screen_1[(r+8)+i+30]);
    spi_mem(buf_screen_1[(r+4)+i+30]);
    spi_mem(buf_screen_1[(r+0)+i+30]);
  }
      if(i==3)
  {
    spi_mem(buf_screen_1[(r+12)+i+45]);
    spi_mem(buf_screen_1[(r+8)+i+45]);
    spi_mem(buf_screen_1[(r+4)+i+45]);
    spi_mem(buf_screen_1[(r+0)+i+45]);
  }
 };
 if(dem==1)
 for(i=0;i<wb;i++)
 {
   if(status_buf)
  {
    spi_mem(buf_screen_1[(r+12)*wb+i]);
    spi_mem(buf_screen_1[(r+8)*wb+i]);
    spi_mem(buf_screen_1[(r+4)*wb+i]);
    spi_mem(buf_screen_1[(r+0)*wb+i]);
  }
  else
  {
    spi_mem(buf_screen_0[(r+12)*wb+i]);
    spi_mem(buf_screen_0[(r+8)*wb+i]);
    spi_mem(buf_screen_0[(r+4)*wb+i]);
    spi_mem(buf_screen_0[(r+0)*wb+i]);
  };
 };
 latch_data();
 ROW=r; // hang thu r duoc hien thi
 OE=0; // enable 74138
 r++;
 if (r==4)
 {
   r=0;
 }
}

/*----------------------------------------------------------------------------*/

//*******************************************************************************
#include <delay.h>
#define SET  PINC.4
#define UP   PINC.3
// I2C Bus functions
#asm
   .equ __i2c_port=0x15 ;PORTC
   .equ __sda_bit=1
   .equ __scl_bit=0
#endasm
#include <i2c.h>
// DS1307 Real Time Clock functions
#include <ds1307.h>

// Cac chuong trinh tao hieu ung cho led matrix
#include <ShiftLeft.c>
//******************************************************************
// Hieu ung dich trai msg
/*----------------------------------------------------------------------------*/
 // ctc cap nhat byte du lieu de dich trai
 void up_data_1(void)
 {
 // b_shift=0: dich du lieu man hinh ra ngoai, va tu flash vao trong man hinh
 // b_shft=1: chi dich du lieu man hinh ra ngoai => b_data luôn luôn=0
   if ((b_shift==1)||(count_byte>=msg1[2]))
   {
     b_data=0;
   }
   else
   {
     if ((b_shift==0)&&(count_byte<msg1[2]))
     {
       b_data=(msg1[row*msg1[2]+count_byte+3]<<count_bit);
     }
   };
 }
 /*----------------------------------------------------------------------------*/

 /*----------------------------------------------------------------------------*/
 // ctc dich trai chuoi msg tren led matrix
 void effect_1(void)
 {
   /*******************************************************************************
    -Thuat giai dich trai chuoi tren led matrix: coi msg la phan man hinh ao ben phai man hinh led thuc
    +  Moi byte tren 1 hang dich sang trai 1 bit
    +  Bit 0 cua byte bat ki duoc thay boi bit 7 cua byte lien truoc (khi chua dich)
   *******************************************************************************/
  if(load_effect)
  {
    if(status_buf)  // khi dang quet hien thi o bo dem 1 thi sap sep du lieu o bo dem 0
    {
      // Gia su man hinh led co kich thuoc ngang wb byte
      for(row=0; row<16; row++)
      {
        // chuyen du lieu giua cac byte trong bo dem man hinh
        for(j=0;j<wb-1;j++)
        {
          buf_screen_0[row*wb+j]=(buf_screen_1[row*wb+j]<<1)|(buf_screen_1[row*wb+j+1]>>7);
        };
        //chuyen du lieu tu msg vao bo dem man hinh
        up_data_1(); //   update du lieu cho b_data o hieu ung 1
        buf_screen_0[row*wb+wb-1]=(buf_screen_1[row*wb+wb-1]<<1)|(b_data>>7);
      };
    }
     // khi dang quet hien thi o bo dem 1 thi sap sep du lieu o bo dem 0
    else
    {
      // Gia su man hinh led co kich thuoc ngang wb byte
      for(row=0; row<16; row++)
      {
        // chuyen du lieu giua cac byte trong bo dem man hinh
        for(j=0;j<wb-1;j++)
        {
          buf_screen_1[row*wb+j]=(buf_screen_0[row*wb+j]<<1)|(buf_screen_0[row*wb+j+1]>>7);
        };
        //chuyen du lieu tu msg vao bo dem man hinh
        up_data_1(); //   update du lieu cho b_data o hieu ung 1
        buf_screen_1[row*wb+wb-1]=(buf_screen_0[row*wb+wb-1]<<1)|(b_data>>7);
      };
     };
     load_effect=0; // Da load xong du lieu moi, tam khoa load du lieu cho lan tiep theo
   }
 }
/*----------------------------------------------------------------------------*/


//******************************************************************
//#include <ShiftRight.c>
//#include <ShiftUp.c>
//#include <ShiftDown.c>
#include <CheckEffect.c>
//************************************************************************

/*----------------------------------------------------------------------------*/
 // ctc kiem tra su  dich chuyen hieu ung trai & phai
 void check_effect_12(unsigned int stop_byte)
 {
   // doan ctc kiem soát so bit chuyen dich
   k++;
   if(k==1)  // thoi gian dich hieu ung
   {
     if(load_effect==0)    // Du lieu moi da load
     {
      count_bit++;
      if(count_bit==8)
      {
        count_bit=0;
        count_byte++;
        if(count_byte==stop_byte)  // stop_byte=so byte can dich cua msg+wb(so byte man hinh led)
        {
          count_byte=0;
          effect++;
          dem=0;
        }
      }
      status_buf=~status_buf;  // dao man hinh hien thi
      load_effect=1; // tiêp tuc cho phep load du lieu cho hieu ung
      k=0;

     }
   }
 }
 /*----------------------------------------------------------------------------*/




void timedeal(void);

/*----------------------------------------------------------------------------*/
// ctc lua chon hieu ung hien thi
/*
void case_effect(void)
{
  switch (effect)
  {
    case 0:
             check_effect=1;
             effect_3();
             break;

   case 1:
             check_effect=0;
             effect_1();
             break;
   case 2:
             check_effect=1;
             effect_4();
             break;

   case 3:
             check_effect=0;
             effect_2();
             break;
   default:
            if(effect==4)
            {
             effect=0;
            }
  };
}  */
/*----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------*/
// ctc lua chon hieu ung hien thi
void case_check_effect(void)
{
  check_effect_12(msg1[2]+4);
}
/*----------------------------------------------------------------------------*/



 /*----------------------------------------------------------------------------*/
 // Declare your global variables here
unsigned char giaima(unsigned char so)
{
switch(so)
{
case 0 : return 0;
case 1 : return 8;
case 2 : return 16;
case 3 : return 24;
case 4 : return 32;
case 5 : return 40;
case 6 : return 48;
case 7 : return 56;
case 8 : return 64;
case 9 : return 72;
}
}
// Timer 0 output compare interrupt service routine
interrupt [TIM0_COMP] void timer0_comp_isr(void)
{
dem1++;
dem1=dem1%20;
if(dem1<10) {
daucham=0;
}
else  daucham=2;
 // Place your code here
if(dem==1)case_check_effect();
else
{
if(!SET && SET!=set_old) //check the set key
{
setting++;
if(setting==5){
setting=0;
}
rtc_set_time(hour,min,sec);
rtc_set_date(day,month,year);
}
if(setting==0)
{

rtc_get_time(&hour,&min,&sec);
rtc_get_date(&day,&month,&year);
}
if(setting==1)
{
if(!UP && UP!=up_old) //check the up key
{
sec++;
timedeal();
}
if(!UP && UP!=up_old) //check the up key
{
sec++;
timedeal();
}
}else if(setting==2)
{
if(!UP && UP!=up_old) //check the up key
{
min++;
timedeal();
}
}else if(setting==3)
{
if(!UP && UP!=up_old) //check the up key
{
hour++;
timedeal();
}
}
else if(setting==4)
{
if(!UP && UP!=up_old) //check the up key
{
mode++;
if(mode>2) mode=0;
}
}
set_old=SET;
up_old=UP;
}
}
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
// Timer 1 output compare A interrupt service routine
// Dung timer 1 de scan led matrix
interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
 // Place your code here
   // Doc gio, phut, giay tu ds1307
  scan_screen();

}
/*----------------------------------------------------------------------------*/


void main(void)
{
#include <ConfigSet.c>
//////////////////
PORTA=0xFF;
DDRA=0xFF;

PORTB=0xFF;
DDRB=0xFF;    // PORTB lam dau ra

PORTC=0x00;
DDRC=0x00;    // PORTC lam dau ra

PORTD=0xFF;
DDRD=0xFF;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 3.906 kHz
// Mode: CTC top=OCR0
// OC0 output: Disconnected
TCCR0=0x0D;
TCNT0=0x00;
OCR0=0xAF;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 3.906 kHz
// Mode: CTC top=OCR1A
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: On
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x0D;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x0F;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x12;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;
/*
// SPI initialization
// SPI Type: Master
// SPI Clock Rate: 2*1000.000 kHz
// SPI Clock Phase: Cycle Half
// SPI Clock Polarity: Low
// SPI Data Order: MSB First
SPCR=0x50;
SPSR=0x01;
*/
// Global enable interrupts
i2c_init();
rtc_init(0,1,0);
#asm("sei")
dem=1;
//rtc_set_date(17,8,13);
while (1)
      {
  if(dem==1)
  {
       check_effect=0;
       effect_1();
       }
   else
   {
         if(setting==0)
         {
            if(mode==0)
              for(k=0;k<8;k++)
            {
                buf_screen_1[k]=font1[giaima(hour/10)+k];
                buf_screen_1[k+8]=0x00;
                buf_screen_1[k+16]=font1[giaima(hour%10)+k];
                buf_screen_1[k+24]=font1[giaima(sec/10)+k+80];
                buf_screen_1[k+32]=font1[giaima(min/10)+k];
                buf_screen_1[k+40]=font1[giaima(sec%10)+k+80];
                buf_screen_1[k+48]=font1[giaima(min%10)+k];
                buf_screen_1[k+56]=0x00;
                if((k+16)==17)buf_screen_1[17]+=daucham;
                if((k+16)==18)buf_screen_1[18]+=daucham;
                if((k+16)==21)buf_screen_1[21]+=daucham;
                if((k+16)==22)buf_screen_1[22]+=daucham;
            }
             if(mode==1)
              for(k=0;k<8;k++)
            {
                buf_screen_1[k]=font1[giaima(hour/10)+k+80];
                buf_screen_1[k+8]=0x00;
                buf_screen_1[k+16]=font1[giaima(hour%10)+k+80];
                buf_screen_1[k+24]=0x00;
                buf_screen_1[k+32]=font1[giaima(min/10)+k+80];
                buf_screen_1[k+40]=0x00;
                buf_screen_1[k+48]=font1[giaima(min%10)+k+80];
                buf_screen_1[k+56]=0x00;
                if((k+16)==17)buf_screen_1[17]+=daucham;
                if((k+16)==18)buf_screen_1[18]+=daucham;
                if((k+16)==21)buf_screen_1[21]+=daucham;
                if((k+16)==22)buf_screen_1[22]+=daucham;
            }
            if(mode==2)
             for(k=0;k<8;k++)
            {
                buf_screen_1[k]=font1[giaima(hour/10)+k];
                buf_screen_1[k+8]=font1[giaima(day/10)+k+80];
                buf_screen_1[k+16]=font1[giaima(hour%10)+k];
                buf_screen_1[k+24]=font1[giaima(day%10)+k+80];
                buf_screen_1[k+32]=font1[giaima(min/10)+k];
                buf_screen_1[k+40]=font1[giaima(month/10)+k+80];
                buf_screen_1[k+48]=font1[giaima(min%10)+k];
                buf_screen_1[k+56]=font1[giaima(month%10)+k+80];
                if((k+16)==17)buf_screen_1[17]+=daucham;
                if((k+16)==18)buf_screen_1[18]+=daucham;
                if((k+16)==21)buf_screen_1[21]+=daucham;
                if((k+16)==22)buf_screen_1[22]+=daucham;
                if((k+24)==28)buf_screen_1[28]+=3;
            }

            }
       if(setting==1)
           for(k=0;k<8;k++)
            {
                buf_screen_1[k]=msg[k];
                buf_screen_1[k+8]=0x00;
                buf_screen_1[k+16]=msg[k+8];
                buf_screen_1[k+24]=font1[giaima(sec/10)+k+80];
                buf_screen_1[k+32]=msg[k+16];
                buf_screen_1[k+40]=font1[giaima(sec%10)+k+80];
                buf_screen_1[k+48]=0x00;
                buf_screen_1[k+56]=0x00;

            }
        if(setting==2)
           for(k=0;k<8;k++)
            {
                buf_screen_1[k]=msg[k+24];
                buf_screen_1[k+8]=0x00;
                buf_screen_1[k+16]=msg[k+32];
                buf_screen_1[k+24]=font1[giaima(min/10)+k+80];
                buf_screen_1[k+32]=msg[k+40];
                buf_screen_1[k+40]=font1[giaima(min%10)+k+80];
                buf_screen_1[k+48]=0x00;
                buf_screen_1[k+56]=0x00;

            }
         if(setting==3)
           for(k=0;k<8;k++)
            {
                buf_screen_1[k]=msg[k+48];
                buf_screen_1[k+8]=0x00;
                buf_screen_1[k+16]=msg[k+56];
                buf_screen_1[k+24]=font1[giaima(hour/10)+k+80];
                buf_screen_1[k+32]=msg[k+64];
                buf_screen_1[k+40]=font1[giaima(hour%10)+k+80];
                buf_screen_1[k+48]=msg[k+72];
                buf_screen_1[k+56]=0x00;

            }
               if(setting==4)
           for(k=0;k<8;k++)
            {
                buf_screen_1[k]=msg[k+80];
                buf_screen_1[k+8]=0x00;
                buf_screen_1[k+16]=msg[k+88];
                buf_screen_1[k+24]=font1[giaima(mode/10)+k+80];
                buf_screen_1[k+32]=msg[k+96];
                buf_screen_1[k+40]=font1[giaima(mode%10)+k+80];
                buf_screen_1[k+48]=0X00;
                buf_screen_1[k+56]=0x00;
            }
            }
      };

}
void timedeal(void)
{
if(sec>=60)
{
sec=0;
}
if(min>=60)
{
min=0;
}
if(hour>=24)
hour=0;
/*if(year>=99)
{
year=10;
}
if(month>=13)
{
month=1;
}
if(day>=32)
day=0;
if(a_min>=60)
{
a_min=0;
}
if(a_hour>=24)
a_hour=0; */
}



