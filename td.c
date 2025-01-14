/*****************************************************
This program was produced by the
CodeWizardAVR V2.03.4 Standard
Automatic Program Generator
� Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
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
#include <delay.h> 
   
unsigned char autohand=2,check_autohand=0,luu_autohand=2,mode1=6,mode2=0,setting=0,dem,dem1;
unsigned char motcham =0x01; 
bit setup_old;
bit up_old; 
bit down_old;
bit ok_old;
bit autohand_old;
bit exit_old;   
bit setdown_old;
   
#include <khaibao.c>
#include <bitmap_flash.c>
#include <SpiMem.c> 
#include <ScreenScan.c>

#define AUTOHAND         PINA.1
#define OK               PINA.0
#define EXIT             PINC.2
#define UP               PINC.3
#define DOWN             PINC.4
#define SETUP            PINA.5
#define SETDOWN          PINA.3
///chan con lai mass

#define BUZZER   PORTD.0

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
//#include <ShiftRight.c> 
//#include <ShiftUp.c>
//#include <ShiftDown.c>
#include <CheckEffect.c>   

// Khai bao chuong trinh con
void giaima_nhayso(void);
void case_effect(void); 
unsigned char giaima(unsigned char so);   
void lunar_calculate(unsigned char day,unsigned char month,unsigned char year, unsigned char *ngay_amlich,unsigned char *thang_amlich,unsigned char *nam_amlich);                               
void ghivao_ramds (unsigned char giatri);
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
// ctc lua chon hieu ung hien thi
void case_effect(void)
{ 
  if    (hieuung==0 || hieuung==5)  {check_effect_left_right(msg0[2]+4);}    // Time 
  else if(hieuung==1)               {check_effect_left_right(msg1[2]+4);}    // Hom Nay 
  else if(hieuung==2)               {check_effect_left_right(msg2[2]+4);}    // Duong Lich
  else if(hieuung==3)               {check_effect_left_right(msg3[2]+4);}    // Am lich 
  else if(hieuung==4)               {check_effect_left_right(msg4[2]+4);}    // Nam
//  else if(hieuung==6)               {check_effect_left_right2(msg6[2]+4);}    // Chuc Mung Nam Moi 
//  else if(hieuung==7)               {check_effect_left_right2(msg7[2]+4);}    //  
//  else if(hieuung==8)               {check_effect_left_right2(msg8[2]+4);}    // Buoi sang vui ve
  else if(hieuung==9)               {check_effect_left_right2(msg9[2]+4);}    // Tram nam tinh vien man-Bac dau ngia phu the   
  else if(hieuung==10)              {check_effect_left_right2(msg10[2]+4);}    // Chuc mung nam moi-An khang thinh vuong   
  else if(hieuung==11)               {check_effect_left_right2(msg11[2]+4);}    // Tet toi tan tai
  else if(hieuung==12)               {check_effect_left_right2(msg12[2]+4);}    // Nam moi hanh phuc binh an den    
  else if(hieuung==13)              {check_effect_left_right2(msg13[2]+4);}    // Ngay xuan vinh hoa phu quy ve    
  
  else if(hieuung==15)               {check_effect_left_right2(msg15[2]+4);}    //    
  else if(hieuung==16)              {check_effect_left_right2(msg16[2]+4);}    //   
  else if(hieuung==17)               {check_effect_left_right2(msg17[2]+4);}    // 
  else if(hieuung==18)               {check_effect_left_right2(msg18[2]+4);}    //  
  else if(hieuung==19)              {check_effect_left_right2(msg19[2]+4);}    // 
  else if(hieuung==20)               {check_effect_left_right2(msg20[2]+4);}    //    

  else if(hieuung==21)              {check_effect_left_right2(msg21[2]+4);}    // 
  else if(hieuung==22)               {check_effect_left_right2(msg22[2]+4);}    // 
  else if(hieuung==23)               {check_effect_left_right2(msg23[2]+4);}    //   
  else if(hieuung==24)              {check_effect_left_right2(msg24[2]+4);}    // 
  else if(hieuung==25)               {check_effect_left_right2(msg25[2]+4);}    //   
  else if(hieuung==26)              {check_effect_left_right2(msg26[2]+4);}    //  
  else if(hieuung==27)               {check_effect_left_right2(msg27[2]+4);}    // 
  else if(hieuung==28)               {check_effect_left_right2(msg28[2]+4);}    //   
  else if(hieuung==29)              {check_effect_left_right2(msg29[2]+4);}    // 
  else if(hieuung==30)               {check_effect_left_right2(msg30[2]+4);}    //   
  else if(hieuung==31)              {check_effect_left_right2(msg31[2]+4);}    //   
  else if(hieuung==32)               {check_effect_left_right2(msg32[2]+4);}    //
  else if(hieuung==33)               {check_effect_left_right2(msg33[2]+4);}    //   
  else if(hieuung==34)              {check_effect_left_right2(msg34[2]+4);}    //   
  else if(hieuung==35)               {check_effect_left_right2(msg35[2]+4);}    //  
  else if(hieuung==36)              {check_effect_left_right2(msg36[2]+4);}    //   
  else if(hieuung==37)               {check_effect_left_right2(msg37[2]+4);}    // 
  else if(hieuung==38)               {check_effect_left_right2(msg38[2]+4);}    //    
  else if(hieuung==39)              {check_effect_left_right2(msg39[2]+4);}    //    
  else if(hieuung==40)              {check_effect_left_right2(msg40[2]+4);}    //    
 
  else                              {check_effect_left_right2(msg[2]+4);}     // Ngay moi vui ve !   
}  
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/      
/////////////////////////////////////////////////
// Timer 0 output compare interrupt service routine
interrupt [TIM0_COMP] void timer0_comp_isr(void)  // Ngat dieu chinh thoi gian
{   // Place your code here 
/*Dau cham nhap nhay*/
    giaima_nhayso();
    dem1++;
    dem1 = dem1 % 34; 
    if(dem1 < 17) 
    {
        motcham=0x01; // TAT DAU CHAM 
    } 
    else
    { 
        motcham=0x00;  // BAT DAU CHAM       
    } 
    /*************************/   
    if(dem==1)
    {
        case_effect(); /// Goi chuong trinh chay chu luc bat nguon   
    }
    else // NEU DEM KHAC 1 THI CAI DAT THOI GIAN
    {   
        if(check_autohand==0)  
        {                  
            if(!SETUP && SETUP!=setup_old) //check the set key, NEU NHAN SET TH� LAM
            {
                setting++;
                if(setting >= 8) setting=0;
            }   
            /*************************/        
            if(!SETDOWN && SETDOWN!=setdown_old) //check the set key, NEU NHAN SET TH� LAM
            {
                setting--;
                if(setting == 255) setting=7;
            }  
        }                               
       /*************************/ 
        if(setting != 0)
        {    
           if(!OK && OK!=ok_old) 
            { 
               // DUA THOI GIAN CAI DAT VAO RTC 
               setting = 0;       
               mode1=0;
               mode2=0;               
               rtc_set_time(hour,min,sec);
               rtc_set_date(week,day,month,year);                   
            } 
            else if(!EXIT && EXIT!=exit_old)
            {    
               setting = 0; 
               mode1=0;
               mode2=0;                
            }                           
        }         
        /*************************/             
        if(setting==0) 
        {
            // DOC THOI GIAN TU RTC
            rtc_get_time(&hour,&min,&sec);
            rtc_get_date(&week,&day,&month,&year);
            lunar_calculate(day,month,year,&ngay_amlich,&thang_amlich,&nam_amlich);
            allnam_amlich=20*100+nam_amlich;
             
            /*************************/  
            if (sec==0 && min==0 && hour >= 6 && hour <= 20) //  || ( sec==2 && min%2==0 &&((day==1 && month==1) || ( (ngay_amlich==30 && thang_amlich==12) || ( (ngay_amlich==1 || ngay_amlich==2 ||ngay_amlich==3 ||ngay_amlich==4) && thang_amlich==1) ))) ) 
                BUZZER = motcham;
            else   
                BUZZER = 0; 
           /*************************/     
            if(!AUTOHAND && AUTOHAND!=autohand_old) //check the up key
            {   
                check_autohand=1;  // Bat hien thi chon che do   
                                    // Khoa hien thi Auto
                mode1=6;           // Khoa hien thi Auto
                mode2=6;           // Khoa hien thi Hand
                autohand++;               
                if (autohand > 2) autohand =0;                     
            }   
            /******************************/
           if(!OK && OK!=ok_old) 
            { 
               check_autohand=0;           // Thoat hien thi chon che do
               luu_autohand = autohand; 
               mode1=0;
               mode2=0; 
            }                                                
           /*************************/
           if ((luu_autohand==1 || luu_autohand==2) && check_autohand==0) //Chon man hinh khi o che do Hand
           {    mode1=6;        // Khoa hien thi Auto
                if(!UP && UP!=up_old) //check the up key
                {       
                    mode2++; 
                    if (mode2 >4)mode2 = 0;                
                }
                else if(!DOWN && DOWN!=down_old) //check the down key
                {
                    mode2--;
                    if (mode2 == 255)mode2 = 4;                                                                                                                                                                                                                              
                }        
           }             
                                                                  
        }else if(setting==1)// CAI DAT NAM
        {
            if(!UP && UP!=up_old) //check the up key
            {       
                year++; 
                if (year >99)year = 13;                
            }
            else if(!DOWN && DOWN!=down_old) //check the down key
            {
                year--;
                if (year <13)year = 99;                                                                                                                                                                                                                              
            }        
        
        }else if(setting==2)// CAI DAT THANG
        {
            if(!UP && UP!=up_old) //check the up key
            {
                month++; 
                if (month >12)month = 1;             
            }
            else if(!DOWN && DOWN!=down_old) //check the down key
            {
                month--;
                if (month < 1)month = 12;                                                                                                                                                                                                                               
            }
        }else if(setting==3) // CAI DAT NGAY
        {
            if(!UP && UP!=up_old) //check the up key
            {
                day++;  
                if (day >31)day = 1;                  
            }    
            else if(!DOWN && DOWN!=down_old) //check the down key
            {
                day--;
                if (day < 1)day = 31;                                                                                                                                                                                                                                     
            }
        }else if(setting==4) // CAI DAT THU
        {
            if(!UP && UP!=up_old) //check the up key
            {
                week++;
                if (week >7)week = 1;                 
            }    
            else if(!DOWN && DOWN!=down_old) //check the down key
            {
                week--;
                if (week <1)week = 7;                                                                                                                                                                                                                        
            }    
        }  
                  
        else if(setting==5) // CAI DAT GIO
        {
            if(!UP && UP!=up_old) //check the up key
            {
                hour++;  
                if (hour >23)hour = 0;   
            }    
            else if(!DOWN && DOWN!=down_old) //check the down key
            {
                hour--;
                if (hour == 255) hour = 23;                                                                                                                                                                                                   
            }
             
        }else if(setting==6) // CAI DAT PHUT
        {
            if(!UP && UP!=up_old) //check the up key
            {
                min++; 
                if (min >59)min = 0;   
            }    
            else if(!DOWN && DOWN!=down_old) //check the down key
            {
                min--;
                if (min == 255)  min = 59;                                                                                                                                                                                                                          
            }                  
        }else if(setting == 7)// CAI DAT GIAY
        {
            if(!UP && UP!=up_old) //check the up key
            {
                sec++; 
                if (sec >59)sec = 0;
            }
            else if(!DOWN && DOWN!=down_old) //check the down key
            {
                sec--;
                if (sec == 255) sec = 59;                                                                                                                                                                                                       
            }
        }    
        
        setup_old=SETUP;
        up_old=UP; 
        down_old = DOWN;
        autohand_old = AUTOHAND; 
        ok_old = OK;
        setdown_old = SETDOWN; 
        exit_old = EXIT;                    
    }  
} 
/*----------------------------------------------------------------------------*/   
/*----------------------------------------------------------------------------*/
// Timer 1 output compare A interrupt service routine
// Dung timer 1 de scan led matrix
interrupt [TIM1_COMPA] void timer1_compa_isr(void) // Ngat scan man hinh
{
 // Place your code here
   // Doc gio, phut, giay tu ds1307      
    scan_screen();        
}
/*----------------------------------------------------*/

