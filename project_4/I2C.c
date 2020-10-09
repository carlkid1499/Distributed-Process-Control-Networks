#include "CerebotMX7cK.h"
#include <plib.h>
#include "I2C.h"

/* Setting Parameters for SMBus which are similar to I2C */
#define Fsck 100000
#define BRG_VAL ((FPB/2/Fsck)-2)
#define SLAVE_ADDRESS 0x5A
#define EEPROM_PAGE_LEN 64

void INIT_IRSENSOR() {
    // enable I2C peripheral number 1. That's the one that the IR sensor uses
    OpenI2C1(I2C_SM_EN, BRG_VAL); // enable I2C peripheral
}

void INIT_EEPROM() {
    // enable I2C peripheral number 2. That's the one used by EEPROM
    OpenI2C2(I2C_EN, BRG_VAL); // enable I2C peripheral
}

int IR_READ(int ram_addr, char *SMBusdata, int len) {
    
    // Split ram address
    int MSB_temp_addr = ram_addr;
    int LSB_temp_addr = ram_addr;
    // Do some bit shifting
    MSB_temp_addr = ((MSB_temp_addr >> 8) & (0x7F)); // 0x7F = 111 1111
    LSB_temp_addr = (LSB_temp_addr & 0xFF); // 0xFF = 1111 1111
    
    // Create the SMBus address
    char SMBusframe[3];
    SMBusframe[0] = ((SLAVE_ADDRESS << 1) | 0); // 0 is write
    SMBusframe[1] = MSB_temp_addr;
    SMBusframe[2] = LSB_temp_addr;

    // Initiate a Read from  EEPROM
    int datasz = len;
    char SMBusbyte = 0;
    int index = 0;
    StartI2C1();
    IdleI2C1();
    // Send Slave address, plus read bit, and RAM Address
    MasterWriteI2C1(SMBusframe[0]);
    AckI2C1();
    MasterWriteI2C1(SMBusframe[1]);
    AckI2C1();
    MasterWriteI2C1(SMBusframe[2]);
    AckI2C1();
    RestartI2C1();    

    // Reset the index
    index = 0;
    MasterWriteI2C1((SLAVE_ADDRESS << 1) | 1); // 1 is read
    AckI2C1();
    while (datasz - 1) {
        SMBusbyte = MasterReadI2C1();
        SMBusdata[index++] = SMBusbyte;
        AckI2C1();
        datasz--;
    }
    SMBusbyte = MasterReadI2C1();
    SMBusdata[index++] = SMBusbyte;

    StopI2C1();
    IdleI2C1();
}

int EEPROM_READ(int mem_addr, char *i2cdata, int len) {
    /* 
     * - Read len bytes from the EEPROM starting from EEPROM memory address mem addr into the
     * buffer pointed to by i2cdata.
     * - Return zero on success or a non-zero value if there is an error. Examples of errors might include
     * an invalid memory address passed into the function, a NULL pointer for i2cData, an invalid len
     * argument, or an I2C bus error. Each error you handle should return a different non-zero value.
     * - The function will not return until either len bytes were read into i2cData or there was error.
     */
    // Create I2C Frame
    int MSB_temp_addr = mem_addr;
    int LSB_temp_addr = mem_addr;
    // Do some bit shifting
    MSB_temp_addr = ((MSB_temp_addr >> 8) & (0x7F)); // 0x7F = 111 1111
    LSB_temp_addr = (LSB_temp_addr & 0xFF); // 0xFF = 1111 1111 
    char i2cframe[3];
    i2cframe[0] = ((SLAVE_ADDRESS << 1) | 0); // 0 is write
    i2cframe[1] = MSB_temp_addr; // Memory Address MSB 7 bits long 0 - 6
    i2cframe[2] = LSB_temp_addr; //  Memory Address LSB 8 bits long 0 - 7

    // Initiate a Read from  EEPROM
    int datasz = len;
    int framelen = 3;
    char i2cbyte = 0;
    int index = 0;
    StartI2C2();
    IdleI2C2();
    while (framelen--) // Send Control Byte and Memory Address
        MasterWriteI2C2(i2cframe[index++]); // didn't check for ACK

    index = 0;
    RestartI2C2(); // Reverse I2C Bus direction
    IdleI2C2();
    MasterWriteI2C2((SLAVE_ADDRESS << 1) | 1);
    while (datasz - 1) {
        i2cbyte = MasterReadI2C2();
        i2cdata[index++] = i2cbyte;
        AckI2C2(); // ack after each byte you read
        IdleI2C2();
        datasz--;
    }
    i2cbyte = MasterReadI2C2();
    i2cdata[index++] = i2cbyte;

    NotAckI2C2(); // End read with a NACK
    IdleI2C2();
    StopI2C2();
    IdleI2C2();
}

int EEPROM_WRITE(int mem_addr, char *i2cdata, int len) {
    /*
     * -Write len bytes into the EEPROM starting at memory address mem addr from the buffer i2cData.
     * -The function should not return until either the write is complete or an error has occurred1
     * . See the eeprom read specification for examples of errors.
     */
    // Create I2C Frame
    int MSB_temp_addr = mem_addr;
    int LSB_temp_addr = mem_addr;
    // Do some bit shifting
    MSB_temp_addr = ((MSB_temp_addr >> 8) & (0x7F)); // 0x7F = 111 1111
    LSB_temp_addr = (LSB_temp_addr & 0xFF); // 0xFF = 1111 1111 

    char i2cframe[3];
    i2cframe[0] = ((SLAVE_ADDRESS << 1) | 0); // 0 is write
    i2cframe[1] = MSB_temp_addr; // Memory Address MSB 7 bits long 0 - 6
    i2cframe[2] = LSB_temp_addr; //  Memory Address LSB 8 bits long 0 - 7

    int datasz = len;
    int framelen = 3;
    int index = 0;
    int write_err = 0;
    // Send I2C Frame to EEPROM
    StartI2C2(); // non-blocking
    IdleI2C2(); // blocking

    while (framelen--)
        write_err |= MasterWriteI2C2(i2cframe[index++]);

    index = 0;

    while (datasz--) {
        // increment mem_addr pointer
        mem_addr++;
        // write the data first
        write_err |= MasterWriteI2C2(i2cdata[index++]);
        // check for page boundary 
        if ((mem_addr % EEPROM_PAGE_LEN) == 0) {
            framelen = 3;
            int index_page = 0;
            StopI2C2();
            IdleI2C2();
            // wait for transfer
            EEPROM_POLL();
            //set new location in frame
            i2cframe[0] = ((SLAVE_ADDRESS << 1) | 0); // 0 is write
            i2cframe[1] = ((mem_addr >> 8) & (0x7F)); // 0x7F = 111 1111
            i2cframe[2] = (mem_addr & 0xFF); // 0xFF = 1111 1111
            //send new location
            StartI2C2(); // non-blocking
            IdleI2C2(); // blocking
            while (framelen--)
                write_err |= MasterWriteI2C2(i2cframe[index_page++]);

            IdleI2C2();
        }
    }
    StopI2C2();
    IdleI2C2();

    // Technically, main() should never return anything, but ...
    if (write_err) return (-1); // Some problem during write

    EEPROM_POLL();
}

void EEPROM_POLL() {
    // Poll EEPROM for Write Completion
    StartI2C2();
    IdleI2C2();
    while (MasterWriteI2C2((SLAVE_ADDRESS << 1) | 0)) {
        RestartI2C2(); // try restart instead of stop if no ack
        IdleI2C2();
    }
}

