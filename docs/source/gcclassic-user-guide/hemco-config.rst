.. _cfg-hco-cfg:

###############
HEMCO_Config.rc
###############

GEOS-Chem Classic relies on the `Harmonized Emissions Component (aka
HEMCO) <https://hemco.readthedocs.io>`_  for file I/O, regridding, and
computing emissions fluxes.  Settings for HEMCO can be updated in the
`HEMCO configuration file
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html>`_,
which is named :file:`HEMCO_Config.rc`.

The HEMCO online manual at `hemco.readthedocs.io
<https://hemco.readthedocs.io>`_ contains detailed instructions about
the structure and contents of :file:`HEMCO_Config.rc`, so we will not
replicate that content in this Guide.  Instead, we will provide a
short summary with links to the relevant documentation.

.. _cfg-hco-cfg-settings:

======================
General HEMCO settings
======================

Define general simulation parameters in the `Settings section
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html#section-settings>`_
of :file:`HEMCO_Config.rc`.  This includes data paths, global
diagnostic options, and verbose output options.

.. code-block:: kconfig

   ###############################################################################
   ### BEGIN SECTION SETTINGS
   ###############################################################################

   ROOT:                        /path/to/hemco/data/dir
   METDIR:                      /path/to/hemco/met/dir
   GCAPSCENARIO:                not_used
   GCAPVERTRES:                 47
   Logfile:                     *
   DiagnFile:                   HEMCO_Diagn.rc
   DiagnPrefix:                 ./OutputDir/HEMCO_diagnostics
   DiagnFreq:                   00000000 010000
   Wildcard:                    *
   Separator:                   /
   Unit tolerance:              1
   Negative values:             0
   Only unitless scale factors: false
   Verbose:                     false
   VerboseOnCores:              root       # Accepted values: root all

   ### END SECTION SETTINGS ###

.. _cfg-hco-cfg-extswitches:

==================
Extension switches
==================

Turn individual emissions inventories on/off in the `Extension
Switches section
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html#extension-switches>`_
of :file:`HEMCO_Config.rc`.  Emission inventories are
specified as either `Base Emissions
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html#base-emissions>`_
(i.e. read from files on disk) or `Extensions
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/extensions.html>`_
(i.e. computed using meteorological inputs).

.. code-block:: kconfig

   ###############################################################################
   ### BEGIN SECTION EXTENSION SWITCHES
   ###############################################################################
   # ExtNr ExtName                on/off  Species  Years avail.
   0       Base                   : on    *
   # ----- MAIN SWITCHES ---------------------------------------------------------
       --> EMISSIONS              :       true
       --> METEOROLOGY            :       true
       --> CHEMISTRY_INPUT        :       true
   # ----- RESTART FIELDS --------------------------------------------------------
       --> GC_RESTART             :       true
       --> HEMCO_RESTART          :       true
   # ----- NESTED GRID FIELDS ----------------------------------------------------
       --> GC_BCs                 :       false
   # ----- REGIONAL INVENTORIES --------------------------------------------------
       --> APEI                   :       false    # 1989-2014
       --> NEI2016_MONMEAN        :       false    # 2002-2020
       --> DICE_Africa            :       false    # 2013
   # ----- GLOBAL INVENTORIES ----------------------------------------------------
       --> CEDSv2                 :       true     # 1750-2019
       --> CEDS_GBDMAPS           :       false    # 1970-2017
       --> CEDS_GBDMAPS_byFuelType:       false    # 1970-2017

   ... etc ...

   # -----------------------------------------------------------------------------
   100     Custom                 : off   -
   101     SeaFlux                : on    DMS/ACET/ALD2/MENO3/ETNO3/MOH
   102     ParaNOx                : on    NO/NO2/O3/HNO3
       --> LUT data format        :       nc
       --> LUT source dir         :       $ROOT/PARANOX/v2015-02
   103     LightNOx               : on    NO
       --> CDF table              :       $ROOT/LIGHTNOX/v2014-07/light_dist.ott2010.dat
   104     SoilNOx                : on    NO
       --> Use fertilizer NOx     :       true

   ... etc ...

   ### END SECTION EXTENSION SWITCHES ###

