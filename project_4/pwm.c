#include "CerebotMX7cK.h"
#include <plib.h>
#include "pwm.h"

#define OC_config_bits (OC_ON | OC_TIMER_MODE16 | OC_TIMER2_SRC | OC_PWM_FAULT_PIN_DISABLE)
#define T2_PRESCALE 1

int pwm_init(int DutyCycle, int CycleFrequency)
{
    
    // Fix this 11/12 Init is wrong look at lab stuff
    mOC3ClearIntFlag();
    OpenTimer2((T2_ON | T2_PS_1_1 |T2_SOURCE_INT), ((FPB/T2_PRESCALE/CycleFrequency) - 1));
    // set up the timer interrupt with a priority of 2, sub priority 0
    mT2SetIntPriority(2); // Group priority range: 1 to 7
    mT2SetIntSubPriority(0); // Subgroup priority range: 0 to 3
    mT2IntEnable(1); // Enable T2 interrupts
    /* PWM_CYCLE_COUNT = PBCLK / (T2_PRESCALE * PWM_CYCLE_FREQUENCY)   (1) 
     * PR2 = PWM_CYCLE_COUNT ? 1           (2) 
     * The second parameter, PWM_DUTY_CYCLE, is a value between zero and 100. 
     * The duty cycle of the PWM output is determined by the ratio of the value 
     * written to the output compare register, OC3RS, 
     * to the value of the Timer 2 period register, PR2, as shown in Eq. 3. 
     * OC3RS = (PWM_DUTY_CYCLE * (PR2+1) / 100)      (3) */
    
    OpenOC3(OC_config_bits,(FPB/(T2_PRESCALE*CycleFrequency)),(FPB/(T2_PRESCALE*CycleFrequency))); 
}

// fix this look at lab handout
int pwm_set(int DutyCycle)
{
   
   SetDCOC3PWM(DutyCycle*((PR2+1)/100)); 
}

void __ISR(_TIMER_2_VECTOR, IPL2) Timer2Handler(void)
{
    /* User generated code to service the interrupt is inserted here */
    LATBINV = LEDA; // Toggle LEDA
   
    mT2ClearIntFlag(); // Macro function to clear the interrupt flag
}

void Timer2_delay(int delay)
{
    while(delay--)
    {
        while(!mT2GetIntFlag()); // Wait for interrupt flag to be set
        mT2ClearIntFlag(); // Clear the interrupt flag
    }
}

