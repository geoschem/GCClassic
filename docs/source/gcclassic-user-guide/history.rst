.. _cfg-hist:

##########
HISTORY.rc
##########

You can specify which GEOS-Chem Classic diagnostic outputs you would
like to archive with the :file:`HISTORY.rc` configuration file.

.. _cfg-hist-sample:

=======================================
Sample HISTORY.rc diagnostic input file
=======================================

A simplified :file:`HISTORY.rc` file is shown below.

.. code-block:: kconfig

   #============================================================================
   # EXPID allows you to specify the beginning of the file path corresponding
   # to each diagnostic collection.  For example:
   #
   #   EXPID: ./GEOSChem
   #      Will create netCDF files whose names begin "GEOSChem",
   #      in this run directory.
   #
   #   EXPID: ./OutputDir/GEOSChem
   #      Will create netCDF files whose names begin with "GEOSChem"
   #      in the OutputDir sub-folder of this run directory.
   #
   #============================================================================
   EXPID:  ./OutputDir/GEOSChem
   #==============================================================================
   # %%%%% COLLECTION NAME DECLARATIONS %%%%%
   #
   # To disable a collection, place a "#" character in front of its name
   #
   # NOTE: These are the "default" collections for GEOS-Chem.
   # But you can create your own custom diagnostic collections as well.
   #==============================================================================
   COLLECTIONS:  'SpeciesConc' ,
                 'SpeciesConcSubset' ,
                 'ConcAfterChem' ,
   ::
   #==============================================================================
   # %%%%% THE SpeciesConc COLLECTION %%%%%
   #
   # GEOS-Chem species concentrations (default = advected species)
   #
   # Available for all simulations
   #==============================================================================
   SpeciesConc.template:           '%y4%m2%d2_%h2%n2z.nc4' ,
   SpeciesConc.frequency:          00000000 060000 ,
   SpeciesConc.duration:           00000001 000000 ,
   SpeciesConc mode:               'instantaneous' ,
   SpeciesConc.fields:             'SpeciesConcVV_?ADV?'
                                   'SpeciesConcMND_?ADV?'
   ::
   #==============================================================================
   # %%%%% THE SpeciesConcSubset COLLECTION %%%%%
   #
   # Same as the SpeciesConc collection, but will subset data in the horizontal
   # and vertical dimensions so that the netCDF diagnostic files will cover
   # a smaller region of the globe.  This can save disk space and memory.
   #
   # NOTE: This capability will be available in GEOS-Chem "Classic" 12.5.0
   # and later versions.
   #
   # Available for all simulations
   #==============================================================================
   SpeciesConcSubset.template:     '%y4%m2%d2_%h2%n2z.nc4',
   SpeciesConcSubset.frequency:    060000,
   SpeciesConcSubset.duration:     00000001 000000,
   SpeciesConcSubset.mode:         'instantaneous',
   SpeciesConcSubset.LON_RANGE:    -40.0 60.0,
   SpeciesConcSubset.LAT_RANGE:    -10.0 50.0,
   SpeciesConcSubset.levels:       1 2 3 4 5,
   SpeciesConcSubset.fields:       'SpeciesConcVV_?ADV?',
                                   'SpeciesConcMND_?ADV?',
   ::
   #==============================================================================
   # %%%%% THE ConcAfterChem COLLECTION %%%%%
   #
   # Concentrations of OH, HO2, O1D, O3P immediately after exiting the KPP solver
   # or OH after the CH4 specialty-simulation chemistry routine.
   #
   # OH:       Available for all full-chemistry simulations and CH4 specialty sim
   # HO2:      Available for all full-chemistry simulations
   # O1D, O3P: Availalbe for full-chemistry simulations using UCX mechanism
   #==============================================================================
   ConcAfterChem.template:         '%y4%m2%d2_%h2%n2z.nc4',
   ConcAfterChem.frequency:        00000100 000000,
   ConcAfterChem.duration:         00000100 000000,
   ConcAfterChem.mode:             'time-averaged',
   ConcAfterChem.fields:           'OHconcAfterChem',
                                   'HO2concAfterChem',
                                   'O1DconcAfterChem',
                                   'O3PconcAfterChem',
   ::

In this :file:`HISTORY.rc` file, we are requesting three collections
(:literal:`SpeciesConc`, :literal:`SpeciesConcSubset`, and
:literal:`ConcAfterChem`).  Each collection represents a set of netCDF
files that will contain the same diagnostic fields.

.. _cfg-hist-sample-legend:

======
Legend
======

.. option:: COLLECTIONS:

   List of **diagnostic collections** in the :file:`HISTORY.rc` file.

   To turn off a collection, place a comment character (:literal:`#`)
   before its name.  For example:

   .. code-block:: kconfig

      COLLECTIONS:  #'SpeciesConc',
                    'SpeciesConcSubset',
                    'ConcAfterChem',

   turns off the :literal:`SpeciesConc` collection.

