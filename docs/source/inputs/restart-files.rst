.. _restart-files:

#############
Restart files
#############

In this section, we provide some basic information about :program:`GEOS-Chem
Classic` restart files and how they are used.

.. _what_is_a_restart_file:

=======================
What is a restart file?
=======================

Restart files contain the initial conditions (cf. :ref:`init-cond`)
for a GEOS-Chem simulation. GEOS-Chem simulations need two restart files.

.. option:: GEOSChem.Restart.YYYYMMDD_hhmmz.nc4

   **Format:** netCDF

   **Description:**  The :program:`GEOS-Chem Classic` restart file.
   Contains species concentrations that are read at simulation startup.

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

   **Description:** The `Harmonized Emissions Component (HEMCO)
   <https://hemco.readthedocs.io>`_ restart file.  HEMCO will save out
   certain quantities  (mostly pertaining to soil NOx and biogenic
   emissions) in order to facilitate long  GEOS-Chem simulations with
   several run stages.

   HEMCO restart files are created in the top-level of your
   :ref:`GEOS-Chem run directory <create-rundir>` directory (and NOT
   in the :option:`OutputDir/` folder, which is where History
   diagnostic files are created.
   HEMCO restart files are created in the top-level of your GEOS-Chem run

When you run a GEOS-Chem simulation, it will write new GEOS-Chem restart
files at the intervals you specify in :ref:`history`. New HEMCO restart
files are written with frequency configured in :file:`HEMCO_Config.rc`.

.. _gc-restart-files:

=======================
GEOS-Chem restart files
=======================

.. _restart-file-input:

How are restart files read into GEOS-Chem?
------------------------------------------

GEOS-Chem restart files are read via `HEMCO
<https://hemco.readthedocs.io>`_. The entries listed below have been
added to :file:`HEMCO_Config.rc` (and may vary slightly for different
simulation types). These fields are obtained from HEMCO and copied to
the appropriate :code:`State_Chm` and :code:`State_Met` fields in
routine :code:`Get_GC_Restart` (located in
:file:`GeosCore/hcoi_gc_main_mod.F90`).

.. code-block:: console

   #==============================================================================
   # --- GEOS-Chem restart file ---
   #==============================================================================
   (((GC_RESTART
   * SPC_           ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 SpeciesRst_?ALL?    $YYYY/$MM/$DD/$HH EFYO xyz 1 * - 1 1
   * DELPDRY        ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Met_DELPDRY         $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * KPP_HVALUE     ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_KPPHvalue      $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * WETDEP_N       ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_WetDepNitrogen $YYYY/$MM/$DD/$HH EY   xy  1 * - 1 1
   * DRYDEP_N       ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_DryDepNitrogen $YYYY/$MM/$DD/$HH EY   xy  1 * - 1 1
   * SO2_AFTERCHEM  ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_SO2AfterChem   $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * H2O2_AFTERCHEM ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_H2O2AfterChem  $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * AEROH2O_SNA    ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_AeroH2OSNA     $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * ORVCSESQ       ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_ORVCSESQ       $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * JOH            ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_JOH            $YYYY/$MM/$DD/$HH EY   xy  1 * - 1 1
   * JNO2           ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_JNO2           $YYYY/$MM/$DD/$HH EY   xy  1 * - 1 1
   * STATE_PSC      ./GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_StatePSC       $YYYY/$MM/$DD/$HH EY   xyz count * - 1 1
   )))GC_RESTART

GEOS-Chem species (the :file:`SPC_` entry) use HEMCO time cycle flag
:code:`EFYO`.  Other restart file fields use the time cycle flag
:code:`EY`. These are explained below.

.. option:: E

   :command:`Exact`: Stops with an error if the simulation year is
   different than the date in the file.

.. option:: F

   :command:`Forced`: Stops with an error if the file isn't found.

.. option:: Y

   :command:`Simulation Year`: Only read the data for the simulation
   year but not for other years.

.. option:: O

   :command:`Once`: Do not keep cycling in time but only read the file
   once.

When reading the species concentrations (:code:`EFYO`) from the
restart file, HEMCO will stop with an error if:

#. The restart file is missing, or
#. Any species is missing, or,
#. The date in the restart file does not match the start date of the
   simulation.

When reading other fields (:code:`EY`) from the restart file,
HEMCO will stop with an error if:

#. The restart file is missing, or
#. The date in the restart file does not match the start date of the
   simulation.

.. tip::

   If you wish to spin up a GEOS-Chem simulation with a restart file
   that has missing species, change the time cycle flag from

   .. code-block:: console

      * SPC_ ... $YYYY/$MM/$DD/$HH EFYO xyz 1 * - 1 1

   to

   .. code-block:: console

      * SPC_ ... $YYYY/$MM/$DD/$HH EY xyz 1 * - 1 1

   This will tell HEMCO to initialize the concentration of species not
   found in the restart file to a default background value. If the
   species has :code:`BackgroundVV` value specified in
   :option:`species_database.yml`, then this value will be used
   for the the initial species concentration.  Otherwise a value of
   :math:`1.0{\times}10^{-20}` will be used.

.. _how_can_i_determine_the_date_of_a_restart_file:

How can I determine the date of a restart file?
-----------------------------------------------

To determine the date of a netCDF restart file, you may use :command:`ncdump`.
For example:

.. code-block:: console

   ncdump -v time -t GEOSChem.Restart.YYYYMMDD_hhmmz.nc4

The :command:`-t` option will return the time value in human-readable
date-time strings rather than numerical values in unit such as :code:`"hours
since 1985-1-1 00:00:0.0.`

.. _where_can_i_get_a_restart_file_for_my_simulation:

Where can I get a restart file for my simulation?
-------------------------------------------------

GEOS-Chem run directories are configured to use sample GEOS-Chem restart
files in :program:`netCDF` format.  These files are available for download at:
`http://geoschemdata.wustl.edu/ExtData/GEOSCHEM_RESTARTS/
<http://geoschemdata.wustl.edu/ExtData/GEOSCHEM_RESTARTS/>`_.

.. tip::

   We recommend that you downloading restart files to your disk space
   with either a `dry-run simulation <dry-run-simulation>`_ or with
   the `bashdatacatalog
   <https://github.com/liambindle/bashdatacatalog>`_.  This will
   ensure that the proper files will be downloaded.

If you have the :file:`ExtData/GEOSCHEM_RESTARTS` folder in your
GEOS-Chem data pahts, then a sample restart file will be copied to
your run directory when you :ref:`generate a new GEOS-Chem classic run
directory <create-rundir>`.

.. attention::

   The sample restart files do not reflect the actual atmospheric
   state and should only be used to "spin up" the model. In other
   words, they should be used as initial values in an initialization
   simulation to generate more accurate initial conditions for your
   production runs.

.. _for_how_long_should_i_spin_up_before_starting_a_production_simulation:

For how long should I spin up before starting a production simulation?
----------------------------------------------------------------------

Doing a 6-month year spin up is usually sufficient for full-chemistry
simulations.  We recommend ten years for ozone, carbon dioxide, and
methane simulations, and four years for radon-lead-beryllium
simulations. If you are in doubt about how long your spin up should be
for your simulation, we recommend contacting the `GEOS-Chem Working
Group <http://acmg.seas.harvard.edu/geos/geos_working_groups.html>`_
that specializes in your area of research.

You may spin up the model starting at any year for which there is met
data, but you should always start your simulations at the month and day
corresponding to the restart file to more accurately capture seasonal
variation. If you want to start your production run at a specific date,
we recommend doing a spin up for the appropriate number of years plus
the number of days needed to reach your ultimate start date. For
example, if you want to do a production simulation starting on 12/1/13,
you could spin up the model for one year using the initial GEOS-FP
restart file dated 7/1/13 and then use the new restart file to spin up
the model for five additional months, from 7/1/13 to 12/1/13.

See also this discussion on our Github page for further guidance:
https://github.com/geoschem/geos-chem/discussions/911.

.. _how_do_i_check_my_initial_conditions:

How do I check my initial conditions?
-------------------------------------

To ensure you are using the expected initial conditions for your
simulation, please check the GEOS-Chem log file. You should see
something like:

.. code-block:: console

   HEMCO: Opening ./GEOSChem.Restart.20190701_0000z.nc4
        - Found all CN     met fields for 2011/01/01 00:00
        - Found all A1     met fields for 2019/07/01 00:30
        - Found all A3cld  met fields for 2019/07/01 01:30
        - Found all A3dyn  met fields for 2019/07/01 01:30
        - Found all A3mstC met fields for 2019/07/01 01:30
        - Found all A3mstE met fields for 2019/07/01 01:30
        - Found all I3     met fields for 2019/07/01 00:00
    Initialize TMPU1    from restart file
    Initialize SPHU1    from restart file
    Initialize PS1_WET  from restart file
    Initialize PS1_DRY  from restart file
    Initialize DELP_DRY from restart file
        - Found all I3     met fields for 2019/07/01 03:00
   ===============================================================================
   R E S T A R T   F I L E   I N P U T
   Min and Max of each species in restart file [mol/mol]:
   Species   1,     ACET: Min = 1.000458833E-22  Max = 6.680149323E-09
   Species   2,     ACTA: Min = 6.574137699E-23  Max = 6.108235029E-10
   Species   3,     AERI: Min = 4.122849756E-16  Max = 1.213838925E-11
   Species   4,     ALD2: Min = 4.186668786E-23  Max = 4.571487633E-09
   ...

If a species is not found in the restart file, you may see something like:

.. code-block:: console

   Species 178,       pFe: Use background = 9.999999683E-21

.. _how-are-restart-files-archived:


How are GEOS-Chem restart files written?
----------------------------------------

** TODO: Need link to restart collection **

GEOS-Chem restart files are now saved via the History component. A
**Restart collection** has been defined in `HISTORY.rc <history>`_ and
fields saved out to the restart file can be modified in that file.

.. _hemco-restart-files:

===================
HEMCO restart files
===================

.. _do_i_need_a_hemco_restart_file_for_my_initial_spin_up_run:

Do I need a HEMCO restart file for my initial spin-up run?
----------------------------------------------------------

Using a HEMCO restart file for your initial spin up run is
optional. The HEMCO restart file contains fields for initializing
variables required for Soil NOx emissions, MEGAN biogenic emissions,
and the UCX chemistry quantities. The HEMCO restart file that comes
with a run directory may only be used for the date and time indicated
in the filename. HEMCO will automatically recognize when a restart
file is not available for the date and time required, and in that case
HEMCO will use default values to initialize those fields. You can also
force HEMCO to use the default initialization values by setting
:code:`HEMCO_RESTART` to false in :file:`HEMCO_Config.rc`.

.. _viewing-restart-files:

======================================
Viewing and manipulating restart files
======================================

**TODO: Update links**

For information on viewing and manipulating GEOS-Chem restart files in
netCDF format, please see the following sections of :ref:`ncguide`:

#. :ref:`ncguide-useful-tools`
#. :ref:`ncguide-regridding`
#. :ref:`ncguide-adding-new-var`
#. :ref:`ncguide-cropping`
#. :ref:`ncguide-chunk-deflate`
