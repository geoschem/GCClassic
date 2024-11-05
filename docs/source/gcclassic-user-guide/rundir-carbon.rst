.. |br| raw:: html

   <br/>

.. _rundir-ex-ch4:

#######################################################
Example: Create a carbon gases simulation run directory
#######################################################

The process of creating run directories for the GEOS-Chem specialty
simulations is similar to that of the :ref:`previous example
<rundir-ex-fullchem>`. But the number of menus that you need to select
from will likely be fewer than for the full-chemistry
simulation. We'll use the carbon gases simulation as an example.

#. Navigate to the :file:`GCClassic` superproject folder and get a
   directory listing:

   .. code-block:: console

      $ cd /path/to/your/GCClassic
      $ ls -CF
      AUTHORS.txt   CMakeLists.txt  CONTRIBUTING.md  LICENSE.txt  run@    src/        test@
      CHANGELOG.md  CMakeScripts/   docs/            README.md    spack@  SUPPORT.md

   As mentioned previously, :file:`run@` is a symbolic link. It actually points
   to the to the :file:`src/GEOS-Chem/run/GCClassic` folder. This folder
   contains several scripts and template files for run directory
   creation. |br|
   |br|

#. Navigate to the run folder and get a directory listing:

   .. code-block:: console

      $ cd run
      $ ls -CF
      archiveRun.sh*                  gitignore                   init_rd.sh*
      createRunDir.sh*                HEMCO_Config.rc.templates/  README.md
      geoschem_config.yml.templates/  HEMCO_Diagn.rc.templates/   runScriptSamples/
      getRunInfo*                     HISTORY.rc.templates/       setupForRestarts.sh*

   You can see several folders (highlighted in the directory display with
   :file:`/`) and a few executable scripts (highlighted with :file:`*`).
   The script we are interested in is :file:`createRunDir.sh`. |br|
   |br|

#. Run the :command:`createRunDir.sh` script.. Type:

   .. code-block:: console

      $ ./createRunDir.sh

   |br|

#. You will then be prompted to supply information about the run
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
         3. Carbon
         4. Hg
         5. POPs
         6. Tagged O3
         7. Trace metals
         8. TransportTracers
         9. CH4
        10. CO2
        11. Tagged CO
      >>>

   To select the GEOS-Chem carbon gases specialty simulation, type
   :command:`3` followed by :command:`ENTER`.

   .. tip::

      To exit, the run directory creation process, type
      :literal:`Ctrl-C` at any prompt.

   |br|


#. You will be asked if you wish to set up a carbon simulation
   with all species (CH4, CO, CO2, OCS), or with just one of these
   species:

   .. code-block:: console

      -----------------------------------------------------------
      Do you wish to use a single advected species?
      -----------------------------------------------------------
        1. Use all species
        2. Use CH4 only
        3. Use CO2 only
        4. Use CO only
        5. Use OCS only
      >>>

   Let's pick the carbon simulation with all species.  Type
   :command:`1` followed by :command:`ENTER`. |br|
   |br|


#. You will then be asked to specify the meteorology type for the
   simulation (`GEOS-FP  <http://wiki.geos-chem.org/GEOS_FP>`_,  `MERRA-2
   <http://wiki-geos-chem.org/MERRA-2>`_), or GCAP 2.0):

   .. attention::

      We are still evaluating GEOS-Chem with the new NASA GEOS-IT
      meterorology product.  Please select one of the other
      meteorology options for the time being.

   .. code-block:: console

      -----------------------------------------------------------
      Choose meteorology source:
      -----------------------------------------------------------
        1. MERRA-2 (Recommended)
        2. GEOS-FP
        3. GEOS-IT (Beta release)
        4. GISS ModelE2.1 (GCAP 2.0)
      >>>

   To accept the recommended meteorology (MERRA-2), type :command:`1`
   followed by :command:`ENTER`. |br|
   |br|

   .. important::

      The convection scheme used for GEOS-FP met generation changed
      from RAS to Grell-Freitas with impact on GEOS-FP meteorology
      files starting June 1, 2020, specifically enhanced vertical
      transport. In addition, there is a bug in convective
      precipitation flux following the switch where all values are
      zero. While this bug is automatically fixed by computing fluxes
      online for runs starting on or after June 1 2020, the fix
      assumes meteorology year corresponds to simulation year. Due to
      these issues we recommend splitting up GEOS-FP runs in time such
      that a single simulation does not run across June
      1, 2020. Instead. set one run to stop on June 1 2020 and then
      restart a new run from there. If you wish to use a GEOS-FP
      meteorology year different from your simulation year please
      create a GEOS-Chem GitHub issue for assistance.

