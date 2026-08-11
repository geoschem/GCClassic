.. _geos-chem-classic:

#################
GEOS-Chem Classic
#################
.. raw:: html

   <p>
     <a href="https://github.com/geoschem/GCClassic/releases"><img src="https://img.shields.io/github/v/release/geoschem/GCClassic?label=Latest%20Stable%20Release" alt="Latest release"></a>
     <a href="https://github.com/geoschem/GCClassic/releases/"><img src="https://img.shields.io/github/release-date/geoschem/GCClassic" alt="Release date"></a>
     <a href="https://doi.org/10.5281/zenodo.4437678"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.4437678.svg" alt="DOI"></a><br/>
     <a href="https://github.com/geoschem/GCClassic/blob/main/LICENSE.txt"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License"></a>
     <a href="https://github.com/geoschem/GCClassic/actions/workflows/gcclassic-compile-tests.yml"><img src="https://github.com/geoschem/GCClassic/actions/workflows/gcclassic-compile-tests.yml/badge.svg" alt="gcclassic-compile-tests"></a>
     <a href="https://geos-chem.readthedocs.io/en/latest/"><img src="https://img.shields.io/readthedocs/geos-chem?label=ReadTheDocs"  alt="ReadTheDocs"></a>
   </p>

This site provides instructions for :program:`GEOS-Chem Classic`,
the single-node mode of operation of the
`GEOS-Chem model <http://geos-chem.org/>`__.  We provide
instruction for downloading and compiling GEOS-Chem Classic, plus its
required software libraries.

.. note::

   If you would like to run GEOS-Chem on more than one node of a
   computing system, consider using
   `GEOS-Chem High Performance (GCHP) <https://gchp.readthedocs.io>`__.

GEOS-Chem is a global 3-D model of atmospheric composition driven by
assimilated meteorological observations from the Goddard Earth
Observing System (GEOS) of the `NASA Global Modeling and Assimilation
Office <http://gmao.gsfc.nasa.gov/>`__.
It is applied by `research groups around the world
<http://acmg.seas.harvard.edu/geos/geos_people.html>`__  to a wide
range of atmospheric composition problems.

* `GEOS-Chem Overview <http://geos-chem.org/geos-overview>`__
* `Narrative description of GEOS-Chem <http://geos-chem.org/geos-chem-narrative>`__

Cloning and building from source code ensures you will have direct
access to the latest available versions of GEOS-Chem Classic, provides
additional compile-time options, and allows you to make your own
modifications to GEOS-Chem Classic source code.

.. note::

   **Try it on your own computer.** GEOS-Chem Classic can be built and run at
   coarse resolution (e.g. 4° x 5°) on a personal laptop using the prebuilt
   dependency image ``billzhuge/geos-chem-deps`` on Docker Hub — no manual
   library setup required.

.. toctree::
   :caption: Getting Started
   :maxdepth: 2

   getting-started/quick-start
   getting-started/system-req-hard
   getting-started/system-req-soft
   getting-started/login-env
   getting-started/key-references

.. toctree::
   :caption: GEOS-Chem Classic User Guide
   :maxdepth: 2

   gcclassic-user-guide/get-code
   gcclassic-user-guide/create-rundir
   gcclassic-user-guide/compile
   gcclassic-user-guide/config-overview
   gcclassic-user-guide/download-data
   gcclassic-user-guide/run
   gcclassic-user-guide/output-files
   gcclassic-user-guide/diagnostics

.. toctree::
   :caption: GEOS-Chem Simulations
   :maxdepth: 1

   supplemental-guides/gcclassic-simulations
   geos-chem-shared-docs/simulations/aerosol-only
   geos-chem-shared-docs/simulations/carbon
   geos-chem-shared-docs/simulations/fullchem
   geos-chem-shared-docs/simulations/hg
   geos-chem-shared-docs/simulations/metals
   geos-chem-shared-docs/simulations/tago3
   geos-chem-shared-docs/simulations/transport-tracers

.. toctree::
   :maxdepth: 1
   :caption: Supplemental Science Guides

   geos-chem-shared-docs/supplemental-guides/science-guides
   geos-chem-shared-docs/supplemental-guides/apm-guide
   geos-chem-shared-docs/supplemental-guides/ate-guide
   geos-chem-shared-docs/supplemental-guides/aerosols-guide
   geos-chem-shared-docs/supplemental-guides/cloud-conv-guide
   geos-chem-shared-docs/supplemental-guides/drydep-guide
   geos-chem-shared-docs/supplemental-guides/pm25-pm10-guide
   geos-chem-shared-docs/supplemental-guides/pbl-mixing-guide
   geos-chem-shared-docs/supplemental-guides/photolysis-guide
   geos-chem-shared-docs/supplemental-guides/phys-consts-guide
   geos-chem-shared-docs/supplemental-guides/rrtmg-guide
   geos-chem-shared-docs/supplemental-guides/tomas-guide
   geos-chem-shared-docs/supplemental-guides/wetdep-guide

.. toctree::
   :caption: Supplemental Technical Guides
   :maxdepth: 1

   supplemental-guides/technical-guides
   supplemental-guides/directory-structure
   supplemental-guides/horizontal-grids
   supplemental-guides/vertical-grids
   supplemental-guides/run-script-examples
   supplemental-guides/run-gcc-on-cloud
   geos-chem-shared-docs/supplemental-guides/load-libraries-guide
   geos-chem-shared-docs/supplemental-guides/spack-guide
   geos-chem-shared-docs/supplemental-guides/customize-guide
   geos-chem-shared-docs/supplemental-guides/custom-emissions-guide
   geos-chem-shared-docs/supplemental-guides/error-guide
   geos-chem-shared-docs/supplemental-guides/debug-guide
   geos-chem-shared-docs/supplemental-guides/bashdatacatalog
   geos-chem-shared-docs/supplemental-guides/history-diag-guide
   geos-chem-shared-docs/supplemental-guides/netcdf-guide
   geos-chem-shared-docs/supplemental-guides/coards-guide
   geos-chem-shared-docs/supplemental-guides/species-guide
   geos-chem-shared-docs/supplemental-guides/parallel-guide
   supplemental-guides/nested-grid-guide
   geos-chem-shared-docs/supplemental-guides/using-kpp-with-gc
   geos-chem-shared-docs/supplemental-guides/using-kpp-standalone
   geos-chem-shared-docs/supplemental-guides/related-docs

.. toctree::
   :maxdepth: 1
   :caption: Help & Reference

   help-and-reference/version-history
   help-and-reference/known-bugs
   help-and-reference/CONTRIBUTING.md
   help-and-reference/SUPPORT.md
   geos-chem-shared-docs/editing_these_docs
