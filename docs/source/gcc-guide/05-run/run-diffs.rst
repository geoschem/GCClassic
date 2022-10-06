.. |br| raw:: html

   <br/>

.. _run-diffs:

########################################
Minimize differences in multi-stage runs
########################################

If you need to split up a very long simulation (e.g. 1 model year or
more) into multiple stages, keep these guidelines in mind:

#. Make sure :code:`GC_RESTART` and :code:`HEMCO_RESTART` options are
   set to :code:`true:` in :ref:`HEMCO_Config.rc <cfg-hco-cfg>`. |br|
   |br|

#. To ensure your :ref:`restart_files <restart-files>` are read and
   species concentrations are properly initialized, check your
   GEOS-Chem log file for the following output:

   .. code-block:: console

      ===============================================================================
      R E S T A R T   F I L E   I N P U T
      Min and Max of each species in restart file [mol/mol]:``
      Species   1,       NO: Min = 1.000000003E-30  Max = 1.560991691E-08
      Species   2,       O3: Min = 3.135925075E-09  Max = 9.816152669E-06
      Species   3,      PAN: Min = 3.435056848E-25  Max = 1.222619450E-09
      ...

   Actual values may differ. If you see :code:`Use background = ...` for
   most or all species, that suggests your restart file was not found. To
   avoid using the wrong restart file make sure to use time cycle flag
   :code:`EY` in HEMCO_Config.rc (cf. :ref:`restart-files-gc-read`).
