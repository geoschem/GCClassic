.. |br| raw:: html

   <br />

.. _dry-run-download:

#################################
Download data from dry-run output
#################################

Once you have successfully executed a GEOS-Chem dry-run, you
can use the output from the dry-run (contained in the :file:`log.dryrun` file)
to download the data files that GEOS-Chem will need to perform the
corresponding "production" simulation.

.. _dry-run-data-download-portal:

====================
Choose a data portal
====================

You can :ref:`download input data <data>` from any of the portals
listed below.

.. list-table:: GEOS-Chem data portals and access methods
   :header-rows: 1

   * - Portal
     - S3 Explorer
     - AWS CLI
     - HTTP
     - Bashdatacatalog
     - Globus
   * - :ref:`GEOS-Chem Input Data <gcid-data>` |br|
       (The main source of GEOS-Chem input data)
     - Yes
     - Yes
     - Yes
     - Yes
     - Yes
   * - :ref:`gcid-special-portals-nested`
     - Yes
     - Yes
     - Yes
     - No
     - No
   * - :ref:`gcid-special-portals-gcap2`
     - No
     - No
     - Yes
     - No
     - No

Most of the data that you will need is contained in the
:ref:`GEOS-Chem Input Data <gcid-data>` portal.

.. _dry-run-download-activate:

====================================
Activate the GCPy Python environment
====================================

You will need to activate a Python environment before you can start
downloading data.  We recommend using the Python environment for `GCPy
<https://gcpy.readthedocs.io>`_, as it has all of the relevant
packages installed. If you `installed GCPy from PyPI
<https://gcpy.readthedocs.io/en/stable/Getting-Started-with-GCPy.html#install-gcpy-from-pypi>`_,
then no further action is needed.  On the other hand, if you
`installed GCPy from conda-forge
<https://gcpy.readthedocs.io/en/stable/Getting-Started-with-GCPy.html#install-gcpy-from-conda-forge>`_,
you will need to activate the GCPy Python environment with this
command:

.. code-block:: console

   $ conda activate gcpy_env
   (gcpy_env) $

The prefix :literal:`(gcpy_env)` will be added to the command prompt,
which lets you know that the Python environment is active.  (If you
installed GCPy from PyPI, you will not see this prefix.)

.. _dry-run-download-py:

==============================================================
Run the :file:`download_data.py` script on the dryrun log file
==============================================================

Navigate to your GEOS-Chem run directory.  The command that you will
use to download data takes the form:

.. code-block:: console

   (gcpy_env) $ ./download_data.py log.dryrun PORTAL-NAME

where:

- :file:`download_data.py` is the dry-run data download program
  (written in Python).  It is included in each :ref:`GEOS-Chem Classic
  run directory <rundir>` that you create. |br|
  |br|

- :file:`log.dryrun` is the log file from your GEOS-Chem dry-run
  simulation. |br|
  |br|

- :literal:`PORTAL-NAME` specifies the data portal that you wish
  to download from.  Allowed values are:

  .. list-table:: Allowed values for the ``PORTAL-NAME`` argument
		  to ``download_data.py``
     :header-rows: 1
     :align: center

     * - Value
       - Downloads from portal
       - With this command
       - Via this method
     * - geoschem+aws
       - :ref:`GEOS-Chem Input Data <gcid-data>`
       - :command:`aws s3 cp`
       - AWS CLI
     * - geoschem+http
       - :ref:`GEOS-Chem Input Data <gcid-data>`
       - :command:`wget`
       - HTTP
     * - nested+aws
       - :ref:`gcid-special-portals-nested`
       - :command:`aws s3 cp`
       - AWS CLI
     * - nested+http
       - :ref:`gcid-special-portals-nested`
       - :command:`wget`
       - HTTP
     * - rochester
       - :ref:`GCAP 2.0 met data @ Rochester <gcid-special-portals-gcap2>`
       - :command:`wget`
       - HTTP
     * - skip-download
       - :ref:`Skips downloading data <dry-run-download-skip>`
       - N/A
       - N/A

For example, to download data from the :ref:`GEOS-Chem Input Data
<gcid-data>` portal, use this command:

.. code-block:: console

   (gcpy_env) $ ./download_data.py log.dryrun geoschem+http

But if you have `AWS CLI (command-line interface)
<https://aws.amazon.com/cli/>`_ set up on your machine, use
this command instead:

.. code-block:: console

   (gcpy_env) $ ./download_data.py log.dryrun geoschem+aws

This will result in a much faster data transfer than by HTTP.  This is
also the command you will use if you are running GEOS-Chem Classic on
an AWS EC2 cloud instance.

