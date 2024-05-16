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

Then doublecheck these settings in the following :ref:`configuration
files <cfg>`:

.. option:: geoschem_config.yml

   #. :option:`start_date`: Set the start date and time for your simulation.
   #. :option:`end_date`: Set the end date and time for your simulation.
   #. :option:`met_field`: Check if the meteorology setting 
      (:option:`GEOS-FP`, :option:`MERRA2`, :option:`GCAP2`) is
      correct for your simulation.
   #. :option:`root_data_dir`: Make sure that the path to
      :file:`ExtData` is correct.

.. option:: HISTORY.rc

   #. Set the frequency and duration for each :ref:`diagnostic
      collection <histguide-collections>` to be consistent with the
      settings in :option:`geoschem_config.yml`.

.. option:: HEMCO_Config.rc

   #. Check the `Settings section
      <https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html#settings>`_
      to make sure that diagnostic frequency :envvar:`DiagnFreq`: is
      set to the interval that you wish (e.g. :envvar:`Monthly`,
      :envvar:`Daily`, :envvar:`YYYYMMDD hhmmss`, etc).
   #. Check the `Extension Settings section
      <https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html#extension-switches>`_,
      to make sure all of the required emissions inventories and data
      sets for your simulation have been switched on.

   .. tip::
 
      You can reduce the amount of data that needs to be downloaded for
      your simulation by turning off inventories that you don't need.

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
