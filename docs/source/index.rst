.. _geos-chem-classic:

#################
GEOS-Chem Classic
#################
.. raw:: html

   <p>
   <a href="https://github.com/geoschem/GCClassic/releases"><img src="https://img.shields.io/github/v/release/geoschem/GCClassic?include_prereleases&label=Latest%20Pre-Release"></a>
   <a href="https://github.com/geoschem/GCClassic/releases"><img src="https://img.shields.io/github/v/release/geoschem/GCClassic?label=Latest%20Stable%20Release"></a>
   <a href="https://github.com/geoschem/GCClassic/releases/"><img src="https://img.shields.io/github/release-date/geoschem/GCClassic"></a><br/>
   <a href="https://doi.org/10.5281/zenodo.4437678"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.4437678.svg" alt="DOI"></a>
   <a href="https://github.com/geoschem/GCClassic/blob/main/LICENSE.txt"><img src="https://img.shields.io/badge/License-MIT-blue.svg"></a>
   <a href="https://geos-chem.readthedocs.io/en/latest/"><img src="https://img.shields.io/readthedocs/geos-chem?label=ReadTheDocs"></a>
   </p>

This site provides instructions for :program:`GEOS-Chem Classic`,
the single-node mode of operation of the
`GEOS-Chem model <http://geos-chem.org/>`_.  We provide
instruction for downloading and compiling GEOS-Chem Classic, plus its
required software libraries.

.. note::

   If you would like to run GEOS-Chem on more than one node of a
   computing system, consider using
   `GEOS-Chem High Performance (GCHP) <https://gchp.readthedocs.io>`_.

GEOS-Chem is a global 3-D model of atmospheric composition driven by
assimilated meteorological observations from the Goddard Earth
Observing System (GEOS) of the `NASA Global Modeling and Assimilation
Office <http://gmao.gsfc.nasa.gov/>`_.
It is applied by `research groups around the world
<http://acmg.seas.harvard.edu/geos/geos_people.html>`_  to a wide
range of atmospheric composition problems.

* `GEOS-Chem Overview <http://geos-chem.org/geos-overview>`_
* `Narrative description of GEOS-Chem <http://geos-chem.org/geos-chem-narrative>`_

Cloning and building from source code ensures you will have direct
access to the latest available versions of GEOS-Chem Classic, provides
additional compile-time options, and allows you to make your own
modifications to GEOS-Chem Classic source code.

.. toctree::
   :caption: Getting Started
   :maxdepth: 2

   getting-started/quick-start.rst
   getting-started/system-req-hard.rst
   getting-started/system-req-soft.rst
   getting-started/login-env.rst
   getting-started/key-references.rst

.. toctree::
   :caption: GEOS-Chem Classic User Guide
   :maxdepth: 2

   gcclassic-user-guide/get-code.rst
   gcclassic-user-guide/create-rundir.rst
   gcclassic-user-guide/compile.rst
   gcclassic-user-guide/config-overview.rst
   gcclassic-user-guide/download-data.rst
   gcclassic-user-guide/run.rst
   gcclassic-user-guide/output-files.rst
   gcclassic-user-guide/diagnostics.rst

.. toctree::
   :caption: GEOS-Chem Simulations
   :maxdepth: 4

   geos-chem-shared-docs/simulations/aerosol-only.rst
   geos-chem-shared-docs/simulations/carbon.rst
   geos-chem-shared-docs/simulations/fullchem.rst
   geos-chem-shared-docs/simulations/hg.rst
   geos-chem-shared-docs/simulations/metals.rst
   geos-chem-shared-docs/simulations/tago3.rst
   geos-chem-shared-docs/simulations/transport-tracers.rst

.. toctree::
   :caption: Supplemental guides
   :maxdepth: 4

   supplemental-guides/directory-structure.rst
   supplemental-guides/run-script-examples.rst
   geos-chem-shared-docs/supplemental-guides/load-libraries-guide.rst
   geos-chem-shared-docs/supplemental-guides/spack-guide.rst
   geos-chem-shared-docs/supplemental-guides/customize-guide.rst
   geos-chem-shared-docs/supplemental-guides/error-guide.rst
   geos-chem-shared-docs/supplemental-guides/debug-guide.rst
   geos-chem-shared-docs/supplemental-guides/bashdatacatalog.rst
   geos-chem-shared-docs/supplemental-guides/history-diag-guide.rst
   geos-chem-shared-docs/supplemental-guides/netcdf-guide.rst
   geos-chem-shared-docs/supplemental-guides/coards-guide.rst
   geos-chem-shared-docs/supplemental-guides/species-guide.rst
   geos-chem-shared-docs/supplemental-guides/parallel-guide.rst
   supplemental-guides/nested-grid-guide.rst
   geos-chem-shared-docs/supplemental-guides/using-kpp-with-gc.rst
   geos-chem-shared-docs/supplemental-guides/using-kpp-standalone.rst
   geos-chem-shared-docs/supplemental-guides/related-docs.rst

.. toctree::
   :maxdepth: 1
   :caption: Help & Reference

   help-and-reference/version-history.rst
   help-and-reference/known-bugs.rst
   help-and-reference/CONTRIBUTING.md
   help-and-reference/SUPPORT.md
   geos-chem-shared-docs/editing_these_docs.rst

