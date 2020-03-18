# GEOS-Chem Classic high-level CMakeLists.txt

cmake_minimum_required (VERSION 3.5)
project (geos-chem-classic
  VERSION 12.7.2
  LANGUAGES Fortran
)

#---------------------------------------------------------------------
# Set policies
#---------------------------------------------------------------------
cmake_policy(SET CMP0054 NEW)
cmake_policy(SET CMP0057 NEW)
if(POLICY CMP0074)
    cmake_policy(SET CMP0074 NEW)
endif()
if(POLICY CMP0079)
    cmake_policy(SET CMP0079 NEW)
endif()

#---------------------------------------------------------------------
# Set high-level logicals for using this repository
#---------------------------------------------------------------------
set(GCCLASSIC_WRAPPER TRUE)
set(GC_EXTERNAL_CONFIG FALSE)
set(HEMCO_EXTERNAL_CONFIG TRUE)

#---------------------------------------------------------------------
# Set install to run directory
#---------------------------------------------------------------------
set(RUNDIR ${CMAKE_BINARY_DIR}/.. CACHE PATH "Path to GEOS-Chem run directory")
if(RUNDIR)
    set(CMAKE_INSTALL_PREFIX ${RUNDIR} CACHE PATH "Install prefix for GEOS-Chem" FORCE)
    set(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT FALSE)
endif()

#---------------------------------------------------------------------
# Find nc-config and nf-config and add to CMAKE_PREFIX_PATH
#---------------------------------------------------------------------
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

#---------------------------------------------------------------------
# Set gfortran-specific compile flags
#---------------------------------------------------------------------
if("${CMAKE_Fortran_COMPILER_ID}" STREQUAL "GNU")
    list(APPEND CMAKE_Fortran_FLAGS "-ffree-line-length-none")
endif()

#---------------------------------------------------------------------
# Add the directory with source code
#---------------------------------------------------------------------
add_subdirectory(src)
