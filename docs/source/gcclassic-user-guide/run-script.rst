.. |br| raw:: html

   <br/>

.. _run-script:

###################
Create a run script
###################

We recommend that you create a **run script** for your GEOS-Chem
simulation.  This is a bash script containing the commands to run
GEOS-Chem.

A sample run script for the `Simple Linux Utility for Resource
Management (SLURM)
<https://slurm.schedmd.com/documentation.html>`_ is shown
below.  SLURM is a "scheduler"---a root-level program that decides
if there are sufficient resources (cores, memory, available time) for
a job to run.  If not, SLURM will delay starting the job until
resources free up.

.. note::

   If your computer system uses a different scheduler (e.g. LSF, PBS),
   simply replace the SLURM-specific commands with the equivalent
   commands for your scheduler.  Ask your sysadmin or IT staff for
   more information.

.. code-block:: bash

   #!/bin/bash

   #SBATCH -c 8
   #SBATCH -N 1
   #SBATCH -t 0-12:00
   #SBATCH -p PARTITION
   #SBATCH --mem=15000
   #SBATCH --mail-type=END

   ###############################################################################
   ### Sample GEOS-Chem Classic run script (using SLURM).
   ###
   ### If you are running a nested-grid simulation at fine resolution, you
   ### will likely need to request additional memory, cores, and time.
   ###
   ### -c           : Requests this many cores
   ### -N           : Requests a single node
   ### --mem        : Requests this amount of memory in GB
   ### -p           : Requests these partitions where the job can run
   ### -t           : Requests time for the job (days-hours:minutes)
   ###  --exclusive : Reserves entire nodes (i.e. to prevent backfilling jobs)
   ###############################################################################

   # Source the environment file you have created for your system
   source /path/to/gcclassic.gnu10.env

   # Set the proper # of threads for OpenMP
   # SLURM_CPUS_PER_TASK ensures this matches the number you set with -c above
   export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

   # Run GEOS_Chem.  The "time" command will return CPU and wall times.
   # Stdout and stderr will be directed to the "GC.log" log file
   # (you can change the log file name below if you wish)
   srun -c $OMP_NUM_THREADS time -p ./gcclassic >> GC.log

   # Exit normally
   exit 0


Important commands in the run script are listed below:

.. option:: #SBATCH -c 8

   Tells SLURM to request 8 computational cores.  You may choose a
   different number of cores depending on the type of node you are
   using.  Most modern computer clusters have nodes with up to 64 (or
   more) cores.

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

.. option:: #SBATCH -p PARTITION

   Tells SLURM to run GEOS-Chem Classic in the computational partition
   (aka "queue") named :code:`PARTITION`.  Ask your IT staff for a
   list of the available partitions (queues) on your system.

   .. note::

      With SLURM, you may specify more than one partition with:

      .. code-block:: bash

         #SBATCH -p PARTITION1,PARTITION2,PARTITION3,...

      Your job will run on whichever partition first has sufficient
      resources.

      If you have different scheduler on your system, ask your
      sysadmin or IT staff if your scheduler allows you to specify
      multiple partitions when submitting jobs.

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

.. option:: time -p ./gcclassic > GC.log 2>&1

   Executes the GEOS-Chem Classic executable and pipes the output
   (both stdout and stderr streams) to a file named :file:`GC.log`.

   The :code:`time -p` command will print the amount of time (both CPU
   time and wall time) that the simulation took to complete to the end
   of :file:`GC.log`.

The following commands should already be present in your environment
file.  Otherwise, add these to the run script before the command to
the :file:`gcclassic` executable.

.. option:: ulimit -s unlimited

   Tells the bash shell to remove any restrictions on stack memory.
   This is the place in GEOS-Chem's memory where temporary variables
   (including :ref:`PRIVATE variables for OpenMP parallel loops
   <parallel-guide-faq-private>`) get created.

.. option:: export OMP_STACKSIZE=500m

   Tells the GEOS_Chem executable to use as much memory as it needs
   for allocating :ref:`PRIVATE variables in OpenMP parallel loops
   <parallel-guide-faq-private>`.

.. option:: srun -c $OMP_NUM_THREADS

   Tells SLURM to run the GEOS-Chem Classic executable using the
   number of cores specified in :option:`OMP_NUM_THREADS`.
