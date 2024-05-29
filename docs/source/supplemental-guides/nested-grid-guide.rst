.. |br| raw:: html

   <br/>

.. _nestgrid-guide:

###########################
Run nested-grid simulations
###########################

A **nested-grid simulation** is a GEOS-Chem Classic simulation running
at the native horizontal resolution of the GEOS-FP (0.25° x 0.3125°)
or MERRA-2 (0.5° x 0.6125°) meteorology fields over a subset of
the globe.  Nested-grid simulations use boundary conditions for
transport that are archived from a global simulatoin.

Follow these steps to set up a GEOS-Chem Classic nested-grid
simulation:

.. _nestgrid-global-sim:

=====================================================
Run a global simulation to create boundary conditions
=====================================================

1. Download the GEOS-Chem source code
-------------------------------------

Download the GEOS-Chem Classic source code by :ref:`following these
instructions <get-code-steps>`.


2. Create a global simulation run directory
-------------------------------------------

:ref:`Create a run directory <rundir>` for your global simulation by
executing these commands:

.. code-block:: console

   $ cd /path/to/GCClassic/run   # or whatever you named the source code directory
   $ ./createRunDir.sh

and then follow the prompts.

.. tip::

   A 4° x 5° global simulation should be adequate for producing
   boundary condition output.

3. Activate the BoundaryConditions diagnostic collection
--------------------------------------------------------

The :literal:`BoundaryConditions` diagnostic collection is deactivated
by default in the :ref:`HISTORY.rc configuration file
<histguide-configfile>` that ships with the run directory. Activate
this collection by removing the comment character (:literal:`#`) as
shown below.

.. code-block:: none

   COLLECTIONS: 'Restart',
                'SpeciesConc',
                ... etc ...
                #'BoundaryConditions',    <== Remove the # sign in front
   ::


The :literal:`BoundaryConditions` collection will save out
instantaneous concentrations of advected species every three hours to
daily files. You may change those settings by modifying the
BoundaryConditions collection section in the :ref:`HISTORY.rc
<histguide-configfile>` file.

.. tip::

   If you wish to save disk space, Use the :literal:`.LON_RANGE` and
   :literal:`.LAT_RANGE` to reduce the size of the region in which the
   boundary conditions will be saved.  The region in which the
   boundary condition is archived should be a little larger than the
   nested-grid simulation window.

   .. code-block:: none

      #==============================================================================
      # %%%%% THE BoundaryConditions COLLECTION %%%%%
      #
      # GEOS-Chem boundary conditions for use in nested grid simulations
      #
      # Available for all simulations
      #==============================================================================
        BoundaryConditions.template:   '%y4%m2%d2_%h2%n2z.nc4',
        BoundaryConditions.format:     'CFIO',
        BoundaryConditions.frequency:  00000000 030000
        BoundaryConditions.duration:   00000001 000000
        BoundaryConditions.mode:       'instantaneous'
        BoundaryConditions.LON_RANGE:  -130.0 -60.0,
        BoundaryConditions.LAT_RANGE:   10.0 60.0,
        BoundaryConditions.fields:     'SpeciesBC_?ADV?             ', 'GIGCchem',
      ::

4. Configure the global simulation
-----------------------------------

Configure your global simulation by :ref:`changing settings in the
relevant configuration files <cfg>`. If you do not need the output
from your global simulation, you may choose to turn off most of the
diagnostic output in :file:`HISTORY.rc` and :file:`HEMCO_Diagn.rc`.

.. tip::

   Turn off most diagnostic output in the :ref:`HISTORY.rc
   <histguide-configfile>` and :ref:`cfg-hco-diagn` files.  This will
   minimize the run time and reduce the size of diagnostic ouptut.

5. Compile GEOS-Chem and run the global simulation
--------------------------------------------------

Follow the steps outlined in these sections to compile and run your
GEOS-Chem global simulation.

#. :ref:`compile`
#. :ref:`data` (e.g. do a dry-run and download data if necessary)
#. :ref:`run`

Once your global simulation finishes, the boundary conditions files
will be placed into the :file:`OutputDir` subdirectory of your run
directory.  You should see files named
:file:`GEOSChem.BoundaryConditions.YYYYMMDD_0000z.nc4` (where
:literal:`YYYYMMDD` are replaced by the simulation date) begin to
appear in your run directory as your simulation runs.  You will need
to tell your nested-grid simulation where to find these files.

.. _nestgrid-nest-sim:

=====================================
Set up your nested grid run directory
=====================================

