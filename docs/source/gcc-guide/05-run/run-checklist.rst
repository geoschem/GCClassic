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

#. Make sure that your computational environment meets all of the
   :ref:`hardware <req-hard>` and
   :ref:`software <req-soft>` requirements for GEOS-Chem Classic.

.. _run-checklist-each:

===============
Each-time setup
===============

#. Make sure that you have :ref:`properly configured your
   login environment <login-env>`
   (i.e. load necessary software modules after login, etc.) |br|
   |br|

#. Create a :ref:`GEOS-Chem Classic run directory <rundir>`,
   and make sure that it is correct for the simulation you wish to
   perform. |br|
   |br|

   .. attention::
   
      The initial :ref:`restart file that is included with your run
      directory <restart-files>` does not reflect the actual
      atmospheric state and should only be used to "spin-up" the
      model. We recommend a spin-up period of 6 months to 1 year
      (depending on the type of simulation you are using).

#. :ref:`Edit configuration files <cfg>` to specify the runtime
   behavior of GEOS-Chem Classic..

   .. attention::
    
      Prior to running with :option:`GEOS-FP` met fields, please be
      aware  of several caveats regarding that data stream. (cf. `The
      GEOS-FP wiki page <http://wiki.geos-chem.org./GEOS-FP>`_).
      
#. :ref:`Configure and build <compile>` the source code into an
   executable file. |br|
   |br|

#. Copy a sample :ref:`GEOS-Chem Classic run script <gc-run-script>` to
   your run directory and edit it for the particulars of your
   simulation and computer system. |br|
   |br|

#. Make sure that your run script contains the proper settings for
   :ref:`OpenMP parallelization <env-files-envvars-parallel>`. |br|
   |br|

#. Be aware of :ref:`ways in which you can speed up your GEOS-Chem
   Classic simulations <speeding-up-simulations>`.




