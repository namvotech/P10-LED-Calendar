//*****************************************************************************
/*Khai bao chan, khai bao bien*/
#define ROW            PORTB        // chon hang khi quet man hinh led
#define R              PORTB.5     // chan 
#define SCLK           PORTB.3
#define CKL            PORTB.7
#define OE             PORTB.4     
#define CASE_EFF       PORTD.0
#define CASE_MSG       PORTD.5   

// Khai bao cac bien su dung trong CT           
bit load_effect;    // "0" khong cho phep load du lieu cho hieu ung, "1" cho phép load                          
bit status_buf;     // "0" chon buf_screen_0[64], "1" chon buf_screen_1[64]  
bit b_shift=0 ;     // b_shift=0 Mac dinh dich du lieu tu man hinh led ra ngoai va tu flash vao man hinh led
                    // b_shift=1 Luon chi dich du lieu tu man hinh led ra ngoai, không dich du lieu tu flash vao man hinh
unsigned  int    wb=4;   // do rong byte man hinh led 
unsigned  int    r;
unsigned  int    count_byte;   
unsigned  int    count_bit;
unsigned  int    i,j,k;
unsigned  int    effect;         //Khong thay tac dung gi
unsigned  char   check_effect;  //Khong thay tac dung gi
unsigned  int    b_data;
unsigned  int    row;          
unsigned char hour,min,sec,week=1,day,month,year, ch_hour,ch_min,ch_sec, dv_hour,dv_min,dv_sec;   
unsigned char ngay_amlich, thang_amlich, nam_amlich;
unsigned int  allnam_amlich;
unsigned char hieuung=0;
// khai bao mang du lieu bo dem man hinh
unsigned char buf_screen_0[64];   // gia tri "64" la kich thuoc byte cho 1 modul 16x32 pixel
unsigned char buf_screen_1[64];   //  Man hinh led co n modul thi gia tri tuong ung la n*64  

//******************************************************************************************