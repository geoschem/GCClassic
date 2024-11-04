.. |br| raw:: html

   <br />

.. _gcid-special-portals:

#######################################
Additional portals for meteorology data
#######################################

As discussed in the previous chapter, the :ref:`GEOS-Chem Input
Data <gcid>` portal is the main source of input data for
:program:`GEOS-Chem Classic`, :program:`GCHP`, and the :program:`HEMCO
standalone model`.  This portal contains the entire catalog
of emissions inventories, chemical inputs, initial conditions, and
most years of `GEOS-FP <http://wiki.geos-chem.org/GEOS_FP>`_,
`MERRA-2 <http://wiki.geos-chem.org/GEOS_FP>`_, and GEOS-IT meteorology.

We also maintain two additional data portals for special data sets.

.. _gcid-special-portals-nested:

===========================
GEOS-Chem Nested Input Data
===========================

.. attention::

   We are still adding data to the GEOS-Chem Nested Input Data
   portal. As of this writing (November 2024), not all data may
   have been uploaded yet.  We thank you for your patience.

The `GEOS-Chem Nested Input data
<https://registry.opendata.aws/geoschem-nested-input-data/>`_
portal stores GEOS-FP and MERRA-2 meteorology fields that have
been cropped to specific :ref:`nested-grid <nestgrid-guide>` domains.
These data can be used to perform high-resolution inversions with the
`Integrated Methane Inversion (IMI) <https://imi.readthedocs.io>`_
workflow.

.. table:: Available nested-grid meteorology (2018 to present day)
   :align: center

   +---------+--------------------------+-------------------------------+
   | Product | Horizontal resolution    | Nested-grid domains           |
   +=========+==========================+===============================+
   | GEOS-FP | :math:`0.125^{\circ}     | AF (Africa) |br|              |
   |         | {\times}0.15625^{\circ}` | AS (Asia) |br|                |
   |         |                          | EU (Europe) |br|              |
   |         |                          | ME (Middle East) |br|         |
   |         |                          | NA (North America) |br|       |
   |         |                          | OC (Oceania) |br|             |
   |         |                          | RU (Russia) |br|              |
   |         |                          | SA (South America)            |
   +---------+--------------------------+-------------------------------+
   | MERRA-2 | :math:`0.5^{\circ}       | AS (Asia) |br|                |
   |         | {\times}0.625^{\circ}`   | EU (Europe) |br|              |
   |         |                          | NA (North America) |br|       |
   +---------+--------------------------+-------------------------------+

The data can be accessed by:

- AWS S3 Explorer (https://s3.amazonaws.com/gcgrid/index.html)
- Direct HTTP or wget download
- :ref:`Dry-run simulation <dry-run>`

The GEOS-Chem Nested Input Data portal is also part of the `AWS
Open Data Sponsorship Program
<https://aws.amazon.com/opendata/open-data-sponsorship-program/>`_.

.. _gcid-special-portals-gcap2:

===========================================
GCAP 2.0 meteorology hosted at U. Rochester
===========================================

The `atmos.earth.rochester.edu
<http://atmos.earth.rochester.edu/input/gc/ExtData/>`_ portal
(curated by Lee Murray at the University of Rochester) contains the
GCAP 2.0 meteorological data inputs for use with GEOS-Chem
simulations.

The data can be accessed by:

- Direct HTTP or wget download (http://atmos.earth.rochester.edu/input/gc/ExtData/)
- :ref:`Dry run simulation <dry-run>`
