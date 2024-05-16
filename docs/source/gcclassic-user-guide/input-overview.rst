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

   The WashU data portal may be unavailable at times due to
   regularly-scheduled maintenance periods.  Please check the
   `WashU  IT status page <https://itstatus.wustl.edu>`_ for more
   information.

.. option:: Amazon

   GEOS-Chem data on the Amazon cloud, `s3://gcgrid
   <https://registry.opendata.aws/geoschem-input-data/>`_.  You can
   browse the contents of the data via the
   `AWS S3 Explorer <https://s3.amazonaws.com/gcgrid/index.html>`_.

   .. note::

      Downloading from the Amazon Data Portal will NOT incur any
      egress charges.  This is because the data is covered under the
      `AWS Open Data Sponsorship Program
      <https://aws.amazon.com/opendata/?wwps-cards.sort-by=item.additionalFields.sortDate&wwps-cards.sort-order=desc>`_.

.. option:: Rochester

   Portal for the GCAP 2.0 meteorological data files,
   `atmos.earth.rochester.edu
   <http://atmos.earth.rochester.edu/input/gc/ExtData/>`_

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
   | :ref:`Dry run simulation <dry-run>`              | :option:`WashU`     |
   |                                                  | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Run :ref:`bashdatacatalog <bashdatacatalog>`     | :option:`WashU`     |
   | on the :file:`InitialConditions.csv` file [1]_   |                     |
   +--------------------------------------------------+---------------------+
   | Direct data download (:program:`FTP` or          | :option:`WashU`     |
   | :program:`wget`)                                 | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Direct data download                             | :option:`Amazon`    |
   | (:program:`AWS S3 Explorer`) [2]_                |                     |
   +--------------------------------------------------+---------------------+
   | Globus, use endpoint **GEOS-Chem data (WashU)**  | :option:`WashU`     |
   +--------------------------------------------------+---------------------+

.. rubric:: Notes

.. [#] We provide :file:`InitialConditions.csv` files (for each
       GEOS-Chem version since 13.0.0) at our `input-data-catalogs
       <https://github.com/geoschem/input-data-catalogs>`_ Github repository.
.. [#] Direct link: `s3.amazonaws.com/gcgrid/index.html <https://s3.amazonaws.com/gcgrid/index.html>`_

.. _chem-inputs:

====================
Chemistry input data
====================

Chemistry input data includes:

- Quantum yields and cross sections for photolysis using either ``Cloud-J`` or legacy ``FAST-JX``
- Climatology data for :program:`Linoz`
- Boundary conditions for :program:`UCX` stratospheric chemistry routines

.. table::
   :align: center

   +--------------------------------------------------+---------------------+
   | Download method                                  | From portals        |
   +==================================================+=====================+
   | :ref:`Dry run simulation <dry-run>`              | :option:`WashU`     |
   |                                                  | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Run :ref:`bashdatacatalog <bashdatacatalog>`     | :option:`WashU`     |
   | on the                                           |                     |
   | :file:`ChemistryInputs.csv` [3]_                 |                     |
   +--------------------------------------------------+---------------------+
   | Direct data download (:program:`FTP` or          | :option:`WashU`     |
   | :program:`wget`)                                 | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Direct data download                             | :option:`Amazon`    |
   | (:program:`AWS S3 Explorer`) [2]_                |                     |
   +--------------------------------------------------+---------------------+
   | Globus, use endpoint **GEOS-Chem data (WashU)**  | :option:`WashU`     |
   +--------------------------------------------------+---------------------+

.. rubric:: Notes

.. [3]  We provide :file:`ChemistryInputs.csv` files (for each
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

   +--------------------------------------------------+---------------------+
   | Download method                                  | From portals        |
   +==================================================+=====================+
   | :ref:`Dry run simulation <dry-run>`              | :option:`WashU`     |
   |                                                  | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Run :ref:`bashdatacatalog <bashdatacatalog>`     | :option:`WashU`     |
   | on the :file:`EmissionsInputs.csv` file [4]_     |                     |
   +--------------------------------------------------+---------------------+
   | Direct data download (:program:`FTP` or          | :option:`WashU`     |
   | :program:`wget`)                                 | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Direct data download                             | :option:`Amazon`    |
   | (:program:`AWS S3 Explorer`) [2]_                |                     |
   +--------------------------------------------------+---------------------+
   | Globus, use endpoint **GEOS-Chem data (WashU)**  | :option:`WashU`     |
   +--------------------------------------------------+---------------------+

.. rubric:: Notes

.. [4] We provide :file:`EmissionsInputs.csv` files (for each
       GEOS-Chem version since 13.0.0) at our `input-data-catalogs
       <https://github.com/geoschem/input-data-catalogs>`_ Github repository.

======================
Meteorology input data
======================

:ref:`As described previously <req-hard-disk-met>`, GEOS-Chem Classic
be driven by the following meteorology products:

#. `MERRA-2 <http://wiki.geos-chem.org/MERRA-2>`_
#. `GEOS-FP <http://wiki.geos-chem.org/GEOS_FP>`_
#. `GCAP 2.0 <http://atmos.earth.rochester.edu/input/gc/ExtData>`_

.. table::
   :align: center

   +--------------------------------------------------+---------------------+
   | Download method                                  | From portals        |
   +==================================================+=====================+
   | :ref:`Dry run simulation <dry-run>`              | :option:`WashU`     |
   |                                                  | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Run :ref:`bashdatacatalog <bashdatacatalog>`     | :option:`WashU`     |
   | on the :file:`MeteorologyInputs.csv` file [5]_   |                     |
   +--------------------------------------------------+---------------------+
   | Direct data download (:program:`FTP` or          | :option:`WashU`     |
   | :program:`wget`)                                 | :option:`Amazon`    |
   |                                                  | :option:`Rochester` |
   +--------------------------------------------------+---------------------+
   | Direct data download                             | :option:`Amazon`    |
   | (:program:`AWS S3 Explorer`) [2]_                |                     |
   +--------------------------------------------------+---------------------+
   | Globus, use endpoint **GEOS-Chem data (WashU)**  | :option:`WashU`     |
   +--------------------------------------------------+---------------------+

.. rubric:: Notes

.. [4] We provide :file:`EmissionsInputs.csv` files (for each
       GEOS-Chem version since 13.0.0) at our `input-data-catalogs
       <https://github.com/geoschem/input-data-catalogs>`_ Github repository.
