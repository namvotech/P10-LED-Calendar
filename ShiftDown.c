//**********************************************************************

  /*----------------------------------------------------------------------------*/
 // ctc cap nhat du lieu hieu ung dich xuong
 void up_data_4(void)
 {
   if (b_shift) 
   {
     b_data=0;
   }
   else 
   {
     if (count_byte<msg[1]) 
     {
       b_data=msg[(msg[1]-count_byte-1)*msg[2]+j+3];
     }                                  
     else
     {
       b_data=0;
     };
   };
 }
  /*----------------------------------------------------------------------------*/

 /*----------------------------------------------------------------------------*/    
// ctc dich chuoi xuong duoi
void effect_4(void)
{
  if(load_effect)
  { 
    if(status_buf)  // khi dang quet hien thi o bo dem 1 thi sap sep du lieu o bo dem 0
    {           
      for (j=0;j<wb;j++) 
      { 
        for (row=0;row<15;row++) 
        { 
          buf_screen_0[(15-row)*wb+j]=buf_screen_1[(15-row-1)*wb+j];
        };
        up_data_4();
        buf_screen_0[0*wb+j]=b_data; 
      };
    }
    else
    {
      for (j=0;j<wb;j++) 
      { 
        for (row=0;row<15;row++) 
        { 
          buf_screen_1[(15-row)*wb+j]=buf_screen_0[(15-row-1)*wb+j];
        };
        up_data_4();
        buf_screen_1[0*wb+j]=b_data; 
      };
    };
    load_effect=0;
  }  
} 
 /*----------------------------------------------------------------------------*/  
 

//****************************************************************************

