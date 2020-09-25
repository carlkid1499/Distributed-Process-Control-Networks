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
#include "semphr.h"

/* Carlos Home board development set if at home */
#define HOME_PRO_MX7_BOARD 1
/* ----- Hardware Setup ----- */
static void prvSetupHardware( void );

/* ----- Tasks ----- */
static void EEPROM_Task(void *pvParameters);

/* ----- UART ISR ----- */
void vUART_ISR_Handler(void);
void __attribute__((interrupt(IPL2), vector(_UART_1_VECTOR))) vUART_ISR_Wrapper(void);

/* Semaphore Handles */
SemaphoreHandle_t EEPROM_Semaphore;

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
    
    /* Lets make a queue for the UART 80 max plus \r */  
    UART_Q = xQueueCreate(81, sizeof(char));
    if (UART_Q == NULL)
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "Error creating! UART_Q!");
        #endif
        for(;;);
    }
    
    EEPROM_Semaphore = xSemaphoreCreateBinary(); // create that semaphore
    if(EEPROM_Semaphore == NULL)
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "Error creating! EEPROM_SEMAPHORE!");
        #endif
        for(;;);
    }
    
    
/* Create the tasks then start the scheduler. */

    /* Create the tasks defined within this file. */
    xTaskCreate( EEPROM_Task, "EEPROM_Task", configMINIMAL_STACK_SIZE,
                                    NULL, tskIDLE_PRIORITY+1, NULL );

    vTaskStartScheduler();	/*  Finally start the scheduler. */

/* Will only reach here if there is insufficient heap available to start
 *  the scheduler. */
    return 0;
}  /* End of main */

void vUART_ISR_Handler(void)
{
    // local variables
    char buf;
    portBASE_TYPE xHigherPriorityTaskWoken = NULL;
    
    getcU1(&buf); // grab a char from terminal       
    putcU1(buf); // echo the character back
    // Let's send it to the UART_Q 
    portBASE_TYPE UART_Q_Status = xQueueSendToBackFromISR(UART_Q, &buf, 0);
    if(UART_Q_Status != pdPASS)
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "UART_Q is full");
        #endif
    }
    
    // Clear the RX interrupt Flag
    INTClearFlag(INT_SOURCE_UART_RX(UART1));
    
    if (buf == '\r') // did we get a return?
    {
        char message[] = "Sending message to EEPROM!...\n";
        putsU1(message);
        // Turn off LEDA, we've got a message to send
        #if ( HOME_PRO_MX7_BOARD == 1 )
            LATGCLR = LED1;
        #else
            LATBCLR = LEDA;
        #endif

        /* Let's give a semaphore to unblock LEDCHandler_Task*/
        xSemaphoreGiveFromISR(EEPROM_Semaphore, &xHigherPriorityTaskWoken);
    }
    portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
}

static void EEPROM_Task (void *pvParameters)
{
    // this needs a bit of work.
    // Local Variables
    char cbuf;
    unsigned char SAddr = 0x00;
    
    /* As per most tasks, this task is implemented within an infinite loop.
     * Take the semaphore once to start with so the semaphore is empty before 
     * the infinite loop is entered.  The semaphore was created before the 
     * scheduler was started so before this task ran for the first time.*/
    xSemaphoreTake(EEPROM_Semaphore, 0);
    
    for(;;)
    {   
        /* Attempt to get a semaphore. Will block until we get one. */
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "EEPROM_Task requesting EEPROM_SEMAPHORE");
        #endif
        xSemaphoreTake(EEPROM_Semaphore, portMAX_DELAY);

        /* To get here we must have received a semaphore */
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "EEPROM_Task received EEPROM_Semaphore");
        #endif
        
        
        portBASE_TYPE UART_Q_Status = xQueueReceive(UART_Q, &cbuf,0);
        while((UART_Q_Status != pdFAIL) || (cbuf != '\r')) //we must have gotten something
        {
            // Send to EEPROM
            EEPROM_WRITE(SAddr,&cbuf, 0);
            EEPROM_POLL(); // poll  EEPROM for completion
            SAddr = SAddr + 0x01; // increment address
            // If next item is a 'r' loop stops
            UART_Q_Status = xQueueReceive(UART_Q, &cbuf,0);
        }
        // stopped here 9/24/2020
        // Need a better way to store messages in  EEPROM
        // I need to store the start and end addresses somewhere
        // So the LCD task can read messages properly!
        #if ( HOME_PRO_MX7_BOARD == 1 )
            LATGSET = LED1;
        #else
            LATBSET = LEDA;
        #endif
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
