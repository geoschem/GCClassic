.. _cfg:

#########################
Configure your simulation
#########################

.. note::

   We recommend that you configure your simulation before downloading
   data files.  You can use the configuration settings with a
   :ref:`dry-run simulation <dry-run>` to download only the data that
   you will need. 

You will need to edit various **configuration files** in order to
specify options for your GEOS-Chem Classic simulation.  These are
described below.

.. _cfg-rundir:

====================================
Commonly-updated configuration files
====================================

When starting a new GEOS-Chem Classic simulation, you will usually
edit most (if not all) of these configuration files:

.. toctree::
   :maxdepth: 1

   geoschem-config.rst
   hemco-config.rst
   hemco-diagn.rst
   history.rst

All of the above-mentioned files are included in your :ref:`GEOS-Chem
Classic run directory <rundir>`.

Please see our :ref:`customguide` Supplemental Guide to learn how you
can customize your simulation by activating alternate science options
in your simulations.

.. _cfg-other:

=========================================
Less-commonly updated configuration files
=========================================

If you need to add or delete species, or to change the default
photolysis and/or chemistry mechanism settings in your simulation,
you'll need to edit these configuration files:

.. toctree::
   :maxdepth: 1

   spec-db.rst
   phot-chem.rst
