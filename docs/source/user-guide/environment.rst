.. _configuring-your-computational-environment:

Configuring your computational environment
==========================================

After you have specified a compiler to use with GEOS-Chem, you must set
some `environment variables
<https://www.networkworld.com/article/3215965/all-you-need-to-know-about-unix-environment-variables.html>`_. These definitions can be placed in your **environment file**.

.. _environment-variables-for-compilers:

Environment variables for compilers
-----------------------------------

It is convention to use the following environment variable names for compilers:

.. table::

    +----------+------------------------------+
    | Variable | Description                  |
    +==========+==============================+
    | ``CC``   | Name of the C compiler       |
    +----------+------------------------------+
    | ``CXX``  | Name of the C++ compiler     |
    +----------+------------------------------+
    | ``FC``   | Name of the Fortran compiler |
    +----------+------------------------------+

In most cases, the Fortran, C, and C++ compilers are installed together
as a integrated package.  Using a command such as ``module load`` or
``spack load`` will make all three of these compilers available.

.. note:: If you are using GEOS-Chem Classic, you really only
	  need the Fortran compiler. But if you will be building other
	  software packages (such as :ref:`KPP-for-GEOS-Chem`), you
	  will need the C and/or C++ compilers.

.. _check-if-environment-variables-have-been-automatically-set:

Check if environment variables have been automatically set
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On many systems, especially those that use a module system to load
libraries, the ``FC``, ``CC``, and ``CXX`` will be set automatically
for you when you load the library.

The easiest way to check if these variables have been automatically
set is to print them to the screen:

.. code-block:: console

   $ echo $CC
   $ echo $CXX
   $ echo $FC

If these variables are not blank, you may skip ahead to
:ref:`Specifying parallelization settings <specifying-parallelization-settings>`.
Otherwise, continue to the next section.

.. _manually-defining-compiler-environment-variables:

Manually defining compiler environment variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the ``FC``, ``CC``, and ``CXX`` environment variables are all undefined,
then set them manually in your startup script (e.g. ``.bashrc``) as follows:

For the :ref:`Intel Compiler Suite <the-intel-compiler-suite>`

.. code-block:: bash

   export CC=icc
   export CXX=icpc
   export FC=ifort

For the :ref:`GNU Compiler Collection <the-gnu-compiler-collection>`

.. code-block:: bash

   export CC=gcc
   export CXX=g++
   export FC=gfortran

Then type:

.. code-block:: console

   $ source ~/.bashrc

to apply the changes.

.. _specifying-parallelization-settings:

Specifying parallelizaton settings
----------------------------------

GEOS-Chem "Classic" uses
`OpenMP parallelization <Parallelizing_GEOS-Chem>`_, which is an
implementation of shared-memory (aka serial) parallelization. Two 
environment variables control the OpenMP parallelization settings, as
defined below. 

.. _omp-num-threads:

OMP_NUM_THREADS
~~~~~~~~~~~~~~~

The ``OMP_NUM_THREADS`` environment variable sets the number of
computational cores (aka threads) that you would like GEOS-Chem to use.

The following commands will request that GEOS-Chem use 8 cores by
default:

.. code:: example

    $ export OMP_NUM_THREADS=8

You can of course change the number of cores from 8 to however many you
want your GEOS-Chem simulation to use.

.. important:: OpenMP-parallelized programs (such as GEOS-Chem
	       Classic) cannot execute on more than 1 computational node.

	       Most modern computational nodes typically contain
	       between 16 and 64 cores. Therefore, your GEOS-Chem
	       "Classic" simulations will not be able to take
	       advantage of more cores than these.
	       
	       We recommend that you consider using
	       `GCHP <https://gchp.readthedocs.io>`_ for more computationally-intensive simulations.

We recommend that you set ``OMP_NUM_THREADS`` not only in your
environment file, but in also each GEOS-Chem run script that you use.

.. _omp-stacksize:

OMP_STACKSIZE
~~~~~~~~~~~~~

In order to use GEOS-Chem "Classic" with
`OpenMP parallelization <Parallelizing_GEOS-Chem>`_, you must 
request the maximum amount of stack memory in your Unix environment. 
(The stack memory is where local automatic variables and temporary
``!$OMP PRIVATE`` variables will be created.) Add the following lines to
your system startup file and to your GEOS-Chem run scripts:

.. code-block:: bash

   ulimit -s unlimited
   export OMP_STACKSIZE=500m

The ``ulimit -s unlimited`` will tell the bash shell to use the
maximum amount of stack memory that is available.

The environment variable ``OMP_STACKSIZE`` must also be set to a very
large number. In this example, we are nominally requesting 500 MB of
memory. But in practice, this will tell the GNU Fortran compiler to use
the maximum amount of stack memory available on your system. The value
``500m`` is a good round number that is larger than the amount of stack
memory on most computer clusters, but you can increase this if you wish.

We recommend that you set ``OMP_STACKSIZE`` not only in your Bash startup
script, but in also each
:ref:\`GEOS-Chem run script <Sample GEOS-Chem run scripts>\` that you use.

.. _errors_caused_by_incorrect_settings:

Errors caused by incorrect settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. If the ``OMP_NUM_THREADS`` is set to 1, then your GEOS-Chem simulation
   will execute properly, but only use one computational core. This will
   make your simulation run much more slowly than intended.

2. If the ``OMP_STACKSIZE`` environment variable is not included in your
   startup script, or if it is set to a very low value, you might
   encounter a segmentation fault
   `segmentation fault error after the TPCORE transport module is initialized <Segmentation_faults#Segmentation_fault_encountered_after_TPCORE_initialization>`_.
   In this case, GEOS-Che  "thinks" that it does not have enough memory to
   perform the simulation, even though sufficient memory may be present.
   Including the ``OMP_STACKSIZE`` variable definition in your startup
   script as described above usually fixes this error.
