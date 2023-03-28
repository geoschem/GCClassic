.. _req-soft-req:

##########################
Required software packages
##########################

.. _req-soft-git:

===
Git
===
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

.. _req-soft-cmake:

=====
CMake
=====
`CMake <https://cmake.org/>`_ is software that directs how the
GEOS-Chem source code is compiled into an executable.  You will need
:program:`CMake` version 3.13 or later to build GEOS-Chem Classic.

**Best way to install:**  :ref:`With Spack
<build-libraries-with-spack>`.

.. _rec-soft-make:

========
GNU Make
========
:program:`GNU Make` is software that can build executables from
Makefiles that are created by :ref:`req-soft-cmake`.



While GNU Make is not required for GEOS-Chem 13.0.0 and later, some
external libraries that you might need to build will require GNU
Make. Therefore it is best to download GNU Make along with CMake.

**Best way to install:**  :ref:`With Spack
<build-libraries-with-spack>`.

.. _req-soft-netcdf:

======
netCDF
======

GEOS-Chem input and output data files use the netCDF file format
(cf. :ref:`netCDF <ncguide>`). NetCDF is a self-describing file format
that allows meadata (descriptive text) to be stored alongside data
values.

**Best way to install:**  :ref:`With Spack
<build-libraries-with-spack>`.
