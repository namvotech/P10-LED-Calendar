//************************************************************************
/*----------------------------------------------------------------------------*/
 // ctc kiem tra su  dich chuyen hieu ung trai & phai
/*****************************************************/
 void check_effect_left_right(unsigned int stop_byte)
 {
   // doan ctc kiem soát so bit chuyen dich
   k++;
   if(k==1)  // thoi gian dich hieu ung (hay toc do chay cua hieu ung)
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
 // ctc kiem tra su  dich chuyen hieu ung trai & phai cua CHUC MUNG NAM MOI
/*****************************************************/
 void check_effect_left_right2(unsigned int stop_byte)
 {
   // doan ctc kiem soát so bit chuyen dich
   k++;
   if(k==2)  // thoi gian dich hieu ung (hay toc do chay cua hieu ung)
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
 
 
 
 