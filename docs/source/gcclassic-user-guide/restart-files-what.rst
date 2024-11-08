.. _restart-files-what:

#######################
What is a restart file?
#######################

Restart files contain species concentrations, as well as other
quantities that are needed to initialize GEOS-Chem simulations.
GEOS-Chem simulations use two separate restart files.

.. option:: GEOSChem.Restart.YYYYMMDD_hhmmz.nc4

   **Format:** netCDF

   **Description:**  The :ref:`GEOS-Chem Classic restart file
   <restart-files-gc>`. Contains species concentrations that are read
   at simulation startup.

   GEOS-Chem writes a restart file at the end of each simulation. This
   allows a long simulation to be split into several individal run
   stages.   For example, the restart file that was created at 00:00
   UTC on August 1, 2019 is named:
   :file:`GEOSChem.Restart.20190801_0000z.nc4`.  The :file:`z`
   character  indicates "Zulu" time (aka UTC).

   GEOS-Chem restart files are created in the :option:`Restarts/`
   folder of your :ref:`GEOS-Chem run directory <rundir>` directory.

.. option:: HEMCO_restart.YYYYMMDDhhmm.nc

   **Format:** netCDF

   **Description:** The :ref:`HEMCO restart file <restart-files-hco>`.
   HEMCO archives certain quantities  (mostly pertaining to soil NOx
   and biogenic emissions in order to facilitate long GEOS-Chem
   simulations with several run stages.

   HEMCO restart files are created in the :option:`Restarts/`
   folder of your :ref:`GEOS-Chem run directory <rundir>` directory.

When you run a GEOS-Chem simulation, it will write new GEOS-Chem restart
files at the intervals you specify in :ref:`HISTORY.rc
<histguide-configfile>`. New HEMCO restart files are written with
frequency configured in :ref:`HEMCO_Config.rc <cfg-hco-cfg>`.

.. _restart-files-what-view:

======================================
Viewing and manipulating restart files
======================================

Please see the following sections of our Supplemental Guide:
:ref:`ncguide` for more information on how you can view and manipulate
data in restart files:

#. :ref:`ncguide-useful-tools`
#. :ref:`ncguide-regridding`
#. :ref:`ncguide-adding-new-var`
#. :ref:`ncguide-cropping`
#. :ref:`ncguide-chunk-deflate`
