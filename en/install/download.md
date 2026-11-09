---
source: Download
source_url: https://www.redmine.org/projects/redmine/wiki/Download
source_version: 251
source_updated_on: '2026-11-01T22:46:07Z'
---

# Download

## Latest releases

Redmine releases are available in either `.tar.gz` or `.zip` format:

|  |  |  |  |
|----|----|----|----|
| redmine-6.0.12 | 2026-11-01 | [redmine-6.0.12.tar.gz](https://www.redmine.org/releases/redmine-6.0.12.tar.gz) | `9df2d08cff4264a2f49b380666018ac388cc17cddd75594c58cf55833f6d021b` |
| [redmine-6.0.12.zip](https://www.redmine.org/releases/redmine-6.0.12.zip) | `383eb661a6a91f9217d319e57e8fc8c64f7cfba5adf3929c398c03cc8a0bbe66` |  |  |
| redmine-6.1.6 | 2026-11-01 | [redmine-6.1.6.tar.gz](https://www.redmine.org/releases/redmine-6.1.6.tar.gz) | `a09f0541e3ef5579de8be1c21fc9cabbd7625d77ec4dd2ddddc39ad9c2c5a483` |
| [redmine-6.1.6.zip](https://www.redmine.org/releases/redmine-6.1.6.zip) | `9fb1c4caf380db9b84bd9421f0964a58ad43d218e60841b0d8e263a436ceb792` |  |  |
| redmine-7.0.3 | 2026-11-01 | [redmine-7.0.3.tar.gz](https://www.redmine.org/releases/redmine-7.0.3.tar.gz) | `0b6b24c033341a9d7ad52cfcfa7b1bc913c191c7a604f740d863f16249dd3c15` |
| [redmine-7.0.3.zip](https://www.redmine.org/releases/redmine-7.0.3.zip) | `ee82a3c405aba179f1b6e27ce8a3b8ae18280778e539493e45c8de3b73229529` |  |  |

See the [Changelog](https://www.redmine.org/projects/redmine/wiki/Changelog) for details and [RedmineInstall](install.md) for installation instructions or [RedmineUpgrade](upgrade.md) for upgrading instructions.

You can also browse the [older releases](https://www.redmine.org/releases/).

## Versions status and releases policy

| Version | Support Status |
|----|----|
| trunk | Unstable version. It will receive new features, bug fixes, and security updates. |
| **7.0.x** | **Latest stable version. Fully supported with new features, bug fixes, and security updates.** |
| 6.1.x | Latest stable version. It will receive only bug fixes and security updates. |
| 6.0.x | Legacy stable version. It will receive only important security updates. |
| 5.1.x | Unsupported. |
| 5.0.x | Unsupported. |
| 4.x and older | Unsupported. |

### Release policy

- Next Redmine releases are always available in [Roadmap](https://www.redmine.org/projects/redmine/roadmap) page
- In a best-effort manner:
  - Minor versions are released every 3 months
  - Major versions once per year
  - Critical / important security fixes or major bug fixes as soon as possible.

### Support policy

- latest minor version is fully supported and it is fully supported
- latest minor version - 1 is supported with bug fixes and security updates
- latest minor version - 2 with important security updates only

For example, if Redmine 6.0.0 is the latest version, then:

- Redmine 6.0.\* is the latest minor version
- Redmine 5.1.\* in the latest minor version –1 and it will receive bug fixes and security updates
- Redmine 5.0.\* is the latest minor version –2 and it will receive important security updates only.

## Source code

You can checkout the source code of Redmine from the Subversion repository. This is the preferred way to get Redmine if you want to benefit from the latest improvements and be able to upgrade easily.

The URL of the official Subversion repository is: https://svn.redmine.org/redmine

Alternatively, you can clone it from the Github mirror maintained by the community: https://github.com/redmine/redmine

### 7.0 Stable

You can checkout the latest stable source with one of the following commands:

**Subversion**

    svn co https://svn.redmine.org/redmine/branches/7.0-stable redmine-7.0

It will create a directory named `redmine-7.0` and you’ll be able to update your Redmine copy using `svn update` in this directory.

### Development (unstable)

You can checkout the latest development source from the trunk with one of the following commands:

**Subversion**

    svn co https://svn.redmine.org/redmine/trunk redmine

## Third-party Redmine bundles

- [TurnKey Redmine Appliance](http://www.turnkeylinux.org/redmine) - Provides a free lightweight Debian-based Redmine appliance (available as an ISO, virtual machine image or cloud image).

<!-- -->

- [BitNami Redmine Stack](https://bitnami.com/stack/redmine) – Provides free virtual machines, containers, and cloud images for Redmine.
