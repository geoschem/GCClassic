.. _downloading-source-code:

####################
Download source code
####################

.. _geos-chem-classic-source-code-repositories:

==========================================
GEOS-Chem Classic source code repositories
==========================================

The :program:`GEOS-Chem Classic` source code is distributed into 3
Github repositories, as described below. This setup allows the
GEOS-Chem core science routines to be easily integrated into several
modeling contexts, such as:

- :program:`GEOS-Chem Classic`
- :program:`GCHP`
- GEOS-Chem within the :program:`NASA/GEOS ESM`
- GEOS-Chem within :program:`CESM`
- GEOS-Chem withn :program:`WRF`
  
This repository setup also aligns with our `GEOS-Chem Vision
<http://acmg.seas.harvard.edu/geos/geos_overview.html>`_ and `Mission
<http://acmg.seas.harvard.edu/geos/index.htmlGEOS-Chem>`_ statements.

.. _geos-chem-science-codebase:

GEOS-Chem Science Codebase
--------------------------

The GEOS-Chem "Science" Codebase repository
(`https://github.com/geoschem/geos-chem
<https://github.com/geoschem/geos-chem>`_) contains the GEOS-Chem
science routines, plus:

  - Scripts to create GEOS-Chem run directories

  - Scripts to create GEOS-Chem integration tests

  - Interfaces (i.e. the driver programs) for :program:`GEOS-Chem
    Classic`, :program:`GCHP`, etc.

.. _hemco:

HEMCO
-----

The HEMCO repository (`https://github.com/geoschem/HEMCO
<https://github.com/geoschem/HEMCO>`_) contains the source code for
the `Harmonized Emissions Component <https://hemco.readthedocs.io>`_,
which is used to read and regrid emissions, met fields, and other
inputs to GEOS-Chem. 

.. _gcclassic:

GCClassic
---------

The GCClassic repository (`https://github.com/geoschem/GCClassic
<https://github.com/geoschem/GCClassic>`_) is a lightweight wrapper
that encompasses GEOS-Chem and HEMCO. We say that GCClassic is the
**superproject** (i.e. top-level source code folder), and that
GEOS-Chem (science codebase) and HEMCO are **submodules**. 

.. _download-instructions:

=====================
Download instructions
=====================

Follow these directions to download the GEOS-Chem Classic source code:

.. _clone-the-gcclassic-superproject-repository:

Clone the GCClassic superproject repository
-------------------------------------------

Type this command to download the latest stable :program:`GEOS-Chem
Classic` version

.. code-block:: console

    $ git clone https://github.com/geoschem/GCClassic.git

This will clone the code into a local folder named :file:`GCClassic`.
    
.. tip::

   If you wish, you can clone the GCClassic superproject
   repository into a different local folder by supplying the
   name of the folder at the end of the :command:`git clone` command:

   .. code-block :: console
   
      git clone https://github.com/geoschem/GCClassic.git my-code
   
Once the :command:`git clone` process starts, you should see output
similar to this: 

.. code-block:: text

    Cloning into 'GCClassic'...
    remote: Enumerating objects: 34, done.
    remote: Counting objects: 100% (34/34), done.
    remote: Compressing objects: 100% (25/25), done.
    remote: Total 737 (delta 12), reused 31 (delta 9), pack-reused 703
    Receiving objects: 100% (737/737), 138.79 KiB | 1.46 MiB/s, done.
    Resolving deltas: 100% (383/383), done.

When the :command:`git clone` process has finished, navigate into the
local folder:

.. code-block:: console

   $ cd GCClassic
   
.. _fetch-gc-and-hemco:

Fetch the GEOS-Chem and HEMCO source codes
------------------------------------------

At this point we have cloned the GCClassic superproject
repository but we have not fetched source code from the underlying
GEOS-Chem science codebase and HEMCO submodules.  

To fetch the submodule codes, type:

.. code-block:: console

    $ git submodule update --init --recursive

You should see output similar to this:

