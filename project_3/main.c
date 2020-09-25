/** @file main.c
 * 
 * @brief Main program file for Reference Design 1 using FreeRTOS10 
 *
 * @par       
 * Demonstrates the use of FreeRTOS, Doxygen, Git, and Tracealyzer
 *
 * @author
 * Dr J
 * @date
 * 07 SEP 2020
 */

/* Includes. */
#include "FreeRTOS.h"
#include "task.h"
#include <plib.h>
#include "CerebotMX7cK.h"
#include "comm.h"
#include <stdio.h>
#include <string.h>
#include "queue.h"
#include "I2C.h"

/* Carlos Home board development set if at home */
#define HOME_PRO_MX7_BOARD 1
/* ----- Hardware Setup ----- */
static void prvSetupHardware( void );

/* ----- Tasks ----- */
static void EEPROM_TASK(void *pvParameters);

/* ----- UART ISR ----- */
void vUART_ISR_Handler(void);
void __attribute__((interrupt(IPL2), vector(_UART_1_VECTOR))) vUART_ISR_Wrapper(void);

/* Queue Handles */
QueueHandle_t UART_Q;

#if ( configUSE_TRACE_FACILITY == 1 )
    traceString str;
#endif

int main( void )
{
    /*  Configure hardware */
    prvSetupHardware();
    
    #if ( configUSE_TRACE_FACILITY == 1 )
        vTraceEnable(TRC_START); // Initialize and start recording
        str = xTraceRegisterString("Channel");
    #endif
    
    /* Lets make a queue for the UART */  
    UART_Q = xQueueCreate(1, sizeof(char *));
    if (UART_Q == NULL)
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "Error creating! UART_Q!");
        #endif
        for(;;);
    }
    
/* Create the tasks then start the scheduler. */

    /* Create the tasks defined within this file. */
    /*xTaskCreate( UART_TASK, "UART_TASK", configMINIMAL_STACK_SIZE,
                                    NULL, tskIDLE_PRIORITY+1, NULL ); */
   /* xTaskCreate( EEPROM_TASK, "EEPROM_TASK", configMINIMAL_STACK_SIZE,
                                    NULL, tskIDLE_PRIORITY+1, NULL ); */

    vTaskStartScheduler();	/*  Finally start the scheduler. */

/* Will only reach here if there is insufficient heap available to start
 *  the scheduler. */
    return 0;
}  /* End of main */

void vUART_ISR_Handler(void)
{
    // local variables
    char buf;
    
    getcU1(&buf); // grab a char from terminal       
    putcU1(buf); // echo the character back 
    if (buf == '\r') // did we get a return?
    {
        char message[] = "Sending message to EEPROM!...\n";
        putsU1(message);
    }
  
    // Clear the RX interrupt Flag
    INTClearFlag(INT_SOURCE_UART_RX(UART1));
}

/* static void UART_TASK (void *pvParameters)
{     
    // Local Variables
    char str_buf[81];
    
    for( ;; )
    {
        // According to the comm.c getstrU1 doesn't block if no characters available
        while(!getstrU1(str_buf, sizeof(str_buf))); // grab a string from terminal
        // echo the message back
        putsU1("<<<<<..... Sending message to EEPROM .....>>>>>");          
        putsU1(str_buf);
        putsU1("<<<<<..... .....>>>>>");
        putsU1("\n");
        
        
        // Turn off LEDA, we've got a message to send
        #if ( HOME_PRO_MX7_BOARD == 1 )
            LATGCLR = LED1;
        #else
            LATBCLR = LEDA;
        #endif

        // Let's send it to the UART_Q 
        portBASE_TYPE UART_Q_Status = xQueueSendToBack(UART_Q, &str_buf, 0);
        if(UART_Q_Status != pdPASS)
        {
            #if ( configUSE_TRACE_FACILITY == 1 )
                vTracePrint(str, "UART_Q is full");
            #endif
        }
        
        // Let's delay to make sure our data gets copied over.
        vTaskDelay(pdMS_TO_TICKS(1)); // delay for 1 ms
    }
} */

static void EEPROM_TASK (void *pvParameters)
{
    // this needs a bit of work.
    // Local Variables
    char msg_to_store;
    
    for(;;)
    {
        portBASE_TYPE UART_Q_Status = xQueueReceive(UART_Q, &msg_to_store,0);
        if(UART_Q_Status != pdFAIL) //we must have gotten something
        {
            // Send to EEPROM
            //putsU1(msg_to_store);
            EEPROM_WRITE(0x0,&msg_to_store, 81);
            EEPROM_POLL(); // poll  EEPROM for completion
            #if ( HOME_PRO_MX7_BOARD == 1 )
                LATGSET = LED1;
            #else
                LATBSET = LEDA;
            #endif
        }
        else
        {
            // we got any error
        }
    }
}

