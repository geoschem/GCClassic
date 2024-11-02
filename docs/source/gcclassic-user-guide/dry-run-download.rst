.. |br| raw:: html

   <br />

.. _dry-run-download:

#################################
Download data from dry-run output
#################################

Once you have successfully executed a GEOS-Chem dry-run, you
can use the output from the dry-run (contained in the :file:`log.dryrun` file)
to download the data files that GEOS-Chem will need to perform the
corresponding "production" simulation. You may download from different
:ref:`data repositories <dry-run-data-download-repo>`.

.. important::

   Before you use the :file:`download_data.py` script, make sure to
   initialize a Mamba or Conda environment with the relevant command
   shown below:

   .. code-block:: console

      $ mamba activate ENV-NAME   # If using Mamba

      $ conda activate ENV-NAME   # If using Conda

   Here :literal:`ENV-NAME` is the name of your environment.

   Also make sure that you have installed the PyYAML module to your
   conda environment.  PyYAML will allow the :file:`download_data.py`
   script to read certain configurable settings from a YAML file in
   your run directory.

   The Python environment for GCPy has all of the proper packages
   that you need to download data from a dry-run simulation.  For
   more information, please see `gcpy.readthedocs.io
   <gcpy.readthedocs.io.>`_.

.. _dry-run-data-download-repo:

========================
Choose a data repository
========================

You can :ref:`download input data <data>` from one of the following
repositories:

.. _dry-run-download-repo-gc:

GEOS-Chem Input Data
--------------------

The :ref:`GEOS-Chem Input Data <gcid>` repository is the main source
of input data (emissions, meteorology, chemistry inputs, restart
files) for GEOS-Chem. We recommend that you download data from this
repository unless otherwise necessary.

This repository is curated by the GEOS-Chem Support Team at Washington
University in St. Louis, and is hosted on the AWS S3 bucket
:file:`s3://geos-chem`.

.. tip::

   We have set up a `Globus <https://www.globus.org/data-transfer>`_
   endpoint named **GEOS-Chem data (WashU)**, which links to the
   GEOS-Chem Input Data repository.  If you need to download many
   years of data, you may find that using Globus is much faster than
   downloading data with a dry-run simulation.  Ask your IT support
   staff if Globus is supported at your institution.

Supported download methods:

- AWS CLI (command-line interface)
- HTTP download (e.g via :program:`wget`)
- Globus

Repository browser:

