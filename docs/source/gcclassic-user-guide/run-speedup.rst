.. _run-speedup:

##########################
Speed up a slow simulation
##########################

GEOS-Chem Classic performance is continuously monitored by the
`GEOS-Chem Support Team
<http://wiki.geos-chem.org/GEOS-Chem_Support_Team>`_ by means of
benchmark simulations and ad-hoc timing tests.  In this chapter, we
provide some practical tips that you can use to speed up your
simulations.

.. _run-speedup-coarse-timesteps:

================================
Use a coarser chemistry timestep
================================

The table below contains our recommended GEOS-Chem Classic timestep
settings.

+----------------------------------------------+-------------+--------------+
| GEOS-Chem Classic Resolution                 | Transport   | Chemistry    |
+==============================================+=============+==============+
| :math:`4^{\circ}{\times}5^{\circ}`           | 600s (10m)  | 1200s (20m)  |
+----------------------------------------------+-------------+--------------+
| :math:`2^{\circ}{\times}2.5^{\circ}`         | 600s (10m)  | 1200s (20m)  |
+----------------------------------------------+-------------+--------------+
| :math:`0.5^{\circ}{\times}0.625^{\circ}`     | 300s (5m)   | 600s (10m)   |
+----------------------------------------------+-------------+--------------+
| :math:`0.25^{\circ}{\times}0.3125^{\circ}`   | 300s (5m)   | 600s (10m)   |
+----------------------------------------------+-------------+--------------+
| :math:`0.125^{\circ}{\times}0.15625^{\circ}` | 150s (2.5m) | 300s (5m)    |
+----------------------------------------------+-------------+--------------+

The `Courant limit
<https://en.wikipedia.org/wiki/Courant%E2%80%93Friedrichs%E2%80%93Lewy_condition>`_
on the latitude-longitude grid constrains the choice of transport
timestep for a given horizontal resolution.  We choose a chemistry
timestep that is double the transport timestep (i.e.
`Strang operator splitting
<https://hplgit.github.io/fdm-book/doc/pub/book/sphinx/._book018.html#strang-splitting-for-odes>`_).

If you wish to speed up your simulation, try increasing the chemistry
timestep.  Chemistry is the GEOS-Chem operation that takes the longest
to execute, so increasing the interval between calls to the chemistry
solver will reduce the run time accordingly.  But you should also verify
that the increased chemistry timestep allows your simulation to
faithfully capture diurnal variations, etc.

See :cite:t:`Philip_et_al._2016` for a comprehensive study on
GEOS-Chem timesteps.

.. _run-speedup-autoreduce:

=============================================
Use the Rosenbrock solver with auto-reduction
=============================================

The GEOS-Chem full-chemistry mechanism uses the KPP Rosenbrock solver,
which has an `automatic mechanism reduction option
<https://kpp.readthedocs.io/en/stable/tech_info/07_numerical_methods.html#rosenbrock-with-mechanism-auto-reduction>`_
as described in :cite:t:`Lin_et_al._2023`.  This automatic mechanism
reduction feature separates species into "fast" and "slow"
categories based on their chemical production or loss rates. "Fast"
species are integrated with the full Rosenbrock algorithm, while
"slow" species will have a simple 1st-order loss applied to
them.  This approach has been shown to reduce the time spent in
chemistry by 20 to 30 percent.

The automatic mechanism reduction option is disabled by default, but
can be enabled by toggiing this switch in :ref:`cfg-gc-yml`:

.. code-block:: yaml

   autoreduce_solver:
     activate: false  # <=== set to true to activate auto-reduction

.. _run-speedup-disable-diags:

=============================
Turn off unwanted diagnostics
=============================

Several diagnostics are turned on by default in :ref:`the HISTORY.rc
<histguide-configfile>` configuration file.  The more diagnostics that
are turned on, the more I/O operations need to be done, resulting in
longer simulation execution times.  Disabling diagnostics that you do
not wish to archive can result in a faster simulation.

.. _run-speedup-disable-debug:

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
you :ref:`configure and build GEOS-Chem Classic <compile>`
so that :option:`CMAKE_BUILD_TYPE` is set to :envvar:`Release`.

.. _run-speedup-combine-files:

===============================================
Reduce the amount of files that need to be read
===============================================

If you are developing a new data set (such as an emissions inventory)
for GEOS-Chem, we recommend that you prepare data files with multiple
timestamps rather than one file per timestamp.  For example, if your
data set has hourly time resolution, consider creating one file for
each day, with each file containing 24 hours of data, etc.

The greatest amount of overhead in I/O occurs when new data files (in
netCDF format) are opened.  This also usually involves decompression
of the file contents, which is computationally intensive.  Reducing
the number of times that GEOS-Chem has to open and close netCDF files
can substantially improve performance.

.. _run-speedup-nested:

=====================================================
Speeding up GEOS-Chem Classic nested-grid simulations
=====================================================

Use these tips to speed up your GEOS-Chem nested-grid simulations:

.. _run-speedup-nested-crop:

Crop nested-grid meteorology inputs
-----------------------------------

Your simulation should not read global high-resolution
(:math:`0.5^{\circ}{\times}0.625^{\circ}` or finer) meteorology
fields.   The overhead in reading and regridding these global fields
can significantly impact your simulation. Instead, consider cropping
high-resolution meteorology fields to the extent of your nested domain.
This can easily be done with the netCDF operators or the Climate Data
Operators; see our :ref:`netcdf-guide` supplemental guide for more
information.

.. _run-speedup-nested-buffer:

Increase the size of the transport buffer zone
----------------------------------------------

By default, nested :option:`buffer_zone_NSEW` option is set to 3 boxes
in each cardinal direction.  Increasing this number will reduce the
amount of grid boxes in which transport will be performed, which
should also reduce the overall run time.
