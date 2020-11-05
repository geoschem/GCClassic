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
foreach(RUNDIR_PATH ${RUNDIR})
	# If RUNDIR is not a relative path, make it an absolute path relative to the build directory
	if(NOT IS_ABSOLUTE "${RUNDIR_PATH}")
		get_filename_component(RUNDIR_PATH "${RUNDIR_PATH}" ABSOLUTE BASE_DIR "${CMAKE_BINARY_DIR}")
	endif()
	install(TARGETS gcclassic RUNTIME DESTINATION ${RUNDIR_PATH})
endforeach()
