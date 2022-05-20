.. _kppguide:

########################
Using KPP with GEOS-Chem
########################

This Guide demonstrates how you can use `The Kinetic PreProcessor
(aka KPP) <https://kpp.readthedocs.io>`_ to translate a chemical
mechanism specification in plain text format to highly-optimized
Fortran90 code for use with GEOS-Chem:

.. _kppguide-quick-start:

======================
Using KPP: Quick start
======================

.. _kppguide-navigate-to-kpp-folder:

1. Navigate to the KPP/custom folder within GEOS-Chem
-----------------------------------------------------

The :file:`KPP/custom` folder is intended for building customized mechanisms.
(The standard mechanisms that ship with GEOS-Chem are contained in
other folders named :file:`KPP/fullchem` and :file:`KPP/Hg`, but we
will leave these alone.)

If you are using GEOS-Chem "Classic", type:

.. code-block:: console

   $ cd GCClassic/src/GEOS-Chem/KPP/custom

or if you are using GCHP, type:

.. code-block:: console

   $ cd GCHP/GCHP_GridComp/GEOSChem_GridComp/geos-chem/KPP/custom

.. _kppguide-config-files:

2. Edit the chemical mechanism configuration files
--------------------------------------------------

The :file:`KPP/custom` folder contains sample chemical mechanism
specification files (:ref:`kppguide-custom-eqn` and
:ref:`kppguide-custom-kpp`). These files define the chemical
mechanism and are copies of the default :command:`fullchem` mechanism
configuration files found in the :file:`KPP/fullchem` folder.  (For a
complete description of KPP configuration files, please see the
documentation at `kpp.readthedocs.io <https://kpp.readthedocs.io>`_.)

You can edit these :ref:`kppguide-custom-eqn` and
:ref:`kppguide-custom-kpp` configuration files to define your own
custom mechanism (cf. :ref:`kppguide-reference-section` for details).

.. important::

   We recommend always building a custom mechanism from the
   :file:`KPP/custom` folder, and to leave the other folders
   untouched. This will allow you to validate your modified mechanism
   against one of the standard mechanisms that ship with GEOS-Chem.

.. _kppguide-custom-eqn:

custom.eqn
~~~~~~~~~~

The :file:`custom.eqn` configuration file contains:

- List of active species
- List of inactive species
- Gas-phase reactions
- Heterogeneous reactions
- Photolysis reactions

.. _kppguide-custom-kpp:

custom.kpp
~~~~~~~~~~

The :file:`custom.kpp` configuration file is the main configuration
file. It contains:

- Solver options
- Production and loss family definitions
- Functions to compute reaction rates
- Global definitions
- An :command:`#INCLUDE custom.eqn` command, which tells
  :program:`KPP` to look for chemical reaction definitions in
  :ref:`kppguide-custom-eqn`.

.. important::

   The symbolic link :file:`gckpp.kpp` points to :file:`custom.kpp`.
   This is necessary in order to generate Fortran files with the
   the naming convention :file:`gckpp*.F90`.

.. _kppguide-build-mechanism-sh:

3. Run the build_mechanism.sh script
-------------------------------------
Once you are satisfied with your custom mechanism specification you may
now use KPP to build the source code files for GEOS-Chem.

Return to the top-level :file:`KPP` folder from :file:`KPP/custom`:

.. code-block:: console

   $ cd ..

There you will find a script named :file:`build_mechanism.sh`, which
is the driver script for running :program:`KPP`. Execute the script as
follows:

.. code-block:: console

   $ ./build_mechanism.sh custom

