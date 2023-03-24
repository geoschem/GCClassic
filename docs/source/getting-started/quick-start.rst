

Quickstart Guide
================

This quickstart guide is for quick reference on how to download, build, and run GEOS-Chem Classic. This guide assumes your environment satisfies GEOS-Chem Classic hardware and software requirements. This means you should load a compute environment such that programs like :program:`cmake` are available before continuing. If you do not have some of the required software dependencies, you can find instructions for installing external dependencies in our Spack instructions.

For simplicity we will also refer to GEOS-Chem Classic as simply GEOS-Chem on this page.  More detailed instructions on downloading, compiling, and running GEOS-Chem can be found in the User Guide elsewhere on this site.

1. Clone GEOS-Chem Classic
--------------------------

Download the source code:

.. code-block:: console

   gcuser:~$ git clone https://github.com/geoschem/GCClassic.git GCClassic
   gcuser:~$ cd GCClassic

Upon download you will have the most recently released version. You can check what this is by printing the last commit in the git log and scanning the output for tag.

.. code-block:: console

   gcuser:~/GCClassic$ git log -n 1

You can stay with this version or checkout an earlier version by its tag name:

.. code-block:: console

   gcuser:~/GCClassic$ git checkout tags/14.1.1

You can see a list of all possible tables using the git tag command:

.. code-block:: console

   gcuser:~/GCClassic$ git tag

When you have the version you wish to use you must initialize and update all the submodules. These include HEMCO and GEOS-Chem git repositories:

.. code-block:: console

   gcuser:~/GCClassic$ git submodule update --init --recursive

Repeat this last step every time you switch to a new version of GEOS-Chem Classic.

2. Create a run directory
-------------------------

Navigate to the :file:`run/` subdirectory. 
To create a run directory, run :file:`./createRunDir.sh`:

.. code-block:: console

   gcuser:~/GCClassic$ cd run/
   gcuser:~/GCClassic$ ./createRunDir.sh

Creating a run directory is interactive, meaning you will be asked multiple questions to set up the simulation. 
For example, running :file:`createRunDir.sh` will prompt questions about configurable settings such as simulation type, grid resolution, meteorology source, and number of vertical levels. 
It will also ask you where you want to store your run directory and what you wish to name it, including whether you want to use the default name, e.g. gcc_4x5_merra2_fullchem. 
We recommend storing run directories in a place that has a large storage capacity. 
It does not need to be in the same location as your source code. 
When creating a run directory you can quit and start from scratch at any time. 

3. Load your Environment
------------------------

Prior to building GEOS-Chem always make sure all libraries and environment variables are loaded. 
An easy way to do this is to write an environment file and load that file every time you work with GEOS-Chem. 
To make this extra easy you can create a symbolic link to your environment file within your run directory or source code for reference. 
For example, do the following in your new run directory to have a handy link to the environment you plan on using. 

.. code-block:: console

   gcuser:~/gcc_4x5_merra2_fullchem$ ln -s ~/envs/gcc.gfortran10.env gcc.env

Then every time you start up a session to work with GEOS-Chem in your run directory you can easily load your environment.

.. code-block:: console

   gcuser:~/gcc_4x5_merra2_fullchem$ source gcc.env

4. Configure your build
-----------------------

You may build GEOS-Chem from within the run directory or from anywhere else on your system. 
Building from within the run directory is convenient because it keeps all build files in close proximity to where you will run the model. 
For this purpose the GEOS-Chem run directory includes a build directory called :file:`build/`. 
Note, however, you can create a build directory elsewhere, such as within the GEOS-Chem Classic source code.

We will start with an example of building from within your source code.

.. code-block:: console

   gcuser:~/GCClassic$ mkdir build
   gcuser:~/GCClassic$ cd build

Initialize the build directory by running :program:`cmake`, passing it the path to your source code. In this example the source code is one level up from the build directory so you can use code for relative path rather than entering the absolute path.

.. code-block:: console

   gcuser:~/GCClassic/build$ cmake ..

