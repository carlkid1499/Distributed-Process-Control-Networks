/*********************************************************************
 *
 *  Headers for Vending Machine Example Application
 *
 *********************************************************************
 * FileName:        VendingMachine.h
 * Dependencies:    TCP/IP stack
 * Processor:      	PIC32
 * Compiler:        Microchip C32 v1.05 or higher
 *
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright (C) 2002-2009 Microchip Technology Inc.  All rights
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
 ********************************************************************/
#ifndef __MAIN_H
	#define __MAIN_H

	#include "TCPIP Stack/TCPIP.h"

// Application Specific Global Variables
	#define MAX_PRODUCTS		7u

	#define BAUD_RATE       (19200)		// bps

	extern APP_CONFIG AppConfig;
	#define SaveAppConfig(a)

	

// Define a header structure for validating the AppConfig data structure in EEPROM/Flash
	typedef struct
	{
		unsigned short wConfigurationLength;	// Number of bytes saved in EEPROM/Flash (sizeof(APP_CONFIG))
		unsigned short wOriginalChecksum;		// Checksum of the original AppConfig defaults as loaded from ROM (to detect when to wipe the EEPROM/Flash record of AppConfig due to a stack change, such as when switching from Ethernet to Wi-Fi)
		unsigned short wCurrentChecksum;		// Checksum of the current EEPROM/Flash data.  This protects against using corrupt values if power failure occurs while writing them and helps detect coding errors in which some other task writes to the EEPROM in the AppConfig area.
	} NVM_VALIDATION_STRUCT;


// An actual function defined in VendMaching.c for displaying the current IP 
// address on the UART and/or LCD.
	void DisplayIPValue(IP_ADDR IPVal);
    


#endif
