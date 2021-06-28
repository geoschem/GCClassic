GEOS-Chem Classic
=================

.. important:: This is a prerelease of the GEOS-Chem Classic user guide.
   These pages are the most up-to-date and accurate instructions for GCHP, but they
   are still a work in progress. 
   
   Contributions (e.g., suggestions, edits, revisions) would be greatly appreciated. See
   :ref:`editing this guide <editing_this_user_guide>` and our :doc:`contributing guidelines <reference/CONTRIBUTING.md>`. 
   If you find a something hard to understand---let us know!

The `GEOS--Chem model <http://acmg.seas.harvard.edu/geos/>`_ is a
global 3-D model of atmospheric composition driven by assimilated
meteorological observations from the Goddard Earth Observing System (GEOS) of the `NASA Global Modeling and Assimilation Office <http://gmao.gsfc.nasa.gov/>`_.
It is applied by `research groups around the world
<http://acmg.seas.harvard.edu/geos/geos_people.html>`_ to a wide range
of atmospheric composition problems.

* `GEOS-Chem Overview <http://acmg.seas.harvard.edu/geos/geos_overview.html>`_
* `Narrative description of GEOS-Chem <http://acmg.seas.harvard.edu/geos/geos_chem_narrative.html>`_

This site provides instructions for GEOS-Chem Classic,
GEOS-Chem's single-node variant. We provide instruction for
downloading and compiling GEOS-Chem Classic, plus its required
software libraries.

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

   user-guide/libraries.rst
   user-guide/environment.rst

.. toctree::
   :maxdepth: 4
   :caption: Supplemental guides

   supplement/run-script-examples.rst
   supplement/spack.rst
    
.. toctree::
   :maxdepth: 4
   :caption: Reference
	     
   geos-chem-shared-docs/editing_these_docs.rst
   reference/known-bugs.rst
