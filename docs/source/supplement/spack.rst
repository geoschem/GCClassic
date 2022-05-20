.. _build-libraries-for-geos-chem-with-spack:

########################################
Build libraries for GEOS-Chem with Spack
########################################

Here are some up-to-date instructions on installing a software stack for
GEOS-Chem Classic with Spack.

===================
Initial Spack setup
===================

.. _installing-spack-to-your-home-directory:

Install spack to your home directory
------------------------------------

Spack can be installed with Git, as follows:

.. code-block:: console

    cd ~
    $ git clone git@github.com:spack/spack.git

.. _initialize-spack:

Initialize Spack
----------------

To initialize Spack type these commands:

.. code-block:: console

    $ export SPACK_ROOT=${HOME}/spack
    $ source ${SPACK_ROOT}/spack/share/spack/setup-env.sh

.. _make-sure-the-default-compiler-is-in-compilers.yaml:

Make sure the default compiler is in compilers.yaml
---------------------------------------------------

Tell Spack to search for compilers:

.. code-block:: console

    $ spack compiler find

You can confirm that the default compiler was found by inspecing compilers.yaml file with your favorite editor, e.g.:

.. code-block:: console

    $ emacs ~/.spack/linux/compilers.yaml

For example, the default compiler that was on my cloud instance was
the GNU Compiler Collection 7.4.0. This collection contains C (``gcc``),
C++ (``g++``), and Fortran (``gfortran``) compilers.  These are specified in
the compiler.yaml file as:

.. code-block:: console

    compilers:
    - compiler:
        spec: gcc@7.4.0
        paths:
          cc: /usr/bin/gcc-7
          cxx: /usr/bin/g++-7
          f77: /usr/bin/gfortran-7
          fc: /usr/bin/gfortran-7
        flags: {}
        operating_system: ubuntu18.04
        target: x86_64
        modules: []
        environment: {}
        extra_rpaths: []

As you can see, the default compiler executables are located in the
/usr/bin folder. This is where many of the system-supplied executable
files are located.
exec

==============================
Build the GCC 10.2.0 compilers
==============================

Let's build a newer compiler verion with Spack. In this case we'll build
the GNU Compiler Collection 10.2.0 using the default compilers.

.. code-block:: console

    $ spack install gcc@10.2.0 target=x86_64 %gcc@7.4.0
    $ spack load gcc%10.2.0

.. _update-compilers.yaml-with-the-compiler-you-just-built:

Update compilers.yaml
---------------------

In order for Spack to use this new compiler to build other packages,
the compilers.yaml file must be updated using these commands:

.. code-block:: console

    $ spack load gcc@10.2.0
    $ spack compiler find


.. _install-libs:

========================================
Install required libraries for GEOS-Chem
========================================

.. _install-hdf5:

Now that we have installed a the GNU Compiler Collection 10.2.0, we
can use it to build the required libraries for GEOS-Chem Classic.


HDF5
----
Now we can start installing libraries. First, let's install :program:`HDF5`,
which is a dependency of :program:`netCDF`.

.. code-block:: console

    $ spack install hdf5%gcc@10.2.0 target=x86_64 +cxx+fortran+hl+pic+shared+threadsafe
    $ spack load hdf5%gcc@10.2.0

The ``+cxx+fortran+hl+pic+shared+threadsafe`` specifies necessary options for building HDF5.

.. _install-netcdf-fortran-and-netcdf-c:

netCDF-Fortran and netCDF-C
---------------------------

Now that we have installed :program:, we may proceed to installing
netCDF-Fortran (which will install netCDF-C as a dependency).

.. code-block:: console

    $ spack install netcdf-fortran%gcc@10.2.0 target=x86_64 ^hdf5+cxx+fortran+hl+pic+shared+threadsafe
    $ spack load netcdf-fortran%gcc@10.2.0
    $ spack load netcdf-c%gcc@10.2.0

We tell Spack to use the same version of HDF5 that we just built by appending
``^hdf5+cxx+fortran+hl+pic+shared+threadsafe`` to the spack install
command.  Otherwise, Spack will try to build a new version of HDF5
with default options (which is not what we want).

.. _install-ncview:

ncview
------

:program:`Ncview` is a convenient viewer for browsing netCDF files. Install it with:

