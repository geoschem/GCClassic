# GCClassic high-level CMakeLists.txt

cmake_minimum_required (VERSION 3.13)
project (geos-chem-classic
  VERSION 13.0.2
  LANGUAGES Fortran
)

#-----------------------------------------------------------------------------
# Set CMake policies.  For more information, see:
#
# https://cmake.org/cmake/help/latest/policy/CMP0054.html
# https://cmake.org/cmake/help/latest/policy/CMP0057.html
# https://cmake.org/cmake/help/latest/policy/CMP0074.html
# https://cmake.org/cmake/help/latest/policy/CMP0079.html
#-----------------------------------------------------------------------------
cmake_policy(SET CMP0054 NEW)
cmake_policy(SET CMP0057 NEW)
if(POLICY CMP0074)
  cmake_policy(SET CMP0074 NEW)
endif()
if(POLICY CMP0079)
  cmake_policy(SET CMP0079 NEW)
endif()

#-----------------------------------------------------------------------------
# Add CMakeScripts/ to the module path and import helper functions
#-----------------------------------------------------------------------------
list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_CURRENT_SOURCE_DIR}/CMakeScripts)
include(GC-Helpers)

#-----------------------------------------------------------------------------
# Print header with the CMake project version and the GC repo version
#-----------------------------------------------------------------------------
get_repo_version(GC_REPO_VERSION ${CMAKE_CURRENT_SOURCE_DIR})
message("=================================================================")
message("GCClassic ${PROJECT_VERSION} (superproject wrapper)")
message("Current status: ${GC_REPO_VERSION}")
message("=================================================================")

#-----------------------------------------------------------------------------
# Declare the GEOSChemBuildProperties
#
# All GEOS-Chem targets depend on this. This is used to control
# the compiler options and definitions for GEOS-Chem targets
# (via inheritance).
#-----------------------------------------------------------------------------
add_library(GEOSChemBuildProperties INTERFACE)

set(GEOSChem_DETECTED_FORTRAN_COMPILER_ID ${CMAKE_Fortran_COMPILER_ID}
    CACHE INTERNAL "Logging the COMPILER_ID to CMakeCache.txt"
)
set(GEOSChem_DETECTED_FORTRAN_COMPILER_VERSION ${CMAKE_Fortran_COMPILER_VERSION}
    CACHE INTERNAL "Logging the compiler version to CMakeCache.txt"
)

set(GEOSChem_Fortran_FLAGS_Intel
    -cpp -w -auto -noalign "SHELL:-convert big_endian" "SHELL:-fp-model source"
    -mcmodel=medium -shared-intel -traceback -DLINUX_IFORT
    CACHE STRING "GEOSChem compiler flags for all build types with Intel compilers"
)
set(GEOSChem_Fortran_FLAGS_RELEASE_Intel
   -O2
    CACHE STRING "GEOSChem compiler flags for build type release with Intel compilers"
)
set(GEOSChem_Fortran_FLAGS_RELWITHDEBINFO_Intel
    -O2
    CACHE STRING "GEOSChem compiler flags for build type relwithdebinfo with Intel compilers"
)
set(GEOSChem_Fortran_FLAGS_DEBUG_Intel
    -g -O0 "SHELL:-check arg_temp_created" "SHELL:-debug all" -fpe0 -ftrapuv -check,bounds
    CACHE STRING "GEOSChem compiler flags for build type debug with Intel compilers"
)

set(GEOSChem_Fortran_FLAGS_GNU
    -cpp -w -std=legacy -fautomatic -fno-align-commons
    -fconvert=big-endian -fno-range-check -mcmodel=medium
    -fbacktrace -g -DLINUX_GFORTRAN -ffree-line-length-none
    CACHE STRING "GEOSChem compiler flags for all build types with GNU compilers"
)
set(GEOSChem_Fortran_FLAGS_RELEASE_GNU
   -O3 -funroll-loops
   CACHE STRING "GEOSChem compiler flags for build type release with GNU compilers"
)
set(GEOSChem_Fortran_FLAGS_RELWITHDEBINFO_GNU
   -O3 -funroll-loops
   CACHE STRING "GEOSChem compiler flags for build type relwithdebinfo with GNU compilers"
)
set(GEOSChem_Fortran_FLAGS_DEBUG_GNU
    -g -gdwarf-2 -gstrict-dwarf -O0 -Wall -Wextra -Wconversion -Warray-temporaries
    -fcheck=array-temps -ffpe-trap=invalid,zero,overflow -finit-real=snan
    -fcheck=bounds -fcheck=pointer
    CACHE STRING "GEOSChem compiler flags for build type debug with GNU compilers"
)

