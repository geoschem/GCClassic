.. _compile-make:

#################
Compile with Make
#################

Now that CMake has created the Makefiles that are needed to compile
GEOS-Chem, you may proceed as follows:

======================================
Build the GEOS-Chem Classic executable
======================================

Use the :command:`make` command to build the GEOS-Chem executable.  Type:

.. code-block:: console

    $ make -j

You will see output similar to this:

.. code-block:: text

   Scanning dependencies of target HeadersHco
   Scanning dependencies of target Isorropia
   Scanning dependencies of target KPP_FirstPass
   [  1%] Building Fortran object src/HEMCO/src/Shared/Headers/CMakeFiles/HeadersHco.dir/hco_inquireMod.F90.o
   [  1%] Building Fortran object src/HEMCO/src/Shared/Headers/CMakeFiles/HeadersHco.dir/hco_precision_mod.F90.o
   [  1%] Building Fortran object src/HEMCO/src/Shared/Headers/CMakeFiles/HeadersHco.dir/hco_charpak_mod.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/KPP/fullchem/CMakeFiles/KPP_FirstPass.dir/gckpp_Monitor.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/KPP/fullchem/CMakeFiles/KPP_FirstPass.dir/gckpp_Precision.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/KPP/fullchem/CMakeFiles/KPP_FirstPass.dir/gckpp_Parameters.F90.o
   [  3%] Linking Fortran static library libKPP_FirstPass.a
   [  3%] Built target KPP_FirstPass
   Scanning dependencies of target Headers
   [  3%] Building Fortran object src/GEOS-Chem/ISORROPIA/CMakeFiles/Isorropia.dir/isorropiaII_main_mod.F.o
   [  3%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/charpak_mod.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/dictionary_m.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/CMN_SIZE_mod.F90.o
   [  3%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/qfyaml_mod.F90.o
   [  4%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/CMN_O3_mod.F90.o
   [  6%] Building Fortran object src/GEOS-Chem/Headers/CMakeFiles/Headers.dir/inquireMod.F90.o

   ... etc ...

   [ 93%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/sulfate_mod.F90.o
   [ 93%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/fullchem_mod.F90.o
   [ 93%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/mixing_mod.F90.o
   [ 93%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/carbon_mod.F90.o
   [ 95%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/chemistry_mod.F90.o
   [ 95%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/gc_environment_mod.F90.o
   [ 96%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/emissions_mod.F90.o
   [ 96%] Building Fortran object src/GEOS-Chem/GeosCore/CMakeFiles/GeosCore.dir/cleanup.F90.o
   [ 98%] Linking Fortran static library libGeosCore.a
   [ 98%] Built target GeosCore
   Scanning dependencies of target gcclassic
   [ 98%] Building Fortran object src/CMakeFiles/gcclassic.dir/GEOS-Chem/Interfaces/GCClassic/main.F90.o
   [100%] Linking Fortran executable ../bin/gcclassic
   [100%] Built target gcclassic

.. tip::

   The :command:`-j` argument tells :command:`make` that it can
   execute as many jobs as it wants simultaneously. For example, if
   you have 8 cores, then the build process may attempt to compile 8
   files at a time.

   If you want to restrict the number of simultaneous jobs (e.g. you
   are compiling on a machine with limited memory), you can can use
   e.g. :command:`make -j4`, which should only try to compile 4 files
   at a time.

.. _compile-make-install:

============================================
Install the executable in your run directory
============================================

Now that the :file:`gcclassic` executable is built, install it to your
run directory with :command:`make install`. For this to work properly,
you must tell CMake where to find your run directory by configuring
CMake with :envvar:`-DRUNDIR=/path/to/run/directory` :ref:`as
described above <compile-cmake>`.  Type:

.. code-block:: console

    $ make install

and you will see output similar to this:

.. code-block:: console

   [  1%] Built target HeadersHco
   [  3%] Built target KPP_FirstPass
   [  3%] Built target Isorropia
   [  4%] Built target JulDayHco
   [ 13%] Built target Headers
   [ 18%] Built target NcdfUtilHco
   [ 19%] Built target JulDay
   [ 19%] Built target GeosUtilHco
   [ 25%] Built target NcdfUtil
   [ 40%] Built target HCO
   [ 46%] Built target GeosUtil
   [ 56%] Built target HCOX
   [ 59%] Built target Transport
   [ 62%] Built target History
   [ 63%] Built target ObsPack
   [ 71%] Built target KPP
   [ 71%] Built target HCOI_Shared
   [ 98%] Built target GeosCore
   [100%] Built target gcclassic
   Install the project...
   -- Install configuration: "Release"
   -- Up-to-date: /home/ubuntu/gc_merra2_fullchem/build_info/CMakeCache.txt
   -- Up-to-date: /home/ubuntu/gc_merra2_fullchem/build_info/summarize_build
   -- Up-to-date: /home/ubuntu/gc_merra2_fullchem/gcclassic

Let's now navigate back to the run directory and get a directory
listing:

.. code-block:: console

   $ cd ..
   $ ls
   CodeDir@                             cleanRunDir.sh*
   GEOSChem.Restart.20190701_0000z.nc4  download_data.py*
   HEMCO_Config.rc                      download_data.yml
   HEMCO_Config.rc.gmao_metfields       gcclassic*
   HEMCO_Diagn.rc                       geoschem_config.yml
   HISTORY.rc                           getRunInfo*
   OutputDir/                           metrics.py*
   README                               runScriptSamples@
   archiveRun.sh*                       rundirConfig/
   build/                               species_database.yml
   build_info/

You should now see the :program:`gcclassic` executable and a :file:`build_info`
directory there. GEOS-Chem has now been configured, compiled, and
installed in your run directory.

Please see the :ref:`rundir-files` section for more information about
the contents of the run directory.

You are now ready to run a GEOS-Chem simulation!

.. _compile-make-clean:

=====================================================
Remove compiler-generated files when no longer needed
=====================================================

In older versions of GEOS-Chem, you could use a GNU Make command such
as :command:`make clean` or :command:`make realclean` to remove all
object (:file:`.o`), library (:file:`.a`), module (:file:`.mod`)
files, as well as the previously-built executable file from the
GEOS-Chem source code folder.

All of the files created by Cmake during the configuration and
compilation stages are placed in the :file:`build/` folder in your run
directory (or in the location that you have specified with the
:envvar:`-DRUNDIR=/path/to/run/dir` option.).  Therefore, if you
wish to build the :program:`GEOS-Chem Classic` executable from
scratch, all you have to do is to remove all of the files from the
build folder.  It's as simple as that!

You can also create a new build folder with this command:

.. code-block:: console

   $ mv build was.build
   $ mkdir build

and then later on, you can remove the old build folder:

.. code-block:: console

   $ rm -rf was.build

This avoids the temptation to use :command:`rm -rf *`, which can
potentially wipe out all of your files if used incorrectly.
