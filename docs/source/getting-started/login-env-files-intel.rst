.. _env-files-intel19:

################################################
Sample environment file for Intel 2023 compilers
################################################

Below is a sample environment file (based on an enviroment file for
the Harvard Cannon computer cluster).  This file will load software
libraries built with the Intel 2023 compilers.

Add the code below (with the appropriate modifications for your
system) into a file named :file:`~/gcclassic.intel23.env`.

.. code-block:: bash

   #==============================================================================
   # Load software packages (EDIT AS NEEDED)
   #==============================================================================

   # Unload all modules first
   module purge

   # Load modules
   module load intel/23.0.0-fasrc01           # icc / i++ / gfortran
   module load intelmpi/2021.8.0-fasrc01      # MPI
   module load netcdf-fortran/4.6.0-fasrc03   # netCDF-Fortran
   module load flex/2.6.4-fasrc01             # Flex lexer (needed for KPP)
   module load cmake/3.25.2-fasrc01           # CMake (needed to compile)

   #==============================================================================
   # Environment variables and related settings
   # (NOTE: Lmod will define <module>_HOME variables for each loaded module
   #==============================================================================

   # Make all files world-readable by default
   umask 022

   # Set number of threads for OpenMP.  If running in a SLURM environment,
   # use the number of requested cores.  Otherwise use 8 cores for OpenMP.
   if [[ "x${SLURM_CPUS_PER_TASK}" == "x" ]]; then
       export OMP_NUM_THREADS=8
   else
       export OMP_NUM_THREADS="${SLURM_CPUS_PER_TASK}"
   fi

   # Max out the stacksize memory limit
   export OMP_STACKSIZE="500m"

   # Compilers
   export CC="icx"
   export CXX="icx"
   export FC="ifort"
   export F77="${FC}"

   # netCDF
   if [[ "x${NETCDF_HOME}" == "x" ]]; then
      export NETCDF_HOME="${NETCDF_C_HOME}"
   fi
   export NETCDF_C_ROOT="${NETCDF_HOME}"
   export NETCDF_FORTRAN_ROOT="${NETCDF_FORTRAN_HOME}"

   # KPP 3.0.0+
   export KPP_FLEX_LIB_DIR="${FLEX_HOME}/lib64"

   #==============================================================================
   # Set limits
   #==============================================================================

   ulimit -c unlimited   # coredumpsize
   ulimit -u 50000       # maxproc
   ulimit -v unlimited   # vmemoryuse
   ulimit -s unlimited   # stacksize

   #==============================================================================
   # Print information
   #==============================================================================

   module list

.. tip::

   Ask your sysadmin how to load software libraries.  If you
   are using your institution's computer cluster, then chances
   are there will be a software module system installed, with
   commands similar to those listed above.

Then you can activate these settings from the command line by typing:

.. code-block:: console

   $ . ~/gcclassic.intel23.env

You may also place the above command within your :ref:`GEOS-Chem run script
<run-script>`, which will be discussed in a subsequent chapter.
