###################################################
# Author: Nicolas Goy
# https://www.kuon.ch/post/2018-07-11-avr-cmake/
###################################################

cmake_minimum_required(VERSION 3.8)

# Default Baudrate for UART, read avr include/util/setbaud.h for usage
set(BAUD 9600)
# The programmer to use, read avrdude manual for list
set(PROG_TYPE usbtiny)

set(E_FUSE 0xfd)
set(H_FUSE 0xda)
set(L_FUSE 0xfd)
set(LOCK_BIT 0xff)

# Rename the output to .elf as we will create multiple files
set_target_properties(${TEST_EXECUTABLE} PROPERTIES OUTPUT_NAME ${TEST_EXECUTABLE}.elf)

add_custom_target(upload DEPENDS ${TEST_EXECUTABLE})

# Strip binary for upload
add_custom_command(TARGET upload USES_TERMINAL COMMAND 
	avr-strip ${TEST_EXECUTABLE}.elf)

# Transform binary into hex file, we ignore the eeprom segments in the step
add_custom_command(TARGET upload USES_TERMINAL COMMAND avr-objcopy -R .eeprom -O ihex ${TEST_EXECUTABLE}.elf ${TEST_EXECUTABLE}.hex)

add_custom_command(TARGET upload USES_TERMINAL COMMAND 
	avr-objcopy -j .eeprom  --set-section-flags=.eeprom="alloc,load"  --change-section-lma .eeprom=0 -O ihex ${TEST_EXECUTABLE}.elf ${TEST_EXECUTABLE}.eep)

# Upload the firmware with avrdude
add_custom_command(TARGET upload USES_TERMINAL COMMAND 
	avrdude  -c ${PROG_TYPE} -p ${MCU} -U flash:w:${TEST_EXECUTABLE}.hex)

# Upload the eeprom with avrdude
add_custom_command(TARGET upload USES_TERMINAL COMMAND 
	avrdude -c ${PROG_TYPE} -p ${MCU}  -U eeprom:w:${TEST_EXECUTABLE}.eep DEPENDS eeprom)

# Burn fuses
add_custom_command(TARGET upload USES_TERMINAL COMMAND 
	avrdude -c ${PROG_TYPE} -p ${MCU}  -U lfuse:w:${L_FUSE}:m -U hfuse:w:${H_FUSE}:m -U efuse:w:${E_FUSE}:m -U lock:w:${LOCK_BIT}:m )

# Clean extra files
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${TEST_EXECUTABLE}.hex;${TEST_EXECUTABLE}.eeprom;${TEST_EXECUTABLE}.lst")
