#include "LCD.h"
#include <plib.h>
#include "CerebotMX7cK.h"
#include "string.h"

#define Fsck 400000
#define BRG_VAL ((FPB/2/Fsck)-2)
#define T1_PRESCALE 1
#define TOGGLES_PER_SEC 1000
#define T1_TICK (FPB/T1_PRESCALE/TOGGLES_PER_SEC)

void Initialize_LCD() {
    Initialize_PMP();
    // Page 11
    Timer1_delay(30);
    writeLCD(0, 0x38); // RS and then data
    Timer1_delay(50);
    writeLCD(0, 0x0f);
    Timer1_delay(50);
    writeLCD(0, 0x01);
    Timer1_delay(5);
}

void Initialize_PMP() {
    int cfg1 = PMP_ON | PMP_READ_WRITE_EN | PMP_READ_POL_HI | PMP_WRITE_POL_HI;
    int cfg2 = PMP_DATA_BUS_8 | PMP_MODE_MASTER1 |
            PMP_WAIT_BEG_1 | PMP_WAIT_MID_2 | PMP_WAIT_END_1;
    int cfg3 = PMP_PEN_0; // only PMA0 enabled
    int cfg4 = PMP_INT_OFF; // no interrupts used
    mPMPOpen(cfg1, cfg2, cfg3, cfg4);
    // see page 15-16 of Project6.pdf

}

void Timer1_Setup() {
    /* ----- BEGIN Timer 1 interrupts ----- */
    // Initialize Timer 1 for 1 ms
    //configure Timer 1 with internal clock, 1:1 prescale, PR1 for 1 ms period
    OpenTimer1(T1_ON | T1_PS_1_1, (T1_TICK - 1));
    // set up the timer interrupt with a priority of 2, sub priority 0
    mT1SetIntPriority(3); // Group priority range: 1 to 7
    mT1SetIntSubPriority(0); // Subgroup priority range: 0 to 3
    mT1IntEnable(1); // Enable T1 interrupts
    // Global interrupts must enabled to complete the initialization.
    /* ----- END: Timer 1 Interrupts ----- */
}

void Timer1_delay(int delay) {
    while (delay--) {
        while (!mT1GetIntFlag()); // Wait for interrupt flag to be set
        mT1ClearIntFlag(); // Clear the interrupt flag
    }
}

void LCD_cls()
{
    writeLCD(0,0x01);
}
void LCD_puts(char *str)
{
    while(*str) // Look for end of string NULL character  
    { 
    LCD_putc(*str); // Write character to LCD 
    str++; // Increment string pointer    
    } 
} //End of LCD_puts 

void LCD_puts_scroll(char *str)
{
    // clear the screen first!
    LCD_cls();
    char * cptr;
    char * topstr;
    char * botstr;
    // Let's split the string by spaces
    cptr = strtok(str," ");
    botstr = cptr;
    writeLCD(0,0xC0); // second line
    LCD_puts(botstr);
    Timer1_delay(250);
    // lets cycle through the tokens
    while(cptr != NULL)
    {
        
        cptr = strtok(NULL, " ");
        if(cptr == NULL)
            break;
        topstr = botstr;
        botstr = cptr;
        LCD_cls(); // clear the screen
        writeLCD(0,0x80); // move to first line
        LCD_puts(topstr);
        Timer1_delay(1000);
        writeLCD(0,0xC0); // second line
        LCD_puts(botstr);
        Timer1_delay(1000);
    }
}

void LCD_putc(char data)
{
    char temp;
    while(busyLCD()); // check the busy flag
    temp = readLCD(0); // read cursor location
    temp = (temp & 0x7F); // clear busy flag to 0
    
    if(data == '\r')
    {
        // reset LCD address to start of current line
        if(temp >= 0x00 && temp <= 0x10) // first line
           writeLCD(0,0x80); // first line
        else if(temp >= 0x40 && temp <= 0x50) // second line
            writeLCD(0,0xC0); // second line
    }
    else if(data == '\n')
    {
        // move LCD address to start of next line
        if(temp >= 0x00 && temp < 0x10) // first line
           writeLCD(0,0xC0); // move to second line
        else if(temp >= 0x40 && temp <= 0x50) // second line
            writeLCD(0,0x80); // move to first line
    }
    else
        // continue
    
    if(temp >= 0x10 && temp < 0x40)
    {
        writeLCD(0,0xC0); // second line
        writeLCD(1,data);
    }    
    else if(temp >= 0x50)
    {
       writeLCD(0,0x80); // first line
       writeLCD(1,data);
    }   
    else
        writeLCD(1,data);
}


char readLCD(int addr) {     
PMPSetAddress(addr);  // Set LCD RS control     
mPMPMasterReadByte(); // initiate dummy read sequence     
return mPMPMasterReadByte(); // read actual data 
} // End of readLCD 


void writeLCD(int addr, char c)
{
    while(busyLCD()); // Wait for LCD to be ready
    PMPSetAddress(addr); // Set LCD RS control
    PMPMasterWrite(c); // initiate write sequence
}

int busyLCD()
{
    int temp;
    temp = readLCD(0); // read it twice!
    temp =  (temp & 0x80); //
    return temp;
}