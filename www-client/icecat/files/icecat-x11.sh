#!/bin/sh

#
# Run GNU IceCat on X11
#
export MOZ_DISABLE_WAYLAND=1
exec @PREFIX@/bin/icecat "$@"
