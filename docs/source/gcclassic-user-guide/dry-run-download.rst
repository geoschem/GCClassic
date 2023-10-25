.. _dry-run-download:

#################################
Download data from dry-run output
#################################

Once you have successfully executed a GEOS-Chem dry-run, you
can use the output from the dry-run (contained in the :file:`log.dryrun` file)
to download the data files that GEOS-Chem will need to perform the
corresponding "production" simulation. You may download from one of
several locations, which are described in the following sections.

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

.. _dry-run-data-download-portal:

====================
Choose a data portal
====================

You can download input data data from one of the following locations:

.. _dry-run-download-washu:

The geoschemdata.wustl.edu site (aka WashU)
---------------------------------------------

If you are using GEOS-Chem on your institutional computer cluster, we
recommend that you **download data from the WashU (Washington
University in St. Louis) site** (`http://geoschemdata.wustl.edu
<http://geoschemdata.wustl.edu>`_).  This site, which is
maintained by Randall Martin's group at WashU, is the main data site
for GEOS-Chem.

.. tip::

   We have also set up a `Globus
   <https://www.globus.org/data-transfer>`_ endpoint named **GEOS-Chem
   data (WashU)** on the WashU site.  If you need to
   download many years of data, it may be faster to use	 Globus
   (particularly if your home institution supports it).

.. _dry-run-download-aws:

The s3://gcgrid bucket (aka Amazon)
-----------------------------------

If you are running GEOS-Chem Classic on the Amazon Web Services cloud,
you can quickly **download the necessary data for your GEOS-Chem
simulation from the :file:`s3://gcgrid` bucket** to the Elastic Block
Storage (EBS) volume attached to your cloud instance.

Navigate to your GEOS-Chem Classic run directory and type:

.. code-block:: console

    $ ./download data.py log.dryrun amazon

This will start the data download process using the ``aws s3 cp``
commands, which should execute much more quickly than if you were to
download the data from another location. It will also produce a
**log of unique data files**.

.. important::

   Copying data from :file:`s3://gcgrid` to the EBS volume of an
   Amazon EC2 cloud instance is always free. But if you download data
   from :file:`s3://gcgrid` to your own computer system, you will
   incur an egress fee. **PROCEED WITH CAUTION!**

.. _dry-run-download-rochester:

The atmos.earth.rochester.edu site (aka Rochester)
----------------------------------------------------

The U. Rochester site (which is maintained by Lee Murray's research
there) contains the GCAP 2.0 met field data.  This met field data is
useful if you wish to perform simulations stretching back into the
preindustrial period, or running into the future.

To download data from the Rochester site, type:

.. code-block:: console

    $ ./download data.py log.dryrun rochester

.. _dry-run-download-data:

======================================================
Run the download_data.py script on the dryrun log file
======================================================

Navigate to your GEOS-Chem run directory where you executed the dry-run
and type:

.. code-block:: console

   $ ./download_data.py log.dryrun washu

The :file:`download_data.py` Python program is included in the
:ref:`GEOS-Chem run directory <rundir>` that you created. This Python
program creates and executes a temporary bash script containing the
appropriate :file:`wget` commands to download the data files. (We have
found that this is the fastest method.)

The :file:`download_data.py` program will also generate a **log of
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

   $ ./download_data.py log.dryrun --skip-download

or for short:

.. code-block:: console

  $ ./download_data.py log.dryrun --skip

This can be useful if you already have the necessary data downloaded to
your system but wish to create the log of unique files for documentation
purposes (such as for benchmark simulations, etc.)