This will run the :program:`KPP` executable (located in the folder
:file:`$KPP_HOME/bin`) :file:`custom.kpp` configuration
file (via symbolic link :file:`gckpp.kpp`,  It also runs a python
script to generate code for the OH reactivity diagnostic.  You should
see output similar to this:

.. code-block:: console

  This is KPP-X.Y.Z.

  KPP is parsing the equation file.
  KPP is computing Jacobian sparsity structure.
  KPP is starting the code generation.
  KPP is initializing the code generation.
  KPP is generating the monitor data:
    - gckpp_Monitor
  KPP is generating the utility data:
    - gckpp_Util
  KPP is generating the global declarations:
    - gckpp_Main
  KPP is generating the ODE function:
    - gckpp_Function
  KPP is generating the ODE Jacobian:
    - gckpp_Jacobian
    - gckpp_JacobianSP
  KPP is generating the linear algebra routines:
    - gckpp_LinearAlgebra
  KPP is generating the utility functions:
    - gckpp_Util
  KPP is generating the rate laws:
    - gckpp_Rates
  KPP is generating the parameters:
    - gckpp_Parameters
  KPP is generating the global data:
    - gckpp_Global
  KPP is generating the driver from none.f90:
    - gckpp_Main
  KPP is starting the code post-processing.

  KPP has succesfully created the model "gckpp".

  Reactivity consists of 172 reactions
  Written to gckpp_Util.F90

where :file:`X.Y.Z`` denotes the :program:`KPP` version that you are using.

If this process is successful, the :file:`custom` folder will have
several new files starting with :file:`gckpp`:

.. code-block:: console

  $ ls gckpp*
  gckpp_Function.F90    gckpp_Jacobian.F90       gckpp.map             gckpp_Precision.F90
  gckpp_Global.F90      gckpp_JacobianSP.F90     gckpp_Model.F90       gckpp_Rates.F90
  gckpp_Initialize.F90  gckpp.kpp@               gckpp_Monitor.F90     gckpp_Util.F90
  gckpp_Integrator.F90  gckpp_LinearAlgebra.F90  gckpp_Parameters.F90

The :file:`gckpp*.F90` files contain optimized Fortran-90 instructions
for solving the chemical mechanism that you have specified.  The
:file:`gckpp.map` file is a human-readable description of the
mechanism.  Also, :file:`gckpp.kpp` is a symbolic link to the
:file:`custom.kpp` file.

`A complete description of these KPP-generated files
<https://kpp.readthedocs.io/en/latest/using_kpp/05_output_from_kpp.html#the-fortran90-code>`_
at kpp.readthedocs.io.

.. _kppguide-using-custom-mech:

4. Recompile GEOS-Chem with your custom mechanism
-------------------------------------------------

:program:`GEOS-Chem` will always use the default mechanism (which is named
:file:`fullchem`).  To tell GEOS-Chem to use the :file:`custom`
mechanism instead, follow these steps.

.. tip::

   GEOS-Chem Classic run directories have a subdirectory named
   :file:`build` in which you can configure and build GEOS-Chem.  If
   you don't have a build directory, you can add one to your run
   directory with :command:`mkdir build`.

.. _kppguide-configuring-gc:

From the build directory, type:

.. code-block:: console

   $ cmake ../CodeDir -DMECH=custom -DRUNDIR=..

**TODO**: Add link to config section here

You should see output similar to this written to the screen:

.. code-block:: none

  -- General settings:
     * CUSTOMMECH:  fullchem  Hg  **custom**

This confirms that the custom mechanism has been selected.

.. _kppguide-compiling:

Once you have configured :program:`GEOS-Chem` to use the
:file:`custom` mechanism, you may build the exectuable.  Type:

.. code-block:: console

   $ make -j
   $ make -j install

The executable file (:file:`gcclassic` or :file:`gchp`, depending on which
mode of GEOS-Chem that you are using) will be placed in the run
directory.

.. _kppguide-reference-section:

============================
Using KPP: Reference section
============================

.. _kppguide-adding-species:

Adding species to a mechanism
-----------------------------
List chemically-active (aka variable) species in the `#DEFVAR
<https://kpp.readthedocs.io/en/latest/using_kpp/04_input_for_kpp.html#defvar-and-deffix>`_ section of :file:`custom.eqn`, as shown below:

.. code-block:: none

  #DEFVAR
  A3O2       = IGNORE; {CH3CH2CH2OO; Primary RO2 from C3H8}
  ACET       = IGNORE; {CH3C(O)CH3; Acetone}
  ACTA       = IGNORE; {CH3C(O)OH; Acetic acid}
  ...etc ...

The :code:`IGNORE` tells KPP not to perform mass-balance checks, which
would make GEOS-Chem execute more slowly.

List species whose concentrations do not change in the `#DEFFIX
<https://kpp.readthedocs.io/en/latest/using_kpp/04_input_for_kpp.html#defvar-and-deffix>`_ section of :file:`custom.eqn`, as shown below:

.. code-block:: none

  #DEFFIX
  H2         = IGNORE; {H2; Molecular hydrogen}
  N2         = IGNORE; {N2; Molecular nitrogen}
  O2         = IGNORE; {O2; Molecular oxygen}
  ... etc ...

Species may be listed in any order, but we have found it convenient to
list them alphabetically.

.. _kppguide-adding-rxns:

Adding reactions to a mechanism
-------------------------------

.. _kppguide-gas-rxns:

Gas-phase reactions
~~~~~~~~~~~~~~~~~~~

List gas-phase reactions first in the `#EQUATIONS
<https://kpp.readthedocs.io/en/latest/using_kpp/04_input_for_kpp.html#equations>`_
section of :file:`custom.eqn`.

.. code-block:: none

   #EQUATIONS
   //
   // Gas-phase reactions
   //
   ...skipping over the comment header...
   //
   O3 + NO = NO2 + O2 :                         GCARR(3.00E-12, 0.0, -1500.0);
   O3 + OH = HO2 + O2 :                         GCARR(1.70E-12, 0.0, -940.0);
   O3 + HO2 = OH + O2 + O2 :                    GCARR(1.00E-14, 0.0, -490.0);
   O3 + NO2 = O2 + NO3 :                        GCARR(1.20E-13, 0.0, -2450.0);
   ... etc ...

.. _kppguide-general-form:

Gas-phase reactions: General form
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

No matter what reaction is being added, the general procedure is the
same. A new line must be added to :file:`custom.eqn` of the following
form:

.. code-block:: none

   A + B = C + 2.000D : RATE_LAW_FUNCTION(ARG_A, ARG_B ...);

The denotes the reactants (:math:`A` and :math:`B`) as well as the
products (:math:`C` and :math:`D`) of the reaction. If exactly one
molecule is consumed or produced, then the factor can be omitted;
otherwise the number of molecules consumed or produced should be
specified with at least 1 decimal place of accuracy. The final
section, between the colon and semi-colon, specifies the function
:code:`RATE_LAW_FUNCTION` and its arguments which will be used to
calculate the reaction rate constant k. Rate-law functions are
specified in the :file:`custom.kpp` file.

For an equation such as the one above, the overall rate at which the
reaction will proceed is determined by :math:`k[A][B]`. However, if the
reaction rate does not depend on the concentration of :math:`A` or
:math:`B`, you may write it with a constant value, such as:

.. code-block:: none

    A + B = C + 2.000D : 8.95d-17

This will save the overhead of a function call.

.. _kppguide-two-body-rates:

Rates for two-body reactions according to the Arrhenius law
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For many reactions, the calculation of k follows the Arrhenius law:

.. code-block:: none

   k = a0 * ( 300 / TEMP )**b0 * EXP( c0 / TEMP )

.. important::

   In relation to Arrhenius parameters that you may find in scientific
   literature, :math:`a_0` represents the :math:`A` term and :math:`c_0`
   represents :math:`-E/R` (not :math:`E/R`, which is usually listed).

For example, the `JPL chemical data evaluation
<https://jpldataeval.jpl.nasa.gov>`__), (Feb 2017) specifies that the
reaction O3 + NO produces NO2 and O2, and its
Arrhenius parameters are :math:`A` = 3.0x10^-12 and :math:`E/R` = 1500.   To
use the Arrhenius formulation above, we must specify :math:`a_0 = 3.0e-12`
and :math:`c_0 = -1500`.

