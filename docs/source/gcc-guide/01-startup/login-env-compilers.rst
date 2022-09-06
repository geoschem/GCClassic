.. _env-iles-envvars-compilers:

#######################################
Set environment variables for compilers
#######################################

The sample :ref:`GNU <env-files-gnu10>` and :ref:`Intel
<env-files-intel19>` environment files set the **environment
variables** listed below in order to select the desired C, C++, and
Fortran compilers:

.. note::

   GEOS-Chem Classic only requires the Fortran compiler.  But you will
   also need the C and C++ compilers if you plan to build other
   software packages (:ref:`such as KPP <kppguide>`) or :ref:`install
   libraries manually <build-libraries-with-spack>`.

.. table:: Environment variables that specify compilers
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

