.. _compiling-geos-chem:

###############################
Configure and compile GEOS-Chem
###############################

In this chapter, we will describe the basic steps that you need to
compile GEOS-Chem into an executable file.

.. _building-geos-chem:

==========================================
Use CMake to configure and build GEOS-Chem
==========================================
You should think of `CMake <http://cmake.org>`_ as an interactive tool
for configuring :program:`GEOS-Chem Classic's` build. For example,
compile-time options like disabling multithreading and turning on
components (e.g. APM, RRTMG) are all configured with CMake commands.

Besides configuring GEOS-Chem's build, CMake also performs checks on
your build environment to detect problems that would cause the build
to fail. If it identifies a problem, like a missing dependency or
mismatched run directory and source code version numbers, CMake will
print an error message that describes the problem.

If you are new to CMake and would like a rundown of how to use the
:command:`cmake` command, check out `Liam Bindle's Cmake Tutorial
<https://github.com/LiamBindle/An-Introduction-to-Using-CMake/wiki>`_. This
tutorial is not necessary, but it will make you more
familiar with using CMake and help you better understand what is going
on.

Below are the steps for building GEOS-Chem with CMake.

.. _navigate-to-your-run-directory:

1. Navigate to your run directory
---------------------------------

In this example, we will compile the GEOS-Chem code for the
full-chemistry simulation.  Navigate to your run directory and get a
directory listing as shown below:

.. code-block:: console

   $ cd ~/gc_merra2_fullchem
   $ ls
   archiveRun.sh*      GEOSChem.Restart.20190701_0000z.nc4   metrics.py
   build/              getrunInfo*                           OutputDir/
   cleanRunDir.sh*     HEMCO_Config.rc                       README
   CodeDir@            HEMCO_Diagn.rc                        rundir.version
   download_data.py*   HISTORY.rc                            runScriptSamples
   download_data.yml   input.geos                            species_database.yml

Note that each GEOS-Chem run directory that you generate has a folder
named :file:`build/`. This is where we will run CMake.

.. _navigate-to-the-build-directory:

2. Navigate to the build directory
----------------------------------

The build directory is where CMake and your compilers are going to put
the files they generate. For this example, we will use the :file:`build/`
folder that was automatically generated in the GEOS-Chem Classic run
directory. For GCHP you will need to create one.

.. code-block:: console

   $ cd build

.. tip::

   If you find yourself switching between different compilers,
   you can create multiple build directories with different
   names (e.g. :file:`build_gfortran10`, :file:`build_ifort19`, etc).

.. _initialize-your-build-directory:

3. Initialize the build directory
----------------------------------

Next, we need to initialize the build directory. Type:

.. code-block:: console

   $ cmake ../CodeDir -DRUNDIR=..

where :file:`../CodeDir` is the symbolic link from our run directory
to the GEOS-Chem source code directory. CMake will
generate output similar to this:

.. code-block:: text

   -- The Fortran compiler identification is GNU 9.3.0
   -- Check for working Fortran compiler: /usr/bin/gfortran
   -- Check for working Fortran compiler: /usr/bin/gfortran  -- works
   -- Detecting Fortran compiler ABI info
   -- Detecting Fortran compiler ABI info - done
   -- Checking whether /usr/bin/gfortran supports Fortran 90
   -- Checking whether /usr/bin/gfortran supports Fortran 90 -- yes
   =================================================================
   GCClassic 14.0.0 (superproject wrapper)
   Current status: 14.0.0-alpha.3-1-g289a460
   =================================================================
   -- Found NetCDF: /usr/lib/x86_64-linux-gnu/libnetcdff.so
   -- Useful CMake variables:
     + CMAKE_PREFIX_PATH:    /usr  /usr
     + CMAKE_BUILD_TYPE:     Release
   -- Run directory setup:
     + RUNDIR:       /home/ubuntu/test_gcc
   -- Threading:
     * OMP:          ON  OFF
   -- Found OpenMP_Fortran: -fopenmp (found version "4.5")
   -- Found OpenMP: TRUE (found version "4.5")
   -- General settings:
     * MECH:         **fullchem**  Hg  custom
     * BPCH_DIAG:    ON  **OFF**
     * USE_REAL8:    ON  **OFF**
   -- Components:
     * TOMAS:        ON  **OFF**
     * TOMAS_BINS:   **NA**  15  40
     * APM:          ON  **OFF**
     * RRTMG:        ON  **OFF**
     * GTMM:         ON  **OFF**
     * HCOSA:        ON  **OFF**
     * LUO_WETDEP:   ON  **OFF**
   =================================================================
   HEMCO 3.5.0
   Current status: 3.4.0-10-g18b61cd
   =================================================================
   -- Found OpenMP_Fortran: -fopenmp
   -- Found OpenMP: TRUE
   =================================================================
   GEOS-Chem 14.0.0 (science codebase)
   Current status: 14.0.0-alpha.3-4-gf833fba4f
   =================================================================
   Creating /home/ubuntu/test_gcc/CodeDir/src/GEOS-Chem/Interfaces/GCClassic/gc_classic_version.H
   -- Configuring done
   -- Generating done
   -- Build files have been written to: /home/ubuntu/test_gcc/gc_merra2_fullchem

