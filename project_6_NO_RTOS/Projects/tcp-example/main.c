#include <stdio.h>
/*
 * This macro uniquely defines this file as the main entry point.
 * There should only be one such definition in the entire project,
 * and this file must define the AppConfig variable as described below.
 */
#define THIS_IS_STACK_APPLICATION

// Include all headers for any enabled TCPIP Stack functions
#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_ZEROCONF_LINK_LOCAL)
	#include "TCPIP Stack/ZeroconfLinkLocal.h"
#endif

// Not used for this application
#if defined(STACK_USE_ZEROCONF_MDNS_SD)
	#include "TCPIP Stack/ZeroconfMulticastDNS.h"
#endif

// Declare AppConfig structure and some other supporting stack variables
APP_CONFIG AppConfig;
static unsigned short wOriginalAppConfigChecksum;	// Checksum of the ROM defaults for AppConfig

// Main Application Global Variables
#include <plib.h>
#include "main.h"
#define __MAIN_C

#define TCP_LOCAL_PORT 9921 // JFF

// Private functions.
static void InitAppConfig(void);
static void InitializeBoard(void);
static void TCP_FSM(void);
static void ADC_INIT(void);


/*	============= Main application entry point.	============= */
int main(void)
{
static DWORD t = 0;
static DWORD dwLastIP = 0;

    // Initialize application specific hardware :  Cerebot 32MX7
    InitializeBoard();

// Initialize stack-related hardware components that may be 
// required by the UART configuration routines
    TickInit();
    MPFSInit();

// Initialize Stack and application related NV variables into AppConfig.
    InitAppConfig();

// Initialize core stack layers (MAC, ARP, TCP, UDP) and
// application modules (HTTP, SNMP, etc.)
    StackInit();
    
// Initialize TCP 
// No need to uncomment STACK_USE_TCP in TCPIP ETH795.h
// as it is defined elsewhere
    
    TCPInit(); // JFF
    
// Initialize any application-specific modules or functions/
// For this demo application, this only includes the
// UART 2 TCP Bridge
#if defined(STACK_USE_UART2TCP_BRIDGE)
    UART2TCPBridgeInit();
#endif
    DelayMs(1000);

    //  Init the ADC, but make sure it's off first
    CloseADC10();
    ADC_INIT();

   while(1)
    {
// Blink LED0 (right most one) every second and poll Ethernet stack.
        if(TickGet() - t >= TICK_SECOND/2ul)
        {
            t = TickGet();
            LED0_IO ^= 1;	// Blink activity LED
        }

        StackTask();

        StackApplications();

        TCP_FSM();

        if(dwLastIP != AppConfig.MyIPAddr.Val)
        {
            dwLastIP = AppConfig.MyIPAddr.Val;
			
#if defined(STACK_USE_UART)		// Future feature
            putrsUART((ROM char*)"\r\nNew IP Address: ");
#endif

			#if defined(STACK_USE_ANNOUNCE)	// Service is optional
				AnnounceIP();
			#endif
		}

        
	} // while (1))
}

static void TCP_FSM(void)
{
static TCP_SOCKET uskt;

static enum // JFF
{	TCP_IS_CLOSED = 0u,
	TCP_OPEN_REQUESTED,
	TCP_IS_CONNECTED
} fsmTCP = TCP_IS_CLOSED;	// Application state machine initial state

static unsigned msg_cntr = 0;
static unsigned msg_avail = 1;
unsigned int max_get;
static char get_string[80] = "Hi\r\n\n";
static char put_string[80];

// *******************************************************************  

// TCP FSM - JFF

switch(fsmTCP)
{
        
        // PIC32 is the server and puTTy is the client
        case TCP_IS_CLOSED:
            uskt = TCPOpen((DWORD)0, TCP_OPEN_SERVER,
					TCP_LOCAL_PORT, TCP_PURPOSE_DEFAULT);
            fsmTCP = TCP_OPEN_REQUESTED;
            break;
            
        case TCP_OPEN_REQUESTED:
            if(TCPIsConnected(uskt))
                fsmTCP = TCP_IS_CONNECTED;
            break;
            
    case TCP_IS_CONNECTED:
        if (msg_avail && (TCPIsPutReady(uskt) > 70))
            {
                sprintf(put_string, "\r\nMsg %d: %s\r\n", msg_cntr, get_string);
                TCPPutString(uskt, (BYTE *) put_string);
                TCPFlush(uskt);
                msg_cntr++;
                msg_avail = 0;
            }
        if ((max_get=TCPIsGetReady(uskt)))
        {
            max_get = TCPGetArray(uskt, (BYTE *) get_string, max_get);
            msg_avail=1;            
        }
        break;
                
} // end TCP fsm            
            
}

