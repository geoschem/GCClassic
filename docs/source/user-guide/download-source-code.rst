.. _downloading-source-code:

Downloading source code
=======================

.. _geos-chem-classic-source-code-repositories:

GEOS-Chem Classic source code repositories
----------------------------------------------

The GEOS-Chem Classic source code is distributed into 3 Github
repositories, as described below. This setup allows the GEOS-Chem core
science routines to be easily integrated into several modeling
contexts (e.g. as GEOS-Chem Classic, as GCHP, as GEOS-Chem within the
NASA/GEOS ESM, as GEOS-Chem within CESM, etc). This aligns with our
`GEOS-Chem Vision <http://acmg.seas.harvard.edu/geos/geos_overview.html>`_ and
`Mission <http://acmg.seas.harvard.edu/geos/index.htmlGEOS-Chem>`_ statements.

.. _geos-chem-science-codebase:

GEOS-Chem Science Codebase
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The GEOS-Chem "Science" Codebase repository
(`https://github.com/geoschem/geos-chem <https://github.com/geoschem/geos-chem>`_) 
contains the GEOS-Chem science routines, plus:

- Scripts to create GEOS-Chem run directories

- Scripts to create GEOS-Chem integration tests

- Interfaces (i.e. the driver programs) for GEOS-Chem "Classic", GCHP,
  etc.

.. _hemco:

HEMCO
~~~~~~~~~

The HEMCO repository (`https://github.com/geoschem/HEMCO <https://github.com/geoschem/HEMCO>`_) contains the
source code for the `Harmonized Emissions Component <https://hemco.readthedocs.io>`_, which is used to
read and regrid emissions, met fields, and other inputs to GEOS-Chem.

.. _gcclassic:

GCClassic
~~~~~~~~~~~~~

The GCClassic repository (`https://github.com/geoschem/GCClassic <https://github.com/geoschem/GCClassic>`_) is a
lightweight wrapper that encompasses GEOS-Chem and HEMCO. We say 
that GCClassic is the **superproject** (i.e. top-level source code
folder), and that GEOS-Chem (science codebase) and HEMCO are
**submodules**.

.. _step-by-step-download-directions:

Step-by-step download directions
--------------------------------

Follow these directions to download the GEOS-Chem Classic source code:

.. _clone-the-gcclassic-superproject-repository:


1. Clone the GCClassic superproject repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Type this command to download the latest stable GEOS-Chem "Classic"
version:

.. code-block:: console

    $ git clone https://github.com/geoschem/GCClassic.git

This will clone a fresh copy of the GCClassic superproject from Github
to your computer system. If you do not specify a name, this command will
clone the superproject into a folder named ``GCClassic``. By default, the
``git clone`` command will create a local folder with the same name as the
remote repository.

.. note:: You can clone the GEOS-Chem Classic superproject into a
	  differently-named folder by specifying a new name after the
	  URL, for example:

          .. code-block:: console::

             $ https://github.com/geoschem/GCClassic GCClassic.13.1.1

Once you type the git clone command, you will see output similar to
this.

.. code-block:: console

    Cloning into 'GCClassic'...
    remote: Enumerating objects: 34, done.
    remote: Counting objects: 100% (34/34), done.
    remote: Compressing objects: 100% (25/25), done.
    remote: Total 737 (delta 12), reused 31 (delta 9), pack-reused 703
    Receiving objects: 100% (737/737), 138.79 KiB | 1.46 MiB/s, done.
    Resolving deltas: 100% (383/383), done.=

.. _examine-the-contents-of-the-gcclassic-folder:

2. Examine the contents of the GCClassic folder
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now get a directory listing for the GCClassic superproject folder. Type:

.. code-block:: console

    $ ls -CF

You should see the following content:

.. code-block:: console

    CMakeLists.txt  LICENSE  run@  src/

Here :file:`CMakeLists.txt` is a file needed by the CMake build system, :file:`run@`
is a symbolic link and :file:`src/` is a folder.

You might surmise that the GEOS-Chem and HEMCO source codes are
contained in the :file:`src/` folder. Type:

