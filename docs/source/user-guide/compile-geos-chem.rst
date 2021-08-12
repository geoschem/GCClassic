.. _compiling-geos-chem:

Compiling GEOS-Chem
===================

In this chapter, we will describe the basic steps that you need to
compile GEOS-Chem into an executable file.

.. _building-geos-chem:

Use CMake to configure and build GEOS-Chem
------------------------------------------

You should think of `CMake <http://cmake.org>`_ as an interactive tool
for configuring GEOS-Chem's build. For example, compile-time options
like disabling multithreading and turning on components (e.g. APM,
RRTMG) are all configured with CMake commands.

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

Navigate to your run directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Navigate to the build directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The build directory is where CMake and your compilers are going to put
the files they generate. For this example, we will use the :file:`build/`
folder that was automatically generated in the GEOS-Chem Classic run
directory. For GCHP you will need to create one.

.. code-block:: console

    $ cd build

.. tip:: If you find yourself switching between different compilers,
	 you can create multiple build directories with different
	 names (e.g. :file:`build_gfortran10`, :file:`build_ifort19`, etc).

.. _initialize-your-build-directory:

Initialize the build directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Next, we need to initialize the build directory. Type:

.. code-block:: console

    $ cmake ../CodeDir -DRUNDIR=..

where :file:`../CodeDir` is the symbolic link from our run directory
to the GEOS-Chem source code directory. CMake will
generate output similar to this:

.. code-block:: text

    =================================================================
    GCClassic 13.0.0 (top-level wrapper)
    Current status: 13.0.0-beta.1-16-ged3eabe.dirty
    =================================================================
    -- Useful CMake variables:
      + CMAKE_PREFIX_PATH:    /path/to/libraries/...
      + CMAKE_BUILD_TYPE:     Release
    -- Run directory setup:
      + RUNDIR:       ..
    -- Bootstrapping  ..
    -- Threading:
      * OMP:          *ON*  OFF
    -- General settings:
      * CUSTOMMECH:   ON  *OFF*
      * BPCH_DIAG:    ON  *OFF*
      * USE_REAL8:    *ON*  OFF
    -- Components:
      * TOMAS:        ON  *OFF*
      * TOMAS_BINS:   *NA* 15 40
      * APM:          ON  *OFF*
      * RRTMG:        ON  *OFF*
      * GTMM:         ON  *OFF*
      * HCOSA:        ON  *OFF*
      * LUO_WETDEP:   ON  *OFF*
    =================================================================
    HEMCO 3.0.0
    Current status: 3.0.0-beta.0-2-g777c2ae.dirty
    =================================================================
    -- Settings:
      * OMP:          *ON*  OFF
      * USE_REAL8:    *ON*  OFF
    =================================================================
    GEOS-Chem 13.0.0 (science codebase)
    Current status: gcc_13.0.0-alpha.13-93-gdc4999053
    =================================================================
    Creating /home/gc_4x5_fullchem/CodeDir/src/GEOS-Chem/Interfaces/GCClassic/gc_classic_version.H
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /home/gc_4x5_fullchem/build=

Your CMake command's output contains important information about your
build's configuration.

.. _configure-your-build:

Configure your build
~~~~~~~~~~~~~~~~~~~~

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

.. tip:: If you are colorblind or if you are using a terminal that
	 does not support colors, refer to the CMake FAQ for
	 instructions on disabling colorized output. For a detailed
	 explanation of CMake output, see the next section.

The table below contains the list of GEOS-Chem build options that you
can pass to CMake. GEOS-Chem will be compiled with the default build
options, unless you explicitly specify otherwise.

:file:`RUNDIR`
  Defines the path tho the run directory.

  In this example, our build directory is a subfolder of the run
  directory, so we can use :option:`-DRUNDIR=..`.  If your build
  directory is somewhere else, then specify the path to the run
  directory as an absolute path.

