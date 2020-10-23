cmake_minimum_required (VERSION 3.8)

project ("BMF-Tests")

add_executable (test_gpio "test_gpio.c")
target_sources (test_gpio PRIVATE "test_gpio.c")

target_link_libraries(test_gpio PUBLIC bmf_lib)
target_include_directories(test_gpio PRIVATE ${CMAKE_SOURCE_DIR})

add_test(NAME test_gpio COMMAND test_gpio)

if (CPU_FLASH)
	set (TEST_EXECUTABLE "test_gpio")
	include ("${CMAKE_SOURCE_DIR}/toolchain/${CPU}/flash.cmake")
endif()
