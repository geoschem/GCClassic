.. _configure-your-computational-environment:

Configure your computational environment
========================================

In this chapter, we will show you how to create an **environment
file**.  An environment file does the following:

  1. Loads software libraries into your login environment.  This is
     often done with a module manager such as ``lmod``, ``spack``, or
     ``environment-modules``. 

  2. Stores settings for GEOS-Chem and its dependent libraries in
     shell variables called `environment variables <https://www.networkworld.com/article/3215965/all-you-need-to-know-about-unix-environment-variables.html>`_.
    
Environment files allow you to easily switch between different sets of
libraries.  For example, you can keep one environment file to load the
Intel Compilers for GEOS-Chem and another to load the GNU Compilers.

For general information about how libraries are loaded, see our
:ref:`Library Guide <load-required-libraries-for-geos-chem>` in the
Supplement section. 

Sample environment file
-----------------------

This example is taken from the Harvard Cannon cluster, which uses the
Lmod module manager to load software libraries.

.. code-block::







.. _loading-required-libraries-for-geos-chem:

Loading required libraries for GEOS-Chem
========================================

This chapter describes the how to load the :ref:`required libraries for GEOS-Chem <software-requirements>`
into your computational environment.

.. _on-the-amazon-web-services-cloud:

On the Amazon Web Services Cloud
--------------------------------

All of the required software libraries for GEOS-Chem will be included in
the Amazon Machine Image (AMI) that you use to initialize your Amazon
Elastic Cloud Compute (EC2) instance. For more information, please see
our `our GEOS-Chem cloud computing tutorial <http://cloud-gc.readthedocs.io>`_.

.. _on-a-shared-computer-cluster:

On a shared computer cluster
----------------------------

If you plan to use GEOS-Chem on a shared computational cluster (e.g.
at a university or research institution), then there is a good
chance that your IT staff will have already installed several of the required
libraries for GEOS-Chem.

Depending on your system's setup, there are a few different ways in
which you can make these libraries available for use in your
computational environment.  These are described in the following sections:

.. _check-if-libraries-are-available-as-modules:

Check if libraries are available as modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Many high-performance computing (HPC) clusters use a module manager such
as `Lmod <https://lmod.readthedocs.io/en/latest/>`_ or
`environment-modules <https://modules.readthedocs.io/en/latest/>`_
to load software packages and libraries. A module manager allows you to 
load different compilers and libraries with simple commands.

One downside of using a module manager is that you are locked into using
only those compiler and software versions that have already been
installed on your system by your IT staff.  But in general, module
managers succeed in ensuring that only well-tested compiler/software
combinations are made available to users.

.. _example-loading-gcc-820:

Example: Loading GNU Compiler Collection 8.2.0 and related modules
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

On the Harvard Cannon cluster, software packages can be loaded with
commands such as these:

.. code-block:: bash

   module purge
   module load git/2.17.0-fasrc01
   module load gcc/8.2.0-fasrc01
   module load netcdf/4.1.3-fasrc02
   ... etc ...
   
where

- The first command (``module purge``) removes all
  previously-loaded modules from your computational environment.
- The second command loads the :program:`Git` source code management system.
- The third command loads the GNU Compiler Collection version 8.2.0.
  This includes the  C (:program:`gcc`), C++ (:program:`g++`) and
  Fortran (:program:`gfortran`) compilers.
- The fourth command loads the netCDF C and Fortran libraries (in this
  version they are bundled together)
- and so forth...

.. _environment-files:
  
Environment files
^^^^^^^^^^^^^^^^^
We recommend that you place module load commands into a separate
**environment file**  rather than directly into your :file:`~/.bashrc`
or :file:`~/.bash_aliases` startup scripts.

For example, if you place the module load commands listed :ref:`in the example above <example-loading-gcc-820>`  into a file named :file:`~/gcclassic.gnu820.env`, you can activate those
settings with the command ``source /gcclassic.gnu820.env``.  This can
be done directly at the  command line, or from within a
:ref:`GEOS-Chem run script <sample-geos-chem-run-scripts>`.

.. tip:: Keep a separate environment file for each combination of
	 modules that you will load.

Module managers make it easy to load many different library versions.
For example, to load software libraries that were built with the Intel
Fortran Compiler instead of the GNU Compiler Collection, you can
simply use a different set of ``module load`` statements: 

.. code-block:: bash

   module load intel/17.0.4-fasrc01
   module load openmpi/2.1.0-fasrc02
   module load netcdf/4.3.2-fasrc05
   module load netcdf-fortran/4.4.0-fasrc03
   ... etc ...