.. code-block:: console

    $ ls -CF src/*

and you will see this output:

.. code-block:: console

    src/CMakeLists.txt  src/gc_classic_version.H@  src/main.F90@

    src/GEOS-Chem:

    src/HEMCO:

Another CMake file, more symbolic links and empty :file:`src/GEOS-Chem` and
:file:`src/HEMCO` folders. Where are the GEOS-Chem and HEMCO codes?

.. _fetch-the-geos-chem-and-hemco-source-codes:

3. Fetch the GEOS-Chem and HEMCO source codes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :file:`/src/GEOS-Chem` and :file:`src/HEMCO` code folders are empty because the
GEOS-Chem and HEMCO source codes have not been "fetched" into the
GCClassic superproject folder. This is because GEOS-Chem and HEMCO are
tracked as **Git submodules** by the GCClassic superproject.

Think of the :file:`GCClassic` superproject as a "historian" for the GEOS-Chem
and HEMCO submodules (which will be stored in the :file:`src/GEOS-Chem` and
:file:`src/HEMCO` folders, respectively). For example, when a programmer
checks in new commits in :file:`src/GEOS-Chem` or in :file:`src/HEMCO`, the
programmer must also make a corresponding commit to the :file:`GCClassic`
superproject. This commit informs the :file:`GCClassic` superproject about the
updates that were in the :file:`src/GEOS-Chem` or :file:`src/HEMCO` folders. In
other words, the :file:`GCClassic` superproject repository must not only keep
track of its own Git history, but also of the Git histories of the
GEOS-Chem and HEMCO repositories as well. That is why we say GCClassic
is like a "historian" for GEOS-Chem and HEMCO repositories.

To check out the GEOS-Chem and HEMCO source code at the proper points in
their version history, type:

.. code-block:: console

    $ git submodule update --init --recursive

You will see output similar to this:

.. code-block:: console

    Submodule 'src/GEOS-Chem' (https://github.com/geoschem/geos-chem.git) registered for path 'src/GEOS-Chem'
    Submodule 'src/HEMCO' (https://github.com/geoschem/hemco.git) registered for path 'src/HEMCO'
    Cloning into 'GCClassic/src/GEOS-Chem'...
    Cloning into 'GCClassic/src/HEMCO'...
    Submodule path 'src/GEOS-Chem': checked out '22c503be96fa2dd848eb2fba142beb6d92a09889'
    Submodule path 'src/HEMCO': checked out 'edf987e03f23be2d7588324bd62a52eb9c646248'

The ``Submodule path`` statements indicate the commits on which the
:file:`src/GEOS-Chem` and src/HEMCO codes were placed on. More on this in a
bit.

If we now get a directory listing:

.. code-block:: console

    $ ls -CF src/*

we see that the ":file:`src/GEOS-Chem` and :file:`src/HEMCO` folders contain
directory structures full of source code:

.. code-block:: console

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

3.1 Pro tip: Define an alias for git submodule update
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Because you will use the ``git submodule update`` command very often, we
recommend that you define an alias for it. Simply add this text to your
:file:`~/.bash_aliases` startup file:

.. code-block:: bash

    alias gsu="git submodule update --init --recursive"

and then apply the changes with:

.. code-block:: console

    $ source ~/.bash_aliases

Now you can type ``gsu`` instead of ``git submodule update --init --recursive``.

.. _create_a_new_branch_in_src_geos_chem:

4. Create a branch in src/GEOS-Chem for your work
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When you fetch the code in the GEOS-Chem and HEMCO submodules with the
``git submodule update --init --recursive`` command (as described above),
the GEOS-Chem and HEMCO submodule codes will be in **detached HEAD
state**. In other words, the code is checked out but a branch is not 
created. Adding new code to a detached HEAD state is very dangerous and
should be avoided. You should instead make a branch at the same point as
the detached HEAD, and then add your own modifications into that branch.

Navigate from the GCClassic superproject folder to the GEOS-Chem
submodule:

.. code-block:: console

    $ cd src/GEOS-Chem
    $ git branch

You will see output similar to this:

.. code-block:: console

    *(HEAD detached at xxxxxxxx)
    main

where ``xxxxxxxx`` denotes the hash of the commit at which the code
has been checked out.

At ths point, you may now create a branch in which to store your own
modifications to the GEOS-Chem science codebase.  Type:

.. code-block:: console

   $ git branch feature/my-git-updates
   $ git checkout feature/my-git-updates

.. note::  This naming convention adheres to the
	   `Github Flow <https://guides.github.com/introduction/flow/>`_ 
	   conventions (i.e. new feature branches start with
	   ``feature/``, bug fix branches start with ``bugfix/``, etc.

Instead of  ``feature/my-git-updates``, you may choose a name that reflects
the nature of your updates (e.g. ``feature/new_reactions``, etc.)  If
you now type:

.. code-block:: console

   $ git branch

You will see that we are checked out onto the branch that you just
created and are no longer in detached HEAD state.
  
.. code-block:: console

   * feature/my-git-updates
   main

At this point, you may proceed to add your modifications into the
GEOS-Chem Science Codebase.
