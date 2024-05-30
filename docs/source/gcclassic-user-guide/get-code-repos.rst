.. _get-code-repos:

########################
Source code repositories
########################

The :program:`GEOS-Chem Classic` source code is distributed into
several GitHub repositories (aka "repos"), as described below. This
setup allows the GEOS-Chem core science routines to be easily
integrated into several modeling contexts, such as:

- GEOS-Chem Classic
- GCHP
- GEOS-Chem within the NASA/GEOS ESM
- GEOS-Chem within CESM
- GEOS-Chem withn WRF (aka WRF-GC)

This repository setup also aligns with our `GEOS-Chem Vision
<http://geos-chem.org/overview>`_ and `Mission
<http://geos-chem.org/>`_ statements.

.. _get-code-repos-gc:

======================
GEOS-Chem repositories
======================

The bulk of the GEOS-Chem Classic code is contained in three repositories:

.. _get-code-repos-gc-sci:

GEOS-Chem "Science Codebase"
----------------------------

The :program:`GEOS-Chem "Science Codebase"` repository
(`https://github.com/geoschem/geos-chem
<https://github.com/geoschem/geos-chem>`_) contains the GEOS-Chem
science routines, plus:

  - Scripts to create GEOS-Chem run directories, plus template
    configuration files for all simulations;

  - Scripts to create GEOS-Chem integration tests;

  - Interfaces (i.e. the driver programs) for GEOS-Chem
    Classic, GCHP, etc.

.. _get-code-repos-hemco:

HEMCO
-----

The :program:`HEMCO` repository (`https://github.com/geoschem/HEMCO
<https://github.com/geoschem/HEMCO>`_) contains the source code for
the `Harmonized Emissions Component <https://hemco.readthedocs.io>`_,
which is used to read and regrid emissions, met fields, and other
inputs to GEOS-Chem.

.. _get-code-repos-gcclassic:

GCClassic
---------

The :program:`GCClassic` repository
(`https://github.com/geoschem/GCClassic
<https://github.com/geoschem/GCClassic>`_) is a lightweight wrapper
that encompasses GEOS-Chem and HEMCO. We say that GCClassic is the
**superproject** (i.e. top-level source code folder), and that
GEOS-Chem (science codebase) and HEMCO are **submodules**.


.. _get-code-repos-other:

=====================================
Other code packages used by GEOS-Chem
=====================================

GEOS-Chem uses a few code packages that are maintained separately.
These are inlined to GEOS-Chem as Git submodules.

.. _get-code-repos-other-cloudj:

Cloud-J
-------

The :program:`Cloud-J` repository
(https://github.com/geoschem/Cloud-J) contains the source code for
the Cloud-J photolysis package.  This is used to compute reaction
rates for photo-dissociation reactions in the GEOS-Chem fullchem and
Hg chemistry mechanisms.

Reference: :cite:t:`Prather_2015`

.. _get-code-repos-other-hetp:

ISORROPIA/HETP
--------------

The :program:`ISORROPIA/HETP` repository
(https://github.com/geoschem/HETerogeneous-vectorized-or-Parallel)
contains the source code for HETP, which is an implementation of the
ISORROPIA II aerosol thermodynamics scheme written in modern Fortran.

Reference: :cite:t:`Miller_et_al._2024`

.. _get-code-repos-other-docs:

geos-chem-shared-docs
---------------------

The :program:`geos-chem-shared-docs` repository
(https://github.com/geoschem/geos-chem-shared-docs) contains common
documentation files that are shared by the `GEOS-Chem
<https://geos-chem.readthedocs.io>`_, `GCHP
<https://gchp.readathedocs.io>`_, and `HEMCO
<https://hemco.readthedocs.io>`_ ReadTheDocs pages. This repository is
maintained by the GEOS-Chem Support Team.
