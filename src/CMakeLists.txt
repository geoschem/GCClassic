# src/CMakeLists.txt

#-----------------------------------------------------------------------------
# Tell CMake to look for code in HEMCO, Cloud-J and GEOS-Chem directory trees
#-----------------------------------------------------------------------------
add_subdirectory(HEMCO     EXCLUDE_FROM_ALL)
target_compile_definitions(HEMCOBuildProperties
    INTERFACE
        $<$<BOOL:${TOMAS}>:TOMAS>
        $<$<STREQUAL:${TOMAS_BINS},15>:TOMAS15>
        $<$<STREQUAL:${TOMAS_BINS},40>:TOMAS40>
        ""
)
add_subdirectory(HETP EXCLUDE_FROM_ALL)
add_subdirectory(Cloud-J EXCLUDE_FROM_ALL)
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
# Define the KPP standalone executable:
# 1. Specify a cache variable with the default target name
# 2. Specify the location of the main program
# 3. Specify libraries that the main program depends on
# 4. Store the binary exectuable file in the bin folder (pre-install)
# 5. If not fullchem or custom mechanism, prevent executable from being built
#
# At present build KPP standalone only for fullchem or custom mechanisms.
#
# This should now fix the issue reported by @msulprizio in:
#   https://github.com/geoschem/GCClassic/issues/78
#-----------------------------------------------------------------------------
set(KPPSA_FILE_NAME kpp_standalone CACHE STRING
  "Default name for the KPP standalone executable file")
mark_as_advanced(KPPSA_FILE_NAME)
add_executable(${KPPSA_FILE_NAME}
  GEOS-Chem/KPP/standalone/kpp_standalone.F90
)
if("${MECH}" STREQUAL fullchem OR "${MECH}" STREQUAL custom)
  target_link_libraries(${KPPSA_FILE_NAME}
    PUBLIC
    KPPStandalone
  )
  set_target_properties(${KPPSA_FILE_NAME}
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
  )
else()
  set_target_properties(${KPPSA_FILE_NAME}
    PROPERTIES
    EXCLUDE_FROM_ALL TRUE
  )
endif()

#-----------------------------------------------------------------------------
# When "make install" is run, copy the target to the destination folder
# (which is typically one directory higher than the CMake build folder)
#-----------------------------------------------------------------------------

# Define set of installation paths to consider
set(COMBINED_INSTALL_DIRS "")
list(APPEND COMBINED_INSTALL_DIRS ${RUNDIR})
list(APPEND COMBINED_INSTALL_DIRS ${INSTALLCOPY})

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

    # Issue warning and skip if geoschem_config.yml doesn't exist
    # (i.e. if it doens't look like a run directory)
    if(CHECK_IS_RUNDIR AND (NOT EXISTS ${INSTALL_PATH}/geoschem_config.yml))
      # Installation path is not a GEOS-Chem run directory
      # Skip ahead -- a warning will be raised elsewhere.
      continue()
    else()
      # Installation path is a GEOS-Chem run directory,
      # Therefore we will install the executable there.
      install(TARGETS ${EXE_FILE_NAME} RUNTIME DESTINATION ${INSTALL_PATH})

      # Only install KPP standalone for fullchem/custom mechanisms.
      # See: htps://github.com/geoschem/GCClassic/issues/78
      if("${MECH}" STREQUAL fullchem OR "${MECH}" STREQUAL custom)
	install(TARGETS ${KPPSA_FILE_NAME} RUNTIME DESTINATION ${INSTALL_PATH})
      endif()
    endif()

endforeach()
