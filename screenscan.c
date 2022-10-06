//*****************************************************************************
// ctc hien thi du lieu ra man hinh 
/*----------------------------------------------------------------------------*/

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