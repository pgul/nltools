/* A CRC-16 CCITT checksum module */

#include <stdio.h>
#include <errno.h>
#include "crc16.h"
#include "ccitttab.h"

void crc16_init(unsigned short *crcptr)
{
    *crcptr = 0x0UL;
}
    
void crc16_process(unsigned short *crcptr, const unsigned char *buffer, size_t length)
{
    const unsigned char *ptr = buffer;
    size_t ctr;
    int k;
 
    for (ctr = 0; ctr < length; ctr++, ptr++)
    {
        *crcptr = (((*crcptr) << 8) ^
                    ccitt_table [ ((*crcptr) >> 8) ^ (*ptr) ]) & 0xFFFF;
    }
}

void crc16_finalize(unsigned short *crcptr)
{
}