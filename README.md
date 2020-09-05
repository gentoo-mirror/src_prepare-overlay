<p align="center">
    <a href="https://gitlab.com/src_prepare/src_prepare-overlay/pipelines">
        <img src="https://gitlab.com/src_prepare/src_prepare-overlay/badges/master/pipeline.svg">
    </a>
    <a href="https://gentoo.org/">
        <img src="https://gitlab.com/src_prepare/badge/-/raw/master/powered-by-gentoo-linux-tyrian.svg">
    </a>
    <a href="./LICENSE">
        <img src="https://img.shields.io/badge/license-GPLv2-blue.svg">
    </a>
    <a href="https://app.element.io/#/room/#src_prepare:matrix.org">
        <img src="https://gitlab.com/src_prepare/badge/-/raw/master/chat-matrix-blue.svg">
    </a>
    <a href="https://gitlab.com/src_prepare/src_prepare-overlay/commits/master.atom">
        <img src="https://gitlab.com/src_prepare/badge/-/raw/master/feed-atom-orange.svg">
    </a>
</p>

# src_prepare Gentoo overlay

This is the overlay of our Matrix group where we talk about topics related to Gentoo (development, maintainance, support, communities and more).

**WARNING: Do not expect high quality ebuilds!** While we do the best we can, most of us are still learning.

A quick guide on how to test ebuilds will follow.

## Why create this overlay?

Mostly to have fun.

## For whom?

src_prepare overlay is based on the concept of the [GURU](https://wiki.gentoo.org/wiki/Project:GURU) project: to create a repository maintained collaboratively by Gentoo users, for Gentoo users.

Despite being based on the concept of the GURU project, src_prepare has different goals in mind:

- openness
	- main git repository is hosted on [GitLab](https://gitlab.com/src_prepare/src_prepare-overlay), with mirrors set to [GitHub](https://github.com/xgqt/src_prepare-overlay) and [Codeberg](https://codeberg.org/src_prepare/src_prepare-overlay);
	- no requirement for GPG keys;
	- no requirement for private info;
- ease of access
	- easier for one to get access to the `master` branch;
	- main contact with the src_prepare project is via [[matrix]](https://matrix.to/#/#src_prepare:matrix.org);
- freedom and privacy
	- more freedom in creating ebuilds;
	- no requirement for GPG keys;
	- no requirement for private info;

The src_prepare project doesn't want to overtake or compete with the GURU project. The GURU project is aimed on professionalism and quality, whereas src_prepare is aimed on openness and ease of access.

## Adding the overlay

### Official list

#### Layman

If you are using [Layman](https://wiki.gentoo.org/wiki/Layman), execute:

``` sh
layman -a src_prepare-overlay
```

#### eselect-repository

If you are using [eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository), execute:

``` sh
eselect repository enable src_prepare-overlay
```

#### Manual

If you want to manually add the overlay, see [examples/repos.conf/src_prepare-overlay.conf](https://gitlab.com/src_prepare/src_prepare-overlay/blob/master/examples/repos.conf/src_prepare-overlay.conf).

##### Layman

If you are using [Layman](https://wiki.gentoo.org/wiki/Layman), execute:

``` sh
layman -o 'https://gitlab.com/src_prepare/src_prepare-overlay/raw/master/repositories.xml' -f -a src_prepare-overlay
```

## How do I sync this?

Execute:

``` sh
emaint sync -r src_prepare-overlay
```

## It says the ebuild is masked, what do I do?

See [examples/package.accept_keywords/src_prepare-overlay](https://gitlab.com/src_prepare/src_prepare-overlay/blob/master/examples/package.accept_keywords/src_prepare-overlay).

## Contributing

We appreciate and encourage for contribution. If you want a specific package or want to create a package for us to maintain, see [CONTRIBUTING.md](/CONTRIBUTING.md).


## Quick maintainer guide

### Testing ebuilds

``` sh
repoman manifest
ebuild FILE clean merge
```
