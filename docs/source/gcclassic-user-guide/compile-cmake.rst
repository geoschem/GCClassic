.. |br| raw:: html

   <br/>

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

   $ cd /path/to/gc_4x5_merra2_fullchem
   $ ls
   archiveRun.sh*     download_data.py*    HEMCO_Config.rc.gmao_metfields  README.md
   build/             download_data.yml    HEMCO_Diagn.rc                  Restarts/
   cleanRunDir.sh*    geoschem_config.yml  HISTORY.rc                      runScriptSamples@
   CodeDir@           getRunInfo*          metrics.py*                     species_database.yml
   CreateRunDirLogs/  HEMCO_Config.rc      OutputDir/

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

   -- The Fortran compiler identification is GNU 12.2.0
   -- Detecting Fortran compiler ABI info
   -- Detecting Fortran compiler ABI info - done
   -- Check for working Fortran compiler: /path/to/gcc/12.2.0/bin/gfortran
   =================================================================
   GCClassic X.Y.Z (superproject wrapper)
   Current status: X.Y.Z
   =================================================================
   -- Found NetCDF: /n/sw/helmod-rocky8/apps/MPI/gcc/12.2.0-fasrc01/openmpi/4.1.4-fasrc01/netcdf-fortran/4.6.0-fasrc02/lib/libnetcdff.so
   -- Useful CMake variables:
     + CMAKE_PREFIX_PATH:    /path/to/netcdf-c
     ...             /path/to/netcdf-fortran/
     + CMAKE_BUILD_TYPE:     Release
   -- Run directory setup:
     + RUNDIR:       /path/to/run/directory
   -- Threading:
     * OMP:          *ON*  OFF
   -- Found OpenMP_Fortran: -fopenmp (found version "4.5")
   -- Found OpenMP: TRUE (found version "4.5")
   -- General settings:
     * MECH:         *fullchem*  carbon  Hg  custom
     * USE_REAL8:    *ON*  OFF
     * SANITIZE:     ON  *OFF*
   -- Components:
     * TOMAS:        ON  *OFF*
     * TOMAS_BINS:   *NA*  15  40
     * APM:          ON  *OFF*
     * RRTMG:        ON  *OFF*
     * GTMM:         ON  *OFF*
     * HCOSA:        ON  *OFF*
     * KPPSA:        ON  *OFF*
     * LUO_WETDEP:   ON  *OFF*
     * FASTJX:       ON  *OFF*
   =================================================================
   HEMCO A.B.C
   Current status: A.B.C
   =================================================================
   =================================================================
   HETP D.E.F
   =================================================================
   =================================================================
   Cloud-J G.H.I
   Current status: 8.0.2
   =================================================================
   =================================================================
   GEOS-Chem X.Y.Z (science codebase)
   Current status: X.Y.Z
   =================================================================
   -- KPP integrator (read from fullchem.kpp):
     + KPP_INTEGRATOR_NAME:          rosenbrock_autoreduce
     * KPP_INTEGRATOR_AUTOREDUCE:    *ON*  OFF
   Creating /path/to/run/directory/CodeDir/src/GEOS-Chem/Interfaces/GCClassic/gc_classic_version.H
   -- Configuring done
   -- Generating done
   -- Build files have been written to: /path/to/run/directory/build

Your CMake command's output contains important information about your
build's configuration.

.. note::

   The text :literal:`X.Y.Z`, :literal:`A.B.C`, :literal:`D.E.F.`,
   and :literal:`G.H.I`
   refer to the version numbers (in `semantic versioning
   <https://semver.org>`_ style) of the :ref:`get-code-repos-gcclassic`,
   :ref:`get-code-repos-hemco`, :ref:`get-code-repos-other-hetp`, and
   :ref:`get-code-repos-other-cloudj` repositories, respectively.

   The :ref:`get-code-repos-gc-sci` and GCClassic repositories share
   the same version number :literal:`X.Y.Z`.


.. _compile-cmake-step4:

=======================================
Configure your build with extra options
=======================================

Your build directory is now configured to compile GEOS-Chem using all
default options. If you do not wish to change anything further,
you may :ref:`skip ahead to the next section <compile-cmake-understand>`.

However, if you wish to modify your build's configuration, simply invoke
:program:`CMake` once more with optional parameters. Use this format:

.. code-block:: console

   $ cmake . -DOPTION=value

