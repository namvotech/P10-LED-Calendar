//******************************************************************
// Hieu ung dich trai msg               
/*----------------------------------------------------------------------------*/
 // ctc cap nhat byte du lieu de dich trai   
 /************************************************/
 void up_data_1(void)
 {                
 // b_shift=0: dich du lieu man hinh ra ngoai, va tu flash vao trong man hinh
 // b_shft=1: chi dich du lieu man hinh ra ngoai => b_data lu�n lu�n=0
  
    if(hieuung==0 || hieuung==5)  //Time: 
    {   
           if ((b_shift==1)||(count_byte>=msg0[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg0[2])) 
             {
               b_data=(msg0[row*msg0[2]+count_byte+3]<<count_bit);
             }   
           } 
    } 
  /**********************************/
    else if(hieuung==1)  //Duong Lich:
    {   
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
           } 
    }    
  /**********************************/   
    else if(hieuung==2)  //Duong Lich:
    {   
           if ((b_shift==1)||(count_byte>=msg2[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg2[2])) 
             {
               b_data=(msg2[row*msg2[2]+count_byte+3]<<count_bit);
             }   
           } 
    }    
  /**********************************/
    else if(hieuung==3)  //Am Lich:
    {   
           if ((b_shift==1)||(count_byte>=msg3[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg3[2])) 
             {
               b_data=(msg3[row*msg3[2]+count_byte+3]<<count_bit);
             }   
           } 
    } 
   /**********************************/
    else if(hieuung==4)  //Duong Lich:
    {   
           if ((b_shift==1)||(count_byte>=msg4[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg4[2])) 
             {
               b_data=(msg4[row*msg4[2]+count_byte+3]<<count_bit);
             }   
           } 
    }     
//  /**********************************/   
//  /**********************************/
//    else if(hieuung==7)  //Buoi sang vui ve !
//    {   
//           if ((b_shift==1)||(count_byte>=msg8[2])) 
//           {
//             b_data=0;
//           }
//           else 
//           {
//             if ((b_shift==0)&&(count_byte<msg8[2])) 
//             {
//               b_data=(msg8[row*msg8[2]+count_byte+3]<<count_bit);
//             }   
//           } 
//    } 
//  /**********************************/
//    else if(hieuung==8)  //Chuc ngu ngon!
//    {   
//           if ((b_shift==1)||(count_byte>=msg9[2])) 
//           {
//             b_data=0;
//           }
//           else 
//           {
//             if ((b_shift==0)&&(count_byte<msg9[2])) 
//             {
//               b_data=(msg9[row*msg9[2]+count_byte+3]<<count_bit);
//             }   
//           } 
//    }
   /**********************************/
    else if(hieuung==9)  //
    {   
           if ((b_shift==1)||(count_byte>=msg9[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg9[2])) 
             {
               b_data=(msg9[row*msg9[2]+count_byte+3]<<count_bit);
             }   
           } 
    }         
 /**********************************/
    else if(hieuung==10)  //Chuc mung nam moi
    {   
           if ((b_shift==1)||(count_byte>=msg10[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg10[2])) 
             {
               b_data=(msg10[row*msg10[2]+count_byte+3]<<count_bit);
             }   
           } 
    }   
    /***************************************/
    else if(hieuung==11)  //Tet toi tan tai-Xuan sang dac loc !
    {   
           if ((b_shift==1)||(count_byte>=msg11[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg11[2])) 
             {
               b_data=(msg11[row*msg11[2]+count_byte+3]<<count_bit);
             }   
           } 
    }  
    /************************************/    
    else if(hieuung==12)  //Tet toi tan tai-Xuan sang dac loc !
    {   
           if ((b_shift==1)||(count_byte>=msg12[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg12[2])) 
             {
               b_data=(msg12[row*msg12[2]+count_byte+3]<<count_bit);
             }   
           } 
    }     
