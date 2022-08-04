.. _rundir-files:

###############################
Run directory files and folders
###############################

In each run directory there are several **user-editable configuration
files** that you can use to control the runtime behavior of GEOS-Chem
Classic. These files (:file:`geoschem_config.yml`, :file:`HEMCO_Config.rc`,
:file:`HEMCO_Diagn.rc`, :file:`HISTORY.rc`) are discussed in depth in
:ref:`cfg-rundir`.

Each run directory also contains the following files, folders, and scripts:

.. option:: archiveRun.sh

   This script can be used to create an archive of the run directory
   (for archival purposes).

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
   GCClassic superproject folder).

.. option:: download_data.py

   Use this Python script (which reads the associated configuration file
   :file:`download_data.yml`) to download data from one of the
   GEOS-Chem data portals to your disk space.  See
   :ref:`dry-run` for more information.

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
   to your GEOS-Chem simulation.  The :ref:`cfg-spec-db` file will be
   discussed in more detail in a following section.
