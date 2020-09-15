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

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
/* Standard demo includes. */
//#include "partest.h"
#include <plib.h>

/* Hardware specific includes. */
#include "CerebotMX7cK.h"

/* Home board development */
#define HOME_PRO_MX7_BOARD 1
/*-----------------------------------------------------------*/



/* ----- Begin: Task Globals ----- */
static void prvSetupHardware(void);
static void ToggleLEDB_Task(void *pvParameters);
static void LEDCHandler_Task(void *pvParameters);
void vLEDC_ISR_Handler(void);
void __attribute__((interrupt(IPL1), vector(_CHANGE_NOTICE_VECTOR))) vLEDC_ISR_Wrapper(void);
void hw_msDelay(unsigned int);
/* ----- End: Task Globals ----- */

/* ----- Begin: Global handle for Binary Semaphore ----- */
SemaphoreHandle_t LEDC_Semaphore;
// Note a MUTEX CAN NOT BE USED IN AN ISR!
/* ----- End: Global handle for Binary Semaphore ----- */

/* ----- Begin: Define for Tracalyzer ----- */
#if ( configUSE_TRACE_FACILITY == 1 )
traceString str;
#endif

/* ----- End: Define for Tracalyzer ----- */

int main(void) {
    prvSetupHardware(); /*  Configure hardware */

#if ( configUSE_TRACE_FACILITY == 1 )
    vTraceEnable(TRC_START); // Initialize and start recording
    str = xTraceRegisterString("Channel");
#endif

    LEDC_Semaphore = xSemaphoreCreateBinary(); // Create a Binary Semaphore type
    if (LEDC_Semaphore != NULL) // was it created successfully?
    {
#if ( configUSE_TRACE_FACILITY == 1 )
        vTracePrint(str, "LEDC_Semaphore created successfully!");
#endif
        /* Create the tasks then start the scheduler. */
        xTaskCreate(ToggleLEDB_Task, "ToggleLEDB_Task", configMINIMAL_STACK_SIZE,
                NULL, tskIDLE_PRIORITY + 2, NULL);
#if ( configUSE_TRACE_FACILITY == 1 )
        vTracePrint(str, "ToggleLEDB_Task Created!");
#endif

        xTaskCreate(LEDCHandler_Task, "LEDCHandler_Task", configMINIMAL_STACK_SIZE,
                NULL, tskIDLE_PRIORITY + 1, NULL);
#if ( configUSE_TRACE_FACILITY == 1 )
        vTracePrint(str, "LEDCHandler_Task Created!");
#endif

        vTaskStartScheduler(); /*  Finally start the scheduler. */
    }



    /* Will only reach here if there is insufficient heap available to start
     *  the scheduler. */
    return 0;
} /* End of main */

/* ToggleLEDB_Task Function Description ****************************************
 * SYNTAX:          static void ToggleLEDB_Task( void *pvParameters );
 * KEYWORDS:        RTOS, Task
 * DESCRIPTION:     Toggle LEDB on/off every millisecond
 * PARAMETER 1:     void pointer - data of unspecified data type sent from
 *                  RTOS scheduler
 * RETURN VALUE:    None (There is no returning from this function)
 * NOTES:           LEDB will turn on or off
 * END DESCRIPTION ************************************************************/
static void ToggleLEDB_Task(void *pvParameters) {
    // local task variables
    TickType_t xLastWakeTick;

    for (;;) {
        xLastWakeTick = xTaskGetTickCount(); // Get the the current tick
#if ( HOME_PRO_MX7_BOARD == 1 )
        LATGINV = LED2; /* Toggle LED2: by default it is off */
#else
        LATBINV = LEDB; /* Toggle LEDB: by default it is off */
#endif

#if ( configUSE_TRACE_FACILITY == 1 )
        vTracePrint(str, "LEDB Toggled");
#endif
        vTaskDelayUntil(&xLastWakeTick, pdMS_TO_TICKS(1)); // delay for 1 ms	
    }
} /* End of ToggleLEDB_Task */

static void LEDCHandler_Task(void *pvParameters) {
    /* As per most tasks, this task is implemented within an infinite loop.
     * Take the semaphore once to start with so the semaphore is empty before 
     * the infinite loop is entered.  The semaphore was created before the 
     * scheduler was started so before this task ran for the first time.*/
    xSemaphoreTake(LEDC_Semaphore, 0);
    for (;;) {
        /* Attempt to get a semaphore. Will block until we get one. */
#if ( configUSE_TRACE_FACILITY == 1 )
        vTracePrint(str, "LEDCHandler_Task requesting LEDC_SEMAPHORE");
#endif
        xSemaphoreTake(LEDC_Semaphore, portMAX_DELAY);

        /* To get here we must have received a semaphore */
#if ( configUSE_TRACE_FACILITY == 1 )
        vTracePrint(str, "LEDCHandler_Task received LEDC_Semaphore");
#endif

#if ( HOME_PRO_MX7_BOARD == 1 )
        LATGINV = LED3; /* Toggle LED1: by default it is off */
#else
        LATBINV = LEDC; /* Toggle LEDC: by default it is off */
#endif
#if ( configUSE_TRACE_FACILITY == 1 )
        vTracePrint(str, "LEDC Toggled");
#endif
    }
}