static void InitializeBoard(void)
{	
	DDPCONbits.JTAGEN = 0;

//  Enable Cerebot 32MX7 PHY
//	TRISECLR = (unsigned int) BIT_9;	// Make bit output
//	LATESET = (unsigned int) BIT_9;		// Set output high

//  Enable Cerebot 32MX7ck PHY
	TRISACLR = (unsigned int) BIT_6;	// Make bit output
	LATASET = (unsigned int) BIT_6;		// Set output high
    
// Set LEDs for output and set all off
	LED0_TRIS = 0;
	LED1_TRIS = 0;
	LED2_TRIS = 0;
	LED3_TRIS = 0;
	LED4_TRIS = 0;
	LED5_TRIS = 0;
	LED6_TRIS = 0;
	LED7_TRIS = 0;
	LED_PUT(0xFF);

	BUTTON0_TRIS = 1;	
	BUTTON1_TRIS = 1;	
	BUTTON2_TRIS = 1;	

		// Enable multi-vectored interrupts
	INTEnableSystemMultiVectoredInt();
		
// Enable optimal performance
	SYSTEMConfigPerformance(GetSystemClock());
//	mOSCSetPBDIV(OSC_PB_DIV_1);				// Use 1:1 CPU Core:Peripheral clocks
	mOSCSetPBDIV(OSC_PB_DIV_8);				// Use 1:1 CPU Core:Peripheral clocks
		
		// Disable JTAG port so we get our I/O pins back, but first
		// wait 50ms so if you want to reprogram the part with 
		// JTAG, you'll still have a tiny window before JTAG goes away.
		// The PIC32 Starter Kit debuggers use JTAG and therefore must not 
		// disable JTAG.
	DelayMs(100);

	LED_PUT(0x00);				// Turn the LEDs off
		
// UART
	#if defined(STACK_USE_UART)

		UARTTX_TRIS = 0;
		UARTRX_TRIS = 1;
		UMODE = 0x8000;			// Set UARTEN.  Note: this must be done before setting UTXEN

		USTA = 0x00001400;		// RXEN set, TXEN set
		#define CLOSEST_UBRG_VALUE ((GetPeripheralClock()+8ul*BAUD_RATE)/16/BAUD_RATE-1)
		#define BAUD_ACTUAL (GetPeripheralClock()/16/(CLOSEST_UBRG_VALUE+1))
	
		#define BAUD_ERROR ((BAUD_ACTUAL > BAUD_RATE) ? BAUD_ACTUAL-BAUD_RATE : BAUD_RATE-BAUD_ACTUAL)
		#define BAUD_ERROR_PRECENT	((BAUD_ERROR*100+BAUD_RATE/2)/BAUD_RATE)
		#if (BAUD_ERROR_PRECENT > 3)
			#warning UART frequency error is worse than 3%
		#elif (BAUD_ERROR_PRECENT > 2)
			#warning UART frequency error is worse than 2%
		#endif
	
		UBRG = CLOSEST_UBRG_VALUE;
	#endif
}

/*********************************************************************
 * Function:        void InitAppConfig(void)
 * PreCondition:    MPFSInit() is already called.
 * Input:           None
 * Output:          Write/Read non-volatile config variables.
 * Side Effects:    None
 * Overview:        None
 * Note:            None
 ********************************************************************/
// MAC Address Serialization using a MPLAB PM3 Programmer and 
// Serialized Quick Turn Programming (SQTP). 
// The advantage of using SQTP for programming the MAC Address is it
// allows you to auto-increment the MAC address without recompiling 
// the code for each unit.  To use SQTP, the MAC address must be fixed
// at a specific location in program memory.  Uncomment these two pragmas
// that locate the MAC address at 0x1FFF0.  Syntax below is for MPLAB C 
// Compiler for PIC18 MCUs. Syntax will vary for other compilers.
//#pragma romdata MACROM=0x1FFF0
static ROM BYTE SerializedMACAddress[6] = {MY_DEFAULT_MAC_BYTE1, MY_DEFAULT_MAC_BYTE2, MY_DEFAULT_MAC_BYTE3, MY_DEFAULT_MAC_BYTE4, MY_DEFAULT_MAC_BYTE5, MY_DEFAULT_MAC_BYTE6};
//#pragma romdata

