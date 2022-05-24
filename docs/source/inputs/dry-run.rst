.. _download-data-with-a-dry-run-simulation:

#######################################
Download data with a dry-run simulation
#######################################

.. _what-is-a-dry-run:

=============================
What is a dry-run simulation?
=============================

A "dry-run" is a is a :program:`GEOS-Chem Classic` simulation that
steps through time, but does not perform computations or read data
files from disk. Instead, a dry-run simulation prints a list of all
data files that a regular GEOS-Chem simulation would have read. The
dry-run output also denotes whether each data file was found on disk,
or if it is missing. This output can be fed to a script which will
download the missing data files to your computer system.

A dry-run simulation is also a good way to check if you have properly
:ref:`configured your computational environment
<configure-your-computational-environment>`.  This is especially
important if you are porrting GEOS-Chem to run on a new computer
system, or on the Amazon Web Services cloud environment. 

You may generate dry-run output for any of the GEOS-Chem Classic
simulation types (fullchem, CH4, TransportTracers, etc.)

.. _how-to-perform-a-geos-chem-classic-dry-run:

==========================================
How to perform a GEOS-Chem Classic dry-run
==========================================

Follow the steps below to perform a GEOS-Chem dry-run.

.. tip::

   Also be sure to watch our video tutorial `Using the updated
   dry-run capability in GEOS-Chem 13.2.1 and later versions
   <https://www.youtube.com/watch?v=ZLSXrjHqJAs&t=35s>`_
   at our `GEOS-Chem Youtube Channel
   <https://youtube.com/c/geoschem/>`_, which will guide you
   through these steps.
   
1. Create a run directory (if not done yet)
-------------------------------------------

:ref:`Create a run directory <create-rundir>` for the type of
:program:`GEOS-Chem Classic` simulation that you wish to perform.
For this example we'll assume that our run directory is named
:file:`gc_merra2_fullchem`.

2. Configure and build GEOS-Chem (if not done yet)
--------------------------------------------------

Navigate to the run directory and :ref:`compile GEOS-Chem
<compiling-geos-chem>`.  For an out-of-the-box build, type these
commands:

.. code-block:: console

   $ cd gc_merra2_fullchem
   $ cd build
   $ cmake ../CodeDir -DRUNDIR=..
   $ make -j
   $ make -j install
   $ cd ..

This will :ref:`configure and build <configure-your-build>` GEOS-Chem
using all default options. For more information on how to apply other
options (such as debugging, etc.), please see our
:ref:`compiling-geos-chem` chapter.

3. Edit run-directory configuration files
------------------------------------------

Next, edit the configuration files to specify the simulation options.
Of these the most important settings are:

.. option:: geoschem_config.yml

   #. Set the start and end dates of the simulation. This setting will
      determine how much data needs to be downloaded from one of the
      GEOS-Chem data mirrors to your local disk space.
   #. Also doublecheck that the path to your data directory (ExtData)
      is correct.
   #. Also see :ref:`geoschem-config` for more information.
      
