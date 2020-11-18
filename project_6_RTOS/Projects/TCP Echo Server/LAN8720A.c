/*  FreeRtos + TCP Reference Design TCP Echo Server
 * Project:     TCP Echo Server
 * File name:   LAN8720A.c
 * Author:      Aaron Ludwig
 * Date:        November 14, 2019
 *
 * Description: File contains functionality for manipulating the Cerebot's PHY chip.
 *
 * NOTES:       This file is a revised version of a similar file from a project 
 *              on GitHub from user jjr-simiatec called "FreeRTOS-TCP-for-PIC32"
 *              using commit 11bee9b5f2a5a21b6311feca873286e4c7be3534 from the 
 *              master branch. This project can be found at the following url:
 *              https://github.com/jjr-simiatec/FreeRTOS-TCP-for-PIC32/commit/11bee9b5f2a5a21b6311feca873286e4c7be3534
 *******************************************************************************/

// RTOS
#include <FreeRTOS.h>
#include <task.h>
#include <semphr.h>
// TCP/IP Stack
#include <FreeRTOS_IP.h>
#include <FreeRTOS_IP_Private.h>
// C Runtime
#include <stdint.h>
#include <stdbool.h>

#include "Ethernet.h"
#include "PHYGeneric.h"
#include "EthernetPrivate.h"
#include "PIC32Arch.h"

#include "ETHPIC32ExtPhy.h"
#include "ETHPIC32ExtPhyRegs.h"

#include "chipKIT_PRO_MX7.h"

void PHYInitialise(void)
{
    EthInit();
    eEthPhyCfgFlags	hwFlags, swFlags;
    hwFlags=EthPhyGetHwConfigFlags();
 
    EthMIIMConfig(GetSystemClock(), 2500000); //2.5 MHz max clock supported
    while(!_PhyDetectReset());
}

void PHYGetStatus(phy_status_t *pStatus)
{
    __BMCONbits_t bmcon;
    unsigned int	tStart, tWaitReset;

    bmcon.w =_PhyReadReg(PHY_REG_BMCON, ipconfigPIC32_PHY_ADDRESS);

    pStatus->speed = bmcon.SPEED ? PHY_SPEED_100MBPS : PHY_SPEED_10MBPS;
    pStatus->fullDuplex = bmcon.DUPLEX != 0;
}

bool PHYSupportsWOL(void)
{
    return false;
}