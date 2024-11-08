.. _env-files-gnu:

################################################
Sample environment file for GNU 12.2.0 compilers
################################################

Below is a sample environment file (based on an enviroment file for
the Harvard Cannon computer cluster).  This file will load software
libraries built with the `GNU 12.2.0 compilers
<https://gcc.gnu.org/onlinedocs/12.2.0/>`_.

.. note::

   This environment file shown below assumes that required software
   packages for :program:`GEOS-Chem Classic` are available as
   pre-built modules.  If your computer system does not have these
   packages pre-installed, you can build them with Spack.  Please see
   our :ref:`spackguide` supplemental guide for detailed instructions.

Save the code below (with any appropriate modifications for your own
computer system) to a file named :file:`~/gcclassic.gnu12.env`.

.. code-block:: bash

   ###############################################################################
   #
   # Environment file for GCClassic + GNU Compiler Collection 12.2.0
   #
   ###############################################################################

   # Display message (if we are in a terminal window)
   if [[ $- = *i* ]] ; then
     echo "Loading modules for GEOS-Chem Classic, please wait ..."
   fi

   #==============================================================================
   # Unload all previously-unloaded software
   #==============================================================================

   # Unload packages loaded with "module load"
   module purge

   #==============================================================================
   # Load software packages for GNU 12.2.0
   #==============================================================================
   if [[ $- = *i* ]] ; then
     echo "... Loading FASRC-built software, please wait ..."
   fi

   # Pre-built modules needed for GEOS-Chem
   # (NOTE: These may be named differently on your system)
   module load gcc/12.2.0-fasrc01             # gcc / g++ / gfortran
   module load openmpi/4.1.4-fasrc01          # MPI
   module load netcdf-c/4.9.2-fasrc01         # netcdf-c
   module load netcdf-fortran/4.6.0-fasrc02   # netcdf-fortran
   module load flex/2.6.4-fasrc01             # Flex lexer (needed for KPP)
   module load cmake/3.25.2-fasrc01           # CMake (needed to compile)

   #==============================================================================
   # Environment variables and related settings
   # (NOTE: Lmod will define <module>_HOME variables for each loaded module)
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
   export CC="gcc"
   export CXX="g++"
   export FC="gfortran"
   export F77="${FC}"

   # netCDF
   if [[ "x${NETCDF_HOME}" == "x" ]]; then
       export NETCDF_HOME="${NETCDF_C_HOME}"
   fi
   export NETCDF_C_ROOT="${NETCDF_HOME}"
   export NETCDF_FORTRAN_ROOT=${NETCDF_FORTRAN_HOME}

   # KPP 3.0.0+
   export KPP_FLEX_LIB_DIR=${FLEX_HOME}/lib64

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

   echo ""
   echo "Environment:"
   echo ""
   echo "CC                  : ${CC}"
   echo "CXX                 : ${CXX}"
   echo "FC                  : ${FC}"
   echo "KPP_FLEX_LIB_DIR    : ${KPP_FLEX_LIB_DIR}"
   echo "MPI_HOME            : ${MPI_HOME}"
   echo "NETCDF_HOME         : ${NETCDF_HOME}"
   echo "NETCDF_FORTRAN_HOME : ${NETCDF_FORTRAN_HOME}"
   echo "OMP_NUM_THREADS     : ${OMP_NUM_THREADS}"
   echo ""
   echo "Done sourcing ${BASH_SOURCE[0]}"

To activate the settings contained in the environment file, type:

.. code-block:: console

   $ . ~/gcclassic.gnu12.env

You may also place the above command within your :ref:`GEOS-Chem run script
<run-script>`, which will be discussed in a subsequent chapter.
