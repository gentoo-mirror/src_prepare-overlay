# src_prepare Gentoo overlay

## What's this?

This is the overlay of our telegram group where we talk about Gentoo stuff (development, maintainance, mistakes, community).

Do not expect high quality ebuilds, while we do the best we can, most of us are still learning.

A quick guide on how to test ebuilds will follow.

## Why create such overlay?

Mostly to have fun.

"My primary goal was to have all the ebuilds for small things for desktop "ricing" and weird ones that would not fit into the main overlay." ~XGQT 

## How do I add this?

### Official list

With layman: `layman -a src_prepare-overlay`

or

With eselect-repository: `eselect repository enable src_prepare-overlay`

### Manual

Check out `examples/repos.conf/src_prepare-overlay.conf`

or

With layman: `layman -o 'https://gitlab.com/src_prepare/src_prepare-overlay/raw/master/repositories.xml' -f -a src_prepare-overlay`

## How do I sync this?

Run `sudo emaint sync -r src_prepare-overlay`

## It says the ebuild is masked, what do I do?

Check out `examples/package.accept_keywords/src_prepare-overlay`

## I can help, what ebuilds do you need?

Check out `TODO.md`

## Quick maintainer guide

### Testing ebuilds

`sudo ebuild FILE clean manifest merge`
