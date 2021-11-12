#include "LCD.h"
#include <plib.h>

void LCD_cls()
{
    writeLCD(0,0x01);
}

void LCD_ln1()
{
    writeLCD(0,0x80);
}

void LCD_ln2()
{
    writeLCD(0,0xC0);
}
void LCD_puts(char *str)
{
    while(*str) // Look for end of string NULL character  
    { 
    LCD_putc(*str); // Write character to LCD 
    str++; // Increment string pointer    
    } 
} //End of LCD_puts 

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