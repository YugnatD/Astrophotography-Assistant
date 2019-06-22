/*===========================================================================*=
	Slave_Telescope - Smbus - Tanguy Dietrich
  =============================================================================
   Descriptif: 

=*===========================================================================*/

#define  SYSCLK         48000000       // System clock frequency in Hz

#define  SMB_FREQUENCY  10000          // gTarget SCL clock rate
                                       // This example supports between 10kHz
                                       // and 100kHz

#define  WRITE          0x00           // SMBus WRITE command
#define  READ           0x01           // SMBus READ command

// Device addresses (7 bits, lsb is a don't care)
#define  SLAVE_ADDR     0x40           // Device address for slave gTarget
#define  MCP23008_ADDR  0x40           // GPIO Extander address
#define  MCP9800_ADDR   0x92           // Temperature Sensor address

// Device MCP23008 Register
#define  MCP23008_IODIR 0x00
#define  MCP23008_IOPOL 0x01
#define  MCP23008_GPIO  0x09

// Device MCP9800 Register
#define  MCP9800_POINTER_TO_REG_TA     0x00
#define  MCP9800_POINTER_TO_REG_CONF   0x01


// Status vector - top 4 bits only
#define  SMB_MTSTA      0xE0           // (MT) start transmitted
#define  SMB_MTDB       0xC0           // (MT) data byte transmitted
#define  SMB_MRDB       0x80           // (MR) data byte received
// End status vector definition

#define  NUM_BYTES_MAX_WR   6          // Number of bytes to write
                                       // Master -> Slave
#define  NUM_BYTES_MAX_RD   6          // Number of bytes to read
                                       // Master <- Slave