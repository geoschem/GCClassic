.. _gc-known-bugs:

#####################
Known bugs and issues
#####################

Please see our `Issue tracker on GitHub
<https://github.com/geoschem/geos-chem/issues>`_ for a list of recent
bugs and fixes.

===================
Current bug reports
===================

These `bug reports (on GitHub)
<https://github.com/geoschem/geos-chem/issues?q=is%3Aissue+is%3Aopen+label%3A%22category%3A+Bug%22>`_
are currently unresolved. We hope to fix these in future releases.

.. attention::

   It has been brought to our attention that the
   :ref:`histguide-rxnconst` and the :ref:`histguide-rxnrates`
   diagnostic collection may not be working as expected.  We are
   currently investigating.

.. important::

    The convection scheme used for GEOS-FP met generation changed
    from RAS to Grell-Freitas with impact on GEOS-FP meteorology
    files starting June 1, 2020, specifically enhanced vertical
    transport. In addition, there is a bug in convective
    precipitation flux following the switch where all values are
    zero. While this bug is automatically fixed by computing fluxes
    online for runs starting on or after June 1 2020, the fix
    assumes meteorology year corresponds to simulation year. Due to
    these issues we recommend splitting up GEOS-FP runs in time such
    that a single simulation does not run across June
    1, 2020. Instead. set one run to stop on June 1 2020 and then
    restart a new run from there. If you wish to use a GEOS-FP
    meteorology year different from your simulation year please
    create a GEOS-Chem GitHub issue for assistance.

============================
Bugs that have been resolved
============================

These `bugs (reported on GitHub) <https://github.com/geoschem/geos-chem/issues?q=+label%3A%22category%3A+Bug+Fix%22+>`_ have been resolved.