And then you can save these into a separate environment file named
:file:``~/gcclassic.intel17.env`.
   
Auto-setting of environment variables
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

As a convenience, your module manager may export the relevant folder
paths to your computational environment.  For example, issuing the above module
statements on the Harvard Cannon cluster will export the following
environment variables:

.. code-block:: bash

   $GCC_HOME        # Home folder for gcc 8.2.0
   $GCC_INCLUDE     # Folder where include files of gcc 8.2.0 are stored
   $GCC LIB         # Folder where library files of gcc 8.2.0 are stored
   $NETCDF_HOME     # Home folder for netcdf-4.1.3
   $NETCDF_INCLUDE  # Folder where netCDF include files (*.mod, *.h) are stored
   $NETCDF_LIB      # Folder where netCDF library files (*.a, *.so) are stored

You can then use these environment variables to tell GEOS-Chem where it
can find the netCDF libraries on your system. See our
:ref:`Setting Environment Variables for GEOS-Chem <setting-environment-variables-for-geos-chem>`
chapter.

.. important:: The names of these environment variables may be
	       different on your system (ask your sysadmin/IT staff
	       for more information). 
   
If netCDF-Fortran is installed as a separate module, then your module
manager may also define additional environment variables for you. For
example, on the Harvard Odyssey cluster, the following environment
variables are defined when a netCDF-Fortran module is loaded:

.. code-block:: bash

   $NETCDF_FORTRAN_HOME     # netCDF home folder`
   $NETCDF_FORTRAN_INCLUDE  # Folder for netCDF include files (*.mod, *.h)
   $NETCDF_FORTRAN_LIB      # Folder for netCDF library files (*.a, *.so)

.. note:: Starting with netCDF 4.2.0 and later, the netCDF Fortran
          library has been split off from the netCDF main library.  That is why
          you will sometimes need to load netCDF and netCDF-Fortran separately.  
   
.. _check-if-libraries-are-available-via-spack:

Check if libraries are available via Spack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your system doesn't have a module manager installed, check to see if
the required libraries for GEOS-Chem were built the
`Spack package manager <https://github.com/spack/spack>`_. You can type

.. code-block:: console

   $ spack find

to see if there are any Spack-built packages such as the GNU Fortran
Compiler, netCDF, and/or netCDF-Fortran. If your system also has a
module manager installed, then you can load libraries with the
``spack load`` command, e.g.

.. code-block:: console

   $ spack load gcc@10.2.0
   $ spack load netcdf-c%gcc@10.2.0
   $ spack load netcdf-fortran%gcc@10.2.0
   ... etc ...

.. note:: When loading a Spack-built library, you can specify its
	  version number.  In the example above, ``spack load
	  gcc@10.2.0`` tells Spack to load the GNU Compiler Collection
	  version 10.2.0.
	  
	  You may also specify a library by the compiler it was built
	  with.  For example, ``spack load netcdf-fortran%gcc@10.2.0`` tells
	  Spack to load the version of netCDF-Fortran that
	  was built with GNU Compiler Collection version 10.2.0.

	  These specification methods are often necessary to select a
	  given library in case there are several available builds to
	  choose from.

We recommend that you place ``spack load`` commands can also be placed into an environment
file, :ref:`as mentioned above <environment-files>`.
   
.. _check-if-libraries-have-been-manually-installed:

Check if libaries have been manually installed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your computer system does not use a module manager and does not use
Spack, check for a manual library installation. Very often, common
software libraries are installed into standard locations such as the
:file:`/usr/lib` or :file:`/usr/local/lib` system folders.  Ask your IT
staff for more information.

Once you know the location of the compiler and netCDF libraries, you can
`set the proper environment variables for GEOS-Chem <Configuring_your_computational_environment>`_.

.. _finally_install_libraries_yourself_with_spack:

If your system has none of these libraries, install them with Spack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your system has none of the required software packages that GEOS-Chem
needs, then we recommend that you
:ref:`use Spack to build the libraries yourself <build-libraries-for-geos-chem-with-spack>`.
Spack makes the process easy and will make sure that all software
dependences are resolved.

We have provided step-by-step instructions on
:ref:`installing libraries with Spack <building-required-libraries-with-spack>`
in our Reference section.

Once you have installed the libraries with Spack, you can load the
libraries into your computational environment
:ref:`as described above <check-if-libraries-are-available-via-spack>`.


.. _configuring-your-computational-environment:

Configuring your computational environment
==========================================

After you have specified a compiler to use with GEOS-Chem, you must set
some  These definitions can be placed in your **environment file**.

.. _environment-variables-for-compilers:

Environment variables for compilers
-----------------------------------

It is convention to use the following environment variable names for compilers:

.. table::

    +----------+------------------------------+
    | Variable | Description                  |
    +==========+==============================+
    | ``CC``   | Name of the C compiler       |
    +----------+------------------------------+
    | ``CXX``  | Name of the C++ compiler     |
    +----------+------------------------------+
    | ``FC``   | Name of the Fortran compiler |
    +----------+------------------------------+

In most cases, the Fortran, C, and C++ compilers are installed together
as a integrated package.  Using a command such as ``module load`` or
``spack load`` will make all three of these compilers available.

