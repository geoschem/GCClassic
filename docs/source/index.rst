.. _geos-chem-classic:

#################
GEOS-Chem Classic
#################
.. raw:: html

   <p>
   <a href="https://github.com/geoschem/GCClassic/releases"><img src="https://img.shields.io/github/v/release/geoschem/GCClassic?include_prereleases&label=Latest%20Pre-Release"></a>
   <a href="https://github.com/geoschem/GCClassic/releases"><img src="https://img.shields.io/github/v/release/geoschem/GCClassic?label=Latest%20Stable%20Release"></a>
   <a href="https://github.com/geoschem/GCClassic/releases/"><img src="https://img.shields.io/github/release-date/geoschem/GCClassic"></a>
   <a href="https://doi.org/10.5281/zenodo.5014891"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.5014891.svg" alt="DOI"></a>
   <a href="https://github.com/geoschem/GCClassic/blob/main/LICENSE.txt"><img src="https://img.shields.io/badge/License-MIT-blue.svg"></a>
   <a href="https://geos-chem.readthedocs.io/en/latest/"><img src="https://img.shields.io/readthedocs/geos-chem?label=ReadTheDocs"></a>
   <a href="https://dev.azure.com/geoschem/GCClassic/_build"><img src="https://img.shields.io/azure-devops/build/geoschem/GCClassic/15/main?label=Build%20Matrix"></a>
   <a href="https://hub.docker.com/r/geoschem/gcclassic"><img src="https://img.shields.io/docker/v/geoschem/gcclassic?color=blue&label=Docker%2FSingularity"></a>
   </p>

This site provides instructions for :program:`GEOS-Chem Classic`,
the single-node mode of operation of the
`GEOS-Chem model <http://acmg.seas.harvard.edu/geos/>`_.  We provide
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

* `GEOS-Chem Overview <http://acmg.seas.harvard.edu/geos/geos_overview.html>`_
* `Narrative description of GEOS-Chem <http://acmg.seas.harvard.edu/geos/geos_chem_narrative.html>`_

Cloning and building from source code ensures you will have direct
access to the latest available versions of GEOS-Chem Classic, provides
additional compile-time options, and allows you to make your own
modifications to GEOS-Chem Classic source code.

.. toctree::
   :caption: Getting Started
   :maxdepth: 2

   gcc-guide/01-startup/key-references.rst
   gcc-guide/01-startup/system-req-hard.rst
   gcc-guide/01-startup/system-req-soft.rst
   gcc-guide/01-startup/login-env.rst


.. toctree::
   :caption: GEOS-Chem Classic User Guide
   :maxdepth: 2

   gcc-guide/02-build/get-code.rst
   gcc-guide/02-build/create-rundir.rst
   gcc-guide/02-build/compile.rst
   gcc-guide/03-config/config-overview.rst
   gcc-guide/04-data/download-data.rst
   gcc-guide/05-run/run.rst
   gcc-guide/06-output/output-files.rst
   gcc-guide/07-diagnostics/diagnostics.rst

.. toctree::
   :caption: Supplemental guides
   :maxdepth: 1

   gcclassic_supplement/directory-structure.rst
   gcclassic_supplement/run-script-examples.rst
   geos-chem-shared-docs/supplemental-guides/libraries.rst
   geos-chem-shared-docs/supplemental-guides/spack.rst
   geos-chem-shared-docs/supplemental-guides/parallel-guide.rst
   geos-chem-shared-docs/supplemental-guides/debug-guide.rst
   geos-chem-shared-docs/supplemental-guides/bashdatacatalog.rst
   geos-chem-shared-docs/supplemental-guides/netcdf-guide.rst
   geos-chem-shared-docs/supplemental-guides/coards-guide.rst
   geos-chem-shared-docs/supplemental-guides/species-guide.rst
   geos-chem-shared-docs/supplemental-guides/using-kpp-with-gc.rst
   geos-chem-shared-docs/supplemental-guides/related-docs.rst

.. toctree::
   :maxdepth: 1
   :caption: Help & Reference

   reference/version-history.rst
   reference/known-bugs.rst
   reference/CONTRIBUTING.md
   reference/SUPPORT.md
   geos-chem-shared-docs/editing_these_docs.rst
