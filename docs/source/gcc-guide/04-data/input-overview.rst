.. _input-overview:

################################
Input data for GEOS-Chem Classic
################################

GEOS-Chem Classic reads (via `HEMCO <https://hemco.readthedocs.io>`_)
several data files from disk during a simulation.  These can be
grouped into the following categories:

#. :ref:`init-cond` (aka :ref:`restart-files`)
#. :ref:`chem-inputs`
#. :ref:`emis-inputs`
#. :ref:`met`

============
Data portals
============

Input data files for GEOS-Chem can be downloaded from one of the
following portals:

.. option:: WashU

   The primary data portal for GEOS-Chem,
   `geoschemdata.wustl.edu <http://geoschemdata.wustl.edu>`_

.. option:: Amazon

   GEOS-Chem data on the Amazon cloud, `s3://gcgrid
   <https://registry.opendata.aws/geoschem-input-data/>`_ 

.. option:: Rochester

   Portal for the GCAP 2.0 meteorological data files, 
   `atmos.earth.rochester.edu
   <https://atmos.earth.rochester.edu/input/gc/ExtData/>`_

.. _init-cond:

=============================
Initial conditions input data
=============================

Initial conditions include:

- Initial species concentrations (aka :ref:`restart-files`) used to
  start a GEOS-Chem simulation.

.. table::
   :align: center

   +--------------------------------------------------+---------------------+
   | Download method                                  | From portals        |
   +==================================================+=====================+
   | :ref:`Dry run simulation <dry-run-simulation>`   | :option:`WashU`     |
   |                                                  | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Run :ref:`bashdatacatalog <bashdatacatalog>`     | :option:`WashU`     |
   | on the :file:`InitialConditions.csv` file        |                     |
   | :math:`^1`                                       |                     |
   +--------------------------------------------------+---------------------+
   | Direct data download (:program:`FTP` or          | :option:`WashU`     |
   | :program:`wget`)                                 | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Globus, use endpoint **GEOS-Chem data (WashU)**  | :option:`WashU`     |
   +--------------------------------------------------+---------------------+

:math:`^1` We provide :file:`InitialConditions.csv` files (for each
GEOS-Chem version since 13.0.0) at our `input-data-catalogs
<https://github.com/geoschem/input-data-catalogs>`_ Github repository.

.. _chem-inputs:

====================
Chemistry input data
====================

Chemistry input data includes:

- Quantum yields and cross sections for :program:`FAST-JX` photolysis
- Climatology data for :program:`Linoz`
- Boundary conditions for :program:`UCX` stratospheric chemistry routines

.. table::
   :align: center

   +--------------------------------------------------+---------------------+
   | Download method                                  | From portals        |
   +==================================================+=====================+
   | :ref:`Dry run simulation <dry-run-simulation>`   | :option:`WashU`     |
   |                                                  | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Run :ref:`bashdatacatalog <bashdatacatalog>`     | :option:`WashU`     |
   | on the                                           |                     |
   | :file:`ChemistryInputs.csv` file :math:`^2`      |                     |
   +--------------------------------------------------+---------------------+
   | Direct data download (:program:`FTP` or          | :option:`WashU`     |
   | :program:`wget`)                                 | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Globus, use endpoint **GEOS-Chem data (WashU)**  | :option:`WashU`     |
   +--------------------------------------------------+---------------------+

:math:`^2` We provide :file:`ChemistryInputs.csv` files (for each
GEOS-Chem version since 13.0.0) at our `input-data-catalogs
<https://github.com/geoschem/input-data-catalogs>`_ Github repository.

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

.. table::
   :align: center

   +-------------------------------------------------+---------------------+
   | Download method                                 | From portals        |
   +=================================================+=====================+
   | :ref:`Dry run simulation <dry-run-simulation>`  | :option:`WashU`     |
   |                                                 | :option:`Amazon`    |
   |                                                 | :option:`Rochester` |
   +-------------------------------------------------+---------------------+
   | Run :ref:`bashdatacatalog <bashdatacatalog>`    | :option:`WashU`     |
   | on the                                          |                     |
   | :file:`EmissionsInputs.csv` file :math:`^3`     |                     |
   +-------------------------------------------------+---------------------+
   | Direct data download (:program:`FTP` or         | :option:`WashU`     |
   | :program:`wget`)                                | :option:`Amazon`    |
   |                                                 | :option:`Rochester` |
   +-------------------------------------------------+---------------------+
   | Globus, use endpoint **GEOS-Chem data (WashU)** | :option:`WashU`     |
   +-------------------------------------------------+---------------------+

:math:`^3` We provide :file:`EmissionsInputs.csv` files (for each
GEOS-Chem version since 13.0.0) at our `input-data-catalogs
<https://github.com/geoschem/input-data-catalogs>`_ Github repository.

.. _met:

======================
Meteorology input data
======================

:ref:`As described previously <meteorology-fields>`, GEOS-Chem Classic
be driven by the following meteorology products:

#. `MERRA-2 <http://wiki.geos-chem.org/MERRA-2>`_
#. `GEOS-FP <http://wiki.geos-chem.org/GEOS_FP>`_
#. `GCAP 2.0 <http://atmos.earth.rochester.edu/input/gc/ExtData>`_

.. table::
   :align: center

   +--------------------------------------------------+---------------------+
   | Download method                                  | From portals        |
   +==================================================+=====================+
   | :ref:`Dry run simulation <dry-run-simulation>`   | :option:`WashU`     |
   |                                                  | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Direct data download (:program:`FTP` or          | :option:`WashU`     |
   | :program:`wget`)                                 | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Globus, use endpoint **GEOS-Chem data (WashU)**  | :option:`WashU`     |
   +--------------------------------------------------+---------------------+

