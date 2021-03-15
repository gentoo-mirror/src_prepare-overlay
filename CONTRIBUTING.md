# Contributing

## How to contribute

src_prepare-overlay is very open to contribution and encourages it.
There are several ways to contribute to this overlay:

#### Submitting an issue

Those that do not have good knowledge in writing ebuilds can
[submit an issue](https://gitlab.com/src_prepare/src_prepare-overlay/-/issues)
so we can create the ebuild and maintain it for the community.
Before submitting an issue, you will have to read the [submitting an issue guidelines](#submitting-an-issue-1).

#### Submitting Merge Requests

Those that want to help us easily maintain an ebuild without making us spend our time creating the ebuild
can create the ebuild and submit a [merge request](https://gitlab.com/src_prepare/src_prepare-overlay/-/merge_requests)
so we can accept and add the ebuild to our overlay and maintain it for you.
Before submitting a merge request, you will have to read the [submitting merge requests guidelines](#submitting-merge-requests-1).

## Contributing guidelines

Before contributing, you will have to read the contributing guidelines as we will **not** accept your request
if you do not respect our community guidelines.

**Before submitting an issue or submitting a Merge Request,
first check if the package you are providing is not in [TODO.md](/TODO.md).**

#### Submitting an issue

When submitting an issue you will have to provide:

- `category/package` (e.g. `www-client/icecat`)
- the description of the package
- the home page of the package
- OPTIONAL: the direct download link of the package
- the license of the package (e.g. GPLv2)

by submitting the skeleton of the ebuild in quotes:

```
NAME=""

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""
LICENSE=""
```

After this, you can safely submit the issue, and we will take care of it.

#### Submitting Merge Requests

When committing and/or submitting merge requests, you will have to respect our
Committing & Submitting Merge Requests System (CnPMRS)
so we can easily identify the changes:

- Provide us the Manifest file;
- Follow the committing & submitting merge request layout (below).

Each commit will have to be based on this layout:

`category/package: [COMMIT_MESSAGE]`

For example, if the package is called **mail-client/freelook-bin**,
and you have added this package, the commit or merge request should look like this:

`mail-client/freelook-bin: add freelook-bin-[PACKAGE_VERSION]` # e.g. 1.0.0

For example, if the package is called **mail-client/freelook-bin**,
and you have fixed an error, the commit or merge request should look like this:

`mail-client/freelook-bin: fix QA - EROOT missing slash`

**This system also applies on your metadata.xml and Manifest.**

## Development workflow

### Add the overlay to the system
Edit /etc/portage/repos.conf/src_prepare-overlay.conf (as root)
```toml
[src_prepare-overlay]
auto-sync = yes
location = /var/db/repos/src_prepare-overlay
sync-git-clone-extra-opts = --depth=999999999 --no-shallow-submodules --no-single-branch --verbose
sync-git-pull-extra-opts = --depth=999999999 --verbose
sync-type = git
sync-uri = git@gitlab.com:src_prepare/src_prepare-overlay.git
sync-user = <your_user_developer>:portage
```
If you don't have write access to the cloned branch yet use "sync-uri = https://gitlab.com/src_prepare/src_prepare-overlay.git" instead.

If you lock your SSH key with a password autosyncing may fail.
To evade that use "auto-sync = no" and pull the changes manually (or using a different tool other than 'emerge --sync' or 'eix-sync').
Either way, remember that if you pull with a user different than <your_user_developer> the sync will fail (because that user likely won't have the SSH keys).

### Sync the overlay
As root
```bash
emaint sync -r src_prepare-overlay
```

### Add new package

#### Basics
As user
```bash
cd /var/db/repos/src_prepare-overlay
mkdir -p category/package-name
cd category/package-name
touch metadata.xml
touch package-name-package-version.ebuild
```
Now edit the ebuild and metadata files accordingly.
[For ebuild developemnt details look here](https://devmanual.gentoo.org/)

#### Tests
If a package's upstream has tests don't forget to enable them.
If they fail describe why in the comments inside the ebuild
(but please make the descriptions reasonably short).

##### Package testing
Make sure you have FEATURES="test" enabled in the make.conf
```bash
if ! grep test /etc/portage/make.conf
then
    echo 'FEATURES="${FEATURES} test"' >> /etc/portage/make.conf
fi
```
And then, as root
```bash
echo "category/package-name test" >> /etc/portage/package.use/development-tests
```

##### Ebuild testing
repoman (app-portage/repoman) and pkgcheck (dev-util/pkgcheck)
will give you a report of what should be fixed.
```bash
repoman -Idx full
pkgcheck scan
```

#### Metadata
metadata.xml should contain at least these lines:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE pkgmetadata SYSTEM "http://www.gentoo.org/dtd/metadata.dtd">
<pkgmetadata>
  <upstream>
    <remote-id type="githosting">organization-or-user/package</remote-id>
  </upstream>
</pkgmetadata>
```
Adjust the "type" and "organization-or-user/package" accordingly.

#### Installation
If the (system wide) repository is set up correctly you should be able to just emerge the package you added right away
```bash
emegre --ask --jobs=1 --oneshot --quiet-build=n --verbose category/package-name
```

#### Git
Follow the rules described in ["Submitting Merge Requests"](#submitting-merge-requests-1) section.
GPG signing is not required but encouraged. Gentoo Wiki provides a great example [on creating a strong key](https://wiki.gentoo.org/wiki/Project:Infrastructure/Generating_GLEP_63_based_OpenPGP_keys).
