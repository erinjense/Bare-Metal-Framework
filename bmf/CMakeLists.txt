cmake_minimum_required(VERSION 3.8)

set (SOURCES "src/gpio.c")
set (HEADERS "gpio.h")

add_library(
	bmf_lib OBJECT
	${SOURCES} ${HEADERS}
)

target_include_directories(bmf_lib PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")