Note that the :literal:`.` argument is necessary. It tells
:program:`CMake` that your current working directory (i.e. :file:`.`)
is your build directory.

For example, to compile GEOS-Chem Classic with all debugging flags
turned on, use:

.. code-block:: console

   $ cmake . -DCMAKE_BUILD_TYPE=Debug

Or to turn off OpenMP parallelization (so that GEOS-Chem Classic will
execute on only one computational core), use:

.. code-block:: console

   $ cmake . -DOMP=n

The output of :program:`CMake` tells you about your build's
configuration. Options are prefixed by a :literal:`+` or :literal:`\*`
in the output, and their values are displayed or highlighted.

.. tip::

  If you are colorblind or if you are using a terminal that
  does not support colors, refer to the CMake FAQ for
  instructions on disabling colorized output. For a detailed
  explanation of CMake output, see the next section.

The table below contains the list of GEOS-Chem build options that you
can pass to :program:`CMake`. GEOS-Chem will be compiled with the
default build options, unless you explicitly specify otherwise.

RUNDIR
------

Defines the path to the run directory.  This is the path where the
:command:`make -j install` will copy the GEOS-Chem Classic executable
upon successful compilation.

In this example, our build directory is a subfolder of the run
directory, so we can use :code:`-DRUNDIR=..`.  If your build directory
is somewhere else, then specify the path such as:

.. code-block:: console

   $ cmake . -DRUNDIR=/path/to/run/dir

Multiple run directories can be specified by a semicolon separated
list. A warning will be issued if one of these directories does
not look like a run directory. Run directory paths can be relative
paths or absolute paths. Relative paths are interpreted as relative to
your build directory.

CMAKE_BUILD_TYPE
----------------

 Specifies the type of build.  Accepted values are:

.. option:: Release

   Tells CMake to configure GEOS-Chem in **Release** mode.  This
   means that all optimizations will be applied and all debugging
   options will be disabled. **(Default option)**.

.. option:: Debug

   Turns on several runtime error checks.  This will make it easier
   to find errors but will adversely impact performance. Only use
   this option if you are actively debugging.

MECH
----

Specifies the chemical mechanism that you wish to use:

.. option:: fullchem

   Activates the **fullchem** mechanism.  The source code
   files that define this mechanism are stored in
   :file:`KPP/fullchem`. **(Default option)**

.. option:: Hg

   Activates the **Hg** mechanism.  The source code
   files that define this mechanism are stored in :file:`KPP/Hg`.

.. option:: carbon

   Activates the **carbon** mechanism (CH4-CO-CO2-OCS).  The source
   code files that define this mechanism are stored in
   :file:`KPP/carbon`.

.. option:: custom

   Activates a **custom** mechanism defined by the user.  The
   source code files that define this mechanism are stored in
   :file:`KPP/custom`.

OMP
---

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

TOMAS
-----

Configure GEOS-Chem with the `TOMAS aerosol
microphysics package
<http://wiki.geos-chem.org/TOMAS_aerosol_microphysics>`_.  Accepted
values are:

.. option:: y

   Activate TOMAS microphysics.

.. option:: n

   Deactivate TOMAS microphysics **(Default option)**

TOMAS_BINS
----------

Specifies the number of size-resolved bins for TOMAS.  Accepted
values are:

.. option:: 15

   Use 15 size-resolved bins with TOMAS simulations.

.. option:: 40

   Use 40 size-resolved bins with TOMAS simulations.

APM
---

Configures GEOS-Chem to use the `APM microphysics package
<http://wiki.geos-chem.org/APM_aerosol_microphysics>`_. Accepted
values are:

.. option:: y

   Activate APM microphysics.

.. option:: n

   Deactivate APM microphysics. **(Default option)**

RRTMG
-----

Configures GEOS-Chem to use the `RRTMG radiative transfer model
<https://wiki.geos-chem.org/Coupling_RRTMG_to_GEOS-Chem>`_.
Accepted values are:

.. option:: y

   Activates the RRTMG radiative transfer model.

.. option:: n

   Deactivates the RRTMG radiative transfer model. **(Default option)**


HCOSA
-----

Compiles the `HEMCO Standalone Model
<https://hemco.readthedocs.io/en/stable/hco-sa-guide/intro.html>`_
executable.


KPPSA
-----

Compiles the :ref:`KPP-Standalone Box Model <kppsa-guide>` executable.


LUO_WETDEP
----------

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

FASTJX
------

