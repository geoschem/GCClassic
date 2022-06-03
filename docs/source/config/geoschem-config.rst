.. _geoschem-config:

############################
The geoschem_config.yml file
############################

Starting with GEOS-Chem 14.0.0, the :file:`input.geos` configuration
file (plain text) has been replaced with by the
:file:`geoschem_config.yml` file.  This file is in `YAML
<https://yaml.org>`_ format, which is a text-based markup syntax used
for representing dictionary-like data structures.

.. note::

   The :file:`geoschem_config.yml` file contains several sections.  Only
   the sections relevant to a given type of simulation are present.
   For example, :option:`fullchem` simulation options (such as aerosol
   settings and photolysis settings) are omitted from the
   :file:`geoschem_config.yml` file for the :option:`CH4` simulation.

.. _gc-yml-simulation:

===================
Simulation settings
===================

.. code-block:: yaml

   #============================================================================
   # Simulation settings
   #============================================================================
   simulation:
     name: fullchem
     start_date: [20190701, 000000]
     end_date: [20190801, 000000]
     root_data_dir: /path/to/ExtData
     met_field: MERRA2
     species_database_file: ./species_database.yml
     debug_printout: false
     use_gcclassic_timers: false

The :command:`simulation` section contains general simulation options:
	    
.. option:: name

   Specifies the type of GEOS-Chem Classic simulation.  Accepted
   values are

   .. option:: fullchem

      Full-chemistry simulation

   .. option:: aerosol

      Aerosol-only simulation

   .. option:: CH4

      Methane simulation

   .. option:: CO2

      Carbon dioxide simulation

   .. option:: Hg

      Mercury simulation

   .. option:: POPs

      Persistent organic pollutants (aka POPs) simulation:

      .. note::

	 This simulation needs updating.  We look to members of the
	 GEOS-Chem community take the lead on this effort.

   .. option:: tagCH4

      Methane simulation with species tagged by geographic region or
      other criteria

   .. option:: tagCO

      Carbon dioxide simulation with species tagged by geographic
      region and other criteria.

   .. option:: tagO3

      Ozone simulation (using specified production and loss rates),
      with species tagged by geographical region.

   .. option:: TransportTracers

      Transport Tracers simulation, with both radionuclide and passive
      species.  Useful for evaluating model transport.

   .. option:: metals

      Trace metals simulation

.. option:: start_date

   Specifies the starting date and time of the simulation in list
   notation [YYYYMMDD, hhmmss].

.. option:: end_date

   Specifies the ending date and time of the simulation in list
   notation [YYYYMMDD, hhmmss].

.. option:: root_data_dir

   Path to the root data directory.  All of the data that GEOS-Chem
   Classic reads must be located in subfolders of this directory.

.. option:: met_field

   Name of the meteorology product that will be used to drive
   GEOS-Chem Classic.  Accepted values are:

   .. option:: MERRA2

      The `MERRA-2 <https://wiki.geos-chem.org/MERRA-2>`_ meteorology
      product from NASA/GMAO.  MERRA-2 is a stable reanalysis product,
      and extends from approximately 1980 to present.
	 **(Recommended option)** 

   .. option:: GEOS-FP

      The `GEOS-FP <https://wiki.geos-chem.org/MERRA-2>`_ meteorology
      product from NASA/GMAO.  GEOS-FP is an operational data product
      and, unlike MERRA-2, periodically receives science updates.

   .. option:: GCAP2

      The GCAP-2 meteorology product, archived from the GISS-2 GCM.
      GCAP-2 has hundreds of years of data available, making it useful
      for simulations of historical climate.

.. option:: species_database_file

   Path to the `GEOS-Chem Species Database
   <http://wiki.geos-chem.org/GEOS-Chem_species_database>`_ file.
   This is stored in the run directory file
   :file:`./species_database.yml`.  You should not have to edit this
   setting.

.. option:: debug_printout

   Activates (:command:`true`) or deactivates (:command:`false`)
   debug print statements to the screen or log file.

