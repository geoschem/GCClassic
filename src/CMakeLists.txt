# src/CMakeLists.txt

#-----------------------------------------------------------------------------
# Tell CMake to look for code in HEMCO and GEOS-Chem directory trees
#-----------------------------------------------------------------------------
add_subdirectory(HEMCO     EXCLUDE_FROM_ALL)
add_subdirectory(GEOS-Chem EXCLUDE_FROM_ALL)

#-----------------------------------------------------------------------------
# Define the GEOS-Chem executable:
# 1. Specify the location of the main program
# 2. Specify libraries that the main program depends on
# 3. Store the binary exectuable file in the bin folder (pre-install)
#-----------------------------------------------------------------------------
add_executable(gcclassic
  GEOS-Chem/Interfaces/GCClassic/main.F90
)
target_link_libraries(gcclassic
  PUBLIC
  GeosCore
)
set_target_properties(gcclassic
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

#-----------------------------------------------------------------------------
# When "make install" is run, copy the target to the destination folder
# (which is typically one directory higher than the CMake build folder)
#-----------------------------------------------------------------------------
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
    # Issue warning and skip if input.geos doesn't exist (i.e. if it doens't look like a run directory)
    if(CHECK_IS_RUNDIR AND (NOT EXISTS ${INSTALL_PATH}/input.geos))
        continue() # Warning is raise elsewhere
    else()
	    install(TARGETS gcclassic RUNTIME DESTINATION ${INSTALL_PATH})
    endif()
endforeach()