To specify a two-body reaction whose rate follows the Arrhenius law, you
can use the :code:`GCARR` rate-law function, which is defined in
:file:`gckpp.kpp`. For example, the entry for the :math:`O3 + NO =
NO2 + O2` reaction can be written as in :file:`custom.eqn` as:

.. code-block:: none

   O3 + NO = NO2 + O2 : GCARR(3.00E12, 0.0, -1500.0);

.. _kppguide-other-functions:

Other rate-law functions
~~~~~~~~~~~~~~~~~~~~~~~~

The :file:`gckpp.kpp` file contains other rate law functions, such as
those required for three-body, pressure-dependent reactions. Any rate
function which is to be referenced in the :file:`custom.eqn`
file must be available in :file:`gckpp.kpp` prior to building the
reaction mechanism.

.. _kppguide-efficiency:

Making your rate law functions computationally efficient
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We recommend writing your rate-law functions so as to avoid
explicitly casting variables from :code:`REAL*4` to
:code:`REAL*8`.  Code that looks like this:

.. code-block:: F90

   REAL, INTENT(IN) :: A0, B0, C0
   rate = DBLE(A0) + ( 300.0 / TEMP )**DBLE(B0) + EXP( DBLE(C0)/ TEMP )

Can be rewritten as:

.. code-block:: F90

   REAL(kind=dp), INTENT(IN) :: A0, B0, C0
   rate = A0 + ( 300.0d0 / TEMP )**B0 + EXP( C0/ TEMP )

