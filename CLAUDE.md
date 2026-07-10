# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

**GCClassic** is the top-level "superproject" wrapper repository for **GEOS-Chem Classic**, a global 3-D model of atmospheric chemistry. This repo itself contains almost no model source code. Its job is to:

- Pin compatible versions of the model components (via git submodules)
- Provide the top-level CMake build system that ties those components together
- Provide run-directory creation scripts and templates
- Host the ReadTheDocs documentation source

The actual Fortran model code lives in the submodules under `src/`:

| Submodule | Path | Upstream repo |
|---|---|---|
| GEOS-Chem (science codebase) | `src/GEOS-Chem` | geoschem/geos-chem |
| HEMCO (emissions component) | `src/HEMCO` | geoschem/hemco |
| Cloud-J (photolysis) | `src/Cloud-J` | geoschem/Cloud-J |
| HETP (heterogeneous chem, vectorized/parallel) | `src/HETP` | geoschem/HETerogeneous-vectorized-or-Parallel |
| geos-chem-shared-docs | `docs/source/geos-chem-shared-docs` | geoschem/geos-chem-shared-docs |

`run`, `test`, and `spack` at the repo root are **symlinks** into the GEOS-Chem submodule (`src/GEOS-Chem/run/GCClassic`, `src/GEOS-Chem/test`, `docs/source/geos-chem-shared-docs/spack`) — edits made "here" are actually edits in the GEOS-Chem submodule and need to be committed/PR'd there.

Because of this structure, **when investigating a bug or feature, always check which repo actually owns the code**: CMake wrapper/build-option logic and version pinning belong in GCClassic; almost everything else (science modules, run directory scripts, tests) lives in the submodules and should be changed via PRs to those upstream repos, not to GCClassic directly.

## Cloning and submodules

```console
git clone --recurse-submodules https://github.com/geoschem/GCClassic.git
cd GCClassic
```

If submodules are out of sync (e.g. after checking out a different branch/tag), update them:

```console
git submodule update --init --recursive
```

Checking out a specific released version:

```console
git checkout tags/14.0.0
git branch version_14.0.0
git checkout version_14.0.0
git submodule update --init --recursive
```

## Building GEOS-Chem Classic

The build is CMake-based and always happens **inside a generated run directory**, not in the source tree.

1. Create a run directory (interactive script, prompts for sim type/grid/met/etc.):
   ```console
   cd run/
   ./createRunDir.sh
   ```
2. Configure with CMake from the run directory's `build/` subfolder, pointing at the source via the
   `CodeDir` symlink that `createRunDir.sh` creates in the run directory:
   ```console
   cd /path/to/run/directory/build
   cmake ../CodeDir -DRUNDIR=..
   ```
3. Compile and install the executable into the run directory:
   ```console
   make -j
   make install
   ```

Key CMake build options (pass as `-DOPTION=VALUE` to the `cmake` command, defined in
`CMakeScripts/GC-ConfigureClassic.cmake`):

- `OMP` (ON/OFF) — OpenMP threading
- `MECH` — chemistry mechanism: `fullchem` (default), `carbon`, `Hg`, `custom`
- `USE_REAL8` (ON/OFF) — 8-byte floating point precision
- `SANITIZE` (ON/OFF, GNU only) — address/leak/undefined-behavior sanitizers
- `TOMAS` / `TOMAS_BINS` (`NA`/`15`/`40`) — TOMAS aerosol microphysics
- `APM`, `RRTMG` — optional components
- `CMAKE_BUILD_TYPE` — `Release` (default), `Debug`, `RelWithDebInfo`

Supported Fortran compilers: **Intel** and **GNU** only (`GEOSChem_Fortran_FLAGS_{Intel,GNU}` in the top-level `CMakeLists.txt`); anything else is a hard CMake error.

CI (`.github/workflows/gcclassic-compile-tests.yml`) does a compile-only smoke test on gfortran for every
push/PR:
```console
git submodule update --init --recursive
cd test/integration/GCClassic
./integrationTest.sh -d $HOME/compile-tests -t compile
```

## Testing

Test infrastructure lives in `test/` (symlinked from `src/GEOS-Chem/test`), organized as:

- `test/integration/GCClassic/` — compiles and runs several out-of-the-box GCClassic configurations to catch build/run-directory regressions. Driver: `integrationTest.sh -d <root-dir> -t compile|all [-e env-file] [-q]`
  - `-t compile` — compile-only
  - `-t all` — compile and execute short simulations
  - `-q` — quick subset of tests, for local dev/debug
- `test/parallel/GCClassic/` — runs configurations with varying OpenMP thread counts to catch parallelization bugs.
- `test/difference/` — compares output of two integration/parallel test runs for bit-for-bit identicality (e.g. before/after a structural change).
- `test/shared/` — common functions/settings (`commonFunctionsForTests.sh`) used by all of the above.

Run from the repo root:
```console
cd test/integration/GCClassic
./integrationTest.sh -d /path/to/test/dir -t compile
```

A conda environment with netCDF active will make these scripts abort immediately — `conda deactivate` first.

## Documentation

Docs source is in `docs/source/` (Sphinx/ReadTheDocs, published at geos-chem.readthedocs.io), organized into `getting-started/`, `gcclassic-user-guide/`, `supplemental-guides/`, `help-and-reference/`. Shared content (build-system guides, conventions common to GCClassic/GCHP) comes from the `geos-chem-shared-docs` submodule embedded at `docs/source/geos-chem-shared-docs`.

## Versioning and changes

- `CHANGELOG.md` follows Keep a Changelog / SemVer, and tracks changes to the **wrapper repo** — i.e.   primarily submodule version bumps (GEOS-Chem, HEMCO, Cloud-J, HETP) plus CMake/docs/CI changes made directly in GCClassic. Submodule-internal changes are documented in each submodule's own CHANGELOG.md.
- The `PROJECT VERSION` in the top-level `CMakeLists.txt` is the GCClassic release version and should track the pinned submodule versions.
- Commit messages/merges in this repo's history follow the pattern `<Component> update: Merge PR #NNNN (<summary>)` — used for both direct GCClassic changes and submodule-pointer bumps.

## Contribution model

This is a community-governed, grass-roots model (see `CONTRIBUTING.md`). Practical implications for making changes:

- Substantive science/structural updates to GEOS-Chem/HEMCO are expected to go through the upstream submodule repos and the GEOS-Chem Steering Committee process, not as direct GCClassic PRs.
- Any structural (non-science) update should be accompanied by a difference test against the prior version to confirm identical results.
- A `CHANGELOG.md` entry is expected for user-facing changes.
- Changes affecting run directories/config should be mirrored for both GEOS-Chem Classic and GCHP where applicable.
