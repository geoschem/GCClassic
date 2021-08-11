.. _code_directory_structure:

GEOS-Chem Classic folder tree
=============================

The tables below list the folders in which various components of
GEOS-Chem and HEMCO reside.

.. _geos-chem-folder-tree:

GEOS-Chem folder tree
---------------------

:file:`GCClassic/src/GEOS-Chem`
  Root folder for the GEOS-Chem "science codebase".

:file:`GCClassic/src/GEOS-Chem/GTMM`
  Contains the GTMM (Global Terrestrial Mercury Model) source code.
  (NOTE: This option has fallen into disuse.)

:file:`GCClassic/src/GEOS-Chem/GeosCore`
  Contains most GEOS-Chem modules & routines

:file:`GCClassic/src/GEOS-Chem/GeosRad`
  Contains the RRTMG radiative transfer model source code.

:file:`GCClassic/src/GEOS-Chem/GeosUtil`
  Contains GEOS-Chem utility modules & routines (for error handling,
  string handling, etc.)

:file:`GCClassic/src/GEOS-Chem/Headers`
  Contains modules for with derived-type definitions for state
  objects, fixed parameter settings, etc.

:file:`GCClassic/src/GEOS-Chem/History`
  Contains modules & routines for archiving GEOS-Chem diagnostics to
  netCDF-format output.

:file:`GCClassic/src/GEOS-Chem/ISORROPIA`
  Contains the ISORROPIA II source code, which is used for aerosol
  thermodynamical equilibrium computations.

:file:`GCClassic/src/GEOS-Chem/KPP`
  Main folder for chemical mechanisms built with `KPP-for-GEOS-Chem <http://kpp.readthedocs.io>`_.

:file:`GCClassic/src/GEOS-Chem/NcdfUtil`
  Contains modules & routines for netCDF file I/O.

:file:`GCClassic/src/GEOS-Chem/ObsPack`
  Contains modules & routines for generating GEOS-Chem diagnostic
  output at the same locations of NOAA ObsPack observational stations.

:file:`GCClassic/src/GEOS-Chem/PKUCPL`
  Contains the coupler code for the PKU 2-way nesting algorithm.
  (This option has fallen into disuse.)

:file:`GEOS-Chem/Interfaces/GCClassic`
  Contains the GCClassic driver program (main.F90).

.. _hemco-folder-tree:

HEMCO folder tree
-----------------

:file:`GCClassic/src/HEMCO/src/Core`
  Contains modules for reading, storing, and updating data.

:file:`GCClassic/src/HEMCO/src/Extensions`
  Contains modules for calculating emissions that depend on meterological variables or parameterizations.

:file:`GCClassic/src/HEMCO/src/Interfaces`
  Contains modules and routines for linking HEMCO to GEOS-Chem
  Classic and other external models.

:file:`GCClassic/src/HEMCO/src/shared`
  Contains various modules with utility routines (such as for netCDF
  I/O, regridding, string handling, etc.)
