.. |br| raw:: html

   <br/>

.. _env-files-envvars-parallel:

#############################################
Set environment variables for parallelization
#############################################

:program:`GEOS-Chem Classic` uses `OpenMP parallelization
<Parallelizing_GEOS-Chem>`_, which is an implementation of
shared-memory (aka serial) parallelization.

.. important::

   OpenMP-parallelized programs (such as GEOS-Chem Classic) cannot
   execute on more than 1 computational node.  Most modern
   computational nodes typically contain  between 16 and 64
   cores. Therefore, :program:`GEOS-Chem Classic` simulations will
   not be able to take advantage of more cores than these.

   We recommend that you consider using `GCHP
   <https://gchp.readthedocs.io>`_ for more computationally-intensive
   simulations.

In the the sample environment files for :ref:`GNU <env-files-gnu>` and
:ref:`Intel <env-files-intel>`, we define the following **environment
varaiables** for OpenMP parallelization:

.. option:: OMP_NUM_THREADS

   The :envvar:`OMP_NUM_THREADS` environment variable sets the number of
   computational cores (aka threads) that you would like GEOS-Chem
   Classic to use.

   For example, the command below will tell :program:`GEOS-Chem Classic`
   to use 8 cores within parallel sections of code:

   .. code:: console

      $ export OMP_NUM_THREADS=8

   We recommend that you define :envvar:`OMP_NUM_THREADS` not only in your
   environment file, but also in your :ref:`GEOS-Chem run script
   <run-script>`.

.. option:: OMP_STACKSIZE

   In order to use :program:`GEOS-Chem Classic` with
   `OpenMP parallelization <Parallelizing_GEOS-Chem>`_, you must
   request the maximum amount of stack memory in your Unix environment.
   (The stack memory is where local automatic variables and temporary
   :envvar:`!$OMP PRIVATE` variables will be created.)

   Add the following lines to your system startup file
   (e.g. :file:`.bashrc`) and to your :ref:`GEOS-Chem run scripts
   <run-script>`:

   .. code-block:: bash

      ulimit -s unlimited
      export OMP_STACKSIZE=500m

   The :command:`ulimit -s unlimited` will tell the bash shell to use the
   maximum amount of stack memory that is available.

   The environment variable :envvar:`OMP_STACKSIZE` must also be set to a very
   large number. In this example, we are nominally requesting 500 MB of
   memory. But in practice, this will tell the GNU Fortran compiler to use
   the maximum amount of stack memory available on your system. The value
   **500m** is a good round number that is larger than the amount of stack
   memory on most computer clusters, but you can increase this if you wish.

.. _env-files-envvars-errors:

========================================================
Errors caused by incorrect environment variable settings
========================================================

Be on the lookout for these errors:

  #. If :option:`OMP_NUM_THREADS` is set to 1, then your
     simulation will execute using only one computational core.
     This will make your simulation take much longer than
     necessary. |br|
     |br|

  #. If :option:`OMP_STACKSIZE` environment variable is not included
     in your environment file (or if it is set to a very low value),
     you might encounter a :ref:`errguide-segfault-tpcore` error.  In
     this case, GEOS-Chem Classic "thinks" that it does not have
     enough memory to perform the simulation, even though sufficient
     memory may be present.
