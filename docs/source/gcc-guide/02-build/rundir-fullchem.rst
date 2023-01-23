.. |br| raw:: html

   <br/>

.. _rundir-ex-fullchem:

#########################################################
Example: Create a full-chemistry simulation run directory
#########################################################

Let us walk through the process of creating a run directory for a global
GEOS-Chem full-chemistry simulation.

#. Navigate to the GCClassic superproject folder and get a directory
   listing:

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
   creation. |br|
   |br|

#. Navigate to the run folder and get a directory listing:

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
   The script we are interested in is :file:`createRunDir.sh`. |br|
   |br|

#. Run the :file:`createRunDir.sh` script. Type:

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
         3. CH4
         4. CO2
         5. Hg
         6. POPs
         7. Tagged CH4
         8. Tagged CO
         9. Tagged O3
        10. TransportTracers
        11. Trace metals
        12. Carbon

   To create a run directory for the full-chemistry simulation, type
   :command:`1` followed by the :command:`ENTER` key. |br|
   |br|

#. You will then be asked to specify any additional options for the
   full-chemistry simulation (such as adding the RRTMG radiative
   transfer model, APM or TOMAS microphysics, etc.)

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

   For the standard full-chemistry simulation, type :command:`1`
   followed by :command:`ENTER`.

   To add an option to the full-chemistry simulation, type a number
   between :command:`2` and :command:`8` and press
   :command:`ENTER`. |br|
   |br|

#. You will then be asked to specify the meteorology type for the
   simulation (`GEOS-FP  <http://wiki.geos-chem.org/GEOS_FP>`_,  `MERRA-2
   <http://wiki-geos-chem.org/MERRA-2>`_), or GCAP 2.0):

   .. code-block:: console

      -----------------------------------------------------------
      Choose meteorology source:
      -----------------------------------------------------------
        1. MERRA-2 (Recommended)
        2. GEOS-FP
        3. GISS ModelE2.1 (GCAP 2.0)

   You should use the recommended option (MERRA-2) if possible. Type
   :command:`1` followed by :command:`ENTER`. |br|
   |br|

#. The next menu will prompt you for the horizontal resolution that
   you wish to use:

   .. code-block:: console

      -----------------------------------------------------------
      Choose horizontal resolution:
      -----------------------------------------------------------
        1. 4.0  x 5.0
        2. 2.0  x 2.5
        3. 0.5  x 0.625

   If you wish to set up a global simulation, type either
   :command:`1` or :command:`2` followed by :command:`ENTER`.

   If you wish to set up a nested-grid simulation, type :command:`3`
   and hit :command:`ENTER`. Then you will be followed by a
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

   Select your preferred horizontal domain, followed by
   :command:`ENTER`. |br|
   |br|

#. You will then be prompted for the vertical dimension of the grid.

   .. code-block:: console

      -----------------------------------------------------------
      Choose number of levels:
      -----------------------------------------------------------
        1. 72 (native)
        2. 47 (reduced)

   For most simulations, you will want to use :command:`72`
   levels. Type  :command:`1` followed by :command:`ENTER`.

   For some memory-intensive simulations (such as nested-grid
   simulations), you can use 47 levels. Type :command:`2` followed
   by :command:`ENTER`. |br|
   |br|

#. You will then be prompted for the folder in which you wish to
   create the run directory.

   .. code-block:: console

      -----------------------------------------------------------
      Enter path where the run directory will be created:
      -----------------------------------------------------------

   You can enter an absolute path (such as :file:`$HOME/myusername/`
   followed by :command:`ENTER)`.

   You can also enter a relative path (such as :file:`~/rundirs`
   followed by ENTER). In this case you will see that the
   :file:`./createRunDir.sh`  script will expand the path to:

   .. code-block:: console

      Expanding to: /n/home09/myusername/rundirs |br|
      |br|


#. The next menu will prompt you for the run directory name.

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
            You may modify these settings in HISTORY.rc and
	    HEMCO_Config.rc.

      |br|

#. The last menu will prompt you with:

   .. code-block:: console

      -----------------------------------------------------------
      Do you want to track run directory changes with git? (y/n)
      -----------------------------------------------------------

   Type :command:`y` and then :command:`ENTER`. Then you will be able to
   track changes that you make to GEOS-Chem configuration files with
   Git. This can be a lifesaver when debugging -- you can revert to an
   earlier state and then start fresh. |br|
   |br|

#. The script will display the full path to the run directory. You
can navigate there and then start editing the :ref:`GEOS-Chem
configuration files <cfg>`.
