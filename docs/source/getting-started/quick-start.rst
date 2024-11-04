.. |br| raw:: html

   <br/>

.. _quick:

################
Quickstart Guide
################

This quickstart guide is for quick reference on how to download,
build, and run :program:`GEOS-Chem Classic`, which is the single-node
instance of GEOS-Chem.

.. tip::

   Please also see our `GCHP Quickstart Guide
   <https://gchp.readthedocs.io/en/stable/getting-started/quick-start.html>`_
   if you would like to run GEOS-Chem across using more than one
   computational node.

This guide assumes that your environment satisfies GEOS-Chem Classic
:ref:`hardware <req-hard>` and :ref:`software <req-soft>`
requirements. This means you should load a :ref:`compute environment
<env>` such that programs like :program:`cmake` are available before
continuing. If you do not have some of the required software
dependencies, you can find instructions for installing external
dependencies in our Spack instructions.

For simplicity we will also refer to :program:`GEOS-Chem Classic` as
simply :program:`GEOS-Chem` on this page.  More detailed instructions
on downloading, compiling, and running GEOS-Chem can be found in the
User Guide elsewhere on this site.

.. _quick_clone:

==========================
1. Clone GEOS-Chem Classic
==========================

Download the source code:

.. code-block:: console

   $ git clone --recurse-submodules https://github.com/geoschem/GCClassic.git GCClassic
   $ cd GCClassic

.. tip::

   If you wish, you may choose a different name for the source code
   folder, e.g.

   .. code-block:: console

      $ git clone --recurse-submodules https://github.com/geoschem/GCClassic.git my_code_dir
      $ cd my_code_dir

Upon download you will have the most recently released version. You
can check what this is by printing the last commit in the git log and
scanning the output for tag.

.. code-block:: console

   $ git log -n 1

.. tip::

   To use an older GEOS-Chem Classic version (e.g. 14.0.0), follow
   these additional steps:

   .. code-block:: console

      $ git checkout tags/14.0.0                  # Points HEAD to the tag "14.0.0"
      $ git branch version_14.0.0                 # Creates a new branch at tag "14.0.0"
      $ git checkout version_14.0.0               # Checks out the version_14.0.0 branch
      $ git submodule update --init --recursive   # Reverts submodules to the "14.0.0" tag

   You can do this for any tag in the version history.   For a list of
   all tags, type:

   .. code-block:: console

      $ git tag

   If you have any unsaved changes, make sure you commit those to a
   branch prior to updating versions.

.. _quick-rundir-create:

=========================
2. Create a run directory
=========================

Navigate to the :file:`run/` subdirectory.  To :ref:`create a run
directory <rundir>`, run the script :file:`./createRunDir.sh`:

.. code-block:: console

   $ cd run/
   $ ./createRunDir.sh

Creating a run directory is interactive, meaning you will
be asked multiple questions to set up the simulation.  For example,
running :file:`createRunDir.sh` will prompt questions about
configurable settings such as simulation type, grid resolution,
meteorology source, and number of vertical levels. It will also ask
you where you want to store your run directory and what you wish to
name it, including whether you want to use the default name,
e.g. :file:`gc_4x5_merra2_fullchem`.  We recommend storing run
directories in a place that has a large storage capacity.   It does
not need to be in the same location as your source code.  When
creating a run directory you can quit and start from scratch at any
time.

For demonstration purposes, we will use a full chemistry simulation
run directory with the default name (:file:`gc_merra2_4x5_fullchem`).
The steps to setup and run other types of GEOS-Chem Classic
simulations follow the same pattern as the examples shown below.

.. attention::

   The first time you create a run directory, you will be asked to
   provide :ref:`registration information <rundir-registration>`.
   Please answer all of the questions, as it will help us to keep
   track of GEOS-Chem usage worldwide.  We will also add your
   information to the `GEOS-Chem Users web page
   <https://geoschem.github.io/users.html>`_.

.. _quick-load:

========================
3. Load your environment
========================

Always make sure that all libraries and environment variables are
loaded prior to building GEOS-Chem Classic.  An easy way to do this is
to write an :ref:`environment file <env>` and load that file every
time you work with GEOS-Chem.  To make this extra easy you can create
a symbolic link to your environment file within your run directory or
for reference.  For example, do the following in your new run
directory to have a handy link to the environment you plan on using.

.. code-block:: console

   $ cd /path/to/gc_4x5_merra2_fullchem   # Skip if you are already here
   $ ln -s ~/envs/gcc.gfortran10.env gcc.env

Then every time you start up a session to work with GEOS-Chem in your
run directory you can easily load your environment.