The next step is to configure your build. 
These are persistent settings that are saved to your build directory.
A useful build option is :literal:`-DRUNDIR`. 
This option lets you specify one or more run directories that GEOS-Chem is "installed" to, meaning where the executable is copied, when you do :command:`make install`. 
Configure your build so it installs GEOS-Chem to the run directory you created in Step 2.

.. code-block:: console

   gcuser:~/GCClassic/build$ cmake . -DRUNDIR="/path/to/your/run/directory"

.. note::
   The :literal:`.` in the :program:`cmake` command above is important. It tells CMake that your current working directory (i.e., :literal:`.`) is your build directory.

If you decide instead to build GEOS-Chem from within your run directory you can do all of the above in one step. This makes use of the :literal:`CodeDir` symbolic link in the run directory:

.. code-block:: console

   gcuser:~/gcc_4x5_merra2_fullchem$ cd build
   gcuser:~/gcc_4x5_merra2_fullchem/build$ cmake ../CodeDir -DRUNDIR=..

GEOS-Chem has a number of additioanl compiler flags you can add here. For example, to compile with RRTMG after running the above command:

   gcuser:~/gcc_4x5_merra2_fullchem/build$ cmake . -DRRTMG=y

A useful compiler option is to build in debug mode. Doing this is a good idea if you encountered a segmentation fault in a previous run and need more information about where the error happened and why.

   gcuser:~/gcc_4x5_merra2_fullchem/build$ cmake . -DCMAKE_BUILD_TYPE=Debug

See the GEOS-Chem documentation for more information on compiler flags.

5. Compile and install
----------------------

Compiling GEOS-Chem Classic should take about a minute, but it can vary depending on your system, your compiler, and your compiler flags. To maximize build speed you should compile GEOS-Chem in parallel using as many cores as are available. Do this with the -j flag:

.. code-block:: console

   gcuser:~/gcc_4x5_merra2_fullchem/build$ make -j

Upon successful compilation, install the compiled executable to your run directory:

.. code-block:: console

   gcuser:~/gcc_4x5_merra2_fullchem/build$ make install

This copies executable :file:`bin/gcclassic` and supplemental files to your run directory. 

.. note::
   You can update build settings at any time:
   
   1. Navigate to your build directory.
   2. Update your build settings with :program:`cmake` (only if they differ since your last execution of cmake)
   3. Recompile with :command:`make -j`. Note that the build system automatically figures out what (if any) files need to be recompiled.
   4. Install the rebuilt executable with :command:`make install`.

If you do not install the executable to your run directory you can always get the executable from the directory :command:`build/bin`.


6. Configure your run directory
-------------------------------

Now, navigate to your run directory:

.. code-block:: console

   gcuser:~$ cd gcc_4x5_merra2_fullchem

Commonly changed simulation settings, such as start time and end time, are set in :file:`geoschem_config.yml`. 
GEOS-Chem diagnostic settings are in :file:`HISTORY.rc` and emissions diagnostic settings are in :file:`HEMCO_Diagn.rc`. 
HEMCO emissions settings as well as other file input settings, such as the restart file, are in :file:`HEMCO_Config.rc`.
You should review these files before starting a run.


7. Run GEOS-Chem Classic
------------------------

If you used an environment file to load libraries prior to building GEOS-Chem then you should load that file prior to running. In general, the command to run GEOS-Chem Classic is simple:

.. code-block:: console

   gcuser:~/gcc_4x5_merra2_fullchem$ ./gcclassic

We recommend running GEOS-Chem Classic as a batch job, although you can also do short runs interactively. 
Running GEOS-Chem as a batch job means that you write a script (usually bash) that configures and runs your GEOS-Chem simulation, and then you submit that script to your local job scheduler (SLURM, LSF, etc.). 
If you write a batch script you can include sourcing your environment file within the script to ensure you always use the intended environment. 
Submitting GEOS-Chem as a batch job is slightly different depending on your scheduler. 
If you aren't familiar with scheduling jobs on your system, ask your system administrator for guidance.


Those are the basics of using GEOS-Chem Classic! 
See the user guide, step-by-step guides, and reference pages for more detailed instructions.
