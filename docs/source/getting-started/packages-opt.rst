.. _req-soft-opt:

##########################################
Optional but recommended software packages
##########################################

.. _req-soft-gcpy:

====
GCPy
====

`GCPy <https://gcpy.readthedocs.io>`_ is our recommended python
companion software to GEOS-Chem.

While :program:`GCPy` is not a general-purpose plotting package, it
does contain many useful functions for creating zonal mean and
horizontal plots from GEOS-Chem output. It also contains scripts to
generate plots and tables from GEOS-Chem benchmark simulations.

**Best way to install:**
`From PyPi (see gcpy.readthedocs.io) <https://gcpy.readthedocs.io/en/stable/Getting-Started-with-GCPy.html>`__

.. _req-soft-gdb:

============
gdb and cgdb
============
`The GNU debugger (gdb) <https://gnu.org/software/GDB>`_  and `its
graphical interface (cgdb) <https://cgdb.github.io/>`_ are very useful
tools for tracking down the source of GEOS-Chem errors, such
as segmentation faults, out-of-bounds errors, etc.

**Best way to install:**  :ref:`With Spack <spackguide>`.

.. _req-soft-ncview:

======
ncview
======
The `ncview <http://meteora.ucsd.edu/~pierce/ncview_home_page.html>`_
program is a netCDF file viewer. While it does not produce
publication-quality output, ncview can let you easily examine the
contents of a netCDF data file (such as those which are input and
output by GEOS-Chem). Ncview is very useful for debugging and development.

.. _req-soft-nco:

===
nco
===
`The netCDF operators (nco) <https://nco.sourceforge.net/>`_ are
powerful command-line tools for editing and manipulating data in
netCDF format.

**Best way to install:**  :ref:`With Spack <spackguide>`.

.. _req-soft-cdo:

===
cdo
===
`The Climate Data Operators (cdo)
<https://code.mpimet.mpg.de/projects/cdo/l>`_ are powerful
command-line utilities for editing and manipulating data in netCDF
format.

**Best way to install:** :ref:`With Spack <spackguide>`.

.. _req-soft-kpp:

===
KPP
===
`The Kinetic PreProcessor (KPP) <https://kpp.readthedocs.io>`_
translates a chemical mechanism specification from user-configurable
input files to Fortran-90 source code.  You will need to use
:program:`KPP` if you plan on updating any of the chemical mechanisms
that ship with GEOS-Chem.

**Best way to install:**  `Clone from github.com/KineticPreProcessor/KPP
<https://github.com/KineticPreProcessor/KPP>`_ and `build the the KPP
executable from source
<https://kpp.readthedocs.io/en/stable/getting_started/01_installation.html>`_.

.. _req-soft-flex:

==============
flex and bison
==============
`Flex <https://github.com/westes/flex>`_ is the Fast Lexical
Analyzer, and `bison <https://www.gnu.org/software/bison/>`_ is a
general purpose parser-generator.  :ref:`req-soft-kpp` uses both
:program:`flex` and :program:`bison` to parse chemical mechanism
definition files.  Depending on your setup, these packages might have
already been installed for you.

**Best way to install:** :ref:`With Spack <spackguide>`.
