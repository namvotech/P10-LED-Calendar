#include <linux/module.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <mach/at91_tc.h>
#include <asm/gpio.h>
#include <asm/atomic.h>
#include <linux/genhd.h>
#include <linux/miscdevice.h>
#include <asm/uaccess.h>
#include <linux/clk.h>
#include <linux/irq.h>
#include <linux/time.h>
#include <linux/jiffies.h>
#include <linux/sched.h>
#include <linux/delay.h>
#include <linux/string.h>

#define DRVNAME      "matrix_led_dev"
#define DEVNAME      "matrix_led"

				/*-------------Port Control-----------*/
#define DATA_C 	AT91_PIN_PB21
#define OE_C 	AT91_PIN_PB23
#define LATCH_C AT91_PIN_PB25
#define CLOCK_C AT91_PIN_PB27

#define DATA_R 	AT91_PIN_PB20
#define OE_R 	AT91_PIN_PB22
#define LATCH_R AT91_PIN_PB24
#define CLOCK_R AT91_PIN_PB26

#define DATA_X 	AT91_PIN_PB31
#define OE_X	AT91_PIN_PB29
#define LATCH_X AT91_PIN_PB30
#define CLOCK_X AT91_PIN_PB28

						/*Basic commands*/
#define SET_DATA_C()				gpio_set_value(DATA_C,1)
#define SET_CLOCK_C()				gpio_set_value(CLOCK_C,1)
#define SET_LATCH_C()				gpio_set_value(LATCH_C,1)
#define SET_OE_C()				gpio_set_value(OE_C,1)

#define SET_DATA_R()				gpio_set_value(DATA_R,1)
#define SET_CLOCK_R()				gpio_set_value(CLOCK_R,1)
#define SET_LATCH_R()				gpio_set_value(LATCH_R,1)
#define SET_OE_R()				gpio_set_value(OE_R,1)

#define SET_DATA_X()				gpio_set_value(DATA_X,1)
#define SET_CLOCK_X()				gpio_set_value(CLOCK_X,1)
#define SET_LATCH_X()				gpio_set_value(LATCH_X,1)
#define SET_OE_X()				gpio_set_value(OE_X,1)


#define CLEAR_DATA_C()				gpio_set_value(DATA_C,0)
#define CLEAR_CLOCK_C()				gpio_set_value(CLOCK_C,0)
#define CLEAR_LATCH_C()				gpio_set_value(LATCH_C,0)
#define CLEAR_OE_C()				gpio_set_value(OE_C,0)

#define CLEAR_DATA_R()				gpio_set_value(DATA_R,0)
#define CLEAR_CLOCK_R()				gpio_set_value(CLOCK_R,0)
#define CLEAR_LATCH_R()				gpio_set_value(LATCH_R,0)
#define CLEAR_OE_R()				gpio_set_value(OE_R,0)

#define CLEAR_DATA_X()				gpio_set_value(DATA_X,0)
#define CLEAR_CLOCK_X()				gpio_set_value(CLOCK_X,0)
#define CLEAR_LATCH_X()				gpio_set_value(LATCH_X,0)
#define CLEAR_OE_X()				gpio_set_value(OE_X,0)

#define MATRIX_LED_DEV_MAGIC  'B'
#define SWEEP_LED_DELAY        			_IOWR(MATRIX_LED_DEV_MAGIC, 0,unsigned long)
#define SHIFT_LEFT				_IOWR(MATRIX_LED_DEV_MAGIC, 1,unsigned long)
#define SHIFT_RIGHT				_IOWR(MATRIX_LED_DEV_MAGIC, 2,unsigned long)
#define UPDATE_SPEED				_IOWR(MATRIX_LED_DEV_MAGIC, 3,unsigned long)
#define PAUSE					_IOWR(MATRIX_LED_DEV_MAGIC, 4,unsigned long)
#define MAU_DO					_IOWR(MATRIX_LED_DEV_MAGIC, 5,unsigned long)
#define MAU_XANH				_IOWR(MATRIX_LED_DEV_MAGIC, 6,unsigned long)
#define CA_HAI					_IOWR(MATRIX_LED_DEV_MAGIC, 7,unsigned long)
#define ANH					_IOWR(MATRIX_LED_DEV_MAGIC, 8,unsigned long)
#define KY_TU					_IOWR(MATRIX_LED_DEV_MAGIC, 9,unsigned long)

/* Counter is 1, if the device is not opened and zero (or less) if opened. */
static atomic_t matrix_led_open_cnt = ATOMIC_INIT(1);
unsigned char DataDisplay[1000];
unsigned char anh[100];
unsigned char write_buf[1000] ;

