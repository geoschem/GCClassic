.. _restart-files-gc:

#######################
GEOS-Chem restart files
#######################

.. _restart-files-gc-read:

==========================================
How are restart files read into GEOS-Chem?
==========================================

GEOS-Chem restart files may be read via `HEMCO
<https://hemco.readthedocs.io>`_ or via GEOS-Chem. If using HEMCO then
all fields are read as single precision floating point
(:code:`REAL*4`). If using  GEOS-Chem then all fields are read with
the native precision stored in the file, e.g. double precision
floating point (:code:`REAL*8`) for species concentrations. Using
HEMCO is on by default, but you may choose to use GEOS-Chem instead by
updating the :file:`geoschem_config.yml` configuration file entry
:literal:`read_restart_as_real8` to :literal:`true`.

There are pros and cons to both methods of reading the GEOS-Chem
restart file. Using HEMCO allows forcing the timestamp of the restart
file to match run start date and time as well as doing custom
alterations such as changing the names of the expected variables in
the file. It also allows online regridding and cropping of restart
files at run-time, a requirement for nested grid simulations if using
a global restart file. However, using HEMCO to read the restart file
prevents bit-for-bit reproducibility when restarting a run and also
prevents restart file mass conservation. This is because of the
precision loss associated with reading restart fields as
:code:`REAL*4` when they are stored internally in the model as
:code:`REAL*8`.

Using GEOS-Chem to read restart files enables bit-for-bit
reproducibility upon restart as well as file mass
conservation. However, it prevents using HEMCO read features. In
particular it is not appropriate to use if the restart file horizontal
grid does not match the run horizontal grid or if the restart file
needs to be cropped. In both cases the model will fail. The model will
also exit with an error message if using the mercury simulation since
this feature has not yet been validated for that simulation.

================================
Using HEMCO to read restart file
================================

This section pertains only to using HEMCO to read the GEOS-Chem
restart file. All fields are read in as :code:`REAL*4`. See the
section above if you instead wish to read fields at their native
precision.

The entries for restart files are stored in
:file:`HEMCO_Config.rc`. They may vary slightly for different
simulation types. These fields are obtained from HEMCO and
copied to the appropriate :code:`State_Chm` and :code:`State_Met`
fields in routine :code:`Get_GC_Restart` (located in
:file:`GeosCore/hcoi_gc_main_mod.F90`).

.. code-block:: console

   #==============================================================================
   # --- GEOS-Chem restart file ---
   #==============================================================================
   (((GC_RESTART
   * SPC_           ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 SpeciesRst_?ALL?    $YYYY/$MM/$DD/$HH EFYO xyz 1 * - 1 1
   * DELPDRY        ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Met_DELPDRY         $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * KPP_HVALUE     ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_KPPHvalue      $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * WETDEP_N       ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_WetDepNitrogen $YYYY/$MM/$DD/$HH EY   xy  1 * - 1 1
   * DRYDEP_N       ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_DryDepNitrogen $YYYY/$MM/$DD/$HH EY   xy  1 * - 1 1
   * SO2_AFTERCHEM  ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_SO2AfterChem   $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * H2O2_AFTERCHEM ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_H2O2AfterChem  $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * AEROH2O_SNA    ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_AeroH2OSNA     $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * ORVCSESQ       ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_ORVCSESQ       $YYYY/$MM/$DD/$HH EY   xyz 1 * - 1 1
   * JOH            ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_JOH            $YYYY/$MM/$DD/$HH EY   xy  1 * - 1 1
   * JNO2           ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_JNO2           $YYYY/$MM/$DD/$HH EY   xy  1 * - 1 1
   * STATE_PSC      ./Restarts/GEOSChem.Restart.$YYYY$MM$DD_$HH$MNz.nc4 Chem_StatePSC       $YYYY/$MM/$DD/$HH EY   xyz count * - 1 1
   )))GC_RESTART

GEOS-Chem species (the :file:`SPC_` entry) use HEMCO time cycle flag
:code:`EFYO` by default.  Other restart file fields use the time cycle flag
:code:`EY`. These are explained below.

.. list-table:: HEMCO time cycle flags used with GEOS-Chem restart files
   :header-rows: 1
   :widths: 10 20 70

   * - Flag
     - Name
     - Description
   * - :command:`E`
     - :command:`Exact`
     - Stops with an error if the date of the simulation is different
       than the file timestamp.
   * - :command:`F`
     - :command:`Forced`
     - Stops with an error if the file isn't found.
   * - :command:`Y`
     - :command:`Simulation Year`
     - Only reads the data for the simulation year but not for other years.
   * - :command:`O`
     - :command:`Once`
     - Does not keep cycling in time but only reads the file once.

When reading the **species concentrations** (time cycle flag:
:code:`EFYO`) from the restart file, HEMCO will cause your simulation
to stop with an error if:

#. The restart file is missing, or;
#. Any species is not found in the restart file, or;
#. The date in the restart file (which is usually 20190101 or
   20190701, depending on your simulation) differs from the start date
   listed in :ref:`geoschem_config.yml <cfg-gc-yml>`.

When reading **other restart file fields** (time cycle flag:
:code:`EY`). HEMCO will stop with an error if:

#. The restart file is missing, or
#. The date in the restart file (which is usually 20190101 or
   20190701, depending on your simulation) differs from the start date
   listed in :ref:`geoschem_config.yml <cfg-gc-yml>`.

