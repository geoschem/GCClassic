.. _req-hard-system:

###############
Computer system
###############

You will need to have access to one (or both) of these types of
computational resources in order to use GEOS-Chem Classic:

.. _req-hard-system-unix:

A Unix-like computer system
---------------------------

GEOS-Chem Classic can only be used on computers with operating systems
that are **Unix-like**.  This includes all flavors of Linux
(e.g. Ubuntu, Fedora, Red-Hat, Rocky Linux, Alma Linux, etc) and BSD
Unix (including MacOS X, which is a BSD derivative).

If your institution has computational resources (e.g. a shared
computer cluster with many cores, sufficient :ref:`disk storage
<req-hard-disk>` and :ref:`memory <req-hard-mem>`),  then you can run
GEOS-Chem Classic there. Contact your sysadmin or IT support staff for
assistance.

.. _req-hard-system-cloud:

An account on the Amazon Web Services cloud
--------------------------------------------

If your institution lacks computational resources (or if you need
additional computational resources), then you should consider signing
up for access to the Amazon Web Services cloud. Using the cloud has
the following advantages:

- You can run GEOS-Chem without having to invest in local hardware and maintenance personnel.
- You won't have to download any meteorological fields or emissions data. All of the necessary data input for GEOS-Chem will be available on the cloud.
- You can initialize your computational environment with all of the required software (e.g. compilers, libraries, utilities) that you need for GEOS-Chem.
- Your GEOS-Chem runs will be 100% reproducible, because you will initialize your computational environment the same way every time.
- You will avoid GEOS-Chem compilation errors due to library incompatibilities.
- You will be charged for the computational time that you use, and if you download data off the cloud.

You can learn more about how to use GEOS-Chem on the cloud by `visiting this tutorial (cloud.geos-chem.org) <http://cloud.geos-chem.org>`_.