:file:`CMAKE_BUILD_TYPE`
  Specifies how to build GEOS-Chem Classic:

  :option:`-DCMAKE_BUILD_TYPE=Release`
    Turns on compiler optimizations for balancing speed and numerical
    stability. Use this option for production runs and benchmarking.

  :option:`-DCMAKE_BUILD_TYPE=Debug`
    Turns on several runtime error checks.  This will make it easier
    to find errors but will adversely impact performance. Only use
    this option if you are actively debugging.

:file:`MECH`
   Specifies the chemistry mechanism to be used.  Currently there
   are only two options:

   :option:`-DMECH=fullchem`
     Activates the default "fullchem" mechanism.  The source code
     files that define this mechanism are stored in :file:`KPP/fullchem`.

   :option:`-DMECH=custom`
     Activates a custom mechanism defined by the user.  The source
     code files that define this mechanism are stored in :file:`KPP/custom.`.

:file:`OMP`
  Toggles OpenMP parallelization on (:option:`-DOMP=y`) or off
  (:option:`-DOMP=y`).

  OpenMP parallelization is turned on by default.

:file:`BPCH_DIAG`
  Toggles the legacy binary punch diagnostics on
  (:option:`-DBPCH_DIAG=y`) or off (:option:`-DBPCH_DIAG=n`).
  Builds GEOS_Chem with binary punch diagnostics.

  Binary punch diagnostics are turned off by default.  Except for a
  few diagnostics, these have been replaced by the :ref:`netCDF-based
  History diagnostics <history_diagnostics>`.

:file:`USE_REAL8`
  This defines the default floating-point precision for GEOS-Chem
  Classic.  By default :option:`-DUSE_REAL8=y` is used.

  You should not compile with :option:`-DUSE_REAL8=n`, as this will
  likely result in an error caused by numerical roundoff and
  underflow.  This option is still experimental.

:file:`TOMAS` and :file:`TOMAS_BINS`
  Toggles the `TOMAS aerosol microphysics package
  <http://wiki.geos-chem.org/TOMAS_aerosol_microphysics>`_  on
  (:option:`-DTOMAS=y`) or off (:option:`-DTOMAS=n`).

  You may also set the number of size bins to 15
  (:option:`-DTOMAS_BINS=15`) or 40 (:option:`-DTOMAS_BINS=40`).

  TOMAS is turned off by default.

:file:`APM`
  Toggles the `APM microphysics package
  <http://wiki.geos-chem.org/APM_aerosol_microphysics>`_ on
  (:option:`-DAPM=y`) or off (:option:`-DAPM=n`).

  APM is turned off by default.

:file:`RRTMG`
  Toggles the RRTMG radiative transfer model on (:option:`-DRRTMG=y`)
  or off (:option:`-DRRTMG=n`).

  RRTMG is turned off by default.

:file:`LUO_WETDEP`
  Toggles the Luo et al 2020 wet deposition scheme on (:option:`-DLUO_WETDEP=y`)
  or off (:option:`-DLUO_WETDEP=n`).

  The Luo et al 2020 wet deposition scheme is turned off by default.

  .. note:: The Luo et al 2020 wet deposition scheme will eventually
	    become the default wet deposition schem in GEOS-Chem.  We
	    have made it an option for the time being while further
	    evaluation is being done.

For example if you wanted to build GEOS-Chem with all debugging flags
on, you would type:

.. code-block:: console

    $ cmake . -DCMAKE_BUILD_TYPE=Debug

or if you wanted to turn off OpenMP parallelization (so that GEOS-Chem
executes only on one computational core), you would type:

.. code-block:: console

   $ cmake . -DOMP=n

etc.

If you plan to use the :option:`make -j install` option (recommended)
to copy your executable to your run directory, you must reconfigure
CMake with the :option:`-DRUNDIR` option. Multiple run directories can
be specified by a semicolon separated list. A warning is issues if one
of these directories does not look like a run directory. These paths
can be relative paths or absolute paths. Relative paths are
interpreted as relative to your build directory. For example:

