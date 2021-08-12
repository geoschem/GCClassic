Hardware requirements
=====================

.. _computer-system-requirements:

Computer system
-------------------

You will need to have access to one (or both) of these types of
computational resources in order to use GEOS-Chem Classic:

.. _a-unix-based-computer-system:

A Unix-based computer system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GEOS-Chem can only be used within a Unix-like operating system
environment.  Any flavor of Unix (e.g. RHEL/Fedora/Centos, Ubuntu,
Debian, Arch) or MacOS (which is based on BSD Unix) should suffice.

If your institution has computational resources (e.g. a shared
computer cluster with many cores, sufficient disk storage and memory),
then you can run GEOS-Chem there. Contact your IT staff for
assistance.

.. _an-account-on-the-amazon-web-services-cloud:

An account on the Amazon Web Services cloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your institution lacks computational resources (or if you need
additional computational resources), then you should consider signing
up for access to the Amazon Web Services cloud. Using the cloud has
the following advantages:

- You can run GEOS-Chem without having to invest in local hardware and maintenance personnel.
- You won't have to download any meteorological fields or emissions data. All of the necessary data input for GEOS-Chem will be available on the cloud.
- You can initialize your computational environment with all of the required software (e.g. compilers, libraries, utilities) that you need for GEOS-Chem.
- Your GEOS-Chem runs will be 100% reproducible, because you will initialize your computational environment the same way every time.
- You will avoid GEOS-Chem compilation errors due to library incompatibilities.
- You will be charged for the computational time that you use, and if you download data off the cloud.

You can learn more about how to use GEOS-Chem on the cloud by `visiting this tutorial (cloud.geos-chem.org) <http://cloud.geos-chem.org>`_.

.. _memory-requirements:

Memory requirements
-------------------

If you plan to run GEOS-Chem on a local computer system, please make
sure that your system has sufficient memory and disk space:

.. _enough-memory-to-run-GEOS-Chem:

Enough memory to run GEOS-Chem
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For the 4\ :sup:`o`\ by 5\ :sup:`o`\ "standard" simulation

- 8-15 GB RAM

For the 2\ :sup:`o`\ by 2.5\ :sup:`o`\ "standard" simulation:

- 30-40 GB RAM
- 20 GB memory (MaxRSS)
- 26 GB virtual memory (MaxVMSize)

Our standard GEOS-Chem Classic 1-month full-chemistry benchmark simulations use a little under 14 GB of system memory. This is mostly due to the fact that the benchmark simulations archive the "kitchen sink"---that is, most diagnostic outputs are requested so that the benchmark simulation can be properly evaluated. But a typical GEOS-Chem Classic production simulation would not require all of these diagnostic outputs, and thus would use much less memory than the benchmark simulations.

.. _extra-memory-for-special-simulations:

Extra memory for special simulations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You may want to consider at least 30 GB RAM if you plan on doing any of the following:

- Running high-resolution (e.g. 1\ :sup:`o`\ x 1\ :sup:`o`\; or higher resolution) global GEOS-Chem simulations

- Running high-resolution (e.g. 0.25\ :sup:`o`\ x 0.3125\ :sup:`o`\ or 0.5\ :sup:`o`\ x 0.625\ :sup:`o`\) nested-grid simulations

- Running 2\ :sup:`o`\ x 2.5\ :sup:`o`\ global GEOS-Chem simulation and saving a lot of
  output fields (the more output you generate the more memory GEOS-Chem will require)

.. _disk space:

Disk space
----------

.. _input-data-for-geos-chem:


Input data for GEOS-Chem
~~~~~~~~~~~~~~~~~~~~~~~~

The following sections will help you assess how much disk space you
will need on your server to store GEOS-Chem input data.

The data format used by GEOS-Chem is COARDS-compliant netCDF.  This is
a standard file format used for Earth Science applications.

.. _emissions-fields:

Emissions fields
^^^^^^^^^^^^^^^^

Please see our `HEMCO data directories <https://wiki.geos-chem.org/HEMCO_data_directories>`_ page to see how much disk space each of the emissions inventory requires.  Emissions inventories will be read into GEOS-Chem by

.. _emissions-fields:

Meterorology fields
^^^^^^^^^^^^^^^^^^^

The amount of disk space that you will need depends on two things:

1. Which type of met data you will use, and

2. How many years of met data you will download

.. _merra2-disk-space:

MERRA-2
^^^^^^^
.. table::