.. option:: use_gcclassic_timers

   Activates (:command:`true`) or deactivates (:command:`false`)
   the GEOS-Chem Classic timers.  If activated, information about how
   long each component of GEOS-Chem took to execute will be printed to
   the screen or log file.

.. _gc-yml-grid:

=============
Grid settings
=============

.. code-block:: YAML

   #============================================================================
   # Grid settings
   #============================================================================
   grid:
     resolution: 4.0x5.0
     number_of_levels: 72
     longitude:
       range: [-180.0, 180.0]
       center_at_180: true
     latitude:
       range: [-90.0, 90.0]
       half_size_polar_boxes: true
     nested_grid_simulation:
       activate: true
       buffer_zone_NSEW: [0, 0, 0, 0]

The :command:`grid` section contains setings that define the grid used
by GEOS-Chem Classic
       
.. option:: resolution

   Specifies the horizontal resolution of the grid.  Accepted values are:

   .. option:: 4.0x5.0

      The global :math:`4^{\circ}{\times}5^{\circ}` GEOS-Chem Classic
      grid.

   .. option:: 2.0x2.5

      The global :math:`2.0{\circ}{\times}2.5^{\circ}` GEOS-Chem Classic
      grid.

   .. option:: 0.5x0.625

      The global :math:`0.5^{\circ}{\times}0.625^{\circ}` GEOS-Chem Classic
      grid (:option:`MERRA2` only).  Can be used for global or nested
      simulations.

   .. option:: 0.5x0.625

      The global :math:`0.25^{\circ}{\times}0.3125^{\circ}` GEOS-Chem
      Classic grid (:option:`GEOS-FP` and :option:`MERRA2`).  Can be
      used for global or  nested simulations.

.. option:: number_of_levels

   Number of vertical levels to use in the simulation.  Accepted
   values are:

   .. option:: 72

      Use 72 vertical levels.  This is the native vertical resolution
      of :option:`MERRA2` and :option:`GEOS-FP`.

   .. option:: 47

      Use 47 vertical levels (for :option:`MERRA2` and :option:`GEOS-FP`).

   .. option:: 40

      Use 40 vertical levels (for :option:`GCAP2`).

.. option:: longitude

   Settings that define the longitude dimension of the grid.  There are
   two sub-options:

   .. option:: range

      The minimum and maximum longitude values (grid box centers),
      specified in list format.

   .. option:: center_at_180

      If :command:`true`, then westernmost grid boxes are centered
      at :math:`-180^{\circ}` longitude (the International Date Line).
      This is true for both :option:`MERRA2` and :option:`GEOS-FP`.
      
      If :command:`false`, then the westernmost grid boxes have their
      westernmost edges at :math:`-180^{\circ}` longitude.  This is
      true for the :option:`GCAP2` grid.

.. option:: latitude

   Settings to define the latitude dimension of the grid.  There are
   two sub-options:	    
      
   .. option:: range

      The minimum and maximum latitude values (grid box centers),
      specified in list format.

   .. option:: use_halfpolar_boxes
   
      If :command:`true`, then the northernmost and southernmost grid
      boxes will be :math:`\frac{1}{2}` the extent of other grid boxes.
      This is true for both :option:`MERRA2` and :option:`GEOS-FP`.
   
      If :command:`false`, then all grid boxes will have the same extent
      in latitude. This is true for the :option:`GCAP2` grid.

