.. |br| raw:: html

   <br/>

.. _env-files:

#################
Environment files
#################

An environment file is a script that:

#. Loads software libraries into your login environment.  This is
   often done with a module manager such as :command:`lmod`,
   :command:`spack`, or  :command:`environment-modules`. |br|
   |br|

#. Stores settings for GEOS-Chem and its dependent libraries in
   shell variables called `environment variables
   <https://www.networkworld.com/article/3215965/all-you-need-to-know-about-unix-environment-variables.html>`_.

You will **source** the environment file each time you log in with a
command such as:

.. code-block:: console

   $ . ~/my-environment-file   # or whatever you name it

.. tip::

   Keep a separate environment file for each combination of
   modules that you will use.  Example environment files
   for :ref:`GNU <env-files-gnu>` and :ref:`Intel <env-files-intel>`
   compilers and related software are provided in the following sections.

For general information about how libraries are loaded, see
:ref:`libguide`.