/********************************************************/
void main(void)
{
    #include <ConfigSet.c>   
    hieuung=rtc_read(0x0A);   
       
    dem=1;  // l�nh nay cho phep chay chu
    while (1)
    {      
    
    /// Dieu kien chay hieu ung
//    /*Chuong trinh chay mode Auto*/  
//      if (luu_autohand==0 && check_autohand==0)     
//        if(setting==0)   // <=> if (setting=0), khong cho thay doi hieu ung khi cai dat thoi gian
//            if(dem==0) 
//            { 
//                 if (hieuung <5) {mode1 = hieuung;}
//                 else             {mode1=0;}  
//                 /************/      
//                 if(sec==3 || sec==33)
//                  { 
//                        if ((day==1 && month==1) || ( (ngay_amlich==30 && thang_amlich==12) || ( (ngay_amlich==1 || ngay_amlich==2 ||ngay_amlich==3 ||ngay_amlich==4) && thang_amlich==1) ))
//                        { 
//                           if(min%5==0)
//                           {                    
//                                //Chuc mung nam moi-An khang thinh vuong 
//                                ghivao_ramds(10); 
//                           }
//                           
//                           else if(min%4==0)
//                           {                    
//                                //Ngay xuan vinh hoa phu quy ve
//                                ghivao_ramds(13); 
//                           }
//                           else if(min%3==0)  
//                           {
//                                //Nam moi hanh phuc binh an den
//                                ghivao_ramds(12);                       
//                           }                    
//                           else if(min%2==0)  
//                           {
//                                 // Tet toi tan tai-Xuan sang dac loc !
//                                ghivao_ramds(11);                       
//                           } 
//                                               
//                        }
//                        else if (min%2==0 && year==13 && month==12 && (day==27 || day==28))
//                        {  
//                               //tram nam tinh vien man-bac dau nghia phu the
//                                ghivao_ramds(9);                     
//                        }
//                        
//                        /************************/
//                        /*Cac ngay le trong nam*/ 
//                        /*AM LICH*/ 
//
//                        //TET NUYEN TIEU 15/1 AL
//                        else if (min%10==0 && ngay_amlich==15 && thang_amlich==1)
//                        {  
//                            ghivao_ramds(15);                  
//                        } 
//                        //GIO TO HUNG VUONG 10/3 AL                   
//                        else if (min%10==0 && ngay_amlich==10 && thang_amlich==3)
//                        {  
//                            ghivao_ramds(16);                  
//                        }    
//                        //LE PHAT DAN 15/4 AL                
//                        else if (min%10==0 && ngay_amlich==15 && thang_amlich==4)
//                        {  
//                            ghivao_ramds(17);                   
//                        }   
//                        //TET DOAN NGO 5/5 AL                 
//                        else if (min%10==0 && ngay_amlich==5 && thang_amlich==5)
//                        {  
//                            ghivao_ramds(18);                   
//                        } 
//                        //LE VU LAN 15/7 AL                   
//                        else if (min%10==0 && ngay_amlich==15 && thang_amlich==7)
//                        {  
//                            ghivao_ramds(19);                   
//                        }  
//                        //TET TRUNG THU 15/8 AL                  
//                        else if (min%10==0 && ngay_amlich==15 && thang_amlich==8)
//                        {  
//                            ghivao_ramds(20);                   
//                        }  
//                        
//                        /**********************/
//                        /*NGAY LE DUONG LICH*/  
//                        //NGAY HOC SINH SINH VIEN VIET NAM 9/1                
//                        else if (min%5==0 && day==9 && month==1)
//                        {  
//                            ghivao_ramds(21);                   
//                        }   
//                        //THANH LAP DANG CONG SAN VIET NAM 3/2                 
//                        else if (min%5==0 && day==3 && month==2)
//                        {  
//                            ghivao_ramds(22);                   
//                        } 
//                        //NGAY THAY THUOC VIET NAM 27/2                   
//                        else if (min%5==0 && day==27 && month==2)
//                        {  
//                            ghivao_ramds(23);                   
//                        }  
//                        //NGAY LE TINH YEU 14/2                  
//                        else if (day==14 && month==2)
//                        {      
//                             if(min%5==0)
//                             {   ghivao_ramds(24);}
//                             else if (min%4==0)
//                             {   ghivao_ramds(25);}                          
//                        }      
//                        // QUOC TE PHU NU 8/3
//                        else if (min%5==0 && day==8 && month==3)
//                        {  
//                            ghivao_ramds(26);                   
//                        }  
//                        //NGAY GIAI PHONG MIEN NAM 30/4                  
//                        else if (min%5==0 && day==30 && month==4)
//                        {  
//                            ghivao_ramds(27);                   
//                        }   
//                        //NGAY QUOC TE LAO DONG 1/5                 
//                        else if (min%5==0 && day==1 && month==5)
//                        {  
//                            ghivao_ramds(28);                   
//                        }      
//                        //NGAY CUA ME 13/5
//                        else if (min%5==0 && day==13 && month==5)
//                        {  
//                            ghivao_ramds(29);                   
//                        } 
//                        //NGAY SINH CHU TICH HO CHI MINH 19/5                   
//                        else if (min%5==0 && day==19 && month==5)
//                        {  
//                            ghivao_ramds(30);                   
//                        }  
//                        //NGAY QUOC TE THIEU NHI 1/6                  
//                        else if (min%5==0 && day==1 && month==6)
//                        {  
//                            ghivao_ramds(31);                   
//                        }   
//                        //NGAY CUA BO 17/6              
//                        else if (min%5==0 && day==17 && month==6)
//                        {  
//                            ghivao_ramds(32);                   
//                        }  
//                        //NGAY GIA DINH VIET NAM 28/6                  
//                        else if (min%5==0 && day==28 && month==6)
//                        {  
//                            ghivao_ramds(33);                   
//                        }
//                        //NGAY THUONG BINH LIET SI 27/7                    
//                        else if (min%5==0 && day==27 && month==7)
//                        {  
//                            ghivao_ramds(34);                   
//                        } 
//                        //LE QUOC KHANH 2/9
//                        else if (min%5==0 && day==2 && month==9)
//                        {  
//                            ghivao_ramds(35);                   
//                        }     
//                        //NGAY QUOC TE NGUOI CAO TUOI 1/10               
//                        else if (min%5==0 && day==1 && month==10)
//                        {  
//                            ghivao_ramds(36);                   
//                        }      
//                        //NGAY NHA GIAO VIET NAM 20/11              
//                        else if (min%5==0 && day==20 && month==11)
//                        {  
//                            ghivao_ramds(37);                   
//                        }     
//                        //NGAY THE GIOI PHONG CHON AIDS 1/12         
//                        else if (min%5==0 && day==1 && month==12)
//                        {  
//                            ghivao_ramds(38);                   
//                        } 
//                        //NGAY QUAN DOI NHAN DAN VIET NAM 22/12                   
//                        else if (min%5==0 && day==22 && month==12)
//                        {  
//                            ghivao_ramds(39);                   
//                        } 
//                        //GIANG SINH 24/12 
//                        else if (min%5==0 && day==24 && month==12)
//                        {  
//                            ghivao_ramds(40);                   
//                        }                                     
//                       /*****************************/  
//                        else
//                        {
//                            rtc_write(0x0A,0);  
//                            if(hieuung==0)  
//                            {
//                                //hien thi Thu 
//                                ghivao_ramds(1); 
//                            }                         
//                        }    
//                  }
//                  else if(sec==7 || sec==37)
//                  {   
//                        if(hieuung==1)  
//                        {
//                                //hien thi duong lich
//                                ghivao_ramds(2);   
//                        }      
//                  } 
//
//                  else if(sec==12 || sec==42)
//                  { 
//                        if(hieuung==2) 
//                        { 
//                              //hien thi ngay am lich
//                                ghivao_ramds(3);         
//                        }   
//                  }
//                        
//                  else if(sec==16 || sec==46)
//                  { 
//                        if(hieuung==3) 
//                        { 
//                                 //hien thi nam am lich
//                                ghivao_ramds(4);  
//                        }           
//                  }                                    
//                  else if (sec==19 || sec==49)         
//                  { 
//                      if(hieuung==4) 
//                      { 
//                               //hien thi time
//                                ghivao_ramds(0);   
//                      }  
//                      else if (hieuung>=6) 
//                      {
//                          ghivao_ramds(1);
//                      } 
//                  }                               
//            }                      
      /////////////////////////// 
      /*Chuong trinh chay mode Mix*/ 
      if ((luu_autohand==2 || luu_autohand==0) && check_autohand==0)     
        if(setting==0)   // <=> if (setting=0), khong cho thay doi hieu ung khi cai dat thoi gian
            if(dem==0) 
            {  
                  if(sec==6 || sec==36)
                  { 
                        if ((day==1 && month==1) || ( (ngay_amlich==30 && thang_amlich==12) || ( (ngay_amlich==1 || ngay_amlich==2 ||ngay_amlich==3 ||ngay_amlich==4) && thang_amlich==1) ))
                        { 
                           if(min%5==0)
                           {                    
                                //Chuc mung nam moi-An khang thinh vuong 
                                ghivao_ramds(10); 
                           }
                           
                           else if(min%4==0)
                           {                    
                                //Ngay xuan vinh hoa phu quy ve
                                ghivao_ramds(13); 
                           }
                           else if(min%3==0)  
                           {
                                //Nam moi hanh phuc binh an den
                                ghivao_ramds(12);                       
                           }                    
                           else if(min%2==0)  
                           {
                                 // Tet toi tan tai-Xuan sang dac loc !
                                ghivao_ramds(11);                       
                           } 
                                               
                        }
                        else if (min%2==0 && year==13 && month==12 && (day==27 || day==28))
                        {  
                               //tram nam tinh vien man-bac dau nghia phu the
                                ghivao_ramds(9);                     
                        }
                        
                        /************************/
                        /*Cac ngay le trong nam*/ 
                        /*AM LICH*/ 

                        //TET NUYEN TIEU 15/1 AL
                        else if (min%10==0 && ngay_amlich==15 && thang_amlich==1)
                        {  
                            ghivao_ramds(15);                  
                        } 
                        //GIO TO HUNG VUONG 10/3 AL                   
                        else if (min%10==0 && ngay_amlich==10 && thang_amlich==3)
                        {  
                            ghivao_ramds(16);                  
                        }    
                        //LE PHAT DAN 15/4 AL                
                        else if (min%10==0 && ngay_amlich==15 && thang_amlich==4)
                        {  
                            ghivao_ramds(17);                   
                        }   
                        //TET DOAN NGO 5/5 AL                 
                        else if (min%10==0 && ngay_amlich==5 && thang_amlich==5)
                        {  
                            ghivao_ramds(18);                   
                        } 
                        //LE VU LAN 15/7 AL                   
                        else if (min%10==0 && ngay_amlich==15 && thang_amlich==7)
                        {  
                            ghivao_ramds(19);                   
                        }  
                        //TET TRUNG THU 15/8 AL                  
                        else if (min%10==0 && ngay_amlich==15 && thang_amlich==8)
                        {  
                            ghivao_ramds(20);                   
                        }  
                        
                        /**********************/
                        /*NGAY LE DUONG LICH*/  
                        //NGAY HOC SINH SINH VIEN VIET NAM 9/1                
                        else if (min%5==0 && day==9 && month==1)
                        {  
                            ghivao_ramds(21);                   
                        }   
                        //THANH LAP DANG CONG SAN VIET NAM 3/2                 
                        else if (min%5==0 && day==3 && month==2)
                        {  
                            ghivao_ramds(22);                   
                        } 
                        //NGAY THAY THUOC VIET NAM 27/2                   
                        else if (min%5==0 && day==27 && month==2)
                        {  
                            ghivao_ramds(23);                   
                        }  
                        //NGAY LE TINH YEU 14/2                  
                        else if (day==14 && month==2)
                        {      
                             if(min%5==0)
                             {   ghivao_ramds(24);}
                             else if (min%4==0)
                             {   ghivao_ramds(25);}                          
                        }      
                        // QUOC TE PHU NU 8/3
                        else if (min%5==0 && day==8 && month==3)
                        {  
                            ghivao_ramds(26);                   
                        }  
                        //NGAY GIAI PHONG MIEN NAM 30/4                  
                        else if (min%5==0 && day==30 && month==4)
                        {  
                            ghivao_ramds(27);                   
                        }   
                        //NGAY QUOC TE LAO DONG 1/5                 
                        else if (min%5==0 && day==1 && month==5)
                        {  
                            ghivao_ramds(28);                   
                        }      
                        //NGAY CUA ME 13/5
                        else if (min%5==0 && day==13 && month==5)
                        {  
                            ghivao_ramds(29);                   
                        } 
                        //NGAY SINH CHU TICH HO CHI MINH 19/5                   
                        else if (min%5==0 && day==19 && month==5)
                        {  
                            ghivao_ramds(30);                   
                        }  
                        //NGAY QUOC TE THIEU NHI 1/6                  
                        else if (min%5==0 && day==1 && month==6)
                        {  
                            ghivao_ramds(31);                   
                        }   
                        //NGAY CUA BO 17/6              
                        else if (min%5==0 && day==17 && month==6)
                        {  
                            ghivao_ramds(32);                   
                        }  
                        //NGAY GIA DINH VIET NAM 28/6                  
                        else if (min%5==0 && day==28 && month==6)
                        {  
                            ghivao_ramds(33);                   
                        }
                        //NGAY THUONG BINH LIET SI 27/7                    
                        else if (min%5==0 && day==27 && month==7)
                        {  
                            ghivao_ramds(34);                   
                        } 
                        //LE QUOC KHANH 2/9
                        else if (min%5==0 && day==2 && month==9)
                        {  
                            ghivao_ramds(35);                   
                        }     
                        //NGAY QUOC TE NGUOI CAO TUOI 1/10               
                        else if (min%5==0 && day==1 && month==10)
                        {  
                            ghivao_ramds(36);                   
                        }      
                        //NGAY NHA GIAO VIET NAM 20/11              
                        else if (min%5==0 && day==20 && month==11)
                        {  
                            ghivao_ramds(37);                   
                        }     
                        //NGAY THE GIOI PHONG CHON AIDS 1/12         
                        else if (min%5==0 && day==1 && month==12)
                        {  
                            ghivao_ramds(38);                   
                        } 
                        //NGAY QUAN DOI NHAN DAN VIET NAM 22/12                   
                        else if (min%5==0 && day==22 && month==12)
                        {  
                            ghivao_ramds(39);                   
                        } 
                        //GIANG SINH 24/12 
                        else if (min%5==0 && day==24 && month==12)
                        {  
                            ghivao_ramds(40);                   
                        }                                     
                       /*****************************/  
                        else
                        {
                            mode2=1;      //hien thi Thu                          
                        }    
                  }
                  else if(sec==9 || sec==39)
                  {   
                        mode2=2;      //hien thi duong lich        
                  } 

                  else if(sec==12 || sec==42)
                  { 
                        mode2=3;      //hien thi ngay am lich  
                  }
                        
                  else if(sec==15 || sec==45)
                  { 
                        mode2=4;      //hien thi nam am lich                       
                  }                                    
                  else if (sec==18 || sec==48)         
                  { 
                        mode2=0;      //hien thi time                              
                  } 
                  else if(hour==23 && min==59 && sec==59)
                  {
                      if (hieuung>=9 || hieuung<=40) 
                      {
                         ghivao_ramds(6);      
                      }
                  }                               
            }
    /*********************************/      
      
      if(dem==1)  
      {   
        check_effect=0;
        effect_left(); 
        delay_ms(25); 
      }
      else
      { 
        if(setting==0)
        {       
            if(check_autohand==1) // Kiem tra hien thi chon che do               
                if (autohand==0)                        // hien thi Auto 
                     for(k=0;k<8;k++)
                     {   
                            //Hang 1
                            buf_screen_1[k   ]=text_autohand[k];
                            buf_screen_1[k+16]=text_autohand[k+8]; 
                            buf_screen_1[k+32]=text_autohand[k+16];
                            buf_screen_1[k+48]=text_autohand[k+24];  
                        
                        //Hang 2                         
                        if(!motcham)  
                        {                     
                            buf_screen_1[k+8]=text_muiten[k];  
                        }
                        else
                        {
                            buf_screen_1[k+8]=0x00;                          
                        }    
                            buf_screen_1[k+24]=font_sohang2[giaima(autohand)+k]; 
                            buf_screen_1[k+40]=0x00; 
                            buf_screen_1[k+56]=0x00;                                                 
                                                         
                     }               
                else if (autohand==1)                      //hien thi Hand
                     for(k=0;k<8;k++)
                     { 
                        buf_screen_1[k]=text_autohand[k+32];     
                        buf_screen_1[k+16]=text_autohand[k+40];          
                        buf_screen_1[k+32]=text_autohand[k+48]; 
                        buf_screen_1[k+48]=text_autohand[k+56]; 
                        //Hang 2                       
                        if(!motcham)  
                        {                     
                            buf_screen_1[k+8]=text_muiten[k];  
                        }
                        else
                        {
                            buf_screen_1[k+8]=0x00;                          
                        }    
                            buf_screen_1[k+24]=font_sohang2[giaima(autohand)+k];
                            buf_screen_1[k+40]=0x00; 
                            buf_screen_1[k+56]=0x00;                         
                     }  
                     
                else                                     //hien thi Mix
                     for(k=0;k<8;k++)
                     { 
                        buf_screen_1[k]=text_autohand[k+64];     
                        buf_screen_1[k+16]=text_autohand[k+72];          
                        buf_screen_1[k+32]=text_autohand[k+80]; 
                        buf_screen_1[k+48]=0x00; 
                        
                        //Hang 2 
                        if(!motcham)  
                        {                     
                            buf_screen_1[k+8]=text_muiten[k];  
                        }
                        else
                        {
                            buf_screen_1[k+8]=0x00;                          
                        }    
                            buf_screen_1[k+24]=font_sohang2[giaima(autohand)+k];
                            buf_screen_1[k+40]=0x00; 
                            buf_screen_1[k+56]=0x00;                         
                     }                                                        
            
           else
           { 
             if(mode1==0 || mode2==0) // HIEN THI GIO:PHUT, GIAY               
                for(k=0;k<8;k++)
                {   
                    buf_screen_1[k]=font_sohang1[ch_hour+k];
                    buf_screen_1[k+8]=0x00;      
                        
                    buf_screen_1[k+16]=font_sohang1_tr[dv_hour+k];
                    buf_screen_1[k+24]=font_sohang2[ch_sec+k];
                        
                    buf_screen_1[k+32]=font_sohang1_ch[ch_min+k];
                    buf_screen_1[k+40]=font_sohang2[dv_sec+k]; 
                        
                    buf_screen_1[k+48]=font_sohang1[dv_min+k];
                    buf_screen_1[k+56]=0x00;  

                    //2 dau 2 cham 
                    if(!motcham)
                    {
                      if((k+16)==17)  buf_screen_1[17]+=1;
                      if((k+16)==18)  buf_screen_1[18]+=1;
                      if((k+16)==21)  buf_screen_1[21]+=1;
                      if((k+16)==22)  buf_screen_1[22]+=1;
                    }
                }
             
             else if(mode1==1 || mode2==1)  // HIEN THI THU
                for(k=0;k<8;k++)
                {   
                     if (week == 1)
                     {
                        buf_screen_1[k]=font_chunhat[k];
                        buf_screen_1[k+8]=font_chunhat[k+24];
                            
                        buf_screen_1[k+16]=font_chunhat[k+8];
                        buf_screen_1[k+24]=font_chunhat[k+32];
                            
                        buf_screen_1[k+32]=font_chunhat[k+16];
                        buf_screen_1[k+40]=font_chunhat[k+40];
                            
                        buf_screen_1[k+48]=0x00;
                        buf_screen_1[k+56]=font_chunhat[k+48];                                                                        
                     }
                     else   
                     {               
                        buf_screen_1[k]=text_week[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG  
                        buf_screen_1[k+8]=0x00;  
                         
                        buf_screen_1[k+16]=text_week[k+8]; 
                        buf_screen_1[k+24]=font_weekled2[giaima(week)+k];
                                                            
                        buf_screen_1[k+32]=text_week[k+16];
                        buf_screen_1[k+40]=font_weekled3[giaima(week)+k];      
                        
                        buf_screen_1[k+48]=text_week[k+24];
                        buf_screen_1[k+56]=font_weekled4[giaima(week)+k];  
                     }          
                }
                  
             else if(mode1==2 || mode2==2)  // HIEN THI NGAY-THANG-NAM DUONG LICH
                 for(k=0;k<8;k++)
                 {
                    buf_screen_1[k]=font_sohang1[giaima(day/10)+k];
                    buf_screen_1[k+8]=font_sohang2[giaima(2)+k]; 
                        
//                    buf_screen_1[k+16]=font_sohang1[giaima(day%10)+k];    
                    buf_screen_1[k+16]=font_sohang1_tr[giaima(day%10)+k]; 
                    buf_screen_1[k+24]=font_sohang2[giaima(0)+k];//cong them 80 sau k cu?i c�ng neu nhu dat chung voi mang hang1
                        
//                    buf_screen_1[k+32]=font_sohang1[giaima(month/10)+k];    
                    buf_screen_1[k+32]=font_sohang1_ch[giaima(month/10)+k]; 
                    buf_screen_1[k+40]=font_sohang2[giaima(year/10)+k];  
                                     
                    buf_screen_1[k+48]=font_sohang1[giaima(month%10)+k];
                    buf_screen_1[k+56]=font_sohang2[giaima(year%10)+k];
                                                               
                    //dau gach        
                    if((k+16)==19)buf_screen_1[19]+=0x03;
                    if((k+32)==35)buf_screen_1[35]+=0x80;
                 }  
                     
             else if(mode1==3 || mode2==3)  // HIEN THI NGAY-THANG AM LICH
                 for(k=0;k<8;k++)
                 {
                    buf_screen_1[k]=font_sohang1[giaima(ngay_amlich/10)+k];
                    buf_screen_1[k+8]=0x00; 
                        
                    buf_screen_1[k+16]=font_sohang1_tr[giaima(ngay_amlich%10)+k];               
                    buf_screen_1[k+24]=text_dauxet[k];//cong them 80 sau k cu?i c�ng neu nhu dat chung voi mang hang1
                        
                    buf_screen_1[k+32]= text_dauxet[k+8];              
                    buf_screen_1[k+40]=font_sohang2_ch[giaima(thang_amlich/10)+k];  
                                     
                    buf_screen_1[k+48]= text_dauxet[k+16]; 
                    buf_screen_1[k+56]=font_sohang2[giaima(thang_amlich%10)+k];                                                                 
                 }   
                     
             else if(mode1==4 || mode2==4)  // HIEN THI NAM AM LICH CAN-CHI
                 for(k=0;k<8;k++)
                 {
                    buf_screen_1[k]=text_can1[giaima(nam_amlich%10)+k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                    buf_screen_1[k+8]=text_chi1[giaima((allnam_amlich-4)%12)+k];
                        
                    buf_screen_1[k+16]=text_can2[giaima(nam_amlich%10)+k];
                    buf_screen_1[k+24]=text_chi2[giaima((allnam_amlich-4)%12)+k];
                        
                    buf_screen_1[k+32]=text_can3[giaima(nam_amlich%10)+k];
                    buf_screen_1[k+40]=text_chi3[giaima((allnam_amlich-4)%12)+k];
                       
                    buf_screen_1[k+48]=text_can4[giaima(nam_amlich%10)+k];
                    buf_screen_1[k+56]= text_chi4[giaima((allnam_amlich-4)%12)+k];                                                       
                 }
           }                                                        
        }                                
  /*****************************************/                  
 /**************************************/        
        else if(setting==1) //HIEN THI CAI DAT NAM
            for(k=0;k<8;k++)
            {  
                    buf_screen_1[k]=text_year[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                if(!motcham)   
                    buf_screen_1[k+8]=text_muiten[k];   
                else 
                    buf_screen_1[k+8]=0x00;   
                            
                    buf_screen_1[k+16]=text_year[k+8]; 
                    buf_screen_1[k+24]=font_sohang2[giaima(year/10)+k];
                            
                    buf_screen_1[k+32]=text_year[k+16];
                    buf_screen_1[k+40]=font_sohang2[giaima(year%10)+k];
                            
                    buf_screen_1[k+48]=text_year[k+24];
                    buf_screen_1[k+56]=0x00;                                
            }
                                    
        else if(setting==2) //HIEN THI CAI DAT THANG
           for(k=0;k<8;k++)
           {    
                    buf_screen_1[k]=text_month[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                if(!motcham)   
                    buf_screen_1[k+8]=text_muiten[k];   
                else 
                    buf_screen_1[k+8]=0x00;       
                            
                    buf_screen_1[k+16]=text_month[k+8]; 
                    buf_screen_1[k+24]=font_sohang2[giaima(month/10)+k];
                            
                    buf_screen_1[k+32]=text_month[k+16];
                    buf_screen_1[k+40]=font_sohang2[giaima(month%10)+k]; 
                            
                    buf_screen_1[k+48]=text_month[k+24];
                    buf_screen_1[k+56]=0x00;                 
           }           
        else if(setting==3)  // HIEN THI CAI DAT NGAY
           for(k=0;k<8;k++)
           {
                    buf_screen_1[k]=text_day[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                if(!motcham)   
                    buf_screen_1[k+8]=text_muiten[k];   
                else 
                    buf_screen_1[k+8]=0x00;        
                            
                    buf_screen_1[k+16]=text_day[k+8]; 
                    buf_screen_1[k+24]=font_sohang2[giaima(day/10)+k];
                            
                    buf_screen_1[k+32]=text_day[k+16];
                    buf_screen_1[k+40]=font_sohang2[giaima(day%10)+k]; 
                            
                    buf_screen_1[k+48]=text_day[k+24];
                    buf_screen_1[k+56]=0x00;    
           }       
              
        else if(setting==4)  // HIEN THI CAI DAT THU
           for(k=0;k<8;k++)
           {                  
                buf_screen_1[k]=text_week[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
            if(!motcham)   
                buf_screen_1[k+8]=text_muiten[k];   
            else 
                buf_screen_1[k+8]=0x00;
                buf_screen_1[k+16]=text_week[k+8]; 
                buf_screen_1[k+24]=font_weekled2[giaima(week)+k];
                                                
                buf_screen_1[k+32]=text_week[k+16];
                buf_screen_1[k+40]=font_weekled3[giaima(week)+k];
                buf_screen_1[k+48]=text_week[k+24];
                buf_screen_1[k+56]=font_weekled4[giaima(week)+k];                           
           }                                                
         
        else if(setting==5) //HIEN THI CAI DAT GIO
            for(k=0;k<8;k++)
            {
                    buf_screen_1[k]=text_hour[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                if(!motcham)   
                    buf_screen_1[k+8]=text_muiten[k];   
                else 
                    buf_screen_1[k+8]=0x00;      
                            
                    buf_screen_1[k+16]=text_hour[k+8]; 
                    buf_screen_1[k+24]=font_sohang2[giaima(hour/10)+k];
                            
                    buf_screen_1[k+32]=text_hour[k+16];
                    buf_screen_1[k+40]=font_sohang2[giaima(hour%10)+k]; 
                            
                    buf_screen_1[k+48]=text_hour[k+24];
                    buf_screen_1[k+56]=0x00;                  
            } 
        else if(setting==6) //HIEN THI CAI DAT PHUT
           for(k=0;k<8;k++)
           { 
                    buf_screen_1[k]=text_min[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                if(!motcham)   
                    buf_screen_1[k+8]=text_muiten[k];   
                else 
                    buf_screen_1[k+8]=0x00;            
                            
                    buf_screen_1[k+16]=text_min[k+8]; 
                    buf_screen_1[k+24]=font_sohang2[giaima(min/10)+k];
                            
                    buf_screen_1[k+32]=text_min[k+16];
                    buf_screen_1[k+40]=font_sohang2[giaima(min%10)+k];
                            
                    buf_screen_1[k+48]=0x00;
                    buf_screen_1[k+56]=0x00;   
                               
           }              
        else if(setting==7)  // HIEN THI CAI DAT GIAY
           for(k=0;k<8;k++) // 8 CON LED MA TRAN 8x8
           {
                    buf_screen_1[k]=text_sec[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                if(!motcham)   
                    buf_screen_1[k+8]=text_muiten[k];   
                else 
                    buf_screen_1[k+8]=0x00;       
                            
                    buf_screen_1[k+16]=text_sec[k+8]; 
                    buf_screen_1[k+24]=font_sohang2[giaima(sec/10)+k];
                            
                    buf_screen_1[k+32]=text_sec[k+16];
                    buf_screen_1[k+40]=font_sohang2[giaima(sec%10)+k];
                            
                    buf_screen_1[k+48]=0x00;
                    buf_screen_1[k+56]=0x00;                        
           } 
      }                                     
    };         
}

/*****************************************************/
/*****************************************************/
/*----------------------------------------------------------------------------*/
 // Declare your global variables here      
 /********************************************/   
 /**********************************************/  
 void ghivao_ramds (unsigned char giatri)   
 {
    rtc_write(0x0A,giatri);  
    delay_ms(100);
    WDTCR=0x08;   
 };
 /**************************************/
void giaima_nhayso(void)  /////Da tich hop luon phan giai ma tu 0,1,2,3,4,5,6,7,8,9 thanh 0,8,16,24,32,40,48,56,64,72.
{   

    if(ch_sec<((sec/10)*8))ch_sec++; 
    if((sec/10)==0)ch_sec=0;
    if(dv_sec<((sec%10)*8)) dv_sec++; 
    if((sec%10)==0)dv_sec=0;
   
    if(ch_min<((min/10)*8))ch_min++; 
    if((min/10)==0)ch_min=0;
    if(dv_min<((min%10)*8))dv_min++; 
    if((min%10)==0)dv_min=0;
 
    if(ch_hour<((hour/10)*8))ch_hour++; 
    if((hour/10)==0)ch_hour=0; 
    if(dv_hour<((hour%10)*8))dv_hour++; 
    if((hour%10)==0)dv_hour=0;                           
}

/************************************/
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
        case 10 : return 80;
        case 11 : return 88;        
    }
}

/***********************************************/
///Ham tinh ngay thang nam am lich
/*******************************************************************/
void lunar_calculate(unsigned char day,unsigned char month,unsigned char year,unsigned char *ngay_amlich,unsigned char *thang_amlich,unsigned char *nam_amlich)
{
   unsigned char tam_1;
   unsigned char RTCLunarRTC_day,RTCLunarRTC_month,RTCLunarRTC_year;
   unsigned char da,db,dayht,monthht,yearht;
   unsigned char lmon;
    
   dayht=  day;
   monthht=  month;
   yearht= year;    

    if((yearht-10)>30)//cho phep den nam 2030 
    {
        goto thoat;
    }
     
    da = ngayALdauthangDL[yearht-13][monthht-1];
    db = ngayDLdauthangAL[yearht-13][monthht-1];
    
    if((db-dayht)<=0)
    {
        RTCLunarRTC_day = (dayht-db+1);
        RTCLunarRTC_month = thangALdauthangAL[yearht-13][monthht-1]; 
    }
    else 
    {
        if((db-dayht)>31)
        {
            RTCLunarRTC_day = (dayht-db+1);//
            RTCLunarRTC_month = thangALdauthangDL[yearht-13][monthht];
        }
        else
        {
            RTCLunarRTC_day = (dayht+da-1);//
            RTCLunarRTC_month = thangALdauthangDL[yearht-13][monthht-1];       
        }
    }
     
    lmon = RTCLunarRTC_month;
    tam_1=monthht-lmon;
     
    if((tam_1)>100&&tam_1<255)
        RTCLunarRTC_year = (yearht-1);
    else
    {
        RTCLunarRTC_year = yearht;
    } 
    
    *ngay_amlich =  (unsigned char) RTCLunarRTC_day;
    *thang_amlich = (unsigned char) RTCLunarRTC_month;
    *nam_amlich = (unsigned char) RTCLunarRTC_year;
     
thoat:
};
/***********************************************************************/
