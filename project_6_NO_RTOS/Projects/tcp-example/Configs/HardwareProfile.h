 /*********************************************************************
 *
 *	Hardware specific definitions for:
 *    - PIC32 Cerebot 32MX7
 *    - PIC32MX795F512L
 *    - Internal 10/100 Ethernet MAC with SMC LAN8720 10/100 PHY
 *
 *********************************************************************
 * FileName:        HWP PIC32_ETH_SK_ETH795.h
 * Dependencies:    Compiler.h
 * Processor:       PIC32
 * Compiler:        Microchip C32 v1.11 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright (C) 2002-2010 Microchip Technology Inc.  All rights
 * reserved.
 *
 * Customized by: 	Richard Wall
 *					University of Idaho
 *					October 21, 2007
 *
 * This hardware profile is specifically modified for the 
 * Cerebot 32MX7 in combination with the UI Stepper motor 
 * PMod and the parallel character LCD using the PMP bus.
 *
 * Note:  UART not specified -- Needs to be set for UART1
 *
 ********************************************************************/
#ifndef HARDWARE_PROFILE_H
#define HARDWARE_PROFILE_H

#include "Compiler.h"

// Define a macro describing this hardware set up (used in other files)
#define PIC32_ENET_SK_DM320004

// Set configuration fuses (but only in MainDemo.c where THIS_IS_STACK_APPLICATION is defined)
#if defined(THIS_IS_STACK_APPLICATION)
	#pragma config FPLLODIV = DIV_1, FPLLMUL = MUL_20, FPLLIDIV = DIV_2, FWDTEN = OFF, FPBDIV = DIV_8, POSCMOD = XT, FNOSC = PRIPLL, CP = OFF
	#pragma config FMIIEN = OFF, FETHIO = ON, ICESEL = ICS_PGx1, DEBUG = ON	// external PHY in RMII/alternate configuration
#endif


// Clock frequency values
// These directly influence timed events using the Tick module.  They also are used for UART and SPI baud rate generation.
#define GetSystemClock()		(80000000ul)			// Hz
#define GetInstructionClock()	(GetSystemClock()/1)	// Normally GetSystemClock()/4 for PIC18, GetSystemClock()/2 for PIC24/dsPIC, and GetSystemClock()/1 for PIC32.  Might need changing if using Doze modes.
#define GetPeripheralClock()	(GetSystemClock()/8)	// Normally GetSystemClock()/4 for PIC18, GetSystemClock()/2 for PIC24/dsPIC, and GetSystemClock()/1 for PIC32.  Divisor may be different if using a PIC32 since it's configurable.


// Hardware I/O pin mappings
// LEDs

// Ports and bits for Stepper Motor
#define LED_A_C				(unsigned int) (BIT_2 | BIT_3 | BIT_4 )
#define LED_D_H				(unsigned int) (BIT_6 | BIT_7 | BIT_8 | BIT_9 | BIT_10) 
#define LED_A_H				(LED_A_C | LED_D_H)

// Ports and bits modified for Cerebot 32MX7 - RWW
#define LED_1_4				(unsigned int) (BIT_12 | BIT_13 | BIT_14 | BIT_15) 

#define LED0_TRIS			(TRISGbits.TRISG12)	// Ref LED1
#define LED0_IO				(LATGbits.LATG12)
#define LED1_TRIS			(TRISGbits.TRISG13)	// Ref LED2
#define LED1_IO				(LATGbits.LATG13)
#define LED2_TRIS			(TRISGbits.TRISG14)	// Ref LED3
#define LED2_IO				(LATGbits.LATG14)
#define LED3_TRIS			(TRISGbits.TRISG15)	// Ref LED4
#define LED3_IO				(LATGbits.LATG15)

// Ports and bits for Stepper Motor
#define LED4_TRIS			(TRISBbits.TRISB2)	// LEDA
#define LED4_IO				(LATBbits.LATB2)
#define LED5_TRIS			(TRISBbits.TRISB3)	// LEDB
#define LED5_IO				(LATBbits.LATB3)
#define LED6_TRIS			(TRISBbits.TRISB4)	// LEDC
#define LED6_IO				(LATBbits.LATB4)
#define LED7_TRIS			(TRISBbits.TRISB6)	// LEDD
#define LED7_IO				(LATBbits.LATB6)
#define LED8_TRIS			(TRISBbits.TRISB7)	// LEDE
#define LED8_IO				(LATBbits.LATB7)
#define LED9_TRIS			(TRISBbits.TRISB8)	// LEDF
#define LED9_IO				(LATBbits.LATB8)
#define LED10_TRIS			(TRISBbits.TRISB9)	// LEDG
#define LED10_IO			(LATBbits.LATB9)
#define LED11_TRIS			(TRISBbits.TRISB11)	// LEDH
#define LED11_IO			(LATBbits.LATB11)

