.. _compile-info:

####################################
Get a summary of compilation options
####################################

The compilation process will create a folder in your run directory
named :file:`build_info`.  Navigate into this folder and get a
directory listing:

.. code-block:: console

   $ cd build_info
   $ ls -CF
   CMakeCache.txt  summarize_build*

:file:`CMakeCache.txt` contains the **CMake cache**, which is a complete
listing of all compilation settings.  :file:`summarize_build` is a
script that will print the most important of these CMake cache
settings.

If you run :file:`summarize_build`:

.. code-block:: console

   $ ./summarize_build

You will get output similar to this:

.. code-block:: bash

   $ ./summarize_build
   ## Compiler Info
   #  Family:   GNU
   #  Version:  10.2.0
   #  Which:    /n/sw/helmod-rocky8/apps/Core/gcc/10.2.0-fasrc01/bin/gfortran

   ## Compiler Options (global)
   -DCMAKE_Fortran_FLAGS=""
   -DCMAKE_Fortran_FLAGS_RELEASE="-O3"

   ## Compiler Options (GEOS-Chem)
   -DGEOSChem_Fortran_FLAGS_GNU="-cpp;-w;-std=legacy;-fautomatic;-fno-align-commons;-fconvert=big-endian;-fno-range-check;-mcmodel=medium;-fbacktrace;-g;-DLINUX_GFORTRAN;-ffree-line-length-none"
   -DGEOSChem_Fortran_FLAGS_RELEASE_GNU="-O3;-funroll-loops"

   ## Compiler Options (HEMCO)
   -DHEMCO_Fortran_FLAGS_GNU="-cpp;-w;-std=legacy;-fautomatic;-fno-align-commons;-fconvert=big-endian;-fno-range-check;-mcmodel=medium;-fbacktrace;-g;-DLINUX_GFORTRAN;-ffree-line-length-none"
   -DHEMCO_Fortran_FLAGS_RELEASE_GNU="-O3;-funroll-loops"

   ## GEOS-Chem Components Settings
   -DTOMAS="OFF"
   -DTOMAS_BINS="NA"
   -DAPM="OFF"
   -DRRTMG="OFF"
   -DGTMM="OFF"
   -DHCOSA="OFF"
   -DLUO_WETDEP="OFF"
   -DFASTJX="OFF"

Here you can see the compiler flags that were used as well as the
options that were selected.