static void InitAppConfig(void)
{

// Start out zeroing all AppConfig bytes to ensure all fields are 
// deterministic for checksum generation

	memset((void*)&AppConfig, 0x00, sizeof(AppConfig));
		
	AppConfig.Flags.bIsDHCPEnabled = TRUE;
	AppConfig.Flags.bInConfigMode = TRUE;
	memcpypgm2ram((void*)&AppConfig.MyMACAddr, (ROM void*)SerializedMACAddress, sizeof(AppConfig.MyMACAddr));
	AppConfig.MyIPAddr.Val = MY_DEFAULT_IP_ADDR_BYTE1 | MY_DEFAULT_IP_ADDR_BYTE2<<8ul | MY_DEFAULT_IP_ADDR_BYTE3<<16ul | MY_DEFAULT_IP_ADDR_BYTE4<<24ul;
	AppConfig.DefaultIPAddr.Val = AppConfig.MyIPAddr.Val;
	AppConfig.MyMask.Val = MY_DEFAULT_MASK_BYTE1 | MY_DEFAULT_MASK_BYTE2<<8ul | MY_DEFAULT_MASK_BYTE3<<16ul | MY_DEFAULT_MASK_BYTE4<<24ul;
	AppConfig.DefaultMask.Val = AppConfig.MyMask.Val;
	AppConfig.MyGateway.Val = MY_DEFAULT_GATE_BYTE1 | MY_DEFAULT_GATE_BYTE2<<8ul | MY_DEFAULT_GATE_BYTE3<<16ul | MY_DEFAULT_GATE_BYTE4<<24ul;
	AppConfig.PrimaryDNSServer.Val = MY_DEFAULT_PRIMARY_DNS_BYTE1 | MY_DEFAULT_PRIMARY_DNS_BYTE2<<8ul  | MY_DEFAULT_PRIMARY_DNS_BYTE3<<16ul  | MY_DEFAULT_PRIMARY_DNS_BYTE4<<24ul;
	AppConfig.SecondaryDNSServer.Val = MY_DEFAULT_SECONDARY_DNS_BYTE1 | MY_DEFAULT_SECONDARY_DNS_BYTE2<<8ul  | MY_DEFAULT_SECONDARY_DNS_BYTE3<<16ul  | MY_DEFAULT_SECONDARY_DNS_BYTE4<<24ul;

	// Load the default NetBIOS Host Name
	memcpypgm2ram(AppConfig.NetBIOSName, (ROM void*)MY_DEFAULT_HOST_NAME, 16);
	FormatNetBIOSName(AppConfig.NetBIOSName);

    // Compute the checksum of the AppConfig defaults as loaded from ROM
	wOriginalAppConfigChecksum = CalcIPChecksum((BYTE*)&AppConfig, sizeof(AppConfig));

}  // End of InitAppConfig

// The init function for the ADC
static void ADC_INIT(void)
{
   
    // PLIB func to configure ADC, see line 72 of adc10.h referenced in plib.h
    // Takes in 5 parameters
    OpenADC10(ADC_MODULE_ON | // Turn it on
              ADC_IDLE_CONTINUE | // Operate in IDLE mode... need to read more on this
              ADC_FORMAT_INTG | // Set the data format 32-bit integer
              ADC_CLK_AUTO | // set to auto convert
              ADC_AUTO_SAMPLING_ON, // auto sampling
              ADC_VREF_AVDD_AVSS | // set the reference voltages A/D Voltage reference configuration Vref+ is AVdd and Vref- is AVss
              ADC_OFFSET_CAL_DISABLE | // Offset calibration disable (normal operation).. need to read more on this
              ADC_SCAN_OFF | //  Read more on this page 20 of FRM 17
              ADC_SAMPLES_PER_INT_8 | // Interrupt me after the completion for each 8th sample
              ADC_BUF_8, // Buffer configured as two 8-word buffers
              ADC_CONV_CLK_PB | // Use the PCLock for ADC conversions
              ADC_SAMPLE_TIME_12, // auto sample time of 12 clocks
              ENABLE_AN2_ANA, // Enable AN2 in analog mode
              SKIP_SCAN_ALL // Skip all the following channels, we only want AN2
            );
    
    // Lastly Enable.
    DelayMs(100);    /* Ensure the correct sampling time has elapsed 
                         * before starting a conversion.*/
    EnableADC10();   
    
    // Configure ADC Interrupts
    INTSetVectorPriority(INT_ADC_VECTOR, INT_PRIORITY_LEVEL_2);
    INTSetVectorSubPriority (INT_ADC_VECTOR, INT_SUB_PRIORITY_LEVEL_3);
    INTClearFlag(INT_AD1);
    INTEnable   (INT_AD1, INT_ENABLED);

}

// ADC ISR
void __ISR(_ADC_VECTOR, IPL2SOFT) ADC_Handler(void)
{
    int NewLevel[15];
    
    NewLevel[0]=ADC1BUF0;
    NewLevel[1]=ADC1BUF1;
    NewLevel[2]=ADC1BUF2;  
    NewLevel[3]=ADC1BUF3;  
    NewLevel[4]=ADC1BUF4;   
    NewLevel[5]=ADC1BUF5;  
    NewLevel[6]=ADC1BUF6;
    NewLevel[7]=ADC1BUF7;
    NewLevel[8]=ADC1BUF8;  
    NewLevel[9]=ADC1BUF9;  
    NewLevel[10]=ADC1BUFA;   
    NewLevel[11]=ADC1BUFB;
    NewLevel[12]=ADC1BUFC;
    NewLevel[13]=ADC1BUFD;
    NewLevel[14]=ADC1BUFE;
    NewLevel[15]=ADC1BUFF;
    INTClearFlag(INT_AD1);
}



// End of main.c