static void prvSetupHardware( void )
{
    Cerebot_mx7cK_setup();
    initialize_uart1(19200, 1); // 19200 Baud rate and odd parity
    INIT_EEPROM(); // initialize I2C resources
    
    /* ----- Enable UART Interrupts ----- */
    UARTSetFifoMode(UART1, UART_INTERRUPT_ON_RX_NOT_EMPTY); // Turn on receive RX interrupt
    // Configure UART2 RX Interrupt
    INTEnable(INT_SOURCE_UART_RX(UART1), INT_ENABLED);
    INTSetVectorPriority(INT_VECTOR_UART(UART1), INT_PRIORITY_LEVEL_1);
    INTSetVectorSubPriority(INT_VECTOR_UART(UART1), INT_SUB_PRIORITY_LEVEL_0);
    /* ----- ------ ----- ----- ----- --- */

    

    #if ( HOME_PRO_MX7_BOARD == 1 )
        /* Set up PRO  MX7 LEDs */
        PORTSetPinsDigitalOut(IOPORT_G, BRD_LEDS);
        LATGCLR = BRD_LEDS; /* Clear all BRD_LEDS bits */
        LATGSET = LED1; /* turn on LED1 */
    #else
        /* Set up PmodSTEM LEDs */
        PORTSetPinsDigitalOut(IOPORT_B, SM_LEDS);
        LATBCLR = SM_LEDS; /* Clear all SM LED bits */
        LATBSET = LEDA;
    #endif
    
    /* Enable multi-vector interrupts */
    INTConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);  /* Do only once */
    INTEnableInterrupts();   /*Do as needed for global interrupt control */
    
//	/* Configure the hardware for maximum performance. */
//	vHardwareConfigurePerformance();
//
//	/* Setup to use the external interrupt controller. */
//	vHardwareUseMultiVectoredInterrupts();
//
//	portDISABLE_INTERRUPTS();
//
//	/* Setup the digital IO for the LED's. */
//	vParTestInitialise();
}
/*-----------------------------------------------------------*/

void vApplicationMallocFailedHook( void )
{
	/* vApplicationMallocFailedHook() will only be called if
	configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
	function that will get called if a call to pvPortMalloc() fails.
	pvPortMalloc() is called internally by the kernel whenever a task, queue,
	timer or semaphore is created.  It is also called by various parts of the
	demo application.  If heap_1.c or heap_2.c are used, then the size of the
	heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
	FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
	to query the size of free heap space that remains (although it does not
	provide information on how the remaining heap might be fragmented). */
	taskDISABLE_INTERRUPTS();
	for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationIdleHook( void )
{
	/* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
	to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
	task.  It is essential that code added to this hook function never attempts
	to block in any way (for example, call xQueueReceive() with a block time
	specified, or call vTaskDelay()).  If the application makes use of the
	vTaskDelete() API function (as this demo application does) then it is also
	important that vApplicationIdleHook() is permitted to return to its calling
	function, because it is the responsibility of the idle task to clean up
	memory allocated by the kernel to any task that has since been deleted. */
}
/*-----------------------------------------------------------*/

void vApplicationStackOverflowHook( TaskHandle_t pxTask, char *pcTaskName )
{
	( void ) pcTaskName;
	( void ) pxTask;

	/* Run time task stack overflow checking is performed if
	configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook	function is 
	called if a task stack overflow is detected.  Note the system/interrupt
	stack is not checked. */
	taskDISABLE_INTERRUPTS();
	for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationTickHook( void )
{
	/* This function will be called by each tick interrupt if
	configUSE_TICK_HOOK is set to 1 in FreeRTOSConfig.h.  User code can be
	added here, but the tick hook is called from an interrupt context, so
	code must not attempt to block, and only the interrupt safe FreeRTOS API
	functions can be used (those that end in FromISR()). */
}
/*-----------------------------------------------------------*/

void _general_exception_handler( unsigned long ulCause, unsigned long ulStatus )
{
	/* This overrides the definition provided by the kernel.  Other exceptions 
	should be handled here. */
	for( ;; );
}
/*-----------------------------------------------------------*/

void vAssertCalled( const char * pcFile, unsigned long ulLine )
{
volatile unsigned long ul = 0;

	( void ) pcFile;
	( void ) ulLine;

	__asm volatile( "di" );
	{
		/* Set ul to a non-zero value using the debugger to step out of this
		function. */
		while( ul == 0 )
		{
			portNOP();
		}
	}
	__asm volatile( "ei" );
}
