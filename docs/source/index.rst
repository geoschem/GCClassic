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
access to the latest available versions of GEOS-Chem CLassic, provides
additional compile-time options, and allows you to make your own
modifications to GEOS-Chem Classic source code.

Our `Quick Start Guide <getting-started/quick-start.html>`__ and the
`downloading <user-guide/downloading.html>`__, `compiling
<user-guide/compiling.html>`__, and `creating a run directory
<user-guide/rundir-init.html>`__ sections of the User Guide give
instructions specifically for using a clone of the source code.

.. toctree::
   :caption: Getting Started
   :maxdepth: 2

   starting/quick-start.rst
   starting/hardware-requirements.rst
   starting/software-requirements.rst
   starting/key-references.rst

.. toctree::
   :caption: Building GEOS-Chem Classic
   :maxdepth: 2

   building-gc/configure-environment.rst
   building-gc/download-source-code.rst
   building-gc/create-rundir.rst
   building-gc/compile-geos-chem.rst

.. toctree::
   :caption: Configuring runs
   :maxdepth: 2

   config/config-overview.rst
   config/geoschem-config.rst
   config/hemco-config.rst
   config/hemco-diagn.rst
   config/history.rst

.. toctree::
   :caption: Downloading input data
   :maxdepth: 2

   inputs/input-overview.rst
   inputs/restart-files.rst
   inputs/dry-run.rst

.. toctree::
   :caption: Running and analyzing results
   :maxdepth: 2

   running/running-gcclassic.rst

.. toctree::
   :caption: Output from GEOS-Chem Classic
   :maxdepth: 2

.. toctree::
   :caption: Diagnostics reference
   :maxdepth: 2

   diagnostics/hemco.rst
   diagnostics/history.rst
   diagnostics/obspack.rst
   diagnostics/planeflight.rst

.. toctree::
   :caption: Supplemental guides
   :maxdepth: 2

   gcclassic_supplement/directory-structure.rst
   gcclassic_supplement/run-script-examples.rst
   geos-chem-shared-docs/supplemental-guides/libraries.rst
   geos-chem-shared-docs/supplemental-guides/spack.rst
   geos-chem-shared-docs/supplemental-guides/debug-guide.rst
   geos-chem-shared-docs/supplemental-guides/bashdatacatalog.rst
   geos-chem-shared-docs/supplemental-guides/netcdf-guide.rst
   geos-chem-shared-docs/supplemental-guides/coards-guide.rst
   geos-chem-shared-docs/supplemental-guides/using-kpp-with-gc.rst
   geos-chem-shared-docs/supplemental-guides/related-docs.rst

.. toctree::
   :maxdepth: 2
   :caption: Reference

   reference/known-bugs.rst
   reference/CONTRIBUTING.md
   reference/SUPPORT.md
   geos-chem-shared-docs/editing_these_docs.rst
