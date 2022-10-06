//************************************************************************
 /*----------------------------------------------------------------------------*/
 // ctc cap nhat du lieu hieu ung dich len
 void up_data_3(void)
 {      
   if (b_shift==1||count_byte>=msg[1]) 
   {
     b_data=0;
   }
   if (count_byte<msg[1]) 
   {
    b_data=msg[count_byte*msg[2]+j+3];
   }                                  
 }
  /*----------------------------------------------------------------------------*/     
  
  /*----------------------------------------------------------------------------*/    
// ctc dich chuoi len tren
void effect_3(void)
{
  if(load_effect)
  { 
    if(status_buf)  // khi dang quet hien thi o bo dem 1 thi sap sep du lieu o bo dem 0
    {       
      for (j=0;j<wb;j++) 
      { 
        for (row=0;row<15;row++) 
        {
          buf_screen_0[row*wb+j]=buf_screen_1[(row+1)*wb+j];
        };
        up_data_3();
        buf_screen_0[15*wb+j]=b_data;     
      };
    }
    else
    {   
      for (j=0;j<wb;j++) 
      { 
        for (row=0;row<15;row++) 
        {
          buf_screen_1[row*wb+j]=buf_screen_0[(row+1)*wb+j];
        };
        up_data_3();
        buf_screen_1[15*wb+j]=b_data;     
      };
    };
    load_effect=0;
  }  
} 
 /*----------------------------------------------------------------------------*/       
 

//************************************************************************