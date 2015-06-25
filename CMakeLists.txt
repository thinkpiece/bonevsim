# -----------------------------------------------------------------------------
# CMakeLists.txt - root CMake configuration file for BONE-V simulator
# Copyright (c) 2010-2015 Junyoung Park (thinkpiece@yahoo.com)
# -----------------------------------------------------------------------------

cmake_minimum_required(VERSION 2.8)

# PROJECT INFORMATION ---------------------------------------------------------

# project name
project(BONEVSIM)

# project version control
set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_VERSION_MINOR 1)
set(PROJECT_VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR})

# project configuration header
configure_file (
  "${PROJECT_SOURCE_DIR}/config.h.in"
  "${PROJECT_SOURCE_DIR}/config.h"
)

include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/include)

# LIBRARY CHECK  --------------------------------------------------------------
#   vCF simulator requires SystemC, TLM, Boost, Thread libraries

# to add find_package modules for SystemC, TLM
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake-modules)

# check SystemC - version > 2.0
find_package(SystemC)

if(SystemC_FOUND)
  include_directories(${SystemC_INCLUDE_DIRS})
else(SystemC_FOUND)
  message(FATAL_ERROR "SystemC libary not found")
endif(SystemC_FOUND)

# check TLM - header only libraries
find_package(TLM)
if(TLM_FOUND)
  include_directories(${TLM_INCLUDE_DIRS})
else(TLM_FOUND)
  message(FATAL_ERROR "TLM library not found")
endif(TLM_FOUND)

# check Threads - SystemC use thread programming
find_package(Threads)

# check Boost
find_package(Boost 1.53 COMPONENTS timer system REQUIRED)
if(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  link_directories(${Boost_LIBRARY_DIRS})
endif(Boost_FOUND)

# SUBDIRECTORIES --------------------------------------------------------------
#   see also README.md

add_subdirectory(src)
