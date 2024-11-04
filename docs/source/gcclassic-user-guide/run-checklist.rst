.. |br| raw:: html

   <br/>

.. _run-checklist:

###############################
Complete this pre-run checklist
###############################

Now that you have created a :ref:`run script <run-script>` for
GEOS-Chem Classic, take a moment to make sure that you have completed
all required setup steps before running your simulation.

.. _run-checklist-first:

================
First-time setup
================

#. If this is your first-time using GEOS-Chem, make sure that you
   :ref:`registered as a new user <rundir-registration>` when you
   created the run directory. |br|
   |br|

#. Make sure that your computational environment meets all of the
   :ref:`hardware <req-hard>` and
   :ref:`software <req-soft>` requirements for GEOS-Chem Classic.

.. _run-checklist-each:

===============
Each-time setup
===============

#. Make sure that you have :ref:`properly configured your
   login environment <env>` (i.e. load necessary software modules
   after login, etc.) |br|
   |br|

#. Create a :ref:`GEOS-Chem Classic run directory <rundir>`,
   and make sure that it is correct for the simulation you wish to
   perform.

   .. attention::

      The initial :ref:`restart file that is included with your run
      directory <restart-files>` does not reflect the actual
      atmospheric state and should only be used to "spin-up" the
      model. We recommend a spin-up period of 6 months to 1 year
      (depending on the type of simulation you are using).

#. :ref:`Edit configuration files <cfg>` to specify the runtime
   behavior of GEOS-Chem Classic..

   .. attention::

      Prior to running with GEOS-FP meteorology, be aware
      that it is an operational (i.e. evolving) product
      that is subject to assimilation system updates.

      On the other hand, the MERRA-2 meterology is a 40+
      year reanalysis product performed with a "frozen" version of the
      NASA GEOS assimilation system.  Thus, `MERRA-2
      <http://wiki.geos-chem.org/MERRA-2>`_ is preferable for studies
      ranging over multiple years or decades.

#. :ref:`Configure and build <compile>` the source code into an
   executable file. |br|
   |br|

#. Create a :ref:`GEOS-Chem Classic run script <run-script>` to
   your run directory and edit it for the particulars of your
   simulation and computer system. |br|
   |br|

#. Make sure that your run script contains the proper settings for
   :ref:`OpenMP parallelization <env-files-envvars-parallel>`, either
   by sourcing an environment file, or by manually adding the settings
   to the run script. |br|
   |br|

#. Be aware of :ref:`ways in which you can speed up your GEOS-Chem
   Classic simulations <run-speedup>`.