Not only do casts lead to a loss of precision, but each cast takes a
few CPU clock cycles to execute.  Because these rate-law functions are
called for each cell in the chemistry grid, wasted clock cycles can
accumulate into a noticeable slowdown in execution.

You can also make your rate-law functions more efficient if you
rewrite them to avoid computing terms that evaluate to 1.   We saw
above (cf. :ref:`kppguide-two-body-rates`) that the rate of the
reaction :math:`O3 + NO = NO2 + O2` can be computed according to the
Arrhenius law.  But because :code:`b0 = 0`, term
:code:`(300/TEMP)**b0` evaluates to 1. We can therefore rewrite the
computation of the reaction rate as:

.. code-block:: none

   k = 3.0x10^-12 + EXP( 1500 / TEMP )

.. tip::

   The :code:`EXP()` and :code:`**` mathematical operations are
   among the most costly in terms of CPU clock cycles.  Avoid calling
   them whenever necessary.

A recommended implementation would be to create separate rate-law functions
that take different arguments depending on which parameters are
nonzero. For example, the Arrhenius law function :code:`GCARR` can be split
into multiple functions:

#. :code:`GCARR_abc(a0, b0, c0)`: Use when :code:`a0 > 0` and :code:`b0 > 0` and :code:`c0 > 0`
#. :code:`GCARR_ab(a0, b0)`: Use when :code:`a0 > 0` and :code:`b0 > 0`
#. :code:`GCARR_ac(a0, c0)`: Use when :code:`a0 > 0` and :code:`c0 > 0`

Thus we can write the O3 + NO reaction in :file:`custom.eqn` as:

.. code-block:: none

   O3 + NO = NO2 + O2 : GCARR_ac(3.00d12, -1500.0d0);

using the rate law function for when both :code:`a0 > 0` and :code:`c0
> 0`.

.. _kppguide-het-rxns:

Heterogeneous reactions
-----------------------

**TODO** Remove reference to HET array

List heterogeneous reactions after all of the gas-phase reactions in
:file:`custom.eqn`, according to the format below:

.. code-block:: none

  //
  // Heterogeneous reactions
  //
  HO2 = O2 :                                   HET(ind_HO2,1);                      {2013/03/22; Paulot2009; FP,EAM,JMAO,MJE}
  NO2 = 0.500HNO3 + 0.500HNO2 :                HET(ind_NO2,1);
  NO3 = HNO3 :                                 HET(ind_NO3,1);
  NO3 = NIT :                                  HET(ind_NO3,2);                      {2018/03/16; XW}
  ... etc ...

Implementing new heterogeneous chemistry requires an additional step.
For the reaction in question, a reaction should be added as usual, but
this time the rate function should be given as an entry in the
:code:`HET` array. A simple example is uptake of HO2, specified as

.. code-block:: none

  HO2 = O2 : HET(ind_HO2,1);

Note that the product in this case, O2, is actually a fixed species, so
no O2 will actually be produced. O2 is used in this case only as a dummy
product to satisfy the KPP requirement that all reactions have at least
one product. Here, :code:`HET` is simply an array of pre-calculated
rate constants. The rate constants in :code:`HET` are actually
calculated in :file:`gckpp_HetRates.F90`.

To implement an additional heterogeneous reaction, the rate calculation
must be added to this file. The following example illustrates a
(fictional) heterogeneous mechanism which converts the species XYZ into
CH2O. This reaction is assumed to take place on the surface of all
aerosols, but not cloud droplets (this requires additional steps not
shown here). Three steps would be required:

