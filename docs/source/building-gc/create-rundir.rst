.. _create-rundir:

######################
Create a run directory
######################

We have greatly simplified run directory creation in `GEOS-Chem
13.0.0 <GEOS-Chem_13.0.0>`__ and later versions. You no longer need to
download the separate `GEOS-Chem Unit Tester <GEOS-Chem_Unit_Tester>`__
repository any longer, but can create run directories from a script in
the GEOS-Chem source code itself.

.. _example1-fullchem:

===========================================================
Example 1: Create a full-chemistry simulation run directory
===========================================================

Let us walk through the process of creating a run directory for a global
GEOS-Chem full-chemistry simulation.

**1.** Navigate to the GCClassic superproject folder and get a
directory listing:

.. code-block:: console

   $ cd /path/to/your/GCClassic
   $ ls -CF

You should see this output:

.. code-block::

   AUTHORS.txt     CMakeScripts/    LICENSE.txt  SUPPORT.md  run@  test@
   CMakeLists.txt  CONTRIBUTING.md  README.md    docs/       src/

As mentioned previously, :file:`run@` is a symbolic link. It actually
points to the to the :file:`src/GEOS-Chem/run/GCClassic` folder. This
folder contains several scripts and template files for run directory
creation.

**2.** Navigate to the run folder and get a directory listing:

.. code-block:: console

   $ cd run
   $ ls -CF

and you should see this output:

.. code-block:: console

   HEMCO_Config.rc.templates/  geoschem_config.yml.templates/
   HEMCO_Diagn.rc.templates/   getRunInfo*
   HISTORY.rc.templates/       gitignore
   README                      init_rd.sh*
   archiveRun.sh*              runScriptSamples/
   createRunDir.sh*

You can see several folders (highlighted in the directory display with
:file:`/`) and a few executable scripts (highlighted with :file:`*`).
The script we are interested in is :file:`createRunDir.sh`.

**3.** Run the :file:`createRunDir.sh` script. Type:

.. code-block:: console

   $ ./createRunDir.sh

**4.** You will then be prompted to supply information about the run
directory that you wish to create:

.. code-block:: console

   ===========================================================
   GEOS-CHEM RUN DIRECTORY CREATION
   ===========================================================

   -----------------------------------------------------------
   Choose simulation type:
   -----------------------------------------------------------
      1. Full chemistry
      2. Aerosols only
      3. CH4
      4. CO2
      5. Hg
      6. POPs
      7. Tagged CH4
      8. Tagged CO
      9. Tagged O3
     10. TransportTracers
     11. Trace metals

To create a run directory for the full-chemistry simulation, type
:command:`1` followed by the :command:`ENTER` key.

**5.** You will then be asked to specify any additional options for the
full-chemistry simulation (such as adding the RRTMG radiative transfer
model, APM or TOMAS microphysics, etc.)

.. code-block:: console

   -----------------------------------------------------------
   Choose additional simulation option:
   -----------------------------------------------------------
     1. Standard
     2. Benchmark
     3. Complex SOA
     4. Marine POA
     5. Acid uptake on dust
     6. TOMAS
     7. APM
     8. RRTMG

**5a**: For the standard full-chemistry simulation, type :command:`1`
followed by :command:`ENTER`.

**5b**: To add an option to the full-chemistry simulation, type a
number between :command:`2` and :command:`8` and press
:command:`ENTER`.

**6.** You will then be asked to specify the meteorology type for the
simulation (GEOS-FP or MERRA-2):

.. code-block:: console

   -----------------------------------------------------------
   Choose meteorology source:
   -----------------------------------------------------------
     1. MERRA-2 (Recommended)
     2. GEOS-FP
     3. GISS ModelE2.1 (GCAP 2.0)

You should use the recommended option (MERRA-2) if possible. Type
:command:`1` followed by :command:`ENTER`.

**7.** The next menu will prompt you for the horizontal resolution that
you wish to use:

.. code-block:: console

   -----------------------------------------------------------
   Choose horizontal resolution:
   -----------------------------------------------------------
     1. 4.0  x 5.0
     2. 2.0  x 2.5
     3. 0.5  x 0.625

**7a.** If you wish to set up a global simulation, type either :command:`1`
or :command:`2` followed by :command:`ENTER`.

