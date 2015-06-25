# ------------------------------------------------------------------------------
# FindSystemC.cmake - to find SystemC include dirs and libraries
# Copyright (c) 2015 Junyoung Park thinkpiece@yahoo.com
# ------------------------------------------------------------------------------
#
# Usage of this module as follows:
#
# find_pakcage( SystemC )
# if(SystemC_FOUND)
#   include_directories(${SystemC_INCLUDE_DIRS})
#   add_executable(test test.cc)
#   target_link_libraries(test ${SystemC_LIBRARIES})
# endif()
#
# Variables defined by this module:
#
#  SystemC_VERSION            The version number of the SystemC libraries that
#                             have been found, same as in sc_ver.h from SystemC
#
#  SystemC_MAJOR_VERSION      major version number of SystemC
#  SystemC_MINOR_VERSION      minor version number of SystemC
#  SystemC_PATCH_VERSION      patch version number of SystemC
#
#  SystemC_INCLUDE_DIRS       Full paths to all include dirs.
#  SystemC_LIBRARIES          Full paths to all libraries.
#
# ------------------------------------------------------------------------------

message(STATUS "Searching for SystemC")

set(SYSTEMC_HINTS
  ${SYSTEMC_ROOT}/include
  ${SYSTEMC_ROOT}/lib
  ${SYSTEMC_ROOT}/lib-linux
  ${SYSTEMC_ROOT}/lib-linux64
  ${SYSTEMC_ROOT}/lib-macos
  ${SYSTEMC_ROOT}/lib-macosx64
  $ENV{SYSTEMC_ROOT}/include
  $ENV{SYSTEMC_ROOT}/lib
  $ENV{SYSTEMC_ROOT}/lib-linux
  $ENV{SYSTEMC_ROOT}/lib-linux64
  $ENV{SYSTEMC_ROOT}/lib-macos
  $ENV{SYSTEMC_ROOT}/lib-macosx64
  )

set(SYSTEMC_PATHS
  /usr/include/systemc
  /usr/lib
  /usr/lib-linux
  /usr/lib-linux64
  /usr/lib-macos
  /usr/lib-macosx64
  /usr/local/lib
  /usr/local/lib-linux
  /usr/local/lib-linux64
  /usr/local/lib-macos
  /usr/local/lib-macosx64
  )

# ------------------------------------------------------------------------------
# Search for SystemC
# ------------------------------------------------------------------------------

# Look for a standard SystemC header file.
if( NOT SystemC_INCLUDE_DIR )
  find_path(SystemC_INCLUDE_DIR
    NAMES systemc.h
    HINTS ${SYSTEMC_HINTS}
    PATHS ${SYSTEMC_PATHS}
  )
endif( NOT SystemC_INCLUDE_DIR )

# Look for a standard SystemC library file.
if( NOT SystemC_LIBRARY_DIR )
  find_path(SystemC_LIBRARY_DIR
    NAMES libsystemc.a
    HINTS ${SYSTEMC_HINTS}
    PATHS ${SYSTEMC_PATHS}
  )
endif( NOT SystemC_LIBRARY_DIR )

# ------------------------------------------------------------------------------
# Extract version information from sc_ver.h
# ------------------------------------------------------------------------------
if (SystemC_INCLUDE_DIR)
  # Extract SystemC_VERSION from sc_ver.h
  set(SystemC_MAJOR_VERSION 0)
  set(SystemC_MINOR_VERSION 0)
  set(SystemC_PATCH_VERSION 0)
  set(SystemC_VERSION "")
  file(READ "${SystemC_INCLUDE_DIR}/sysc/kernel/sc_ver.h"
       SYSTEMC_VERSION_H_CONTENTS)

  string(REGEX REPLACE ".*#define SC_VERSION_MAJOR[ \\t]*([0-9]).*" "\\1"
         SystemC_MAJOR_VERSION "${SYSTEMC_VERSION_H_CONTENTS}")
  string(REGEX REPLACE ".*#define SC_VERSION_MINOR[ \\t]*([0-9]).*" "\\1"
         SystemC_MINOR_VERSION "${SYSTEMC_VERSION_H_CONTENTS}")
  string(REGEX REPLACE ".*#define SC_VERSION_PATCH[ \\t]*([0-9]).*" "\\1"
         SystemC_PATCH_VERSION "${SYSTEMC_VERSION_H_CONTENTS}")
  set(SystemC_VERSION
    ${SystemC_MAJOR_VERSION}.${SystemC_MINOR_VERSION}.${SystemC_PATCH_VERSION})
endif (SystemC_INCLUDE_DIR)

set(SystemC_FOUND FALSE)

if("${SystemC_MAJOR_VERSION}" MATCHES "2")
  set(SystemC_FOUND TRUE)
endif("${SystemC_MAJOR_VERSION}" MATCHES "2")

# ------------------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------------------
if (SystemC_FOUND)
  set(SystemC_LIBRARIES ${SystemC_LIBRARY_DIR}/libsystemc.a)
  set(SystemC_INCLUDE_DIRS ${SystemC_INCLUDE_DIR})
  message(STATUS "SystemC version: ${SystemC_VERSION}")
  message(STATUS "SystemC library: ${SystemC_LIBRARIES}")
  message(STATUS "SystemC include directories: ${SystemC_INCLUDE_DIRS}")
  message(STATUS "SystemC library directories: ${SystemC_LIBRARY_DIR}")
endif(SystemC_FOUND)