#. Add a new line to the :file:`custom.eqn` file, such as :code:`XYZ =
   CH2O : HET(ind_XYZ,1);`

#. Add a new function to :file:`gckpp_HetRates.F90` designed to
   calculate the heterogeneous reaction rate. As a simple example, we
   can copy the function :code:`HETNO3` and rename it :code:`HETXYZ`.
   This function accepts two arguments: molecular mass of the impinging
   gas-phase species, in this case XYZ, and the reaction's "sticking
   coefficient" - the probability that an incoming molecule will stick
   to the surface and undergo the reaction in question. In the case of
   :code:`HETNO3`, it is assumed that all aerosols will have the same
   sticking coefficient, and the function returns a first-order rate
   constant based on the total available aerosol surface area and the
   frequency of collisions

#. Add a new line to the function :code:`SET_HET` in
   :file:`gckpp_HetRates.F90` which calls the new function with the
   appropriate arguments and passes the calculated constant to
   :code:`HET`. Example: assuming a molar mass of 93 g/mol, and a
   sticking coefficient of 0.2, we would write
   :code:`HET(ind_XYZ, 1) = HETXYZ(93.0_fp, 0.2_fp)`

The function :code:`HETXYZ` can then be specialized to distinguish
between aerosol types, or extended to provide a second-order reaction
rate, or whatever the user desires.

.. _kppguide-photo-rxns:

Photolysis reactions
--------------------

List photolysis reactions after the heterogeneous reactions, as shown
below.

.. code-block:: none

  //
  // Photolysis reactions
  //
  O3 + hv = O + O2 :                           PHOTOL(2);      {2014/02/03; Eastham2014; SDE}
  O3 + hv = O1D + O2 :                         PHOTOL(3);      {2014/02/03; Eastham2014; SDE}
  O2 + hv = 2.000O :                           PHOTOL(1);      {2014/02/03; Eastham2014; SDE}
  ... etc ...
  NO3 + hv = NO2 + O :                         PHOTOL(12);     {2014/02/03; Eastham2014; SDE}
  ... etc ...

A photolysis reaction can be specified by giving the correct index of
the :code:`PHOTOL` array. This index can be determined by inspecting the file
:file:`FJX_j2j.dat`.

.. tip::

   See the `photolysis section of :file:`geoschem_config.yml` to
   determine the folder in which :file:`FJX_j2j.dat` is located.

For example, one branch of the :math:`NO_3` photolysis reaction is specified in
the :file:`custom.eqn` file as

.. code-block:: none

  NO3 + hv = NO2 + O : PHOTOL(12)

Referring back to :file:`FJX_j2j.dat` shows that reaction 12, as
specified by the left-most index, is indeed :math:`NO_3 = NO2 + O`:

.. code-block:: none

  12 NO3       PHOTON    NO2       O                       0.886 /NO3   /

If your reaction is not already in :file:`FJX_j2j.dat`, you may add it
there. You may also need to modify :file:`FJX_spec.dat` (in the same
folder ast :file:`FJX_j2j.dat`) to include cross-sections for your
species. Note that if you add new reactions to :file:`FJX_j2j.dat` you
will also need to set the parameter :code:`JVN_` in GEOS-Chem module
:file:`Headers/CMN_FJX_MOD.F90` to match the total number of entries.

If your reaction involves new cross section data, you will need to
follow an additional set of steps. Specifically, you will need to:

#. Estimate the cross section of each wavelength bin (using the
   correlated-k method), and
#. Add this data to the :file:`FJX_spec.dat` file.

For the first step, you can use tools already available on the Prather
research group website. To generate the cross-sections used by Fast-JX,
download the file `UCI_fastJ_addX_73cx.tar.gz
<http://ftp.as.harvard.edu/gcgrid/data/ExtData/CHEM_INPUTS/FAST_JX/code/UCI_fastJ_addX_73cx.tar.gz>`__.
You can then simply add your data to :file:`FJX_spec.dat` and refer to it in
:file:`FJX_j2j.dat` as specified above. The following then describes
how to generate a new set of cross-section data for the example of some
new species MEKR:

To generate the photolysis cross sections of a new species, come up with
some unique name which you will use to refer to it in the
:file:`FJX_j2j.dat` and :file:`FJX_spec.dat` files - e.g. MEKR. You
will need to copy one of the :file:`addX_*.f` routines and make your own (say,
:file:`addX_MEKR.f`). Your edited version will need to read in whatever cross
section data you have available, and you'll need to decide how to handle
out-of-range information - this is particularly crucial if your cross
section data is not defined in the visible wavelengths, as there have
been some nasty problems in the past caused by implicitly assuming that
the XS can be extrapolated (I would recommend buffering your data with
zero values at the exact limits of your data as a conservative first
guess). Then you need to compile that as a standalone code and run it;
this will spit out a file fragment containing the aggregated 18-bin
cross sections, based on a combination of your measured/calculated XS
data and the non-contiguous bin subranges used by Fast-JX. Once that
data has been generated, just add it to :file:`FJX_spec.dat` and refer
to it as above. There are examples in the addX files of how to deal with
variations of cross section with temperature or pressure, but the main
takeaway is that you will generate multiple cross section entries to be
added to :file:`FJX_spec.dat` with the same name.

