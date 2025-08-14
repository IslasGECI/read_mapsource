# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Fixed

### Changed

### Removed

## [0.3.0] - 2025-08-14
### Added
- CLI function `check_traps()` to check all traps in the mapsource and compare them with the traps in the POSITION_TRAPS file.
### Changed
- The function `update_active_traps()` now check the traps ID on both directions.

## [0.2.0] - 2025-08-12
### Changed
- The function `write_position_traps_for_one_week()` now receives the mapsource path instead the directory. Also writes the next positions file with the `IG` or `IS` prefix, as the mapsource path indicates.

## [0.1.0] - 2024-04-10

### Added

- Function `check_cameras()` to compare IDs between IG_CAMARAS revision_campo and cameras mapsource.

[Unreleased]: https://github.com/IslasGECI/read_mapsource/compare/HEAD...v0.3.0
[0.3.0]: https://github.com/IslasGECI/read_mapsource/compare/v0.3.0...v0.2.0
[0.2.0]: https://github.com/IslasGECI/read_mapsource/compare/v0.2.0...v0.1.0
[0.1.0]: https://github.com/IslasGECI/read_mapsource/compare/v0.1.0