/********************************/ 
    else if(hieuung==13)  //Tet toi tan tai-Xuan sang dac loc !
    {   
           if ((b_shift==1)||(count_byte>=msg13[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg13[2])) 
             {
               b_data=(msg13[row*msg13[2]+count_byte+3]<<count_bit);
             }   
           } 
    }    


  /************************************/
  /*NGAY LE AM LICH*/
   /**********************************/
    else if(hieuung==15)  //
    {   
           if ((b_shift==1)||(count_byte>=msg15[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg15[2])) 
             {
               b_data=(msg15[row*msg15[2]+count_byte+3]<<count_bit);
             }   
           } 
    }         
 /**********************************/
    else if(hieuung==16)  //
    {   
           if ((b_shift==1)||(count_byte>=msg16[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg16[2])) 
             {
               b_data=(msg16[row*msg16[2]+count_byte+3]<<count_bit);
             }   
           } 
    }   
    /***************************************/
    else if(hieuung==17)  //
    {   
           if ((b_shift==1)||(count_byte>=msg17[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg17[2])) 
             {
               b_data=(msg17[row*msg17[2]+count_byte+3]<<count_bit);
             }   
           } 
    }  
    /************************************/    
    else if(hieuung==18)  //
    {   
           if ((b_shift==1)||(count_byte>=msg18[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg18[2])) 
             {
               b_data=(msg18[row*msg18[2]+count_byte+3]<<count_bit);
             }   
           } 
    }     
/********************************/ 
    else if(hieuung==19)  //
    {   
           if ((b_shift==1)||(count_byte>=msg19[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg19[2])) 
             {
               b_data=(msg19[row*msg19[2]+count_byte+3]<<count_bit);
             }   
           } 
    }  
/********************************/ 
    else if(hieuung==20)  //
    {   
           if ((b_shift==1)||(count_byte>=msg20[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg20[2])) 
             {
               b_data=(msg20[row*msg20[2]+count_byte+3]<<count_bit);
             }   
           } 
    }        
/********************************/ 
/*NGAY LE DUONG LICH*/
/********************************/ 
    else if(hieuung==21)  //
    {   
           if ((b_shift==1)||(count_byte>=msg21[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg21[2])) 
             {
               b_data=(msg21[row*msg21[2]+count_byte+3]<<count_bit);
             }   
           } 
    }   
/********************************/ 
    else if(hieuung==22)  //
    {   
           if ((b_shift==1)||(count_byte>=msg22[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg22[2])) 
             {
               b_data=(msg22[row*msg22[2]+count_byte+3]<<count_bit);
             }   
           } 
    } 
/********************************/ 
    else if(hieuung==23)  //
    {   
           if ((b_shift==1)||(count_byte>=msg23[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg23[2])) 
             {
               b_data=(msg23[row*msg23[2]+count_byte+3]<<count_bit);
             }   
           } 
    } 
/********************************/ 
    else if(hieuung==24)  //
    {   
           if ((b_shift==1)||(count_byte>=msg24[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg24[2])) 
             {
               b_data=(msg24[row*msg24[2]+count_byte+3]<<count_bit);
             }   
           } 
    }  
/********************************/ 
    else if(hieuung==25)  //
    {   
           if ((b_shift==1)||(count_byte>=msg25[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg25[2])) 
             {
               b_data=(msg25[row*msg25[2]+count_byte+3]<<count_bit);
             }   
           } 
    }   
/********************************/ 
    else if(hieuung==26)  //
    {   
           if ((b_shift==1)||(count_byte>=msg26[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg26[2])) 
             {
               b_data=(msg26[row*msg26[2]+count_byte+3]<<count_bit);
             }   
           } 
    }
/********************************/ 
    else if(hieuung==27)  //
    {   
           if ((b_shift==1)||(count_byte>=msg27[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg27[2])) 
             {
               b_data=(msg27[row*msg27[2]+count_byte+3]<<count_bit);
             }   
           } 
    }  
    
