.. _runscript:

############################
Sample GEOS-Chem run scripts
############################

Here are some sample run scripts that you can adapt for your own purposes.

.. _runscript-slurm:

======================================
For clusters using the Slurm scheduler
======================================

Here is a sample GEOS-Chem run script for computational clusters that
use the SLURM scheduler to control jobs:

Run script for Slurm
--------------------

Save this code to a file named :file:`geoschem.run.slurm`:

.. code-block:: bash

    #!/bin/bash

    #SBATCH -c 24
    #SBATCH -N 1
    #SBATCH -t 0-12:00
    #SBATCH -p MYPARTITION
    #SBATCH --mem=30000
    #SBATCH --mail-type=END

    ###############################################################################
    ### Sample GEOS-Chem run script for SLURM
    ### You can increase the number of cores with -c and memory with --mem,
    ### particularly if you are running at very fine resolution (e.g. nested-grid)
    ###############################################################################
    # Source the environment file that you created
    source /path/to/gcclassic.gnu10.env

    # Set the proper # of threads for OpenMP
    # SLURM_CPUS_PER_TASK ensures this matches the number you set with -c above
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

    # NOTE: If the environment file does not max out the available
    # stack memory for GEOS-Chem, you may uncomment these lines here:
    #ulimit -s unlimited
    #export OMP_STACKSIZE=500m

    # Run GEOS_Chem.  The "time" command will return CPU and wall times.
    # Stdout and stderr will be directed to the "GC.log" log file
    # (you can change the log file name below if you wish)
    srun -c $OMP_NUM_THREADS time -p ./gcclassic >> GC.log

.. important::

   If you forget to define :envvar:`OMP_NUM_THREADS` in your run
   script, then :program:`GEOS-Chem Classic` will execute using one
   core.  This can cause your simulations to take much longer than is
   necessary!

Then make :file:`geoschem.run.slurm` executable:

.. code-block:: console
 
   $ chmod 755 geoschem.run.slurm

For more information about how Slurm is set up on your particular
cluster, ask your sysadmin.

Submitting jobs with Slurm
--------------------------

To schedule a :program:`GEOS-Chem Classic` job with Slurm, use this
command:

.. code-block:: console

   $ sbatch geoschem.run.slurm

.. _runscript-amazon:

===========================================
For Amazon Web Services EC2 cloud instances
===========================================

When you log into an Amazon Web Services EC2 instance, you will
receive an entire node with as many **vCPUs** as you have requested. A
vCPU is equivalent to the number of computational cores. Most cloud
instances have twice as many vCPUs as physical CPUs (i.e. each CPU chip
has 2 cores).

.. tip:: To find out how many vCPUs are available in your instance,
	 you can use then :command:`nproc` command.

Run script for Amazon EC2
-------------------------

Save the code below to a file named :file:`geoschem.run.aws`:

.. code-block:: bash

    #!/bin/bash

    ###############################################################################
    ### Sample GEOS-Chem run script for Amazon Web Services EC2 instances
    ###############################################################################

    # Load your bash-shell customizations
    source ~/.bashrc

    ### NOTE: We do not have to load an environment file
    ### because all libraries are contained in the Amazon
    ### Machine Image (AMI) used to initialize the instance.

    # In an AWS cloud instance, you own the entire node, so there is no need
    # to use a scheduler like SLURM.  You can just use the `nproc` command
    # to specify the number of cores that GEOS-Chem should use.
    export OMP_NUM_THREADS=$(nproc)

    # NOTE: If your `/.bashrc file does not max out the available
    # stack memory for GEOS-Chem, you may uncomment these lines here:
    #ulimit -s unlimited
    #export OMP_STACKSIZE=500m

    # Run GEOS_Chem.  The "time" command will return CPU and wall times.
    # Stdout and stderr will be directed to the "GC.log" log file
    # (you can change the log file name below if you wish)
    time -p ./gcclassic >> GC.log 2>&1

And then make the :file:`geoschem.run.aws` file executable:

.. code-block:: console

   $ chmod 755 geoschem.run.aws

Running jobs on AWS
-------------------

When you are on an AWS EC2 instance, you own the entire node, so it is
not necessary to use a scheduler.  You can run your GEOS-Chem job in
with this command:

.. code-block:: console

   $ ./geoschem.run.aws &

This will run your job in the background and send all output
(i.e. program output and error output) to :file:`log`.
