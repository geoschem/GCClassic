.. _planeflight-diagnostic:

######################
Planeflight diagnostic
######################

On this page we provide information about the GEOS-Chem planeflight
diagnostic, which allows you to save certain diagnostic quantities
along flight tracks or at the position of ground observations.  This
can be more efficient in terms of storage than saving out 3-D data
files via the :ref:`GEOS-Chem History diagnostics <history-diagnostics>`.

.. attention::

   Several diagnostic quantities were disabled when the SMVGEAR
   chemistry solver was replaced with the FlexChem implementation of
   :program:`KPP` (cf: :ref:`kppguide`).  Therefore, you may find that
   functionality is not currently working. We look to GEOS-Chem
   community members to help us maintain the planeflight diagnostic.


.. _planeflight-dat-file:

===============================================
The Planeflight.dat.YYYYMMDD configuration file
===============================================

The :file:`Planeflight.dat.YYYYMMDD` files allow you to specify the
diagnostic quantities (species, reaction rates, met fields) that you
want to print out for a specific longitude, latitude, altitude, and
time. A sample :file:`Planeflight.dat.YYYYMMDD` file is given below. Of
course if you have lots of flight track data points, your file will be
much longer.

If the plane flight following diagnostic is switched on, then it will
look for a new :file:`Planeflight.dat.YYYYMMDD` file each day. If a
:file:`Planeflight.dat.YYYYMMDD`:` file is found for a given day, then
GEOS-Chem will save out diagnostic quantities along the flight
track(s) to the :file:`plane.log.YYYYMMDD` file.

Format
------

.. code-block:: text

   Planeflight.dat -- Input file for planeflight diagnostic
   GCST
   July 2018
   -----------------------------------------------------------
   9     <-- # of variables to be output (listed below)
   -----------------------------------------------------------
   TRA_001
   TRA_002
   TRA_003
   GMAO_TEMP
   GMAO_ABSH
   GMAO_RELH
   GMAO_IIEV
   GMAO_JJEV
   GMAO_LLEV
   -----------------------------------------------------------
     Now give the times and locations of the flight
   -----------------------------------------------------------
   Point   Type DD-MM-YYYY HH:MM     LAT     LON ALT/PRE        OBS
       1   Scrz 30-06-2012 13:53  -46.43   51.85  202.00   1765.030
       2   Scrz 30-06-2012 13:53  -46.43   51.85  202.00   1765.060
       3   Sush 30-06-2012 16:25  -54.85  -68.31   32.00   1764.750
       4   Sush 30-06-2012 16:25  -54.85  -68.31   32.00   1765.610
       5   Sllb 30-06-2012 17:13   54.95 -112.45  588.00   1891.200
       6   Sllb 30-06-2012 17:13   54.95 -112.45  588.00   1891.310
   99999   END  00-00-0000 00:00    0.00    0.00    0.00      0.000

The data in this text file can be read and plotted using GAMAP routines
`CTM_READPLANEFLIGHT <http://acmg.seas.harvard.edu/gamap/doc/by_alphabet/gamap_c.html#CTM_READ_PLANEFLIGHT>`__
and
`PLANE_PLOT <http://acmg.seas.harvard.edu/gamap/doc/by_alphabet/gamap_p.html#PLANE_PLOT>`__.


Requesting diagnostic quantities
--------------------------------

The first part of the :file:`Planeflight.dat.YYYYMMDD` file allows you
to request several diagnostic quantities that you would like to be
archived along the plane's flight track.  These are listed in the
table below.

You must make sure that you have specified the number of requested
quantities properly, or you will get an input error.

.. important::

   Several planeflight diagnostic quantities had to be
   disabled when the SMVGEAR chemical solver was replaced by the
   FlexChem implementation of the KPP chemical solver.  Therefore, you
   may find that not all of the planeflight diagnostic quantities
   listed below are still functional.  Please report any issues to the
   GEOS-Chem Support Team by `opening a new Github issue
   <https://github.com/geoschem/issues/new/choose>`_.

