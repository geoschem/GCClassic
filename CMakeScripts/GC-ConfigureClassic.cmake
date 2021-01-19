function(configureGCClassic)

    #-------------------------------------------------------------------------
    # Find OpenMP if we're building a multithreaded executable
    #-------------------------------------------------------------------------
    gc_pretty_print(SECTION "Threading")
    set(OMP ON CACHE STRING
        "Switch to enable/disable OpenMP threading in GEOS-Chem"
    )
    gc_pretty_print(VARIABLE OMP IS_BOOLEAN)
    if("${OMP}")
       set(NO_OMP "OFF" CACHE STRING "Boolean opposite of the OMP switch, needed for backwards compatibility")
       find_package(OpenMP REQUIRED)
       #######################################################################
       # NOTE: Newer versions of CMake (maybe > 3.8) prefer OpenMP::OpenMP
       # rather than ${OpenMP_Fortran_FLAGS} to specify compilation options
       # for OpenMP.  However, this is not supported in older versions.
       # For backwards compatibility, especially with Azure DevOps, we will
       # leave the new syntax commented out.  It can be restored later.
       #
       #  -- Bob Yantosca (28 Jul 2020)
       #    target_compile_options(HEMCOBuildProperties
       #      INTERFACE OpenMP::OpenMP_Fortran
       #    )
       #    target_link_libraries(HEMCOBuildProperties
       #      INTERFACE OpenMP::OpenMP_Fortran
       #    )
       #######################################################################
       target_compile_options(GEOSChemBuildProperties
           INTERFACE ${OpenMP_Fortran_FLAGS}
       )
       target_link_libraries(GEOSChemBuildProperties
           INTERFACE ${OpenMP_Fortran_FLAGS}
       )
    else()
        set(NO_OMP "ON" CACHE STRING
	  "Boolean opposite of the OMP switch, for backwards compatibility")
        target_compile_definitions(GEOSChemBuildProperties
		INTERFACE "NO_OMP"
        )
    endif()

    # Header for next section
    gc_pretty_print(SECTION "General settings")

    #-------------------------------------------------------------------------
    # Make MECH an option. This controls which KPP directory is used.
    #-------------------------------------------------------------------------
    set(CUSTOMMECH OFF CACHE BOOL
        "Switch to build with a custom mech"
    )
    gc_pretty_print(VARIABLE CUSTOMMECH IS_BOOLEAN)
    if(${CUSTOMMECH})
        set(MECH "custom")
    else()
        set(MECH "fullchem")
    endif()

    #-------------------------------------------------------------------------
    # Turn on bpch diagnostics?
    #-------------------------------------------------------------------------
    set(BPCH_DIAG "OFF" CACHE BOOL 
        "Switch to enable GEOS-Chem's bpch diagnostics"
    )
    gc_pretty_print(VARIABLE BPCH_DIAG IS_BOOLEAN)
    if(${BPCH_DIAG})
        target_compile_definitions(GEOSChemBuildProperties
	    INTERFACE BPCH_DIAG
	)
    endif()

    #-------------------------------------------------------------------------
    # Set USE_REAL8 as cache variable so as to not override existing definition
    # See https://github.com/geoschem/geos-chem/issues/43.
    #-------------------------------------------------------------------------
    set(USE_REAL8 ON CACHE BOOL
      "Switch to set flexible precision 8-byte floating point real"
    )
    gc_pretty_print(VARIABLE USE_REAL8 IS_BOOLEAN)
    target_compile_definitions(GEOSChemBuildProperties
      INTERFACE $<$<BOOL:${USE_REAL8}>:USE_REAL8>
    )

    #-------------------------------------------------------------------------
    # Always set MODEL_CLASSIC when building GEOS-Chem Classic
    #-------------------------------------------------------------------------
    target_compile_definitions(GEOSChemBuildProperties
	INTERFACE MODEL_CLASSIC
    )

    # Header for next section
    gc_pretty_print(SECTION "Components")

    #-------------------------------------------------------------------------
    # Build TOMAS
    #-------------------------------------------------------------------------
    set(TOMAS "OFF" CACHE BOOL "Switch to enable TOMAS")
    set(TOMAS_BINS "NA" CACHE STRING "Number of TOMAS bins (only used if TOMAS is true)")
    gc_pretty_print(VARIABLE TOMAS IS_BOOLEAN)
    gc_pretty_print(VARIABLE TOMAS_BINS OPTIONS "NA" "15" "40")
    if(${TOMAS})
        target_compile_definitions(GEOSChemBuildProperties INTERFACE TOMAS)
        if("${TOMAS_BINS}" MATCHES "NA")
            message(FATAL_ERROR "TOMAS_BINS must be 15 or 40 if TOMAS is ON")
        endif()
    else()
        if(NOT "${TOMAS_BINS}" MATCHES "NA")
            message(FATAL_ERROR "TOMAS_BINS must be NA if TOMAS is OFF")
        endif()
    endif()
    

    if("${TOMAS_BINS}" MATCHES 15)
        target_compile_definitions(GEOSChemBuildProperties
            INTERFACE TOMAS15
        )
    elseif("${TOMAS_BINS}" MATCHES 40)
        target_compile_definitions(GEOSChemBuildProperties
            INTERFACE TOMAS40
        )
    endif()
    
    #-------------------------------------------------------------------------
    # Build APM?
    #-------------------------------------------------------------------------
    set(APM "OFF" CACHE BOOL
    	"Switch to build APM as a component of GEOS-Chem"
    )
    gc_pretty_print(VARIABLE APM IS_BOOLEAN)
    if(${APM})
        target_compile_definitions(GEOSChemBuildProperties INTERFACE APM)
    endif()

    #-------------------------------------------------------------------------
    # Build RRTMG?
    #-------------------------------------------------------------------------
    set(RRTMG "OFF" CACHE BOOL
        "Switch to build RRTMG as a component of GEOS-Chem"
    )
    gc_pretty_print(VARIABLE RRTMG IS_BOOLEAN)
    if(${RRTMG})
        target_compile_definitions(GEOSChemBuildProperties INTERFACE RRTMG)
    endif()

    #-------------------------------------------------------------------------
    # Build GTMM?
    # (This is a deprecated option...needs updating.  Turn OFF by default.)
    #-------------------------------------------------------------------------
    set(GTMM OFF CACHE BOOL
        "Switch to build GTMM as a component of GEOS-Chem"
    )
    gc_pretty_print(VARIABLE GTMM IS_BOOLEAN)
    if(${GTMM})
        target_compile_definitions(GEOSChemBuildProperties INTERFACE GTMM_Hg)
    endif()

    #-------------------------------------------------------------------------
    # Build HEMCO standalone?
    #-------------------------------------------------------------------------
    set(HCOSA "OFF" CACHE BOOL
        "Switch to build the hemco-standalone (HCOSA) executable"
    )
    gc_pretty_print(VARIABLE HCOSA IS_BOOLEAN)

    #-------------------------------------------------------------------------
    # Build Luo et al wetdep scheme?
    # (Currently a research option... turn OFF by default)
    #-------------------------------------------------------------------------
    set(LUO_WETDEP OFF CACHE BOOL
        "Switch to build the Luo et al (2019) wetdep scheme into GEOS-Chem"
    )
    gc_pretty_print(VARIABLE LUO_WETDEP IS_BOOLEAN)
    if(${LUO_WETDEP})
        target_compile_definitions(GEOSChemBuildProperties
            INTERFACE LUO_WETDEP
        )
    endif()

    #-------------------------------------------------------------------------
    # Export the following variables to GEOS-Chem directory's scope
    #-------------------------------------------------------------------------
    set(GCHP                    FALSE                       PARENT_SCOPE)
    set(MODEL_CLASSIC           TRUE                        PARENT_SCOPE)
    set(MECH                    ${MECH}                     PARENT_SCOPE)
    set(TOMAS                   ${TOMAS}                    PARENT_SCOPE)
    set(APM                     ${APM}                      PARENT_SCOPE)
    set(RRTMG                   ${RRTMG}                    PARENT_SCOPE)
    set(GTMM                    ${GTMM}                     PARENT_SCOPE)
    set(LUO_WETDEP              ${LUO_WETDEP}               PARENT_SCOPE)

    #-------------------------------------------------------------------------
    # Export information about Git status
    #-------------------------------------------------------------------------

    # Get branch nane in code repository
    macro(get_git_branch VAR)
      execute_process(
        COMMAND git -C ${CMAKE_CURRENT_SOURCE_DIR} rev-parse --abbrev-ref HEAD
        OUTPUT_VARIABLE ${VAR}
        OUTPUT_STRIP_TRAILING_WHITESPACE
	)
    endmacro()
    get_git_branch(CODE_BRANCH)
    set(GIT_BRANCH ${CODE_BRANCH} CACHE STRING "Current branch in code repo")

    # Get last commit name from code repository
    macro(get_git_commit VAR)
      execute_process(
        COMMAND git -C ${CMAKE_CURRENT_SOURCE_DIR} log -n 1 --pretty=format:"%s"
        OUTPUT_VARIABLE ${VAR}
	)
    endmacro()
    get_git_commit(LAST_COMMIT)
    set(GIT_COMMIT ${LAST_COMMIT} CACHE STRING "Last commit in Git repo")

    # Get last commit hash from code repository
    macro(get_git_commit_hash VAR)
      execute_process(
        COMMAND git -C ${CMAKE_CURRENT_SOURCE_DIR} log -n 1 --pretty=format:"%h"
        OUTPUT_VARIABLE ${VAR}
	)
    endmacro()
    get_git_commit_hash(COMMIT_HASH)
    set(GIT_COMMIT_HASH ${COMMIT_HASH} CACHE STRING "Last commit hash in Git repo")

    # Get last commit date from code repository
    macro(get_git_commit_date VAR)
      execute_process(
        COMMAND git -C ${CMAKE_CURRENT_SOURCE_DIR} log -n 1 --pretty=format:"%cd"
        OUTPUT_VARIABLE ${VAR}
	)
    endmacro()
    get_git_commit_date(COMMIT_DATE)
    set(GIT_COMMIT_DATE ${COMMIT_DATE} CACHE STRING "Date of last Git commit")
    
endfunction()
