# src/CMakeLists.txt

#-----------------------------------------------------------------------------
# Tell CMake to look for code in HEMCO and GEOS-Chem directory trees
#-----------------------------------------------------------------------------
add_subdirectory(HEMCO     EXCLUDE_FROM_ALL)
add_subdirectory(GEOS-Chem EXCLUDE_FROM_ALL)

#-----------------------------------------------------------------------------
# Define the GEOS-Chem executable:
# 1. Specify a cache variable with the default target name
# 2. Specify the location of the main program
# 3. Specify libraries that the main program depends on
# 4. Store the binary exectuable file in the bin folder (pre-install)
#-----------------------------------------------------------------------------
set(EXE_FILE_NAME gcclassic CACHE STRING
  "Default name for the GEOS-Chem Classic executable file")
mark_as_advanced(EXE_FILE_NAME)

add_executable(${EXE_FILE_NAME}
  GEOS-Chem/Interfaces/GCClassic/main.F90
)
target_link_libraries(${EXE_FILE_NAME}
  PUBLIC
  GeosCore
)
set_target_properties(${EXE_FILE_NAME}
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

#-----------------------------------------------------------------------------
# Special option for e.g. integration tests
# allow installation to a directory that is not a GEOS-Chem run directory
#-----------------------------------------------------------------------------
set(INSTALLCOPY_FORCE "none" CACHE STRING
  "Forces copying of the GEOS_Chem executable to a non-GEOS-Chem run directory")
mark_as_advanced(INSTALLCOPY_FORCE)

#-----------------------------------------------------------------------------
# When "make install" is run, copy the target to the destination folder
# (which is typically one directory higher than the CMake build folder)
#-----------------------------------------------------------------------------

# Define set of installation paths to consider
set(COMBINED_INSTALL_DIRS "")
list(APPEND COMBINED_INSTALL_DIRS ${RUNDIR})
list(APPEND COMBINED_INSTALL_DIRS ${INSTALLCOPY})
list(APPEND COMBINED_INSTALL_DIRS ${INSTALLCOPY_FORCE})

# Consider installation to all of the specified paths
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
      if("${INSTALLCOPY_FORCE}" STREQUAL "none")
	# Installation path is not a GEOS-Chem run directory
	# and we have not specified a path with INSTALLCOPY_FORCE.
	# Skip ahead -- a warning will be raised elsewhere.
	continue()
      else()
	# Installation path is not a GEOS-Chem run directory,
	# but we have specified a path with INSTALLCOPY_FORCE.
	# Therefore we will install the executable there.
	install(TARGETS ${EXE_FILE_NAME} RUNTIME DESTINATION ${INSTALL_PATH})
      endif()
    else()
      # Installation path is a GEOS-Chem run directory,
      # so install the executable there.
      install(TARGETS ${EXE_FILE_NAME} RUNTIME DESTINATION ${INSTALL_PATH})
    endif()

endforeach()