.. table:: Planeflight diagnostic archivable quantities

   +---------------+---------------------------------+-------------+
   | Quantity      | Description                     | Units       |
   +===============+=================================+=============+
   | TRA_nnn       | Species concentration           | v/v dry     |
   |               | (nnn = species index)           |             |
   +---------------+---------------------------------+-------------+
   | OH, HO2, etc. | Species concentration           | molec/cm3   |
   +---------------+---------------------------------+-------------+
   | RO2           | Concentration of RO2 family     | v/v dry     |
   +---------------+---------------------------------+-------------+
   | AN            | Concentration of AN family      | v/v dry     |
   +---------------+---------------------------------+-------------+
   | NOy           | Concentration of NOy family     | v/v dry     |
   +---------------+---------------------------------+-------------+
   | GMAO_TEMP     | Temperature                     | K           |
   +---------------+---------------------------------+-------------+
   | GMAO_ABSH     | Absolute humidity               | unitless    |
   +---------------+---------------------------------+-------------+
   | GMAO_SURF     | Aerosol surface area            | cm2/cm3     |
   +---------------+---------------------------------+-------------+
   | GMAO_PSFC     | Surface pressure                | hPa         |
   +---------------+---------------------------------+-------------+
   | GMAO_UWND     | Zonal winds                     | m/s         |
   +---------------+---------------------------------+-------------+
   | GMAO_VWND     | Meridional winds                | m/s         |
   +---------------+---------------------------------+-------------+
   | GMAO_IIEV     | Longitude index                 | unitless    |
   +---------------+---------------------------------+-------------+
   | GMAO_JJEV     | Latitude index                  | unitless    |
   +---------------+---------------------------------+-------------+
   | GMAO_LLEV     | Level index                     | unitless    |
   +---------------+---------------------------------+-------------+
   | GMAO_RELH     | Relative humidity               | %           |
   +---------------+---------------------------------+-------------+
   | GMAO_PSLV     | Sea level pressure              | hPa         |
   +---------------+---------------------------------+-------------+
   | GMAO_AVGW     | Water vapor mixing ratio        | v/v         |
   +---------------+---------------------------------+-------------+
   | GMAO_THTA     | Potential temperature           | K           |
   +---------------+---------------------------------+-------------+
   | GMAO_PRES     | Pressure at center of grid box  | hPa         |
   +---------------+---------------------------------+-------------+
   | GMAO_ICEnn    | SEAICEnn fields                 | unitless    |
   +---------------+---------------------------------+-------------+
   | AODC_SULF     | Column AOD, sulfate             | unitless    |
   +---------------+---------------------------------+-------------+
   | AODC_BLKC     | Column AOD, black carbon        | unitless    |
   +---------------+---------------------------------+-------------+
   | AODC_ORGC     | Column AOD, organic carbon      | unitless    |
   +---------------+---------------------------------+-------------+
   | AODC_SALA     | Column AOD, fine sea salt       | unitless    |
   +---------------+---------------------------------+-------------+
   | AODC_SALC     | Column AOD, coarse sea salt     | unitless    |
   +---------------+---------------------------------+-------------+
   | AODC_DUST     | Column AOD, dust                | unitless    |
   +---------------+---------------------------------+-------------+
   | AODB_SULF     | Column AOD, sulfate             | unitless    |
   |               | (below aircraft)                |             |
   +---------------+---------------------------------+-------------+
   | AODB_BLKC     | Column AOD, black carbon        | unitless    |
   |               | (below aircraft)                |             |
   +---------------+---------------------------------+-------------+
   | AODB_ORGC     | Column AOD, organic carbon      | unitless    |
   |               | (below aircraft)                |             |
   +---------------+---------------------------------+-------------+
   | AODB_SALA     | Column AOD, fine sea salt       | unitless    |
   |               | (below aircraft)                |             |
   +---------------+---------------------------------+-------------+
   | AODB_SALC     | Column AOD, coarse sea salt     | unitless    |
   |               | (below aircraft)                |             |
   +---------------+---------------------------------+-------------+
   | AODB_DUST     | Column AOD, dust                | unitless    |
   |               | (below the aircraft)            |             |
   +---------------+---------------------------------+-------------+
   | TMS_nnn       | Nucleation rates (TOMAS)        |             |
   +---------------+---------------------------------+-------------+
   | HG2_FRACG     | Frac of Hg(II) in gas           | unitless    |
   |               | phase                           |             |
   +---------------+---------------------------------+-------------+
   | HG2_FRACP     | Frac Hg(II) in                  | unitless    |
   |               | particle phase                  |             |
   +---------------+---------------------------------+-------------+
   | ISOR_HPLUS    | ISORROPIA H+                    | M           |
   +---------------+---------------------------------+-------------+
   | ISOR_PH       | ISORROPIA pH                    | unitless    |
   +---------------+---------------------------------+-------------+
   | ISOR_AH2O     | ISORROPIA aerosol water         | ug/m3 air   |
   +---------------+---------------------------------+-------------+
   | ISOR_HSO4     | ISORROPIA bifulfate             | M           |
   +---------------+---------------------------------+-------------+
   | TIME_LT       | Local time                      | hours       |
   +---------------+---------------------------------+-------------+
   | AQAER_RAD     | Aqueous aerosol radius          | cm          |
   +---------------+---------------------------------+-------------+
   | AQAER_SURF    | Aqueous aerosol surface area    | cm2/cm3     |
   +---------------+---------------------------------+-------------+
   | PROD_xxxx     | Production rates                | molec/cm3/s |
   |               | (needs updating)                |             |
   +---------------+---------------------------------+-------------+
   | REA_nnn       | Reaction rates                  | molec/cm3/s |
   |               | (Needs updating)                |             |
   +---------------+---------------------------------+-------------+