set(GEOSChem_SUPPORTED_COMPILER_IDS "Intel" "GNU")
if(NOT CMAKE_Fortran_COMPILER_ID IN_LIST GEOSChem_SUPPORTED_COMPILER_IDS)
   message(FATAL_ERROR "GEOSChem does not support ${CMAKE_Fortran_COMPILER_ID} compilers")
endif()

#---------------------------------------------------------------------
# Assign comiler options to build properties
#---------------------------------------------------------------------
target_compile_options(GEOSChemBuildProperties
   INTERFACE
   $<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:
      ${GEOSChem_Fortran_FLAGS_Intel}
      $<$<CONFIG:Debug>:${GEOSChem_Fortran_FLAGS_DEBUG_Intel}>
      $<$<CONFIG:RelWithDebInfo>:${GEOSChem_Fortran_FLAGS_RELWITHDEBINFO_Intel}>
      $<$<CONFIG:Release>:${GEOSChem_Fortran_FLAGS_RELEASE_Intel}>
   >
   $<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>:
      ${GEOSChem_Fortran_FLAGS_GNU}
      $<$<CONFIG:Debug>:${GEOSChem_Fortran_FLAGS_DEBUG_GNU}>
      $<$<CONFIG:RelWithDebInfo>:${GEOSChem_Fortran_FLAGS_RELWITHDEBINFO_GNU}>
      $<$<CONFIG:Release>:${GEOSChem_Fortran_FLAGS_RELEASE_GNU}>
   >
)

#-----------------------------------------------------------------------------
# Put all of GEOS-Chem's mod files in build subdir called mod
#-----------------------------------------------------------------------------
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(GEOSChemBuildProperties
    INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/mod
)

#-----------------------------------------------------------------------------
# Find nc-config and nf-config and add to CMAKE_PREFIX_PATH
#-----------------------------------------------------------------------------
find_program(NC_CONFIG NAMES "nc-config" DOC "Location of nc-config utility")
find_program(NF_CONFIG NAMES "nf-config" DOC "Location of nf-config utility")

