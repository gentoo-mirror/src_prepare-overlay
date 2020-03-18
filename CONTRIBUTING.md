# Contributing

## How to contribute

src_prepare-overlay is very open to contribution and encourages it.
There are several ways to contribute to this overlay:

#### Filing an issue

Those that do not have good knowledge in writing ebuilds can
[file an issue](https://gitlab.com/src_prepare/src_prepare-overlay/-/issues)
so we can create the ebuild and maintain it for the community.
Before filing an issue, you will have to read the [filing an issue guidelines](#filing-an-issue-1).

#### Pulling Merge Requests

Those that want to help us easily maintain an ebuild without making us spend our time creating the ebuild
can create the ebuild and pull a [merge request](https://gitlab.com/src_prepare/src_prepare-overlay/-/merge_requests)
so we can accept and add the ebuild to our overlay and maintain it for you.
Before pulling a merge request, you will have to read the [pulling merge requests guidelines](#pulling-merge-requests-1).

## Contributing guidelines

Before contributing, you will have to read the contributing guidelines as we will **not** accept your request
if you do not respect our community guidelines.

#### Filing an issue

When filing an issue you will have to provide:

- [CATEGORY]/[PACKAGE_NAME] (e.g. `www-client/icecat`)
- the description of the package
- the home page of the package 
- OPTIONAL: the direct download link of the package 
- the license of the package (e.g. GPLv2)

by filling the skeleton of the ebuild in quotes:

```
NAME=""

DESCRIPTION=""     
HOMEPAGE=""     
SRC_URI=""     
LICENSE=""     
```

After this, you can safely file the issue, and we will take care of it.

#### Pulling Merge Requests

When committing and/or pulling merge requests, you will have to respect our
Committing & Pulling Merge Requests System (CnPMRS)
so we can easily identify the changes:

- Provide us the Manifest file;
- Follow the committing & pulling merge request layout (below).

Each commit will have to be based on this layout:

`[CATEGORY]/[PACKAGE_NAME]: [COMMIT_MESSAGE]`

For example, if the package is called **mail-client/freelook-bin**,
and you have added this package, the commit or merge request should look like this:

`mail-client/freelook-bin: add freelook-bin-[PACKAGE_VERSION]` # e.g. 1.0.0

For example, if the package is called **mail-client/freelook-bin**,
and you have fixed an error, the commit or merge request should look like this:

`mail-client/freelook-bin: fix QA - EROOT missing slash`

**This system also applies on your metadata.xml and Manifest.**