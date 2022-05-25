.. _obspack-diagnostic:

##################
ObsPack diagnostic
##################

On this page we provide information about the ObsPack diagnostic in
GEOS-Chem, which is intended to sample GEOS-Chem data at specified
coordinates and times (e.g. corresponding to surface or flight track
measurements). This feature was written by Andy Jacobson of NOAA and
Andrew Schuh of Colorado State University and implemented in GEOS-Chem
12.2.0.

.. _specifying_obspack_diagnostic_options:

=====================================
Specifying ObsPack diagnostic options
=====================================

`The ObsPack Menu section of input.geos <http://wiki.geos-chem.org/The_input.geos_file#ObsPack_diagnostic>`_ is where you define the following settings:

#. Turning ObsPack or off

#. Specifying which GEOS-Chem species you would like to archive.

   - At present, you can archive individual species, or all advected species.

#. Specifying the names of input files

   - These are the files from which coordinate data will be read)

#. Specifying the names of output files

   - These are the files that will contain GEOS-Chem data sampled by the
     ObsPack diagnostic.

.. _input_file_format:

=================
Input file format
=================

The ObsPack diagnostic reads input information (such as coordinates,
sampling method, and observation ID's) from netCDF files having the
format shown below. You will need to prepare an input file for each
YYYY/MM/DD date on which you would like to obtain ObsPack diagnostic
output from GEOS-Chem. (The ObsPack diagnostic will skip over days on
which it cannot find an input file.)

ObsPack input files can be downloaded from NOAA (see
`https://www.esrl.noaa.gov/gmd/ccgg/obspack/
<https://www.esrl.noaa.gov/gmd/ccgg/obspack/>`_).

.. attention::

   Starting in ObsPack v6, :file:`time_components` indicates the
   start-time of the sampling interval, not the center time. For the
   center time, we need to read the :file:`time` variable. The
   :file:`time` variable represents the center of the averaging window
    in all ObsPack data versions.

.. _obspack_file_metadata:

Obspack file metadata
---------------------

Here is the metadata from an ObsPack data file. We have only displayed
the variables that the ObsPack module needs to read.

.. code-block:: text

    netcdf obspack_co2_1_GLOBALVIEWplus_v6.0_2020-09-11.20190408 {
    dimensions:
            obs = UNLIMITED ; // (3111 currently)
            calendar_components = 6 ;
            string_of_200chars = 200 ;
            string_of_500chars = 500 ;
    variables:
            int obs(obs) ;
                    obs:long_name = "obs" ;
                    obs:_Storage = "chunked" ;
                    obs:_ChunkSizes = 1024 ;
                    obs:_Endianness = "little" ;
            int time(obs) ;
                    time:units = "Seconds since 1970-01-01 00:00:00 UTC" ;
                    time:_FillValue = -999999999 ;
                    time:long_name = "Seconds since 1970-01-01 00:00:00 UTC" ;
                    time:_Storage = "chunked" ;
                    time:_ChunkSizes = 778 ;
                    time:_DeflateLevel = 5 ;
                    time:_Endianness = "little" ;
            ...
            float latitude(obs) ;
                    latitude:units = "degrees_north" ;
                    latitude:_FillValue = -1.e+34f ;
                    latitude:long_name = "Sample latitude" ;
                    latitude:_Storage = "chunked" ;
                    latitude:_ChunkSizes = 778 ;
                    latitude:_DeflateLevel = 5 ;
                    latitude:_Endianness = "little" ;
            float longitude(obs) ;
                    longitude:units = "degrees_east" ;
                    longitude:_FillValue = -1.e+34f ;
                    longitude:long_name = "Sample longitude" ;
                    longitude:_Storage = "chunked" ;
                    longitude:_ChunkSizes = 778 ;
                    longitude:_DeflateLevel = 5 ;
                    longitude:_Endianness = "little" ;
            float altitude(obs) ;
                    altitude:units = "meters" ;
                    altitude:_FillValue = -1.e+34f ;
                    altitude:long_name = "sample altitude in meters above sea level" ;
                    altitude:comment = "Altitude is surface elevation plus sample intake height in meters above sea level." ;
                    altitude:_Storage = "chunked" ;
                    altitude:_ChunkSizes = 778 ;
                    altitude:_DeflateLevel = 5 ;
            ...
            char obspack_id(obs, string_of_200chars) ;
                    obspack_id:long_name = "Unique ObsPack observation id" ;
                    obspack_id:comment = "Unique observation id string that includes obs_id, dataset_id and obspack_num." ;
                    obspack_id:_Storage = "chunked" ;
                    obspack_id:_ChunkSizes = 1, 200 ;
                    obspack_id:_DeflateLevel = 5 ;
            ...
            int CT_sampling_strategy(obs) ;
                    CT_sampling_strategy:_FillValue = -9 ;
                    CT_sampling_strategy:long_name = "model sampling strategy" ;
                    CT_sampling_strategy:values = "How to sample model. 1=4-hour avg; 2=1-hour avg; 3=90-min avg; 4=instantaneous" ;
                    CT_sampling_strategy:_Storage = "chunked" ;
                    CT_sampling_strategy:_ChunkSizes = 778 ;
                    CT_sampling_strategy:_DeflateLevel = 5 ;
                    CT_sampling_strategy:_Endianness = "little"

    ... omitting global attributes etc. ...

.. _notes:

Notes
~~~~~

1. The ObsPack ID string should be 200 characters long.

2. If you have coordinate data in another format (e.g. a text-based
   :ref:`Planeflight.dat <planeflight-dat-file>` file) then you'll
   need to create a netCDF file using the format shown above, or else
   ObsPack will not be able to read it.

.. _output_file_format:

==================
Output file format
==================

The ObsPack diagnostic will produce a file called
:file:`GEOSChem.ObsPack.YYYYMMDD_hhmmz.nc4` for each day where an
:ref:`input file <input_file_format>` has been specified. (You can change
the output file name in the ObsPack Menu in :file:`input.geos`.

Below is shown an ObsPack output file for the
`GEOS-Chem methane simulation
<http://wiki.geos-chem.org/CH4_simulation>`_. If you are using
the ObsPack diagnostic with other GEOS-Chem simulations, your output
files will look similar to this, except for the species names.

.. code-block:: text

    netcdf GEOSChem.ObsPack.20180926_0000z.nc4 {
    dimensions:
            obs = UNLIMITED ; // (662 currently)
            species = 1 ;
            char_len_obs = 200 ;
    variables:
            char obspack_id(obs, char_len_obs) ;
                    obspack_id:long_name = "obspack_id" ;
                    obspack_id:units = "1" ;
            int nsamples(obs) ;
                    nsamples:long_name = "no. of model samples" ;
                    nsamples:units = "1" ;
                    nsamples:comment = "Number of discrete model samples in average" ;
            int averaging_interval(obs) ;
                    averaging_interval:long_name = "Amount of model time over which this observation is averaged" ;
                    averaging_interval:units = "seconds" ;
            int averaging_interval_start(obs) ;
                    averaging_interval_start:long_name = "Start of averaging interval" ;
                    averaging_interval_start:units = "seconds since 1970-01-01 00:00:00 UTC" ;
                    averaging_interval_start:calendar = "standard" ;
            int averaging_interval_end(obs) ;
                    averaging_interval_end:long_name = "End of averaging interval" ;
                    averaging_interval_end:units = "seconds since 1970-01-01 00:00:00 UTC" ;
                    averaging_interval_end:calendar = "standard" ;
            float lon(obs) ;
                    lon:long_name = "longitude" ;
                    lon:units = "degrees_east" ;
            float lat(obs) ;
                    lat:long_name = "latitude" ;
                    lat:units = "degrees_north" ;
            float u(obs) ;
                    u:long_name = "Zonal component of wind" ;
                    u:units = "m s^-1" ;
            float v(obs) ;
                    v:long_name = "Meridional component of wind" ;
                    v:units = "m s^-1" ;
            float blh(obs) ;
                    blh:long_name = "Boundary layer height" ;
                    blh:units = "m" ;
            float q(obs) ;
                    q:long_name = "mass_fraction_of_water_inair" ;
                    q:units = "kg water (kg air)^-1" ;
            float pressure(obs) ;
                    pressure:long_name = "pressure" ;
                    pressure:units = "Pa" ;
            float temperature(obs) ;
                    temperature:long_name = "temperature" ;
                    temperature:units = "K" ;
            float CH4(obs) ;
                    CH4:long_name = "Methane" ;
                    CH4:units = "mol mol-1" ;
                    CH4:_FillValue = -1.e+34f ;

    // global attributes:
                    :history = "GEOS-Chem simulation at 2019/01/11 14:54" ;
                    :conventions = "CF-1.4" ;
                    :references = "www.geos-chem.org; wiki.geos-chem.org" ;
                    :model_start_date = "2018/09/26 00:00:00 UTC" ;
                    :model_end_date = "2018/09/27 00:00:00 UTC" ;
    }


You can several different types of netCDF-reading software to read and
plot data from Obspack diagnostic output files. We recommend using
either Python scripts or Jupyter notebooks.

.. _known_issues:

============
Known issues
============

.. _unit_conversions_are_currently_done_for_all_species:

Unit conversions are currently done for all species
---------------------------------------------------

In routine :file:`ObsPack_Sample` (located in module
:file:`ObsPack/obspack_mod.F90`), the following algorithm is used:

.. code-block:: fortran

    ! Ensure that units of species are "v/v dry", which is dry=
    ! air mole fraction.  Capture the InUnit value, this is=
    ! what the units are prior to this call.  After we sample=
    ! the species, we'll call this again requesting that the=
    ! species are converted back to the InUnit values.=

    ... THEN DO THE DATA SAMPLING ...............................................
    ... i.e. determine which GEOS-Chem grid boxes to include in the averaging ...

    ! Return State_Chm%SPECIES to whatever units they had
    ! coming into this routine
    call Convert_Spc_Units( am_I_root, Input_Opt, State_Met,                 &


The routine :file:`Convert_Spc_Units` performs unit conversions for
all of the species in the :file:`State_Chm%Species` array, regardless
of whether they are being archived with ObsPack or not. This can lead
to a bottleneck in performance, as :file:`ObsPack_Sample` is called on
every GEOS-Chem "heartbeat" timestep.

What would be more efficient would be to do the unit conversion only
for hose species that are being archived by ObsPack. A typical
full-chemistry simulation includes about 200 species. But if we are
only using ObsPack to archive 10 of these species, GEOS-Chem would
execute much faster if we were doing unit conversions for only the 10
archived species instead of all 200 species.

This issue is currently unresolved.