.. important::

   If your cross section data varies as a function of temperature AND
   pressure, you need to do something a little different. The acetone
   XS documentation shows one possible way to handle this; Fast-JX
   currently interpolates over either T or P, but not both, so if your
   data varies over both simultaneously then this will take some
   thought. The general idea seems to be that one determines which
   dependence is more important and uses that to generate a set of 3
   cross sections (for interpolation), assuming values for the unused
   variable based on the standard atmosphere.

.. _kppguide-adding-families:

Adding production and loss families to a mechanism
--------------------------------------------------

Certain common families (e.g. :math:`PO_x`, :math:`LO_x`) have been
pre-defined for you. You will find the family definitions near the top of the
:file:`gckpp.kpp` file:

.. code-block:: none

  #FAMILIES
  POx : O3 + NO2 + 2NO3 + PAN + PPN + MPAN + HNO4 + 3N2O5 + HNO3 + BrO + HOBr + BrNO2 + 2BrNO3 + MPN + ETHLN + MVKN + MCRHN + MCRHNB + PROPNN + R4N2 + PRN1 + PRPN + R4N1 + HONIT + MONITS + MONITU + OLND + OLNN + IHN1 + IHN2 + IHN3 + IHN4 + INPB + INPD + ICN + 2IDN + ITCN + ITHN + ISOPNOO1 + ISOPNOO2 + INO2B + INO2D + INA + IDHNBOO + IDHNDOO1 + IDHNDOO2 + IHPNBOO + IHPNDOO + ICNOO + 2IDNOO + MACRNO2 + ClO + HOCl + ClNO2 + 2ClNO3 + 2Cl2O2 + 2OClO + O + O1D + IO + HOI + IONO + 2IONO2 + 2OIO + 2I2O2 + 3I2O3 + 4I2O4;
  LOx : O3 + NO2 + 2NO3 + PAN + PPN + MPAN + HNO4 + 3N2O5 + HNO3 + BrO + HOBr + BrNO2 + 2BrNO3 + MPN + ETHLN + MVKN + MCRHN + MCRHNB + PROPNN + R4N2 + PRN1 + PRPN + R4N1 + HONIT + MONITS + MONITU + OLND + OLNN + IHN1 + IHN2 + IHN3 + IHN4 + INPB + INPD + ICN + 2IDN + ITCN + ITHN + ISOPNOO1 + ISOPNOO2 + INO2B + INO2D + INA + IDHNBOO + IDHNDOO1 + IDHNDOO2 + IHPNBOO + IHPNDOO + ICNOO + 2IDNOO + MACRNO2 + ClO + HOCl + ClNO2 + 2ClNO3 + 2Cl2O2 + 2OClO + O + O1D + IO + HOI + IONO + 2IONO2 + 2OIO + 2I2O2 + 3I2O3 + 4I2O4;
  PCO : CO;
  LCO : CO;
  PSO4 : SO4;
  LCH4 : CH4;
  PH2O2 : H2O2;

.. note::

   The :math:`PO_x`, :math:`LO_x`, :math:`PCO`, and :math:`LCO` families
   are used for computing budgets in the GEOS-Chem benchmark
   simulations.  :math:`PSO4` is required for simulations using `TOMAS aerosol
   microphysics <TOMAS_aerosol_microphysics>`__.

To add a new prod/loss family, add a new line to the :code:`#FAMILIES`
section with the format

.. code-block:: none

  FAM_NAME : MEMBER_1 + MEMBER_2 + ... + MEMBER_N;

The family name must start with :code:`P` or :code:`L` to indicate
whether KPP should calculate a production or a loss rate.

The maximum number of families allowed by KPP is currently set to 300.
Depending on how many prod/loss families you add, you may need to
increase that to a larger number to avoid errors in KPP. You can change
the number for :code:`MAX_FAMILIES` in :file:`KPP/kpp-code/src/gdata.h` and then `rebuild
KPP <FlexChem#KPP_source_code>`__.