.. _cfg-hco-base:

==============
Base emissions
==============

.. note::

   You do not have to edit this section if you just wish to run
   GEOS-Chem Classic with its default emissions configuration.

Specify how emissions and other data sets will be read from disk in
the `Base Emissions section
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html#base-emissions>`_
of :file:`HEMCO_Config.rc`.

.. code-block:: kconfig

   ###############################################################################
   ### BEGIN SECTION BASE EMISSIONS
   ###############################################################################

   # ExtNrName sourceFile sourceVar sourceTime C/R/E SrcDim SrcUnit Species ScalIDs Cat Hier

   (((EMISSIONS

   #==============================================================================
   # --- APEI (Canada) ---
   #==============================================================================
   (((APEI
   0 APEI_NO   $ROOT/APEI/v2016-11/APEI.0.1x0.1.nc NOx 1989-2014/1/1/0 RF xy kg/m2/s NO   25/1002/115    1 30
   0 APEI_CO   $ROOT/APEI/v2016-11/APEI.0.1x0.1.nc CO  1989-2014/1/1/0 RF xy kg/m2/s CO   26/52/1002     1 30
   0 APEI_SOAP -                                   -   -               -  -  -       SOAP 26/52/1002/280 1 30
   0 APEI_SO2  $ROOT/APEI/v2016-11/APEI.0.1x0.1.nc SOx 1989-2014/1/1/0 RF xy kg/m2/s SO2  60/1002        1 30
   0 APEI_SO4  -                                   -   -               -  -  -       SO4  60/65/1002     1 30
   0 APEI_pFe  -

   ... etc ...

   ### END SECTION BASE EMISSIONS ###

.. _cfg-hco-scalefac:

=============
Scale factors
=============

Define scale factors for emissions inventories and other data sets in
the `Scale Factors section
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html#scale-factors>`_
of :file:`HEMCO_Config.rc`.

.. code-block:: kconfig

   #==============================================================================
   # --- Scale factors used for species conversions ---
   #==============================================================================

   # Units carbon to species conversions
   # Factor = # carbon atoms * MW carbon) / MW species
   40 CtoACET MATH:58.09/(3.0*12.0)   - - - xy unitless 1
   41 CtoALD2 MATH:44.06/(2.0*12.0)   - - - xy unitless 1
   42 CtoALK4 MATH:58.12/(4.3*12.0)   - - - xy unitless 1

   ... etc ...
   # VOC speciations
   (((RCP_3PD.or.RCP_45.or.RCP_60.or.RCP_85
   50 KET2MEK    0.25  - - - xy unitless 1
   51 KET2ACET   0.75  - - - xy unitless 1
   )))RCP_3PD.or.RCP_45.or.RCP_60.or.RCP_85

   ... etc ...

   ### END SECTION SCALE FACTORS ###

.. _masks:

=====
Masks
=====

Define masks for emissions and other data sets in the `Masks section
<https://hemco.readthedocs.io/en/latest/hco-ref-guide/hemco-config.html#masks>`_
of :file:`HEMCO_Config.rc`

.. code-block:: kconfig

   ###############################################################################
   ### BEGIN SECTION MASKS
   ###############################################################################

   # ScalID Name sourceFile sourceVar sourceTime C/R/E SrcDim SrcUnit Oper Lon1/Lat1/Lon2/Lat2

   (((EMISSIONS

   #==============================================================================
   # Country/region masks
   #==============================================================================
   (((APEI
   1002 CANADA_MASK $ROOT/MASKS/v2018-09/Canada_mask.geos.1x1.nc                  MASK     2000/1/1/0 C xy 1 1 -141/40/-52/85
   )))APEI

   (((NEI2016_MONMEAN
   1007 CONUS_MASK  $ROOT/MASKS/v2018-09/CONUS_Mask.01x01.nc                      MASK     2000/1/1/0 C xy 1 1 -140/20/-50/60
   )))NEI2016_MONMEAN

   ... etc ...

   )))EMISSIONS

   ### END SECTION MASKS ###

   ### END OF HEMCO INPUT FILE ###