+-----------------------------------------------------------+----------+
|**Resolution**                                             |**Size**  |
+-----------------------------------------------------------+----------+
|Global 4\ :sup:`o`\ x 5\ :sup:`o`\                         |~30 GB/yr |
+-----------------------------------------------------------+----------+
|Global 2\ :sup:`o`\ x 2.5\ :sup:`o`\                       |~110 GB/yr|
+-----------------------------------------------------------+----------+
|Asia (AS) Nested 0.5\ :sup:`o`\ x 0.625\ :sup:`o`\         |~115 GB/yr|
+-----------------------------------------------------------+----------+
|Europe (EU) Nested 0.5\ :sup:`o`\ x 0.625\ :sup:`o`\       |~58 GB/yr |
+-----------------------------------------------------------+----------+
|North America (NA) Nested 0.5\ :sup:`o`\ x 0.625\ :sup:`o`\|~110 GB/yr|
+-----------------------------------------------------------+----------+

.. _geosfp-disk-space:

GEOS-FP
^^^^^^^

.. table::

+-------------------------------------------------------------+----------+
|**Resolution**                                               |**Size**  |
+-------------------------------------------------------------+----------+
|Global 4\ :sup:`o`\ x 5\ :sup:`o`\                           |~30 GB/yr |
+-------------------------------------------------------------+----------+
|Global 2\ :sup:`o`\ x 2.5\ :sup:`o`\                         |~120 GB/yr|
+-------------------------------------------------------------+----------+
|China (CH) Nested 0.25\ :sup:`o`\ x 0.3125\ :sup:`o`\        |~175 GB/yr|
+-------------------------------------------------------------+----------+
|Europe (EU) Nested 0.25\ :sup:`o`\ x 0.3125\ :sup:`o`\       |~58 GB/yr |
+-------------------------------------------------------------+----------+
|North America (NA) Nested 0.25\ :sup:`o`\ x 0.3125\ :sup:`o`\|~225 GB/yr|
+-------------------------------------------------------------+----------+

.. _gcap2-disk-space:

GCAP-2.0
^^^^^^^^

TODO

.. _obtaining-emissions-data-and-met-fields:

Obtaining emissions data and met fields
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You may use a :ref:`GEOS-Chem "dry-run" simulation <download-data-with-a-dry-run-simulation>`
to only download as many emissions inventories and met field data files as your simulation
needs.

If you need to download large amounts of data, consider using
`Globus <https://www.globus.org/data-transfer>`_.  We have created a
Globus Endpoint named **GEOS-Chem data (WashU)** on the WashU mirror
site from which you may access the entire GEOS-Chem data archive.

.. _data-generated-by-geos-chem:

Data generated by GEOS-Chem
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _monthly-mean-output:

Monthly-mean output
^^^^^^^^^^^^^^^^^^^

For GEOS-Chem full-chemistry simulations, we can look to the GEOS-Chem
benchmarks as a rough upper limit of how
much disk space is needed for diagnostic output.  The `GEOS-Chem 13.0.0
vs. 12.9.0 1-month benchmark simulation
<https://wiki.geos-chem.org/GEOS-Chem_13.0.0#GEOS-Chem_Classic_13.0.0_vs_12.9.0>`_
generated approximately 837 MB/month of output.  Of this amount,
diagnostic output files accounted for ~646 MB and restart files
accounted for ~191 MB.

We say that this is an upper limit, because benchmark simulations
archive the "kitchen sink"&mdash;all species concentrations, various
aerosol diagnostics, convective fluxes, dry dep fluxes and velocities,
J-values, various chemical and meteorological quantities, transport
fluxes,  wet deposition diagnostics, and emissions diagnostics.  Most
GEOS-Chem users would probably not need to archive this much output.

The GEOS-Chem specialty simulations--simulations for species with
first-order loss by prescribed oxidant fields (i.e. Hg, CH4, CO2,
CO)--will produce much less output than the benchmark simulations.
This is because these simulations typically only have a few species.

.. _reducing-output-file-sizes:

Reducing output file sizes
^^^^^^^^^^^^^^^^^^^^^^^^^^

You may subset the horizontal and vertical size of the diagnostic
output files in order to save space.  For more information, please see
our section on GEOS-Chem HISTORY diagnostics.

Furthermore, since GEOS-Chem 13.0.0, we have modified the diagnostic
code so that diagnostic arrays are only dimensioned with enough
elements necessary to save out the required output.  For example, if
you only wish to output the SpeciesConc_O3 diagnostic, GEOS-Chem will
dimension the relevant array with (NX,NY,NZ,1) elements (1 because we
are only archiving 1 species).  This can drastically reduce the amount
of memory that your simulation will require.

.. _timeseries-output:

Timeseries output
^^^^^^^^^^^^^^^^^^^^^^^

Archiving hourly or daily timeseries output would require much more
disk space than the monthly-mean output.  The disk space actually used
will depend on how many quantities are archived and what the archival
frequency is.