- AWS S3 Explorer (https://geos-chem.s3.amazonaws.com/index.html)

.. _dry-run-download-repo-nest:

GEOS-Chem Nested Input Data
---------------------------

The :ref:`gcid-special-repos-nested` repository contains cropped
GEOS-FP and MERRA-2 meteorological inputs for several nested domains.
These data can be used to perform high-resolution inversions using the
`Integrated Methane Inversion (IMI) <https://imi.readthedocs.io>`_
workflow.

This repository is curated by the GEOS-Chem Support Team at
Harvard University and is hosted at the AWS S3 bucket
:file:`s3://gcgrid`.

Supported download methods:

- AWS CLI (command-line interface)
- HTTP download (e.g via :program:`wget`)

Repository browser:

- AWS S3 Explorer (https://gcgrid.s3.amazonaws.com/index.html)

.. _dry-run-download-repo-ur:

GCAP 2.0 meteorology at University of Rochester
-----------------------------------------------

The `atmos.earth.rochester.edu
<http://atmos.earth.rochester.edu/input/gc/ExtData/>`_ repository
contains the GCAP 2.0 meteorology inputs for GEOS-Chem.  GCAP 2.0
meteorology is useful if you wish to perform simulations stretching
back into the preindustrial period, or running into the future.

This repository is curated by Lee Murray (GitHub:
:literal:`@ltmurray`) at the University of Rochester.

Supported download methods:

- HTTP download (e.g via :program:`wget`)

Repository browser:

- HTTP site (http://atmos.earth.rochester.edu/input/gc/ExtData)

.. _dry-run-download-data:

==============================================================
Run the :file:`download_data.py` script on the dryrun log file
==============================================================

Navigate to your GEOS-Chem run directory where you executed the dry-run
and type.

.. code-block:: console

   $ ./download_data.py log.dryrun REPOSITORY-NAME

where:

- :file:`download_data.py` is the dry-run data download program
  (written in Python).  It is included in each :ref:`GEOS-Chem Classic
  run directory <rundir>` that you create. |br|
  |br|

- :file:`log.dryrun` is the log file from your GEOS-Chem dry-run
  simulation. |br|
  |br|

- :literal:`REPOSITORY-NAME` specifies the data repository that you wish
  to download from.  Allowed values are:

  .. list-table:: Allowed values for the ``REPOSITORY-NAME`` argument
		  to ``download_data.py``
     :header-rows: 1

     * - Value
       - Downloads from repository
       - Command used
       - Method
     * - geoschem-s3
       - :ref:`dry-run-download-repo-gc`
       - :command:`aws s3 cp`
       - AWS CLI
     * - geoschem-wget
       - :ref:`dry-run-download-repo-gc`
       - :command:`wget`
       - HTTP
     * - nested-s3
       - :ref:`dry-run-download-repo-nest`
       - :command:`aws s3 cp`
       - AWS CLI
     * - nested-wget
       - :ref:`dry-run-download-repo-nest`
       - :command:`wget`
       - HTTP
     * - rochester
       - :ref:`GCAP 2.0 met data @ Rochester <dry-run-download-repo-ur>`
       - :command:`wget`
       - HTTP

For example, to download data from the :ref:`dry-run-download-repo-gc`
repository using the AWS CLI download (which is faster than HTTP
download), use this command:

.. code-block:: console

   $ ./download_data.py log.dryrun geoschem-s3

.. note::

   You must have the `AWS CLI (command-line interface)
   <https://aws.amazon.com/cli/>`_ software installed on your system
   before in order to use the :literal:`geoschem-s3` or
   :literal:`nested-s3` options in the table listed above.

The :file:`download_data.py` program will generate a **log of
unique data files** (i.e. with all duplicate listings removed), which
looks similar to this:

.. code-block:: text

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!! LIST OF (UNIQUE) FILES REQUIRED FOR THE SIMULATION
    !!! Start Date       : 20160701 000000
    !!! End Date         : 20160701 010000
    !!! Simulation       : standard
    !!! Meteorology      : GEOSFP
    !!! Grid Resolution  : 4.0x5.0
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ./GEOSChem.Restart.20160701_0000z.nc4 --> /n/holylfs/EXTERNAL_REPOS/GEOS-CHEM/gcgrid/data/ExtData/GEOSCHEM_RESTARTS/v2018-11/initial_GEOSChem_rst.4x5_standard.nc
    ./HEMCO_Config.rc
    ./HEMCO_Diagn.rc
    ./HEMCO_restart.201607010000.nc
    ./HISTORY.rc
    ./input.geos
    /n/holylfs/EXTERNAL_REPOS/GEOS-CHEM/gcgrid/data/ExtData/CHEM_INPUTS/FAST_JX/v2019-10/FJX_j2j.dat
    /n/holylfs/EXTERNAL_REPOS/GEOS-CHEM/gcgrid/data/ExtData/CHEM_INPUTS/FAST_JX/v2019-10/FJX_spec.dat
    /n/holylfs/EXTERNAL_REPOS/GEOS-CHEM/gcgrid/data/ExtData/CHEM_INPUTS/FAST_JX/v2019-10/dust.dat
    /n/holylfs/EXTERNAL_REPOS/GEOS-CHEM/gcgrid/data/ExtData/CHEM_INPUTS/FAST_JX/v2019-10/h2so4.dat
    /n/holylfs/EXTERNAL_REPOS/GEOS-CHEM/gcgrid/data/ExtData/CHEM_INPUTS/FAST_JX/v2019-10/jv_spec_mie.dat
    ... etc ...

This name of this "unique" log file will be the same as the log file
with dryrun ouptut, with :file:`.unique` appended. In our above
example, we passed :file:`log.dryrun` to :file:`download_data.py`, so
the "unique" log file will be named :file:`log.dryrun.unique`. This
"unique" log file can be very useful for documentation purposes.

.. _dry-run-download-skip:

=============================================
Skip download, but create log of unique files
=============================================

If you wish to only produce the \*log of unique data files without
downloading any data, then type the following command from within your
GEOS-Chem run directory:

.. code-block:: console

   $ ./download_data.py log.dryrun skip-download

or for short:

.. code-block:: console

  $ ./download_data.py log.dryrun skip

This can be useful if you already have the necessary data downloaded to
your system but wish to create the log of unique files for documentation
purposes (such as for benchmark simulations, etc.)