Your CMake command's output contains important information about your
build's configuration.

.. _configure-your-build:

4. Configure your build
-----------------------

Your build directory is now configured to compile GEOS-Chem using all
default options. If you do not wish to change anything further,
you may skip ahead to the next section (LINK NEEDED).

However, if you wish to modify your build's configuration, simply invoke
CMake once more with optional parameters. Use this format:

.. code-block:: console

   $ cmake . -Doption=value

Note that the ``.`` argument is necessary. It tells CMake that your
current working directory (i.e. :file:`.`) is your build directory. The output
of :program:`cmake` tells you about your build's configuration. Options are
prefixed by a ``+`` or ``\*``  in the output, and their values are
displayed or highlighted.

.. tip::

  If you are colorblind or if you are using a terminal that
  does not support colors, refer to the CMake FAQ for
  instructions on disabling colorized output. For a detailed
  explanation of CMake output, see the next section.

The table below contains the list of GEOS-Chem build options that you
can pass to CMake. GEOS-Chem will be compiled with the default build
options, unless you explicitly specify otherwise.

.. option:: -DRUNDIR=/path/to/run/dir

   Defines the path to the run directory.

   In this example, our build directory is a subfolder of the run
   directory, so we can use :envvar:`-DRUNDIR=..`.  If your build
   directory is somewhere else, then specify the path to the run
   directory as an absolute path.

.. option:: -DCMAKE_BUILD_TYPE=Debug

   Turns on several runtime error checks.  This will make it easier
   to find errors but will adversely impact performance. Only use
   this option if you are actively debugging.

.. option:: Options for chemical mechanisms

   Configure GEOS-Chem to use one of several chemical mechanisms,
   described below:

   .. option:: -DMECH=fullchem

      Activates the "fullchem" mechanism.  The source code
      files that define this mechanism are stored in :file:`KPP/fullchem`.

      NOTE: "fullchem" is the default chemical mechanism.  Therefore, if you
      wish to use the "fullchem" mechanism, you can omit this option.

   .. option:: -DMECH=Hg

      Activates the Hg mechanism.  The source code
      files that define this mechanism are stored in :file:`KPP/Hg`.

   .. option:: -DMECH=custom

      Activates a custom mechanism defined by the user.  The source
      code files that define this mechanism are stored in :file:`KPP/custom.`.

.. option:: -DOMP=n

   OpenMP parallelization is turned on by default.  This option will
   toggle OpenMP parallization off by default (e.g. for debugging).

.. option:: Options for TOMAS aerosol microphysics

   Options for configuring GEOS-Chem to use the `TOMAS aerosol
   microphysics package
   <http://wiki.geos-chem.org/TOMAS_aerosol_microphysics>`_.

   .. option:: -DTOMAS=y

      Configure GEOS-Chem with the TOMAS Aerosol Microphysics
      package.  TOMAS is deactivated by default.

   .. option:: -DTOMAS_BINS=15

      Select 15 size-resolved bins for TOMAS.

   .. option:: -DTOMAS_BINS=40

      Select 40 size-resolved bins for TOMAS.

   .. option:: -DBPCH_DIAG=y

      Toggles the legacy binary punch diagnostics on.

      Binary punch diagnostics are turned off by default.  Except for a
      few diagnostics, these have been replaced by the :ref:`netCDF-based
      History diagnostics <history-diagnostics>`.

.. option:: -DAPM=y

   Configures GEOS-Chem to use the `APM microphysics package
   <http://wiki.geos-chem.org/APM_aerosol_microphysics>`_.
   APM is deactivated by default.

.. option:: -DRRTMG=y

   Configures GEOS-Chem to use the RRTMG radiative transfer model.
   RRTMG is turned off by default.

.. option:: -DLUO_WETDEP=y

   Configures GEOS-Chem to use the Luo et al 2020 wet deposition
   scheme.  This option is turned off by default.

   The Luo et al 2020 wet deposition scheme is turned off by default.

   .. note::

      The Luo et al 2020 wet deposition scheme will eventually
      become the default wet deposition schem in GEOS-Chem.  We
      have made it an option for the time being while further
      evaluation is being done.

