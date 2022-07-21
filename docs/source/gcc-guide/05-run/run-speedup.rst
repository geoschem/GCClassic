.. |br| raw:: html

   <br/>

.. _run-speedup:

##########################
Speed up a slow simulation
##########################

GEOS-Chem Classic performance is continuously monitored by the
`GEOS-Chem Support Team
<http://wiki.geos-chem.org/GEOS-Chem_Support_Team>`_ by means of
benchmark simulations and ad-hoc timing tests. It has been shown that
running GEOS-Chem with
`recommended timesteps
<https://wiki.geos-chem.org/Centralized_chemistry_time_step#Optimal_Configuration>`_
from
`Philip et al. (2016)
<https://gmd.copernicus.org/articles/9/1683/2016/gmd-9-1683-2016.html>`_
can increase run times by approximately a factor of 2.  To speed up
GEOS-Chem Classic simulations, users may choose to use any of the
following options.

.. _use-coarser-timesteps:

=====================
Use coarser timesteps
=====================

As :ref:`discussed previously <gc-yml-timesteps>`, the default
timesteps for GEOS-Chem Classic are 600 seconds for dynamics, and 1200
seconds for chemistry and emissions.  You can experiment with using
coarser timesteps (such as 1800 seconds for dynamics and 3600 seconds
for emissions & chemistry).

.. attention::

   For nested-grid simulations, you might not be able to use coarser
   timesteps, or else the Courant limit in transport will be violated.

.. _turn-off-diagnostics:

=============================
Turn off unwanted diagnostics
=============================

Several diagnostics are turned on by default in :ref:`the HISTORY.rc
<history>` configuration file.  The more diagnostics that are turned
on, the more I/O operations need to be done, resulting in longer
simulation execution times.  Disabling diagnostics that you do not
wish to archive can result in a faster simulation.

.. _disable-debug-options:

=========================
Disable debugging options
=========================

If you previously configured GEOS-Chem with the :
:option:`CMAKE_BUILD_TYPE` option set to :envvar:`Debug`, then several
run-time debugging checks will be activated.  These include:

- Checking for array-out-of-bounds errors
- Checking for floating-point math exceptions (e.g. div-by-zero)
- Disabling compiler optimizations

These options can be useful in detecting errors in your GEOS-Chem
Classic simulation, but result in a much slower simulation.  If you
plan on running a long Classic simulation, make sure that
you :ref:`configure and build GEOS-Chem Classic <compile-geos-chem>`
so that :option:`CMAKE_BUILD_TYPE` is set to :envvar:`Release`.