.. code-block:: console

   Submodule 'src/GEOS-Chem' (https://github.com/geoschem/geos-chem.git) registered for path 'src/GEOS-Chem'
   Submodule 'src/HEMCO' (https://github.com/geoschem/hemco.git) registered for path 'src/HEMCO'
   Cloning into 'GCClassic/src/GEOS-Chem'...
   Cloning into 'GCClassic/src/HEMCO'...
   Submodule path 'src/GEOS-Chem': checked out '22c503be96fa2dd848eb2fba142beb6d92a09889'
   Submodule path 'src/HEMCO': checked out 'edf987e03f23be2d7588324bd62a52eb9c646248'

The :code:`Submodule path` statements indicate the commits on which the
:file:`src/GEOS-Chem` and :file:`src/HEMCO` codes were placed on

If we now get a directory listing:

.. code-block:: console

   $ ls -CF src/*

we see that the ":file:`src/GEOS-Chem` and :file:`src/HEMCO` folders contain
directory structures full of source code:

.. code-block:: text

   src/CMakeLists.txt  src/gc_classic_version.H@  src/main.F90@

   src/GEOS-Chem:
   APM/            CMakeScripts/  GeosUtil/  History/     lib/         ObsPack/   run/
   AUTHORS.txt     doc/           GTMM/      Interfaces/  LICENSE.txt  PKUCPL/
   bin/            GeosCore/      Headers/   ISORROPIA/   mod/         README.md
   CMakeLists.txt  GeosRad/       help/      KPP/         NcdfUtil/    REVISIONS

   src/HEMCO:
   AUTHORS.txt  CMakeLists.txt  CMakeScripts/  LICENSE.txt  README.md  run/  src/

and now you can see the various files and subdirectories that make up
the GEOS-Chem and HEMCO source codes.

.. _pro-tip-define-an-alias-for-the-git-submodule-update-command:   

Pro tip: Define an alias for git submodule update
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Because you will use the :command:`git submodule update` command very
often, we recommend that you define an alias for it. Simply add this
text to your :file:`~/.bash_aliases` startup file:

.. code-block:: bash

    alias gsu="git submodule update --init --recursive"

and then apply the changes with:

.. code-block:: console

    $ source ~/.bash_aliases

Now you can type :command:gsu` instead of :command:`git submodule
update --init --recursive`. 

.. _create_a_new_branch_in_src_geos_chem:

Create a branch in src/GEOS-Chem for your work
----------------------------------------------

When you fetch the code in the GEOS-Chem and HEMCO submodules with the
:command:`git submodule update --init --recursive` command
(cf :ref:`fetch-gc-and-hemco`), the GEOS-Chem and
HEMCO submodule codes will be in **detached HEAD state**. In
other words, the code is checked out but a branch is not
created. Adding new code to a detached HEAD state is very
dangerous and should be avoided. You should instead make a branch
at the same point as the detached HEAD, and then add your own
modifications into that branch. Navigate from the GCClassic
superproject folder to the GEOS-Chem submodule:

.. code-block:: console

    $ cd src/GEOS-Chem
    $ git branch

You will see output similar to this:

.. code-block:: text

    *(HEAD detached at xxxxxxxx)
    main

where ``xxxxxxxx`` denotes the hash of the commit at which the code
has been checked out.

At ths point, you may now create a branch in which to store your own
modifications to the GEOS-Chem science codebase.  Type:

.. code-block:: console

   $ git branch feature/my-git-updates
   $ git checkout feature/my-git-updates

.. note::

   This naming convention adheres to the
   `Github Flow <https://guides.github.com/introduction/flow/>`_ 
   conventions (i.e. new feature branches start with
   :file:`feature/`, bug fix branches start with :file:`bugfix/`, etc.

Instead of :file:`feature/my-git-updates`, you may choose a name that reflects
the nature of your updates (e.g. :file:`feature/new_reactions`, etc.)  If
you now type:

.. code-block:: console

   $ git branch

You will see that we are checked out onto the branch that you just
created and are no longer in detached HEAD state.
  
.. code-block:: text

   * feature/my-git-updates
   main

At this point, you may proceed to add your modifications into the
GEOS-Chem Science Codebase.

.. _download-code-more-info:

For more information
--------------------

For more information about downloading the GEOS-Chem source code,
please see the following Youtube video tutorials:

  - `Getting started with GEOS-Chem 13
    <https://www.youtube.com/watch?v=BV4BIj8WAxE>`_ (by Melissa Sulprizio)

  - `Managing branches between superproject and submodules
    <https://www.youtube.com/watch?v=1fhI-HObyV4>`_ (by Bob Yantosca)