/********************************/    
    
    else if(hieuung==28)  //
    {   
           if ((b_shift==1)||(count_byte>=msg28[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg28[2])) 
             {
               b_data=(msg28[row*msg28[2]+count_byte+3]<<count_bit);
             }   
           } 
    }   
/********************************/ 
    else if(hieuung==29)  //
    {   
           if ((b_shift==1)||(count_byte>=msg29[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg29[2])) 
             {
               b_data=(msg29[row*msg29[2]+count_byte+3]<<count_bit);
             }   
           } 
    } 
/********************************/ 
    else if(hieuung==30)  //
    {   
           if ((b_shift==1)||(count_byte>=msg30[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg30[2])) 
             {
               b_data=(msg30[row*msg30[2]+count_byte+3]<<count_bit);
             }   
           } 
    } 
/********************************/ 
    else if(hieuung==31)  //
    {   
           if ((b_shift==1)||(count_byte>=msg31[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg31[2])) 
             {
               b_data=(msg31[row*msg31[2]+count_byte+3]<<count_bit);
             }   
           } 
    }  
/********************************/ 
    else if(hieuung==32)  //
    {   
           if ((b_shift==1)||(count_byte>=msg32[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg32[2])) 
             {
               b_data=(msg32[row*msg32[2]+count_byte+3]<<count_bit);
             }   
           } 
    }   
/********************************/ 
    else if(hieuung==33)  //
    {   
           if ((b_shift==1)||(count_byte>=msg33[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg33[2])) 
             {
               b_data=(msg33[row*msg33[2]+count_byte+3]<<count_bit);
             }   
           } 
    }
/********************************/ 
    else if(hieuung==34)  //
    {   
           if ((b_shift==1)||(count_byte>=msg34[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg34[2])) 
             {
               b_data=(msg34[row*msg34[2]+count_byte+3]<<count_bit);
             }   
           } 
    }     





/********************************/ 
    else if(hieuung==35)  //
    {   
           if ((b_shift==1)||(count_byte>=msg35[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg35[2])) 
             {
               b_data=(msg35[row*msg35[2]+count_byte+3]<<count_bit);
             }   
           } 
    }  
/********************************/ 
    else if(hieuung==36)  //
    {   
           if ((b_shift==1)||(count_byte>=msg36[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg36[2])) 
             {
               b_data=(msg36[row*msg36[2]+count_byte+3]<<count_bit);
             }   
           } 
    }   
/********************************/ 
    else if(hieuung==37)  //
    {   
           if ((b_shift==1)||(count_byte>=msg37[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg37[2])) 
             {
               b_data=(msg37[row*msg37[2]+count_byte+3]<<count_bit);
             }   
           } 
    }
/********************************/ 
    else if(hieuung==38)  //
    {   
           if ((b_shift==1)||(count_byte>=msg38[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg38[2])) 
             {
               b_data=(msg38[row*msg38[2]+count_byte+3]<<count_bit);
             }   
           } 
    }     

/********************************/ 
    else if(hieuung==39)  //
    {   
           if ((b_shift==1)||(count_byte>=msg39[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg39[2])) 
             {
               b_data=(msg39[row*msg39[2]+count_byte+3]<<count_bit);
             }   
           } 
    }   

/********************************/ 
    else if(hieuung==40)  //
    {   
           if ((b_shift==1)||(count_byte>=msg40[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg40[2])) 
             {
               b_data=(msg40[row*msg40[2]+count_byte+3]<<count_bit);
             }   
           } 
    }        
/********************************/     
/********************************/        
    else     // Ngay moi vui ve
    {
           if ((b_shift==1)||(count_byte>=msg[2])) 
           {
             b_data=0;
           }
           else 
           {
             if ((b_shift==0)&&(count_byte<msg[2])) 
             {
               b_data=(msg[row*msg[2]+count_byte+3]<<count_bit);
             }   
           }     
    }           
 }      
 /*----------------------------------------------------------------------------*/ 
 /*----------------------------------------------------------------------------*/
 // ctc dich trai chuoi msg tren led matrix
 void effect_left(void)
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