.. _outfiles-hist:

##########################
History diagnostics output
##########################

`GEOS-Chem History diagnostics
<http://wiki.geos-chem.orgGuide_to_GEOS-Chem_History_diagnostics>`_
are comprised of several **diagnostic collections**.  Each
diagnostic collection contains a series of **diagnostic fields** that
may be archived from a GEOS-Chem Classic simulation.

In the :ref:`cfg-hist` configuration file (which is located in your
:ref:`GEOS-Chem Classic run directory <rundir>`, you will find a list
of **default diagnostic collections**.  These are collections that
have been predefined for you.  You may edit the :ref:`cfg-hist`
configuration file to select which diagnostic collections you wish to
archive from your GEOS-Chem Classic simulation.  You may also define
your own custom diagnostic collectinons.

The filenames listed below correspond to the default diagnostic
collections in the :ref:`cfg-hist` file.

.. table:: GEOS-Chem History diagnostics output files
   :align: center

   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | History output file                                      | Diagnostic collection                          | Used in simulations         |
   +==========================================================+================================================+=============================+
   | :file:`GEOSChem.AdvFluxVert.YYYYMMDD_hhhmmz.nc4`         | `AdvFluxVert <http://wiki.geos-chem.org/       | :option:`fullchem`          |
   |                                                          | History_collections_for_advection_and_mixing#  |                             |
   |                                                          | The_AdvFluxVert_collection>`_                  |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.AerosolMass.YYYYMMDD_hhhmmz.nc4`         | `AerosolMass <http://wiki.geos-chem.org/       | :option:`fullchem`          |
   |                                                          | History_collections_for_aerosols#              | :option:`aerosol`           |
   |                                                          | The_AerosolMass_collection>`_                  |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.Aerosols.YYYYMMDD_hhhmmz.nc4`            | `Aerosols <http://wiki.geos-chem.org/          | :option:`fullchem`          |
   |                                                          | History_collections_for_aerosols#              | :option:`aerosol`           |
   |                                                          | The_Aerosols_collection>`_                     |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.BoundaryConditions.YYYYMMDD_hhhmmz.nc4`  | `BoundaryConditions <http://wiki.geos-chem.org | Nested-grid simulations     |
   |                                                          | /History_collections_for_species_concentration |                             |
   |                                                          | s#The_BoundaryConditions_collection>`_         |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.CH4.YYYYMMDD_hhhmmz.nc4`                 | `CH4 <http://wiki.geos-chem.org/               | :option:`CH4`               |
   |                                                          | History_collections_for_methane#               |                             |
   |                                                          | The_CH4_collection>`_                          |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.CloudConvFlux.YYYYMMDD_hhhmmz.nc4`       | `CloudConvFlux <http://wiki.geos-chem.org/     | All simulations             |
   |                                                          | History_collections_for_convection_and_wet_    |                             |
   |                                                          | deposition#The_CloudConvFlux_collection>`_     |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.ConcAboveSfc.YYYYMMDD_hhhmmz.nc4`        | `ConcAboveSfc <http://wiki.geos-chem.org/      | :option:`fullchem`          |
   |                                                          | History_collections_for_dry_deposition#        |                             |
   |                                                          | The_ConcAboveSfc_collection>`_                 |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.ConcAfterChem.YYYYMMDD_hhhmmz.nc4`       | `ConcAfterChem <http://wiki.geos-chem.org/     | :option:`fullchem`          |
   |                                                          | History_collections_for_chemistry_and_photo    |                             |
   |                                                          | lysis#The_ConcAfterChem_collection>`_          |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.DryDep.YYYYMMDD_hhhmmz.nc4`              | `DryDep <http://wiki.geos-chem.org/            | All simulations with dry-   |
   |                                                          | History_collections_for_dry_deposition#        | depositing species          |
   |                                                          | The_DryDep_collection>`_                       |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.JValues.YYYYMMDD_hhhmmz.nc4`             | `JValues <http://wiki.geos-chem.org/           | :option:`fullchem`          |
   |                                                          | History_collections_for_chemistry_and_photo    | :option:`Hg`                |
   |                                                          | lysis#The_JValues_collection>`_                |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.KppDiags.YYYYMMDD_hhhmmz.nc4`            | `KppDiags <http://wiki.geos-chem.org/          | :option:`fullchem`          |
   |                                                          | History_collections_for_chemistry_and_photo    | :option:`Hg`                |
   |                                                          | lysis#The_KppDiags_collection>`_               |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.LevelEdgeDiags.YYYYMMDD_hhhmmz.nc4`      | `LevelEdgeDiags <http://wiki.geos-chem.org/    | All simulations             |
   |                                                          | History_collections_for_met_fields_and_related |                             |
   |                                                          | _quantities#The_LevelEdgeDiags_Collection>`_   |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.MercuryChem.YYYYMMDD_hhhmmz.nc4`         | `MercuryChem <http://wiki.geos-chem.org/       | :option:`Hg`                |
   |                                                          | History_collections_for_mercury_and_POPs#      |                             |
   |                                                          | The_MercuryChem_Collection>`_                  |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.MercuryEmis.YYYYMMDD_hhhmmz.nc4`         | `MercuryEmis <http://wiki.geos-chem.org/       | :option:`Hg`                |
   |                                                          | History_collections_for_mercury_and_POPs#      |                             |
   |                                                          | The_MercuryEmis_Collection>`_                  |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.MercuryOcean.YYYYMMDD_hhhmmz.nc4`        | `MercuryOcean <http://wiki.geos-chem.org/      | :option:`Hg`                |
   |                                                          | History_collections_for_mercury_and_POPs#      |                             |
   |                                                          | The_MercuryOcean_Collection>`_                 |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.POPs.YYYYMMDD_hhhmmz.nc4`                | `POPs <http://wiki.geos-chem.org/              | :option:`POPs`              |
   |                                                          | History_collections_for_mercury_and_POPs#      |                             |
   |                                                          | The_POPs_Collection>`_                         |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.Metrics.YYYYMMDD_hhhmmz.nc4`             | `Metrics <http://wiki.geos-chem.org/           | :option:`fullchem`          |
   |                                                          | History_collections_for_chemistry_and_photo    | :option:`CH4`               |
   |                                                          | lysis#The_Metrics_collection>`_                |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.ProdLoss.YYYYMMDD_hhhmmz.nc4`            | `ProdLoss <http://wiki.geos-chem.org/          | :option:`fullchem`          |
   |                                                          | History_collections_for_chemistry_and_photo    | :option:`aerosol`           |
   |                                                          | lysis#The_ProdLoss_collection>`_               | :option:`tagCO`             |
   |                                                          |                                                | :option:`tagO3`             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.RadioNuclide.YYYYMMDD_hhhmmz.nc4`        | `RadioNuclide <http://wiki.geos-chem.org/      | :option:`TransportTracers`  |
   |                                                          | History_collections_TransportTracers#          |                             |
   |                                                          | #The_RadioNuclide_collection>`_                |                             |
   |                                                          |                                                |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.Restart.YYYYMMDD_hhhmmz.nc4`             | `Restart <http://wiki.geos-chem.org            | All simulations             |
   |                                                          | /History_collections_for_species_concentration |                             |
   |                                                          | s#The_Restart_collection>`_                    |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.RxnRates.YYYYMMDD_hhhmmz.nc4`            | `RxnRates <http://wiki.geos-chem.org/          | :option:`fullchem`          |
   |                                                          | History_collections_for_chemistry_and_photo    | :option:`CH4`               |
   |                                                          | lysis#The_RxnRates_collection>`_               | :option:`Hg`                |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.SpeciesConc.YYYYMMDD_hhhmmz.nc4`         | `SpeciesConc <http://wiki.geos-chem.org        | All simulations             |
   |                                                          | /History_collections_for_species_concentration |                             |
   |                                                          | s#The_SpeciesConc_collection>`_                |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.StateChm.YYYYMMDD_hhhmmz.nc4`            | `StateChm <http://wiki.geos-chem.org/          | All simulations             |
   |                                                          | History_collections_for_chemistry_and_photo    |                             |
   |                                                          | lysis#The_StateChm_collection>`_               |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.StateMet.YYYYMMDD_hhhmmz.nc4`            | `StateMet <http://wiki.geos-chem.org/          | All simulations             |
   |                                                          | History_collections_for_met_fields_and_related |                             |
   |                                                          | _quantities#The_StateMet_Collection>`_         |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.WetLossConv.YYYYMMDD_hhhmmz.nc4`         | `WetLossConv <http://wiki.geos-chem.org/       | All simulations with        |
   |                                                          | History_collections_for_convection_and_wet_    | wet-depositing species      |
   |                                                          | deposition#The_WetLossConv_collection>`_       |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
   | :file:`GEOSChem.WetLossLS.YYYYMMDD_hhhmmz.nc4`           | `WetLossLS <http://wiki.geos-chem.org/         | All simulations with        |
   |                                                          | History_collections_for_convection_and_wet_    | wet-depositing species      |
   |                                                          | deposition#The_WetLossLS_collection>`_         |                             |
   +----------------------------------------------------------+------------------------------------------------+-----------------------------+