.. option:: nested_grid_simulation

   Settings for nested-grid simulations.  There are two sub-options:	    
      
   .. option:: activate
   
      If :command:`true`, this indicates that the simulation will use a
      sub-window of the horizontal grid.
   
      If :command:`false`, this indicates that the simulation will use
      the entire global grid extent.
   
   .. option:: buffer_zone_NSEW
   
      Specifies the nested grid latitude offsets (# of grid boxes) in list
      format :code:`[N-offset, S-offset, E-offset, W-offset]`.  These
      offsets are used to define an inner window region in which
      transport is actually done (aka the "transport window").  This
      "transport window" is always smaller than the actual size of the
      nested grid region in order to properly account for the boundary
      conditions.

   - For global simulations, use: :code:`[0, 0, 0, 0]`.
   - For nested-grid simulations, we recommend using: :code:`[3, 3, 3, 3]`.

.. _gc-yml-timesteps:

==================
Timesteps settings
==================

.. code-block:: YAML

   #============================================================================
   # Timesteps settings
   #============================================================================
   timesteps:
     transport_timestep_in_s: 600
     chemistry_timestep_in_s: 1200
     radiation_timestep_in_s: 10800

The :command:`timesteps` section specifies the frequency at which
various GEOS-Chem operations occur: 
     
.. option:: transport_timestep_in_s

   Specifies the "heartbeat" timestep of GEOS-Chem Classic.  This is
   the frequency at which transport, cloud convection, PBL mixing, and
   wet deposition will be done.

   - Recommended value for global simulations: :code:`600`
   - Recommended value for nested simluations: :code:`300` or smaller

.. option:: chemistry_timestep_in_s

   Specifies the frequency at which chemistry and emissions will be
   done.

   - Recommended value for global simulations :code:`1200`
   - Recommended value for nested simulations :code:`600` or smaller

.. option:: radiation_timestep_in_s

   Specifies the frequency at which the `RRTMG
   <http://wiki.geos-chem.org/Coupling_GEOS-Chem_with_RRTMG>`_ radiative
   transfer model will be called (valid for :option:`fullchem`
   simulations only).

.. _gc-yml-operations:

===================
Operations settings
===================

This section of :file:`geoschem_config.yml` is included for all
simulations.  However, some of the options listed below will be omitted for
simulations that do not require them.

There are several sub-sections under :code:`operations`:

.. _gc-yml-operations-chemistry:

Chemistry
----------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     chemistry:
       activate: true
       linear_chemistry_aloft:
         activate: true
         use_linoz_for_O3: true
       active_strat_H2O:
         activate: true
         use_static_bnd_cond: true
       gamma_HO2: 0.2

       # ... following sub-sections omitted ...

The :command:`operations:chemistry` section contains settings that control how
chemistry is done in GEOS-Chem Classic:

.. option:: activate

   Activates (:command:`true`) or deactivates (:command:`false`)
   chemistry in GEOS-Chem Classic.

.. option:: linear_chemistry_aloft

   Determines how linearized chemistry will be applied in the
   stratosphere and/or mesosphere.  (Only valid for :option:`fullchem`
   simulations).

   There are two sub-options:

   .. option:: activate

      Activates (:command:`true`) or deactivates (:command:`false`)
      linearized stratospheric chemistry in the stratosphere and/or
      mesosphere.

   .. option:: use_linoz_for_O3

      If :command:`true`, `Linoz stratospheric ozone chemistry
      <http://wiki.geos-chem.org/Linoz_stratospheric_ozone_chemistry>`_
      will be used.

      If :command:`false`, Synoz (i.e. a synthetic flux of ozone across
      the tropopause) will be used instead of Linoz.

.. option:: active_strat_H2O

   Determines if water vapor as modeled by GEOS-Chem classic will be
   allowed to influence humidity fields. (Only valid for
   :option:`fullchem` simulations)

   There are two sub-options:

   .. option:: activate

      Allows (:command:`true`) or disallows (:command:`false` the H2O
      species in GEOS-Chem classic to influence specific humidity and
      relative humidity.

   .. option:: use_static_bnd_cond

      Allows (:command:`true`) or diasallows (:command:`false`) a
      static boundary condition.

      **TODO** Clarify this

.. option:: gamma_HO2

   Specifies :math:`\gamma`, the uptake coefficient for :math:`HO_2`
   heterogeneous chemistry.

   Recommended value: :code:`0.2`.

.. _gc-yml-operations-convection:

Convection
----------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     convection:
       activate: true

     # ... following sub-sections omitted ...

The :command:`operations:convection` section contains settings that control how
`cloud convection <http://wiki.geos-chem.org/Cloud_convection>`_ is
done in GEOS-Chem Classic:
     
.. option:: activate
   
   Activates (:command:`true`) or deactivates (:command:`false`)
   cloud convection in GEOS-Chem Classic.

.. _gc-yml-operations-drydep:

Dry deposition
--------------
This section contains settings that control how `dry deposition
<http://wiki.geos-chem.org/Dry_deposition>`_ is done in GEOS-Chem
Classic:

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     dry_deposition:
       activate: true
       CO2_effect:
         activate: false
         CO2_level: 600.0
         reference_CO2_level: 380.0
       diag_alt_above_sfc_in_m: 10

     # ... following sub-sections omitted ...

The :command:`operations:dry_deposition` section contains settings
that control how dry deposition is done in GEOS-Chem Classic.
     
**TODO** add options here

.. _gc-yml-operations-pblmix:

PBL mixing
----------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     pbl_mixing:
       activate: true
       use_non_local_pbl: true

     # ... following sub-sections omitted ...


The :command:`operations:pbl_mixing` section contains settings that
control how `planetary boundary layer (PBL) mixing
<http://wiki.geos-chem.org/Boundary_layer_mixing>`_  is done in
GEOS-Chem Classic:

.. option:: activate

   Activates (:command:`true`) or deactivates (:command:`false`)
   planetary boundary layer mixing in GEOS-Chem Classic.

.. option:: use_non_local_pbl

   If :command:`true`, then the `non-local PBL mixing scheme (VDIFF)
   <http://wiki.geos-chem.org/Boundary_layer_mixing#VDIFF>`_ will
   be used.

   If :command:`false`, then the `full PBL mixing scheme (TURBDAY)
   <http://wiki.geos-chem.org/Boundary_layer_mixing#VDIFF>`_ will
   be used.

.. _gc-yml-operations-photolysis:

Photolysis
----------
This section contains settings that control how `photolysis
<http://wiki.geos-chem.org/FAST-JX_v7.0_photolysis_mechanism>`_ is
done in GEOS-Chem Classic.

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     photolysis:
       input_dir: ${RUNDIR_DATA_ROOT}/CHEM_INPUTS/FAST_JX/v2021-10/
       overhead_O3:
         use_online_O3_from_model: ${RUNDIR_USE_ONLINE_O3}
         use_column_O3_from_met: true
         use_TOMS_SBUV_O3: false
       photolyze_nitrate_aerosol:
         activate: false
         NITs_Jscale_JHNO3: 0.0
         NIT_Jscale_JHNO2: 0.0
         percent_channel_A_HONO: 66.667
         percent_channel_B_NO2: 33.333

     # ... following sub-sections omitted ...

**TODO** add options here

.. _gc-yml-rrtmg:

RRTMG radiative transfer model
------------------------------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     rrtmg_rad_transfer_model:
       activate: ${RUNDIR_USE_RRTMG}
       aod_wavelengths_in_nm:
         - 550
       longwave_fluxes: ${RUNDIR_RRTMG_OPTS}
       shortwave_fluxes: ${RUNDIR_RRTMG_OPTS}
       clear_sky_flux: ${RUNDIR_RRTMG_OPTS}
       all_sky_flux: ${RUNDIR_RRTMG_OPTS}

     # .. following sub-sections omitted ...

**TODO** add options here

.. _gc-yml-transport:

Transport
---------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     transport:
       gcclassic_tpcore:                 # GEOS-Chem Classic only
         activate: true                  # GEOS-Chem Classic only
         fill_negative_values: true      # GEOS-Chem Classic only
         iord_jord_kord: [3, 3, 7]       # GEOS-Chem Classic only
       transported_species:
         - ACET
         - ACTA
         - AERI
	 - ... etc more species ...

     # .. following sub-sections omitted ...

**TODO** add options here

.. _gc-yml-wetdep:

Wet deposition
--------------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     wet_deposition:
       activate: true

The :command:`operations:wet_deposition` section contains settings
that control how wet deposition is done in GEOS-Chem Classic:

.. option:: activate

   Activates (:command:`true`) or deactivates (:command:`false`)
   wet deposition in GEOS-Chem Classic.
