.. _outfiles-other:

#############################
Other diagnostic output files
#############################

.. _outfiles-other-hco:

=======================
HEMCO diagnostic output
=======================

`HEMCO diagnostics
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/diagnostics.html>`_
generate :ref:`netCDF-format <coards-guide>` files in the :file:`OutputDir/`
subdirectory of your :ref:`GEOS-Chem run directory <rundir>`.  You may
change this filepath by editing the :ref:`cfg-hco-cfg` configuration
file.

HEMCO diagnostic files use the naming convention
:file:`HEMCO_diagnostics.YYYYMMDDhhmm.nc`, where :literal:`YYYYMMDD`
and :literal:`hhmm` refer to the model date and time at which each
file was created.

For more information, please see our HEMCO user manual at
`hemco.readthedocs.io <https://hemco.readthedocs.io>`_.

.. _outfiles-other-plane:

=============================
Planeflight diagnostic output
=============================

The :ref:`GEOS-Chem plane-following diagnostic
<planeflight-diagnostic>` generates text files in the top-level
of your  :ref:`GEOS-Chem Classic run directory <rundir>`. You may
change this filepath by editing the :ref:`planeflight section of
geoschem_config.yml <gc-yml-xdiag-plane>`.

Planeflight diagnostic files use the naming convention
:file:`plane.log.YYYYMMDDhhmm`, where :literal:`YYYYMMDD` refers to
the model date at which each diagnostic file is created.

.. _outfiles-other-obspack:

=========================
ObsPack diagnostic output
=========================

The :ref:`GEOS-Chem ObsPack diagnostic <obspack-diagnostic>`
generates :ref:`netCDF-format <coards-guide>` files in the top-level of
your :ref:`GEOS-Chem Classic run directory <rundir>`.  You may change
this filepath by editing the :ref:`ObsPack section of
geoschem_config.yml <gc-yml-xdiag-obspack>`.

ObsPack diagnostic files use the naming convention
:file:`GEOS-Chem.ObsPack.YYYYMMDD_hhmmz.nc4`, where
:literal:`YYYYMMDD` and :literal:`hhmm` refers to the model date
a which each diagnostic file is created, and :literal:`z` refers to
UTC (aka Zulu time).
