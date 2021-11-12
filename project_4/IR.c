#include "CerebotMX7cK.h"
#include <plib.h>
#include "IR.h"

/* Setting Parameters for SMBus which are similar to I2C */
#define Fsck 100000
#define BRG_VAL ((FPB/2/Fsck)-2)
#define SLAVE_ADDRESS 0x5A
#define EEPROM_PAGE_LEN 64

void INIT_IRSENSOR() {
    // enable I2C peripheral number 1. That's the one that the IR sensor uses
    OpenI2C1(I2C_EN , BRG_VAL); // enable I2C peripheral for smbus
}

void IR_READ(int *SMBusdata) {
    
    // Create the SMBus Frame
    int SMBusframe[3];
    SMBusframe[0] = ((SLAVE_ADDRESS << 1) | 0); // 0 is write
    SMBusframe[1] = 0x07;
    SMBusframe[2] = ((SLAVE_ADDRESS << 1) | 1); // 1 is read

    int SMBusLSB = 0;
    int SMBusMSB = 0;
    int SMBusPEC = 0;
    
    // Initiate a Read from IR Sensor
    StartI2C1();
    IdleI2C1();
    
    // Send Slave address plus write bit
    MasterWriteI2C1(SMBusframe[0]);
    IdleI2C1();
    
    // Send command to read from RAM
    MasterWriteI2C1(SMBusframe[1]);
    IdleI2C1();
    
    // Send start condition again
    RestartI2C1();
    IdleI2C1();
 
    // Send Slave address plus read bit
    MasterWriteI2C1(SMBusframe[2]); // 1 is read
    
    // Read in LSB
    SMBusLSB = MasterReadI2C1();
    AckI2C1();
    IdleI2C1();
    
    // Read in MSB
    SMBusMSB = MasterReadI2C1();
    AckI2C1();
    IdleI2C1();
    
    // Read in PEC
    SMBusPEC = MasterReadI2C1();
    AckI2C1();
    IdleI2C1();
    
    // Issue STOP
    StopI2C1();
    IdleI2C1();
    
    SMBusdata[0] = SMBusLSB;
    SMBusdata[1] = SMBusMSB;
    SMBusdata[2] = SMBusPEC;
}
