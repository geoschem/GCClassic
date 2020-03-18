# src/CMakeLists.txt

#---------------------------------------------------------------------
# Add HEMCO subdirectory
#---------------------------------------------------------------------
add_subdirectory(HEMCO EXCLUDE_FROM_ALL)

#---------------------------------------------------------------------
# Add GEOS-Chem subdirectory
#---------------------------------------------------------------------
add_subdirectory(GEOS-Chem EXCLUDE_FROM_ALL)

#---------------------------------------------------------------------
# Add the executable and store in the bin folder (pre-install)
#---------------------------------------------------------------------
add_executable(geos
    main.F
)
target_link_libraries(geos
    PUBLIC GeosCore
)
set_target_properties(geos PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
install(TARGETS geos
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}
)
