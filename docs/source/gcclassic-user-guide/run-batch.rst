.. _run-batch:

#####################################
Submit your run script to a scheduler
#####################################

Many shared computer systems use a **scheduler** to determine in
which order submitted jobs will run.

If your computer system uses the `SLURM scheduler
<https://slurm.schedmd.com/documentation.html>`_, then you can use the
following command to submit your GEOS-Chem Classic :ref:`run script
<run-script>` to a computational queue:

.. code-block:: console

   sbatch geoschem.run

The SLURM scheduler will then decide when your job starts based on
paramaters such as current load on the system and past cluster usage
(sometimes known as **fairshare**).   If there is high demand on the
cluster, your job may remain in **pending state** for a few hours (or
sometimes days!) before it starts.

If your computer system uses a different scheduler (e.g. `LSF
<https://hpc.llnl.gov/banks-jobs/running-jobs/lsf-user-manual>`_,
`PBS
<https://learn.scientificprogramming.io/learn-to-use-pbs-pro-job-scheduler-ffd9c0ad680d>`_,
etc.) then ask your sysadmin or IT staff about the commands that are
needed to submit jobs.