.. code-block:: console

   $ source gcc.env

.. _quick-cfg:

=======================
4. Configure your build
=======================

You may build GEOS-Chem Classic from within the run directory or from
anywhere else on your system.  But we recommend that you always build
GEOS-Chem Classic from within the run directory.  This is convenient
because it keeps all build files in close proximity to where you will
run the model. For this purpose the GEOS-Chem run directory includes a
build directory called :file:`build/`.

First, navigate to the :file:`build/` folder of your run directory:

.. code-block:: console

   $ cd /path/to/gc_4x5_merra2_fullchem  # Skip if you are already here
   $ cd build

The next step is to :ref:`configure your build <compile-cmake>`. These
are persistent settings that are saved to your build directory. A
useful configuration option is :literal:`-DRUNDIR`.  This option lets you
specify one or more run directories that GEOS-Chem is "installed" to;
that is, where where the executable is copied, when you do
:command:`make install`.

Configure your build so it installs GEOS-Chem to the run directory you
created in Step 2. The run directory is one directory level higher
than the :file:`build` directory.  Also located one level higher than
the build directory is the :literal:`CodeDir` symbolic link to the
top-level GEOS-Chem source code directory.  Use the following command to
configure your build:

.. code-block:: console

   $ cmake ../CodeDir -DRUNDIR=..

GEOS-Chem has a number of :ref:`additional configuration options
<compile-cmake-step4>` you can add here. For example, to compile with
RRTMG after running the above command:

.. note::

   The :literal:`.` in the :program:`cmake` command above is
   important. It tells CMake that your current working directory
   (i.e., :literal:`.`) is your build directory.

   .. code-block:: console

      $ cmake . -DRRTMG=y

A useful configuration option is to build in **debug mode**. Doing
this is a good idea if you encountered an error (such as a
segmentation fault) in a previous run and need more information about
where the error happened and why.

.. code-block:: console

   $ cmake . -DCMAKE_BUILD_TYPE=Debug

:ref:`Click here <compile-cmake>` for more information on
configuration options.

.. _quick-cmp-inst:

======================
5. Compile and install
======================

:ref:`Compiling GEOS-Chem Classic <compile-make>` should take about a
minute, but it can vary depending on your system, your compiler, and
your configuration options. To maximize build speed you should compile
GEOS-Chem in parallel using as many cores as are available. Do this
with the :literal:`-j` flag from the :file:`build/` directory:

.. code-block:: console

   $ cd /path/to/gc_4x5_merra2_fullchem/build   # Skip if you are already here
   $ make -j

Upon successful compilation, install the compiled executable to your
run directory:

.. code-block:: console

   $ make install

This copies executable :file:`build/bin/gcclassic` and supplemental
files to your run directory.

.. note::
   You can update build settings at any time:

   #. Navigate to your build directory.
   #. Update your build settings with :program:`cmake` (only if they
      differ since your last execution of cmake)
   #. Recompile with :command:`make -j`. Note that the build system
      automatically figures out what (if any) files need to be
      recompiled.
   #. Install the rebuilt executable with :command:`make install`.

If you do not install the executable to your run directory you can always get the executable from the directory :command:`build/bin`.

.. _quick-rundir-conf:

===============================
6. Configure your run directory
===============================

Now, navigate to your run directory:

.. code-block:: console

   $ cd /path/to/gcc_4x5_merra2_fullchem

You should review these files before starting a simulation:

- :ref:`geoschem_config.yml <cfg-gc-yml>`
   - Controls several frequently-updated simulation settings
     (e.g. start and end time, which operations to turn on/off, etc.)

- :ref:`HISTORY.rc <histguide-configfile>`
   - Controls GEOS-Chem diagnostic settings.

- :ref:`HEMCO_Diagn.rc <cfg-hco-diagn>`
   - Controls emissions diagnostic settings via `HEMCO <https://hemco.readthedocs.io>`_.

- :ref:`HEMCO_Config.rc <cfg-hco-cfg>`
   - Controls which emissions inventories and other non-emissions data
     will be read from disk (via `HEMCO
     <https://hemco.readthedocs.io>`_).

