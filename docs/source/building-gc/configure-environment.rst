.. _configure-your-computational-environment:

########################################
Configure your computational environment
########################################

In this chapter, we will show you how to create an **environment
file**.  An environment file does the following:

  1. Loads software libraries into your login environment.  This is
     often done with a module manager such as :command:`lmod`,
     :command:`spack`, or  :command:`environment-modules`.

  2. Stores settings for GEOS-Chem and its dependent libraries in
     shell variables called `environment variables
     <https://www.networkworld.com/article/3215965/all-you-need-to-know-about-unix-environment-variables.html>`_.

Environment files allow you to easily switch between different sets of
libraries.  For example, you can keep one environment file to load the
Intel Compilers for GEOS-Chem and another to load the GNU Compilers.

For general information about how libraries are loaded, see our
:ref:`Library Guide <load-required-libraries-for-geos-chem>` in the
Supplement section.

.. _environment_files:

=================
Environment files
=================

.. tip::

   You may skip this section if you plan on using :program:`GEOS-Chem
   Classic` on an Amazon EC2 cloud instance.  When you initialize the
   EC2 instance with one of the pre-configured Amazon Machine Images
   (AMIs) all of the required software libraries will be automatically
   loaded.

We recommend that you place module load commands into a separate
**environment file**  rather than directly into your :file:`~/.bashrc`
or :file:`~/.bash_aliases` startup scripts.

.. _gnu_10_example:

Sample environment file for GNU 10.2.0 compilers
------------------------------------------------

Below is a sample environment file from the Harvard Cannon computer
cluster.  This file will load software libraries built with the GNU
10.2.0 compilers.

Save the code below (with any appropriate modifications for your own
computer system) to a file named :file:`~/gcclassic.gnu102.env`.

.. code-block:: bash

   # Echo message if we are in a interactive (terminal) session
   if [[ $- = *i* ]] ; then
     echo "Loading modules for GEOS-Chem, please wait ..."
   fi

   #==============================================================================
   # Modules (specific to Cannon @ Harvard)
   #==============================================================================

   # Remove previously-loaded modules
   module purge

   # Load modules for GNU Compilers v10.2.0
   module load git/2.17.0-fasrc01
   module load gcc/10.2.0-fasrc01
   module load openmpi/4.1.0-fasrc01
   module load netcdf-fortran/4.5.3-fasrc03
   module load flex/2.6.4-fasrc01
   module load cmake/3.17.3-fasrc01

   #==============================================================================
   # Environment variables
   #==============================================================================

   # Parallelization settings for GEOS-Chem Classic
   export OMP_NUM_THREADS=8
   export OMP_STACKSIZE=500m

   # Make all files world-readable by default
   umask 022

   # Specify compilers
   export CC=gcc
   export CXX=g++
   export FC=gfortran

   # Netcdf variables for CMake
   # NETCDF_HOME and NETCDF_FORTRAN_HOME are automatically
   # defined by the "module load" commands on Cannon.
   export NETCDF_C_ROOT=${NETCDF_HOME}
   export NETCDF_FORTRAN_ROOT=${NETCDF_FORTRAN_HOME}

   # Set memory limits to max allowable
   ulimit -c unlimited              # coredumpsize
   ulimit -l unlimited              # memorylocked
   ulimit -u 50000                  # maxproc
   ulimit -v unlimited              # vmemoryuse
   ulimit -s unlimited              # stacksize

   # List modules loaded
   module list

.. tip::

   Ask your sysadmin how to load software libraries.  If you are using
   your institution's computer cluster, then chances are there will
   be a software module system installed, with commands similar to
   those listed above.

Then you can activate these seetings from the command line by typing:

.. code-block:: console

   $ source ~/gcclassic.gnu102.env

You may also place the :command:`source ~/gcclassic.gnu102.env` command
within your :ref:`GEOS-Chem run scripts <sample-geos-chem-run-scripts>`.

.. _intel_19_example:

Sample environment file for Intel 19 compilers
----------------------------------------------

To load software libraries based on the Intel 19 compilers, we can
start from our :ref:`GNU 10.2.0 environment file <gnu_10_example>` and
add the proper :command:`module load` commands for Intel 19.

Add the code below (with the appropriate modifications for your
system) into a file named :file:`~/gcclassic.intel19.env`.

.. code-block:: bash

   # Echo message if we are in a interactive (terminal) session
   if [[ $- = *i* ]] ; then
     echo "Loading modules for GEOS-Chem, please wait ..."
   fi

   #==============================================================================
   # Modules (specific to Cannon @ Harvard)
   #==============================================================================

   # Remove previously-loaded modules
   module purge

   # Load modules for Intel compilers v19.0.4
   module load git/2.17.0-fasrc01
   module load intel/19.0.5-fasrc01
   module load openmpi/4.0.1-fasrc01
   module load netcdf-fortran/4.5.2-fasrc03
   module load flex/2.6.4-fasrc01
   module load cmake/3.17.3-fasrc01

   #==============================================================================
   # Environment variables
   #==============================================================================

   # Parallelization settings for GEOS-Chem Classic
   export OMP_NUM_THREADS=8
   export OMP_STACKSIZE=500m

   # Make all files world-readable by default
   umask 022

   # Specify compilers
   export CC=icc
   export CXX=icpc
   export FC=ifort

   # Netcdf variables for CMake
   # NETCDF_HOME and NETCDF_FORTRAN_HOME are automatically
   # defined by the "module load" commands on Cannon.
   export NETCDF_C_ROOT=${NETCDF_HOME}
   export NETCDF_FORTRAN_ROOT=${NETCDF_FORTRAN_HOME}

   # Set memory limits to max allowable
   ulimit -c unlimited              # coredumpsize
   ulimit -l unlimited              # memorylocked
   ulimit -u 50000                  # maxproc
   ulimit -v unlimited              # vmemoryuse
   ulimit -s unlimited              # stacksize

   # List modules loaded
   module list

