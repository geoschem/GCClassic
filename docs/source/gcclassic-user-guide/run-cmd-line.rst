.. |br| raw:: html

   <br/>

.. _run-cmd-line:

=======================================
Or run the script from the command line
=======================================

If your computer system does not use a scheduler, or if you are logged
into an Amazon Web Services (AWS) cloud instance, then you can run
GEOS-Chem Classic directly from the terminal command line.

Here is a sample run script for interactive use
(:file:`geoschem-int.sh`).   It is similar to the
:ref:`run script shown previously <run-script>`, with a few edits:

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

   If you are logged into an AWS cloud instance, you can add 

   .. code-block:: bash

      export OMP_NUM_THREADS=`ncpus`

   to the run script.  This will automatically set
   :option:`OMP_NUM_THREADS` to the available number of cores.

To run GEOS-Chem interactively, type:

.. code-block:: console

   $ ./geoschem.run > GC.log 2>&1 &

This will run the job in the background.  To monitor the progress of
the job you can type:

.. code-block:: console

   $ tail -f GC.log

which will show the contents of the log file as they are being written.

Another way to view output from GEOS-Chem in real time is to use the
:command:`tee` command .  This will print output to the screen and
also send the same output to a log file.  Type:

.. code-block:: console

   $ ./geoschem.run | tee GC.log		
