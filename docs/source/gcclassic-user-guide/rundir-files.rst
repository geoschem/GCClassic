.. _rundir-files:

###############################
Run directory files and folders
###############################

Each GEOS-Chem Classic run directory that you create will contain
the files and folders listed below. The :ref:`GEOS-Chem and HEMCO
configuration files <cfg>` in the run directory will be appropriate to
the type of simulation that you have selected.

.. option:: archiveRun.sh

   This script can be used to create an archive of the run directory.
   Run this script with:

   .. code-block:: console

      $ ./archiveRun.sh directory-name

   Where :file:`directory-name` is the name of the archive folder.
   This can be either a relative path or an absolute path.

.. option:: build/

   This is a blank directory where you can direct :program:`CMake` to
   :ref:`configure and build <compile>` the GEOS-Chem source code.

.. option:: build_info/

   This folder is created when you :ref:`compile GEOS-Chem
   <compile>`.  It contains information about the options
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
   :file:`GCClassic` superproject folder).

.. option:: CreateRunDirLogs/rundir_vars.txt

   Log file containing environment variable settings used in run
   directory creation.  Running the :file:`init_rd.sh` script on this
   file will create a duplicate run directory.

.. option:: download_data.py

   Use this Python script to download data from one of the GEOS-Chem
   data portals to your disk space. See our :ref:`dry-run` chapter for
   more information.

.. option:: download_data.yml

   Configuration file for :file:`download_data.py`.

.. option:: geoschem_config.yml

   The main GEOS-Chem configuration file (see :ref:`Configure your
   simulation <cfg>`).

.. option:: getRunInfo

   This file is now deprecated and will be removed in a future version.

.. option:: HEMCO_Config.rc

   The main HEMCO configuration file (see :ref:`Configure your
   simulation <cfg>`).

.. option:: HEMCO_Config.rc.gmao_metfields

   HEMCO configuration file snippet containing entries for reading the
   GMAO meteorological fields.  This file will only be present if you
   are using GEOS-FP or MERRA-2 meteorology to drive your GEOS-Chem
   simulation.

.. option:: HEMCO_Config.rc.gcap2_metfields

   HEMCO configuration file snippet containing entries for reading the
   GCAP2 meteorological fields.  This file will only be present if you
   are using GCAP2  meteorology to drive your GEOS-Chem simulation.

.. option:: HEMCO_Diagn.rc

   Configuration file for HEMCO diagnostics (see :ref:`Configure your
   simulation <cfg>`).

.. option:: HISTORY.rc

   Configuration file for GEOS-Chem History diagnostics (see
   :ref:`Configure your simulation <cfg>`).

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

.. option:: README.md

   README file (in Markdown format) with containing links to
   information about GEOS-Chem.

.. option:: Restarts/

   Directory where GEOS-Chem :ref:`restart files <restart-files>`
   will be created.

.. option:: Restarts/GEOSChem.Restart.YYYYMMDD_hhmmzz.nc4

   :ref:`Restart file <restart-files>` containing initial conditions
   for the GEOS-Chem simulation.

   .. attention::

      The restart file that is created when you generate a run directory
      should not be used to start a production simulation. We recommend
      that you "spin up" your simulation for at least 6 months to a year
      in order to remove the signature of the initial conditions.

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
   to your GEOS-Chem simulation.  The :ref:`cfg-spec-db` file will be
   discussed in more detail in a following section.