#. The next menu will prompt you for the horizontal resolution that
   you wish to use:

   .. code-block:: console

      -----------------------------------------------------------
      Choose horizontal resolution:
      -----------------------------------------------------------
        1. 4.0  x 5.0
        2. 2.0  x 2.5
        3. 0.5  x 0.625
      >>>

   If you wish to set up a global simulation, type either
   :command:`1` or :command:`2` followed by :command:`ENTER`.

   If you wish to set up a nested-grid simulation, type
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
      >>>

   Type the number of your preferred option and then hit
   :command:`ENTER`. |br|
   |br|

#. You will then be prompted for the vertical dimension of the grid.

   .. code-block:: console

      -----------------------------------------------------------
      Choose number of levels:
      -----------------------------------------------------------
        1. 72 (native)
        2. 47 (reduced)
      >>>

   For most simulations, you will want to use 72 levels. Type
   :command:`1` followed by :command:`ENTER`.

   For some memory-intensive simulations (such as nested-grid
   simulations), you can use 47 levels. Type :command:`2` followed by
   :command:`ENTER`. |br|
   |br|

#. You will then be prompted for the folder in which you wish to
   create the run directory.

   .. code-block:: console

      -----------------------------------------------------------
      Enter path where the run directory will be created:
      -----------------------------------------------------------
      >>>

   You may enter an absolute path (e.g.
   :file:`$HOME/myusername/my-run-directories`) followed by
   :command:`ENTER`.

   You may also enter a relative path (e.g.
   :file:`~/my-run-directories`) followed by :command:`ENTER`). In
   this case you will see that the :file:`./createRunDir.sh` script
   will expand the path to an absolute path. |br|
   |br|


#. The next menu will prompt you for the run directory name.

   .. code-block:: console

      -----------------------------------------------------------
      Enter run directory name, or press return to use default:

      NOTE: This will be a subfolder of the path you entered above.
      -----------------------------------------------------------
      >>>

   You should use the default run directory name whenever possible. Type
   :command:`ENTER`. The script will display the following output:

   .. code-block:: console

      -- Using default directory name gc_4x5_merra2_carbon

   or if you are creating a nested grid simulation:

   .. code-block:: console

      -- Using default directory name gc_05x0625_merra2_carbon

   and then

   .. code-block:: console

      -- See rundir_vars.txt for summary of default run directory settings
      -- This run directory has been set up to start on 20190101
      -- A restart file for this date has been copied to the Restarts subdirectory
      -- You may add more restart files using format GEOSChem.Restart.YYYYMMDD_HHmmz.nc4
      -- Change simulation start and end dates in configuration file geoschem_config.yml
      -- Default frequency and duration of diagnostics are set to monthly
      -- Modify diagnostic settings in HISTORY.rc and HEMCO_Config.rc

   |br|

#. The last menu will prompt you with:

   .. code-block:: console

      -----------------------------------------------------------
      Do you want to track run directory changes with git? (y/n)
      -----------------------------------------------------------
      >>>

   Type :command:`y` and then :command:`ENTER`. Then you will be able to
   track changes that you make to GEOS-Chem configuration files with
   Git. This can be a lifesaver when debugging---you can revert to an
   earlier state and then start fresh.

   You will then see output similar to this:

   .. code-block:: console

      Initialized empty Git repository in /path/to/gc_4x5_merra2_carbon/.git/

      Created /path/to/gc_4x5_merra2_carbon

      >>>> REMINDER: You must compile with options: -DMECH=carbon <<<<

   You can navigate to this directory and then start editing the
   :ref:`GEOS-Chem configuration files <cfg>`.

   Because the carbon simulation requires special compilation
   instructions, a reminder will be displayed with the proper command
   to use during the configuration step. |br|
   |br|

The procedure to set up run directories for other GEOS-Chem Classic
simulations is similar to that shown above.
