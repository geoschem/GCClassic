.. |br| raw:: html

   <br/>

.. _running-gc:

#########################
Running GEOS-Chem Classic
#########################

This page presents the basic information needed to run GEOS-Chem as well
as how to verify a successful run and reuse a run directory.

.. _important-things:

===================================================
Important things to know before you submit your run
===================================================

#. Please be aware of :ref:`several options for speeding up your
   GEOS-Chem simulation <speeding-up-simulations>`. |br|
   |br|

#. The initial :ref:`restart file that is included with your run
   directory <restart-files>` does not reflect the actual
   atmospheric state and should only be used to "spin-up" the
   model. We recommend a spin-up period of 6 months to 1 year
   (depending on the type of simulation you are using). |br|
   |br|

#. Prior to running with :option:`GEOS-FP` met fields, please be aware
   of several caveats regarding that data stream. (cf. `The GEOS-FP
   wiki page <http://wiki.geos-chem.org./GEOS-FP>`_).

.. _pre-run-checklist:

=================
Pre-run checklist
=================

You can use this checklist to make sure that you have completed all of
the required steps for running GEOS-Chem Classic:

.. _one-time-setup:

First-time setup
-----------------

#. Make sure that your computational environment meets all of the
   :ref:`hardware <hardware-requirements>` and
   :ref:`software <software-requirements>` for GEOS-Chem Classic. |br|
   |br|

#. Make sure that you have :ref:`properly configured your
   login environment <config-overview>`.

.. _each-time-setup:

Each-time setup
----------------

#. Create a :ref:`GEOS-Chem Classic run directory <create-rundir>`,
   and make sure that it is correct for the simulation you wish to
   perform. |br|
   |br|

#. :ref:`Configure your GEOS-Chem Classic <config-overview>`
   simulation by editing the settings in these files:

   - :ref:`geoschem_config.yml <geoschem-config>`
   - :ref:`HEMCO_Config.rc <hemco-config>`
   - :ref:`HEMCO_Diagn.rc <hemco-diagn>`
   - :ref:`HISTORY.rc <history>` |br|
     |br|

#. :ref:`Configure and build <compiling-geos-chem>` the GEOS-Chem
   source code. |br|
   |br|

#. Copy a sample :ref:`GEOS-Chem Classic run script <gc-run-script>` to
   your run directory. |br|
   |br|

#. Make sure that your run script contains the proper settings for
   :ref:`OpenMP parallelization <specifying-parallelization-settings>`.

.. _gc-run-script:

=========================
The GEOS-Chem run script
=========================

A sample GEOS-Chem run script is provided for you in the GEOS-Chem
Classic :ref:`run directory <create-rundir>`.  You can edit this
script as necessary for your own computational system.

Navigate to your run directory.  Then copy the
:file:`runScriptSamples/geoschem.run` sample run script into the run directory:

.. code-block:: console

   cp ./runScriptSamples/geoschem.run .

The :file:`geoschem.run` script looks like this:

.. code-block:: bash

   #!/bin/bash

   #SBATCH -c 8
   #SBATCH -N 1
   #SBATCH -t 0-12:00
   #SBATCH -p MYQUEUE
   #SBATCH --mem=15000
   #SBATCH --mail-type=END

   ###############################################################################
   ### Sample GEOS-Chem run script for SLURM
   ### You can increase the number of cores with -c and memory with --mem,
   ### particularly if you are running at very fine resolution (e.g. nested-grid)
   ###############################################################################

   # Set the proper # of threads for OpenMP
   # SLURM_CPUS_PER_TASK ensures this matches the number you set with -c above
   export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

   # Run GEOS-Chem.  The "time" command will return CPU and wall times.
   # Stdout and stderr will be directed to the "GC.log" log file
   # (you can change the log file name below if you wish)
   srun -c $OMP_NUM_THREADS time -p ./gcclassic > GC.log 2>&1

   # Exit normally
   exit 0

The sample run script contains commands for the `SLURM scheduler
<https://slurm.schedmd.com/documentation.html>`_, which is used on
many HPC sytems.

.. note::

   If your computer system uses a different scheduler (such as LSF or
   PBS), then you can replace the SLURM-specific commands with
   commands for your scheduler.  Ask your IT staff for more
   information.

Important commands in the run script are listed below:

.. option:: #SBATCH -c 8

   Tells SLURM to request 8 computational cores.

.. option:: #SBATCH -N 1

   Tells SLURM to request 1 computational node.

   .. important::

      GEOS-Chem Classic uses `OpenMP
      <https://wiki.geos-chem.org/Parallelizing_GEOS-Chem>`_, which is
      a  shared-memory parallelization model.  Using OpenMP limits
      GEOS-Chem Classic to one computational node.