.. note:: If you are using GEOS-Chem Classic, you really only
	  need the Fortran compiler. But if you will be building other
	  software packages (such as :ref:`KPP-for-GEOS-Chem`), you
	  will need the C and/or C++ compilers.

.. _check-if-environment-variables-have-been-automatically-set:

Check if environment variables have been automatically set
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On many systems, especially those that use a module system to load
libraries, the ``FC``, ``CC``, and ``CXX`` will be set automatically
for you when you load the library.

The easiest way to check if these variables have been automatically
set is to print them to the screen:

.. code-block:: console

   $ echo $CC
   $ echo $CXX
   $ echo $FC

If these variables are not blank, you may skip ahead to
:ref:`Specifying parallelization settings <specifying-parallelization-settings>`.
Otherwise, continue to the next section.

.. _manually-defining-compiler-environment-variables:

Manually defining compiler environment variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the ``FC``, ``CC``, and ``CXX`` environment variables are all undefined,
then set them manually in your startup script (e.g. ``.bashrc``) as follows:

For the :ref:`Intel Compiler Suite <the-intel-compiler-suite>`

.. code-block:: bash

   export CC=icc
   export CXX=icpc
   export FC=ifort

For the :ref:`GNU Compiler Collection <the-gnu-compiler-collection>`

.. code-block:: bash

   export CC=gcc
   export CXX=g++
   export FC=gfortran

Then type:

.. code-block:: console

   $ source ~/.bashrc

to apply the changes.

.. _specifying-parallelization-settings:

Specifying parallelizaton settings
----------------------------------

GEOS-Chem "Classic" uses
`OpenMP parallelization <Parallelizing_GEOS-Chem>`_, which is an
implementation of shared-memory (aka serial) parallelization. Two 
environment variables control the OpenMP parallelization settings, as
defined below. 

.. _omp-num-threads:

OMP_NUM_THREADS
~~~~~~~~~~~~~~~

The ``OMP_NUM_THREADS`` environment variable sets the number of
computational cores (aka threads) that you would like GEOS-Chem to use.

The following commands will request that GEOS-Chem use 8 cores by
default:

.. code:: example

    $ export OMP_NUM_THREADS=8

You can of course change the number of cores from 8 to however many you
want your GEOS-Chem simulation to use.

.. important:: OpenMP-parallelized programs (such as GEOS-Chem
	       Classic) cannot execute on more than 1 computational node.

	       Most modern computational nodes typically contain
	       between 16 and 64 cores. Therefore, your GEOS-Chem
	       "Classic" simulations will not be able to take
	       advantage of more cores than these.
	       
	       We recommend that you consider using
	       `GCHP <https://gchp.readthedocs.io>`_ for more computationally-intensive simulations.

We recommend that you set ``OMP_NUM_THREADS`` not only in your
environment file, but in also each GEOS-Chem run script that you use.

.. _omp-stacksize:

OMP_STACKSIZE
~~~~~~~~~~~~~

In order to use GEOS-Chem "Classic" with
`OpenMP parallelization <Parallelizing_GEOS-Chem>`_, you must 
request the maximum amount of stack memory in your Unix environment. 
(The stack memory is where local automatic variables and temporary
``!$OMP PRIVATE`` variables will be created.) Add the following lines to
your system startup file and to your GEOS-Chem run scripts:

.. code-block:: bash

   ulimit -s unlimited
   export OMP_STACKSIZE=500m

The ``ulimit -s unlimited`` will tell the bash shell to use the
maximum amount of stack memory that is available.

The environment variable ``OMP_STACKSIZE`` must also be set to a very
large number. In this example, we are nominally requesting 500 MB of
memory. But in practice, this will tell the GNU Fortran compiler to use
the maximum amount of stack memory available on your system. The value
``500m`` is a good round number that is larger than the amount of stack
memory on most computer clusters, but you can increase this if you wish.

We recommend that you set ``OMP_STACKSIZE`` not only in your Bash startup
script, but in also each
:ref:\`GEOS-Chem run script <Sample GEOS-Chem run scripts>\` that you use.

.. _errors_caused_by_incorrect_settings:

Errors caused by incorrect settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. If the ``OMP_NUM_THREADS`` is set to 1, then your GEOS-Chem simulation
   will execute properly, but only use one computational core. This will
   make your simulation run much more slowly than intended.

2. If the ``OMP_STACKSIZE`` environment variable is not included in your
   startup script, or if it is set to a very low value, you might
   encounter a segmentation fault
   `segmentation fault error after the TPCORE transport module is initialized <Segmentation_faults#Segmentation_fault_encountered_after_TPCORE_initialization>`_.
   In this case, GEOS-Che  "thinks" that it does not have enough memory to
   perform the simulation, even though sufficient memory may be present.
   Including the ``OMP_STACKSIZE`` variable definition in your startup
   script as described above usually fixes this error.