.. option:: HISTORY.rc

   #. Set the frequency and duration for the :ref:`HISTORY diagnostic
      <history-diagnostics>` collections to be consistent with the
      settings in   :option:`geoschem_config.yml`.

.. option:: HEMCO_Config.rc

   #. Set the :envvar:`DiagnFreq` parameter to be consistent
      with the simulation length defined in
      :option:`geoschem_config.yml`
   #. Select the emission inventories and data sets that
      you wish to use in your GEOS-Chem simulation.  

.. tip::

   You can reduce the amount of data that needs to be downloaded for
   your GEOS-Chem simulation by turning off inventories that you don't
   need.

4. Run GEOS-Chem Classic with the ``--dryrun`` flag
--------------------------------------------------------

Run GEOS-Chem with the :command:`--dryrun` command-line argument, and
pipe the output to a log file. Type:

.. code-block:: console

   $ ./gcclassic --dryrun | tee log.dryrun

This will pipe the output of the :file:`gcclassic` executable to the
Unix :program:`tee` command, which will send it to the screen and to a
log file named :file:`log.dryrun`.

The :file:`log.dryrun` file will look somewhat like a regular
GEOS-Chem log file but will also contain a list of data files and
whether each file was found on disk or not.  This information will be
used by the :file:`download_data.py` script in the next step.

You may use whatever name you like for the dry-run output
log file (but we prefer :file:`log.dryrun`).

.. _downloading-data-from-dry-run-output:

=================================
Download data from dry-run output
=================================

Once you have successfully executed a GEOS-Chem dry-run, you
can use the output from the dry-run (contained in the :file:`log.dryrun` file)
to download the data files that GEOS-Chem will need to perform the
corresponding "production" simulation. You may download from one of
several GEOS-Chem mirror sites, which are described in the following
sections.

.. important::

   Before you use the :file:`download_data.py` script, make sure to
   initialize a Conda environment by typing :command:`conda activate
   ENV-NAME` (where ENV-NAME is the name of your environment).
   
   Also make sure that you have installed the PyYAML module to your
   conda environment.  PyYAML will allow the :file:`download_data.py`
   script to read certain configurable settings from a YAML file in
   your run directory.

You can download GEOS-Chem data from one of the following mirror sites:

.. _downloading-data-from-washu:

The geoschemdata.wustl.edu mirror (aka WashU)
---------------------------------------------

If you are using GEOS-Chem on your institutional computer cluster, we
recommend that you **download data from the WashU (Washington
University in St. Louis) mirror site** (`http://geoschemdata.wustl.edu
<http://geoschemdata.wustl.edu.ca>`_).  This mirror, which is
maintained by Randall Martin's group at WashU, is the main data mirror
mirror for GEOS-Chem.

.. tip::

   We have also set up a `Globus
   <https://www.globus.org/data-transfer>`_ endpoint named **GEOS-Chem
   data (WashU)** on the WashU mirror site.  If you need to
   download many years of data, it may be faster to use	 Globus
   (particularly if your home institution supports it). 

Navigate to your GEOS-Chem run directory where you executed the dry-run
and type:

.. code-block:: console

   $ ./download_data.py log.dryrun washu

The :file:`download_data.py` Python program is included in each GEOS-Chem run
directory that you create.  This program creates and executes a temporary bash script
containing the appropriate :file:`wget` commands to download the data files.
(We have found that this is the fastest method.)

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
with dryrun ouptut, with :file:`.unique` appended. In our above example, we
passed :file:`log.dryrun` to :file:`download_data.py`, so the "unique" log file will
be named :file:`log.dryrun.unique`. This "unique" log file can be very useful
for documentation purposes.

.. _downloading-data-from-aws-s3-gcgrid:

The s3://gcgrid mirror (aka Amazon)
-----------------------------------

If you are running GEOS-Chem Classic on the Amazon Web Services cloud,
you can quickly **download the necessary data for your GEOS-Chem
simulation from the ``s3://gcgrid`` bucket** to the Elastic Block
Storage (EBS) volume attached to your cloud instance.

Navigate to your GEOS-Chem Classic run directory and type:

.. code-block:: console

    $ ./download data.py log.dryrun amazon

This will start the data download process using the ``aws s3 cp``
commands, which should execute much more quickly than if you were to
download the data from Compute Canada. It will also produce the **log
of unique data files**.

.. important::

   Copying data from :file:`s3://gcgrid` to the EBS volume of an
   Amazon EC2 cloud instance is always free. But if you download data
   from :file:`s3://gcgrid` to your own computer system, you will
   incur an egress fee. **PROCEED WITH CAUTION!**

.. _downloading-data-from-rochester:

The atmos.earth.rochester.edu mirror (aka Rochester)
----------------------------------------------------

The U. Rochester site (which is maintained by Lee Murray's research
there) contains the GCAP 2.0 met field data.  This met field data is
useful if you wish to perform simulations stretching back into the
preindustrial period, or running into the future.

To download data from the Rochester mirror, type:

.. code-block:: console

    $ ./download data.py log.dryrun rochester

.. _downloading-data-from-computecanada:

Skip download, but create log of unique files
---------------------------------------------

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
