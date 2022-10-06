//*********************************************************************

 /*----------------------------------------------------------------------------*/
 // ctc cap nhat byte du lieu de dich phai   
 void up_data_2(void)
 {                
 // b_shift=0: dich du lieu man hinh ra ngoai, va tu flash vao trong man hinh
 // b_shft=1: chi dich du lieu man hinh ra ngoai => b_data luôn luôn=0
   if (b_shift) 
   {
     b_data=0;
   }
   else 
   {
     if (count_byte>=msg[2]) 
    {
      b_data=0; 
    }
    else 
    {
      b_data=(msg[row*msg[2]+(msg[2]-count_byte)+2]>>(count_bit));
    };    
   };
 }      
 /*----------------------------------------------------------------------------*/    
 
 /*----------------------------------------------------------------------------*/
 // ctc dich phai chuoi msg tren led matrix
 void effect_2(void)
 { 
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
          buf_screen_0[row*wb+(wb-1-j)]=(buf_screen_1[row*wb+(wb-1-j)]>>1)|(buf_screen_1[row*wb+(wb-1-j-1)]<<7); 
        };
        //chuyen du lieu tu msg vao bo dem man hinh   
        up_data_2(); //   update du lieu cho b_data o hieu ung 1
        buf_screen_0[row*wb+0]=(buf_screen_1[row*wb+0]>>1)|(b_data<<7); 
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
          buf_screen_1[row*wb+(wb-1-j)]=(buf_screen_0[row*wb+(wb-1-j)]>>1)|(buf_screen_0[row*wb+(wb-1-j-1)]<<7);
        };
        //chuyen du lieu tu msg vao bo dem man hinh   
        up_data_2(); //   update du lieu cho b_data o hieu ung 1
        buf_screen_1[row*wb+0]=(buf_screen_0[row*wb+0]>>1)|(b_data<<7);
      };
     }; 
     load_effect=0; // Da load xong du lieu moi, tam khoa load du lieu cho lan tiep theo
   }   
 }
/*----------------------------------------------------------------------------*/    

 
 
 
 
 //**********************************************************************************