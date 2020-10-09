#include "CerebotMX7cK.h"
#include <plib.h>
#include "inputcapture.h"

float RPS = 0; // global variable for speed
float RPS_arr[15]; // global array for RPS
float RPS_Average; // global variable for RPS average

void timer3_init()
{
    OpenTimer3(T3_ON | T3_PS_1_256 | T3_SOURCE_INT, 0xFFFF);
    mT3SetIntPriority(2);   // Set Timer 3 interrupt group priority 2
    mT3SetIntSubPriority(2); // Set Timer 3 interrupt subgroup priority 2
    mT3IntEnable(1);  // Enable Timer 3 interrupts 
    /* Alternate to code above using the C32 Peripheral Library function: 
    ConfigIntTimer3(T3_INT_ON | T3_INT_PRIOR_2 | T3_INT_SUB_PRIOR_2); */
}
void inputcapture_init()
{
    timer3_init();
    // set motor hall effect outputs SA (RD3) and SB (RD12)
    PORTSetPinsDigitalIn(IOPORT_D, (BIT_3 | BIT_12)); 
    // clear pending input capture interrupts
    mIC5ClearIntFlag();
    // configure the IC module see page 8 of project10.pdf
    OpenCapture5( IC_ON | IC_CAP_16BIT | IC_IDLE_STOP | IC_FEDGE_FALL | IC_TIMER3_SRC | IC_INT_1CAPTURE | IC_EVERY_FALL_EDGE); // Note the logical OR
    ConfigIntCapture5(IC_INT_ON | IC_INT_PRIOR_3 | IC_INT_SUB_PRIOR_0);   
}

void __ISR( _TIMER_3_VECTOR, ipl2) T3Interrupt(void) 
{
    LATBINV = LEDC; // Toggle LEDC  - Timing instrumentation
    mT3ClearIntFlag(); // Clear Timer 3 interrupt flag
}

void __ISR( _INPUT_CAPTURE_5_VECTOR, ipl3) Capture5(void) 
{
static int i = 0; // static remembers value over time   
LATBINV = LEDD;   //Toggle LEDD on each input capture interrupt  
static unsigned int con_buf[4]; // Declare an input capture buffer.
// Declare three time capture variables:  
static unsigned short int t_new; // Most recent captured time 
static unsigned short int t_old = 0; // Previous time capture static 
unsigned short int time_diff; // Time between captures 

ReadCapture5(con_buf);  // Read captures into buffer

t_new = con_buf[0];   // Save time of event 
time_diff = t_new - t_old;  // Compute elapsed time in timer ?ticks? 
t_old = t_new;    // Replace previous time capture with new 

// Compute motor speed in RPS (revolutions per second) and save as global variable3

RPS = (float)10000000 / ((float)256 * (float)time_diff); // calc RPS

RPS_arr[i] = RPS;

i++; // i for RPS_arr

// circular buffer
if(i > 15)
{
    i = 0;
}

float sum = 0; // make sure to start it at zero
int j;

for(j=0;j<15;j++)
{
    sum = sum + RPS_arr[j];
}
// update the RPS average
RPS_Average = (sum/16);

mIC5ClearIntFlag();  
// Clears interrupt flag 
// INTClearFlag(INT_IC5); // Alternate peripheral library function 
}