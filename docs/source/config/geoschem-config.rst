.. _geoschem-config:

############################
The geoschem_config.yml file
############################

Starting with GEOS-Chem 14.0.0, the :file:`input.geos` configuration
file (plain text) has been replaced with by the
:file:`geoschem_config.yml` file.  This file is in `YAML
<https://yaml.org>`_ format, which is a text-based markup syntax used
for representing dictionary-like data structures.

The :file:`geoschem_config.yml` file contains several sections.  Only
the sections relevant to a given type of simulation are present.
(For example, :option:`fullchem` simulation options such as aerosol
settings and photolysis settings are omitted from the
:file:`geoschem_config.yml` file for the :option:`CH4` simulation.)

===================
Simulation settings
===================

This section of :file:`geoschem_config.yml` is included for all
simulations.

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

.. option:: simulation:name

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

.. option:: simulation:start_date

   Specifies the starting date and time of the simulation in list
   notation [YYYYMMDD, hhmmss].

.. option:: simulation:end_date

   Specifies the ending date and time of the simulation in list
   notation [YYYYMMDD, hhmmss].

.. option:: simulation:root_data_dir

   Path to the root data directory.  All of the data that GEOS-Chem
   Classic reads must be located in subfolders of this directory.

.. option:: simulation:met_field

   Name of the meteorology product that will be used to drive
   GEOS-Chem Classic.  Accepted values are:

   .. option:: MERRA2

      The `MERRA-2 <https://wiki.geos-chem.org/MERRA-2>`_ meteorology
      product from NASA/GMAO.  MERRA-2 is a stable reanalysis product,
      and extends from approximately 1980 to present.  **(Recommended option)**

   .. option:: GEOS-FP

      The `GEOS-FP <https://wiki.geos-chem.org/MERRA-2>`_ meteorology
      product from NASA/GMAO.  GEOS-FP is an operational data product
      and, unlike MERRA-2, periodically receives science updates.

   .. option:: GCAP2

      The GCAP-2 meteorology product, archived from the GISS-2 GCM.
      GCAP-2 has hundreds of years of data available, making it useful
      for simulations of historical climate.

.. option:: simulation:species_database_file

   Path to the `GEOS-Chem Species Database
   <http://wiki.geos-chem.org/GEOS-Chem_species_database>`_ file.
   This is stored in the run directory file
   :file:`./species_database.yml`.  You should not have to edit this
   setting.

.. option:: simulation:debug_printout

   Activates (:command:`true`) or deactivates (:command:`false`)
   debug print statements to the screen or log file.

.. option:: simulation:use_gcclassic_timers

   Activates (:command:`true`) or deactivates (:command:`false`)
   the GEOS-Chem Classic timers.  If activated, information about how
   long each component of GEOS-Chem took to execute will be printed to
   the screen or log file.

=============
Grid settings
=============

This section of :file:`geoschem_config.yml` is included for all
simulations.

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

.. option:: grid:resolution

   Specifies the horizontal resolution of the grid.  Accepted values
   are:

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

.. option:: grid:number_of_levels

   Number of vertical levels to use in the simulation.  Accepted
   values are:

   .. option:: 72

      Use 72 vertical levels.  This is the native vertical resolution
      of :option:`MERRA2` and :option:`GEOS-FP`.

   .. option:: 47

      Use 47 vertical levels (for :option:`MERRA2` and :option:`GEOS-FP`).

   .. option:: 40

      Use 40 vertical levels (for :option:`GCAP2`).

.. option:: grid:longitude:range

   The minimum and maximum longitude values (grid box centers),
   specified in list format.

.. option:: grid:longitude:center_at_180

   If :command:`true`, then westernmost grid boxes are centered
   at :math:`-180^{\circ}` longitude (the International Date Line).
   This is true for both :option:`MERRA2` and :option:`GEOS-FP`.

   If :command:`false`, then the westernmost grid boxes have their
   westernmost edges at :math:`-180^{\circ}` longitude.  This is
   true for the :option:`GCAP2` grid.

.. option:: grid:latitude:range

   The minimum and maximum latitude values (grid box centers),
   specified in list format.

.. option:: grid:latitude:use_halfpolar_boxes

   If :command:`true`, then the northernmost and southernmost grid
   boxes will be :math:`\frac{1}{2}` the extent of other grid boxes.
   This is true for both :option:`MERRA2` and :option:`GEOS-FP`.

   If :command:`false`, then all grid boxes will have the same extent
   in latitude. This is true for the :option:`GCAP2` grid.

.. option:: grid:nested_grid_simulation:activate

   If :command:`true`, this indicates that the simulation will use a
   sub-window of the horizontal grid.

   If :command:`false`, this indicates that the simulation will use
   the entire global grid extent.

.. option:: grid:nested_grid_simulation:buffer_zone_NSEW

   Specifies the nested grid latitude offsets (# of grid boxes) in list
   format :code:`[N-offset, S-offset, E-offset, W-offset]`.  These
   offsets are used to define an inner window region in which
   transport is actually done (aka the "transport window").  This
   "transport window" is always smaller than the actual size of the
   nested grid region in order to properly account for the boundary
   conditions.

   - For global simulations, use: :code:`[0, 0, 0, 0]`.
   - For nested-grid simulations, we recommend using: :code:`[3, 3, 3, 3]`.

==================
Timesteps settings
==================

This section of :file:`geoschem_config.yml` is included for all
simulations.

.. code-block:: YAML

   #============================================================================
   # Timesteps settings
   #============================================================================
   timesteps:
     transport_timestep_in_s: 600
     chemistry_timestep_in_s: 1200
     radiation_timestep_in_s: 10800

.. option:: timesteps:transport_timestep_in_s

   Specifies the "heartbeat" timestep of GEOS-Chem Classic.  This is
   the frequency at which transport, cloud convection, PBL mixing, and
   wet deposition will be done.

   - Recommended value for global simulations: :code:`600`
   - Recommended value for nested simluations: :code:`300` or smaller

.. option:: timesteps:chemistry_timestep_in_s

   Specifies the frequency at which chemistry and emissions will be
   done.

   - Recommended value for global simulations :code:`1200`
   - Recommended value for nested simulations :code:`600` or smaller

.. option:: timesteps:radiation_timestep_in_s

   Specifies the frequency at which the `RRTMG
   <http://wiki.geos-chem.org/Coupling_GEOS-Chem_with_RRTMG>`_ radiative
   transfer model will be called (valid for :option:`fullchem`
   simulations only).