.. option:: <collection-name>.template

   Determines the date and time format of the netCDF file names that
   will be created for diagnostic collection :literal:`<collection-name>`.

   The string :literal:`%y4%m2%d2_%h2%n2z.nc4` will print
   :literal:`YYYYMMDD_hhmmz.nc4` to the end of each netCDF filename,
   where:

   -  :literal:`YYYYMMDD` is the date in year/month/day format
   -  :literal:`hhmm` is the time in hour:minutes format.
   -  :literal:`z` denotes "Zulu", which is an abbreviation for UTC
      time.
   -  :literal:`.nc4` denotes that the data file is in the netCDF-4
      format.

.. option:: <collection-name>.frequency

   Determines how often the diagnostic fields belonging to collection
   :literal:`<collection-name>` collection will be written to a netCDF
   file.  For example:

   - :literal:`010000` schedules diagnostic archival each hour.
   - :literal:`00000100 000000` schedules diagnostic output each month.
   - :literal:`00000001 000000` (or :literal:`240000`) schedules
     diagnostic output each day.
   - ... etc. ...

.. option:: <collection-name>.duration

   Determines how often a new netCDF file will be created for collection
   :literal:`<collection-name>`.  For example:

   - :literal:`010000` creates a new netCDF each hour.
   - :literal:`00000100 000000` creates a new netCDF file each month.
     month.
   - :literal:`00000001 000000` (or :literal:`240000`) creates a new
     netCDF file each day.

.. option:: <collection-name>.mode

   Determines the averaging method for collection
   :literal:`<collection-name>`.  Accepted values are:

   .. option:: instantaneous

      Data will be archived as instantaneous "snapshots" at the
      frequency specified in :option:`<collection-name>.frequency`.

   .. option:: time-averaged

      Data will be time-averaged with the frequency specified in
      :option:`<collection-name>.frequency`.

.. option:: <collection-name>.fields

   A list of the diagnostic fields that will be included in collection
   :literal:`<collection-name>`.

   A single underscore :literal:`_` denotes a **species-based diagnostic
   field**. To request output for a single species, list the species
   name immediately after the underscore, such as:

   .. code-block:: kconfig

      SpeciesConc.fields:   'SpeciesConcVV_NO'
                            'SpeciesConcVV_O3'
                            'SpeciesConcVV_CO'
                            ... etc ...
      ::

   You may also use a **wildcard** such as :literal:`?ADV?`, which requests
   all advected species:

   .. code-block:: kconfig

      SpeciesConc.fields:    'SpeciesConcVV_?ADV?'
                             ... etc ...
      ::

   The complete wildcard list is shown below.  Wildcards are case-insensitive.

   - :literal:`?ADV?`: Only the advected species
   - :literal:`?AER?`: Only the aerosol species
   - :literal:`?ALL?`: All GEOS-Chem species
   - :literal:`?DRYALT?`: Only the dry-deposited species whose
     concentrations we wish to archive at a given altitude above the
     surface.  (In practice these are only O3 and HNO3.)
   - :literal:`?DRY?`: Only the dry-deposited species
   - :literal:`?FIX?`: Only the inactive (aka "fixed") species in the
     KPP chemical mechanism
   - :literal:`?GAS?`: Only the gas-phase species
   - :literal:`?HYG?`: Only aerosols that undergo hygroscopic growth
     (sulfate, BC, OC, SALA, SALC)
   - :literal:`?LOS?`: Only chemical loss species or families
   - :literal:`?KPP?`: Only the KPP species
   - :literal:`?PHO?`: Only the photolyzed species
   - :literal:`?VAR?`: Only the active (aka "variable") species in the
     KPP chemical mechanism
   - :literal:`?WET?`: Only the wet-deposited species
   - :literal:`?PRD?`: Only chemical production species or families
   - :literal:`?DUSTBIN?`: Only the dust bin number
   - :literal:`?PHOTOBIN?` Number of a given wavelength bin for
     FAST-JX photolysis

   To include fields from the :code:`State_Chm` object in collection
   :literal:`<collection-name>`, precede the field name with
   :literal:`Chem_`:

   .. code-block:: kconfig

      'Chem_phCloud',
      ... etc ...

   To include fields from the :code:`State_Met` object in collection
   :literal:`<collection-name>`, precede the field name with
   :literal:`Met_`:

   .. code-block:: kconfig

      'Met_T'.
      'Met_PS',
      'Met_SPHU',
      ... etc ...

   Both :literal:`Chem_` and :literal:`Met_` specifiers are case-insensitive.

.. option:: <collection-name>.LON_RANGE

   **Optional**. Restrict data fields of collection
   :literal:`<collection-name>` to the range
   :literal:`min_lon, max_lon`.

.. option:: <collection-name>.LAT_RANGE

   **Optional**. Restrict data fields of collection
   :literal:`<collection-name>` to the range
   :literal:`min_lat, max_lat`.

.. option:: <collection-name>.levels

   **Optional**. Restrict data fields of collection
   :literal:`<collection-name>` to the specified levels (e.g.,
   :literal:`1,2,3,4,5` or :literal:`1-5`).

.. option:: ::

   Signifies the end of the definition section for collection
   :literal:`<collection-name>`.