Configures GEOS-Chem to use the legacy FAST-JX v7.0 photolysis
mechanism instead of its successor
:ref:`get-code-repos-other-cloudj`.

.. note::

   We recommend using FAST-JX for the mercury simulation
   instead of Cloud-J. Further work is needed to make the
   mercury simulation compatible with Cloud-J. Once that work
   is completed the legacy FAST-JX option will be deleted from
   the model.

Accepted values are:

.. option:: y

   Uses the legacy FAST-JX v7.0 photolysis scheme rather than Cloud-J.

.. option:: n

   Uses the Cloud-J photolyis scheme rather than legacy FAST-JX. **(Default
   option)**

SANITIZE
--------

Activates the AddressSanitizer/LeakSanitizer functionality in GNU Fortran to
identify memory leaks.  Accepted values are:

.. option:: y

   Activates AddressSanitizer/LeakSanitizer

.. option:: n

   Deactivates AddressSanitizer/LeakSanitizer **(Default option)**.

.. _compile-cmake-understand:

=======================
Understand CMake output
=======================

As you can see from the example CMake output listed above, GEOS-Chem
Classic contains code from the various repositories:

#. `GCClassic wrapper (aka "the superproject") <https://github.com/geoschem/GCClassic.git>`_:

   .. code-block:: none

      =================================================================
      GCClassic X.Y.Z (superproject wrapper)
      Current status: X.Y.Z
      =================================================================

   where :literal:`X.Y.Z` specifies  the GEOS-Chem Classic "major",
   "minor", and "patch" version numbers.

   .. note::

      If you are cloning GEOS-Chem Classic between official releases, you
      may the see :code:`Current status` reported like this:

      .. code-block:: console

         X.Y.Z-alpha.n-C-gabcd1234.dirty  or

         X.Y.Z.rc.n-C.gabcd1234.dirty

      We will explain these formats below.

#. `HEMCO (Harmonized Emissions Component) submodule <https://github.com/geoschem/hemco.git>`_:

   .. code-block:: none

      =================================================================
      HEMCO A.B.C
      Current status: A.B.C
      =================================================================

   where :literal:`A.B.C` specifies the HEMCO "major", "minor", and
   "patch" version numbers. The HEMCO version number differs from
   GEOS-Chem because it is kept in a separate repository, and is
   considered a separate package. |br|
   |br|

#. `GEOS-Chem submodule <https://github.com/geoschem/geos-chem.git>`_:

   .. code-block:: none

      =================================================================
      GEOS-Chem X.Y.Z (science codebase)
      Current status: X.Y.Z
      =================================================================

   The GEOS-Chem science codebase and GEOS-Chem Classic wrapper will
   always share the same version number.

   During the build configuration stage, CMake will display the **version
   number** (e.g. :literal:`X.Y.Z`) as well as the **current status of the Git
   repository** (e.g. :literal:`TAG-C-gabcd1234.dirty`) for GCClassic,
   GEOS-Chem, and HEMCO. |br|
   |br|

#. Similar messages will be displayed for the
   :ref:`get-code-repos-other-cloudj` and
   :ref:`get-code-repos-other-hetp` repositories. |br|
   |br|


Let's take the Git repository status of GCClassic as our example. The
status string uses the same format as the :command:`git describe
--tags` command, namely:

.. code-block:: text

    TAG-C-gabcd1234.dirty

where

.. option:: TAG

    Indicates the most recent tag in the `GCClassic superproject
    repository <https://github.com/geoschem/GCClassic>`_.

    Tags may use the following notations:

    - :literal:`X.Y.Z`: Denotes an official release
    - :literal:`X.Y.Z-rc.n`: Denotes a release candidate
    - :literal:`X.Y.Z-alpha.n`: Denotes an internal "alpha" benchmark

    where :literal:`n` is the number of the release candidate or alpha
    benchmark (starting from 0).

.. option:: C

   Indicates the number of commits that were made on top of the commit
   that is referred to by :option:`TAG`.

.. option:: g

   Indicates that the version control system is Git.

.. option:: abcd1234

   Indicates the Git commit hash. This is an alphanumeric string that
   denotes the commit at the :literal:`HEAD` of the GCClassic repository.

.. option:: .dirty

   If present, indicates that there are uncommitted updates atop the
   :option:`abcd1234` commit in the GCClassic repository.

Under each header are printed the various :ref:`options that have been
selected <cfg>`.
