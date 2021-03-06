# get glibc version for use in CPACK_*_XRT_PACKAGE_DEPENDS
# source: https://gist.github.com/likema/f5c04dad837d2f5068ae7a8860c180e7
execute_process(
    COMMAND ${CMAKE_C_COMPILER} -print-file-name=libc.so.6
    OUTPUT_VARIABLE GLIBC
    OUTPUT_STRIP_TRAILING_WHITESPACE)
if (DEFINED CROSS_COMPILE)
    execute_process(
	COMMAND find ${sysroot} -iname libc.so.6
	OUTPUT_VARIABLE GLIBC
	OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()
get_filename_component(GLIBC ${GLIBC} REALPATH)
get_filename_component(GLIBC_VERSION ${GLIBC} NAME)
string(REPLACE "libc-" "" GLIBC_VERSION ${GLIBC_VERSION})
string(REPLACE ".so" "" GLIBC_VERSION ${GLIBC_VERSION})
if(NOT GLIBC_VERSION MATCHES "^[0-9.]+$")
    message(FATAL_ERROR "Unknown glibc version: ${GLIBC_VERSION}")
endif(NOT GLIBC_VERSION MATCHES "^[0-9.]+$")

# Logic to get a version one greater than installed
string(REPLACE "." ";" GLIBC_VERSION_LIST ${GLIBC_VERSION})
list(GET GLIBC_VERSION_LIST 0 GLIBC_VERSION_MAJOR)
list(GET GLIBC_VERSION_LIST 1 GLIBC_VERSION_MINOR)
SET(GLIBC_MINOR_VERSION_ONEGREATER "${GLIBC_VERSION_MINOR}")
MATH(EXPR GLIBC_MINOR_VERSION_ONEGREATER "1 + ${GLIBC_VERSION_MINOR}")
SET(GLIBC_VERSION_ONEGREATER "${GLIBC_VERSION_MAJOR}.${GLIBC_MINOR_VERSION_ONEGREATER}")

