.. _env:

################################
Customize your login environment
################################

.. tip::

   You may :ref:`skip ahead <get-code>` if you will be using
   :program:`GEOS-Chem Classic` on an Amazon EC2 cloud instance.
   When you initialize the EC2 instance with one of the pre-configured Amazon
   Machine Images  (AMIs) all of the required software libraries will be
   automatically loaded.

.. tip::

   If your computer system lacks the required software packages for
   :program:`GEOS-Chem Classic`, you can build them with the Spack
   package manager.  For detailed instructions, please see our
   :ref:`spackguide` supplemental guide.

Each time you log in to your computer system, you'll need to load
the :ref:`software libraries <req-soft>` needed by
GEOS-Chem into your environment. You can do this with a script known
as an **environment file**, as described in the following chapters:

.. toctree::
   :maxdepth: 1

   login-env-files.rst
   login-env-files-gnu.rst
   login-env-files-intel.rst
   login-env-compilers.rst
   login-env-parallel.rst
