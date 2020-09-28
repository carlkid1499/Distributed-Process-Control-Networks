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
#include "LCD.h"

/* Carlos Home board development set if at home */
#define HOME_PRO_MX7_BOARD 1
/* ----- Hardware Setup ----- */
static void prvSetupHardware( void );

/* ----- Tasks ----- */
static void EEPROM_Task(void *pvParameters);
static void LCD_Task(void *pvParameters);

/* ----- UART ISR ----- */
void vUART_ISR_Handler(void);
void __attribute__((interrupt(IPL2), vector(_UART_1_VECTOR))) vUART_ISR_Wrapper(void);

/* ----- CNI ISR Handler ----- */
void vBTN1_ISR_Handler(void);
void __attribute__((interrupt(IPL1), vector(_CHANGE_NOTICE_VECTOR))) vBTN1_ISR_Wrapper(void);

void hw_msDelay(unsigned int);

/* Semaphore Handles */
SemaphoreHandle_t EEPROM_Semaphore;
SemaphoreHandle_t LCD_Semaphore;

/* Queue Handles */
QueueHandle_t UART_Q;
QueueHandle_t LCD_Q;

/* Message Struct */
struct AMessage {
        int length;
        int Start_Addr;
    } xMessage;

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
    
    /* Lets make a queue for the UART 80 characters + '\0' */
    UART_Q = xQueueCreate(81, sizeof(char));
    if (UART_Q != NULL)
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "UART_Q! Created Successfully!");
        #endif
    }
    else
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "Error creating! UART_Q!");
        #endif
        for(;;);
    }
    
    /* Create a queue to hold LCD messages 
    ** Will store length of message and
    ** start address in a struct.
    ** Queue with 10 copies of AMessage Struct. Got help from this link!
    ** https://www.freertos.org/FreeRTOS_Support_Forum_Archive/August_2015/freertos_Send_a_struct_through_Queue_64d28ac3j.html
    */
     LCD_Q = xQueueCreate(10, sizeof(struct AMessage));

    if (LCD_Q != NULL)
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "LCD_Q! Created Successfully!");
        #endif
    }
    else
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "Error creating! LCD_Q!");
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
    
    LCD_Semaphore = xSemaphoreCreateBinary(); // create that semaphore
    if(LCD_Semaphore == NULL)
    {
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "Error creating! LCD_SEMAPHORE!");
        #endif
        for(;;);
    }
    
    
    /* Create the tasks then start the scheduler. */
    xTaskCreate( EEPROM_Task, "EEPROM_Task", configMINIMAL_STACK_SIZE,
                                    NULL, tskIDLE_PRIORITY+1, NULL );
    /* Create the tasks then start the scheduler. */
    xTaskCreate( LCD_Task, "LCD_Task", configMINIMAL_STACK_SIZE,
                                    NULL, tskIDLE_PRIORITY+1, NULL );

    vTaskStartScheduler();	/*  Finally start the scheduler. */

/* Will only reach here if there is insufficient heap available to start
 *  the scheduler. */
    return 0;
}  /* End of main */

void vUART_ISR_Handler(void)
{
    mU1RXIntEnable(0); // disable UART interrupts at beginning
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
    
    mU1RXClearIntFlag(); // clear the UART interrupt flag
    mU1RXIntEnable(1); // enable UART interrupts at beginning
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
           
        /* Let's give a semaphore to unblock EEPROM_Task*/
        xSemaphoreGiveFromISR(EEPROM_Semaphore, &xHigherPriorityTaskWoken);
    }
    // Did we wake a higher priority task? If yes witch to it.
    portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
}

void vBTN1_ISR_Handler(void)
{
    portBASE_TYPE xHigherPriorityTaskWoken = NULL;
    mCNIntEnable(0); // disable CN interrupts at beginning
    hw_msDelay(20); // 20 ms button debounce
    while (PORTReadBits(IOPORT_G, BTN1)); // poll button 1
    hw_msDelay(20); // 20 ms button debounce
    mCNClearIntFlag(); // Macro function to clear CNI flag
    mCNIntEnable(1); // enable CN interrupts at end
    /* ---- Give Semaphore to LCD_Task ---- */
    xSemaphoreGiveFromISR(LCD_Semaphore, &xHigherPriorityTaskWoken);
    portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
}

void hw_msDelay(unsigned int mS) {
    unsigned int tWait, tStart;
    tStart = ReadCoreTimer(); // Read core timer count - SW Start breakpoint
    tWait = (CORE_MS_TICK_RATE * mS); // Set time to wait
    while ((ReadCoreTimer() - tStart) < tWait); // Wait for the time to pass
}