.. attention::

   If you wish to spin up a GEOS-Chem simulation with a restart file
   that has (1) missing species or (2) a timestamp that does not
   match the start date in :ref:`geoschem_config.yml <cfg-gc-yml>`,
   simply change the time cycle flag from

   .. code-block:: console

      * SPC_ ... $YYYY/$MM/$DD/$HH EFYO xyz 1 * - 1 1

   to

   .. code-block:: console

      * SPC_ ... $YYYY/$MM/$DD/$HH CYS xyz 1 * - 1 1

   This will direct HEMCO to read the closest date
   available (:literal:`C`), to use the simulation year
   (:literal:`Y`),  and to skip any species (:literal:`S`) not found
   in the restart file.

   Skipped species will be assigned the initial concentration
   (units: :math:`mol\ mol^{-1}` w/r/t dry air) specified by its
   :ref:`spcguide-defs-other-bkgdvv` entry in
   :ref:`species_database.yml <cfg-spec-db>`.  If the species does not
   have a :ref:`spcguide-defs-other-bkgdvv` value specified, then its
   initial concentration will be set to :math:`1.0{\times}10^{-20}`
   instead.

.. _restart-files-gc-date:

===============================================
How can I determine the date of a restart file?
===============================================

The date of the restart file is in the filename. It is also stored in the
file metadata. You may check the metadata using :command:`ncdump`.
For example:

.. code-block:: console

   ncdump -v time -t GEOSChem.Restart.YYYYMMDD_hhmmz.nc4

The :command:`-t` option will return the time value in human-readable
date-time strings rather than numerical values in unit such as :code:`"hours
since 1985-1-1 00:00:0.0.`

If using HEMCO to read the restart file then the timestamp in the
filename and within the file must match the simulation start date and time.
You can change this by modifying :file:`HEMCO_Config.rc` (see earlier section
on using HEMCO to read restart files). If using GEOS-Chem
to read the restart file then only the date and time in the filename must
match the simulation start.

.. _restart-files-gc-where:

=================================================
Where can I get a restart file for my simulation?
=================================================

GEOS-Chem Classic :ref:`run directories <rundir>` are configured to
use sample GEOS-Chem restart files in :program:`netCDF` format.  These
files are available for download at the :ref:`gcid-data` portal.

.. tip::

   We recommend that you download restart files to your disk space
   with either a `dry-run simulation <dry-run-simulation>`_ or with
   the `bashdatacatalog
   <https://github.com/liambindle/bashdatacatalog>`_.  This will
   ensure that the proper files will be downloaded.

If you have the :file:`ExtData/GEOSCHEM_RESTARTS` folder in your
GEOS-Chem data paths, then a sample restart file will be copied to
your run directory when you :ref:`generate a new GEOS-Chem classic run
directory <rundir>`.

Monthly GEOS-Chem restart files from the GEOS-Chem 14.0.0 10-year
benchmark `may be found here <http://geoschemdata.wustl.edu/ExternalShare/geos-chem/10yr_benchmarks/14.0.0/GCClassic/Restarts/>`_.

.. attention::

   The sample restart files do not reflect the actual atmospheric
   state and should only be used to "spin up" the model. In other
   words, they should be used as initial values in an initialization
   simulation to generate more accurate initial conditions for your
   production runs.

.. _restart-files-gc-spinup:

======================================================================
For how long should I spin up before starting a production simulation?
======================================================================

Doing a 6-month year spin up is usually sufficient for full-chemistry
simulations.  We recommend ten years for ozone, carbon dioxide, and
methane simulations, and four years for radon-lead-beryllium
simulations. If you are in doubt about how long your spin up should be
for your simulation, we recommend contacting the `GEOS-Chem Working
Group <https://geoschem.github.io/working-groups.html>`_
that specializes in your area of research.

You may spin up the model starting at any year for which there is met
data, but you should always start your simulations at the month and day
corresponding to the restart file to more accurately capture seasonal
variation. If you want to start your production run at a specific date,
we recommend doing a spin up for the appropriate number of years plus
the number of days needed to reach your ultimate start date. For
example, if you want to do a production simulation starting on
2019/12/01, you could spin up the model for one year using the initial
GEOS-FP restart file dated 2019/07/01 and then use the new restart
file to spin up the model for five additional months, from 2019/07/01
to 2019/12/01.

.. _restart-files-gc-check:

=====================================
How do I check my initial conditions?
=====================================

To ensure you are using the expected initial conditions for your
simulation please check the GEOS-Chem log file. You should see
min, max, and sum of all fields stored in the GEOS-Chem restart file
printed to log. If you enable the :literal:`verbose` option in configuration
file :file:`geoschem_config.yml` and your restart file contains meteorology
field :literal:`Met_DELPDRY` then you will also see the global mass per
species computed entirely from restart file values printed to log. This
mass can be compared to global mass printed at the start of each timestep
when in :literal:`verbose` mode to check mass conservation.

.. code-block:: console

   HEMCO: Opening ./Restarts/GEOSChem.Restart.20190701_0000z.nc4
        - Found all CN     met fields for 2011/01/01 00:00
        - Found all A1     met fields for 2019/07/01 00:30
        - Found all A3cld  met fields for 2019/07/01 01:30
        - Found all A3dyn  met fields for 2019/07/01 01:30
        - Found all A3mstC met fields for 2019/07/01 01:30
        - Found all A3mstE met fields for 2019/07/01 01:30
        - Found all I3     met fields for 2019/07/01 00:00
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

.. _restart-files-gc-write:

========================================
How are GEOS-Chem restart files written?
========================================

GEOS-Chem restart files are now saved via the History component. A
:ref:`Restart collection <histguide-restart>` has been defined in
:ref:`HISTORY.rc <histguide-configfile>` and fields saved out to the
restart file can be modified in that file.