1. Create a nested-grid simulation run directory
------------------------------------------------

Using the same GEOS-Chem Classic source code directory that :ref:`we
downloaded above <nestgrid-global-sim>` follow these steps to
:ref:`create a run directory <rundir>` for your nested-grid simulation.

.. code-block:: console

   $ cd /path/to/GCClassic/run   # or whatever you named the source code directory
   $ ./createRunDir.sh

Select the native resolution corresponding to your choice of
meteorology.  You will then be asked to specify which nested region
you would like to use.

2. Configure your nested-grid simulation
----------------------------------------

Check the :ref:`run-directory configuration files <cfg>` to make sure
that you have the same chemistry, emissions, transport, etc. options
selected as in the global simulation.

In :ref:`cfg-hco-cfg`, make sure the :literal:`GC_BCs` option is set
to :literal:`true` and update the :literal:`BC_` entry to point to
your boundary condition files.

.. code-block:: none

   # ExtNr ExtName                on/off  Species
   0       Base                   : on    *
   # ----- RESTART FIELDS ----------------------
       --> GC_RESTART             :       true
       --> GC_BCs                 :       true    <== make sure this is true
       --> HEMCO_RESTART          :       true
   ...
   #==============================================================================
   # --- GEOS-Chem boundary condition file ---
   #==============================================================================
   (((GC_BCs
   * BC_  /path/to/your/GEOSChem.BoundaryConditions.$YYYY$MM$DD_$HH$MNz.nc4 SpeciesBC_?ADV?  1980-2023/1-12/1-31/0-23 RFY xyz 1 * - 1 1
   )))GC_BCs

Activate your preferred diagnostics by changing the relevant settings
in these configuration files:

#. :ref:`histguide-configfile`
#. :ref:`cfg-hco-diagn`
#. :ref:`Planeflight.dat.YYYYMMDD <planeflight-diagnostic>`
#. :ref:`The ObsPack menu of geoschem_config.yml <gc-yml-xdiag-obspack>`

3. Copy the executable to the nested-grid run directory
-------------------------------------------------------

You do not have to recompile GEOS-Chem Classic when changing grids.
Therefore, you can copy the :literal:`gcclassic` executable from your
:ref:`global simulation <nestgrid-global-sim>` run directory to your
nested-grid run directory.


4. Run the nested-grid simulation
---------------------------------

Follow the steps outlined in these sections to run your nested-grid
simulation.

#. :ref:`data` (e.g. do a dry-run and download data if necessary)
#. :ref:`run`


.. _nestgrid-faq:

==========================
Frequently asked questions
==========================

.. _nestgrid-faq-aws:

Can I run nested GEOS-Chem simulations on the AWS cloud?
--------------------------------------------------------

Yes, you can run the nested grid simulations on AWS cloud. Please see
the `Running GEOS-Chem on AWS cloud online
tutorial <https://cloud-gc.readthedocs.io/en/latest/>`_ and contact the
`GEOS-Chem Support Team <GEOS-Chem_Support_Team>`_ with any questions.

.. _nestgrid-faq-multiple-bcs:

Can I save out boundary conditions for more than one nested grid in the same global run?
-----------------------------------------------------------------------------------------

We recommend that you :ref:`generate boundary conditions
<nestgrid-global-sim>` over the entire global domain (at 4° x 5° or 2°
x 2.5°).  Then these boundary conditions can be used as input to
simulations on different nested domains.

.. _nestgrid-faq-data:

How can I find which data are available for nested grid simulations?
--------------------------------------------------------------------

You will download meteorology and emissions data from one of the
:ref:`GEOS-Chem data portals <input-overview>`.  You can browse the
WashU data portal (`http://geoschemdata.wustl.edu/ExtData
<http://geoschemdata.wustl.edu/ExtData>`_) to see if the data you need
are available.

.. _nestgrid-faq-errors:

Where can I find out more info about nested grid errors?
--------------------------------------------------------

Please see the following Supplemental Guides:

#. :ref:`errguide`
#. :ref:`debug-guide`

.. _nestgrid-faq-abnormal:

I noticed abnormal concentrations at boundaries of the nested region. Is that normal?
-------------------------------------------------------------------------------------

If you see high tracer concentrations right at the boundary of your
nested grid region, then this may be normal.

For nested grid simulations, we have to leave a “buffer zone” (i.e.
typically 3 boxes along each boundary) in which the TPCORE advection is
not applied. However, all other operations (chemistry, wetdep, drydep,
convection, PBL mixing) will be applied. Therefore, in the “buffer
zone”, the concentrations will not be realistic because the advection is
not allowed to transport the tracer out of these boxes.

