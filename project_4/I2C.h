#ifndef __I2C_H__
    #define __I2C_H__
#endif

void INIT_EEPROM(); // initialize I2C resources
void INIT_IRSENSOR(); // initialize I2C resources
int IR_READ(int ram_addr, char *SMBusdata, int len);
int EEPROM_READ(int mem_addr, char *i2cdata, int len); // funtion to read data from  EEPROM
int EEPROM_WRITE(int mem_addr, char *i2cdata, int len); // funtion to write data to EEPROM
void EEPROM_POLL(); // poll for completion