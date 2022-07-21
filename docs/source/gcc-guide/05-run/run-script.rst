.. |br| raw:: html

   <br/>

.. _run-script:

###################
Create a run script
###################

We recommend that you create a **run script** for your GEOS-Chem
simulation.  This is a bash script containing the commands to run
GEOS-Chem. 

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