If you plan to use the :command:`make -j install` option (recommended)
to copy your executable to your run directory, you must reconfigure
CMake with the :envvar:`-DRUNDIR=/path/to/run/dir`
option. Multiple run directories can be specified by a semicolon
separated list. A warning is issues if one of these directories does
not look like a run directory. These paths can be relative paths or
absolute paths. Relative paths are interpreted as relative to your
build directory. For example:

.. code-block:: console

   $ cmake . -DRUNDIR=/path/to/run/dir

For example if you wanted to build GEOS-Chem with all debugging flags
on, you would type:

.. code-block:: console

   $ cmake . -DCMAKE_BUILD_TYPE=Debug

or if you wanted to turn off OpenMP parallelization (so that GEOS-Chem
executes only on one computational core), you would type:

.. code-block:: console

   $ cmake . -DOMP=n

etc.

.. _understand-the-output-from-cmake:

5. Understand the output from CMake
-----------------------------------

As you can see from the example CMake output listed above, GEOS-Chem
Classic 13.0.0 and later versions contain code from 3 independent repositories:

1. `GCClassic wrapper (aka "the superproject") <https://github.com/geoschem/GCClassic.git>`_:

.. code-block:: none

   =================================================================
   GCClassic 14.0.0 (superproject wrapper)
   Current status: 14.0.0-alpha.3-1-g289a460
   =================================================================

2. `HEMCO (Harmonized Emissions Component) submodule <https://github.com/geoschem/hemco.git>`_:

.. code-block:: none

   =================================================================
   HEMCO 3.5.0
   Current status: 3.4.0-10-g18b61cd
   =================================================================

3. `GEOS-Chem submodule <https://github.com/geoschem/geos-chem.git>`_:

.. code-block:: none

   =================================================================
   GEOS-Chem 14.0.0 (science codebase)
   Current status: 14.0.0-alpha.3-4-gf833fba4f
   =================================================================

During the build configuration stage, CMake will display the **version
number** (e.g. :file:`14.0.0`) as well as the **current status of the Git
repository** (e.g. :file:`14.0.0-alpha.3-1-g289a460`) for GCClassic,
GEOS-Chem, and HEMCO.

Let's take the Git repository status of GCClassic as our example. The
status string uses the same format as the :command:`git describe
--tags` command, namely:

.. code-block:: text

    14.0.0-alpha.3-1-g289a460

where

.. option:: 14.0.0-alpha.3

    Indicates the most recent tag in the `GCClassic superproject
    repository ` <https://github.com/geoschem/GCClassic>`_.

.. option:: 1

   Indicates the number of commits that were made atop
   :file:`14.0.0-alpha.3`.

.. option:: g

   Indicates that the version control system is Git.

.. option:: 289a460

   Indicates the Git commit (short form) at the HEAD of the
   GCClassic repository.

.. option:: .dirty

   If present, indicates that there are uncommitted updates atop the
   :file:`289a460` commit in the GCClassic repository.

Under each header are printed the various :ref:`options that have been
selected <configure-your-build>`.

.. _compile-geos-chem:

=================
Compile GEOS-Chem
=================

Now that CMake has created the Makefiles that are needed to compile
GEOS-Chem, you may proceed as follows:

1. Build the GEOS-Chem Classic executable
-----------------------------------------

Use the :command:`make` command to build the GEOS-Chem executable.  Type:

.. code-block:: console

    $ make -j

You will see output similar to this:

