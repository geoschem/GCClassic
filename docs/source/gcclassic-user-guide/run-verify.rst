.. |br| raw:: html

   <br/>

.. _running-verify:

##############################
Verify a successful simulation
##############################

There are several ways to verify that your GEOS-Chem Classic run was
successful:

#. The following output can be found at the end of the log file:

   .. code-block:: console

      **************   E N D   O F   G E O S -- C H E M   **************

#. NetCDF files (e.g. :file:`OutputDir/GEOSChem*.nc4` and
   :file:`OutputDir/HEMCO*.nc`) are present. |br|
   |br|

#. :ref:`restart-files`
   (e.g. :file:`GEOSChem.Restart.YYYYMMDD_hhmmz.nc4` and
   :file:`HEMCO_restart.YYYYMMDDhh.nc`) for ending date
   :code:`YYYYMMDD hhmm` are present. |br|
   |br|

#. Your scheduler log file (e.g. :file:`slurm-xxxxx.out`, where
   :code:`xxxxx` is the job id) is free of errors.

If your run stopped with an error, please see the following resources:

- :ref:`errguide`
- :ref:`debug-guide`
-  `Submitting GEOS-Chem support
   requests <https://geos-chem.readthedocs.io/en/stable/help-and-reference/SUPPORT.html>`_

