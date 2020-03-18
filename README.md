# src_prepare Gentoo overlay

This is the overlay of our Telegram group where we talk about topics related to Gentoo (development, maintainance, mistakes, community).

**WARNING: Do not expect high quality ebuilds!** While we do the best we can, most of us are still learning.

A quick guide on how to test ebuilds will follow.

## Why create this overlay?

Mostly to have fun.

"My primary goal was to have all the ebuilds for small things for desktop "ricing" and weird ones that would not fit into the main overlay." ~XGQT 

In short, we want to contribute :)

## How do I add this?

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

## I can help, what ebuilds do you need?

See [TODO.md](https://gitlab.com/src_prepare/src_prepare-overlay/-/blob/master/TODO.md)

## Quick maintainer guide

### Testing ebuilds

``` sh
repoman manifest
sudo ebuild FILE clean merge
```
