.. _get-code-repos:

########################
Source code repositories
########################

The :program:`GEOS-Chem Classic` source code is distributed into 3
Github repositories, as described below. This setup allows the
GEOS-Chem core science routines to be easily integrated into several
modeling contexts, such as:

- GEOS-Chem Classic
- GCHP
- GEOS-Chem within the NASA/GEOS ESM
- GEOS-Chem within CESM (aka CESM-GC)
- GEOS-Chem withn WRF (aka WRF-GC)

This repository setup also aligns with our `GEOS-Chem Vision
<http://geos-chem.org/geos-overview>`_ and `Mission
<http://geos-chem.org>`_ statements.

.. _get-code-repos-gc:

==========================
GEOS-Chem Science Codebase
==========================

The GEOS-Chem "Science" Codebase repository
(`https://github.com/geoschem/geos-chem
<https://github.com/geoschem/geos-chem>`_) contains the GEOS-Chem
science routines, plus:

  - Scripts to create GEOS-Chem run directories

  - Scripts to create GEOS-Chem integration tests

  - Interfaces (i.e. the driver programs) for GEOS-Chem
    Classic, GCHP, etc.

.. _get-code-repos-hemco:

=====
HEMCO
=====

The HEMCO repository (`https://github.com/geoschem/HEMCO
<https://github.com/geoschem/HEMCO>`_) contains the source code for
the `Harmonized Emissions Component <https://hemco.readthedocs.io>`_,
which is used to read and regrid emissions, met fields, and other
inputs to GEOS-Chem.

.. _get-code-repos-gcclassic:

=========
GCClassic
=========

The GCClassic repository (`https://github.com/geoschem/GCClassic
<https://github.com/geoschem/GCClassic>`_) is a lightweight wrapper
that encompasses GEOS-Chem and HEMCO. We say that GCClassic is the
**superproject** (i.e. top-level source code folder), and that
GEOS-Chem (science codebase) and HEMCO are **submodules**.
