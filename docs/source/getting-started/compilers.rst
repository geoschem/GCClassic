.. _req-soft-compilers:

###################
Supported compilers
###################

GEOS-Chem is written in the Fortran programming language. However, you
will also need C and C++ compilers to install certain libraries (like
:ref:`netCDF <ncguide>`) on your system.

.. _req-soft-compilers-intel:

=====
Intel
=====
The :program:`Intel Compiler Suite` is our recommended proprietary
compiler suite.

Intel compilers produce well-optimized code that runs extremely
efficiency on machines with Intel CPUs. Many universities and
institutions will have an Intel site license that allows you to use
these compilers.

The GCST has tested :program:`GEOS-Chem Classic` with these versions
(but others may work as well):

- 23.0.0
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

.. _req-soft-compilers-gnu:

===
GNU
===
The :program:`GNU Compiler Collection` (or :program:`GCC` for short)
is our recommended open-source compiler suite.

Because the GNU Compiler Collection is free and open source, this is a
good choice if your institution lacks an Intel site license, or if you
are running GEOS-Chem on the Amazon EC2 cloud environment.

The GCST has tested :program:`GEOS-Chem Classic` with these versions
(but others may work as well):

- 12.2.0
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

**Best way to install:**  :ref:`With Spack <spackguide>`.