.. option:: #SBATCH -t 0-12:00

   Tells SLURM to request 12 hours of computational time.  The format
   is :code:`D-hh:mm` or (:code:`days-hours:minutes`).

.. option:: #SBATCH -p MYQUEUE

   Tells SLURM to run GEOS-Chem Classic in the computational partition
   named :code:`MYQUEUE`.  Ask your IT staff for a list of the
   available partitions on your system.

.. option:: #SBATCH --mem=15000

   Tells SLURM to reserve 15000 MB (15 GB) of memory for the
   simulation.

.. option:: #SBATCH --mail-type=END

   Tells SLURM to send an email upon completion (successful or
   unsuccesful) of the simulation.

.. option:: export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

   Specifies how many computational cores that GEOS-Chem Classic
   should use.  The environment variable :envvar:`SLURM_CPUS_PER_TASK`
   will fill in the number of cores requested
   (in this example, we used :code:`#SBATCH -c 8`, which requests 8
   cores).

.. option:: srun -c $OMP_NUM_THREADS

   Tells SLURM to run the GEOS-Chem Classic executable using the
   number of cores specified in :option:`OMP_NUM_THREADS`.

.. option:: time -p ./gcclassic > GC.log 2>&1

   Executes the GEOS-Chem Classic executable and pipes the output
   (both stdout and stderr streams) to a file named :file:`GC.log`.

   The :code:`time -p` command will print the amount of time (both CPU
   time and wall time) that the simulation took to complete to the end
   of :file:`GC.log`.

.. _running-gc-batch:

Running GEOS-Chem as a batch job
--------------------------------
To submit a GEOS-Chem Classic simulation to a computational cluster
that uses the SLURM scheduler, type the following command:

.. code-block:: console

   sbatch geoschem.run

This will submit your job to the SLURM scheduler.  Your job may remain
pending in the queue for a time if there is high demand on your cluster.

If your computer system uses a different scheduler, please refer to
your local system documentation (or ask your IT staff) for the proper
command to submit batch jobs.

.. _running-gc-interactive:

Running GEOS-Chem interactively
-------------------------------

If your computer system does not use a scheduler, or if you are logged
into an Amazon Web Services (AWS) cloud instance, then you can run
GEOS-Chem Classic as an interactive job.

Here is a sample run script for interactive use
(:file:`geoschem-int.sh`).   It is similar to the
:ref:`run script shown above <gc-run-script>`, with a few edits:

.. code-block:: bash

   #!/bin/bash

   ###############################################################################
   ### Sample GEOS-Chem run script for interactive use
   ###############################################################################

   # Set the proper # of threads for OpenMP
   export OMP_NUM_THREADS=8

   # Run GEOS-Chem.  The "time" command will return CPU and wall times.
   # Stdout and stderr will be directed to the "GC.log" log file
   # (you can change the log file name below if you wish)
   time -p ./gcclassic > GC.log 2>&1

   # Exit normally
   exit 0

The modifications entail:

#. Removing the SLURM-specific commands (i.e. :code:`#SBATCH`,
   :code:`$SLURM_CPUS__PER_TASK`, and :code:`srun`). |br|
   |br|

#. Manually specifying the number of cores that you wish GEOS-Chem to
   use (:code:`export $OMP_NUM_THREADS=8`).

.. note::

   If you are logged into an AWS cloud instance, you can use:

   .. code-block:: bash

      export OMP_NUM_THREADS=`ncpus`

   which will automatically fill in the number of available cores.

To run GEOS-Chem interactively, type:

.. code-block:: console

   $ ./geoschem.run &

This will run the job in the background.  To monitor the progress of
the job you can type:

.. code-block:: console

   tail -f GC.log

which will show the contents of the log file as they are being written.

.. _verifying-a-successful-run:

==========================
Verifying a Successful Run
==========================

There are several ways to verify that your GEOS-Chem Classic run was
successful:

#. The following output can be found at the end of the log file:

   .. code-block:: console

      **************   E N D   O F   G E O S -- C H E M   **************

#. NetCDF files (e.g. :file:`OutputDir/GEOSChem*.nc4` and
   :file:`OutputDir/HEMCO*.nc`) are present. |br|
   |br|

#. :ref:`restart-files`
   (e.g. :file:`GEOSChem.Restart.YYYYMMDD_hhmmz.nc4` and
   :file:`HEMCO_restart.YYYYMMDDhh.nc`) for ending date
   :code:`YYYYMMDD hhmm` are present. |br|
   |br|

#. Your scheduler log file (e.g. :file:`slurm-xxxxx.out`, where
   :code:`xxxxx` is the job id) is free of errors.

If your run stopped with an error, please the following resources:

