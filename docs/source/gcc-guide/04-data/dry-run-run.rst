.. _dry-run-run:

############################
Execute a dry-run simulation
############################

Follow the steps below to perform a GEOS-Chem Classic dry-run simulation:

.. tip::

   Also be sure to watch our video tutorial `Using the updated
   dry-run capability in GEOS-Chem 13.2.1 and later versions
   <https://www.youtube.com/watch?v=ZLSXrjHqJAs&t=35s>`_
   at our `GEOS-Chem Youtube Channel
   <https://youtube.com/c/geoschem/>`_, which will guide you
   through these steps.

==========================
Complete preliminary setup
==========================

Make sure that you have done the following steps;

#. :ref:`Downloaded GEOS-Chem Classic source code <get-code>`
#. :ref:`Compiled the source code <compile>`
#. :ref:`Configured your simulation <cfg>`

Then doublecheck these settings in the following **configuration files**:

.. option:: geoschem_config.yml

   #. Set the start and end dates of the simulation. This setting will
      determine how much data needs to be downloaded from one of the
      GEOS-Chem data mirrors to your local disk space.
   #. Also doublecheck that the path to your data directory (ExtData)
      is correct.
   #. Also see :ref:`geoschem-config` for more information.

.. option:: HISTORY.rc

   #. Set the frequency and duration for the :ref:`HISTORY diagnostic
      <history-diagnostics>` collections to be consistent with the
      settings in   :option:`geoschem_config.yml`.

.. option:: HEMCO_Config.rc

   #. Set the :envvar:`DiagnFreq` parameter to be consistent
      with the simulation length defined in
      :option:`geoschem_config.yml`
   #. Select the emission inventories and data sets that
      you wish to use in your GEOS-Chem simulation.

.. tip::

   You can reduce the amount of data that needs to be downloaded for
   your GEOS-Chem simulation by turning off inventories that you don't
   need.

.. _dry-run-run-flag:

=============================================
Run the executable with the ``--dryrun`` flag
=============================================

Run the GEOS-Chem Classic executable file at the command line with the
:command:`--dryrun` command-line argument as shown below:

.. code-block:: console

   $ ./gcclassic --dryrun | tee log.dryrun

The :program:`tee` command will send the output of the dryrun to the
screen as well as to a file named :file:`log.dryrun`.

The :file:`log.dryrun` file will look somewhat like a regular
GEOS-Chem log file but will also contain a list of data files and
whether each file was found on disk or not.  This information will be
used by the :file:`download_data.py` script in the next step.

You may use whatever name you like for the dry-run output
log file (but we prefer :file:`log.dryrun`).  You will need this file
to download data (:ref:`see the next chapter <dry-run-download>`).
