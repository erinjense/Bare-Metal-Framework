cmake_minimum_required (VERSION 3.8)

option (ATMEGA328P "Compile code for the ATmega328p." ON)
option (CPU_FLASH  "Uploading code." ON)

if (ATMEGA328P)
	set (CPU "atmega328p")
endif()

if (CPU)
	set(CMAKE_TOOLCHAIN_FILE "toolchain/${CPU}/toolchain.cmake")
endif()

project ("Bare-Metal-Framework")

include(CheckLibraryExists)
include(GNUInstallDirs)
include(CTest)

add_subdirectory ("bmf")
enable_testing ()
add_subdirectory ("tests")
