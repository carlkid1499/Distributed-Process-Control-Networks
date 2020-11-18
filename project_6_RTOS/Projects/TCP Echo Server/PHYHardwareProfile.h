/*  FreeRtos + TCP Reference Design TCP Echo Server
 * Project:     TCP Echo Server
 * File name:   PHYHardwareProfile.h
 * Author:      Aaron Ludwig
 * Date:        November 14, 2019
 *
 * Description: File contains specific definitions for the Cerebot's PHY chip.
 *
 * NOTES:       This file is a revised version of a similar file from a project 
 *              on GitHub from user jjr-simiatec called "FreeRTOS-TCP-for-PIC32"
 *              using commit 11bee9b5f2a5a21b6311feca873286e4c7be3534 from the 
 *              master branch. This project can be found at the following url:
 *              https://github.com/jjr-simiatec/FreeRTOS-TCP-for-PIC32/commit/11bee9b5f2a5a21b6311feca873286e4c7be3534
 *******************************************************************************/

#ifndef PHY_HARDWARE_PROFILE_H
#define PHY_HARDWARE_PROFILE_H

#define ipconfigPIC32_PHY_DRIVER                PIC32_PHY_DRIVER_DP83848

#define	PHY_RMII	/* external PHY runs in RMII mode */

#define ipconfigPIC32_PHY_ADDRESS               0 /* The logical address of the SMC LAN8720 PHY */

#define ipconfigPIC32_PHY_ASSERT_HW_RESET()
#define ipconfigPIC32_PHY_CLEAR_HW_RESET()
#define ipconfigPIC32_PHY_ENABLE_INTERRUPT()    IEC0SET = _IEC0_INT3IE_MASK
#define ipconfigPIC32_PHY_DISABLE_INTERRUPT()   IEC0CLR = _IEC0_INT3IE_MASK
#define ipconfigPIC32_PHY_CLEAR_INTERRUPT()     IFS0CLR = _IFS0_INT3IF_MASK

#define ipconfigPIC32_PHY_INTERRUPT_VECTOR      _EXTERNAL_3_VECTOR

#endif