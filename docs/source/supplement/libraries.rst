.. _load-required-libraries-for-geos-chem:

Load required libraries for GEOS-Chem
========================================

This supplemental guide describes the how to load the
:ref:`required software dependencies for GEOS-Chem Classic
<software-requirements>` into your computational environment.

.. _on-the-amazon-web-services-cloud:

On the Amazon Web Services Cloud
--------------------------------

All of the required software libraries for :program:`GEOS-Chem
Classic` will be included in the Amazon Machine Image (AMI) that you
use to initialize your Amazon Elastic Cloud Compute (EC2)
instance. For more information, please see our `our GEOS-Chem cloud
computing tutorial <http://cloud-gc.readthedocs.io>`_. 

.. _on-a-shared-computer-cluster:

On a shared computer cluster
----------------------------

If you plan to use :program:`GEOS-Chem Classic` on a shared
computational cluster (e.g. at a university or research institution),
then there is a good chance that your IT staff will have already
installed several of the required libraries.

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

Example: Load modules for GNU compilers 8.2.0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

On the Harvard Cannon cluster, software packages can be loaded with
:program:`module load` commands such as these:

.. code-block:: console

   $ module purge
   $ module load git/2.17.0-fasrc01
   $ module load gcc/8.2.0-fasrc01
   $ module load openmpi/3.1.1-fasrc01
   $ module load netcdf/4.1.3-fasrc02
   $ module load perl/5.26.1-fasrc01
   $ module load cmake/3.17.3-fasrc01

where the version number and build identifier are listed after the
``/`` character.  (This setup may differ on your system.)

Here is a summary of what the above commands do:

+------------------------------------+--------------------------------------------+
| Command                            | Description                                |
+====================================+============================================+
| :command:`module purge`            | Removes previously loaded modules          |
+------------------------------------+--------------------------------------------+
| :command:`module load git/...`     | Loads Git (version control system)         |
+------------------------------------+--------------------------------------------+
| :command:`module load gcc/...`     | Loads GNU compilers                        |
+------------------------------------+--------------------------------------------+
| :command:`module load openmpi/...` | Loads OpenMPI (needed for netCDF)          |
+------------------------------------+--------------------------------------------+
| :command:`module load netcdf/...`  | Loads netCDF library                       |
+------------------------------------+--------------------------------------------+
| :command:`module load perl/...`    | Loads Perl (scripting language)            |
+------------------------------------+--------------------------------------------+
| :command:`module load cmake/...`   | Loads CMake (build system for GEOS-Chem)   |
+------------------------------------+--------------------------------------------+

Ask your sysadmin if your computer cluster has a similar method of
loading software libraries.

.. _check-if-libraries-are-available-via-spack:

Check if libraries are available via Spack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your system doesn't have a module manager installed, check to see
if the required libraries for GEOS-Chem were built the `Spack package
manager <https://github.com/spack/spack>`_.  Type

.. code-block:: console

   $ spack find

to locate any Spack-built software libraries on your system.  If there
Spack-built libraries are found, you may present, you may load them
into your computational environment with :program:`spack load`
commands:

.. code-block:: console

   $ spack load gcc@10.2.0
   $ spack load netcdf-c%gcc@10.2.0
   $ spack load netcdf-fortran%gcc@10.2.0
   ... etc ...

.. note:: When loading a Spack-built library, you can specify its
	  version number.  For example, :command:`spack load
	  gcc@10.2.0` tells Spack to load the GNU Compiler Collection
	  version 10.2.0.

	  You may also specify a library by the compiler it was built
	  with.  For example, :command:`spack load
	  netcdf-fortran%gcc@10.2.0` tells Spack to load the version
	  of netCDF-Fortran that was built with GNU Compiler
	  Collection version 10.2.0.

	  These specification methods are often necessary to select a
	  given library in case there are several available builds to
	  choose from.

We recommend that you place :command:`spack load` commands into an
:ref:`environment file <environment_files>`.

.. _check-if-libraries-have-been-manually-installed:

Check if libaries have been manually installed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your computer system does not use a module manager and does not use
Spack, check for a manual library installation. Very often, common
software libraries are installed into standard locations (such as the
:file:`/usr/lib` or :file:`/usr/local/lib` system folders).  Ask your
sysadmin for more information.

Once you know the location of the compiler and netCDF libraries, you can
`set the proper environment variables for GEOS-Chem
<Configuring_your_computational_environment>`_.

.. _finally_install_libraries_yourself_with_spack:

If there are none of these, install them with Spack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your system has none of the required software packages that GEOS-Chem
needs, then we recommend that you  :ref:`use Spack to build the
libraries yourself <build-libraries-for-geos-chem-with-spack>`.
Spack makes the process easy and will make sure that all software
dependences are resolved.

Once you have installed the libraries with Spack, you can load the
libraries into your computational environment :ref:`as described above
<check-if-libraries-are-available-via-spack>`.