.. code-block:: text

   Scanning dependencies of target HeadersHco
   Scanning dependencies of target Isorropia
   Scanning dependencies of target KPP_FirstPass
   [  1%] Building Fortran object src/HEMCO/src/Shared/Headers/CMakeFiles/HeadersHco.dir/hco_inquireMod.F90.o
   [  1%] Building Fortran object src/HEMCO/src/Shared/Headers/CMakeFiles/HeadersHco.dir/hco_precision_mod.F90.o
   [  1%] Building Fortran object src/HEMCO/src/Shared/Headers/CMakeFiles/HeadersHco.dir/hco_charpak_mod.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/KPP/fullchem/CMakeFiles/KPP_FirstPass.dir/gckpp_Monitor.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/KPP/fullchem/CMakeFiles/KPP_FirstPass.dir/gckpp_Precision.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/KPP/fullchem/CMakeFiles/KPP_FirstPass.dir/gckpp_Parameters.F90.o
   [  3%] Linking Fortran static library libKPP_FirstPass.a
   [  3%] Built target KPP_FirstPass
   Scanning dependencies of target Headers
   [  3%] Building Fortran object src/GEOS-Chem/ISORROPIA/CMakeFiles/Isorropia.dir/isorropiaII_main_mod.F.o
   [  3%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/charpak_mod.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/dictionary_m.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/CMN_SIZE_mod.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/qfyaml_mod.F90.o
   [  4%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/CMN_O3_mod.F90.o
   [  6%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/inquireMod.F90.o

   ... etc ...

   [ 93%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/sulfate_mod.F90.o
   [ 93%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/fullchem_mod.F90.o
   [ 93%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/mixing_mod.F90.o
   [ 93%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/carbon_mod.F90.o
   [ 95%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/chemistry_mod.F90.o
   [ 95%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/gc_environment_mod.F90.o
   [ 96%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/emissions_mod.F90.o
   [ 96%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/cleanup.F90.o
   [ 98%] Linking Fortran static library libGeosCore.a
   [ 98%] Built target GeosCore
   Scanning dependencies of target gcclassic
   [ 98%] Building Fortran object src/CMakeFiles/gcclassic.dir/GEOS-Chem/Interfaces/GCClassic/main.F90.o
   [100%] Linking Fortran executable ../bin/gcclassic
   [100%] Built target gcclassic

.. tip::

   The :command:`-j` argument tells :command:`make` that it can
   execute as many jobs as it wants simultaneously. For example, if
   you have 8 cores, then the build process may attempt to compile 8
   files at a time.

   If you want to restrict the number of simultaneous jobs (e.g. you
   are compiling on a machine with limited memory), you can can use
   e.g. :command:`make -j4`, which should only try to compile 4 files
   at a time.

.. _install-the-geos-executable-in-your-run-directory:

2. Install the executable in your run directory
-----------------------------------------------

Now that the :file:`gcclassic` executable is built, install it to your
run directory with :command:`make install`. For this to work properly,
you must tell CMake where to find your run directory by configuring
CMake with :envvar:`-DRUNDIR=/path/to/run/directory` :ref:`as
described above <configure-your-build>`.  Type:

.. code-block:: console

    $ make install

and you will see output similar to this:

.. code-block:: console

   [  1%] Built target HeadersHco
   [  3%] Built target KPP_FirstPass
   [  3%] Built target Isorropia
   [  4%] Built target JulDayHco
   [ 13%] Built target Headers
   [ 18%] Built target NcdfUtilHco
   [ 19%] Built target JulDay
   [ 19%] Built target GeosUtilHco
   [ 25%] Built target NcdfUtil
   [ 40%] Built target HCO
   [ 46%] Built target GeosUtil
   [ 56%] Built target HCOX
   [ 59%] Built target Transport
   [ 62%] Built target History
   [ 63%] Built target ObsPack
   [ 71%] Built target KPP
   [ 71%] Built target HCOI_Shared
   [ 98%] Built target GeosCore
   [100%] Built target gcclassic
   Install the project...
   -- Install configuration: "Release"
   -- Up-to-date: /home/ubuntu/gc_merra2_fullchem/build_info/CMakeCache.txt
   -- Up-to-date: /home/ubuntu/gc_merra2_fullchem/build_info/summarize_build
   -- Up-to-date: /home/ubuntu/gc_merra2_fullchem/gcclassic

Let's now navigate back to the run directory and get a directory
listing:

.. code-block:: console

   $ cd ..
   $ ls
   CodeDir@                             cleanRunDir.sh*
   GEOSChem.Restart.20190701_0000z.nc4  download_data.py*
   HEMCO_Config.rc                      download_data.yml
   HEMCO_Config.rc.gmao_metfields       gcclassic*
   HEMCO_Diagn.rc                       geoschem_config.yml
   HISTORY.rc                           getRunInfo*
   OutputDir/                           metrics.py*
   README                               runScriptSamples@
   archiveRun.sh*                       rundirConfig/
   build/                               species_database.yml
   build_info/

You should now see the :program:`gcclassic` executable and a :file:`build_info`
directory there. GEOS-Chem has now been configured, compiled, and
installed in your run directory.

Please see the :ref:`rundir-files` section for more information about
the contents of the run directory.

You are now ready to run a GEOS-Chem simulation!

.. _how-do-i-make-clean:

How do I make clean?
--------------------

In older versions of GEOS-Chem, you could use a GNU Make command such
as :command:`make clean` or :command:`make realclean` to remove all
object (:file:`.o`), library (:file:`.a`), module (:file:`.mod`)
files, as well as the previously-built executable file from the
GEOS-Chem source code folder.

All of the files created by Cmake during the configuration and
compilation stages are placed in the :file:`build/` folder in your run
directory (or in the location that you have specified with the
:envvar:`-DRUNDIR=/path/to/run/dir` option.).  Therefore, if you
wish to build the :program:`GEOS-Chem Classic` executable from
scratch, all you have to do is to remove all of the files from the
build folder.  It's as simple as that!

You can also create a new build folder with this command:

.. code-block:: console

   $ mv build was.build
   $ mkdir build

and then later on, you can remove the old build folder:

.. code-block:: console

   $ rm -rf was.build

This avoids the temptation to use :command:`rm -rf *`, which can
potentially wipe out all of your files if used incorrectly.
