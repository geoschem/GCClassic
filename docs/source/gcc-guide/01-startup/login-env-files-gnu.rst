.. _env-files-gnu10:

################################################
Sample environment file for GNU 10.2.0 compilers
################################################

Below is a sample environment file from the Harvard Cannon computer
cluster.  This file will load software libraries built with the GNU
10.2.0 compilers.

Save the code below (with any appropriate modifications for your own
computer system) to a file named :file:`~/gcclassic.gnu102.env`.

.. code-block:: bash

   # Echo message if we are in a interactive (terminal) session
   if [[ $- = *i* ]] ; then
     echo "Loading modules for GEOS-Chem, please wait ..."
   fi

   #==============================================================================
   # Modules (specific to Cannon @ Harvard)
   #==============================================================================

   # Remove previously-loaded modules
   module purge

   # Load modules for GNU Compilers v10.2.0
   module load git/2.17.0-fasrc01
   module load gcc/10.2.0-fasrc01
   module load openmpi/4.1.0-fasrc01
   module load netcdf-fortran/4.5.3-fasrc03
   module load flex/2.6.4-fasrc01
   module load cmake/3.17.3-fasrc01

   #==============================================================================
   # Environment variables
   #==============================================================================

   # Parallelization settings for GEOS-Chem Classic
   export OMP_NUM_THREADS=8
   export OMP_STACKSIZE=500m

   # Make all files world-readable by default
   umask 022

   # Specify compilers
   export CC=gcc
   export CXX=g++
   export FC=gfortran

   # Netcdf variables for CMake
   # NETCDF_HOME and NETCDF_FORTRAN_HOME are automatically
   # defined by the "module load" commands on Cannon.
   export NETCDF_C_ROOT=${NETCDF_HOME}
   export NETCDF_FORTRAN_ROOT=${NETCDF_FORTRAN_HOME}

   # Set memory limits to max allowable
   ulimit -c unlimited              # coredumpsize
   ulimit -l unlimited              # memorylocked
   ulimit -u 50000                  # maxproc
   ulimit -v unlimited              # vmemoryuse
   ulimit -s unlimited              # stacksize

   # List modules loaded
   module list

.. tip::

   Ask your sysadmin how to load software libraries.  If you are using
   your institution's computer cluster, then chances are there will
   be a software module system installed, with commands similar to
   those listed above.

Then you can activate these seetings from the command line by typing:

.. code-block:: console

   $ . ~/gcclassic.gnu102.env

You may also place the above command within your :ref:`GEOS-Chem run script
<run-script>`, which will be discussed in a subsequent chapter.
