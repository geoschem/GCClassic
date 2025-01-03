.. _dry-run:

#######################################
Download data with a dry-run simulation
#######################################

.. tip::

   If you are located at an institution with many other GEOS-Chem
   users, then the necessary input data might have already been
   downloaded and stored in a commmon directory on your system.  Ask
   your sysadmin or IT support staff.

   Please see our :ref:`data` chapter for other ways in which you can
   download the necessary input data for GEOS-Chem.

A :program:`dry-run` is a is a :program:`GEOS-Chem Classic` simulation
that steps through time, but does not perform computations or read
data files from disk. Instead, a dry-run simulation prints a list of
all data files that a regular GEOS-Chem simulation would have
read. The dry-run output also denotes whether each data file was found
on disk, or if it is missing. This output can be fed to a script which
will download the missing data files to your computer system.

You may generate dry-run output for any of the GEOS-Chem Classic
simulation types (:option:`fullchem`, :option:`carbon`,
:option:`TransportTracers`, etc.)

In the following chapters, you will learn how to you can download data
using the output from a dry-run simulation:

.. toctree::
   :maxdepth: 2

   dry-run-run.rst
   dry-run-download.rst