.. code-block:: console

    $ cmake . -DRUNDIR=/path/to/rundir

.. _understand-the-output-from-cmake:

Understand the output from CMake
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As you can see from the example CMake output listed above, GEOS-Chem
Classic 13.0.0 and later versions contain code from 3 independent repositories:

1. GCClassic wrapper (aka "the superproject"),
   `https://github.com/geoschem/GCClassic.git <https://github.com/geoschem/GCClassic.git>`_:

.. code-block::

    =================================================================
    GCClassic 13.0.0 (superproject wrapper)
    Current status: 13.0.0-alpha.8-27-g1158ac1.dirty
    ==================================================================

2. HEMCO (Harmonized Emissions Component) submodule,
   `https://github.com/geoschem/hemco.git <https://github.com/geoschem/hemco.git>`_:

.. code_block::

    =================================================================
    HEMCO 3.0.0
    Current status: gcc_13.0.0-alpha.4-12-g3b0a804
    ==================================================================

3. GEOS-Chem submodule, `https://github.com/geoschem/geos-chem.git
   <https://github.com/geoschem/geos-chem.git>`_:

.. code-block::

   =================================================================
   GEOS-Chem 13.0.0 (science codebase)
   Current status: gcc_13.0.0-alpha.8-57-gdd726b48
   ==================================================================

