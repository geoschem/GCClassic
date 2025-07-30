# Changelog

This file documents all notable changes to the GEOS-Chem Classic wrapper repository since version 13.4.1. See also CHANGELOG files for individual submodules:
- src/geos-chem/CHANGELOG.md
- src/HEMCO/CHANGELOG.md
- src/Cloud-J/CHANGELOG.md

The format is based on [Keep a
Changelog](https://keepachangelog.com/en/1.0.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] - TBD
### Changed
- Updated `lint-ci-workflows` to run on `main` and `dev/*` branches
- Updated badges on `README.md` and `docs/source/index.rst`

### Fixed
- Fixed security issues in GitHub Actions that caused the `lint-ci-workflows` action to fail

### Removed
- Removed the Azure Dev Pipelines workflows; these are now superseded by the `gcclassic-compile-tests` GitHub action

## [14.6.3] - 2025-07-28
### Added
- Added `-DDEBUG` flag to `GEOSChem_Fortran_FLAGS_DEBUG_Intel` and `GEOSChem_Fortran_FLAGS_DEBUG_GNU` to toggle debug-only code

### Changed
- Updated `CMakeLists.txt` to set compilation option `mcmodel=small` for ARM-based CPUs, as ARM does not support `mcmodel=medium`
- Updated ReadTheDocs documentation to state that we are using Spack v0.23.1 in the Spack installation guide
- Updated GEOS-Chem submodule to 14.6.3
- Updated HEMCO submodule to 3.11.2

## [14.6.2] - 2025-06-12
### Changed
- Updated GEOS-Chem submodule to 14.6.2

## [14.6.1] - 2025-05-29
### Added
- Added RTD documentation updates for GEOS-Chem 14.6.1

## [14.6.0] - 2025-04-18
### Added
- Added a CI workflow that checks for issues in GCClassic's CI workflows
- Added documentation for GEOS-Chem simulations to ReadTheDocs

### Changed
- Bumped `jinja2` to 3.1.6 in `docs/source/requirements.txt` (fixes a security issue identified by @dependabot)

### Fixed
- Fixed broken links and references in the "GEOS-Chem restart files" ReadTheDocs documentation

## [14.5.3] - 2025-03-05
### Added
- Updated RTD docs to state that users wishing not to open AWS account can use AWS CLI commands with `--no-sign-request1`

### Changed
- Updated GEOS-Chem submodule to 14.5.3
- Updated HEMCO submodule to 3.10.2

### Fixed
- Fixed error with the `rubric` section in the RTD planeflight documentation

## [14.5.2] - 2025-02-12
### Added
- Added clarifying text about which types of data can use altitude coordinates for the Planeflight diagnostic in RTD documentation 
- Added warning for users to preprocess ObsPack GLOBALVIEWplus CH4 data files before reading into GEOS-Chem in RTD documentation
- Added text to RTD stating that data download from `s3://geos-chem` is and `s3://gcgrid` is free

### Changed
- Bumped `jinja2` to version 3.1.5 in `docs/requirements.txt` to fix a security issue
- Changed the build sequence so that the KPP-Standalone is only built when configuring with `-DKPPSA=y`
- Updated RTD documentation to state that older Intel compilers may cause unexpected results; Also updated to recommend GCC 10 and later.
- Updated RTD documentation for fullchem rundir creation, which now asks users if they wish to build KPP-Standalone

## [14.5.1] - 2025-01-10
### Added
- Added code to `src/CMakeLists.txt` to build & install the KPP standalone executable when `fullchem` or `custom` mechanisms are selected
- Added ReadTheDocs Supplemental Guide on using the KPP-Standalone Box Model and KPP-Standalone Interface in GEOS-Chem

### Changed
- Changed `submodules: true` to `submodules: recursive` in `.ci-pipelines/*.yml` files, which will fetch all levels of submodules in Azure CI tests.

### Fixed
- Fixed logic error in `src/CMakeLists.txt` that attempted to build the KPP standalone for the carbon simulation (see geoschem/GCClassic #78)
- Fixed broken links in ReadTheDocs documentation

## [14.5.0] - 2024-11-08
### Changed
- Updated GEOS-Chem to 14.5.0
- Updated HEMCO to 3.10.0
- Updated Cloud-J to 8.0.1
- Updated `docs/source/geos-chem-shared-docs/spack/packages.yaml` to use GCC 12.2.0 compilers
- Updated documentation for version 14.5.0
- Moved several doc files (not supplemental guides) that are used in both GCClassic and GCHP the to `geos-chem-shared-docs/doc` folder

### Fixed
- Fixed formatting error in `.github/workflows/stale.yml` that caused the Mark Stale Issues action not to run
- Updated to Python package `jinja2==3.1.4` in `docs/requirements.txt` (fixes a security issue)

## [14.4.3] - 2024-08-13
### Changed
- Updated GEOS-Chem (science codebase) to 14.4.3
- Updated HEMCO to 3.9.3
- Updated Cloud-J to 7.7.3
- Updated documentation (clarified discussion of grid edges)

### Fixed
- Added brackets around `exempt-issue-labels` list in `.github/workflows/stale.yml`

## [14.4.2] - 2024-07-24
### Added
- ReadTheDocs update for for Cloud-J input parameter `num_levs_with_cloud`
- ReadTheDocs update: add section about using a dry-run simulation to Quickstart Guide

### Changed
- Updated Cloud-J submodule to 7.7.2
- Discontinue support of FAST-JX for all simulations except Hg
- ReadTheDocs now describes latitude and longitude bounds as grid cell edges

## [14.4.1] - 2024-06-28
### Fixed
- Fixed formatting error in `.github/workflows/stale.yml` that caused the Mark Stale Issues action not to run

## [14.4.0] - 2024-05-30
### Added
- RTD docs now includes Supplemental Guide "Archiving Output with the History diagnostics"
- GitHub Action config file `.github/workflows/stale.yml`, which replaces StaleBot
- Added git submodule HETP for aerosol thermodynamics in GEOS-Chem

### Changed
- Updated Python package versions for ReadTheDocs in `docs/requirements.txt`
- Now request Python 3.12 for ReadTheDocs builds in `.readthedocs.yaml`
- Updated GEOS-Chem submodule to 14.4.0
- Updated HEMCO submodule to 3.9.0
- Converted Github issue templates to issue forms using YAML definition files
- Updated RTD documentation for the 14.4.0 release

### Removed
- `BPCH_DIAG` configuration option and related ReadTheDocs documentation
- GitHub config files `.github/stale.yml` and `.github/no-response.yml`
- Unused CO2 and carbon simulation options from `geoschem_config.yml` (and from related code in `co2_mod.F90`).

## [14.3.1] - 2024-04-02
### Added
- GitHub action to perform compile-only integration tests

### Changed
- Updated GEOS-Chem submodule to 14.3.1
- Updated HEMCO submodule to 3.8.1
- Now use short submodule names (i.e. without the full path) in `.gitmodules`
- Remove obsolete CH4 menu options from config file documentation

## [14.3.0] - 2024-02-07
### Changed
- Updated GEOS-Chem submodule to 14.3.0
- Updated HEMCO submodule to 3.6.0

### Added
- Added Cloud-J submodule which is the new default photolysis package used in GEOS-Chem
- Added compile option FASTJX to use legacy FAST-JX photolysis in GEOS-Chem instead of Cloud-J
- Added ReadTheDocs documentation for nested-grid simulations

## [14.2.3] - 2023-12-01
### Added
- Script `.release/changeVersionNumbers.sh` to change version numbers before a new GEOS-Chem Classic release

## [14.2.2] - 2023-10-23
### Changed
- Updated GEOS-Chem submodule to 14.2.2

## [14.2.1] - 2023-10-10
### Changed
- `test` now points to `src/GEOS-Chem/test`
- Updated GEOS-Chem submodule to 14.2.1
- Updated HEMCO submodule to 3.7.1
- Updated version numbers
- Updated version numbers in `CMakeLists.txt` and `docs/source/conf.py` to 14.2.0

## [14.2.0] - 2023-10-05
## Added
- Quick start guide for GEOS-Chem Classic in ReadTheDocs
- Add note about WashU status downtime and link to `itstatus.wustl.edu`
- Added `SatDiagn` to list of GEOS-Chem History collections
- Added definitions for transport tracer properties to ReadTheDocs

### Changed
- Updated GEOS-Chem submodule to 14.2.0
- Updated HEMCO submodule to 3.7.0
- Updated version numbers in `CMakeLists.txt` and `docs/source/conf.py` to 14.2.0
- Reorganize folder structure of ReadTheDocs `docs/source` subdirectories
- Note that HEMCO log output is now sent to the GEOS-Chem log file
- Updated `AUTHORS.txt` for version 14.2.0
- Updated links in `README.md` to point to `http://geos-chem.org`
- Updated logo & badge links in `README.md` to use HTML
- Updated version numbers to 14.2.0

### Fixed
- Fixed typo in Intel debug option in `CMakeLists.txt`
- Fixed broken link to NCO page in ReadTheDocs

### Removed
- `passive_species` menu in `geoschem_config.rst` ReadTheDocs file

## [14.1.1] - 2023-03-03
### Added
  - Added `.github/ISSUE_TEMPLATE/config.yml` file w/ Github issue options

### Changed
  - Updated GEOS-Chem submodule to 14.1.1
  - Updated HEMCO submodule to 3.6.2
  - The GitHub PR template is now named `./github/PULL_REQUEST_TEMPLATE.md`
  - Updated ReadTheDocs user registration documentation GEOS-Chem 14.1.1
  - Updated ReadTheDocs run directory creation information for GEOS-Chem 14.1.1
  - Updated version numbers in `CMakeLists.txt` and `docs/source/conf.py` to 14.1.1

## [14.1.0] - 2023-02-01
### Added
  - Added SANITIZE CMake option

### Changed
  - Updated GEOS-Chem submodule to 14.1.0
  - Updated HEMCO submodule to 3.6.0
  - Updated ReadTheDocs documentation for 14.1.0

### Fixed
  - Fixed logic in .github/workflows/findRefKey.sh for determing previous commit

## [14.0.2] - 2022-11-29
### Changed
  - Updated GEOS-Chem submodule to 14.0.2
  - Updated HEMCO submodule to 3.5.2
  - Updated the documentation for clarity


## [14.0.1] - 2022-10-31
### Changed
  - Updated GEOS-Chem submodule to 14.0.1


## [14.0.0] - 2022-10-25
### Added
  - Added files for GEOS-Chem User Manual on ReadTheDocs
  - Created CHANGELOG.md

### Changed
  - Changed GEOS-Chem submodule to 14.0.0 release
  - Changed HEMCO submodule to 3.5.0 release
  - Updated CONTRIBUTING.md and SUPPORT.md to retire guidelines on GEOS-Chem wiki
