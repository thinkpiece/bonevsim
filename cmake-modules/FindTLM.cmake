# ------------------------------------------------------------------------------
# FindTLM.cmake - to find SystemC TLM include dirs
# Copyright (c) 2015 Junyoung Park thinkpiece@yahoo.com
# ------------------------------------------------------------------------------
#
# Note that TLM is header-only library. No need to link libraries.
#
# Usage of this module as follows:
#
# find_package( TLM )
# if(TLM_FOUND)
#   include_directories(${TLM_INCLUDE_DIRS})
#   add_executable(test test.cc)
# endif()
#
# Variables defined by this module:
#
#  TLM_VERSION            The version number of the TLM that have been found,
#                         same as in tlm_version.h
#
#  TLM_MAJOR_VERSION      major version number of TLM
#  TLM_MINOR_VERSION      minor version number of TLM
#  TLM_PATCH_VERSION      patch version number of TLM
#
#  TLM_INCLUDE_DIRS       Full paths to all include dirs
#
# ------------------------------------------------------------------------------

message(STATUS "Searching for TLM")

SET(TLM_HINTS
  $ENV{TLM_ROOT}
  ${SYSTEMC_ROOT}/include
  ${SYSTEMC_ROOT}/lib
  ${SYSTEMC_ROOT}/lib-linux
  ${SYSTEMC_ROOT}/lib-linux64
  ${SYSTEMC_ROOT}/lib-macosx64
  $ENV{SYSTEMC_ROOT}/include
  $ENV{SYSTEMC_ROOT}/lib
  $ENV{SYSTEMC_ROOT}/lib-linux
  $ENV{SYSTEMC_ROOT}/lib-linux64
  $ENV{SYSTEMC_ROOT}/lib-macosx64
  )

SET(TLM_PATHS
  /usr/include/TLM
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
# Search for TLM
# ------------------------------------------------------------------------------

# Look for a standard SystemC header file.
if( NOT TLM_INCLUDE_DIR )
  find_path(TLM_INCLUDE_DIR
    NAMES tlm.h
    HINTS ${TLM_HINTS}
    PATHS ${TLM_PATHS}
  )
endif( NOT TLM_INCLUDE_DIR )

# ------------------------------------------------------------------------------
# Extract version information from tlm_version.h
# ------------------------------------------------------------------------------
if (TLM_INCLUDE_DIR)
  set(TLM_MAJOR_VERSION 0)
  set(TLM_MINOR_VERSION 0)
  set(TLM_PATCH_VERSION 0)
  set(TLM_VERSION "")
  file(READ "${TLM_INCLUDE_DIR}/tlm_core/tlm_2/tlm_version.h"
       TLM_VERSION_H_CONTENTS)

  string(REGEX REPLACE ".*#define TLM_VERSION_MAJOR[ \\t]*([0-9]).*" "\\1"
         TLM_MAJOR_VERSION "${TLM_VERSION_H_CONTENTS}")
  string(REGEX REPLACE ".*#define TLM_VERSION_MINOR[ \\t]*([0-9]).*" "\\1"
         TLM_MINOR_VERSION "${TLM_VERSION_H_CONTENTS}")
  string(REGEX REPLACE ".*#define TLM_VERSION_PATCH[ \\t]*([0-9]).*" "\\1"
         TLM_PATCH_VERSION "${TLM_VERSION_H_CONTENTS}")
  set(TLM_VERSION
    ${TLM_MAJOR_VERSION}.${TLM_MINOR_VERSION}.${TLM_PATCH_VERSION})
endif (TLM_INCLUDE_DIR)

set(TLM_FOUND FALSE)
if(TLM_INCLUDE_DIR)
  set(TLM_FOUND TRUE)
  set(TLM_INCLUDE_DIRS ${TLM_INCLUDE_DIR})
  message(STATUS "TLM version: ${TLM_VERSION}")
  message(STATUS "TLM include directory: ${TLM_INCLUDE_DIRS}")
endif(TLM_INCLUDE_DIR)