# A function to call nx-config with an argument, and append the resulting
# path to a list
function(inspect_netcdf_config VAR NX_CONFIG ARG)
    execute_process(
        COMMAND ${NX_CONFIG} ${ARG}
        OUTPUT_VARIABLE NX_CONFIG_OUTPUT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if(EXISTS "${NX_CONFIG_OUTPUT}")
        list(APPEND ${VAR} ${NX_CONFIG_OUTPUT})
        set(${VAR} ${${VAR}} PARENT_SCOPE)
    endif()
endfunction()

inspect_netcdf_config(CMAKE_PREFIX_PATH "${NC_CONFIG}" "--prefix")
inspect_netcdf_config(CMAKE_PREFIX_PATH "${NF_CONFIG}" "--prefix")

#-----------------------------------------------------------------------------
# Append GEOS-Chem's environment variables to CMAKE_PREFIX_PATH
#-----------------------------------------------------------------------------
list(APPEND CMAKE_PREFIX_PATH
    # Possible NetCDF environment variables
    $ENV{NetCDF_F_ROOT}     $ENV{NetCDF_C_ROOT} $ENV{NetCDF_ROOT}
    $ENV{NETCDF_F_ROOT}     $ENV{NETCDF_C_ROOT} $ENV{NETCDF_ROOT}
    $ENV{NetCDF_Fortran_ROOT}
    $ENV{NETCDF_FORTRAN_ROOT}

    # Possible GEOS-Chem's environmnet variables
    $ENV{GC_F_BIN} 	    $ENV{GC_BIN}
    $ENV{GC_F_INCLUDE} 	    $ENV{GC_INCLUDE}
    $ENV{GC_F_LIB} 	    $ENV{GC_LIB}
)

#-----------------------------------------------------------------------------
# Link NetCDF-F to GEOSChemBuildProperties
#-----------------------------------------------------------------------------
find_package(NetCDF REQUIRED)
target_include_directories(GEOSChemBuildProperties INTERFACE
    ${NETCDF_INCLUDE_DIRS}
)
# Not sure if HCOI should be here...
target_link_libraries(GEOSChemBuildProperties INTERFACE
    ${NETCDF_LIBRARIES}
)

#-----------------------------------------------------------------------------
# Use the NC_HAS_COMPRESSION def if nf_def_var_deflate is in netcdf.inc
#-----------------------------------------------------------------------------
if(EXISTS ${NETCDF_F77_INCLUDE_DIR}/netcdf.inc)
    file(READ ${NETCDF_F77_INCLUDE_DIR}/netcdf.inc NCINC)
    if("${NCINC}" MATCHES ".*nf_def_var_deflate.*")
        target_compile_definitions(GEOSChemBuildProperties
            INTERFACE "NC_HAS_COMPRESSION"
        )
    endif()
endif()

#-----------------------------------------------------------------------------
# For GEOS-Chem Classic only
#-----------------------------------------------------------------------------
if(NOT GC_EXTERNAL_CONFIG)

    # This conditional block configures the GEOS-Chem build
    # for GEOS-Chem Classic. As mentioned above, it sets
    # GCCLASSIC_EXE_TARGETS, RRTMG, GTMM, TOMAS, MECH, and
    # GCHP, and it configures the GEOSChemBuildProperties.

    # Set CMAKE_BUILD_TYPE to Release by default
    if(NOT CMAKE_BUILD_TYPE)
        set(CMAKE_BUILD_TYPE "Release"
    	    CACHE STRING
            "Set the build type"
    	    FORCE
    	)
    endif()

    # Display CMAKE_PREFIX_PATH and CMAKE_BUILD_TYPE
    gc_pretty_print(SECTION "Useful CMake variables")
    gc_pretty_print(VARIABLE CMAKE_PREFIX_PATH)
    gc_pretty_print(VARIABLE CMAKE_BUILD_TYPE)

    # Get the run directory
    gc_pretty_print(SECTION "Run directory setup")

   # Run directory
   set(RUNDIR "" CACHE PATH "Path(s) to run directory (semicolon separated list). Specifies install locations for gchp")
   set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "Fake CMAKE_INSTALL_PREFIX (use RUNDIR instead)" FORCE)
   set(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT FALSE)
   gc_pretty_print(VARIABLE RUNDIR)

    # Configure for GCClassic
    include(GC-ConfigureClassic)
    configureGCClassic()

endif()

#-----------------------------------------------------------------------------
# Set high-level logicals for using this repository
#-----------------------------------------------------------------------------
set(GCCLASSIC_WRAPPER TRUE)
set(GC_EXTERNAL_CONFIG FALSE)
set(HEMCO_EXTERNAL_CONFIG TRUE)

#-----------------------------------------------------------------------------
# Add the directory with source code
#-----------------------------------------------------------------------------
add_subdirectory(src)

#-----------------------------------------------------------------------------
# Write GEOSChemBuildProperties's configuration to a file
#-----------------------------------------------------------------------------
get_target_property(BT_DEFINITIONS  GEOSChemBuildProperties
    INTERFACE_COMPILE_DEFINITIONS
)
get_target_property(BT_OPTIONS      GEOSChemBuildProperties
    INTERFACE_COMPILE_OPTIONS
)
get_target_property(BT_LIBRARIES    GEOSChemBuildProperties
    INTERFACE_LINK_LIBRARIES
)
get_target_property(BT_INCLUDES     GEOSChemBuildProperties
    INTERFACE_INCLUDE_DIRECTORIES
)
file(WRITE ${CMAKE_BINARY_DIR}/GEOSChemBuildProperties.txt
    "# This file shows the GEOSChemBuildProperties's configuration.\n"
    "\n"
    "GEOSChemBuildProperties::INTERFACE_COMPILE_DEFINITIONS:${BT_DEFINITIONS}\n"
    "GEOSChemBuildProperties::INTERFACE_COMPILE_OPTIONS:${BT_OPTIONS}\n"
    "GEOSChemBuildProperties::INTERFACE_LINK_LIBRARIES:${BT_LIBRARIES}\n"
    "GEOSChemBuildProperties::INTERFACE_INCLUDE_DIRECTORIES:${BT_INCLUDES}\n"
)

