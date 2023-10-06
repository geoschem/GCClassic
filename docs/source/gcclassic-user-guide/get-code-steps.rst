.. _get-code-steps:

#####################
Download instructions
#####################

Follow these directions to download the GEOS-Chem Classic source code.

.. _get-code-steps-clone-gcclassic:

====================================
Clone GCClassic and fetch submodules
====================================

To download the latest stable GEOS-Chem Classic version, type:

.. code-block:: console

    $ git clone --recurse-submodules https://github.com/geoschem/GCClassic.git

This command does the following:

#. Clones the :ref:`GCClassic <get-code-repos-gcclassic>` repo from
   GitHub to a local folder named :file:`GCClassic`;
#. Clones the :ref:`GEOS-Chem Science Codebase <get-code-repos-gc>`
   repo from GitHub to :file:`GCClassic/src/GEOS-Chem`; and
#. Clones the :ref:`HEMCO <get-code-repos-hemco>` repo from GitHub to :file:`GCClassic/src/HEMCO`.

.. tip::

   To download GEOS-Chem Classic source code into a folder named
   something other than :file:`GCClassic`, supply the name of the
   folder at the end of the :command:`git clone` command.  For example:

   .. code-block:: console

      git clone --recurse-submodules https://github.com/geoschem/GCClassic.git my-code-dir

   will download the GEOS-Chem Classic source code into
   :file:`my-code-dir` instead of :file:`GCClassic`.

Once the :command:`git clone` process starts, you should see output
similar to this:

.. code-block:: text

   Cloning into 'GCClassic'...
   remote: Enumerating objects: 2680, done.
   remote: Counting objects: 100% (1146/1146), done.
   remote: Compressing objects: 100% (312/312), done.
   remote: Total 2680 (delta 858), reused 1099 (delta 825), pack-reused 1534
   Receiving objects: 100% (2680/2680), 1.74 MiB | 13.16 MiB/s, done.
   Resolving deltas: 100% (1411/1411), done.
   Submodule 'docs/source/geos-chem-shared-docs' (https://github.com/geoschem/geos-chem-shared-docs.git) registered for path 'docs/source/geos-chem-shared-docs'
   Submodule 'src/GEOS-Chem' (https://github.com/geoschem/geos-chem.git) registered for path 'src/GEOS-Chem'
   Submodule 'src/HEMCO' (https://github.com/geoschem/hemco.git) registered for path 'src/HEMCO'
   Cloning into '/local/ryantosca/GC/rundirs/epa-kpp/tmp/GCClassic/docs/source/geos-chem-shared-docs'...
   remote: Enumerating objects: 148, done.
   remote: Counting objects: 100% (148/148), done.
   remote: Compressing objects: 100% (103/103), done.
   remote: Total 148 (delta 77), reused 116 (delta 45), pack-reused 0
   Receiving objects: 100% (148/148), 162.29 KiB | 2.90 MiB/s, done.
   Resolving deltas: 100% (77/77), done.
   Cloning into '/local/ryantosca/GC/rundirs/epa-kpp/tmp/GCClassic/src/GEOS-Chem'...
   remote: Enumerating objects: 75574, done.
   remote: Counting objects: 100% (410/410), done.
   remote: Compressing objects: 100% (187/187), done.
   remote: Total 75574 (delta 238), reused 364 (delta 216), pack-reused 75164
   Receiving objects: 100% (75574/75574), 85.23 MiB | 30.59 MiB/s, done.
   Resolving deltas: 100% (62327/62327), done.
   Cloning into '/local/ryantosca/GC/rundirs/epa-kpp/tmp/GCClassic/src/HEMCO'...
   remote: Enumerating objects: 3178, done.
   remote: Counting objects: 100% (638/638), done.
   remote: Compressing objects: 100% (195/195), done.
   remote: Total 3178 (delta 476), reused 585 (delta 438), pack-reused 2540
   Receiving objects: 100% (3178/3178), 2.24 MiB | 11.87 MiB/s, done.
   Resolving deltas: 100% (2270/2270), done.
   Submodule path 'docs/source/geos-chem-shared-docs': checked out '228507857eb53740dacf4055ce9268aa8ccf520d'
   Submodule path 'src/GEOS-Chem': checked out '7e51a0674aba638c8322fef493ac9251095e8cf4'
   Submodule path 'src/HEMCO': checked out '4a66bae48f33e6dc22cda5ec9d4633192dee2f73'
   Submodule 'docs/source/geos-chem-shared-docs' (https://github.com/geoschem/geos-chem-shared-docs.git) registered for path 'src/HEMCO/docs/source/geos-chem-shared-docs'
   Cloning into '/local/ryantosca/GC/rundirs/epa-kpp/tmp/GCClassic/src/HEMCO/docs/source/geos-chem-shared-docs'...
   remote: Enumerating objects: 148, done.
   remote: Counting objects: 100% (148/148), done.
   remote: Compressing objects: 100% (103/103), done.
   remote: Total 148 (delta 77), reused 116 (delta 45), pack-reused 0
   Receiving objects: 100% (148/148), 162.29 KiB | 3.00 MiB/s, done.
   Resolving deltas: 100% (77/77), done.
   Submodule path 'src/HEMCO/docs/source/geos-chem-shared-docs': checked out '645401baa35b6a6838b9bedede309a01a311517f'

When the :command:`git clone` process has finished, navigate into the
:file:`GCClassic` folder and get a directory listing:

.. code-block:: console

   $ cd GCClassic
   $ ls -CF src/*

and you will see output similar to this:

.. code-block:: text

   src/CMakeLists.txt  src/gc_classic_version.H@  src/main.F90@

   src/GEOS-Chem:
   APM/            CMakeScripts/  GeosUtil/  History/     lib/         ObsPack/   run/
   AUTHORS.txt     doc/           GTMM/      Interfaces/  LICENSE.txt  PKUCPL/
   bin/            GeosCore/      Headers/   ISORROPIA/   mod/         README.md
   CMakeLists.txt  GeosRad/       help/      KPP/         NcdfUtil/    REVISIONS

   src/HEMCO:
   AUTHORS.txt  CMakeLists.txt  CMakeScripts/  LICENSE.txt  README.md  run/  src/

This confirms that the :file:`GCClassic/src/GEOS-Chem` and
:file:`GCClassic/src/HEMCO` folders have been populated with source
code from the :ref:`GEOS-Chem Science Codebase <get-code-repos-gc>`
and :ref:`HEMCO <get-code-repos-hemco>` GitHub repositories.

.. tip::

   To use an older GEOS-Chem Classic version (e.g. 14.0.0), follow
   these additional steps:

   .. code-block:: console

      $ git checkout tags/14.0.0                  # Points HEAD to the tag "14.0.0"
      $ git branch version_14.0.0                 # Creates a new branch at tag "14.0.0"
      $ git checkout version_14.0.0               # Checks out the version_14.0.0 branch
      $ git submodule update --init --recursive   # Reverts submodules to the "14.0.0" tag

   You can do this for any tag in the version history.   For a list of
   all tags, type:

   .. code-block:: console

      $ git tag

   If you have any unsaved  changes, make sure you commit those to a
   branch prior to updating versions.

.. _get-code-steps-branch:

==============================================
Create a branch in src/GEOS-Chem for your work
==============================================

Whter the :program:`git clone` command :ref:`described above
<get-code-steps-clone-gcclassic>` finishes, the :ref:`GEOS-Chem
Science Codebase <get-code-repos-gc>` submodule code (in folder
:file:`GCClassic/src/GEOS-Chem`) and the :ref:`HEMCO
<get-code-repos-hemco>` submodule code (in folder
:file:`GCClassic/src/HEMCO`) will be in **detached HEAD state**. In
other words, the code is checked out but a branch is not
created. Adding new code to a detached HEAD state is very dangerous
and should be avoided. You should instead make a branch it the same
point as the detached HEAD, and then add your own modifications into
that branch.

Navigate from :file:`GCClassic` to :file:`GCClassic/src/GEOS-Chem`:

.. code-block:: console

    $ cd src/GEOS-Chem

and then type:

.. code-block:: console

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

.. note::

   If you need to also modify :ref:`HEMCO <get-code-repos-hemco>`
   source code, repeat the process above to create your own working
   branch in :file:`GCClassic/src/HEMCO`.

.. _get-code-steps-info:

========================
See additional resources
========================

For more information about downloading the GEOS-Chem source code,
please see the following Youtube video tutorials:

  - `Getting started with GEOS-Chem 13
    <https://www.youtube.com/watch?v=BV4BIj8WAxE>`_ (by Melissa Sulprizio)

  - `Managing branches between superproject and submodules
    <https://www.youtube.com/watch?v=1fhI-HObyV4>`_ (by Bob Yantosca)