.. tip::

   Ask your sysadmin how to load software libraries.  If you
   are using your institution's computer cluster, then chances
   are there will be a software module system installed, with
   commands similar to those listed above.

Then you can activate these seetings from the command line by typing:

.. code-block:: console

   $ source gcclassic.intel19.env

You may also place the :command:`source ~/gcclassic.intel19.env` command
within your :ref:`GEOS-Chem run scripts <sample-geos-chem-run-scripts>`.

.. tip::

   Keep a separate environment file for each combination of
   modules that you will load.

.. _set_environment-variables-for-compilers:

=======================================
Set environment variables for compilers
=======================================

Use the following environment variables to specify compilers:

.. table:: Environment variables that specify the choice of compiler
   :align: center

   +---------------+------------------+--------------------+-----------------+
   | Variable      | Specifies the:   | GNU name           | Intel name      |
   +===============+==================+====================+=================+
   | :envvar:`CC`  | C compiler       | :envvar:`gcc`      | :envvar:`icc`   |
   +---------------+------------------+--------------------+-----------------+
   | :envvar:`CXX` | C++ compiler     | :envvar:`g++`      | :envvar:`icpc`  |
   +---------------+------------------+--------------------+-----------------+
   | :envvar:`FC`  | Fortran compiler | :envvar:`gfortran` | :envvar:`ifort` |
   +---------------+------------------+--------------------+-----------------+

These environment variables should be defined in your
:ref:`environment file <environment_files>`.

.. note::

   Only the Fortran compiler is needed to compile :program:`GEOS-Chem
   Classic`.  But if you will be building other software packages
   (cf  :ref:`kppguide`), or :ref:`manually installing libraries
   <build-libraries-for-geos-chem-with-spack>`,
   you will also need the C and C++ compilers.

.. _specifying-parallelization-settings:

=============================================
Set environment variables for parallelization
=============================================

:program:`GEOS-Chem Classic` uses `OpenMP parallelization
<Parallelizing_GEOS-Chem>`_, which is an implementation of
shared-memory (aka serial) parallelization.

.. important::

   OpenMP-parallelized programs (such as GEOS-Chem Classic) cannot
   execute on more than 1 computational node.  Most modern
   computational nodes typically contain  between 16 and 64
   cores. Therefore, :program:`GEOS-Chem Classic` simulations will
   not be able to take advantage of more cores than these.

   We recommend that you consider using `GCHP
   <https://gchp.readthedocs.io>`_ for more computationally-intensive
   simulations.

Two environment variables control the OpenMP parallelization settings:

.. option:: OMP_NUM_THREADS

   The :envvar:`OMP_NUM_THREADS` environment variable sets the number of
   computational cores (aka threads) that you would like GEOS-Chem
   Classic to use.

   For example, the command below will tell :program:`GEOS-Chem Classic`
   to use 8 cores within parallel sections of code:

   .. code:: console

      $ export OMP_NUM_THREADS=8

   We recommend that you define :envvar:`OMP_NUM_THREADS` not only in your
   environment file, but also in your :ref:`GEOS-Chem run scripts
   <sample-geos-chem-run-scripts>`.

.. option:: OMP_STACKSIZE

   In order to use :program:`GEOS-Chem Classic` with
   `OpenMP parallelization <Parallelizing_GEOS-Chem>`_, you must
   request the maximum amount of stack memory in your Unix environment.
   (The stack memory is where local automatic variables and temporary
   :envvar:`!$OMP PRIVATE` variables will be created.) Add the following lines to
   your system startup file and to your GEOS-Chem run scripts:

   .. code-block:: bash

      ulimit -s unlimited
      export OMP_STACKSIZE=500m

   The :command:`ulimit -s unlimited` will tell the bash shell to use the
   maximum amount of stack memory that is available.

   The environment variable :envvar:`OMP_STACKSIZE` must also be set to a very
   large number. In this example, we are nominally requesting 500 MB of
   memory. But in practice, this will tell the GNU Fortran compiler to use
   the maximum amount of stack memory available on your system. The value
   **500m** is a good round number that is larger than the amount of stack
   memory on most computer clusters, but you can increase this if you wish.

   We recommend that you set :envvar:`OMP_STACKSIZE` not only in your
   Bash startup script, but in also each `GEOS-Chem run script
   <https://github.com/geoschem/geos-chem/tree/main/run/GCClassic/runScriptSamples>`_
   that you use.

.. _errors_caused_by_incorrect_settings:

Errors caused by incorrect environment variable settings
--------------------------------------------------------

Be on the lookout for these errors:

  #. If :option:`OMP_NUM_THREADS` is set to 1, then your
     :program:`GEOS-Chem Classic` simulation will execute using only
     one  computational core.  This will make your simulation take much
     longer than is necessary.

  #. If :option:`OMP_STACKSIZE` environment variable is not included
     in your environment file (or if it is set to a very low value),
     you might encounter a `segmentation fault error after the TPCORE
     transport module is initialized
     <Segmentation_faults#Segmentation_fault_encountered_after_TPCORE_initialization>`_. 
     In this case, :program:`GEOS-Chem Classic` "thinks" that it does
     not have enough memory to perform the simulation, even though
     sufficient memory may be present.