#-----------------------------------------------------------------------------
# Try to compile a simple program that uses NetCDF-Fortran and OpenMP
#-----------------------------------------------------------------------------
if(NOT GC_EXTERNAL_CONFIG AND NOT GC_TRY_RUN_PASSED)

    # Try to compile and run try_compile.F90
    try_run(RUN_FAILED COMPILED_OK
        ${CMAKE_CURRENT_BINARY_DIR}/try_compile                  # binary dir
        ${CMAKE_CURRENT_SOURCE_DIR}/CMakeScripts/try_compile.F90 # test src file
        LINK_LIBRARIES ${BT_LIBRARIES}
        CMAKE_FLAGS "-DINCLUDE_DIRECTORIES=${BT_INCLUDES}"       # include dirs
    	COMPILE_OUTPUT_VARIABLE COMPILE_OUTPUT
    	RUN_OUTPUT_VARIABLE RUN_OUTPUT
    )

    # Display a warning if its compilation failed
    if(NOT COMPILED_OK)
        if(OMP)
            set(CONDITIONAL_AND_OMP " and OpenMP")
        endif()
        message(WARNING
            "Failed to compile a simple program that uses "
            "NetCDF-Fortran ${CONDITIONAL_AND_OMP}! Could "
            "your NetCDF installation be broken?\nSee "
            "\"FailedCompile.txt\" for more info."
        )
        file(WRITE ${CMAKE_BINARY_DIR}/FailedCompile.txt
            "${COMPILE_OUTPUT}"
        )
    else()
        file(REMOVE ${CMAKE_BINARY_DIR}/FailedCompile.txt)
    endif()

    # Display a warning if its execution failed
    if(RUN_FAILED)
        if(OMP)
            set(CONDITIONAL_AND_OMP "and OpenMP ")
        endif()
        message(WARNING
            "A simple program that uses NetCDF-Fortran "
            "${CONDITIONAL_AND_OMP}compiled successfully, "
            "but its execution failed!\n\nSee "
            "\"FailedExecution.txt\" for more info."
        )
        file(WRITE ${CMAKE_BINARY_DIR}/FailedEasyRun.txt
            "${COMPILE_OUTPUTS}\n${RUN_OUTPUT}"
        )
    else()
        file(REMOVE ${CMAKE_BINARY_DIR}/FailedEasyRun.txt
            ${CMAKE_BINARY_DIR}/simple_xy.nc
        )
        set(GC_TRY_RUN_PASSED TRUE CACHE INTERNAL
            "try_run passed" FORCE
        )
    endif()
endif()

#-----------------------------------------------------------------------------
# Copy build information files to each RUNDIR and INSTALLCOPY directory
#----------------------------------------------------------------------------
set(COMBINED_INSTALL_DIRS "")
list(APPEND COMBINED_INSTALL_DIRS ${RUNDIR})
list(APPEND COMBINED_INSTALL_DIRS ${INSTALLCOPY})

# Install to run directories
foreach(INSTALL_PATH ${COMBINED_INSTALL_DIRS})
  if(INSTALL_PATH IN_LIST RUNDIR)
    set(CHECK_IS_RUNDIR TRUE)
  else()
    set(CHECK_IS_RUNDIR FALSE)
  endif()

  # Convert INSTALL_PATH to absolute
  if(NOT IS_ABSOLUTE "${INSTALL_PATH}")
    get_filename_component(INSTALL_PATH "${INSTALL_PATH}" ABSOLUTE BASE_DIR "${CMAKE_BINARY_DIR}")
  endif()
  # Issue warning and skip if input.geos doesn't exist
  # (i.e. if it doens't look like a run directory)
  if(CHECK_IS_RUNDIR AND (NOT EXISTS ${INSTALL_PATH}/input.geos))
    message(WARNING
      "RUNDIR path \"${INSTALL_PATH}\" "
      "doesn't have input.geos. Is it a run directory? If it "
      "isn't, and you still want to install to it, you should "
      "use INSTALLCOPY rather than RUNDIR.\nSkipping installing to "
      "${INSTALL_PATH}"
      )
  else()
    install(FILES ${CMAKE_BINARY_DIR}/CMakeCache.txt DESTINATION ${INSTALL_PATH}/build_info)
    install(PROGRAMS ${CMAKE_SOURCE_DIR}/CMakeScripts/summarize_build DESTINATION ${INSTALL_PATH}/build_info)
  endif()
endforeach()