-  `Guide to GEOS-Chem error
   messages <Guide_to_GEOS-Chem_error_messages>`__
-  `Tips on how to debug GEOS-Chem
   effectively <GEOS-Chem_coding_and_debugging#GEOS-Chem_debugging_tips>`__
-  `Submitting GEOS-Chem support
   requests <Submitting_GEOS-Chem_support_requests>`__

.. _minimizing-differences:

====================================================
Minimizing differences when splitting up simulations
====================================================

Often, users will split long simulations into several smaller
simulations to stay within their cluster's computational limits. When
doing so, make sure you follow these guidelines to minimize differences
in model output:

#. Make sure :code:`GC_RESTART` and :code:`HEMCO_RESTART` options are
   set to :code:`true:` in :ref:`HEMCO_Config.rc <hemco-config>`. |br|
   |br|

#. To ensure your :ref:`restart_files <restart-files>` are read and
   species concentrations are properly initialized, you may check your
   GEOS-Chem log file for the following output:

   .. code-block:: console

      ===============================================================================
      R E S T A R T   F I L E   I N P U T
      Min and Max of each species in restart file [mol/mol]:``
      Species   1,       NO: Min = 1.000000003E-30  Max = 1.560991691E-08
      Species   2,       O3: Min = 3.135925075E-09  Max = 9.816152669E-06
      Species   3,      PAN: Min = 3.435056848E-25  Max = 1.222619450E-09
      ...

   Actual values may differ. If you see :code:`Use background = ...` for
   most or all species, that suggests your restart file was not found. To
   avoid using the wrong restart file make sure to use time cycle flag
   :code:`EY` in HEMCO_Config.rc (cf. :ref:`restart-file-input`).

.. _speeding-up-simulations:

=========================================
Speeding up GEOS-Chem Classic simulations
=========================================

GEOS-Chem Classic performance is continuously monitored by the
`GEOS-Chem Support Team
<http://wiki.geos-chem.org/GEOS-Chem_Support_Team>`_ by means of
benchmark simulations and ad-hoc timing tests. It has been shown that
running GEOS-Chem with
`recommended timesteps
<https://wiki.geos-chem.org/Centralized_chemistry_time_step#Optimal_Configuration>`_
from
`Philip et al. (2016)
<https://gmd.copernicus.org/articles/9/1683/2016/gmd-9-1683-2016.html>`_
can increase run times by approximately a factor of 2.  To speed up
GEOS-Chem Classic simulations, users may choose to use any of the
following options.

.. _use-coarser-timesteps:

Use coarser timesteps
---------------------

As :ref:`discussed previously <gc-yml-timesteps>`, the default
timesteps for GEOS-Chem Classic are 600 seconds for dynamics, and 1200
seconds for chemistry and emissions.  You can experiment with using
coarser timesteps (such as 1800 seconds for dynamics and 3600 seconds
for emissions & chemistry).

.. attention::

   For nested-grid simulations, you might not be able to use coarser
   timesteps, or else the Courant limit in transport will be violated.

.. _turn-off-diagnostics:

Turn off unwanted diagnostics
-----------------------------

Several diagnostics are turned on by default in :ref:`the HISTORY.rc
<history>` configuration file.  The more diagnostics that are turned
on, the more I/O operations need to be done, resulting in longer
simulation execution times.  Disabling diagnostics that you do not
wish to archive can result in a faster simulation.

.. _disable-debug-options:

Disable debugging options when building GEOS-Chem
-------------------------------------------------

If you previously configured GEOS-Chem with the :
:option:`CMAKE_BUILD_TYPE` option set to :envvar:`Debug`, then several
run-time debugging checks will be activated.  These include:

- Checking for array-out-of-bounds errors
- Checking for floating-point math exceptions (e.g. div-by-zero)
- Disabling compiler optimizations

These options can be useful in detecting errors in your GEOS-Chem
Classic simulation, but result in a much slower simulation.  If you
plan on running a long Classic simulation, make sure that
you :ref:`configure and build GEOS-Chem Classic <compile-geos-chem>`
so that :option:`CMAKE_BUILD_TYPE` is set to :envvar:`Release`.

.. _further_reading:

===============
Further reading
===============

#. `SLURM manual <https://slurm.schedmd.com/documentation.html>`__
#. `LSF user manual
   (LLNL) <https://hpc.llnl.gov/banks-jobs/running-jobs/lsf-user-manual>`__
#. `Learn to use PBS Pro job scheduler
   (LearnScientificProgramming.io) <https://learn.scientificprogramming.io/learn-to-use-pbs-pro-job-scheduler-ffd9c0ad680d>`__
#. `Guide to GEOS-Chem performance <Guide_to_GEOS-Chem_performance>`__
