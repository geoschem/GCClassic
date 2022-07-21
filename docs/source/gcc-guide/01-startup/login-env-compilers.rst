.. _env-iles-envvars-compilers:

#######################################
Set environment variables for compilers
#######################################

The sample :ref:`GNU <env-files-gnu10>` and :ref:`Intel
<env-files-intel19>` environment ffiles from the previous sections
define the following **environment variables** to specify the choice
of compiler:

.. table::
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

The commands used to define :envvar:`CC`, :envvar:`CXX`, and
:envvar:`FC` are:

.. code-block:: bash

   # for GNU
   export CC=gcc
   export CXX=g++
   export FC=gfortran

or

.. code-block:: bash

   # for Intel
   export CC=icc
   export CXX=icpc
   export FC=ifort

.. note::

   Only the Fortran compiler is needed to compile :program:`GEOS-Chem
   Classic`.  But if you will be building other software packages (cf
   :ref:`kppguide`), or :ref:`manually installing libraries
   <build-libraries-with-spack>`, you will also need the C and C++
   compilers.
