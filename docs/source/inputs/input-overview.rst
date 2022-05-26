.. _input-overview:

################################
Input data for GEOS-Chem Classic
################################

:program:`GEOS-Chem Classic` reads (via `HEMCO
<https://hemco.readthedocs.io>`_) several data files from disk during
a simulation.  These can be grouped into the following categories:

#. :ref:`init-cond` (aka :ref:`restart-files`)
#. :ref:`chem-inputs`
#. :ref:`emis-inputs`
#. :ref:`met`

The data files for GEOS-Chem can be downloaded from the WashU data
portal (`geoschemdata.wustl.edu data portal
<http://geoschemdata.wustl.edu>`_) or from the
`s3://gcgrid <https://registry.opendata.aws/geoschem-input-data/>`_
bucket at AWS. You can download data either with a
:ref:`GEOS-Chem-Classic dry-run simulation <dry-run-simulation>` or
with the
`bashdatacatalog <https://github.com/LiamBindle/bashdatacatalog>`_
utility.

.. _init-cond:

=============================
Initial conditions input data
=============================

Initial conditions include:

- Initial species concentrations (aka :ref:`restart-files`) used to
  start a GEOS-Chem simulation.

You can find a comma-separated list of chemistry inputs (named
:file:`InitialConditions.csv`) at our `input-data-catalogs
<https://github.com/geos-chem/input-data-catalogs>`_
repository. We have prepared :file:`InitialConditions.csv` files for for
each feature version of GEOS-Chem since 13.0.0.

Use the :file:`InitialConditions.csv` file with
:program:`bashdatacatalog` to download, update, or remove initial
condition data. See the `bashdatacatalog wiki
<https://github.com/LiamBindle/bashdatacatalog/wiki>`_  for details.

.. _chem-inputs:

====================
Chemistry input data
====================

Chemistry input data includes:

- Quantum yields and cross sections for :program:`FAST-JX` photolysis
- Climatology data for :program:`Linoz`
- Boundary conditions for :program:`UCX` stratospheric chemistry routines

You can find a comma-separated list of chemistry inputs (named
:file:`ChemistryInputs.csv`) at our `input-data-catalogs
<https://github.com/geos-chem/input-data-catalogs>`_
repository. We have prepared :file:`ChemistryInputs.csv` files for for
each feature version of GEOS-Chem since 13.0.0.

Use the :file:`ChemistryInputs.csv` file with
:program:`bashdatacatalog` to download, update, or remove chemistry
input data.  See the `bashdatacatalog wiki
<https://github.com/LiamBindle/bashdatacatalog/wiki>`_  for details.

.. _emis-inputs:

====================
Emissions input data
====================

Emissions input data includes the following data:

- Emissions inventories
- Input data for HEMCO Extensions
- Input data for GEOS-Chem specialty simulations
- Scale factors
- Mask definitions
- Surface boundary conditions
- Leaf area indices
- Land cover map

You can find a comma-separated list of emissions inputs (named
:file:`EmissionsInputs.csv`) at our `input-data-catalogs
<https://github.com/geos-chem/input-data-catalogs>`_
repository. We have prepared :file:`EmissionsInputs.csv` files for for
each feature version of GEOS-Chem since 13.0.0.

Use the :file:`EmissionsInputs.csv` file with
:program:`bashdatacatalog` to download, update, or remove emissions
input data. See the `bashdatacatalog wiki
<https://github.com/LiamBindle/bashdatacatalog/wiki>`_  for details.

.. _met:

======================
Meteorology input data
======================

:ref:`As described previously <meteorology-fields>`, GEOS-Chem Classic
be driven by the following meteorology products:

#. `MERRA-2 <http://wiki.geos-chem.org/MERRA-2>`_
#. `GEOS-FP <http://wiki.geos-chem.org/GEOS_FP>`_
#. `GCAP 2.0 <http://atmos.earth.rochester.edu/input/gc/ExtData>`_

:program:`MERRA-2` and :program:`GEOS-FP` data can be downloaded from
`geoschemdata.wustl.edu
<http://geoschemdata.wustl.edu>`_ portal, either by direct FTP or by
Globus (use endpoint name :file:`GEOS-Chem data (WashU)`).

:program:`GCAP 2.0` data can be downloaded from
https://atmos.earth.rochester.edu/input/gc/ExtData/.

You may also choose to download the necessary meteorological data for
your :program:`GEOS-Chem Classic` simulations with a
:ref:`dry-run-simulation <dry-run-simulation>`.
