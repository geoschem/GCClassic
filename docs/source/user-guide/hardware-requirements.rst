    :Author: Bob Yantosca

.. contents::

.. _hardware-requirements:

1 Hardware requirments
----------------------

.. _computer-system-requirements:

1.1 Computer system
~~~~~~~~~~~~~~~~~~~

You will need to have access to one (or both) of these types of
computational resources in order to use GEOS-Chem:

.. _a-unix-based-computer-system:

1.1.1 A Unix-based computer system
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You will need a Unix operating system environment in order to run
GEOS-Chem. Any flavor of Unix (e.g. CentOS, Ubuntu, Fedora, etc.)
should work just fine.

If your institution has computational resources (e.g. a shared
computer cluster with many cores, sufficient disk storage and memory),
then you can run GEOS-Chem there. Contact your IT staff for
assistance.

.. _an-account-on-the-amazon-web-services-cloud:

1.1.2 An account on the Amazon Web Services cloud
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your institution lacks computational resources (or if you need
additional computational resources beyond what is available), then you
should consider signing up for access to the Amazon Web Services
cloud. Using the cloud has the following advantages:

- You can run GEOS-Chem without having to invest in local hardware and maintenance personnel.

- You won't have to download any meteorological fields or emissions data. All of the necessary data input for GEOS-Chem will be available on the cloud.

- You can initialize your computational environment with all of the required software (e.g. compilers, libraries, utilities) that you need for GEOS-Chem.

- Your GEOS-Chem runs will be 100% reproducible, because you will initialize your computational environment the same way every time.

- You will avoid GEOS-Chem compilation errors due to library incompatibilities.

- You will be charged for the computational time that you use, and if you download data off the cloud.

You can learn more about how to use GEOS-Chem on the cloud by `visiting this tutorial (**cloud.geos-chem.org**) <http://cloud.geos-chem.org>`_.

.. _memory-requirements:

1.2 Memory requirements
~~~~~~~~~~~~~~~~~~~~~~~

If you plan to run GEOS-Chem on a local computer system, please make
sure that your system has sufficient memory and disk space:

.. _enough-memory-to-run-GEOS-Chem:

1.2.1 Enough memory to run GEOS-Chem
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For the 4\ :sup:`o`\ by 5\ :sup:`o`\ "standard" simulation

- 8-15 GB RAM

For the 2\ :sup:`o`\ by 2.5\ :sup:`o`\ "standard" simulation:

- 30-40 GB RAM

- 20 GB memory (MaxRSS)

- 26 GB virtual memory (MaxVMSize)

Our standard GEOS-Chem Classic 1-month full-chemistry benchmark simulations use a little under 14 GB of system memory. This is mostly due to the fact that the benchmark simulations archive the "kitchen sink"---that is, most diagnostic outputs are requested so that the benchmark simulation can be properly evaluated. But a typical GEOS-Chem Classic production simulation would not require all of these diagnostic outputs, and thus would use much less memory than the benchmark simulations.

.. _extra-memory-for-special-simulations:

1.2.2 Extra memory for special simulations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You may want to consider at least 30 GB RAM if you plan on doing any of the following:

- Running high-resolution (e.g. 1\ :sup:`o`\ x 1\ :sup:`o`\; or higher resolution) global GEOS-Chem simulations

- Running high-resolution (e.g. 0.25\ :sup:`o`\ x 0.3125\ :sup:`o`\ or 0.5\ :sup:`o`\ x 0.625\ :sup:`o`\) nested-grid simulations

- Running 2\ :sup:`o`\ x 2.5\ :sup:`o`\ global GEOS-Chem simulation and saving a lot of
  output fields (the more output you generate the more memory GEOS-Chem will require)

.. _disk space:

1.3 Disk space
~~~~~~~~~~~~~~

This section will help you to determine how much disk space you will
need for a typical GEOS-Chem simulation.

The data format used by GEOS-Chem is COARDS-compliant netCDF.  This is
a standard file format used for Earth Science applications.

.. _emissions-fields:

1.3.1 Emissions fields
^^^^^^^^^^^^^^^^^^^^^^

Please see our `HEMCO data directories <https://wiki.geos-chem.org/HEMCO_data_directories>`_ page to see how much disk space each of the emissions inventory requires.  Emissions inventories will be read into GEOS-Chem by   

.. _emissions-fields:

1.3.2 Meterorology fields
^^^^^^^^^^^^^^^^^^^^^^^^^

The amount of disk space that you will need depends on two things:

1. Which type of met data you will use, and