.. code-block:: console

    $ spack install ncview%gcc@10.2.0 target=x86_64 ^hdf5+cxx+fortran+hl+pic+shared+threadsafe
    $ spack load ncview%gcc@10.2.0

.. _install-the-netcdf-operators-nco:

nco (The netCDF Operators)
--------------------------

The netCDF operators (:program:`nco`) are useful programs for
manipulating netCDF files and attributes.  Install (:program:`nco`)
with:

.. code-block:: console

    $ spack install nco%gcc@10.2.0 target=x86_64 ^hdf5+cxx+fortran+hl+pic+shared+threadsafe
    $ spack load nco%gcc@10.2.0

.. _install-climate-data-operators-cdo:

cdo (The Climate Data Operators)
--------------------------------

The Climate Data Operators (:program:`cdo`) are utilities for
processing data in netCDF files.

.. code-block:: console

    $ spack install cdo%gcc@10.2.0 target=x86_64 ^hdf5+cxx+fortran+hl+pic+shared+threadsafe
    $ spack load cdo%gcc@10.2.0

.. _install-flex:

flex
----

The :program:`flex` library is a lexical parser. It is a dependency for
`KPP <https://kpp.readthedocs.io>`_.

.. code-block:: console

    $ spack install flex%gcc@10.2.0 target=x86_64
    $ spack load flex%gcc10.2.0

.. _install-gdb-and-cgdb:

gdb and cgdb
~~~~~~~~~~~~

:program:`Gdb`` is the GNU Debugger. :program:`Cgdb`` is a visual,
user-friendly interface for :program:`gdb`.

.. code-block:: console

    $ spack install gdb@9.1%gcc@10.2.0 target=x86_64
    $ spack load gdb%10.2.0

    $ spack install cgdb%gcc@10.2.0 target=x86_64
    $ spack load cgdb%gcc@10.2.0

.. _install-cmake-and-gmake:

cmake and gmake
~~~~~~~~~~~~~~~

:program:`Cmake` and :program:`gmake` are used to build source code
into executables.

.. code-block:: console

    $ spack install cmake%gcc@10.2.0 target=x86_64
    $ spack load cmake%gcc@10.2.0

    $ spack install gmake%gcc@10.2.0 target=x86_64
    $ spack load gmake%gcc@10.2.0

.. _installing-optional-packages:

============================
Installing optional packages
============================

These packages are useful not strictly necessary for GEOS-Chem.

.. _openjdk-java:

OpenJDK (Java)
--------------

Some programs might need the :program:`openjdk` Java Runtime Environment:

.. code-block:: console

    $ spack install openjdk%gcc@10.2.0
    $ spack load openjdk%gcc@10.2.0

.. _tau-performance-profiler:

TAU performance profiler
------------------------

The Tuning and Analysis Utilities (;program:`tau`) lets you profile
:program:`GEOS-Chem` in order to locate computational bottlenecks:

.. code-block:: console

    $ spack install tau%gcc@10.2.0 +pthread+openmp~otf2
    $ spack load tau%gcc@10.2.0

.. _loading-spack-packages-at-startup:

=================================
Loading Spack packages at startup
=================================

.. _creating-an-environment-file-for-spack:

Creating an environment file for Spack
--------------------------------------

Once you have finished installing libraries with :program:`Spack`, you
can create an environment file to load the Spack libraries whenever
you start a new Unix shell. Here is a sample environment file that can
be used (or modified) to load the Spack libraries described above.

