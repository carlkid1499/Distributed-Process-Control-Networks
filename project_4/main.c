/* ----- includes. ----- */
#include "FreeRTOS.h"
#include "task.h"
#include <plib.h>
#include "CerebotMX7cK.h"

/* ----- CAN includes ----- */
#include "sw_timer.h"
#include "GenericTypeDefs.h"
#include "CANFunctions.h"

/* ----- hardware setup ----- */
static void prvSetupHardware( void );


/* Simple Tasks that light a specific LED when running  */
static void prvTestTask1( void *pvParameters );
static void IOUnitTask( void *pvParameters );
static void CntrlUnitTask( void *pvParameters );
static void LCDGateTask( void *pvParameters );


#define HOMEBOARD 1

#if ( configUSE_TRACE_FACILITY == 1 )
    traceString str;
#endif

int main( void )
{
    prvSetupHardware();		/*  Configure hardware */
    
    #if ( configUSE_TRACE_FACILITY == 1 )
        vTraceEnable(TRC_START); // Initialize and start recording
        str = xTraceRegisterString("Channel");
    #endif


    
/* Create the tasks then start the scheduler. */

    /* Create the tasks defined within this file. */
    xTaskCreate( prvTestTask1, "prvTestTask1", configMINIMAL_STACK_SIZE,
                                    NULL, tskIDLE_PRIORITY, NULL );
    xTaskCreate( IOUnitTask, "IOUnitTask", configMINIMAL_STACK_SIZE,
                                    NULL, tskIDLE_PRIORITY, NULL );

    vTaskStartScheduler();	/*  Finally start the scheduler. */

/* Will only reach here if there is insufficient heap available to start
 *  the scheduler. */
    return 0;
}  /* End of main */

static void prvTestTask1( void *pvParameters )
{
    for( ;; )
    {
	/* In this loop, we wait till we have 1 second tick. Each second CAN1 will
 * send a message to CAN2 and toggles LEDA. When CAN2 receives this message
 * it toggles LEDD. It then sends a message to CAN1 and toggles LEDB. When
 * CAN1 receives this message it toggles LEDC. If one second is up then
 * CAN1 sends a message to CAN2 to toggle LEDA and the process repeats. */

        if(PeriodMs(0) == 0)
        {
            CAN1TxSendLEDMsg();	/* Function is defined in CANFunctions.c */
            PeriodMs(1000);
        }

/* CAN2RxMsgProcess will check if CAN2 has received a message from CAN1 and
 * will toggle LEDD. It will send a message to CAN1 to toggle LEDB. */

        CAN2RxMsgProcess();     /* Function is defined in CANFunctions.c */

/* CAN1RxMsgProcess() will check if CAN1  has received a message from CAN2 and
 * will toggle LEDC. */

        CAN1RxMsgProcess();     /* Function is defined in CANFunctions.c */
    }
}  /* End of prvTestTask1 */

static void IOUnitTask (void *pvParameters)
{   
    char unsigned ram_addr = 0x07;
    int len = 2;
    char SMBusdata[len];
    for(;;)
    {
      IR_READ(ram_addr,SMBusdata,len);
      vTaskDelay(pdMS_TO_TICKS(500)); // delay 500ms
    }
}
static void prvSetupHardware( void )
{
    Cerebot_mx7cK_setup();
    
    /* ----- ENABLE I2C1 for IR SENSOR ----- */
    INIT_IRSENSOR();
    
    /* ----- CAN BUS INITS ----- */
    CAN1Init();
    CAN2Init();
    
    /* Set up PmodSTEM LEDs */
    PORTSetPinsDigitalOut(IOPORT_B, SM_LEDS);
    LATBCLR = SM_LEDS;                      /* Clear all SM LED bits */

    /* Enable multi-vector interrupts */
    INTConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);  /* Do only once */
    INTEnableInterrupts();   /*Do as needed for global interrupt control */
    portDISABLE_INTERRUPTS();

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
