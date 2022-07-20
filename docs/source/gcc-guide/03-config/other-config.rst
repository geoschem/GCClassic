.. _cfg-other:

################################################
Configuration files for photolysis and chemistry
################################################

Edit these configuration files **only if you are changing the
photolysis or chemistry mechanisms**.  Otherwise you can skip to the
next section.

.. _cfg-other-photol:

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

Please see the following references for more information about KPP:

#. The KPP user manual (`kpp.readthedocs.io <https://kpp.readthedocs.io>`_)
#. The :ref:`kppguide` Guide