unsigned char MatrixCode[6];
unsigned char MatrixCodeAnh1[8],MatrixCodeAnh2[8],MatrixCodeAnh3[8],MatrixCodeAnh4[8],MatrixCodeAnh5[8],MatrixCodeAnh6[8],MatrixCodeAnh7[8],MatrixCodeAnh8[8];
unsigned char ColumnCode[]={0xfe,0xfd,0xfb,0xf7,0xef,0xdf,0xbf,0x7f};
//unsigned char ColumnCode1[]={0xfe,0xfd,0xfb,0xf7,0xef,0xdf,0xbf,0x7f};
////////////////////////thoa///////////////////////////////////
unsigned char font1[8];
unsigned char so1=0,so2=0,so3=0,so4=0,so5=0,so6=0,so7=0,so8=0;
///////////////////////////////////////////////////////////////////

			//{0xfe,0xfd,0xfb,0xf7,0xef,0xdf,0xbf,0x7f};
			//{0xf7,0xfb,0xfd,0xfe,0x7f,0xbf,0xdf,0xef};	
unsigned char font[]={
//******************BANG MA ASCII****************
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,//SPACE    0
0xFF,0xFF,0xFF,0xA0,0xFF,0xFF,//!    1
0xFF,0xFF,0xFF,0xF8,0xF4,0xFF,//'    2
0xFF,0xEB,0x80,0xEB,0x80,0xEB,//#    3
0xFF,0xDB,0xD5,0x80,0xD5,0xED,//$    4
0xFF,0xD8,0xEA,0x94,0xAB,0x8D,//%    5
0xFF,0xC9,0xB6,0xA9,0xDF,0xAF,//&    6
0xFF,0xFF,0xFF,0xF8,0xF4,0xFF,//'    7
0xFF,0xFF,0xE3,0xDD,0xBE,0xFF,//(    8
0xFF,0xFF,0xBE,0xDD,0xE3,0xFF,//)    9
0xFF,0xD5,0xE3,0x80,0xE3,0xD5,//*    10
0xFF,0xF7,0xF7,0xC1,0xF7,0xF7,//+    11
0xFF,0xFF,0x5F,0x9F,0xFF,0xFF,//,    12
0xFF,0xF7,0xF7,0xF7,0xF7,0xF7,//-    13
0xFF,0xFF,0x9F,0x9F,0xFF,0xFF,//x    14
0xFF,0xFF,0xC9,0xC9,0xFF,0xFF,///    15
0xFF,0xC1,0xAE,0xB6,0xBA,0xC1,//0    16
0xFF,0xFF,0xBD,0x80,0xBF,0xFF,//1    17
0xFF,0x8D,0xB6,0xB6,0xB6,0xB9,//2    18
0xFF,0xDD,0xBE,0xB6,0xB6,0xC9,//3    19
0xFF,0xE7,0xEB,0xED,0x80,0xEF,//4    20
0xFF,0xD8,0xBA,0xBA,0xBA,0xC6,//5    21
0xFF,0xC3,0xB5,0xB6,0xB6,0xCF,//6    22
0xFF,0xFE,0x8E,0xF6,0xFA,0xFC,//7    23
0xFF,0xC9,0xB6,0xB6,0xB6,0xC9,//8    24
0xFF,0xF9,0xB6,0xB6,0xD6,0xE1,//9    25
0xFF,0xFF,0xC9,0xC9,0xFF,0xFF,//:    26
0xFF,0xFF,0xA4,0xC4,0xFF,0xFF,////   27
0xFF,0xF7,0xEB,0xDD,0xBE,0xFF,//<    28
0xFF,0xEB,0xEB,0xEB,0xEB,0xEB,//=    29
0xFF,0xFF,0xBE,0xDD,0xEB,0xF7,//>    30
0xFF,0xFD,0xFE,0xAE,0xF6,0xF9,//?    31
0xFF,0xCD,0xB6,0x8E,0xBE,0xC1,//@    32
0xFF,0x83,0xF5,0xF6,0xF5,0x83,//A    33
0xFF,0xBE,0x80,0xB6,0xB6,0xC9,//B    34
0xFF,0xC1,0xBE,0xBE,0xBE,0xDD,//C    35
0xFF,0xBE,0x80,0xBE,0xBE,0xC1,//D    36
0xFF,0x80,0xB6,0xB6,0xB6,0xBE,//E    37
0xFF,0x80,0xF6,0xF6,0xFE,0xFE,//F    38
0xFF,0xC1,0xBE,0xB6,0xB6,0xC5,//G    39
0xFF,0x80,0xF7,0xF7,0xF7,0x80,//H	40
0xFF,0xFF,0xBE,0x80,0xBE,0xFF,//I	41
0xFF,0xDF,0xBF,0xBE,0xC0,0xFE,//J	42
0xFF,0x80,0xF7,0xEB,0xDD,0xBE,//K    43
0xFF,0x80,0xBF,0xBF,0xBF,0xFF,//L    44
0xFF,0x80,0xFD,0xF3,0xFD,0x80,//M    45
0xFF,0x80,0xFD,0xFB,0xF7,0x80,//N    46
0xFF,0xC1,0xBE,0xBE,0xBE,0xC1,//O    47
0xFF,0x80,0xF6,0xF6,0xF6,0xF9,//P    48
0xFF,0xC1,0xBE,0xAE,0xDE,0xA1,//Q    49
0xFF,0x80,0xF6,0xE6,0xD6,0xB9,//R    50
0xFF,0xD9,0xB6,0xB6,0xB6,0xCD,//S    51
0xFF,0xFE,0xFE,0x80,0xFE,0xFE,//T    52
0xFF,0xC0,0xBF,0xBF,0xBF,0xC0,//U    53
0xFF,0xE0,0xDF,0xBF,0xDF,0xE0,//V    54
0xFF,0xC0,0xBF,0xCF,0xBF,0xC0,//W    55
0xFF,0x9C,0xEB,0xF7,0xEB,0x9C,//X    56
0xFF,0xFC,0xFB,0x87,0xFB,0xFC,//Y    57
0xFF,0x9E,0xAE,0xB6,0xBA,0xBC,//Z    58
0xFF,0xFF,0x80,0xBE,0xBE,0xFF,//[    59
0xFF,0xFD,0xFB,0xF7,0xEF,0xDF,//\    60
0xFF,0xFF,0xBE,0xBE,0x80,0xFF,//]    61
0xFF,0xFB,0xFD,0xFE,0xFD,0xFB,//^    62
0xFF,0x7F,0x7F,0x7F,0x7F,0x7F,//_    63
0xFF,0xFF,0xFF,0xF8,0xF4,0xFF,//'    64
0xFF,0xDF,0xAB,0xAB,0xAB,0xC7,//a    65
0xFF,0x80,0xC7,0xBB,0xBB,0xC7,//b	66
0xFF,0xFF,0xC7,0xBB,0xBB,0xBB,//c	67
0xFF,0xC7,0xBB,0xBB,0xC7,0x80,//d	68
0xFF,0xC7,0xAB,0xAB,0xAB,0xF7,//e    69
0xFF,0xF7,0x81,0xF6,0xF6,0xFD,//f	70
0xFF,0xF7,0x6B,0x6B,0x6B,0x83,//g    71
0xFF,0x80,0xF7,0xFB,0xFB,0x87,//h    72
0xFF,0xFF,0xBB,0x82,0xBF,0xFF,//i    73
0xFF,0xDF,0xBF,0xBB,0xC2,0xFF,//j    74
0xFF,0xFF,0x80,0xEF,0xD7,0xBB,//k    75
0xFF,0xFF,0xBE,0x80,0xBF,0xFF,//l    76
0xFF,0x83,0xFB,0x87,0xFB,0x87,//m    77
0xFF,0x83,0xF7,0xFB,0xFB,0x87,//n    78
0xFF,0xC7,0xBB,0xBB,0xBB,0xC7,//o    79
0xFF,0x83,0xEB,0xEB,0xEB,0xF7,//p    80
0xFF,0xF7,0xEB,0xEB,0xEB,0x83,//q    81
0xFF,0x83,0xF7,0xFB,0xFB,0xF7,//r    82
0xFF,0xB7,0xAB,0xAB,0xAB,0xDB,//s    83
0xFF,0xFF,0xFB,0xC0,0xBB,0xBB,//t    84
0xFF,0xC3,0xBF,0xBF,0xDF,0x83,//u    85
0xFF,0xE3,0xDF,0xBF,0xDF,0xE3,//v    86
0xFF,0xC3,0xBF,0xCF,0xBF,0xC3,//w    87
0xFF,0xBB,0xD7,0xEF,0xD7,0xBB,//x    88
0xFF,0xF3,0xAF,0xAF,0xAF,0xC3,//y    89
0xFF,0xBB,0x9B,0xAB,0xB3,0xBB,//z    90
0xFF,0xFB,0xE1,0xE0,0xE1,0xFB,//^    91
0xFF,0xE3,0xE3,0xC1,0xE3,0xF7,//->   93
0xFF,0xF7,0xE3,0xC1,0xE3,0xE3,//<-   93
0xFF,0xEF,0xC3,0x83,0xC3,0xEF,//     94
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,//BLANK CHAR 95
};
// End of code table
int     letter,i=0,cycle=0,slip=0,shift=0,shift_speed=50,pause=0,k=0,mau=0;	
bool trang_thai=0;															
void __iomem *at91tc0_base;
struct clk *at91tc0_clk;