2. How many years of met data you will download

.. _merra2-disk-space:

1.3.2.1 MERRA-2
:::::::::::::::

.. table::

    +-----------------------------------------------------------------+------------+
    | Resolution                                                      | Data size  |
    +-----------------------------------------------------------------+------------+
    | Global 4\ :sup:`o`\ x 5\ :sup:`o`\                              | ~30 GB/yr  |
    +-----------------------------------------------------------------+------------+
    | Global 2\ :sup:`o`\ x 2.5\ :sup:`o`\                            | ~110 GB/yr |
    +-----------------------------------------------------------------+------------+
    | Nested 0.5\ :sup:`o`\ x 0.625\ :sup:`o`\ Asia (aka AS)          | ~115 GB/yr |
    +-----------------------------------------------------------------+------------+
    | Nested 0.5\ :sup:`o`\ x 0.625\ :sup:`o`\ Europe (aka EU)        | ~58 GB/yr  |
    +-----------------------------------------------------------------+------------+
    | Nested 0.5\ :sup:`o`\ x 0.625\ :sup:`o`\ North America (aka NA) | ~110 GB/yr |
    +-----------------------------------------------------------------+------------+

.. _geosfp-disk-space:

1.3.2.2 GEOS-FP
:::::::::::::::

.. table::

    +-------------------------------------------------------------------+------------+
    | Resolution                                                        | Data Size  |
    +-------------------------------------------------------------------+------------+
    | Global 4\ :sup:`o`\ x 5\ :sup:`o`\                                | ~30 GB/yr  |
    +-------------------------------------------------------------------+------------+
    | Global 2\ :sup:`o`\ x 2.5\ :sup:`o`\                              | ~120 GB/yr |
    +-------------------------------------------------------------------+------------+
    | Nested 0.25\ :sup:`o`\ x 0.3125\ :sup:`o`\ China (aka CH)         | ~175 GB/yr |
    +-------------------------------------------------------------------+------------+
    | Nested 0.25\ :sup:`o`\ x 0.3125\ :sup:`o`\ Europe (aka EU)        | ~58 GB/yr  |
    +-------------------------------------------------------------------+------------+
    | Nested 0.25\ :sup:`o`\ x 0.3125\ :sup:`o`\ North America (aka NA) | ~225 GB/yr |
    +-------------------------------------------------------------------+------------+

.. _gcap2-disk-space:

1.3.2.3 GCAP-2.0
::::::::::::::::

.. _obtaining-emissions-data-and-met-fields:

1.3.3 Obtaining emissions data and met fields
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can use a GEOS-Chem "dry-run" simulation to only download as many
emissions inventories and met field data files as your simulation
needs.  For more information, please see our chapter on Downloading
data with the GEOS-Chem dry-run option. 

.. _data-generated-by-geos-chem:

1.3.4 Data generated by GEOS-Chem
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. _monthly-mean-output:

1.3.4.1 Monthly-mean output
:::::::::::::::::::::::::::

For GEOS-Chem full-chemistry simulations, we can look to the GEOS-Chem
benchmarks as a rough upper limit of how 
much disk space is needed for diagnostic output.  The `GEOS-Chem 13.0.0
vs. 12.9.0 1-month benchmark simulation <https://wiki.geos-chem.org/GEOS-Chem_13.0.0#GEOS-Chem_Classic_13.0.0_vs_12.9.0>`_  generated approximately 837 
MB/month of output.  Of this amount, diagnostic output files
accounted for ~646 MB and restart files accounted for ~191 MB.   

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

1.3.4.2 Reducing output file sizes
::::::::::::::::::::::::::::::::::

You may subset the horizontal and vertical size of the diagnostic
output files in order to save space.  For more information, please see
our section on GEOS-Chem HISTORY diagnostics.

Furthermore, since GEOS-Chem 13.0.0, we have modified the diagnostic
code so that diagnostic arrays are only dimensioned with enough
elements necessary to save out the required output.  For example, if
you only wish to output the SpeciesConc\ :sub:`O3`\ diagnostic, GEOS-Chem will
dimension the relevant array with (NX,NY,NZ,1) elements (1 because we
are only archiving 1 species).  This can drastically reduce the amount
of memory that your simulation will require. 

.. _timeseries-output:

1.3.4.3 Timeseries output
:::::::::::::::::::::::::

Archiving hourly or daily timeseries output would require much more
disk space than the monthly-mean output.  The disk space actually used
will depend on how many quantities are archived and what the archival
frequency is. 
