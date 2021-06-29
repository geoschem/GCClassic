Create a run directory
======================

We have greatly simplified run directory creation in `GEOS-Chem
13.0.0 <GEOS-Chem_13.0.0>`__ and later versions. You no longer need to
download the separate `GEOS-Chem Unit Tester <GEOS-Chem_Unit_Tester>`__
repository any longer, but can create run directories from a script in
the GEOS-Chem source code itself.

.. _example_1_creating_a_run_directory_for_a_full_chemistry_simulation:

Example 1: Create a full-chemistry simulation run directory
-----------------------------------------------------------

Let us walk through the process of creating a run directory for a global
GEOS-Chem full-chemistry simulation.

**1.** Navigate to the GCClassic superproject folder and get a
directory listing:

.. code-block:: console

   $ cd /path/to/your/GCClassic
   $ ls -CF

You should see this output:

.. code-block:: console

   CMakeLists.txt  LICENSE  run@  src/

As mentioned previously, :file:`run@` is a symbolic link. It actually
points to the to the :file:`src/GEOS-Chem/run/GCClassic` folder. This
folder contains several scripts and template files for run directory
creation.

**2.** Navigate to the run folder and get a directory listing:

.. code-block:: console

   $ cd run
   $ ls -CF`

and you should see this output:

.. code-block:: console

   archiveRun.sh*    gitignore                   HISTORY.rc.templates/  runScriptSamples/
   createRunDir.sh*  HEMCO_Config.rc.templates/  input.geos.templates/
   getRunInfo*       HEMCO_Diagn.rc.templates/   README

You can see several folders (highlighted in the directory display with
``/``) and a few executable scripts (highlighted with ``*``).  The
script we are interested in is :file:`createRunDir.sh`.

**3.** Run the :file:`createRunDir.sh` script. Type:

.. code-block:: console

   $ ./createRunDir.sh

**4.** You will then be prompted to supply information about the run
directory that you wish to create:

.. code-block:: console

   ===========================================================
   GEOS-CHEM RUN DIRECTORY CREATION
   ===========================================================

   ----------------------------------------------------------
   Choose simulation type:
   -----------------------------------------------------------
      1. Full chemistry
      2. Aerosols only
      3. CH4
      4. CO2
      5. Hg
      6. POPs
      7. Tagged CH4
      8. Tagged CO
      9. Tagged O3
     10. TransportTracers

To create a run directory for the full-chemistry simulation, type ``1`` followed by the ``ENTER`` key.

**5.** You will then be prompted to specify whether you want to perform
chemistry in the stratosphere or not:

.. code-block:: console

   -----------------------------------------------------------
   Choose chemistry domain:
   -----------------------------------------------------------
     1. Troposphere + stratosphere (Recommended)
     2. Troposphere only

Select the recommended option: Type ``1`` and then ``ENTER``.

**6.** You will then be asked to specify any additional options for the
full-chemistry simulation (such as adding the RRTMG radiative transfer
model, APM or TOMAS microphysics, etc.)

.. code-block:: console

   -----------------------------------------------------------
   Choose additional simulation option:
   -----------------------------------------------------------
     1. Standard
     2. Benchmark
     3. Complex SOA
     4. Marine POA
     5. Acid uptake on dust
     6. TOMAS
     7. APM
     8. RRTMG

**6a**: For the standard full-chemistry simulation, type ``1`` followed by ``ENTER``.

**6b**: To add an option to the full-chemistry simulation, type a number between ``2`` and ``8`` and press ``ENTER``.

**7.** You will then be asked to specify the meteorology type for the
simulation (GEOS-FP or MERRA-2):

.. code-block:: console

   -----------------------------------------------------------
   Choose meteorology source:
   -----------------------------------------------------------
     1. MERRA-2 (Recommended)
     2. GEOS-FP

You should use the recommended option (MERRA-2) if possible. Type ``1`` followed by ``ENTER``.

**8.** The next menu will prompt you for the horizontal resolution that
you wish to use:

.. code-block:: console

   -----------------------------------------------------------
   Choose horizontal resolution:
   -----------------------------------------------------------
     1. 4.0  x 5.0
     2. 2.0  x 2.5
     3. 0.5  x 0.625

**8a.** If you wish to set up a global simulation, type either ``1`` or ``2`` followed by ``ENTER``.

**8b.** If you wish to set up a nested-grid simulation, type ``3`` and hit ``ENTER``. Then you will be followed by a nested-grid menu:

.. code-block:: console

   -----------------------------------------------------------
   Choose horizontal grid domain:
   -----------------------------------------------------------
     1. Global
     2. Asia
     3. Europe
     4. North America
     5. Custom

Select your preferred horizontal domain, followed by ``ENTER``.

**9.** You will then be prompted for the vertical dimension of the grid.

.. code-block:: console

   -----------------------------------------------------------
   Choose number of levels:
   -----------------------------------------------------------
     1. 72 (native)
     2. 47 (reduced)

**9a.** For most simulations, you will want to use ``72`` levels. Type ``1`` followed by ``ENTER``.

**9b.** For some memory-intensive simulations (such as nested-grid
simulations), you can use 47 levels. Type ``2`` followed by ``ENTER``.

**10.** You will then be prompted for the folder in which you wish to
create the run directory.

.. code-block:: console

   -----------------------------------------------------------
   Enter path where the run directory will be created:
   -----------------------------------------------------------

**10a.** You can enter an absolute path (such as
:file:`/n/home09/myusername/` followed by ``ENTER)``.

**10b.** Or you can enter a relative path (such as :file:`~/rundirs`
followed by ENTER). In this case you will see that the
:file:`./createRunDir.sh`  script will expand the path to:

.. code-block:: console

   Expanding to: /n/home09/myusername/rundirs

**11.** The next menu will prompt you for the run directory name.

.. code-block:: console
   -----------------------------------------------------------
   Enter run directory name, or press return to use default:

   NOTE: This will be a subfolder of the path you entered above.
   -----------------------------------------------------------

You should use the default run directory name whenever possible. Type
``ENTER`` to select the default.

The script will display the following output:

.. code-block:: console

    -- Using default directory name gc_4x5_fullchem

or if you are creating a nested grid simulation:

.. code-block:: console

    -- Using default directory name gc_05x0625_fullchem

and then:

.. code-block:: console

    -- This run directory has been set up for 20190701 - 20190801.
       You may modify these settings in input.geos.

    -- The default frequency and duration of diagnostics is set to monthly.
       You may modify these settings in HISTORY.rc and HEMCO_Config.rc.

**12.** The last menu will prompt you with:

.. code-block:: console

   -----------------------------------------------------------
   Do you want to track run directory changes with git? (y/n)
   -----------------------------------------------------------

Type ``y`` and then ``ENTER``. Then you will be able to track changes
that you make to GEOS-Chem configuration files with Git. This can be a
lifesaver when debugging -- you can revert to an earlier state and
then start fresh.

**13.** The script will display the full path to the run directory. You
can navigate there and then start editing the GEOS-Chem configuration
files.

.. _example_2_creating_a_run_directory_for_the_methane_simulation:

Example 2: Create a CH4 simulation run directory
------------------------------------------------

The process of creating run directories for the GEOS-Chem specialty
simulations is similar to that as listed in Example 1 above. However,
the number of menus that you need to select from will likely be fewer
than for the full-chemistry simulation. We'll use the methane simulation
as an example.

**1.** Navigate to the :file:`GCClassic` superproject folder and get a
d irectory listing:

.. code-block:: console

   $ cd /path/to/your/GCClassic
   $ ls -CF

You should see this output:

.. code-block:: console


  CMakeLists.txt  LICENSE  run@  src/

As mentioned previously, run@ is a symbolic link. It actually points
to the to the :file:`src/GEOS-Chem/run/GCClassic` folder. This folder
contains several scripts and template files for run directory creation.

**2.** Navigate to the run folder and get a directory listing:

.. code-block:: console

   $ cd run
   $ ls -CF

and you should see this output:

.. code-block:: console

   archiveRun.sh*    gitignore                   HISTORY.rc.templates/  runScriptSamples/
   createRunDir.sh*  HEMCO_Config.rc.templates/  input.geos.templates/
   getRunInfo*       HEMCO_Diagn.rc.templates/   README

You can see several folders (highlighted in the directory display with
``/``) and a few executable scripts (highlighted with ``*``).  The script we
are interested in is :file:`createRunDir.sh`.

**3.** Run the createRunDir.sh. Type:

.. code-block:: console

     $ ./createRunDir.sh

**4.** You will then be prompted to supply information about the run
directory that you wish to create:

.. code-block:: console

   ===========================================================
   GEOS-CHEM RUN DIRECTORY CREATION
   ===========================================================

   -----------------------------------------------------------
   Choose simulation type:
   -----------------------------------------------------------
      1. Full chemistry
      2. Aerosols only
      3. CH4
      4. CO2
      5. Hg
      6. POPs
      7. Tagged CH4
      8. Tagged CO
      9. Tagged O3
     10. TransportTracers

To select the GEOS-Chem methane specialty simulation, type ``3`` followed by ``ENTER``.

**5.** You will then be asked to specify the meteorology type for the
simulation (GEOS-FP or MERRA-2):

.. code-block:: console

   -----------------------------------------------------------
   Choose meteorology source:
   -----------------------------------------------------------
     1. MERRA-2 (Recommended)
     2. GEOS-FP

To accept the recommended meteorology (MERRA-2), type ``1`` followed by ``ENTER``.

**6.** The next menu will prompt you for the horizontal resolution that
you wish to use:

.. code-block:: console

   -----------------------------------------------------------
   Choose horizontal resolution:
   -----------------------------------------------------------
     1. 4.0  x 5.0
     2. 2.0  x 2.5
     3. 0.5  x 0.625

**6a.** If you wish to set up global simulation, type either ``1`` or ``2`` followed by ``ENTER``.

**6b.** If you wish to set up a nested-grid simulation, type ``3`` and hit ENTER. Then you will be followed by a nested-grid menu:

.. code-block:: console

   -----------------------------------------------------------
   Choose horizontal grid domain:
   -----------------------------------------------------------
     1. Global
     2. Asia
     3. Europe
     4. North America
     5. Custom

Type the number of your preferred option and then hit ``ENTER``.

**7.** You will then be prompted for the vertical dimension of the grid.

.. code-block:: console

   -----------------------------------------------------------
   Choose number of levels:
   -----------------------------------------------------------
     1. 72 (native)
     2. 47 (reduced)

**7a.** For most simulations, you will want to use 72 levels. Type
``1`` followed by ``ENTER``.

**7b.** For some memory-intensive simulations (such as nested-grid
simulations), you can use 47 levels. Type ``2`` followed by ``ENTER``.

**8.** You will then be prompted for the folder in which you wish to
create the run directory.

.. code-block:: console

   -----------------------------------------------------------
   Enter path where the run directory will be created:
   -----------------------------------------------------------

**8a.** You enter this an absolute path (such as
:file:`/n/home09/myusername/` followed by ENTER).

**8b.** Or you can enter a relative path (such as :file:`~/rundirs`
followed by ENTER). In this case you will see that the
:file:`./createRunDir.sh` script will expand the path to:

.. code-block:: console

   Expanding to: /n/home09/myusername/rundirs

**9.** The next menu will prompt you for the run directory name.

.. code-block:: console

   -----------------------------------------------------------
   Enter run directory name, or press return to use default:

   NOTE: This will be a subfolder of the path you entered above.
   -----------------------------------------------------------

You should use the default run directory name whenever possible. Type
``ENTER``. The script will display the following output:

.. code-block:: console

    -- Using default directory name gc_4x5_CH4

or if you are creating a nested grid simulation:

.. code-block:: console

    -- Using default directory name gc_05x0625_CH4

 and then:

    -- This run directory has been set up for 20190701 - 20190801.
       You may modify these settings in input.geos.

    -- The default frequency and duration of diagnostics is set to monthly.
       You may modify these settings in HISTORY.rc and HEMCO_Config.rc.

**10.** The last menu will prompt you with:

.. code-block:: console

   -----------------------------------------------------------
   Do you want to track run directory changes with git? (y/n)
   -----------------------------------------------------------

Type ``y`` and then ``ENTER``. Then you will be able to track changes
that you make to GEOS-Chem configuration files with Git. This can be a
lifesaver when debugging -- you can revert to an earlier state and
then start fresh.

**11.** The script will display the full path to the run directory. You
can navigate there and then start editing the GEOS-Chem configuration
files.
