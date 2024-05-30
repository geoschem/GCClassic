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
#. Clones the :ref:`get-code-repos-gc-sci`
   repo from GitHub to :file:`GCClassic/src/GEOS-Chem`;
#. Clones the :ref:`get-code-repos-hemco` repo from GitHub to
   :file:`GCClassic/src/HEMCO`;
#. Clones the :ref:`get-code-repos-other-cloudj` repo from GitHub to
   :file:`GCClassic/src/Cloud-J`;
#. Clones the :ref:`get-code-repos-other-hetp` repo from GitHub to
   :file:`GCClassic/src/HETP`; and
#. Clones the :ref:`get-code-repos-other-docs` from GitHub to
   :file:`GCClassic/docs/source/geos-chem-shared-docs`.

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

.. code-block:: console

   $ git clone https://github.com/geoschem/GCClassic.git
   Cloning into 'GCClassic'...
   remote: Enumerating objects: 4410, done.
   remote: Counting objects: 100% (1309/1309), done.
   remote: Compressing objects: 100% (629/629), done.
   remote: Total 4410 (delta 714), reused 1257 (delta 676), pack-reused 3101
   Receiving objects: 100% (4410/4410), 2.10 MiB | 8.12 MiB/s, done.
   Resolving deltas: 100% (2377/2377), done.
   Submodule 'geos-chem-shared-docs' (https://github.com/geoschem/geos-chem-shared-docs.git) registered for path 'docs/source/geos-chem-shared-docs'
   Submodule 'Cloud-J' (https://github.com/geoschem/Cloud-J.git) registered for path 'src/Cloud-J'
   Submodule 'GEOS-Chem' (https://github.com/geoschem/geos-chem.git) registered for path 'src/GEOS-Chem'
   Submodule 'HEMCO' (https://github.com/geoschem/hemco.git) registered for path 'src/HEMCO'
   Submodule 'src/HETerogeneous-vectorized-or-Parallel' (https://github.com/geoschem/HETerogeneous-vectorized-or-Parallel) registered for path 'src/HETP'
   Cloning into '/n/holyscratch01/jacob_lab/ryantosca/tests/14.4.0/release/example/docs/source/geos-chem-shared-docs'...
   remote: Enumerating objects: 356, done.
   remote: Counting objects: 100% (110/110), done.
   remote: Compressing objects: 100% (71/71), done.
   remote: Total 356 (delta 66), reused 79 (delta 39), pack-reused 246
   Receiving objects: 100% (356/356), 524.63 KiB | 8.46 MiB/s, done.
   Resolving deltas: 100% (205/205), done.
   Cloning into '/n/holyscratch01/jacob_lab/ryantosca/tests/14.4.0/release/example/src/Cloud-J'...
   remote: Enumerating objects: 488, done.
   remote: Counting objects: 100% (149/149), done.
   remote: Compressing objects: 100% (56/56), done.
   remote: Total 488 (delta 104), reused 102 (delta 93), pack-reused 339
   Receiving objects: 100% (488/488), 715.91 KiB | 9.67 MiB/s, done.
   Resolving deltas: 100% (241/241), done.
   Cloning into '/n/holyscratch01/jacob_lab/ryantosca/tests/14.4.0/release/example/src/GEOS-Chem'...
   remote: Enumerating objects: 88738, done.
   remote: Counting objects: 100% (8421/8421), done.
   remote: Compressing objects: 100% (2309/2309), done.
   remote: Total 88738 (delta 6574), reused 7742 (delta 6093), pack-reused 80317
   Receiving objects: 100% (88738/88738), 98.58 MiB | 11.35 MiB/s, done.
   Resolving deltas: 100% (72704/72704), done.
   Cloning into '/n/holyscratch01/jacob_lab/ryantosca/tests/14.4.0/release/example/src/HEMCO'...
   remote: Enumerating objects: 4752, done.
   remote: Counting objects: 100% (1546/1546), done.
   remote: Compressing objects: 100% (423/423), done.
   remote: Total 4752 (delta 1177), reused 1426 (delta 1117), pack-reused 3206
   Receiving objects: 100% (4752/4752), 2.88 MiB | 21.06 MiB/s, done.
   Resolving deltas: 100% (3458/3458), done.
   Cloning into '/n/holyscratch01/jacob_lab/ryantosca/tests/14.4.0/release/example/src/HETP'...
   remote: Enumerating objects: 97, done.
   remote: Counting objects: 100% (97/97), done.
   remote: Compressing objects: 100% (69/69), done.
   remote: Total 97 (delta 37), reused 68 (delta 21), pack-reused 0
   Receiving objects: 100% (97/97), 81.51 KiB | 937.00 KiB/s, done.
   Resolving deltas: 100% (37/37), done.
   Submodule path 'docs/source/geos-chem-shared-docs': checked out '285d5904561a34d7c7941681a4fed19a68e1201f'
   Submodule path 'src/Cloud-J': checked out '3162ea8baa9ab69c3b8473270abc0188ad54501b'
   Submodule path 'src/GEOS-Chem': checked out 'c4c4c146ed9cd6bb8af42f080b766a0a0119b4a5'
   Submodule path 'src/HEMCO': checked out 'fddcae53f73327e0da7f0a505b4d07a53dd0930b'
   Submodule 'geos-chem-shared-docs' (https://github.com/geoschem/geos-chem-shared-docs.git) registered for path 'src/HEMCO/docs/source/geos-chem-shared-docs'
   Cloning into '/n/holyscratch01/jacob_lab/ryantosca/tests/14.4.0/release/example/src/HEMCO/docs/source/geos-chem-shared-docs'...
   remote: Enumerating objects: 356, done.
   remote: Counting objects: 100% (110/110), done.
   remote: Compressing objects: 100% (71/71), done.
   remote: Total 356 (delta 66), reused 79 (delta 39), pack-reused 246
   Receiving objects: 100% (356/356), 524.63 KiB | 8.33 MiB/s, done.
   Resolving deltas: 100% (205/205), done.
   Submodule path 'src/HEMCO/docs/source/geos-chem-shared-docs': checked out '4bb2b11e35953a8b0a8e1aec9161479bf0fc6bb6'
   Submodule path 'src/HETP': checked out '2a99b24625ed26cf87ae88697ddd6cf8bbdec812'

When the :command:`git clone` process has finished, navigate into the
:file:`GCClassic` folder and get a directory listing:

.. code-block:: console

   $ cd GCClassic
   $ ls -CF src/*
   src/CMakeLists.txt

   src/Cloud-J:
   AUTHORS.txt   CMakeLists.txt  CONTRIBUTING.md  LICENSE    src/        tables/
   CHANGELOG.md  CMakeScripts/   docs/            README.md  SUPPORT.md  tools/

   src/GEOS-Chem:
   APM/          CMakeLists.txt  GeosRad/   Headers/     KPP/         ObsPack/   run/
   AUTHORS.txt   CMakeScripts/   GeosUtil/  History/     LICENSE.txt  PKUCPL/    test/
   CHANGELOG.md  GeosCore/       GTMM/      Interfaces/  NcdfUtil/    README.md

   src/HEMCO:
   AUTHORS.txt   CMakeLists.txt  CONTRIBUTING.md  LICENSE.txt  run/    src/
   CHANGELOG.md  CMakeScripts/   docs/            README.md    spack@  SUPPORT.md

   src/HETP:
   CHANGELOG.md  CMakeLists.txt  CMakeScripts/  LICENSE  README.md  src/


This confirms that the :file:`GCClassic/src/GEOS-Chem` and
:file:`GCClassic/src/HEMCO` folders have been populated with source
code from the GitHub repositories listed above.

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

Instead of :file:`feature/my-git-updates`, you may choose a name that reflects
the nature of your updates (e.g. :file:`feature/new_reactions`, etc.).

.. note::

   This naming convention adheres to the `Github Flow
   <https://guides.github.com/introduction/flow/>`_
   conventions (i.e. new feature branches start with
   :file:`feature/`, bug fix branches start with :file:`bugfix/`, etc.

If you now type:

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
