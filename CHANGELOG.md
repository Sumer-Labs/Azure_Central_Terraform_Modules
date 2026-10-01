# Changelog

All notable changes to the platform are documented in this file.

## [1.2.0] - 2026-10-02

### Added

- Enabled GitHub immutable releases for platform releases.
- Platform release workflow now creates releases as drafts before publishing.
- Platform release workflow verifies the release tag points to the expected commit.
- Platform release workflow verifies the published release is immutable.

## [1.1.0] - 2026-10-01

### Added

- Automated platform release workflow.
- Automatic platform version detection from CHANGELOG.md.
- Automatic creation of platform Git tags and GitHub Releases.
- Automatic mapping of platform release tags to the exact Git commit.
- Platform release environment.

### Platform Release

- Release format: `platform-v<MAJOR>.<MINOR>.<PATCH>`.
- Platform releases are automatically created when a new version is merged to `main`.
- Application teams consume the platform using the platform release tag.
- Application teams do not need to manage commit SHAs.

## [1.0.0] - 2026-10-01

### Added

- Initial platform release.
- Central Terraform version management.
- Central AzureRM provider management.
- Reusable Terraform CI workflow.
- Terraform validation.
- Terraform tests.
- Checkov security scanning.
- Terraform plan.
- Terraform Policy-as-Code.
- Reusable VNet module.
- Required tagging policy.

### Infrastructure Modules

- Virtual Network
- Subnets
- Dedicated NSG per subnet
- NSG-to-subnet associations