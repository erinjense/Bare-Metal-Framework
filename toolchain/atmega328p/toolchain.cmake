###################################################
# Author: Nicolas Goy
# https://www.kuon.ch/post/2018-07-11-avr-cmake/
###################################################

cmake_minimum_required(VERSION 3.8)

set(F_CPU 16000000UL)
set(MCU atmega328p)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_CXX_COMPILER avr-g++)
set(CMAKE_C_COMPILER avr-gcc)
set(CMAKE_ASM_COMPILER avr-gcc)

add_definitions(
    -DF_CPU=${F_CPU}
    -DBAUD=${BAUD}
)

set(CMAKE_EXE_LINKER_FLAGS -mmcu=${MCU})

add_compile_options(
    -mmcu=${MCU}
    -Os
    -Wall
    -Wno-main
    -Wundef
    -pedantic
    -Werror
    -Wfatal-errors
    -Wl,--relax,--gc-sections
    -g
    -gdwarf-2
    -funsigned-char
    -funsigned-bitfields
    -fpack-struct
    -ffunction-sections
    -fdata-sections
    -fno-split-wide-types
    -fno-tree-scev-cprop
)