static void EEPROM_Task (void *pvParameters)
{
    // Local Variables
    char charbuf;
    int SAddr = 0x00;
    struct AMessage Send_msg;
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
        
        int message_length = 0;
        portBASE_TYPE UART_Q_Status = xQueueReceive(UART_Q, &charbuf,0);
        while((UART_Q_Status != pdFAIL) && (charbuf != '\r')) //we must have gotten something
        {
            /* Send to the EERPOM */
            putcU1(charbuf);
            // by default we start at address 0x0
            EEPROM_WRITE(SAddr, &charbuf, 1);
            EEPROM_POLL();
            message_length = message_length + 1;
            SAddr = SAddr + 1;
            UART_Q_Status = xQueueReceive(UART_Q, &charbuf,0);
        }
        
        //terminate message with a NULL
        charbuf = NULL;
        EEPROM_WRITE(SAddr, &charbuf, 1);
        EEPROM_POLL();
        message_length = message_length + 1;
        SAddr = SAddr + 1;
        
        putsU1("\n\r");
        // if we reach here message has been stored and UART should be ready to get another one
        Send_msg.length = message_length;
        Send_msg.Start_Addr = SAddr - message_length;

        portBASE_TYPE LCD_Q_Status = xQueueSendToBack(LCD_Q, (void *)&Send_msg, 0);
        vTaskDelay(5); // wait for data to copy over
        if(LCD_Q_Status != pdPASS)
        {
            #if ( configUSE_TRACE_FACILITY == 1 )
                vTracePrint(str, "LCD_Q is full");
            #endif
        }
        else
        {
            #if ( HOME_PRO_MX7_BOARD == 1 )
                LATGCLR = LED2;
            #else
                LATBCLR = LEDB;
            #endif
        }
        
        // Adjust some local variables
        message_length = 0;
        
        // light LEDA we are ready for another message!
        #if ( HOME_PRO_MX7_BOARD == 1 )
            LATGSET = LED1; /* turn on LED1 */
        #else
            LATBSET = LEDA;
        #endif
    }
}

static void LCD_Task(void *pvParameters)
{
    struct AMessage Receive_msg;
    /* As per most tasks, this task is implemented within an infinite loop.
     * Take the semaphore once to start with so the semaphore is empty before 
     * the infinite loop is entered.  The semaphore was created before the 
     * scheduler was started so before this task ran for the first time.*/
    xSemaphoreTake(LCD_Semaphore, 0);
    
    for(;;)
    {
        /* Attempt to get a semaphore. Will block until we get one. */
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "LCD_Task requesting LCD_SEMAPHORE");
        #endif
        xSemaphoreTake(LCD_Semaphore, portMAX_DELAY);

        /* To get here we must have received a semaphore */
        #if ( configUSE_TRACE_FACILITY == 1 )
            vTracePrint(str, "LCD_Task received LCD_Semaphore");
        #endif
        
        // issue here... might be receiving same data over and over?!?!
        portBASE_TYPE LCD_Q_Status = xQueueReceive(LCD_Q, &(Receive_msg),0);
        vTaskDelay(5); // wait for data to copy over
        if(LCD_Q_Status != pdFAIL)
        {
            #if ( HOME_PRO_MX7_BOARD == 1 )
                LATGCLR = LED2;
            #else
                LATBCLR = LEDB;
            #endif
            int Address = Receive_msg.Start_Addr;
            int length = Receive_msg.length;
            char Rmsg[length];
            // Read From EEPROM and Print to UART
            EEPROM_READ(Address, Rmsg, length);
            EEPROM_POLL();
            char message[] = "Read message from EEPROM: ";
            putsU1(message);
            putsU1(Rmsg);
        }
        else
        {
            #if ( HOME_PRO_MX7_BOARD == 1 )
                LATGSET = LED2;
            #else
                LATBSET = LEDB;
            #endif
        }
    }
}

static void prvSetupHardware( void )
{
    Cerebot_mx7cK_setup();
    initialize_uart1(19200, 1); // 19200 Baud rate and odd parity
    INIT_EEPROM(); // initialize I2C resources
    //Timer1_Setup();
    //Initialize_LCD();
    
    /* ----- Begin: Enable UART Interrupts ----- */
    mU1RXIntEnable(1); //  Enable Uart 1 Rx Int
    mU1SetIntPriority(3);
    mU1SetIntSubPriority(0);
    /* ----- End: Enable UART Interrupts ----- */
    
    
    /* ----- BEGIN: CN Interrupts ----- */
    unsigned int dummy; // used to hold PORT read value
    // BTN1 and BTN2 pins set for input by Cerebot header file
    // PORTSetPinsDigitalIn(IOPORT_G, BIT_6 | BIT7); //
    // Enable CN for BTN1
    mCNOpen(CN_ON, CN8_ENABLE, 0);
    // Set CN interrupts priority level 1 sub priority level 0
    mCNSetIntPriority(1); // Group priority (1 to 7)
    mCNSetIntSubPriority(0); // Subgroup priority (0 to 3)
    // read port to clear difference
    dummy = PORTReadBits(IOPORT_G, BTN1);
    mCNClearIntFlag(); // Clear CN interrupt flag
    mCNIntEnable(1); // Enable CN interrupts
    // Global interrupts must enabled to complete the initialization.
    /* ----- END: CN Interrupts ----- */
    

    #if ( HOME_PRO_MX7_BOARD == 1 )
        /* Set up PRO  MX7 LEDs */
        PORTSetPinsDigitalOut(IOPORT_G, BRD_LEDS);
        LATGCLR = BRD_LEDS; /* Clear all BRD_LEDS bits */
        LATGSET = LED1; /* turn on LED1 */
        LATGSET = LED2;
    #else
        /* Set up PmodSTEM LEDs */
        PORTSetPinsDigitalOut(IOPORT_B, SM_LEDS);
        LATBCLR = SM_LEDS; /* Clear all SM LED bits */
        LATBSET = LEDA;
        LATBSET = LEDB;
    #endif
    
    /* Enable multi-vector interrupts */
    INTConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);  /* Do only once */
    INTEnableInterrupts();   /*Do as needed for global interrupt control */
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