.. attention::

   If you wish to spin up a GEOS-Chem simulation with a restart file
   that has (1) missing species or (2) a timestamp that does not
   match the start date in :ref:`geoschem_config.yml <cfg-gc-yml>`,
   simply change the time cycle flag for the :literal:`SPC_` entry in
   :ref:`HEMCO_Config.rc <cfg-hco-cfg>` from

   .. code-block:: console

      * SPC_ ... $YYYY/$MM/$DD/$HH EFYO xyz 1 * - 1 1

   to

   .. code-block:: console

      * SPC_ ... $YYYY/$MM/$DD/$HH CYS xyz 1 * - 1 1

   This will direct HEMCO to read the closest date
   available (:literal:`C`), to use the simulation year
   (:literal:`Y`),  and to skip any species (:literal:`S`) not found
   in the restart file.

   Skipped species will be assigned the initial concentration
   (units: :math:`mol\ mol^{-1}` w/r/t dry air) specified by its
   :option:`BackgroundVV` entry in :ref:`species_database.yml
   <cfg-spec-db>`.   If the species does not have a
   :option:`BackgroundVV` value specified, then its initial
   concentration will be set to :math:`1.0{\times}10^{-20}`
   instead.

Please see our :ref:`customguide` Supplemental Guide to learn how you
can customize your simulation by activating alternate science options
in your simulations.

.. _quick-dry-download:

======================
7. Download input data
======================

Before you can run your GEOS-Chem Classic simulation, you must first
:ref:`download the required input data <data>`.  These data include:

- :ref:`Meteorological fields <gcid-data-org-met>` (e.g. GEOS-FP,
  MERRA-2, GEOS-IT, or GCAP2)
- :ref:`Emissions inventories <gcid-data-org-emis-inputs>`
- :ref:`Inputs for GEOS-Chem modules (e.g. Cloud-J) <gcid-data-org-chem-inputs>`
- :ref:`Initial conditions for starting GEOS-Chem simulations <gcid-data-org-init-cond>`

.. tip::

   If your institution has several GEOS-Chem users, then someone may
   have already downloaded these data for you.  If this is the case,
   you may :ref:`start running your your GEOS-Chem Classic simulation
   <quick-run>` right away.

The easiest way to download data is to perform a :ref:`dry-run
simulation <dry-run>`. This is a GEOS-Chem Classic simulation that
steps through time, but does not perform computations or read data
files from disk.  Instead, the dry-run simulation prints a list of all
data files that the simulation would have read.

To start a dry-run simulation, type this command:

.. code-block:: console

   $ ./gcclassic --dryrun | tee log.dryrun

This will generate the :file:`log.dryrun` log file, which contains the
list of data files to be downloaded.

Once the dry-run simulation has finished, use the
:file:`download_data.py` file (included in your run directory) to
:ref:`download the required data <dry-run-download>`.

.. note::

   Depending on your system, you might have to activate a Conda or
   Mamba environment containing a version of Python before running the
   :file:`download.data.py` script.  Ask your sysadmin.

To start the data download, type:

.. code-block:: console

   $ ./download_data.py log.dryrun geoschem+http

This will download data from the :ref:`GEOS-Chem Input Data <gcid>`
portal using the HTTP data transfer protocol.

.. tip::

   If you have `AWS CLI (command line interface)
   <https://aws.amazon.com/cli/>`_ installed on your system, you
   can use this command instead:

   .. code-block:: console

      $ ./download_data.py log.dryrun geoschem+aws

   This will use the AWS CLI data download protocol instead, which
   should be faster than regular HTTP connections.  This is the
   command you should use if you are running GEOS-Chem Classic in an
   AWS EC2 instance.

We also maintain :ref:`separate data portals <gcid-special-portals>`
for special nested-grid domains as well as the GCAP 2.0 meteorology.

For more information about dry-run simulations, please see our
:ref:`dry-run` chapter.

.. _quick-run:

======================
8. Run your simulation
======================

If you used an :ref:`environment file <env>` to load software
libraries prior to building GEOS-Chem then you should load that file
prior to running.  To :ref:`run GEOS-Chem Classic <run>`, type at the
command line:

.. code-block:: console

   $ ./gcclassic

If you wish to send output to a log file,  use:

.. code-block:: console

   $ ./gcclassic > GC.log 2>&1

We recommend :ref:`running GEOS-Chem Classic as a batch job
<run-batch>`, although you can also do short runs
interactively. Running GEOS-Chem as a batch job means that you
:ref:`write a script (usually bash) <run-script>` and then you submit
that script to your local job scheduler (SLURM, LSF, etc.).  If
you write a batch script you can include sourcing your
:ref:`environment file <env>` within the script to ensure you always
use the intended environment. Submitting GEOS-Chem as a batch job is
slightly different depending on your scheduler.  If you aren't
familiar with scheduling jobs on your system, ask your system
administrator for guidance.

Those are the basics of using GEOS-Chem Classic!  See this user guide,
step-by-step guides, and reference pages for more detailed
instructions.
