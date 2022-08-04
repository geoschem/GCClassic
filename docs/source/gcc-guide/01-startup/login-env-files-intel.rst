.. _env-files-intel19:

##############################################
Sample environment file for Intel 19 compilers
##############################################

To load software libraries based on the Intel 19 compilers, we can
start from our :ref:`GNU 10.2.0 environment file <env-files-gnu10>` and
add the proper :command:`module load` commands for Intel 19.

Add the code below (with the appropriate modifications for your
system) into a file named :file:`~/gcclassic.intel19.env`.

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

   # Load modules for Intel compilers v19.0.4
   module load git/2.17.0-fasrc01
   module load intel/19.0.5-fasrc01
   module load openmpi/4.0.1-fasrc01
   module load netcdf-fortran/4.5.2-fasrc03
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
   export CC=icc
   export CXX=icpc
   export FC=ifort

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

   Ask your sysadmin how to load software libraries.  If you
   are using your institution's computer cluster, then chances
   are there will be a software module system installed, with
   commands similar to those listed above.

Then you can activate these settings from the command line by typing:

.. code-block:: console

   $ . ~/gcclassic.intel19.env

You may also place the above command within your :ref:`GEOS-Chem run script
<run-script>`, which will be discussed in a subsequent chapter.
