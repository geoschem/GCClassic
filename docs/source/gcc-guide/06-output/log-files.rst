.. _outfiles-logs:

#########
Log files
#########

Log files redirect the output of Fortran :code:`PRINT*` or
:code:`WRITE` statements to a file. You can check the log files for an
"echo-back" of simulation options, as well as error messages.

.. _outfiles-logs-gclog:

==================
GEOS-Chem log file
==================

File name: :file:`GC.log` (or similar)

Contains an "echo-back" of input options that were specified in
:ref:`geoschem_config.yml <cfg-gc-yml>` and :ref:`HISTORY.rc
<cfg-hist>`, as well as information about what is happening at each
GEOS-Chem timestep.  If your GEOS-Chem Classic simulation dies with an
error, a detailed error message will be printed in this log file.

.. _outfiles-logs-dryrun:

======================================
GEOS-Chem log file with dry-run output
======================================

File name: :file:`log.dryrun` (or similar)

Contains the full path names of all input files (configuration files,
meteorology files, emissions files) that are read by GEOS-Chem. This
will allow users to download only those files that their GEOS-Chem
simulation requires, thus speeding up the data downloading
process.

For more information, please see the :ref:`dry run <dry-run>` chapter.

==============================
GEOS-Chem species metadata log
==============================

File name: :file:`OutputDir/geoschem_species_metadata.yml`

Contains metadata (taken from the  :ref:`GEOS-Chem species database
<cfg-spec-db>`) in YAML format for only those species that are used in
the simulation.  This facilitates coupling GEOS-Chem to other Earth
System Models.

.. _outfiles-logs-hemco:

==============
HEMCO log file
==============

File name: :file:`HEMCO.log`

Contains information about how emissions, met fields, and other
relevant data are read from disk and processed by `HEMCO
<https://hemco.readthedocs.io>`_ for input into GEOS-Chem Classic.

.. _outfiles-logs-timers:

===============
Timers log file
===============

File name: :file:`gcclassic_timers.json` (in `JSON
<https://www.w3schools.com/js/js_json_intro.asp>`_ format).

The timers log file is created when you set :code:`use_gcclassic_timers:
true` in :ref:`the Simulation Settings section of geoschem_config.yml
<gc-yml-simulation>`. It contains "wall-clock" times that measure how
long each component of GEOS-Chem took to execute.  This information is
used by the GEOS-Chem benchmarking scripts that execute on the
Amazon cloud computing platform.

.. _outfiles-logs-sched:

==================
Scheduler log file
==================

File name: Specific to each scheduler.

If you used a batch scheduler such as SLURM, PBS, LSF, etc. to submit
your GEOS-Chem Classic simulation, then output from the Unix stdout
and/or stderr streams may be printed to this file. This file may contain
important error messages.
