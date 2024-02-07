.. _env-iles-envvars-compilers:

#######################################
Set environment variables for compilers
#######################################

The sample :ref:`GNU <env-files-gnu10>` and :ref:`Intel
<env-files-intel19>` environment files set the **environment
variables** listed below in order to select the desired C, C++, and
Fortran compilers:

.. table:: Environment variables that specify compilers
   :align: center

   +---------------+------------------+--------------------+-----------------+
   | Variable      | Specifies the:   | GNU name           | Intel name      |
   +===============+==================+====================+=================+
   | :envvar:`CC`  | C compiler       | :envvar:`gcc`      | :envvar:`icx`   |
   +---------------+------------------+--------------------+-----------------+
   | :envvar:`CXX` | C++ compiler     | :envvar:`g++`      | :envvar:`icx`   |
   +---------------+------------------+--------------------+-----------------+
   | :envvar:`FC`  | Fortran compiler | :envvar:`gfortran` | :envvar:`ifort` |
   +---------------+------------------+--------------------+-----------------+

.. note::

   GEOS-Chem Classic only requires the Fortran compiler.  But you will
   also need the C and C++ compilers if you plan to build other
   software packages (:ref:`such as KPP <kppguide>`) or :ref:`install
   libraries manually <spackguide>`.

   Also, older  Intel compiler versions used :envvar:`icc` as the name
   for the C compiler and :envvar:`icpc` as the name of the C++ compiler.
   These names have been deprecated in Intel 2023 and will be removed
   from future Intel compiler releases.

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
   export CC=icx
   export CXX=icx
   export FC=ifort
