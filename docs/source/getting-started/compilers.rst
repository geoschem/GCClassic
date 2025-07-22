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

Older compiler versions than these may either be incompatible with
GEOS-Chem, or may cause unexpected results.  We hope to be able to
port GEOS-Chem to the latest Intel 2024 compiler suite (:literal:`icx`
for C, C++ and :literal:`ifx` for Fortran) in the near future.

**Best way to install:**  `Direct from Intel
<https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/fortran-compiler.html>`_
(Older versions may require purchase of a site license or a student license)

.. tip::

   Intel 2021 and later may be obtained for free, or installed with a
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

While all Linux distributions ship with a pre-installed version of
GCC, we recommend that you use GCC 10 or later.  Older GCC versions
may have trouble parsing certain GEOS-Chem source code.

.. attention::

   If you plan to build :ref:`required software libraries <req-soft>`
   with Spack, please use `Spack release v0.23.1
   <https://github.com/spack/spack/releases/tag/v0.23.1>`_ until
   further notice.  For more information, please see the section
   entitled :ref:`gc-known-bugs-gcc12` at our :ref:`gc-known-bugs`
   reference page.

**Best way to install:**  :ref:`With Spack <spackguide>`.


.. _req-soft-compilers-other:

===============
Other compilers
===============

We currently have no plans to port GEOS-Chem to compilers
other than :ref:`req-soft-compilers-intel` and
:ref:`req-soft-compilers-gnu`. But when we interface
GEOS-Chem into external models (such as `CESM
<https://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_in_CESM>`_);
all compilers used by the parent model can successfully parse
GEOS-Chem source code.
