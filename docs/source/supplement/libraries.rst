.. _load-required-libraries-for-geos-chem:

Load required libraries for GEOS-Chem
========================================

This supplemental guide describes the how to load the
:ref:`required libraries for GEOS-Chem <software-requirements>`
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
   module load openmpi/3.1.1-fasrc01
   module load netcdf/4.1.3-fasrc02
   module load perl/5.26.1-fasrc01
   module load jdk/1.8.0_172-fasrc01
   module load cmake/3.17.3-fasrc-01
   module load emacs/26.1-fasrc01
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
   $NETCDF_FORTRAN_INCLUDE  # Folder for netCDF include files (.mod, .h)
   $NETCDF_FORTRAN_LIB      # Folder for netCDF library files (.a, .so)

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
