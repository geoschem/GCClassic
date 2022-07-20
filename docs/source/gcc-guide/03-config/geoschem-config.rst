.. _cfg-gc-yml:

###################
geoschem_config.yml
###################

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

The :code:`simulation` section contains general simulation options:

.. option:: name

   Specifies the type of GEOS-Chem simulation.  Accepted
   values are

   .. option:: fullchem

      Full-chemistry simulation.

   .. option:: aerosol

      `Aerosol-only simulation
      <http://wiki.geos-chem.org/Aerosol-only_simulation>`_.

   .. option:: CH4

      `Methane simulation <http://wiki.geos-chem.org/CH4_simulation>`_.

   .. option:: CO2

      `Carbon dioxide simulation <http://wiki.geos-chem.org/CO2_simulation>`_.

   .. option:: Hg

      `Mercury simulation <http://wiki.geos-chem.org/Mercury>`_.

   .. option:: POPs

      `Persistent organic pollutants (aka POPs) simulation
      <http://wiki.geos-chem.org/POPs simulation>`_.

      .. attention::

	 The POPs simulation is currently stale.  We look to members
	 of the GEOS-Chem user community take the lead on updating
	 this simulation.

   .. option:: tagCH4

       `Methane simulation
       <http://wiki.geos-chem.org/CH4_simulation>`_ with species
       tagged by geographic region or other criteria.

   .. option:: tagCO

      Carbon dioxide simulation, with species
      tagged by geographic region and other criteria.

   .. option:: tagO3

      `Ozone simulation
      <http://wiki.geos-chem.org/Tagged_O3_simulation>`_ (using
      specified production and loss rates),
      with species tagged by geographical region.

   .. option:: TransportTracers

      `Transport Tracers simulation
      <http://wiki.geos-chem.org/TransportTracers_simulation>`_, with
      both radionuclide and :option:`passive_species`.  Useful for
      evaluating model transport.

   .. option:: metals

      Trace metals simulation

.. option:: start_date

   Specifies the starting date and time of the simulation in list
   notation :code:`[YYYYMMDD, hhmmss]`.

.. option:: end_date

   Specifies the ending date and time of the simulation in list
   notation :code:`[YYYYMMDD, hhmmss]`.

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

   Activates (:code:`true`) or deactivates (:code:`false`)
   debug print statements to the screen or log file.

.. option:: use_gcclassic_timers

   Activates (:code:`true`) or deactivates (:code:`false`)
   the GEOS-Chem Classic timers.  If activated, information about how
   long each component of GEOS-Chem took to execute will be printed to
   the screen or log file.

.. _cfg-gc-yml-grid:

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

The :code:`grid` section contains settings that define the grid used
by GEOS-Chem Classic:

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

      If :code:`true`, then westernmost grid boxes are centered
      at :math:`-180^{\circ}` longitude (the International Date Line).
      This is true for both :option:`MERRA2` and :option:`GEOS-FP`.

      If :code:`false`, then the westernmost grid boxes have their
      westernmost edges at :math:`-180^{\circ}` longitude.  This is
      true for the :option:`GCAP2` grid.

.. option:: latitude

   Settings to define the latitude dimension of the grid.  There are
   two sub-options:

   .. option:: range

      The minimum and maximum latitude values (grid box centers),
      specified in list format.

   .. option:: use_halfpolar_boxes

      If :code:`true`, then the northernmost and southernmost grid
      boxes will be :math:`\frac{1}{2}` the extent of other grid boxes.
      This is true for both :option:`MERRA2` and :option:`GEOS-FP`.

      If :code:`false`, then all grid boxes will have the same extent
      in latitude. This is true for the :option:`GCAP2` grid.

.. option:: nested_grid_simulation

   Settings for nested-grid simulations.  There are two sub-options:

   .. option:: activate

      If :code:`true`, this indicates that the simulation will use a
      sub-window of the horizontal grid.

      If :code:`false`, this indicates that the simulation will use
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

.. _cfg-gc-yml-timesteps:

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

The :code:`timesteps` section specifies the frequency at which
various GEOS-Chem operations occur:

.. option:: transport_timestep_in_s

   Specifies the "heartbeat" timestep of GEOS-Chem..  This is
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

.. _cfg-gc-yml-operations:

===================
Operations settings
===================

This section of :file:`geoschem_config.yml` is included for all
simulations.  However, some of the options listed below will be omitted for
simulations that do not require them.

There are several sub-sections under :code:`operations`:

.. _cfg-gc-yml-operations-chemistry:

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