.. code-block:: C

   // - Many limits can be changed here by adjusting the MAX_* constants
   // - To increase the max size of inlined code (F90_GLOBAL etc.),
   //   change MAX_INLINE in scan.h.
   //
   //   NOTES:
   //   ------
   //   (1) Note: MAX_EQN or MAX_SPECIES over 1023 causes a seg fault in CI build
   //         -- Lucas Estrada, 10/13/2021
   //
   //   (2) MacOS has a hard limit of 65332 bytes for stack memory.  To make
   //       sure that you are using this max amount of stack memory, add
   //       "ulimit -s 65532" in your .bashrc or .bash_aliases script.  We must
   //       also set smaller limits for MAX_EQN and MAX_SPECIES here so that we
   //       do not exceed the avaialble stack memory (which will result in the
   //       infamous "Segmentation fault 11" error).  If you are stll having
   //       problems on MacOS then consider reducing MAX_EQN and MAX_SPECIES
   //       to smaller values than are listed below.
   //         -- Bob Yantosca (03 May 2022)
   #ifdef MACOS
   #define MAX_EQN        2000     // Max number of equations (MacOS only)
   #define MAX_SPECIES    1000     // Max number of species   (MacOS only)
   #else
   #define MAX_EQN       11000     // Max number of equations
   #define MAX_SPECIES    6000     // Max number of species
   #endif
   #define MAX_SPNAME       30     // Max char length of species name
   #define MAX_IVAL         40     // Max char length of species ID ?
   #define MAX_EQNTAG       32     // Max length of equation ID in eqn file
   #define MAX_K          1000     // Max length of rate expression in eqn file
   #define MAX_ATOMS        10     // Max number of atoms
   #define MAX_ATNAME       10     // Max char length of atom name
   #define MAX_ATNR        250     // Max number of atom tables
   #define MAX_PATH        300     // Max char length of directory paths
   #define MAX_FILES        20     // Max number of files to open
   #define MAX_FAMILIES    300     // Max number of family definitions
   #define MAX_MEMBERS     150     // Max number of family members
   #define MAX_EQNLEN      300     // Max char length of equations
   #define MAX_EQNLEN      200

.. important::

   When adding a prod/loss family or changing any of the other
   settings in :file:`gckpp.kpp`, you must re-run KPP to produce new
   Fortran-90 files for GEOS-Chem (cf. :ref:`creating_fortran_files`).

Production and loss families are archived via the HISTORY diagnostics.
For more information, please see the `Guide to GEOS_Chem History
diagnostics <http://wiki.geos-chem.org/Guide_to_GEOS_Chem_History_diagnostics>`__
on the GEOS-Chem wiki.

.. _kppguide-changing-int:

Changing the numerical integrator
---------------------------------

Several global options for :program:`KPP` are listed at the top of the
:file:`gckpp.kpp` file:

.. code-block:: none

   #MINVERSION   2.5.0
   #INTEGRATOR   rosenbrock
   #LANGUAGE     Fortran90
   #UPPERCASEF90 on
   #DRIVER       none
   #HESSIAN      off
   #MEX          off
   #STOICMAT     off

The `#INTEGRATOR
<https://kpp.readthedocs.io/en/latest/using_kpp/04_input_for_kpp.html#integrator>`_
tag specifies the choice of numerical integrator that you wish to use
with your chemical mechanism.  The Rosenbrock solver is used by
default for the GEOS-Chem :command:`fullchem` and :command:`Hg`
mechanisms.  But if you wish to use a different integrator for research
purposes, you may select from `several more options
<https://kpp.readthedocs.io/en/latest/tech_info/07_numerical_methods.html>`_.

The `#LANGUAGE
<https://kpp.readthedocs.io/en/latest/using_kpp/04_input_for_kpp.html#language>`_
should be set to :command:`Fortran90` and `#UPPERCASEF90
<https://kpp.readthedocs.io/en/latest/using_kpp/04_input_for_kpp.html#uppercasef90>`_
should be set to :command:`on`.

The `#MINVERSION
<https://kpp.readthedocs.io/en/latest/using_kpp/04_input_for_kpp.html#minversion>`_
should be set to 2.5.0.  This is the minimum KPP version you should be
using with GEOS-Chem.

The other options should be left as they are, as they are not relevant
to :program:`GEOS-Chem`.

For more information about :program:`KPP` settings, please see
`https://kpp.readthedocs.io <kpp.readthedocs.io>`_.
