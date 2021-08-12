.. _sample-geos-chem-run-scripts:

Sample GEOS-Chem run scripts
============================

Here are some sample run scripts that you can adapt for your own purposes.

.. _run-script-for-slurm-scheduler:

Run script for SLURM scheduler
------------------------------

Here is a sample GEOS-Chem run script for computational clusters that
use the SLURM batch scheduler.

.. tip:: Use the ``SLURM_CPUS_PER_TASK`` environment variable to make
	 sure that GEOS-Chem uses all of the cores that you have requested.

.. code-block:: bash

    #!/bin/bash

    #SBATCH -c 24
    #SBATCH -N 1
    #SBATCH -t 0-12:00
    #SBATCH -p my-queue_name
    #SBATCH --mem=30000
    #SBATCH --mail-type=END

    ###############################################################################
    ### Sample GEOS-Chem run script for SLURM
    ### You can increase the number of cores with -c and memory with --mem,
    ### particularly if you are running at very fine resolution (e.g. nested-grid)
    ###############################################################################

    # Load your environment settings and software modules
    source ~/.bashrc
    source ~/gcclassic.env

    # Set the proper # of threads for OpenMP
    # SLURM_CPUS_PER_TASK ensures this matches the number you set with -c above
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

    # Run GEOS_Chem.  The "time" command will return CPU and wall times.
    # Stdout and stderr will be directed to the "GC.log" log file
    # (you can change the log file name below if you wish)
    srun -c $OMP_NUM_THREADS time -p ./gcclassic >> GC.log

.. important:: If you forget to define ``OMP_NUM_THREADS`` in your Unix
               environment and/or run scripts, then GEOS-Chem will only execute using
	       one core. This can cause GEOS-Chem to execute much more slowly than
	       intended.

.. _run-script-for-the-amazon-web-services-cloud:

Run script for the Amazon Web Services cloud
--------------------------------------------

When you log into an Amazon Web Services cloud instance, you will
receive an entire node with as many **vCPUs** as you have requested. A
vCPU is equivalent to the number of computational cores. Most cloud
instances have twice as many vCPUs as physical CPUs (i.e. each CPU chip
has 2 cores).

.. tip:: To find out how many vCPUs are available in your instance,
	 you can use then ``nproc`` command. The ``nproc`` command can
	 also be embedded in your shell startup scripts such as
	 (``.bashrc`` or ``.bash_aliases``), as well as into your
	 GEOS-Chem run script.

Here is a sample run script for GEOS-Chem on the AWS cloud:

.. code-block:: bash

    #!/bin/bash

    ###############################################################################
    ### Sample GEOS-Chem run script on AWS
    ###############################################################################

    # Load your environment settings
    source ~/.bashrc

    # In an AWS cloud instance, you own the entire node, so there is no need
    # to use a scheduler like SLURM.  You can just use the `nproc` command
    # to specify the number of cores that GEOS-Chem should use.
    export OMP_NUM_THREADS=$(nproc)

    # Run GEOS_Chem.  The "time" command will return CPU and wall times.
    # Stdout and stderr will be directed to the "GC.log" log file
    # (you can change the log file name below if you wish)
    time -p ./gcclassic >> GC.log 2>&1