.. code-block:: bash

    #==============================================================================
    # %%%%% Clear existing environment variables %%%%%
    #==============================================================================
    unset CC
    unset CXX
    unset EMACS_HOME
    unset FC
    unset F77
    unset F90
    unset NETCDF_HOME
    unset NETCDF_INCLUDE
    unset NETCDF_LIB
    unset NETCDF_FORTRAN_HOME
    unset NETCDF_FORTRAN_INCLUDE
    unset NETCDF_FORTRAN_LIB
    unset OMP_NUM_THREADS
    unset OMP_STACKSIZE
    unset PERL_HOME

    #==============================================================================
    # %%%%% Load Spack packages %%%%%
    #==============================================================================
    echo "Loading gfortran 10.2.0 and related libraries ..."

    # Initialize Spack
    # In the examples above /path/to/spack was ${HOME}/spack
    export SPACK_ROOT=/path/to/spack
    source $SPACK_ROOT/share/spack/setup-env.sh

    # List each Spack package that you want to load
    # (add the backslash after each new package that you add)
    pkgs=(                      \
      gcc@10.2.0                \
      cmake%gcc@10.2.0          \
      openmpi%gcc@10.2.0        \
      netcdf-fortran%gcc@10.2.0 \
      netcdf-c%gcc@10.2.0       \
      hdf5%gcc@10.2.0           \
      gdb%gcc@10.2.0            \
      flex%gcc@10.2.0           \
      openjdk%gcc@10.2.0        \
      cdo%gcc@10.2.0            \
      nco%gcc@10.2.0            \
      ncview%gcc@10.2.0         \
      perl@5.30.3%gcc@10.2.0    \
      tau%gcc@10.2.0            \
    )

    # Load each Spack package
    for f in ${pkgs[@]}; do
        echo "Loading $f"
        spack load $f
    done

    #==============================================================================
    # %%%%% Settings for OpenMP parallelization %%%%%
    #==============================================================================

    # Max out the stack memory for OpenMP
    # Asking for a huge number will just give you the max availble
    export OMP_STACKSIZE=500m

    # By default, set the number of threads for OpenMP parallelization to 1
    export OMP_NUM_THREADS=1

    # Redefine number threads for OpenMP parallelization
    # (a) If in a SLURM partition, set OMP_NUM_THREADS = SLURM_CPUS_PER_TASK
    # (b) Or, set OMP_NUM_THREADS to the optional first argument that is passed
    if [[ -n "${SLURM_CPUS_PER_TASK+1}" ]]; then
      export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
    elif [[ "$#" -eq 1 ]]; then
      if [[ "x$1" != "xignoreeof" ]]; then
        export OMP_NUM_THREADS=${1}
      fi
    fi
    echo "Number of OpenMP threads: $OMP_NUM_THREADS"

    #==============================================================================
    # %%%%% Define relevant environment variables %%%%%
    #==============================================================================

    # Compiler environment variables
    export FC=gfortran
    export F90=gfortran
    export F77=gfortran
    export CC=gcc
    export CXX=g++

    # Machine architecture
    export ARCH=`uname -s`

    # netCDF paths
    export NETCDF_HOME=`spack location -i netcdf-c%gcc@10.2.0`
    export NETCDF_INCLUDE=${NETCDF_HOME}/include
    export NETCDF_LIB=${NETCDF_HOME}/lib

    # netCDF-Fortran paths
    export NETCDF_FORTRAN_HOME=`spack location -i netcdf-fortran%gcc@10.2.0`
    export NETCDF_FORTRAN_INCLUDE=${NETCDF_FORTRAN_HOME}/include
    export NETCDF_FORTRAN_LIB=${NETCDF_FORTRAN_HOME}/lib

    # Other important paths
    export GCC_HOME=`spack location -i gcc@10.2.0`
    export MPI_HOME=`spack location -i openmpi%gcc@10.2.0`
    export TAU_HOME=`spack location -i tau%gcc@10.2.0`

    #==============================================================================
    # %%%%% Echo relevant environment variables %%%%%
    #==============================================================================
    echo
    echo "Important environment variables:"
    echo "CC  (C compiler)       : $CC"
    echo "CXX (C++ compiler)     : $CXX"
    echo "FC  (Fortran compiler) : $FC"
    echo "NETCDF_HOME            : $NETCDF_HOME"
    echo "NETCDF_INCLUDE         : $NETCDF_INCLUDE"
    echo "NETCDF_LIB             : $NETCDF_LIB"
    echo "NETCDF_FORTRAN_HOME    : $NETCDF_FORTRAN_HOME"
    echo "NETCDF_FORTRAN_INCLUDE : $NETCDF_FORTRAN_INCLUDE"
    echo "NETCDF_FORTRAN_LIB     : $NETCDF_FORTRAN_LIB"

Save this to your home folder with a name such as ``~/.spack_env``. The
``.`` in front of the name will make it a hidden file like your ``.bashrc``
or ``.bash_aliases``.

.. _loading-spack-built-libraries:

Loading Spack-built libraries
-----------------------------
Whenever you start a new Unix session (either by opening a terminal
window or running a new job), your :file:`.bashrc` and
:file:`.bash_aliases` files will be sourced, and the commands
contained within them applied. You should then load the Spack
modules by typing at the terminal prompt:

