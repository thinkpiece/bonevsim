BONE-V Simulator
=================

BONE-V network-cycle-accurate (NCA) simulator is designed to explore the architectural tradeoffs and deliver the optimal network architecture for BONE-V processor. BONE-V is the codename for a vision processor, which is developed by KAIST Semiconductor System Laboratory (SSL) and it stands for Basic On-chip NEtwork for Vision application. The simulator is written in C/C++ and mainly based on SystemC. It consists of Loosely-timed core models and Approximately-timed Network-on-Chip (NoC) models.


Prerequisites
-------------

This simulator requires additional libraries described below

### SystemC with TLM library
  Necessary for the approximately/loosely-timed simulation. You muse set the
  environment variable, **SYSTEMC_ROOT**, so that the system can find SystemC,
  TLM properly. Alternatively, the -DSYSTEMC_ROOT=/path/to/systemc option
  should be used with cmake command. The recommended version is SystemC 2.3.1
  or newer, and TLM 2.0.3 or newer

### Boost
  The environment variable, **BOOST_ROOT**, is required to build mVPU
  simulator. Alternatively, the -DBOOST_ROOT=/path/to/boost option should be
  used with cmake command. The recommended version is 1.5.6 or newer.

### OpenCV


Coding Style
------------

The typical conventions look something like this:

* variable_names_in_snake_case : Variable, a mutable thing. All lower case, words separated by underscores.

* CONSTANTS_IN_ALL_CAPS : Constant, an immutable thing. All upper case, words separated by underscores.

* functionAndMethodNames : Functions and methods, immutable and callable things. Mixed camel case, first letter always lower case.

* StructAndClassNames : Structs and classes, immutable and instantiatable things. Mixed camel case, first letter always upper case.

* systemc_tlm_function : The SystemC TLM essential functions are all lowercase, with underscores between
words.


Directories
-----------

  +- include/       - Fundamental header files
  +- noc/           - Approximately-timed NoC model 
  +- target/        - executable use cases
  | +- tile-sift/   - Visual attention based tile-SIFT (BONE-V S/W) in BV6
  | +- mesh/        - Mesh variation of BV6
  | +- ring/        - Ring variation of BV6
  | +- BV3/         - H-Star + Ring NoC combining 16 homogeneous SPUs 
  | +- BV4/         - H-Star + Ring NoC heterogeneous clusters
  +- misc/          - Simulation monitor, etc
  +- cmake-modules/ - CMake module extension

SystemC & TLM
-------------

*SystemC* was developed to provide features that facilitate hardware modleing,
particulary the parallelism of hardware, in C/C++, the mainstream programming
lanuage.