void vLEDC_ISR_Handler(void) {
    mCNIntEnable(0); // disable CN interrupts at beginning
#if ( HOME_PRO_MX7_BOARD == 1 )
    LATGSET = LED4; // set the LED4 since we entered the ISR
#else
    LATBSET = LEDD; // set the LEDD since we entered the ISR
#endif
#if ( configUSE_TRACE_FACILITY == 1 )
    vTracePrint(str, "LEDD on from ISR");
#endif
    hw_msDelay(20); // 20 ms button debounce
    while (PORTReadBits(IOPORT_G, BTN1)); // poll button 1 on
    hw_msDelay(20); // 20 ms button debounce
    portBASE_TYPE xHigherPriorityTaskWoken = pdFALSE;
    /* Let's give a semaphore to unblock LEDCHandler_Task*/
    xSemaphoreGiveFromISR(LEDC_Semaphore, &xHigherPriorityTaskWoken);

    mCNClearIntFlag(); // Macro function to clear CNI flag

    /* Giving the semaphore may have unblocked a task -if it did and the 
     * unblocked task has a priority equal to or above the currently executing 
     * task then xHigherPriorityTaskWoken will have been set to pdTRUE 
     * and portEND_SWITCHING_ISR() will force a context switch to the newly 
     * unblocked higher priority task.NOTE: The syntax for forcing a context 
     * switch within an ISR varies between FreeRTOS ports.  The 
     * portEND_SWITCHING_ISR() macro is provided as part of
     * the PIC32 port layer for this purpose.  taskYIELD() must never be 
     * called from an ISR! */
#if ( HOME_PRO_MX7_BOARD == 1 )
    LATGCLR = LED4; // unset the LED4 since we are exiting the ISR
#else
    LATBCLR = LEDD; // unset the LEDD since we are exiting the ISR
#endif
#if ( configUSE_TRACE_FACILITY == 1 )
    vTracePrint(str, "LEDD off from  ISR");
#endif
    mCNIntEnable(1); // Enable CN interrupts at end
    portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
}

static void prvSetupHardware(void) {
    Cerebot_mx7cK_setup();

#if ( HOME_PRO_MX7_BOARD == 1 )
    /* Set up PRO  MX7 LEDs */
    PORTSetPinsDigitalOut(IOPORT_G, BRD_LEDS);
    LATGCLR = BRD_LEDS; /* Clear all BRD_LEDS bits */
#else
    /* Set up PmodSTEM LEDs */
    PORTSetPinsDigitalOut(IOPORT_B, SM_LEDS);
    LATBCLR = SM_LEDS; /* Clear all SM LED bits */
#endif

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

    // Enable multi vectored interrupts
    INTEnableSystemMultiVectoredInt(); //done only once    
}

/*-----------------------------------------------------------*/

void vApplicationMallocFailedHook(void) {
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
    for (;;);
}

/*-----------------------------------------------------------*/

void vApplicationIdleHook(void) {
    /* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
    to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
    task.  It is essential that code added to this hook function never attempts
    to block in any way (for example, call xQueueReceive() with a block time
    specified, or call vTaskDelay()).  If the application makes use of the
    vTaskDelete() API function (as this demo application does) then it is also
    important that vApplicationIdleHook() is permitted to return to its calling
    function, because it is the responsibility of the idle task to clean up
    memory allocated by the kernel to any task that has since been deleted. */

    /* Begin: Button Bounce Trap */
    while (!PORTReadBits(IOPORT_G, BTN1)); // poll button 1 off
#if ( HOME_PRO_MX7_BOARD == 1 )
    LATGINV = LED1; // toggle  LED1
#else
    LATBINV = LEDA; // toggle LEDA
#endif
#if ( configUSE_TRACE_FACILITY == 1 )
    vTracePrint(str, "LEDA Toggled");
#endif
    hw_msDelay(20); // 20 ms button debounce
    while (PORTReadBits(IOPORT_G, BTN1)); // poll button 1 on
    hw_msDelay(20); // 20 ms button debounce
    /* End: Button Bounce Trap */
}

/*-----------------------------------------------------------*/

void hw_msDelay(unsigned int mS) {
    unsigned int tWait, tStart;
    tStart = ReadCoreTimer(); // Read core timer count - SW Start breakpoint
    tWait = (CORE_MS_TICK_RATE * mS); // Set time to wait
    while ((ReadCoreTimer() - tStart) < tWait); // Wait for the time to pass
}

void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName) {
    (void) pcTaskName;
    (void) pxTask;

    /* Run time task stack overflow checking is performed if
    configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook	function is 
    called if a task stack overflow is detected.  Note the system/interrupt
    stack is not checked. */
    taskDISABLE_INTERRUPTS();
    for (;;);
}

/*-----------------------------------------------------------*/

void vApplicationTickHook(void) {
    /* This function will be called by each tick interrupt if
    configUSE_TICK_HOOK is set to 1 in FreeRTOSConfig.h.  User code can be
    added here, but the tick hook is called from an interrupt context, so
    code must not attempt to block, and only the interrupt safe FreeRTOS API
    functions can be used (those that end in FromISR()). */
}

/*-----------------------------------------------------------*/

void _general_exception_handler(unsigned long ulCause, unsigned long ulStatus) {
    /* This overrides the definition provided by the kernel.  Other exceptions 
    should be handled here. */
    for (;;);
}

/*-----------------------------------------------------------*/

void vAssertCalled(const char * pcFile, unsigned long ulLine) {
    volatile unsigned long ul = 0;

    (void) pcFile;
    (void) ulLine;

    __asm volatile( "di");
    {
        /* Set ul to a non-zero value using the debugger to step out of this
        function. */
        while (ul == 0) {
            portNOP();
        }
    }
    __asm volatile( "ei");
}