During the build configuration stage, CMake will display the VERSION
NUMBER (e.g. :file:`13.0.0`) as well as the CURRENT STATUS OF THE GIT
REPOSITORY (e.g. :file:`13.0.0-alpha.8-27-g1158ac1.dirty` for GCClassic,
GEOS-Chem, and HEMCO.

Let's take the Git repository status of GCClassic as our example. The
status string uses the same format as the :command:`git describe
--tags` command, namely:

.. code-block:: text

    13.0.0-alpha.8-27-g1158ac1.dirty

where

  :file:`13.0.0-alpha.8`
      Indicates the most recent tag in the GCClassic superproject
      repository.

  :file:`27`
      Indicates the number of commits that were made atop 13.0.0-alpha.8.

  :file:`g`
      Indicates that the version control system is Git.

  :file:`1158ac1`
      Indicates the Git commit (short form) at the HEAD of the
      GCClassic repository.

  :file:`.dirty`
      Indicates that there are uncommitted updates atop the :file:`1158ac1`
      commit in the GCClassic repository.

Under each header are printed the various :ref:`options that have been
selected <configure-your-build>`.

.. _compile-geos-chem:

Compile GEOS-Chem
-----------------

Now that CMake has created the Makefiles that are needed to compile
GEOS-Chem, you may proceed as follows:

Build the GEOS-Chem Classic executable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the :command:`make` command to build the GEOS-Chem executable.  Type:

.. code-block:: console:

    $ make -j

You will see output similar to this:

.. code-block:: text

    [  1%] Built target KPPFirstPass_fullchem
    [  3%] Built target HeadersHco
    [  4%] Building Fortran object src/GEOS-Chem/ISORROPIA/CMakeFiles/Isorropia.dir/isorropiaII_main_mod.F.o
    [  6%] Built target JulDayHco
    [  6%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/state_chm_mod.F90.o
    [  6%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/state_met_mod.F90.o
    [  7%] Building Fortran object src/HEMCO/src/Shared/NcdfUtil/CMakeFiles/NcdfUtilHco.dir/hco_ncdf_mod.F90.o
    [  7%] Linking Fortran static library libNcdfUtilHco.a
    [ 10%] Built target NcdfUtilHco
    Scanning dependencies of target GeosUtilHco
    [ 12%] Building Fortran object src/HEMCO/src/Shared/GeosUtil/CMakeFiles/GeosUtilHco.dir/hco_henry_mod.F90.o
    [ 12%] Building Fortran object src/HEMCO/src/Shared/GeosUtil/CMakeFiles/GeosUtilHco.dir/hco_regrid_a2a_mod.F90.o
    [ 13%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/state_diag_mod.F90.o
    [ 13%] Linking Fortran static library libGeosUtilHco.a
    [ 13%] Built target GeosUtilHco
    ...
    [ 98%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/gc_environment_mod.F90.o
    [ 98%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/chemistry_mod.F90.o
    [ 98%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/cleanup.F90.o
    [ 98%] Linking Fortran static library libGeosCore.a
    [ 98%] Built target GeosCore
    Scanning dependencies of target geos
    [ 98%] Building Fortran object src/CMakeFiles/geos.dir/GEOS-Chem/Interfaces/GCClassic/main.F90.o
    [100%] Linking Fortran executable ../bin/geos
    [100%] Built target geos

.. tip:: The :option:`-j` argument tells :command:`make` that it can
	 execute as many jobs as it wants simultaneously. For
	 example, if you have 8 cores, then the build process may
	 attempt to compile 8 files at a time.

	 If you want to restrict the number of simultaneous jobs
	 (e.g. you are compiling on a machine with limited memory),
	 you can can use e.g. :command:`make -j4`, which should only
	 try to compile 4 files at a time.

.. _install-the-geos-executable-in-your-run-directory:

Install the executable in your run directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now that the :file:`gcclassic` executable is built, install it to your
run directory with :command:`make install`. For this to work properly,
you must tell CMake where to find your run directory by configuring
CMake with :option:`-DRUNDIR` :ref:`as described above
<configure-your-build>`.  Type:

.. code-block:: console:

    $ make install

and you will see output similar to this:

.. code-block:: text

    [  1%] Built target KPPFirstPass_fullchem
    [ 10%] Built target Headers
    [ 10%] Built target JulDay
    [ 16%] Built target NcdfUtil
    [ 22%] Built target GeosUtil
    [ 25%] Built target Transport
    [ 27%] Built target HeadersHco
    [ 28%] Built target JulDayHco
    [ 33%] Built target NcdfUtilHco
    [ 34%] Built target GeosUtilHco
    [ 50%] Built target HCO
    [ 59%] Built target HCOX
    [ 59%] Built target HCOI_Shared
    [ 65%] Built target KPP_fullchem
    [ 68%] Built target History
    [ 69%] Built target ObsPack
    [ 71%] Built target Isorropia
    [ 98%] Built target GeosCore
    [100%] Built target geos
    Install the project...
    -- Install configuration: "Release"
    -- Installing: /n/home05/msulprizio/RD/gc_4x5_fullchem/build_info/CMakeCache.txt
    -- Installing: /n/home05/msulprizio/RD/gc_4x5_fullchem/build_info/summarize_build
    -- Installing: /n/home05/msulprizio/RD/gc_4x5_fullchem/gcclassic
    [gc_fullchem_4x5/build]$

Let's now navigate back to the run directory and get a directory
listing:

.. code-block:: text

    $ cd ..
    $ ls
    archiveRun.sh*     GEOSChem.Restart.20190701_0000z.nc4  OutputDir/
    build/             getRunInfo*                          README
    build_info/        HEMCO_Config.rc                      rundir.version
    cleanRunDir.sh*    HEMCO_Diagn.rc                       runScriptSamples/
    CodeDir@           HISTORY.rc                           species_database.yml
    download_data.py*  input.geos
    gcclassic*         metrics.py*
    $

You should now see the :program:`gcclassic` executable and a :file:`build_info`
directory there. GEOS-Chem has now been configured, compiled, and
installed in your run directory.

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
:option:`RUNDIR` option.).  Therefore, if you wish to build the
GEOS-Chem Classic executable from scratch, all you have to do is to
remove all of the files from the build folder.  It's as simple as that!

You can also create a new build folder with this command:

.. code-block:: console

   $ mv build was.build
   $ mkdir build

and then later on, you can remove the old build folder:

.. code-block:: console

   $ rm -rf was.build

This avoids the temptation to use :command:`rm -rf *`, which can
potentially wipe out all of your files if used incorrectly.