The :code:`operations:chemistry` section contains settings for chemistry:

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`)
   chemistry in GEOS-Chem.

.. option:: linear_chemistry_aloft

   Determines how linearized chemistry will be applied in the
   stratosphere and/or mesosphere.  (Only valid for :option:`fullchem`
   simulations).

   There are two sub-options:

   .. option:: activate

      Activates (:code:`true`) or deactivates (:code:`false`)
      linearized stratospheric chemistry in the stratosphere and/or
      mesosphere.

   .. option:: use_linoz_for_O3

      If :code:`true`, `Linoz stratospheric ozone chemistry
      <http://wiki.geos-chem.org/Linoz_stratospheric_ozone_chemistry>`_
      will be used.

      If :code:`false`, Synoz (i.e. a synthetic flux of ozone across
      the tropopause) will be used instead of Linoz.

.. option:: active_strat_H2O

   Determines if water vapor as modeled by GEOS-Chem will be
   allowed to influence humidity fields. (Only valid for
   :option:`fullchem` simulations)

   There are two sub-options:

   .. option:: activate

      Allows (:code:`true`) or disallows (:code:`false` the H2O
      species in GEOS-Chem to influence specific humidity and
      relative humidity.

   .. option:: use_static_bnd_cond

      Allows (:code:`true`) or diasallows (:code:`false`) a
      static boundary condition.

      **TODO** Clarify this

.. option:: gamma_HO2

   Specifies :math:`\gamma`, the uptake coefficient for :math:`HO_2`
   heterogeneous chemistry.

   Recommended value: :code:`0.2`.

.. _cfg-gc-yml-operations-convection:

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

The :command:`operations:convection` section contains settings for
`cloud convection <http://wiki.geos-chem.org/Cloud_convection>`_:

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`)
   cloud convection in GEOS-Chem.

.. _cfg-gc-yml-operations-drydep:

Dry deposition
--------------

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

The :code:`operations:dry_deposition` section contains settings that
for `dry deposition <http://wiki.geos-chem.org/Dry_deposition>`_:

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`)
   dry deposition.

.. option:: CO2_effect

   This sub-section contains options for applying the
   `simple parameterization for the CO2 effect on stomatal resistance
   <http://wiki.geos-chem.org/Dry_deposition#Simple_parameterization_for_CO2_dependence_of_stomatal_resistance>`_.

   .. option:: activate

      Activates (:code:`true`) or deactivates (:code:`false`) the CO2
      effect on stomatal resistance in dry deposition.

      Default value: :code:`false`.

   .. option:: CO2_level

      Specifies the CO2 level (in ppb).

   .. option:: reference_CO2_level

      Specifies the reference CO2 level (in ppb).

.. option:: diag_alt_above_sfc_in_m:

   Specifies the altitude above the surface (in m) to used with the
   `ConcAboveSfc diagnostic collection <http://wiki.seas.harvard.edu/geos-chem/index.php/History_collections_for_dry_deposition#The_ConcAboveSfc_collection>`_.

.. _cfg-gc-yml-operations-pblmix:

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

The :code:`operations:pbl_mixing` section contains settings that
for `planetary boundary layer (PBL) mixing
<http://wiki.geos-chem.org/Boundary_layer_mixing>`_:

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`)
   planetary boundary layer mixing in GEOS-Chem Classic.

.. option:: use_non_local_pbl

   If :code:`true`, then the `non-local PBL mixing scheme (VDIFF)
   <http://wiki.geos-chem.org/Boundary_layer_mixing#VDIFF>`_ will
   be used. (Default option)

   If :code:`false`, then the `full PBL mixing scheme (TURBDAY)
   <http://wiki.geos-chem.org/Boundary_layer_mixing#VDIFF>`_ will
   be used.

.. _cfg-gc-yml-operations-photolysis:

Photolysis
----------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     photolysis:
       input_dir: /path/to/ExtData/CHEM_INPUTS/FAST_JX/v2021-10/
       overhead_O3:
         use_online_O3_from_model: true
         use_column_O3_from_met: true
         use_TOMS_SBUV_O3: false
       photolyze_nitrate_aerosol:
         activate: false
         NITs_Jscale_JHNO3: 0.0
         NIT_Jscale_JHNO2: 0.0
         percent_channel_A_HONO: 66.667
         percent_channel_B_NO2: 33.333

     # ... following sub-sections omitted ...

The :code:`operation:photolysis` section contains settings for
`photolysis
<http://wiki.geos-chem.org/FAST-JX_v7.0_photolysis_mechanism>`_.

This section only applies to :option:`fullchem` and :option:`Hg` simultions.

.. option:: input_dir

   Specifies the path to the FAST_JX configuration file that contain
   information about species cross sections and quantum yields.

.. option:: overhead_O3

   This section contains settings that control which overhead ozone
   sources are used for photolysis

   .. option:: use_online_O3_from_model

      Activates (:code:`true`) or deactivates (:code:`false`) using
      online O3 from GEOS-Chem in the extinction calculations for
      FAST-JX photolysis.

      Recommended value: :code:`true`

  .. option:: use_column_O3_from_met

     Activates (:code:`true`) or deactivates (:code:`false`) using
     ozone columns (e.g. TO3) from the meteorology fields.

     Recommended value: :code:`true`.

  .. option:: use_TOMS_SBUV_O3

     Activates (:code:`true`) or deactivates (:code:`false`) using
     ozone columns from the TOMS-SBUV archive  will be used.

     Recommended value: :code:`false`.

.. _cfg-gc-yml-rrtmg:

RRTMG radiative transfer model
------------------------------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem operations
   #============================================================================
   operations:

     # .. preceding sub-sections omitted ...

     rrtmg_rad_transfer_model:
       activate: false
       aod_wavelengths_in_nm:
         - 550
       longwave_fluxes: false
       shortwave_fluxes: false
       clear_sky_flux: false
       all_sky_flux: false

     # .. following sub-sections omitted ...

The :code:`operations:rrtmg_rad_transfer_model` section contains
settings for the `RRTMG radiative transfer model
<http://wiki.geos-chem.org/Coupling_RRTMG_to_GEOS-Chem>`_:

This section only applies to :option:`fullchem` simultions.

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`) the RRTMG
   radiative transfer model.

   Default value: :code:`false`.

.. option:: aod_wavelengths_in_nm

   Specify wavelength(s) for the aerosol optical properties in nm
   (in `YAML sequence format
   <https://www.tutorialspoint.com/yaml/yaml_sequence_styles.htm>`_)
   Up to three wavelengths can be selected.  The specified wavelengths
   are  used for the `FAST-JX photolysis mechanism
   <http://wiki.geos-chem.org/FAST-JX_v7.0_photolysis_mechanism>`_
   regardless of whether the RRTMG radiative transfer model is used.

.. option:: longwave_fluxes

   Activates (:code:`true`) or deactivates (:code:`false`)
   RRTMG longwave flux calculations.

   Default value: :code:`false`.

.. option:: shortwave_fluxes

   Activates (:code:`true`) or deactivates (:code:`false`)
   RRTMG shortwave calculations.

   Default value: :code:`false`.

.. option:: clear_sky_flux

   Activates (:code:`true`) or deactivates (:code:`false`)
   RRTMG clear-sky flux calculations.

   Default value: :code:`false`.

.. option:: all_sky_flux

   Activates (:code:`true`) or deactivates (:code:`false`)
   RRTMG all-sky flux calculations.

   Default value: :code:`false`.

.. _cfg-gc-yml-transport:

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
	 # ... etc more transported species ...
       passive_species:
         PassiveTracer:
           long_name: Passive_tracer_for_mass_conservation_evaluation
           mol_wt_in_g: 1.0
           lifetime_in_s: -1
           default_bkg_conc_in_vv: 1.0e-7
         # ... etc more passive species ...

   # .. following sub-sections omitted ...

The :code:`operations:transport` section contains
settings for `species transport
<http://wiki.geos-chem.org/Advection_scheme_TPCORE>`_:

.. option:: gcclassic_tpcore

   Contains options that control species transport in GEOS-Chem
   Classic with the `TPCORE advection scheme
   <http://wiki.geos-chem.org/Advection_scheme_TPCORE>`_:

   .. option:: activate

      Activates (:code:`true`) or deactivates (:code:`false`) species
      transport in GEOS-Chem Classic.

      Default value: :code:`true`.

   .. option:: fill_negative_values

      If :code:`true`, negative species concentrations will be
      replaced with zeros.

      If :code:`false`, no change will be made to species
      concentrations.

      Default value: :code:`true`.

   .. option:: iord_jord_kord

      Specifies advection options (in list format) for TPCORE in the
      longitude, latitude, and vertical dimensions.  The options are
      listed below:

      #. 1st order upstream scheme (use for debugging only)
      #. 2nd order van Leer (full monotonicity constraint)
      #. Monotonic PPM
      #. Semi-monotonic PPM (same as 3, but overshoots are allowed)
      #. Positive-definite PPM
      #. Un-constrained PPM (use when fields & winds are very smooth)
         this option only when the fields and winds are very smooth.
      #. Huynh/Van Leer/Lin full monotonicity constraint (KORD only)

      Default (and recommended) value: :code:`[3, 3, 7]`

.. option:: transported_species

   A list of species names (in `YAML sequence format
   <https://www.tutorialspoint.com/yaml/yaml_sequence_styles.htm>`_)
   that will be transported by the TPCORE advection scheme.

.. option:: passive_species

   Optional menu that allows you to specify **passive species**, which
   are excluded from undergoing chemical reactions.

   Define passive species by providing the name of the species along
   with associated metadata fields. For example:

   .. code-block:: YAML

      PassiveTracer:
        long_name: Passive_tracer_for_mass_conservation_evaluation
        mol_wt_in_g: 1.0
        lifetime_in_s: -1              # -1 indicates infinite lifetime!
        default_bkg_conc_in_vv: 1.0e-7

   Each passive species must also be listed under
   :option:`transported_species`.

.. _cfg-gc-yml-wetdep:

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

The :code:`operations:wet_deposition` section contains settings
for `wet deposition <http://wiki.geos-chem.org/Wet_deposition>`_.

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`)
   wet deposition in GEOS-Chem Classic.

.. _gc-yml-aerosols:

=================
Aerosols settings
=================

This section of :file:`geoschem_config.yml` is included for
:option:`fullchem` and :option:`aerosol` simulations.

There are several sub-sections under :code:`aerosols`:

.. _cfg-gc-yml-aerosol-carbon:

Carbon aerosols
---------------

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem aerosols
   #============================================================================
   aerosols:

     carbon:
       activate: true
       brown_carbon: false
       enhance_black_carbon_absorption:
         activate: true
         hydrophilic: 1.5
         hydrophobic: 1.0

     # .. following sub-sections omitted ...

The :code:`aerosols:carbon` section contains settings for
`carbon aerosols
<http://wiki.geos-chem.org/Carbonaceous_aerosols>`_:

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`) carbon
   aerosols in GEOS-Chem.

   Default value: :code:`true`.

.. option:: brown_carbon

   Activates (:code:`true`) or deactivates (:code:`false`) brown
   carbon aerosols in GEOS-Chem.

   Default value: :code:`false`.

.. option:: enhance_black_carbon_absorption

   Options for enhancing the absorption of black carbon aerosols
   due to external coating.

   .. option:: activate

      Activates (:code:`true`) or deactivates (:code:`false`) black
      carbon absorption enhancement.

      Default value: :code:`true`.

   .. option:: hydrophilic

      Absorption enhancement factor for hydrophilic black carbon
      aerosol (species name **BCPI**).

      Default value: :code:`1.5`

   .. option:: hydrophobic

      Absorption enhancement factor for hydrophilic black carbon
      aerosol (species name **BCPO**).

      Default value: :code:`1.0`

.. _cfg-gc-yml-aerosols-soa:

Complex SOA
-----------
The :code:`aerosols:complex_SOA` section contains settings for
`the complex SOA scheme used in GEOS-Chem
<http://wiki.seas.harvard.edu/geos-chem/index.php/Secondary_organic_aerosols#Complex_SOA_scheme>`_.

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem aerosols
   #============================================================================
   aerosols:

     # ... preceding sub-sections omitted ...

     complex_SOA:
       activate:  true
       semivolatile_POA: false

     # ... following sub-sections omitted ...

.. option:: activate

    Activates (:code:`true`) or deactivates (:code:`false`) the
    complex SOA scheme.

    Default value:

    - :code:`true` for the :option:`fullchem` benchmark simulation
    - :code:`false` for all other :option:`fullchem` simulations

.. option:: semivolatile_POA

    Activates (:code:`true`) or deactivates (:code:`false`) the
    semi-volatile primary organic aerosol (POA) option.

    Default value: :code:`false`

.. _gc-yml-aerosols-dust:

Mineral dust aerosols
---------------------
The :code:`aerosols:dust` section contains settings for
`mineral dust aerosols
<http://wiki.seas.harvard.edu/geos-chem/index.php/Mineral_dust_aerosols>`_.

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem aerosols
   #============================================================================
   aerosols:

     # ... preceding sub-sections omitted ...

     dust:
       activate: true
       acid_uptake_on_dust: false

     # ... following sub-sections omitted ...

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`) mineral
   dust aerosols in GEOS-Chem.

   Default value: :code:`true`

.. option:: acid_uptake_on_dust

   Activates (:code:`true`) or deactivates (:code:`false`) the
   `acid uptake on dust option
   <http://wiki.seas.harvard.edu/geos-chem/index.php/Mineral_dust_aerosols#Surface_chemistry_on_dust>`_,
   which includes 12 additional species.

   Default value: :code:`false`

.. _cfg-gc-yml-aerosols-seasalt:

Sea salt aerosols
-----------------
The :code:`aerosols:sea_salt` section contains settings for `sea salt
aerosols
<http://wiki.seas.harvard.edu/geos-chem/index.php/Sea_salt_aerosols>`_:

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem aerosols
   #============================================================================
   aerosols:

     # ... preceding sub-sections omitted ...

     sea_salt:
       activate: true
       SALA_radius_bin_in_um: [0.01, 0.5]
       SALC_radius_bin_in_um: [0.5,  8.0]
       marine_organic_aerosols: false

     # ... following sub-sections omitted ...

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`) sea salt
   aerosols.

   Default value: :code:`true`

.. option:: SALA_radius_bin_in_um

   Specifies the upper and lower boundaries (in nm) for
   accumulation-mode sea salt aerosol (aka **SALA**).

   Default value: :code:`0.01 nm - 0.5 nm`

.. option:: SALC_radius_bin_in_um

   Specifies the upper and lower boundaries (in nm) for
   coarse-mode sea salt aerosol (aka **SALC**).

   Default value: :code:`0.5 nm - 8.0 nm`

.. option:: marine_organic_aerosols

   Activates (:code:`true`) or deactivates (:code:`false`)
   `emission of marine primary organic aerosols
   <http://wiki.seas.harvard.edu/geos-chem/index.php/Aerosol_emissions#Online_emission_of_marine_primary_organic_aerosol_.28POA.29>`_.
   This option includes two extra species (**MOPO** and **MOPI**).

   Default value: :code:`false`

.. _cfg-gc-yml-aerosols-strat:

Stratospheric aerosols
----------------------
The :code:`aerosols:sulfate` section contains settings for
stratopsheric aerosols.

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem aerosols
   #============================================================================
   aerosols:

     # ... preceding sub-sections omitted ...

     stratosphere:
       settle_strat_aerosol: true
       polar_strat_clouds:
         activate: true
         het_chem: true
       allow_homogeneous_NAT: false
       NAT_supercooling_req_in_K: 3.0
       supersat_factor_req_for_ice_nucl: 1.2
       calc_strat_aod: true

     # ... following sub-sections omitted ...


.. option:: settle_strat_aerosol

   Activates (:code:`true`) or deactivates (:code:`false`)
   gravitational settling of stratospheric solid particulate aerosols
   (SPA, trapezoidal scheme) and stratospheric liquid aerosols (SLA,
   corrected Stokes' Law).

   Default value: :code:`true`

.. option:: polar_strat_clouds

   Contains settings for how aerosols are handled in polar
   stratospheric clouds (PSC):

   .. option:: activate

      Activates (:code:`true`) or deactivates (:code:`false`)
      formation of polar stratospheric clouds.

      Default value: :code:`true`

   .. option:: het_chem

      Activates (:code:`true`) or deactivates (:code:`false`)
      heterogeneous chemistry within polar stratospheric clouds.

      Default value: :code:`true`

.. option:: allow_homogeneous_NAT

   Activates (:code:`true`) or deactivates (:code:`false`)
   heterogeneous formation of NAT from freezing of HNO3.

   Default value: :code:`false`

.. option:: NAT_supercooling_req_in_K

   Specifies the cooling (in K) required for homogeneous NAT nucleation.

   Default value: :code:`3.0`

.. option:: supersat_factor_req_for_ice_nucl

   Specifies the supersaturation factor required for ice nucleation.

   Recommended values: :code:`1.2` for coarse grids; :code:`1.5` for
   fine grids.

.. option:: calc_strat_aod

   Includes (:code:`true`) or excludes (:code:`false`) online
   stratospheric aerosols in extinction calculations for photolysis.

   Default value: :code:`true`

.. _cfg-gc-yml-aerosols-sulfate:

Sulfate aerosols
----------------
The :code:`aerosols:sulfate` section contains settings for `sulfate
aerosols <http://wiki.geos-chem.org/Sulfate_aerosols>`_:

.. code-block:: YAML

   #============================================================================
   # Settings for GEOS-Chem aerosols
   #============================================================================
   aerosols:

     # ... preceding sub-sections omitted ...

     sulfate:
       activate: true
       metal_cat_SO2_oxidation: true

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`) sulfate aerosols.

   Default value: :code:`true`

.. option:: metal_cat_SO2_oxidation

   Activates (:code:`true`) or deactivates (:code:`false`) the
   `metal catalyzed oxidation of SO2
   <http://wiki.geos-chem.org/Sulfate_aerosols#Metal_catalyzed_oxidation_of_SO2>`_.

   Default value: :code:`true`

.. _cfg-gc-yml-xdiag:

=================
Extra diagnostics
=================

The :code:`extra_diagnostics` section contains settings for GEOS-Chem Classic
diagnostics that are not archived by :ref:`History
<history-diagnostics>` or `HEMCO <https://hemco.readthedocs.io>`_:

.. _gc-yml-xdiag-obspack:

Obspack diagnostic
------------------

The :code:`extra_diagnostics:obspack` section contains settings for
the `Obspack diagnostic <https://wiki.geos-chem.org/Obspack_diagnostic>`_:

.. code-block:: YAML

   #============================================================================
   # Settings for diagnostics (other than HISTORY and HEMCO)
   #============================================================================
   extra_diagnostics:

     obspack:
       activate: false
       quiet_logfile_output: false
       input_file: ./obspack_co2_1_OCO2MIP_2018-11-28.YYYYMMDD.nc
       output_file: ./OutputDir/GEOSChem.ObsPack.YYYYMMDD_hhmmz.nc4
       output_species:
         - CO
         - 'NO'
         - O3

     # ... following sub-sections omitted ...

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`) ObsPack
   diagnostic output.

   Default value: :code:`true`

.. option:: quiet_logfile_output

   Deactivates (:code:`true`) or activates (:code:`false`) printing
   informational output to :code:`stdout` (i.e. the screen or log file).

   Default value: :code:`false`

.. option:: input_file

   Specifies the path to an ObsPack data file (in netCDF format).

.. option:: output_file

   Specifies the path to the ObsPack diagnostic output file.  This
   will be a file that contains data at the same locations as
   specified in :option:`input_file`.

.. option:: output_species

   A list of GEOS-Chem species (as a YAML sequence) to archive to the
   output file.


Planeflight diagnostic
-----------------------
The :code:`extra_diagnostics:planeflight` section contains settings for
the `GEOS-Chem planeflight diagnostic
<https://wiki.geos-chem.org/Planeflight_diagnostic>`_:

.. code-block:: YAML

   #============================================================================
   # Settings for diagnostics (other than HISTORY and HEMCO)
   #============================================================================
   extra_diagnostics:

     # ... preceding sub-sections omitted ...

     planeflight:
       activate: false
       flight_track_file: Planeflight.dat.YYYYMMDD
       output_file: plane.log.YYYYMMDD

     # ... following sub-sections omitted ...

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`) the
   Planeflight diagnostic output.

   Default value: :code:`false`

.. option:: flight_track_file

   Specifies the path to a flight track file.  This file contains
   the coordinates of the plane as a function of time, as well as the
   requested quantities to archive.

.. option:: output_file

   Specifies the path to the Planeflight output file.  Requested
   quantities will be archived from GEOS-Chem along the flight track
   specified in :option:`flight_track_file`.

.. _gc-yml-legacydiag:

Legacy diagnostics
------------------

.. attention::

   These diagnostics (in the older binary data format) are slated to
   be replaced by netCDF output in an upcoming version.

.. code-block:: YAML

   #============================================================================
   # Settings for diagnostics (other than HISTORY and HEMCO)
   #============================================================================
   extra_diagnostics:

      # ... preceding sub-sections omitted ...

      gamap:
        diaginfo_dat_file: ./diaginfo.dat
        tracerinfo_dat_file: ./tracerinfo.dat

      ND51_satellite:
        activate: false
        output_file: ts_satellite.YYYYMMDD.bpch
        tracers:
          - 1
          - 2
          - 501
        UTC_hour_for_write: 0
        averaging_period_in_LT: [9, 11]
        IMIN_and_IMAX_of_region: [1, 72]
        JMIN_and_JMAX_of_region: [1, 46]
        LMIN_and_LMAX_of_region: [1, 1]

      ND51b_satellite:
        # same format as ND51_satellite

The :code:`extra_diagnostics:gamap` specify the paths where GEOS-Chem
will create the :file:`diaginfo.dat` and :file:`tracerinfo.dat` files
used by `GAMAP <https://geoschem.github.io/gamap-manual/>`_.

The :code:`extra_diagnostics:ND51_satellite` and
:code:`extra_diagnostics:ND51b_satellite` contain settings for the
`GEOS-Chem satellite timeseries
diagnostics. <http://wiki.seas.harvard.edu/geos-chem/index.php/The_input.geos_file#ND51_and_ND51b_diagnostics>`_.
These will be replaced by :ref:`history-diagnostics` (in netCDF format) in an
upcoming version.

.. _cfg-gc-yml-CH4:

======================
CH4 simulation options
======================

This section of :file:`geoschem_config.yml` is included for
the :option:`CH4` simulation:

.. _gc-yml-ch4_obsopt:

Observational operators
-----------------------

The :code:`ch4_simulation_options:use_observational_operators` section
contains options for using satellite observational operators:

.. code-block:: YAML

   #============================================================================
   # Settings specific to the CH4 simulation / Integrated Methane Inversion
   #============================================================================
   ch4_simulation_options:

     use_observational_operators:
       AIRS: false
       GOSAT: false
       TCCON: false

     # ... following sub-sections omitted ...

.. option:: AIRS

   Activates (:code:`true`) or deactivates (:code:`false`) the
   AIRS observational operator.

   Default value: :code:`false`

.. option:: GOSAT

   Activates (:code:`true`) or deactivates (:code:`false`) the
   GOSAT observational operator.

   Default value: :code:`false`

.. option:: TCCON

   Activates (:code:`true`) or deactivates (:code:`false`) the
   GOSAT observational operator.

   Default value: :code:`false`

.. _gc-yml-ch4_anopt:

Analytical inversion options
----------------------------

The :code:`ch4_simulation_options:analytical_inversion` section
contains options for analytical inversions (cf. the
`Integrated Methane Inversion <https://imi.readthedocs.io>`_).

.. code-block:: YAML

   #============================================================================
   # Settings specific to the CH4 simulation / Integrated Methane Inversion
   #============================================================================
   ch4_simulation_options:

     # ... preceding sub-sections omitted ...

     analytical_inversion:
       activate: true
       emission_perturbation: 1.0
       state_vector_element_number: 0
       use_emission_scale_factor: false
       use_OH_scale_factors: false

.. option:: activate

   Activates (:code:`true`) or deactivates (:code:`false`) the
   analytical inversion.

   Default value: :code:`true`

.. option:: activate

   Specifies a factor by which emissions at a grid box will be
   perturbed.

   Default value: :code:`1.0`

.. option:: state_vector_element_number

   Specifies the element of the state vector used for the inversion.

   Default value: :code:`0`

.. option:: use_emission_scale_factor

   Activates (:code:`true`) or deactivates (:code:`false`) scaling
   methane emissions by a fixed factor.

   Default value: :code:`false`

.. option:: use_emission_scale_factor

   Activates (:code:`true`) or deactivates (:code:`false`) scaling
   OH by a fixed factor.

   Default value: :code:`false`

.. _cfg-gc-yml-co2:

======================
CO2 simulation options
======================

This section of :file:`geoschem_config.yml` is included for
the :option:`CO2` simulation:

.. _gc-yml-co2-sources:

CO2 Sources
-----------

The :code:`CO2_simulation_options:sources` section contains toggles
for activating sources of :math:`CO_2`:

.. code-block:: YAML

   #============================================================================
   # Settings specific to the CO2 simulation
   #============================================================================
   CO2_simulation_options:

     sources:
       fossil_fuel_emissions: true
       ocean_exchange: true
       balanced_biosphere_exchange: true
       net_terrestrial_exchange: true
       ship_emissions: true
       aviation_emissions: true
       3D_chemical_oxidation_source: true

     # ... following sub-sections omitted ...

.. option:: fossil_fuel_emissions

   Activates (:code:`true`) or deactivates (:code:`false`)
   using :math:`CO_2` fossil fuel emissions as computed by HEMCO.

   Default value: :code:`true`

.. option:: ocean_exchange

   Activates (:code:`true`) or deactivates (:code:`false`)
   :math:`CO_2` ocean-air exchange.

   Default value: :code:`true`

.. option:: balanced_biosphere_exchange

   Activates (:code:`true`) or deactivates (:code:`false`)
   :math:`CO_2` balanced-biosphere exchange.

   Default value: :code:`true`

.. option:: net_terrestrial_exchange

   Activates (:code:`true`) or deactivates (:code:`false`)
   :math:`CO_2` net terrestrial exchange.

   Default value: :code:`true`

.. option:: ship_emissions

   Activates (:code:`true`) or deactivates (:code:`false`) :math:`CO_2`
   ship emissions as computed by HEMCO.

   Default value: :code:`true`

.. option:: aviation_emissions

   Activates (:code:`true`) or deactivates (:code:`false`) :math:`CO_2`
   aviation emissions as computed by HEMCO.

   Default value: :code:`true`

.. option:: 3D_chemical_oxidation_source

   Activates (:code:`true`) or deactivates (:code:`false`)
   :math:`CO_2` production by archived chemical oxidation, as read by
   HEMCO.

   Default value: :code:`true`

.. _cfg-gc-yml-co2-tagspc:

CO2 tagged species
-------------------

The :code:`CO2_simulation_options:tagged_species` section contains toggles
for activating tagged :math:`CO_2` species:

.. attention::

   Tagged :math:`CO_2` tracers should be customized by each user and
   the present configuration will not work for resolutions other than
   :math:`2.0^{\circ} {\times} 2.5^{\circ}`.

.. code-block:: YAML

   #============================================================================
   # Settings specific to the CO2 simulation
   #============================================================================
   CO2_simulation_options:

     # ... preceding sub-sections omitted ...

     tagged_species:
       save_fossil_fuel_in_background: false
       tag_bio_and_ocean_CO2: false
       tag_land_fossil_fuel_CO2:
       tag_global_ship_CO2: false
       tag_global_aircraft_CO2: false

.. option:: save_fossil_fuel_in_background

   Activates (:code:`true`) or deactivates (:code:`false`) saving the
   :math:`CO_2` background.

   Default value: :code:`false`

.. option:: tag_bio_and_ocean_CO2

   Activates (:code:`true`) or deactivates (:code:`false`) tagging of
   biosphere regions (28), ocean regions (11), and the rest of the
   world (ROW) as specified in :file:`Regions_land.dat` and
   :file:`Regions_ocean.dat` files.

     # .. following sub-sections omitted ...

.. _cfg-gc-yml-hg:

=====================
Hg simulation options
=====================

This section of :file:`geoschem_config.yml` is included for
the `mercury (Hg) simulation <https://wiki.geos-chem.org/Mercury>`_:

.. _cfg-gc-yml-hg-src:

Hg sources
----------

The :code:`Hg_simulation_options:sources` section contains settings
for various mercury sources.

.. code-block:: YAML

   #============================================================================
   # Settings specific to the Hg simulation
   #============================================================================
   Hg_simulation_options:

     sources:
       use_dynamic_ocean_Hg: false
       use_preindustrial_Hg: false
       use_arctic_river_Hg: true

     # ... following sub-sections omitted ...

.. option:: use_dynamic_ocean_Hg

   Activates (:code:`true`) or deactivates (:code:`false`) the online
   slab ocean mercury model.

   Default value: :code:`false`

.. option:: use_preindustrial_Hg

   Activates (:code:`true`) or deactivates (:code:`false`) the
   preindustrial mercury simulation.  This will turn off all
   anthropogenic emissions.

   Default value: :code:`false`

.. option:: use_arctic_river_Hg

   Activates (:code:`true`) or deactivates (:code:`false`) the
   source of mercury from arctic rivers.

   Default value: :code:`true`

.. _cfg-gc-yml-hg-chem:

Hg chemistry
------------

The :code:`Hg_simulation_options:chemistry` section contains settings
for mercury chemistry:

.. code-block:: YAML

   #============================================================================
   # Settings specific to the Hg simulation
   #============================================================================
   Hg_simulation_options:

     # ... preceding sub-sections omitted ...

     chemistry:
       tie_HgIIaq_reduction_to_UVB: true

     # ... following sub-sections omitted ...

.. option:: tie_HgIIaq_reduction_to_UVB

   Activates (:code:`true`) or deactivates (:code:`false`) linking the
   reduction of aqueous oxidized mercury to UVB radiation.
   A lifetime of -1 seconds indicates the species has an infinite lifetime.

   Default value: :code:`true`

.. _cfg-gc-yml-tagco:

============================
Tagged CO simulation options
============================

The :code:`tagged_CO_simulation_options` section contains settings
for the `tagged CO simulation
<https://wiki.geos-chem.org/Tagged_CO_simulation>`_.

.. code-block:: YAML

   #============================================================================
   # Settings specific to the tagged CO simulation
   #============================================================================

   tagged_CO_simulation_options:
     use_fullchem_PCO_from_CH4: true
     use_fullchem_PCO_from_NMVOC: true

.. option:: use_fullchem_PCO_from_CH4

    Activates (:code:`true`) or deactivates (:code:`false`) applying
    the production of :math:`CO` from :math:`CH_4`.  This field is
    archived from a 1-year or 10-year :option:`fullchem` benchmark
    simulation and is read from disk via HEMCO.

    Default value: :code:`true`

.. option:: use_fullchem_PCO_from_NMVOC

    Activates (:code:`true`) or deactivates (:code:`false`) applying
    the production of :math:`CO` from non-methane volatile organic
    compounds (VOCs). This field is archived from a 1-year or 10-year
    :option:`fullchem` benchmark simulation and is read from disk via
    HEMCO.

    Default value: :code:`true`
