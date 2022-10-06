.. _compile-cmake:

####################
Configure with CMake
####################

You should think of `CMake <http://cmake.org>`_ as an interactive tool
for configuring GEOS-Chem Classic's build. For example,
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

.. _compile-cmake-step1:

==============================
Navigate to your run directory
==============================

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

.. _compile-cmake-step2:

===============================
Navigate to the build directory
===============================

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

.. _compile-cmake-step3:

==============================
Initialize the build directory
==============================

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

.. _compile-cmake-step4:

=======================================
Configure your build with extra options
=======================================

Your build directory is now configured to compile GEOS-Chem using all
default options. If you do not wish to change anything further,
you may :ref:`skip ahead to the next section <compile-cmake-understand>`.

However, if you wish to modify your build's configuration, simply invoke
CMake once more with optional parameters. Use this format:

.. code-block:: console

   $ cmake . -DOPTION=value

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

.. option:: RUNDIR

   Defines the path to the run directory.

   In this example, our build directory is a subfolder of the run
   directory, so we can use :code:`-DRUNDIR=..`.  If your build
   directory is somewhere else, then specify the path to the run
   directory as an absolute path.

.. option:: CMAKE_BUILD_TYPE

   Specifies the type of build.  Accepted values are:

   .. option:: Release

      Tells CMake to configure GEOS-Chem in **Release** mode.  This
      means that all optimizations will be applied and all debugging
      options will be disabled. **(Default option)**.

   .. option:: Debug

      Turns on several runtime error checks.  This will make it easier
      to find errors but will adversely impact performance. Only use
      this option if you are actively debugging.

.. option:: MECH

   Specifies the chemical mechanism that you wish to use:

   .. option:: fullchem

      Activates the **fullchem** mechanism.  The source code
      files that define this mechanism are stored in
      :file:`KPP/fullchem`. **(Default option)**

   .. option:: Hg

      Activates the **Hg** mechanism.  The source code
      files that define this mechanism are stored in :file:`KPP/Hg`.

   .. option:: custom

      Activates a **custom** mechanism defined by the user.  The
      source code files that define this mechanism are stored in
      :file:`KPP/custom.`.

.. option:: OMP

   Determines if GEOS-Chem Classic will activate `OpenMP parallelization
   <http://wiki.geos-chem.org/Parallelizing_GEOS-Chem>`_.  Accepted
   values are:

   .. option:: y

      Activates OpenMP parallelization.  **(Default option)**

      GEOS-Chem Classic will execute on as many computational cores as
      is specified with :option:`OMP_NUM_THREADS`.

   .. option:: n

      Deactivates OpenMP parallelization.  GEOS-Chem Classic will
      execute on a single computational core.  Useful for debugging.

.. option:: TOMAS

   Configure GEOS-Chem with the `TOMAS aerosol
   microphysics package
   <http://wiki.geos-chem.org/TOMAS_aerosol_microphysics>`_.  Accepted
   values are:

   .. option:: y

      Activate TOMAS microphysics.

   .. option:: n

      Deactivate TOMAS microphysics **(Default option)**

.. option:: TOMAS_BINS

   Specifies the number of size-resolved bins for TOMAS.  Accepted
   values are:

   .. option:: 15

      Use 15 size-resolved bins with TOMAS simulations.

   .. option:: 40

      Use 40 size-resolved bins with TOMAS simulations.

.. option:: BPCH_DIAG

   Toggles the legacy binary punch diagnostics on.

   .. attention::

      This option is deprecated and will be removed soon.  Most
      binary-punch format diagnostics have been replaced by
      :ref:`netCDF-based History diagnostics <history-diagnostics>`.

   Accepted values are:

   .. option:: y

      Activate legacy binary-punch diagnostics.

   .. option:: n

      Deactivate legacy binary-punch diagnostics. **(Default option)**

.. option:: APM

   Configures GEOS-Chem to use the `APM microphysics package
   <http://wiki.geos-chem.org/APM_aerosol_microphysics>`_. Accepted
   values are:

   .. option:: y

      Activate APM microphysics.

   .. option:: n

      Deactivate APM microphysics. **(Default option)**

.. option:: RRTMG

   Configures GEOS-Chem to use the `RRTMG radiative transfer model
   <https://wiki.geos-chem.org/Coupling_RRTMG_to_GEOS-Chem>`_.
   Accepted values are:

   .. option:: y

      Activates the RRTMG radiative transfer model.

   .. option:: n

      Deactivates the RRTMG radiative transfer model. **(Default option)**

.. option:: LUO_WETDEP

   Configures GEOS-Chem to use the `Luo et al., 2020
   <https://gmd.copernicus.org/articles/13/2879/2020/>`_ wet deposition
   scheme.

   .. note::

      The Luo et al 2020 wet deposition scheme will eventually
      become the default wet deposition schem in GEOS-Chem.  We
      have made it an option for the time being while further
      evaluation is being done.

   Accepted values are:

   .. option:: y

      Activates the Luo et al., 2020 wet deposition scheme.

   .. option:: n

      Deactivates the Luo et al., 2020 wet deposition scheme. **(Default
      option)**

If you plan to use the :command:`make -j install` option (recommended)
to copy your executable to your run directory, you must reconfigure
CMake with the :command:`RUNDIR=/path/to/run/dir`
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

.. _compile-cmake-understand:

=======================
Understand CMake output
=======================

As you can see from the example CMake output listed above, GEOS-Chem
Classic contains code from 3 independent repositories:

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
selected <cfg>`.