// Cerebot 32MX7
#define LED_GET()			(unsigned char)( ((LATG&LED_1_4) >>12) | ((LATB&LED_A_C)<<2)  | (((LATB&&LED_D_H)<<1))  )  
// Directs 12 bit value to LED 1 - 4 and LED A - H,  RWW Cerebot 32MX7
//#define LED_PUT(a)			do{LATGCLR=(LED_1_4); LATGSET=((a<<12)&LED_1_4);  LATBCLR=LED_A_H; LATBSET=((((a&0x70)>>2)+(unsigned int) BIT_5)&LED_A_H);}while(0)
#define LED_PUT(a)			do{LATGCLR=(LED_1_4); LATGSET=((a<<12)&LED_1_4);  LATBCLR=LED_A_H; LATBSET=(((a&0x70)>>2)& LED_A_H);LATBSET=(((a&0x0F80)>>1)& LED_A_H);}while(0)

// Momentary push buttons = Normally low
#define BUTTON0_TRIS		(TRISGbits.TRISG6)	// Ref BTN1
#define BUTTON0_IO			(PORTGbits.RG6)
#define BUTTON1_TRIS		(TRISGbits.TRISG7)	// Ref BTN2
#define BUTTON1_IO			(PORTGbits.RG7)
#define BUTTON2_TRIS		(TRISAbits.TRISA0)	// Ref BTN3
#define BUTTON2_IO			(PORTAbits.RA0)
#define BUTTON3_TRIS		(TRISAbits.TRISA0)	// No BUTTON3 on this board - Use BTN3
#define BUTTON3_IO			(TRISAbits.TRISA0)

// UART configuration (not too important since we don't have a UART 
// connector attached normally, but needed to compile if the STACK_USE_UART 
// or STACK_USE_UART2TCP_BRIDGE features are enabled.
#define UARTTX_TRIS			(TRISFbits.TRISF3)
#define UARTRX_TRIS			(TRISFbits.TRISF2)

// External SMC PHY configuration
#define	PHY_RMII				// external PHY runs in RMII mode
// #define	PHY_CONFIG_ALTERNATE	// alternate configuration used
#define	PHY_ADDRESS			0x0	// the address of the SMC LAN8720 PHY

// Note, it is not possible to use a MRF24WB0M Wi-Fi PICtail Plus 
// card with this starter kit.  The required interrupt signal, among 
// possibly other I/O pins aren't available on the Starter Kit board.

// LCD I/O pins
#define LCD_MASK			0x00ff
#define LCD_DATA_TRIS		(TRISE)
#define LCD_DATA_OUT()		TRISECLR = LCD_MASK
#define LCD_DATA_IO			(LATE)
#define LCD_RD_WR_TRIS		(TRISDbits.TRISD5)
#define LCD_RD_WR_IO		(LATDbits.LATD5)
#define LCD_RS_TRIS			(TRISBbits.TRISB15)
#define LCD_RS_IO			(LATBbits.LATB15)
#define LCD_E_TRIS			(TRISDbits.TRISD4)
#define LCD_E_IO			(LATDbits.LATD4)

// UART mapping functions for consistent API names across 8-bit and 16 or 
// 32 bit compilers.  For simplicity, everything will use "UART" instead 
// of USART/EUSART/etc.
#define BusyUART()			BusyUSART()
#define CloseUART()			CloseUSART()
#define ConfigIntUART(a)	ConfigIntUSART(a)
#define DataRdyUART()		DataRdyUSART()
#define OpenUART(a,b,c)		OpenUSART(a,b,c)
#define ReadUART()			ReadUSART()
#define WriteUART(a)		WriteUSART(a)
#define getsUART(a,b,c)		getsUSART(b,a)
#define putsUART(a)			putsUSART(a)
#define getcUART()			ReadUSART()
#define putcUART(a)			WriteUSART(a)
#define putrsUART(a)		putrsUSART((far rom char*)a)

#endif // #ifndef HARDWARE_PROFILE_H
