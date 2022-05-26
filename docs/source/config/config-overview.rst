.. _config-overview:

#############################################
Summary of GEOS-Chem user configuration files
#############################################

This page describes the configuration files that are read by
:program:`GEOS-Chem Classic`.

.. _rundir-config-files:

=================================
Run directory configuration files
=================================

:ref:`As discussed previously <create-rundir>`, each run directory
contains several user-editable configuration files that control the
runtime behavior of GEOS-Chem.  These are listed below:

.. option:: geoschem_config.yml

   Contains user-editable settings that specify options for the given
   GEOS-Chem simulation. (cf :ref:`geoschem-config`)

.. option:: HEMCO_Config.rc

   Contain user-editable settings that control which emission
   inventories and other data sets will be read into GEOS-Chem via
   HEMCO. (cf. :ref:`hemco-config`).

.. option:: HEMCO_Diagn.rc

   Contains user-editable settings that tell HEMCO which diagnostic
   quantities to archive. (cf. :ref:`hemco-diagn`)

.. option:: HISTORY.rc

   Contains user-editable settings that specify which GEOS-Chem
   diagnostics will be archived. (cf. :ref:`history`)

.. _photolysis_mechanism:

========================================
Photolysis mechanism configuration files
========================================

These are found in the ``ExtData/CHEM_INPUTS/FAST_JX/`` directory
structure. Please see `Input files for FAST-JX
v7.0 <FAST-JX_v7.0_photolysis_mechanism#Input_files_for_FAST-JX_v7.0>`__
for details.

You do not need to modify any of these files unless you wish to change
the default photolysis settings.

.. _chemical_mechanism:

======================================
Chemical mechanism configuration files
======================================

Chemical mechanism configuration files are located in these folders:

.. option:: KPP/fullchem

   Contains configuration files for the default "full-chemistry"
   mechanism (NOx + Ox + aerosols + Br + Cl + I).

   - :file:`fullchem.kpp`: Main configuration file for the
     **fullchem** mechanism.

   - :file:`fullchem.eqn`: List of species and reactions
     for the **fullchem** mechanism.

.. option:: KPP/Hg

   Contains configuration files for the mercury chemistry mechanism:

   - :file:`Hg.kpp`: Main configuration file for the **Hg**
     mechanism.

   - :file:`Hg.eqn`: List of species and reactions for the **Hg**
     mechanism.

.. option:: KPP/custom

   Contains configuration files that you can edit if you need to
   create a custom mechanism.   We recommend that you create the
   custom in this folder and leave :file:`KPP/fullchem` and
   :file:`KPP/Hg` untouched.

   - :file:`custom.kpp`: Copy of :file:`fullchem.kpp`

   - :file:`custom.eqn`: Copy of :file:`fullchem.eqn`.

Please see :ref:`kppguide` for more information on how to use KPP to
create chemical solver source code for GEOS-Chem.