void sweep_led_delay(unsigned int delay) {
	long int time_delay;
	time_delay = jiffies + delay;
	while (time_before(jiffies, time_delay)) {
		schedule();
		}
}
void mang64_to_mang8(int j){

	int d;
	
	if (j<8)         	   for(d=0;d<8;d++) { MatrixCodeAnh1[d]=anh[d+0]; }
   	else if ((j>= 8)&&(j<16))  for(d=0;d<8;d++) { MatrixCodeAnh2[d]=anh[d+8]; }
   	else if ((j>= 16)&&(j<24)) for(d=0;d<8;d++) { MatrixCodeAnh3[d]=anh[d+16]; }
  	else if ((j>= 24)&&(j<32)) for(d=0;d<8;d++) { MatrixCodeAnh4[d]=anh[d+24]; }
	else if ((j>= 32)&&(j<40)) for(d=0;d<8;d++) { MatrixCodeAnh5[d]=anh[d+32]; }
   	else if ((j>= 40)&&(j<48)) for(d=0;d<8;d++) { MatrixCodeAnh6[d]=anh[d+40]; }
  	else if ((j>= 48)&&(j<56)) for(d=0;d<8;d++) { MatrixCodeAnh7[d]=anh[d+48]; }
	else if ((j>= 56)&&(j<64)) for(d=0;d<8;d++) { MatrixCodeAnh8[d]=anh[d+56]; }

}
////khi da tach duoc 8 mang rieng biet, moi mang gom 8 con so chuong trinh con nay co tac dung chuyen 1 mang ve 1 so
void convert_mang_so(void)
{
    for (i=0;i<8;i++)
      {  
    if((MatrixCodeAnh1[i]==1)
	{
          so1=so1|(1<<i);
	}
              
           }

   for (i=0;i<8;i++)
      {  
    if((MatrixCodeAnh2[i]==1)
	{
          so2=so2|(1<<i);
	}
              
           }

   for (i=0;i<8;i++)
      {  
    if((MatrixCodeAnh3[i]==1)
	{
          so3=so3|(1<<i);
	}
              
           }
     
.
.
.
.
.
.
.
.

   for (i=0;i<8;i++)
      {  
    if((MatrixCodeAnh8[i]==1)
	{
          so8=so8|(1<<i);
	}
              
           }


 font1[0]=so1;
 font1[1]=so2;
 font1[2]=so3;
.
.
.
.
.
font1[7]=so8;
///luc do font1[] la mot mang gom 8 so chay nhu binh thuong
}
void ndelay(unsigned long nsec);


void row_write_anh_data( int j)
{
	
	int d;
	if (j==0)       for(d=0;d<8;d++) { (MatrixCodeAnh1[d])? CLEAR_DATA_R():SET_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
   	else if (j== 1) for(d=0;d<8;d++) { (MatrixCodeAnh2[d])? CLEAR_DATA_R():SET_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
   	else if (j== 2) for(d=0;d<8;d++) { (MatrixCodeAnh3[d])? CLEAR_DATA_R():SET_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
  	else if (j== 3) for(d=0;d<8;d++) { (MatrixCodeAnh4[d])? CLEAR_DATA_R():SET_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
	else if (j== 4) for(d=0;d<8;d++) { (MatrixCodeAnh5[d])? CLEAR_DATA_R():SET_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
   	else if (j== 5) for(d=0;d<8;d++) { (MatrixCodeAnh6[d])? CLEAR_DATA_R():SET_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
  	else if (j== 6) for(d=0;d<8;d++) { (MatrixCodeAnh7[d])? CLEAR_DATA_R():SET_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
	else if (j== 7) for(d=0;d<8;d++) { (MatrixCodeAnh8[d])? CLEAR_DATA_R():SET_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}//printk("ok");}

	// for (j=0;j<8;j++){(data[j])? SET_DATA_R():CLEAR_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
	
	SET_LATCH_R();
	CLEAR_LATCH_R();
	
}

void column_write_anh_data(unsigned char dulieu1)//,unsigned char dulieu2,unsigned char dulieu3,unsigned char dulieu4)
{
	unsigned char data;

	int j;
	
	data = dulieu1;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_C():CLEAR_DATA_C();SET_CLOCK_C();CLEAR_CLOCK_C();}
	//data = dulieu2;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_C():CLEAR_DATA_C();SET_CLOCK_C();CLEAR_CLOCK_C();}
	//data = dulieu3;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_C():CLEAR_DATA_C();SET_CLOCK_C();CLEAR_CLOCK_C();}
	//data = dulieu4;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_C():CLEAR_DATA_C();SET_CLOCK_C();CLEAR_CLOCK_C();}
	
	SET_LATCH_C();
	CLEAR_LATCH_C();

}

void row_write_data(unsigned char data1)
{
	unsigned char data;
	int j;
	data =~ data1; for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_R():CLEAR_DATA_R();SET_CLOCK_R();CLEAR_CLOCK_R();}
	
	SET_LATCH_R();
	CLEAR_LATCH_R();
}




void column_write_data(unsigned char dulieu1,unsigned char dulieu2,unsigned char dulieu3,unsigned char dulieu4)
{
	unsigned char data;

	int j;
	
	data = dulieu1;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_C():CLEAR_DATA_C();SET_CLOCK_C();CLEAR_CLOCK_C();}
	data = dulieu2;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_C():CLEAR_DATA_C();SET_CLOCK_C();CLEAR_CLOCK_C();}
	data = dulieu3;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_C():CLEAR_DATA_C();SET_CLOCK_C();CLEAR_CLOCK_C();}
	data = dulieu4;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_C():CLEAR_DATA_C();SET_CLOCK_C();CLEAR_CLOCK_C();}
	
	SET_LATCH_C();
	CLEAR_LATCH_C();

}

void column_x_write_data(unsigned char data1,unsigned char data2,unsigned char data3,unsigned char data4)
{
	unsigned char data;

	int j;
	
	data = data1;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_X():CLEAR_DATA_X();SET_CLOCK_X();CLEAR_CLOCK_X();}
	data = data2;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_X():CLEAR_DATA_X();SET_CLOCK_X();CLEAR_CLOCK_X();}
	data = data3;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_X():CLEAR_DATA_X();SET_CLOCK_X();CLEAR_CLOCK_X();}
	data = data4;	for (j=0;j<8;j++){(data&(1<<j))? SET_DATA_X():CLEAR_DATA_X();SET_CLOCK_X();CLEAR_CLOCK_X();}
	
	SET_LATCH_X();
	CLEAR_LATCH_X();
	
	
}

static irqreturn_t at91tc0_isr(int irq, void *dev_id) {
	int status,j;
	
	// Read TC0 status register to reset RC compare status.
	status = ioread32(at91tc0_base + AT91_TC_SR);
	
   if (shift!=0)
   	{
		if (cycle < shift_speed)
		{       switch(mau)
{
				case 1:	{
					if (trang_thai==1){
						for (j=0;j<8;j++){
						SET_OE_C();
	 					SET_OE_R();
						SET_OE_X();				 
						
							
						
						//column_write_anh_data(ColumnCode[j]);
						if (i<8)                    {row_write_anh_data(j);column_write_data(ColumnCode[j],0xff,0xff,0xff);}
						//column_write_data(ColumnCode[j],0xff,0xff,0xff);
   						else if ((i>= 8)&&(i<16))  { row_write_anh_data(j);column_write_data(ColumnCode[j],0xff,0xff,0xff);}
   						else if ((i>= 16)&&(i<24)) {row_write_anh_data(j); column_write_data(ColumnCode[j],0xff,0xff,0xff);}
  						else if ((i>= 24)&&(i<32)) { row_write_anh_data(j);column_write_data(ColumnCode[j],0xff,0xff,0xff);}
	 					CLEAR_OE_C();
	 					CLEAR_OE_R();ndelay(15000); }
					}
					else {
						SET_OE_C();
	 					SET_OE_R();
						SET_OE_X();				 
				
						row_write_data(DataDisplay[slip+i]);
						if (i<8)      		   { column_write_data(ColumnCode[i],0xff,0xff,0xff);}
   						else if ((i>= 8)&&(i<16))  { column_write_data(0xff,ColumnCode[i-8],0xff,0xff);}
   						else if ((i>= 16)&&(i<24)) { column_write_data(0xff,0xff,ColumnCode[i-16],0xff);}
  						else if ((i>= 24)&&(i<32)) { column_write_data(0xff,0xff,0xff,ColumnCode[i-24]);}
	 					CLEAR_OE_C();
	 					CLEAR_OE_R();
						}	
					}
				
				
				break;
case 2:
				{
				if (trang_thai==1){
						for (j=0;j<8;j++){
						SET_OE_C();
	 					SET_OE_R();
						SET_OE_X();				 
						
							
						
						
						if (i<8)         	   { row_write_anh_data(j);column_x_write_data(ColumnCode[j],0xff,0xff,0xff); }
   						else if ((i>= 8)&&(i<16))  { row_write_anh_data(j);column_x_write_data(ColumnCode[j],0xff,0xff,0xff);}
   						else if ((i>= 16)&&(i<24)) {row_write_anh_data(j); column_x_write_data(ColumnCode[j],0xff,0xff,0xff);}
  						else if ((i>= 24)&&(i<32)) { row_write_anh_data(j);column_x_write_data(ColumnCode[j],0xff,0xff,0xff);}
	 					CLEAR_OE_X();
	 					CLEAR_OE_R();ndelay(15000);}
					}
					else {
				 		
				SET_OE_C();
	 			SET_OE_X();
				SET_OE_R();
				row_write_data(DataDisplay[slip+i]);
				if (i<8)         	   { column_x_write_data(ColumnCode[i],0xff,0xff,0xff); }
   				else if ((i>= 8)&&(i<16))  { column_x_write_data(0xff,ColumnCode[i-8],0xff,0xff);}
   				else if ((i>= 16)&&(i<24)) { column_x_write_data(0xff,0xff,ColumnCode[i-16],0xff);}
  				else if ((i>= 24)&&(i<32)) { column_x_write_data(0xff,0xff,0xff,ColumnCode[i-24]);}
	 			
	 			CLEAR_OE_X();
				CLEAR_OE_R();
						}
				}
	
				break;
case 3:
{
				if (trang_thai==1){
						
						for (j=0;j<8;j++){
						SET_OE_C();
	 					SET_OE_R();
						SET_OE_X();				 
						
							
						row_write_anh_data(j);
						
						if (i<8)     	   { column_x_write_data(ColumnCode[j],0xff,0xff,0xff);column_write_data(ColumnCode[j],0xff,0xff,0xff);}
   				else if ((i>= 8)&&(i<16))  { column_write_data(ColumnCode[j],0xff,0xff,0xff);column_x_write_data(ColumnCode[j],0xff,0xff,0xff);}
   				else if ((i>= 16)&&(i<24)) { column_write_data(ColumnCode[j],0xff,0xff,0xff);column_x_write_data(ColumnCode[j],0xff,0xff,0xff);}
  				else if ((i>= 24)&&(i<32)) { column_write_data(ColumnCode[j],0xff,0xff,0xff);column_x_write_data(ColumnCode[j],0xff,0xff,0xff);}
	 					CLEAR_OE_C();
	 					CLEAR_OE_R();
						CLEAR_OE_X();ndelay(15000);}
					}
					else {
						SET_OE_C();
	 					SET_OE_R();
						SET_OE_X();
						row_write_data(DataDisplay[slip+i]);
				
				if (i<8)     	   { column_x_write_data(ColumnCode[i],0xff,0xff,0xff);column_write_data(ColumnCode[i],0xff,0xff,0xff);}
   				else if ((i>= 8)&&(i<16))  { column_write_data(0xff,ColumnCode[i-8],0xff,0xff);column_x_write_data(0xff,ColumnCode[i-8],0xff,0xff);}
   				else if ((i>= 16)&&(i<24)) { column_write_data(0xff,0xff,ColumnCode[i-16],0xff);column_x_write_data(0xff,0xff,ColumnCode[i-16],0xff);}
  				else if ((i>= 24)&&(i<32)) { column_write_data(0xff,0xff,0xff,ColumnCode[i-24]);column_x_write_data(0xff,0xff,0xff,ColumnCode[i-24]);}
				CLEAR_OE_C();
	 			CLEAR_OE_R();
				CLEAR_OE_X();
					}
			     }
				break;
}
				
	
				
			 
			
	 		i++;
	 	        if (i==32) 
		 {	
			
			i = 0;
			
			cycle = ++cycle * 4;
	 	 }
		
   	}
  else 
     {
	 cycle = 0;
	 if (pause==0)
	 {
	  	if (shift==1)
	  	{
	   		slip++;
	  		 if (slip == letter*6+32)
	   			{
	    			slip = 0;
	   			}
	  	}
	  	else 
	  	{
	  	 	slip--;
	   		if (slip == 0)
	   		{
	     			slip = letter*6+32;
	   		}
	  	}
	 }
      }
	
   }
	return IRQ_HANDLED;
}

void asscii_to_matrix_led (unsigned char  data) 
{
	MatrixCode[0] = font[data * 6 +0]; 
	MatrixCode[1] = font[data * 6 +1];
	MatrixCode[2] = font[data * 6 +2];
	MatrixCode[3] = font[data * 6 +3];
	MatrixCode[4] = font[data * 6 +4];
	MatrixCode[5] = font[data * 6 +5];
}

static int matrix_led_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg[])
{
 int retval;
 switch (cmd)
 {
  case SWEEP_LED_DELAY : sweep_led_delay(arg[0]);
  break;
  case SHIFT_LEFT: 
    shift = 2;
	pause = 0;
  break;
  case SHIFT_RIGHT: 
    shift = 1;
	pause = 0;
  break;
  case UPDATE_SPEED: shift_speed = 101 - arg[0];
  break;
  case PAUSE: pause =1;
  break;
  case MAU_DO:
	mau = 1;
//	pause = 0;
  break;
  case MAU_XANH:
	mau = 2;
//	pause = 0;
  break;	
  case CA_HAI:
	mau = 3;
//	pause = 0;
  break;
case ANH:
	trang_thai = 1;
	write_buf[64] =0;
  break;
case KY_TU:
	trang_thai = 0;
	
  break;
  default: 
  printk ("Driver: Don't have this operation \n");
  retval = -EINVAL;
  break;
  }
  return retval;

}

static ssize_t matrix_led_write (struct file *filp, unsigned char __iomem buf[], size_t bufsize, loff_t *f_pos)
{
	                    //write_buf[];       
	int write_size = 0,letter_byte,h;
	if (copy_from_user (write_buf, buf, bufsize) != 0) 
	{
		return -EFAULT; 
		//printk("write size: \n",);
	} 
	else 
	{ 
		 write_size = bufsize;
		 printk("write size: %d\n",write_size);
		 DataDisplay[0] = 0x0;
		 DataDisplay[1] = 0x0;
		 DataDisplay[2] = 0x0;
		 DataDisplay[3] = 0x0;
		 DataDisplay[4] = 0x0;
		 DataDisplay[5] = 0x0;
		 DataDisplay[6] = 0x0;
		 DataDisplay[7] = 0x0;

		 DataDisplay[8] = 0x0;
		 DataDisplay[9] = 0x0;
		 DataDisplay[10] = 0x0;
		 DataDisplay[11] = 0x0;
		 DataDisplay[12] = 0x0;
		 DataDisplay[13] = 0x0;
		 DataDisplay[14] = 0x0;
		 DataDisplay[15] = 0x0;

		 DataDisplay[16] = 0x0;
		 DataDisplay[17] = 0x0;
		 DataDisplay[18] = 0x0;
		 DataDisplay[19] = 0x0;
		 DataDisplay[20] = 0x0;
		 DataDisplay[21] = 0x0;
		 DataDisplay[22] = 0x0;
		 DataDisplay[23] = 0x0;

		 DataDisplay[24] = 0x0;
		 DataDisplay[25] = 0x0;
		 DataDisplay[26] = 0x0;
		 DataDisplay[27] = 0x0;
		 DataDisplay[28] = 0x0;
		 DataDisplay[29] = 0x0;
		 DataDisplay[30] = 0x0;
		 DataDisplay[31] = 0x0;
					

		
	
		   	if (write_buf[64] == 95)
			{	
				for (letter=0;letter < write_size;letter++){
				if(write_buf[letter]== 49){anh[letter] = '\1';}	
				if(write_buf[letter]== 48){anh[letter] = '\0';}
				if(write_buf[letter]== 95){anh[letter] = '\0';}	
				}
				for (h=0;h<64;h++){
					mang64_to_mang8(h);
				
					}	
				
				 
					
				
				
			}
			else {	 
		 		//trang_thai = 0;	

				 for (letter=0;letter < write_size;letter++)
				 { 

			
					if (write_buf[letter] == 95)
		   			{ 
		    				 write_buf[letter] = 32;
		   			}
	       				asscii_to_matrix_led(write_buf[letter]-32);
		   			for(letter_byte=0;letter_byte < 6; letter_byte++)
		   			{
	        				 DataDisplay[letter*6+32+letter_byte] = ~MatrixCode[letter_byte];
	       				}
				}
	    		     }   

		 DataDisplay[letter*6+32+0] = 0x0;
		 DataDisplay[letter*6+32+1] = 0x0;
		 DataDisplay[letter*6+32+2] = 0x0;
		 DataDisplay[letter*6+32+3] = 0x0;
		 DataDisplay[letter*6+32+4] = 0x0;
		 DataDisplay[letter*6+32+5] = 0x0;
		 DataDisplay[letter*6+32+6] = 0x0;
		 DataDisplay[letter*6+32+7] = 0x0;
		
		 DataDisplay[letter*6+32+8] = 0x0;
		 DataDisplay[letter*6+32+9] = 0x0;
		 DataDisplay[letter*6+32+10] = 0x0;
		 DataDisplay[letter*6+32+11] = 0x0;
		 DataDisplay[letter*6+32+12] = 0x0;
		 DataDisplay[letter*6+32+13] = 0x0;
		 DataDisplay[letter*6+32+14] = 0x0;
		 DataDisplay[letter*6+32+15] = 0x0;

		 DataDisplay[letter*6+32+16] = 0x0;
		 DataDisplay[letter*6+32+17] = 0x0;
		 DataDisplay[letter*6+32+18] = 0x0;
		 DataDisplay[letter*6+32+19] = 0x0;
		 DataDisplay[letter*6+32+20] = 0x0;
		 DataDisplay[letter*6+32+21] = 0x0;
		 DataDisplay[letter*6+32+22] = 0x0;
		 DataDisplay[letter*6+32+23] = 0x0;

		 DataDisplay[letter*6+32+24] = 0x0;
		 DataDisplay[letter*6+32+25] = 0x0;
		 DataDisplay[letter*6+32+26] = 0x0;
		 DataDisplay[letter*6+32+27] = 0x0;
		 DataDisplay[letter*6+32+28] = 0x0;
		 DataDisplay[letter*6+32+29] = 0x0;
		 DataDisplay[letter*6+32+30] = 0x0;
		 DataDisplay[letter*6+32+31] = 0x0;
		

		
		 

		 slip = 0;
		 cycle = 0;
		 i = 0;
	}
	return write_size;
}

static int
matrix_led_open(struct inode *inode, struct file *file)
{
   int result = 0;
   unsigned int dev_minor = MINOR(inode->i_rdev);
   if (!atomic_dec_and_test(&matrix_led_open_cnt)) {
      atomic_inc(&matrix_led_open_cnt);
      printk(KERN_ERR DRVNAME ": Device with minor ID %d already in use\n", dev_minor);
      result = -EBUSY;
      goto out;
   }
out:
   return result;
}

static int
matrix_led_close(struct inode * inode, struct file * file)
{
   smp_mb__before_atomic_inc();
   atomic_inc(&matrix_led_open_cnt);

   return 0;
}

struct file_operations matrix_led_fops = {
   .write	= matrix_led_write,
   .ioctl    	= matrix_led_ioctl,
   .open    	= matrix_led_open,
   .release	= matrix_led_close,
};

static struct miscdevice matrix_led_dev = {
        .minor        = MISC_DYNAMIC_MINOR,
        .name         = "matrix_led",
        .fops         = &matrix_led_fops,
};

static int __init
matrix_led_mod_init(void)
{	
	int ret=0;
	gpio_request (DATA_C, NULL);
	gpio_request (CLOCK_C, NULL);
	gpio_request (LATCH_C, NULL);
	gpio_request (OE_C, NULL);
	gpio_request (DATA_R, NULL);
	gpio_request (CLOCK_R, NULL);
	gpio_request (LATCH_R, NULL);
	gpio_request (OE_R, NULL);
	gpio_request (DATA_X, NULL);
	gpio_request (CLOCK_X, NULL);
	gpio_request (LATCH_X, NULL);
	gpio_request (OE_X, NULL);
	
	at91_set_GPIO_periph (DATA_C, 1);
	at91_set_GPIO_periph (CLOCK_C, 1);
	at91_set_GPIO_periph (LATCH_C, 1);
	at91_set_GPIO_periph (OE_C, 1);
	at91_set_GPIO_periph (DATA_R, 1);
	at91_set_GPIO_periph (CLOCK_R, 1);
	at91_set_GPIO_periph (LATCH_R, 1);
	at91_set_GPIO_periph (OE_R, 1);
	at91_set_GPIO_periph (DATA_X, 1);
	at91_set_GPIO_periph (CLOCK_X, 1);
	at91_set_GPIO_periph (LATCH_X, 1);
	at91_set_GPIO_periph (OE_X, 1);


	
    gpio_direction_output(DATA_C, 0);
	gpio_direction_output(CLOCK_C, 0);
	gpio_direction_output(LATCH_C, 0);
	gpio_direction_output(OE_C, 0);
	gpio_direction_output(DATA_R, 0);
	gpio_direction_output(CLOCK_R, 0);
	gpio_direction_output(LATCH_R, 0);
	gpio_direction_output(OE_R, 0);
	gpio_direction_output(DATA_X, 0);
	gpio_direction_output(CLOCK_X, 0);
	gpio_direction_output(LATCH_X, 0);
	gpio_direction_output(OE_X, 0);

	at91tc0_clk = clk_get(	NULL, // Device pointer - not required.
							"tc0_clk"); // Clock name.
    clk_enable(at91tc0_clk);
	at91tc0_base = ioremap_nocache(AT91SAM9260_BASE_TC0, // Physical address
                                                    64); // Number of bytes to be mapped.
	if (at91tc0_base == NULL)
    {
        printk(KERN_INFO "TC0 memory mapping failed\n");
        ret = -EACCES;
        goto exit_5;
    }
	
	// Configure TC0 in waveform mode, TIMER_CLK1 and to generate interrupt on RC compare.
    // Load 50000 to RC so that with TIMER_CLK1 = MCK/2 = 50MHz, the interrupt will be
    // generated every 1/50MHz * 50000 = 20nS * 50000 = 1 milli second.
    // NOTE: Even though AT91_TC_RC is a 32-bit register, only 16-bits are programmble.
	
	iowrite32(50000, (at91tc0_base + AT91_TC_RC));
	iowrite32((AT91_TC_WAVE | AT91_TC_WAVESEL_UP_AUTO), (at91tc0_base + AT91_TC_CMR));
	iowrite32(AT91_TC_CPCS, (at91tc0_base + AT91_TC_IER));
	iowrite32((AT91_TC_SWTRG | AT91_TC_CLKEN), (at91tc0_base + AT91_TC_CCR));
	
	 // Install interrupt for TC0.
	ret = request_irq(AT91SAM9260_ID_TC0, // Interrupt number
	                         at91tc0_isr, // Pointer to the interrupt sub-routine
	  								   0, // Flags - fast, shared or contributing to entropy pool
                               "matrix_led_irq", // Device name to show as owner in /proc/interrupts
                                   NULL); // Private data for shared interrupts
	if (ret != 0)
	{
		printk(KERN_INFO "matrix_led_irq: Timer interrupt request failed\n");
		ret = -EBUSY;
		goto exit_6;
	}
	
	misc_register(&matrix_led_dev);
	printk(KERN_INFO "matrix_led: Loaded module\n");
	return ret;
	
	exit_6:
	iounmap(at91tc0_base);
	exit_5:
	clk_disable(at91tc0_clk);
	return ret;
}

static void __exit
matrix_led_mod_exit(void)
{
	iounmap(at91tc0_base);
	clk_disable(at91tc0_clk);
	// Free TC0 IRQ.
	free_irq(AT91SAM9260_ID_TC0, // Interrupt number
		                  NULL); // Private data for shared interrupts
	misc_deregister(&matrix_led_dev);
	printk(KERN_INFO "matrix_led: Unloaded module\n");
}

module_init (matrix_led_mod_init);
module_exit (matrix_led_mod_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("TranCamNhan");
MODULE_DESCRIPTION("Character device for for generic gpio api");
http://www.dientuvietnam.net/forums/ky-thuat-mach-logic-dien-tu-so-58/xin-giup-do-ve-cac-chan-cua-module-led-matrix-16x32-cua-tq-75199/index2.html
http://www.echipkool.com/2012/07/lap-trinh-led-ma-tran-8x8-2-mau.html