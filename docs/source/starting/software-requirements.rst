.. _software-requirements:

#####################
Software requirements
#####################

This chapter lists the required software libraries that you must have installed on your system in order to use GEOS-Chem.

- If you are using a shared computer cluster, then many of these
  libraries have probably already been pre-installed by your IT
  staff.  Consult with them for more information.

- If you plan to use GEOS-Chem on the Amazon Web services cloud, then
  all of these libraries will be included with the Amazon Machine
  Image (AMI) that you will use to start your cloud instance.

- If your computer cluster has none of these libraries installed, then
  you will have to install them yourself
  (cf. :ref:`build-libraries-for-geos-chem-with-spack`).

.. _supported-compilers-for-GEOS-Chem-Classic:

=========================================
Supported compilers for GEOS-Chem Classic
=========================================

GEOS-Chem is written in the Fortran programming language. However, you
will also need C and C++ compilers to install certain libraries (like
:ref:`netcdf`) on your system.

.. _ifort-req:

The Intel Compiler Suite
------------------------
The :program:`Intel Compiler Suite` is our recommended proprietary
compiler suite.

Intel compilers produce well-optimized code that runs extremely
efficiency on machines with Intel CPUs. Many universities and
institutions will have an Intel site license that allows you to use
these compilers.

The GCST has tested :program:`GEOS-Chem Classic` with these versions
(but others may work as well):

- 19.0.5.281
- 19.0.4
- 18.0.5
- 17.0.4
- 15.0.0
- 13.0.079
- 11.1.069

**Best way to install:**  `Direct from Intel
<https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/fortran-compiler.html>`_
(may require purchase of a site license or a student license)

.. tip::

   Intel 2021 may be obtained for free, or installed with a
   package manager such as `Spack <https://spack.readthedocs.io>`_.

.. _gcc-req:

The GNU Compiler Collection
---------------------------
The :program:`GNU Compiler Collection` (or :program:`GCC` for short)
is our recommended open-source compiler suite.

Because the GNU Compiler Collection is free and open source, this is a
good choice if your institution lacks an Intel site license, or if you
are running GEOS-Chem on the Amazon EC2 cloud environment.

The GCST has tested :program:`GEOS-Chem Classic` with these versions
(but others may work as well):

- 11.2.0
- 11.1.0
- 10.2.0
- 9.3.0
- 9.2.0
- 8.2.0
- 7.4.0
- 7.3.0
- 7.1.0
- 6.2.0

**Best way to install:**  :ref:`With Spack
<build-libraries-for-geos-chem-with-spack>`.

.. _required-software-packages-for-geos-chem:

========================================
Required software packages for GEOS-Chem
========================================

.. _git-req:

Git
---
`Git <https://git-scm.com>`_ is the de-facto software industry
standard package for source code management. A version of Git usually
ships with most Linux OS builds.

The GEOS-Chem source code can be downloaded using the Git source code
management system. GEOS-Chem software repositories are stored at the
`https://github.com/geoschem <https://github.com/geoschem>`_
organization page.

**Best way to install:** `git-scm.com/downloads
<https://git-scm.com/downloads>`_.  But first check if you have a version of
Git pre-installed.

.. _cmake-req:

CMake
-----
`CMake <https://cmake.org/>`_ is software that directs how the
GEOS-Chem source code is compiled into an executable.  You will need
:program:`CMake` version 3.13 or later to build GEOS-Chem Classic.

**Best way to install:**  :ref:`With Spack
<build-libraries-for-geos-chem-with-spack>`.

.. _gnu-make-req:

GNU Make
--------
:program:`GNU Make` is software that can build executables from source
code.

While GNU Make is not required for GEOS-Chem 13.0.0 and later, some
external libraries that you might need to build will require GNU
Make. Therefore it is best to download GNU Make along with CMake.

**Best way to install:**  :ref:`With Spack
<build-libraries-for-geos-chem-with-spack>`.

.. _netcdf-req:

The netCDF library (plus dependencies)
--------------------------------------

GEOS-Chem input and output data files use the netCDF file format
(cf. :ref:`netcdf-guide`). NetCDF is a self-describing file format
that allows meadata (descriptive text) to be stored alongside data
values.

**Best way to install:**  :ref:`With Spack
<build-libraries-for-geos-chem-with-spack>`.

.. _optional-but-recommended-software-packages:

==========================================
Optional but recommended software packages
==========================================

.. _gcpy-req:

GCPy
----

`GCPy <https://gcpy.readthedocs.io>`_ is our recommended python
companion software to GEOS-Chem.

While :program:`GCPy` is not a general-purpose plotting package, it
does contain many useful functions for creating zonal mean and
horizontal plots from GEOS-Chem output. It also contains scripts to
generate plots and tables from GEOS-Chem benchmark simulations.

**Best way to install:**
`With Conda (see gcpy.readthedocs.io) <https://gcpy.readthedocs.io/en/stable/Getting-Started-with-GCPy.html>`__

.. _gdb-req:

gdb and cgdb
------------
`The GNU debugger (gdb) <https://gnu.org/software/GDB>`_  and `its
graphical interface (cgdb) <https://cgdb.github.io/>`_ are very useful
tools for tracking down the source of GEOS-Chem errors, such
as segmentation faults, out-of-bounds errors, etc.

**Best way to install:**  :ref:`With Spack
<build-libraries-for-geos-chem-with-spack>`.

.. _ncview-req:

ncview
------
The `ncview <http://meteora.ucsd.edu/~pierce/ncview_home_page.html>`_
program is a netCDF file viewer. While it does not produce
publication-quality output, ncview can let you easily examine the
contents of a netCDF data file (such as those which are input and
output by GEOS-Chem). Ncview is very useful for debugging and development.

.. _nco-req:

nco
---
`The netCDF operators (nco)
<http://meteora.ucsd.edu/~pierce/ncview_home_page.html>`_ are
powerful command-line tools for editing and manipulating data in
netCDF format.

**Best way to install:**  :ref:`With Spack
<build-libraries-for-geos-chem-with-spack>`.

.. _cdo-req:

cdo
---
`The Climate Data Operators (cdo)
<https://code.mpimet.mpg.de/projects/cdo/l>`_ are powerful
command-line utilities for editing and manipulating data in netCDF
format.

**Best way to install:** :ref:`With Spack
<build-libraries-for-geos-chem-with-spack>`.

.. _kpp-req:

KPP
---
`The Kinetic PreProcessor (KPP) <https://kpp.readthedocs.io>`_
translates a chemical mechanism specification from user-configurable
input files to Fortran-90 source code.  You will need to use
:program:`KPP` if you plan on updating any of the chemical mechanisms
that ship with GEOS-Chem.

**Best way to install:**  `Clone from github.com/KineticPreProcessor/KPP
<https://github.com/KineticPreProcessor/KPP>`_.

.. _flex-req:

flex
----
`Flex <https://github.com/westes/flex>`_ is the Fast Lexical
Analyzer. :program:`KPP` requires :program:`flex` to parse the
chemical mechanism input files.

**Best way to install:** :ref:`With Spack
<build-libraries-for-geos-chem-with-spack>`.