===============================================
(Optional) Examine the log of unique data files
===============================================

The :file:`download_data.py` program will generate a **log of
unique data files** (i.e. with all duplicate listings removed), which
looks similar to this:

.. code-block:: text

   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   !!! LIST OF (UNIQUE) FILES REQUIRED FOR THE SIMULATION
   !!! Start Date       : 20190701 000000
   !!! End Date         : 20190701 010000
   !!! Simulation       : fullchem
   !!! Meteorology      : MERRA2
   !!! Grid Resolution  : 4.0x5.0
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   ./HEMCO_Config.rc
   ./HEMCO_Config.rc.gmao_metfields
   ./HEMCO_Diagn.rc
   ./HISTORY.rc
   ./Restarts/GEOSChem.Restart.20190701_0000z.nc4 --> /home/ubuntu/ExtData/GEOSCHEM_RESTARTS/GC_14.5.0/GEOSChem.Restart.fullchem.20190701_0000z.nc4
   ./Restarts/HEMCO_restart.201907010000.nc
   ./geoschem_config.yml
   /path/to/ExtData/CHEM_INPUTS/CLOUD_J/v2024-09/FJX_j2j.dat
   /path/to/ExtData/CHEM_INPUTS/CLOUD_J/v2024-09/FJX_scat-aer.dat
   /path/to/ExtData/CHEM_INPUTS/CLOUD_J/v2024-09/FJX_scat-cld.dat
   /path/to/ExtData/CHEM_INPUTS/CLOUD_J/v2024-09/FJX_scat-ssa.dat
   /path/to/ExtData/CHEM_INPUTS/CLOUD_J/v2024-09/FJX_spec.dat
   /path/to/ExtData/CHEM_INPUTS/FastJ_201204/fastj.jv_atms_dat.nc
   /path/to/ExtData/CHEM_INPUTS/Linoz_200910/Linoz_March2007.dat
   /path/to/ExtData/CHEM_INPUTS/Olson_Land_Map_201203/Olson_2001_Drydep_Inputs.nc
   /path/to/ExtData/CHEM_INPUTS/UCX_201403/NoonTime/Grid4x5/InitCFC_JN2O_01.dat

    ... etc ...

This name of this "unique" log file will be the same as the log file
with dryrun ouptut, with :file:`.unique` appended. In our above
example, we passed :file:`log.dryrun` to :file:`download_data.py`, so
the "unique" log file will be named :file:`log.dryrun.unique`. This
"unique" log file can be very useful for documentation purposes.

If you wish to only produce the **log of unique data files** without
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

.. _dry-run-download-deactivate:

======================================
Deactivate the GCPy Python environment
======================================

Once you have downloaded all of the data needed for your GEOS-Chem
Classic simulation, you can deactivate the GCPy Python environment.

.. code-block:: console

   (gcpy_env) $ conda deactivate
   $

This will remove the :literal:`(gcpy_env)` prefix from the command prompt.

===============================================
(Optional) Download additional meteorology data
===============================================

You may need to perform a subsequent dry-run simulation to download
additional data that are stored separately from the :ref:`GEOS-Chem
Input Data portal <gcid-data>`:

#. If you plan to run a :ref:`GEOS-Chem Classic nested-grid simulation
   <nestgrid-guide>` with meteorology fields that have been cropped to a
   :ref:`specific nested grid domain <gcc-hgrids-nested>`, then follow
   these steps:

   .. code-block:: console

      $ ./gcclassic --dryrun | tee log.dryrun.nested

      $ conda activate gcpy_env                                      # Skip if using GCPy from PyPI

      (gcpy_env) $ ./download_data.py log.dryrun.nested nested+http  # or nested+aws if you have AWSCLI

      (gcpy_env) $ conda deactivate                                  # Skip if using GCPy from PyPI

   This will download the cropped meteorology fields from our
   :ref:`GEOS-Chem Nested Input Data portal
   <gcid-special-portals-nested>` to your computer system or EC2 instance.

#. If you plan to perform a GEOS-Chem Classic simulation drven by GCAP
   2.0 meteorology, follow these steps:

   .. code-block:: console

      $ ./gcclassic --dryrun | tee log.dryrun.gcap2

      $ conda activate gcpy_env                                      # Skip if using GCPy from PyPI

      (gcpy_env) $ ./download_data.py log.dryrun.gcap2 rochester

      (gcpy_env) $ conda deactivate                                  # Skip if using GCPy from PyPI

   This will download the GCAP 2.0 meteorology data from the
   :ref:`GCAP 2.0 data portal hosted at U. Rochester
   <gcid-special-portals-gcap2>` to your computer system or EC2 instance.
