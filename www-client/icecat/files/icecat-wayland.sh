#!/bin/sh

#
# Run GNU IceCat under Wayland
#
export MOZ_ENABLE_WAYLAND=1
exec @PREFIX@/bin/icecat "$@"
