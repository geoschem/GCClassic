#################
GEOS-Chem Classic
#################
.. raw:: html

   <p>
   <a href="http://wiki.seas.harvard.edu/geos-chem/index.php/GEOS-Chem_versions"><img src="https://img.shields.io/github/v/release/geoschem/GCClassic?label=Latest%20Release"></a>
   <a href="https://doi.org/10.5281/zenodo.5014891"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.5014891.svg" alt="DOI"></a>
   <a href="https://geos-chem.readthedocs.io/en/latest/"><img src="https://img.shields.io/readthedocs/geos-chem?label=ReadTheDocs"></a>
   <a href="https://dev.azure.com/geoschem/GCClassic/_build"><img src="https://img.shields.io/azure-devops/build/geoschem/GCClassic/15/main?label=Build%20Matrix"></a>
   <a href="https://hub.docker.com/r/geoschem/gcclassic"><img src="https://img.shields.io/docker/v/geoschem/gcclassic?color=blue&label=Docker%2FSingularity"></a>
   <a href="https://github.com/geoschem/GCClassic/releases"><img src="https://img.shields.io/github/v/release/geoschem/GCClassic?include_prereleases&label=Latest%20Pre-Release"></a>
   </p>


.. important:: This is a prerelease of the GEOS-Chem Classic user guide.
   These pages are still a work in progress.

   Contributions (e.g., suggestions, edits, revisions) would be greatly appreciated. See
   :ref:`editing this guide <editing_this_user_guide>` and our :doc:`contributing guidelines <reference/CONTRIBUTING.md>`.
   If you find a something hard to understand---let us know!
   

This site provides instructions for :program:`GEOS-Chem Classic`,
the single-node mode of operation of the
`GEOS-Chem model <http://acmg.seas.harvard.edu/geos/>`_.  We provide instruction for
downloading and compiling GEOS-Chem Classic, plus its required software libraries.
   
GEOS-Chem is a global 3-D model of atmospheric composition driven by
assimilated meteorological observations from the Goddard Earth
Observing System (GEOS) of the `NASA Global Modeling and Assimilation
Office <http://gmao.gsfc.nasa.gov/>`_. 
It is applied by `research groups around the world
<http://acmg.seas.harvard.edu/geos/geos_people.html>`_  to a wide range
of atmospheric composition problems.

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
   :maxdepth: 4
   :caption: Getting Started

   getting-started/quick-start.rst
   getting-started/hardware-requirements.rst
   getting-started/software-requirements.rst
   getting-started/key-references.rst

.. toctree::
   :maxdepth: 4
   :caption: User Guide

   user-guide/configure-environment.rst
   user-guide/download-source-code.rst
   user-guide/create-rundir.rst
   user-guide/compile-geos-chem.rst
   user-guide/dry-run.rst
   
.. toctree::
   :maxdepth: 4
   :caption: Supplemental guides

   supplement/directory-structure.rst
   supplement/run-script-examples.rst
   supplement/libraries.rst
   supplement/spack.rst

.. toctree::
   :maxdepth: 4
   :caption: Reference

   geos-chem-shared-docs/editing_these_docs.rst
   reference/known-bugs.rst
