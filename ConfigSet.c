/*Cai dat thong so ban dau cho vi dieu khien*/
PORTA=0x00;   
DDRA=0x00;

PORTB=0xFF;   
DDRB=0xFF;    // PORTB lam dau ra

PORTC=0x00;   
DDRC=0x00;    // PORTC lam dau vao

PORTD=0x00;   
DDRD=0xFF;  

 

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 3.906 kHz
// Mode: CTC top=OCR0
// OC0 output: Disconnected
TCCR0=0x0D;
TCNT0=0x00;
OCR0=0xAF;       

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 3.906 kHz
// Mode: CTC top=OCR1A
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: On
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x0D;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x0F;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x12;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;
/*
// SPI initialization
// SPI Type: Master
// SPI Clock Rate: 2*1000.000 kHz
// SPI Clock Phase: Cycle Half
// SPI Clock Polarity: Low
// SPI Data Order: MSB First
SPCR=0x50;
SPSR=0x01;
*/
// Global enable interrupts
i2c_init();
rtc_init(0,1,0);
#asm("sei")