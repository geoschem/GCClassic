.. _restart-files-what:

#######################
What is a restart file?
#######################

Restart files contain the initial conditions (cf. :ref:`init-cond`)
for a GEOS-Chem simulation. GEOS-Chem simulations need two restart files.

.. option:: GEOSChem.Restart.YYYYMMDD_hhmmz.nc4

   **Format:** netCDF

   **Description:**  The :ref:`GEOS-Chem Classic restart file
   <restart-files-gc>`. Contains species concentrations that are read
   at simulation startup.

   GEOS-Chem writes a restart file at the end of each simulation. This
   allows a long simulation to be split into several individal run
   stages.

   For example, the restart file that was created at 00:00 UTC on
   August 1, 2016 is named:
   :file:`GEOSChem.Restart.20160801_0000z.nc4`.  The :file:`z`
   indicates "Zulu" time, which is another name for UTC.

   GEOS-Chem restart files are created in the top-level of your
   :ref:`GEOS-Chem run directory <create-rundir>` directory (and NOT
   in the :option:`OutputDir/` folder, which is where History
   diagnostic files are created.

.. option:: HEMCO_restart.YYYYMMDDhhmm.nc

   **Format:** netCDF

   **Description:** The :ref:`HEMCO restart file <restart-files-hco>`.
   HEMCO archives certain quantities  (mostly pertaining to soil NOx
   and biogenic emissions) in order to facilitate long  GEOS-Chem
   simulations with several run stages.

   HEMCO restart files are created in the top-level of your
   :ref:`GEOS-Chem run directory <create-rundir>` directory (and NOT
   in the :option:`OutputDir/` folder, which is where History
   diagnostic files are created.
   HEMCO restart files are created in the top-level of your GEOS-Chem run

When you run a GEOS-Chem simulation, it will write new GEOS-Chem restart
files at the intervals you specify in :ref:`history`. New HEMCO restart
files are written with frequency configured in :ref:`HEMCO_Config.rc
<hemco-config>`.

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