In any case, the tracer concentrations in the “buffer zone” will get
overwritten by the 2° x 2.5° or 4° x 5° boundary conditions at the
specified time (usually every 3h).

.. attention::

   You should exclude the boxes in the “buffer zone” from your
   scientific analysis.

The following diagram illustrates this:

.. code-block:: none

   <----------------------------NX global grid------------------------->

   +-------------------------------------------------------------------+   ^
   | GLOBAL REGION                                                     |   |
   |                                                                   |   |
   |                       <----------NX nested grid--------->         |   |
   |                                                                   |   |
   |                       +=================================[Y]  ^    |   |
   |                       |     NESTED GRID WINDOW REGION    |   |    |   |
   |                       |                                  |   |    |   |
   |                       |      <------- IM_W ------->      |   |    |   |
   |                       |      +--------------------+  ^   |   |    |   |
   |                       |      |  TPCORE REGION     |  |   |   |    |   |
   |                       |      |  (advection is     |  |   |  NY    |  NY
   |<------- I0 ---------->|<---->|   done in this     | JM_W | nested | global
   |                       | I0_W |   window!!!)       |  |   |  grid  | grid
   |                       |      |                    |  |   |   |    |   |
   |                       |      +--------------------+  V   |   |    |   |
   |                       |        ^                         |   |    |   |
   |                       |        | J0_W                    |   |    |   |
   |                       |        V                         |   |    |   |
   |                      [X]=================================+   V    |   |
   |                                ^                                  |   |
   |                                | J0                               |   |
   |                                V                                  |   |
  [1]------------------------------------------------------------------+   V

Diagram notes:

#. The outermost box (:literal:`GLOBAL REGION`) is the global grid size. This
   region has :literal:`NX global grid`  boxes in longitude and
   :literal:`NY global grid` boxes in latitude. The origin of the
   :literal:`GLOBAL REGION`" is at the south pole, at the lower
   left-hand corner (point :literal:`[1]`). |br|
   |br|

#. The next innermost box (:literal:`NESTED GRID WINDOW REGION`) is the
   nested-grid window. This region has :literal:`NX nested grid` boxes
   in longitude and :literal:`NY nested grid` boxes in latitude. This
   is the size of the trimmed met fields that will be used for a
   "nested-grid" simulation. |br|
   |br|

#. The innermost region :literal:`TPCORE REGION` is the actual area in
   which :program:`TPCORE` advection will be performed. Note that this
   region is smaller ehan the :literal:`NESTED GRID WINDOW REGION`. It
   is set up this way since a cushion of grid boxes is needed for
   boundary conditions. |br|
   |br|

#. :literal:`I0` is the longitude offset (# of boxes) and
   :literal:`J0` is the latitude offset (# of boxes) which translate
   between the :literal:`GLOBAL REGION` and the :literal:`NESTED GRID
   WINDOW REGION`.  |br|
   |br|

#. :literal:`I0_W` is the longitude offset (# of boxes), and
   :literal:`J0_W` is the latitude offset (# of boxes) which translate
   between the :literal:`NESTED GRID WINDOW REGION` and the
   :literal:`TPCORE REGION`.  These define the thickness of the buffer
   zone mentioned above. |br|
   |br|

#. The lower left-hand corner of the :literal:`NESTED GRID WINDOW
   REGION`  (point :literal:`[X]`) has longitude and latitude indices
   (:literal:`I1_W`, :literal:`J1_W`). Similarly, the upper right-hand
   corner (point :literal:`[Y]`) has longitude and latitude indices
   (:literal:`I2_W`, :literal:`J2_W`). |br|
   |br|

#. Note that if :literal:`I0=0`, :literal:`J0=0`, :literal:`I0_W=0`,
   :literal:`J0_W=0`, :literal:`NX nested grid = NX global grid`,
   :literal:`NY nested grid = NY global grid` specifies a global
   simulation.  In this case the :literal:`NESTED GRID WINDOW REGION`
   totally coincides with the :literal:`GLOBAL REGION`. |br|
   |br|


#. In order for the nested-grid simulation to work we must save out
   concentrations over the :literal:`NESTED GRID WINDOW REGION` from a
   coarse model (e.g. 2° x 2.5° or 4° x 5°).  These concentrations are
   copied along the edges of the :literal:`NESTED GRID WINDOW REGION`
   and are thus used as boundary conditions for :program:`TPCORE`.