.. _specifying_the_flight_track:

Specifying the flight track
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The next section of the :file:`Planeflight.dat.YYYYMMDD` file is where
you will specify the points that make up the flight track.

+---------------+-----------------------------------------------+
| Quantity      | Description                                   |
+===============+===============================================+
| POINT         | A sequential index of flight track points.    |
+---------------+-----------------------------------------------+
| TYPE          | Identifier for the plane (or station)         |
+---------------+-----------------------------------------------+
| DD            | Day of the observation                        |
+---------------+-----------------------------------------------+
| MM            | Month of the observation                      |
+---------------+-----------------------------------------------+
| YYYY          | Year of the observation                       |
+---------------+-----------------------------------------------+
| HH            | Hour of the observation (UTC)                 |
+---------------+-----------------------------------------------+
| MM            | Minute of the observation (UTC)               |
+---------------+-----------------------------------------------+
| LAT           | Latitude (deg), range -90 to +90              |
+---------------+-----------------------------------------------+
| LON           | Longitude (deg), range -180 to +180           |
+---------------+-----------------------------------------------+
| ALT/PRE       | Altitude [m] or Pressure [hPa] of             |
|               | the observation                               |
+---------------+-----------------------------------------------+
| OBS           | Value of the observation (if known),          |
|               | used to compare to model output               |
+---------------+-----------------------------------------------+


.. important:: The :file:`TYPE` column can be used to specify the
	       aircraft type and flight number to distinguish between
	       multiple plane flight tracks.

	       The planeflight diagnostic will automatically set L=1
	       if it does not recognize :file:`TYPE`. When using a new
	       flight track, make sure to add your :file:`TYPE` `to this
	       IF statement
	       <https://github.com/geoschem/geos-chem/blob/d7baeb8fe51a66914408e9d1f655dd062bd5d4df/GeosCore/planeflight_mod.F90#L1057-L1126>`_
	       if you do not wish to use L=1 for that type value.

.. _plane_log_file:

The plane.log.YYYYMMDD output file
----------------------------------

The :file:`plane.log.YYYYMMDD` file contains output from the
planeflight diagnostic.

Format
~~~~~~

.. code-block:: text

    POINT    TYPE YYYYMMDD HHMM     LAT     LON   PRESS        OBS     T-IND P-I I-IND J-IND  TRA_001     GMAO_TEMP   ...
        1    Scrz 20120630 1353  -46.43   51.85  981.74   1765.030 000061277 002 00047 00012  1.785E-006  2.780E+002  ...
        2    Scrz 20120630 1353  -46.43   51.85  981.74   1765.060 000061277 002 00047 00012  1.785E-006  2.780E+002  ...
        3    Sush 20120630 1625  -54.85  -68.31  949.77   1764.750 000061281 002 00023 00010  1.784E-006  2.746E+002  ...
        4    Sush 20120630 1625  -54.85  -68.31  949.77   1765.610 000061281 002 00023 00010  1.784E-006  2.746E+002  ...
        5    Sllb 20120630 1713   54.95 -112.45  876.13   1891.200 000061283 005 00015 00037  1.906E-006  2.942E+002  ...
        6    Sllb 20120630 1713   54.95 -112.45  876.13   1891.310 000061283 005 00015 00037  1.906E-006  2.942E+002  ...

Columns
~~~~~~~

+--------------+--------------------------------+
| Column       | Description                    |
+==============+================================+
| POINT        | Flight track data point        |
|              | number (for reference)         |
+--------------+--------------------------------+
| TYPE         | Aircraft/flight number ID      |
|              | or ground station ID           |
+--------------+--------------------------------+
| YYYYMMDD     | Year, month, and day (UTC      |
|              | or each flight track point     |
+--------------+--------------------------------+
| HHMM         | Hour and minute (UTC)          |
|              | for each flight track point    |
+--------------+--------------------------------+
| LAT          | Latitude (-90 to 90 degrees)   |
|              | for each flight track point    |
+--------------+--------------------------------+
| LON          | Longitude (-180 to 180         |
|              | degrees) for each flight       |
|              | track point                    |
+--------------+--------------------------------+
| PRESS        | Pressure in hPa for each       |
|              | flight track point             |
+--------------+--------------------------------+
| OBS          | Observation value from the     |
|              | flight campaign                |
+--------------+--------------------------------+
| T-IND        | Time index                     |
+--------------+--------------------------------+
| P-IND        | GEOS-CHEM level index          |
+--------------+--------------------------------+
| I-IND        | GEOS-Chem longitude index      |
+--------------+--------------------------------+
| J-IND        | GEOS-Chem latitude index       |
+--------------+--------------------------------+
| TRA_001 etc. | Diagnostic quantities          |
|              | requested in                   |
|              | :file:`Planeflight.dat.YYMMDD` |
+--------------+--------------------------------+