.. code-block:: console

    $ source ~/.spack.env

You can also add some code to your :file:`.bash_aliases` so that this
will be done automatically:

.. code-block:: bash

    if [[ -f ~/.spack.env ]]; then
        source ~/.spack.env
    fi

In either case, this will load the modules for you. You should see
output similar to:

.. code-block:: console

    Loading gfortran 10.2.0 and related libraries ...
    Loading gcc@10.2.0
    Loading cmake%gcc@10.2.0
    Loading openmpi%gcc@10.2.0
    Loading netcdf-fortran%gcc@10.2.0
    Loading netcdf-c%gcc@10.2.0
    Loading hdf5%gcc@10.2.0
    Loading gdb%gcc@10.2.0
    Loading flex%gcc@10.2.0
    Loading openjdk%gcc@10.2.0
    Loading cdo%gcc@10.2.0
    Loading nco%gcc@10.2.0
    Loading ncview%gcc@10.2.0
    Loading perl@5.30.3%gcc@10.2.0
    Loading tau%gcc@10.2.0
    Number of OpenMP threads: 1

    Important environment variables:
    CC  (C compiler)       : gcc
    CXX (C++ compiler)     : g++
    FC  (Fortran compiler) : gfortran
    NETCDF_HOME            : /net/seasasfs02/srv/export/seasasfs02/share_root/ryantosca/spack/opt/spack/linux-centos7-x86_64/gcc-10.2.0/netcdf-c-4.7.4-22bkbtqledcaipqc2zrgun4qes7kkm5q
    NETCDF_INCLUDE         : /net/seasasfs02/srv/export/seasasfs02/share_root/ryantosca/spack/opt/spack/linux-centos7-x86_64/gcc-10.2.0/netcdf-c-4.7.4-22bkbtqledcaipqc2zrgun4qes7kkm5q/include
    NETCDF_LIB             : /net/seasasfs02/srv/export/seasasfs02/share_root/ryantosca/spack/opt/spack/linux-centos7-x86_64/gcc-10.2.0/netcdf-c-4.7.4-22bkbtqledcaipqc2zrgun4qes7kkm5q/lib
    NETCDF_FORTRAN_HOME    : /net/seasasfs02/srv/export/seasasfs02/share_root/ryantosca/spack/opt/spack/linux-centos7-x86_64/gcc-10.2.0/netcdf-fortran-4.5.3-mtuoejjcl3ozbvd6prgqm44k5jre3hne
    NETCDF_FORTRAN_INCLUDE : /net/seasasfs02/srv/export/seasasfs02/share_root/ryantosca/spack/opt/spack/linux-centos7-x86_64/gcc-10.2.0/netcdf-fortran-4.5.3-mtuoejjcl3ozbvd6prgqm44k5jre3hne/include
    NETCDF_FORTRAN_LIB     : /net/seasasfs02/srv/export/seasasfs02/share_root/ryantosca/spack/opt/spack/linux-centos7-x86_64/gcc-10.2.0/netcdf-fortran-4.5.3-mtuoejjcl3ozbvd6prgqm44k5jre3hne/lib

Once you see this output, you can then start using programs that rely on
these Spack-built libraries.

.. _setting-the-number-of-cores-for-openmp:

Setting the number of cores for OpenMP
--------------------------------------

If you type:

.. code-block:: console

    $ source ~/.spack.env

by itself, this will set the :envvar:`OMP_NUM_THREADS` variable
to 1. This variable sets the number of computational cores that OpenMP
should use.

You can change this with, e.g.

.. code-block:: console

    source ~/.spack.env 6

which will set :envvar:`OMP_NUM_THREADS` to 6. In this case, GEOS-Chem
Classic (and other programs that use OpenMP parallelization) will
parallelize with 6 cores.

If you are using the SLURM scheduler and are source :file:`.spack.env`
in your job script, then :file:`OMP_NUM_THREADS` will be automatically
set to :file:`SLURM_CPUS_PER_TASK`, which is then number of cores
requested. If you are not using SLURM then you should add e.g.

.. code-block:: bash

    export OMP_NUM_THREADS=6

(or however many cores you have requested) in your SLURM job script.
