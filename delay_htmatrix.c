/*****************************************************/
//Delay hien thi
/*****************************************************/
unsigned int delay_htmatrix(unsigned int x)
{
    unsigned int i,j;
    for (i=0;i<x;i++) 
        for (j=0;j<120;j++) 
        {
            if(setting==1) //HIEN THI CAI DAT NAM
                for(k=0;k<8;k++)
                {  
                        buf_screen_1[k]=text_year[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                        buf_screen_1[k+8]=0x00;   
                        
                        buf_screen_1[k+16]=text_year[k+8]; 
                        buf_screen_1[k+24]=font_sohang2[giaima(year/10)+k];
                        
                        buf_screen_1[k+32]=text_year[k+16];
                        buf_screen_1[k+40]=font_sohang2[giaima(year%10)+k];
                        
                        buf_screen_1[k+48]=text_year[k+24];
                        buf_screen_1[k+56]=0x00;  
                        
                        //dau mui ten
                        muitennhay();                           
                }
                                
            if(setting==2) //HIEN THI CAI DAT THANG
               for(k=0;k<8;k++)
               {    
                        buf_screen_1[k]=text_month[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                        buf_screen_1[k+8]=0x00;        
                        
                        buf_screen_1[k+16]=text_month[k+8]; 
                        buf_screen_1[k+24]=font_sohang2[giaima(month/10)+k];
                        
                        buf_screen_1[k+32]=text_month[k+16];
                        buf_screen_1[k+40]=font_sohang2[giaima(month%10)+k]; 
                        
                        buf_screen_1[k+48]=text_month[k+24];
                        buf_screen_1[k+56]=0x00; 
                        muitennhay();                 
               }           
            if(setting==3)  // HIEN THI CAI DAT NGAY
               for(k=0;k<8;k++)
               {
                        buf_screen_1[k]=text_day[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                        buf_screen_1[k+8]=0x00;         
                        
                        buf_screen_1[k+16]=text_day[k+8]; 
                        buf_screen_1[k+24]=font_sohang2[giaima(day/10)+k];
                        
                        buf_screen_1[k+32]=text_day[k+16];
                        buf_screen_1[k+40]=font_sohang2[giaima(day%10)+k]; 
                        
                        buf_screen_1[k+48]=text_day[k+24];
                        buf_screen_1[k+56]=0x00; 
                        
                        muitennhay();    
               }       
          
            if(setting==4)  // HIEN THI CAI DAT THU
               for(k=0;k<8;k++)
               {
                        buf_screen_1[k]=text_week[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                        buf_screen_1[k+8]=0x00;
                        
                        buf_screen_1[k+16]=text_week[k+8]; 
                        buf_screen_1[k+24]=font_weekled8[giaima(week)+k];
                        
                        buf_screen_1[k+32]=text_week[k+16];
                        buf_screen_1[k+40]=font_weekled32[giaima(week)+k];
                        
                        buf_screen_1[k+48]=text_week[k+24];
                        buf_screen_1[k+56]=font_weekled40[giaima(week)+k];  
                        
                        muitennhay();                              
               }                                                
     
            if(setting==5) //HIEN THI CAI DAT GIO
                for(k=0;k<8;k++)
                {
                        buf_screen_1[k]=text_hour[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                        buf_screen_1[k+8]=0x00;           
                        
                        buf_screen_1[k+16]=text_hour[k+8]; 
                        buf_screen_1[k+24]=font_sohang2[giaima(hour/10)+k];
                        
                        buf_screen_1[k+32]=text_hour[k+16];
                        buf_screen_1[k+40]=font_sohang2[giaima(hour%10)+k]; 
                        
                        buf_screen_1[k+48]=text_hour[k+24];
                        buf_screen_1[k+56]=0x00;  
                        
                        muitennhay();               
                } 
            if(setting==6) //HIEN THI CAI DAT PHUT
               for(k=0;k<8;k++)
               { 
                        buf_screen_1[k]=text_min[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                        buf_screen_1[k+8]=0x00;             
                        
                        buf_screen_1[k+16]=text_min[k+8]; 
                        buf_screen_1[k+24]=font_sohang2[giaima(min/10)+k];
                        
                        buf_screen_1[k+32]=text_min[k+16];
                        buf_screen_1[k+40]=font_sohang2[giaima(min%10)+k];
                        
                        buf_screen_1[k+48]=0x00;
                        buf_screen_1[k+56]=0x00;   
                        
                        muitennhay();      
               }              
            if(setting==7)  // HIEN THI CAI DAT GIAY
               for(k=0;k<8;k++) // 8 CON LED MA TRAN 8x8
               {
                        buf_screen_1[k]=text_sec[k];  // buf_screen_1[k], PHAN TU THU K CUA MANG
                        buf_screen_1[k+8]=0x00;          
                        
                        buf_screen_1[k+16]=text_sec[k+8]; 
                        buf_screen_1[k+24]=font_sohang2[giaima(sec/10)+k];
                        
                        buf_screen_1[k+32]=text_sec[k+16];
                        buf_screen_1[k+40]=font_sohang2[giaima(sec%10)+k];
                        
                        buf_screen_1[k+48]=0x00;
                        buf_screen_1[k+56]=0x00; 
                        
                        muitennhay();               
               }  
                        


        };      
};