**7b.** If you wish to set up a nested-grid simulation, type :command:`3` and
hit :command:`ENTER`. Then you will be followed by a nested-grid menu:

.. code-block:: console

   -----------------------------------------------------------
   Choose horizontal grid domain:
   -----------------------------------------------------------
     1. Global
     2. Asia
     3. Europe
     4. North America
     5. Custom

Select your preferred horizontal domain, followed by :command:`ENTER`.

**8.** You will then be prompted for the vertical dimension of the grid.

.. code-block:: console

   -----------------------------------------------------------
   Choose number of levels:
   -----------------------------------------------------------
     1. 72 (native)
     2. 47 (reduced)

**8a.** For most simulations, you will want to use :command:`72` levels. Type
:command:`1` followed by :command:`ENTER`.

**8b.** For some memory-intensive simulations (such as nested-grid
simulations), you can use 47 levels. Type :command:`2`` followed by
:command:`ENTER`.

**9.** You will then be prompted for the folder in which you wish to
create the run directory.

.. code-block:: console

   -----------------------------------------------------------
   Enter path where the run directory will be created:
   -----------------------------------------------------------

**9a.** You can enter an absolute path (such as
:file:`$HOME/myusername/` followed by :command:`ENTER)`.

**9b.** Or you can enter a relative path (such as :file:`~/rundirs`
followed by ENTER). In this case you will see that the
:file:`./createRunDir.sh`  script will expand the path to:

.. code-block:: console

   Expanding to: /n/home09/myusername/rundirs

**10.** The next menu will prompt you for the run directory name.

.. code-block:: console

   -----------------------------------------------------------
   Enter run directory name, or press return to use default:

   NOTE: This will be a subfolder of the path you entered above.
   -----------------------------------------------------------

You should use the default run directory name whenever possible. Type
:command:`ENTER` to select the default.

The script will display the following output:

.. code-block:: console

      -- Using default directory name gc_4x5_fullchem

or if you are creating a nested grid simulation:

.. code-block:: console

      -- Using default directory name gc_05x0625_fullchem

and then:

.. code-block:: console

      -- This run directory has been set up for 20190701 - 20190801.
         You may modify these settings in input.geos.

      -- The default frequency and duration of diagnostics is set to monthly.
         You may modify these settings in HISTORY.rc and HEMCO_Config.rc.

**11.** The last menu will prompt you with:

.. code-block:: console

   -----------------------------------------------------------
   Do you want to track run directory changes with git? (y/n)
   -----------------------------------------------------------

Type :command:`y` and then :command:`ENTER`. Then you will be able to
track changes that you make to GEOS-Chem configuration files with
Git. This can be a lifesaver when debugging -- you can revert to an
earlier state and then start fresh.

**12.** The script will display the full path to the run directory. You
can navigate there and then start editing the GEOS-Chem configuration
files.

.. _example2-ch4:

================================================
Example 2: Create a CH4 simulation run directory
================================================

The process of creating run directories for the GEOS-Chem specialty
simulations is similar to that as listed in Example 1 above. However,
the number of menus that you need to select from will likely be fewer
than for the full-chemistry simulation. We'll use the methane simulation
as an example.

**1.** Navigate to the :file:`GCClassic` superproject folder and get a
d irectory listing:

.. code-block:: console

   $ cd /path/to/your/GCClassic
   $ ls -CF

You should see this output:

.. code-block::

   AUTHORS.txt     CMakeScripts/    LICENSE.txt  SUPPORT.md  run@  test@
   CMakeLists.txt  CONTRIBUTING.md  README.md    docs/       src/

As mentioned previously, run@ is a symbolic link. It actually points
to the to the :file:`src/GEOS-Chem/run/GCClassic` folder. This folder
contains several scripts and template files for run directory creation.

**2.** Navigate to the run folder and get a directory listing:

.. code-block:: console

   $ cd run
   $ ls -CF

and you should see this output:

.. code-block:: console

   HEMCO_Config.rc.templates/  geoschem_config.yml.templates/
   HEMCO_Diagn.rc.templates/   getRunInfo*
   HISTORY.rc.templates/       gitignore
   README                      init_rd.sh*
   archiveRun.sh*              runScriptSamples/
   createRunDir.sh*

You can see several folders (highlighted in the directory display with
:file:`/`) and a few executable scripts (highlighted with :file:`*`).
The script we are interested in is :file:`createRunDir.sh`.

**3.** Run the createRunDir.sh. Type:

.. code-block:: console

     $ ./createRunDir.sh

**4.** You will then be prompted to supply information about the run
directory that you wish to create:

.. code-block:: console

   ===========================================================
   GEOS-CHEM RUN DIRECTORY CREATION
   ===========================================================
   
   -----------------------------------------------------------
   Choose simulation type:
   -----------------------------------------------------------
      1. Full chemistry
      2. Aerosols only
      3. CH4
      4. CO2
      5. Hg
      6. POPs
      7. Tagged CH4
      8. Tagged CO
      9. Tagged O3
     10. TransportTracers
     11. Trace metals

To select the GEOS-Chem methane specialty simulation, type
:command:`3` followed by :command:`ENTER`. 

**5.** You will then be asked to specify the meteorology type for the
simulation (GEOS-FP or MERRA-2):

.. code-block:: console

   -----------------------------------------------------------
   Choose meteorology source:
   -----------------------------------------------------------
     1. MERRA-2 (Recommended)
     2. GEOS-FP 
     3. GISS ModelE2.1 (GCAP 2.0)

To accept the recommended meteorology (MERRA-2), type :command:`1` followed
by :command:`ENTER`. 

**6.** The next menu will prompt you for the horizontal resolution that
you wish to use:

.. code-block:: console

   -----------------------------------------------------------
   Choose horizontal resolution:
   -----------------------------------------------------------
     1. 4.0  x 5.0
     2. 2.0  x 2.5
     3. 0.5  x 0.625

**6a.** If you wish to set up global simulation, type either
:command:`1` or :command:`2` followed by :command:`ENTER`. 

**6b.** If you wish to set up a nested-grid simulation, type
:command:`3` and hit :command:`ENTER`. Then you will be followed by a
nested-grid menu:  

.. code-block:: console

   -----------------------------------------------------------
   Choose horizontal grid domain:
   -----------------------------------------------------------
     1. Global
     2. Asia
     3. Europe
     4. North America
     5. Custom

Type the number of your preferred option and then hit :command:`ENTER`.

**7.** You will then be prompted for the vertical dimension of the grid.

.. code-block:: console

   -----------------------------------------------------------
   Choose number of levels:
   -----------------------------------------------------------
     1. 72 (native)
     2. 47 (reduced)

**7a.** For most simulations, you will want to use 72 levels. Type
:command:`1` followed by :command:`ENTER`.

**7b.** For some memory-intensive simulations (such as nested-grid
simulations), you can use 47 levels. Type :command:`2` followed by
:command:`ENTER`. 
 
**8.** You will then be prompted for the folder in which you wish to
create the run directory.

.. code-block:: console

   -----------------------------------------------------------
   Enter path where the run directory will be created:
   -----------------------------------------------------------

**8a.** You enter this an absolute path (such as
:file:`$HOME/myusername/` followed by ENTER).

**8b.** Or you can enter a relative path (such as :file:`~/rundirs`
followed by ENTER). In this case you will see that the
:file:`./createRunDir.sh` script will expand the path to:

.. code-block:: console

   Expanding to: /n/home09/myusername/rundirs

**9.** The next menu will prompt you for the run directory name.

.. code-block:: console

   -----------------------------------------------------------
   Enter run directory name, or press return to use default:

   NOTE: This will be a subfolder of the path you entered above.
   -----------------------------------------------------------

You should use the default run directory name whenever possible. Type
:command:`ENTER`. The script will display the following output:

.. code-block:: console

      -- Using default directory name gc_4x5_CH4

or if you are creating a nested grid simulation:

.. code-block:: console

      -- Using default directory name gc_05x0625_CH4

.. code-block:: console

      -- This run directory has been set up for 20190701 - 20190801.
         You may modify these settings in input.geos.

      -- The default frequency and duration of diagnostics is set to monthly.
         You may modify these settings in HISTORY.rc and HEMCO_Config.rc.

**10.** The last menu will prompt you with:

.. code-block:: console

   -----------------------------------------------------------
   Do you want to track run directory changes with git? (y/n)
   -----------------------------------------------------------

Type :command:`y` and then :command:`ENTER`. Then you will be able to
track changes that you make to GEOS-Chem configuration files with
Git. This can be a lifesaver when debugging -- you can revert to an
earlier state and then start fresh.

**11.** The script will display the full path to the run directory. You
can navigate there and then start editing the GEOS-Chem configuration
files.

.. _rundir-files:

===============================
Run directory files and folders
===============================

In each run directory there are several **user-editable configuration
files** that you can use to control the runtime behavior of GEOS-Chem.
These files (:file:`geoschem_config.yml`, :file:`HEMCO_Config.rc`,
:file:`HEMCO_Diagn.rc`, :file:`HISTORY.rc`) are discussed in depth in the
:ref:`rundir-config-files` section.

Each run directory also contains the following files, folders, and scripts:

.. option:: archiveRun.sh

   This script can be used to create an archive of the run directory
   (for archival purposes).

.. option:: build/

   This is a blank directory where you can direct :program:`CMake` to
   :ref:`configure and build <compiling-geos-chem>` the GEOS-Chem
   source code.

.. option:: build_info/

   This folder is created when you :ref:`compile GEOS-Chem
   <compiling-geos-chem>`.  It contains information about the options
   that were passed to :program:`CMake` during the configuration and
   build process.
   
.. option:: cleanRunDir.sh

   Typing

   .. code-block:: console

      $ ./cleanRunDir.sh

   will remove log files and diagnostic output files left over from a
   previous GEOS-Chem simulation.

.. option:: CodeDir

   Symbolic link to the top-level source code folder (i.e. the
   GCClassic superproject folder).	    
   
.. option:: download_data.py

   Use this Python script (which reads the associated configuration file
   :file:`download_data.yml`) to download data from one of the
   GEOS-Chem data portals to your disk space.  See
   :ref:`dry-run-simulation` for more information.

.. option:: GEOSChem.Restart.YYYYMMDD_hhmmzz.nc4

   This is the :ref:`restart file <restart-files>`, which contains
   initial conditions for the GEOS-Chem simulation.

   .. attention::

      The restart file that is created when you generate a run directory
      should not be used to start a production simulation. We recommend
      that you "spin up" your simulation for at least 6 months to a year
      in order to remove the signature of the initial conditions.
   
.. option:: getRunInfo
 
   This file is now deprecated and will be removed in a future version.
	    
.. option:: metrics.py

   This Python script can be used to print the OH metrics for a
   full-chemistry simulation.  Typing:

   .. code-block:: console

      $ ./metrics.py

   will generate output such as:

   .. code-block:: console
   
      ==============================================================================
      GEOS-Chem FULL-CHEMISTRY SIMULATION METRICS
      
      Simulation start : 2019-07-01 00:00:00z
      Simulation end   : 2019-07-01 01:00:00z
      ============================================================================== 
      
      Mass-weighted mean OH concentration    = 10.04682154969 x 10^5 molec cm-3
      
      CH3CCl3 lifetime w/r/t tropospheric OH = 6.3189 years
      
      CH4 lifetime w/r/t tropospheric OH     = 10.6590 years

.. option:: OutputDir/

   Blank directory where GEOS-Chem diagnostic output files will be
   created.

.. option:: rundirConfig

   Folder containing the :file:`rundir_vars.txt` file, which contains
   information about the environment variable settings that were used
   by the :file:`createRunDir.sh`.	    
   
.. option:: runScriptSamples

   Symbolic link to the folder in the `GEOS-Chem "Science Codebase"
   <https://github.com/geoschem/geos-chem>`_"
   repository that contains `sample scripts
   <https://github.com/geoschem/geos-chem/tree/main/run/GCClassic/runScriptSamples>`_
   for running GEOS-Chem.

.. option:: species_database.yml

   `YAML <https://yaml.org>`_ file containing metadata (e.g. molecular
   weight, Henry's law constants, wetdep and drydep parameters, etc.)
   for each species used in the various GEOS-Chem simulations.  You
   should not have to edit this file unless you are adding new species
   to your GEOS-Chem simulation.
