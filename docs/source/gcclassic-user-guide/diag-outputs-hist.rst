.. _outfiles-hist:

##########################
History diagnostics output
##########################

:ref:`GEOS-Chem History diagnostics <histguide-configfile
are comprised of several **diagnostic collections**.  Each
diagnostic collection contains a series of **diagnostic fields** that
may be archived from a GEOS-Chem Classic simulation.

In the :ref:`HISTORY.rc configuration file <histguide-configfile>` (which
is located in your :ref:`GEOS-Chem Classic run directory <rundir>`,
you will find a list of **default diagnostic collections**.  These are
collections that have been predefined for you.  You may edit the
this configuration file to select which diagnostic collections you
wish to archive from your GEOS-Chem Classic simulation.  You may also
define your own custom diagnostic collectinons.

The filenames listed below correspond to the default diagnostic
collections in the  :ref:`HISTORY.rc configuration file
<histguide-configfile>`.

.. table:: GEOS-Chem History diagnostics output files
   :align: center

   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | History output file                                      | Diagnostic collection               | Used in simulations         |
   +==========================================================+=====================================+=============================+
   | :file:`GEOSChem.AdvFluxVert.YYYYMMDD_hhhmmz.nc4`         | :ref:`histguide-advfluxvert`        | :option:`fullchem`          |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.AerosolMass.YYYYMMDD_hhhmmz.nc4`         | :ref:`histguide-aerosolmass`        | :option:`fullchem`          |
   |                                                          |                                     | :option:`aerosol`           |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.Aerosols.YYYYMMDD_hhhmmz.nc4`            | :ref:`histguide-aerosols`           | :option:`fullchem`          |
   |                                                          |                                     | :option:`aerosol`           |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.BoundaryConditions.YYYYMMDD_hhhmmz.nc4`  | :ref:`histguide-boundaryconditions` | Nested-grid simulations     |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.Carbon.YYYYMMDD_hhhmmz.nc4`              | :ref:`histguide-carbon`             | :option:`carbon`            |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.CH4.YYYYMMDD_hhhmmz.nc4`                 | :ref:`histguide-ch4`                | :option:`CH4`               |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.CloudConvFlux.YYYYMMDD_hhhmmz.nc4`       | :ref:`histguide-cloudconvflux`      | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.CO.YYYYMMDD_hhhmmz.nc4`                  | :ref:`histguide-co`                 | :option:`CH4`               |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.CO2.YYYYMMDD_hhhmmz.nc4`                 | :ref:`histguide-co2`                | :option:`CH4`               |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.ConcAboveSfc.YYYYMMDD_hhhmmz.nc4`        | :ref:`histguide-concabovesfc`       | :option:`fullchem`          |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.ConcAfterChem.YYYYMMDD_hhhmmz.nc4`       | :ref:`histguide-concafterchem`      | :option:`fullchem`          |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.DryDep.YYYYMMDD_hhhmmz.nc4`              | :ref:`histguide-drydep`             | All simulations with dry-   |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.JValues.YYYYMMDD_hhhmmz.nc4`             | :ref:`histguide-jvalues`            | :option:`fullchem`          |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.KppARDiags.YYYYMMDD_hhhmmz.nc4`          | :ref:`histguide-kppardiags`         | :option:`fullchem`          |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.KppDiags.YYYYMMDD_hhhmmz.nc4`            | :ref:`histguide-kppdiags`           | :option:`fullchem`          |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.LevelEdgeDiags.YYYYMMDD_hhhmmz.nc4`      | :ref:`histguide-leveledgediags`     | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.MercuryChem.YYYYMMDD_hhhmmz.nc4`         | :ref:`histguide-mercurychem`        | :option:`Hg`                |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.MercuryEmis.YYYYMMDD_hhhmmz.nc4`         | :ref:`histguide-mercuryemis`        | :option:`Hg`                |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.MercuryOcean.YYYYMMDD_hhhmmz.nc4`        | :ref:`histguide-mercuryocean`       | :option:`Hg`                |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.Metrics.YYYYMMDD_hhhmmz.nc4`             | :ref:`histguide-metrics`            | :option:`fullchem`          |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.ProdLoss.YYYYMMDD_hhhmmz.nc4`            | :ref:`histguide-prodloss`           | :option:`fullchem`          |
   |                                                          |                                     | :option:`aerosol`           |
   |                                                          |                                     | :option:`tagCO`             |
   |                                                          |                                     | :option:`tagO3`             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.RadioNuclide.YYYYMMDD_hhhmmz.nc4`        | :ref:`histguide-radionuclide`       | :option:`TransportTracers`  |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.Restart.YYYYMMDD_hhhmmz.nc4`             | :ref:`histguide-restart`            | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.RRTMG.YYYYMMDD_hhhmmz.nc4`               | :ref:`histguide-rrtmg`              | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.RxnConst.YYYYMMDD_hhhmmz.nc4`            | :ref:`histguide-rxnconst`           | :option:`fullchem`          |
   |                                                          |                                     | :option:`CH4`               |
   |                                                          |                                     | :option:`Hg`                |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.RxnRates.YYYYMMDD_hhhmmz.nc4`            | :ref:`histguide-rxnrates`           | :option:`fullchem`          |
   |                                                          |                                     | :option:`CH4`               |
   |                                                          |                                     | :option:`Hg`                |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.SatDiagn.YYYYMMDD_hhhmmz.nc4`            | :ref:`histguide-satdiagn`           | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.SatDiagnEdge.YYYYMMDD_hhhmmz.nc4`        | :ref:`histguide-satdiagnedge`       | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.SpeciesConc.YYYYMMDD_hhhmmz.nc4`         | :ref:`histguide-speciesconc`        | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.StateChm.YYYYMMDD_hhhmmz.nc4`            | :ref:`histguide-statechm`           | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.StateMet.YYYYMMDD_hhhmmz.nc4`            | :ref:`histguide-statemet`           | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.StratBM.YYYYMMDD_hhhmmz.nc4`             | :ref:`histguide-stratbm`            | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.Tomas.YYYYMMDD_hhhmmz.nc4`               | :ref:`histguide-tomas`              | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.UVFlux.YYYYMMDD_hhhmmz.nc4`              | :ref:`histguide-uvflux`             | All simulations             |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.WetLossConv.YYYYMMDD_hhhmmz.nc4`         | :ref:`histguide-wetlossconv`        | All simulations with        |
   |                                                          |                                     | wet-deposited species       |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
   | :file:`GEOSChem.WetLossLS.YYYYMMDD_hhhmmz.nc4`           | :ref:`histguide-wetlossls`          | All simulations with        |
   |                                                          |                                     | wet-deposited species       |
   +----------------------------------------------------------+-------------------------------------+-----------------------------+
