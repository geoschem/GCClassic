.. _code_directory_structure:

#############################
GEOS-Chem Classic folder tree
#############################

The tables below list the folders in which various components of
GEOS-Chem Classic reside.

.. code-block:: bash

   GCClassic
   |
   +---CMakeScripts                           # Utility functions for CMake
   |
   +---docs                                   # Root directory for ReadTheDocs documentation
   |   |
   |   +---source                             # Subdivides documentation into subdirectories
   |       |
   |       +---gcclassic-user-guide           # Markup files (ReST format) for ReadTheDocs
   |       |
   |       +---geos-chem-shared-docs          # Submodule containing shared documentation files
   |       |                                  # (such as common supplemental guides)
   |       |
   |       +---getting-started                # Markup files (ReST format) for ReadTheDocs
   |       |
   |       +---help-and-reference             # Markup files (ReST format) for ReadTheDocs
   |       |
   |       +---_static                        # Static content (e.g. images) for ReadTheDocs
   |       |
   |       +---supplemental-guides            # Markup files (ReST format) for ReadTheDocs
   |                                          # (Content specific to GEOS-Chem Classic)
   |
   +---run                                    # Link to src/GEOS-Chem/run/GCClassic
   |
   +---src                                    # Contains submodules used by GEOS-Chem Classic
   |   |
   |   +---Cloud-J                            # Cloud-J submodule source code
   |   |   |
   |   |   +---CMakeScripts                   # Utility functions for CMake
   |   |   |
   |   |   +---docs                           # Cloud-J documentation files
   |   |   |
   |   |   +---src                            # Cloud-J source code
   |   |   |
   |   |   +---tables                         # Input lookup tables for Cloud-J
   |   |   |
   |   |   +---tools                          # Tools for Cloud-J
   |   |       |
   |   |       +---AddXs                      # Source code to add new cross-sections
   |   |
   |   +---GEOS_Chem                          # GEOS-Chem submodule, contains
   |   |   |
   |   |   +---APM                            # Source code for APM microphysics module
   |   |   |
   |   |   +---CMakeScripts                   # Utility functions for CMake
   |   |   |
   |   |   +---GeosCore                       # Source code for most GEOS-Chem science routines
   |   |   |
   |   |   +---GeosRad                        # RRTMG radiative transfer model source code
   |   |   |
   |   |   +---GeosUtil                       # Source code for various utility routines
   |   |   |
   |   |   +---GTMM                           # Global Terrestrial Mercury Model source code
   |   |   |                                  # (NOTE: This feature has fallen into disuse)
   |   |   |
   |   |   +---Headers                        # Source code for defining the GEOS-Chem state objects
   |   |   |
   |   |   +---History                        # Source code for History diagnostics
   |   |   |
   |   |   +---Interfaces                     # Driver code for various implementations of GEOS-Chem
   |   |   |   |
   |   |   |   +---CESM                       # Source code to connect GEOS-Chem to CESM
   |   |   |   |
   |   |   |   +---GCClassic                  # "Main program" source code for GEOS-Chem Classic
   |   |   |   |
   |   |   |   +---GCHP                       # "Main program" source code for GCHP
   |   |   |   |
   |   |   |   +---GEOS                       # Source code to connect GEOS-Chem in the NASA GEOS ESM
   |   |   |
   |   |   +---KPP                            # Root folder KPP-generated solver code
   |   |   |   |
   |   |   |   +---carbon                     # KPP-generated code for the carbon mechanism
   |   |   |   |
   |   |   |   +---custom                     # "Sandbox" for generating custom mechanisms
   |   |   |   |
   |   |   |   +---fullchem                   # KPP-generated code for the full-chemistry mechanism
   |   |   |   |
   |   |   |   +---Hg                         # KPP-generated code for the mercury (Hg) mechanism
   |   |   |
   |   |   +---NcdfUtil                       # Source code for netCDF file I/O
   |   |   |
   |   |   +---ObsPack                        # Source code for the ObsPack diagnostic
   |   |   |
   |   |   +---PKUCPL                         # Source code for PKU two way coupler
   |   |   |                                  # (NOTE: This feature has fallen into disuse)
   |   |   |
   |   |   +---run                            # Root folder for run directory creation scripts
   |   |   |   |
   |   |   |   +---CESM                       # Rundir creation scripts/files for CESM
   |   |   |   |
   |   |   |   +---GCClassic                  # Rundir creation scripts/files for GEOS-CHem Classic
   |   |   |   |
   |   |   |   +---GCHP                       # Rundir creation scripts/files for GCHP
   |   |   |   |
   |   |   |   +---GEOS                       # Rundir creation scripts/files for NASA GEOS ESM
   |   |   |   |
   |   |   |   +---shared                     # Common scripts and configuration file snippets
   |   |   |   |
   |   |   |   +---WRF                        # Rundir creation scripts/files for WRF-GC
   |   |   |
   |   |   +---test                           # Root folder for integration test scripts
   |   |       |
   |   |       +---difference                 # Scripts to compare the results of two integrationtests
   |   |       |
   |   |       +---integration                # Top-level integration test folder
   |   |       |   |
   |   |       |   +---GCClassic              # Scripts to run integration tests for GEOS-Chem Classic
   |   |       |   |
   |   |       |   +---GCHP                   # Scripts to run integration tests for GCHP
   |   |       |
   |   |       +---parallel                   # Top-level parallelization test folder
   |   |       |   |
   |   |       |   +---GCClassic              # Scripts to run parallel tests for GEOS-Chem Classic
   |   |       |
   |   |       +---shared                     # Common scripts for integration & parallel tests
   |   |
   |   +---HEMCO                              # Harmonized Emissions Component (HEMCO) submodule
   |   |   |
   |   |   +---CMakeScripts                   # Utility functions for CMake
   |   |   |
   |   |   +---docs                           # Root directory for ReadTheDocs documentation
   |   |   |   |
   |   |   |   +---source                     # Subdivides documentation into subdirectories
   |   |   |       |
   |   |   |       +---coupling               # Markup files (ReST format) for ReadTheDocs
   |   |   |       |
   |   |   |       +---geos-chem-shared-docs  # Submodule containing shared documentation files
   |   |   |       |		              # (such as common supplemental guides)
   |   |   |       |
   |   |   |       +---hco-ref-guide          # Markup files (ReST format) for ReadTheDocs
   |   |   |       |
   |   |   |       +---hco-sa-guide 	      # Markup files (ReST format) for ReadTheDocs
   |   |   |       |
   |   |   |       +---reference              # Markup files (ReST format) for ReadTheDocs
   |   |   |       |
   |   |   |       +---_static 		      # Static content (e.g. images) for ReadTheDocs
   |   |   |
   |   |   +---run                            # Rundir creation scripts/files for HEMCO standalone
   |   |   |
   |   |   +---src                            # Top-level source code folder
   |   |       |
   |   |       +---Core                       # Source code for core HEMCO routines
   |   |       |
   |   |       +---Extensions                 # Source code for HEMCO extensions
   |   |       |   |
   |   |       |   +---PreProcess             # Scripts for creating the FINN or GFED include file
   |   |       |
   |   |       +---Interfaces                 # Driver programs for the various HEMCO implementations
   |   |       |   |
   |   |       |   +--GEOS                    # Source code to connect HEMCO to the NASA GEOS ESM
   |   |       |   |
   |   |       |   +--MAPL_ESMF               # Source code to run HEMCO in the ESMF/MAPL environment
   |   |       |   |
   |   |       |   +--Shared                  # Common files for run directory creation
   |   |       |   |
   |   |       |   +--Standalone              # "Main Program" for the HEMCO standalone model
   |   |       |
   |   |       +---Shared                     # Top-level folder for shared code
   |   |           |
   |   |           +---GeosUtil               # Local copies of source code in GEOS-Chem/GeosUtil
   |   |           |
   |   |           +---Headers                # Local copies of source code in GEOS-Chem/Headers
   |   |           |
   |   |           +---NcdfUtil               # Local copies of source code in GEOS-Chem/NcdfUtil
   |   |
   |   +---HETP                               # ISORROPIA/HETP submodule source code
   |       |
   |       +---CMakeScripts                   # Utility functions for CMake
   |       |
   |       +---Core                           # Source code for HETP
   | 	   |
   |	   +---Test                           # "Main program" for testing HETP in standalone mode
   |
   |
   +---spack                                  # Link to docs/source/geos-chem-shared-docs/spack
   |                                           
   +---test                                   # Link to src/GEOS-Chem/test