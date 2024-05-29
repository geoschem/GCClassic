.. _restart-files-hco:

###################
HEMCO restart files
###################

In this chapter, you will learn more about HEMCO restart files.

.. _restart-files-hco-spinup:

==========================================================
Do I need a HEMCO restart file for my initial spin-up run?
==========================================================

Using a HEMCO restart file for your initial spin up run is optional.

The HEMCO restart file contains fields for initializing variables
required for Soil NOx emissions, MEGAN biogenic emissions, and the UCX
chemistry quantities. The HEMCO restart file that comes with a run
directory may only be used for the date and time indicated in the
filename. HEMCO will automatically recognize when a restart file is
not available for the date and time required, and in that case HEMCO
will use default values to initialize those fields. You can also force
HEMCO to use the default initialization values by setting
:code:`HEMCO_RESTART` to false in :file:`HEMCO_Config.rc`.

.. _restart-files-hco-info:

====================
For more information
====================

Please see `HEMCO diagnostics (at hemco.readthedocs.io)
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/diagnostics.html>`_
for more information about restart files and other diagnostic
outputs from HEMCO.
