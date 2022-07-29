.. _req-hard-mem:

###################
Memory requirements
###################

If you plan to run GEOS-Chem on a local computer system, please make
sure that your system has sufficient memory to run your simulations.

.. _req-hard-mem-limits:

==================================
Sufficient memory to run GEOS-Chem
==================================

For the :math:`4^{\circ}{\times}5^{\circ}` "standard" simulation

  - 8-15 GB RAM

For the :math:`2^{\circ}{\times} 2.5^{\circ}` "standard" simulation:

  - 30-40 GB RAM
  - 20 GB memory (MaxRSS)
  - 26 GB virtual memory (MaxVMSize)

Our standard GEOS-Chem Classic 1-month full-chemistry
benchmark simulations use a little under 14 GB of system memory. This
is mostly due to the fact that the benchmark simulations archive the
"kitchen sink"---that is, most diagnostic outputs are requested so
that the benchmark simulation can be properly evaluated. But a typical
GEOS-Chem Classic production simulation would not require all of these
diagnostic outputs, and thus would use much less memory than the
benchmark simulations.

.. _req-hard-mem-extra:

====================================
Extra memory for special simulations
====================================

You may want to consider at least 30 GB RAM if you plan on doing any
of the following:

  - Running high-resolution (e.g. :math:`1^{\circ}{\times}1.25^{\circ}` or
    higher resolution) global simulations

  - Running high-resolution (e.g. :math:`0.25^{\circ}{\times}0.3125^{\circ}`
    or  :math:`0.5^{\circ}{\times}0.625^{\circ}`

  - Running :math:`2^{\circ}{\times}2.5^{\circ}` and generating a lot
    of diagnostic output.  The more diagnostics you turn on, the more
    memory GEOS-Chem Classic will require).
