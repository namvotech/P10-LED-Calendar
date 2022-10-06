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

