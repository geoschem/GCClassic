# Changelog

This file documents all notable changes to the GEOS-Chem Classic wrapper repository since version 13.4.1. See also CHANGELOG files for individual submodules:
- src/geos-chem/CHANGELOG.md
- src/HEMCO/CHANGELOG.md
- src/Cloud-J/CHANGELOG.md

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] - TBD
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
