.. _cfg-spec-db:

####################
species_database.yml
####################

.. note::

   You will only need to edit :file:`species_database.yml` if you are
   adding new species to a GEOS-Chem simulation.

The **GEOS-Chem Species Database** is a `YAML file
<https://yaml.org>`_ that contains a listing of metadata for each
species used by GEOS-Chem.  The Species Database is included in your
run directory as file :file:`species_database.yml`, a snippet of which
is shown below.

.. code-block:: yaml

   # GEOS-Chem Species Database
   # Core species only (neglecting microphysics)
   # NOTE: Anchors must be defined before any variables that reference them.
   A3O2:
     Formula: CH3CH2CH2OO
     FullName: Primary peroxy radical from C3H8
     Is_Gas: true
     MW_g: 75.10
   ACET:
     DD_F0: 1.0
     DD_Hstar: 1.0e+5
     Formula: CH3C(O)CH3
     FullName: Acetone
     Henry_CR: 5500.0
     Henry_K0: 2.74e+1
     Is_Advected: true
     Is_DryDep: true
     Is_Gas: true
     Is_Photolysis: true
     MW_g: 58.09

   ... etc ...
     
   AERI:
     DD_DvzAerSnow: 0.03
     DD_DvzMinVal: [0.01, 0.01]
     DD_F0: 0.0
     DD_Hstar: 0.0
     Formula: I
     FullName: Iodine on aerosol
     Is_Advected: true
     Is_Aerosol: true
     Is_DryDep: true
     Is_WetDep: true
     MW_g: 126.90
     WD_AerScavEff: 1.0
     WD_KcScaleFac: [1.0, 0.5, 1.0]
     WD_RainoutEff: [1.0, 0.0, 1.0]
     WD_RainoutEff_Luo: [0.4, 0.0, 1.0]

   ... etc ...

Each species name begins in the first column of the file, followed by
a :literal:`:`.  Underneath
the species name follows an indented block of species properties in
:literal:`Property: Value` format.  

Some properties listed above are only applicable to gas-phase species,
and others to aerosol species.  But at the very least, each species
should have the following species defined:

- :literal:`Formula`
- :literal:`FullName`
- :literal:`MW_g`
- Either :literal:`Is_Gas` or :literal:`Is_Aerosol`

For more information about species properties, please see the `Guide
to Species in GEOS-Chem 
<http://wiki.geos-chem.org/Guide_to_species_in_GEOS-Chem>`_ on the
GEOS-Chem wiki. 

