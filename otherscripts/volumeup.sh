#!/bin/bash
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>
# Copyright (C) 2014 Alexander Keller <github@nycroth.com>

# The second parameter overrides the mixer selection
# For PulseAudio users, use "pulse"
# For Jack/Jack2 users, use "jackplug"
# For ALSA users, you may use "default" for your primary card
# or you may use hw:# where # is the number of the card desired
MIXER="default"
[ -n "$(lsmod | grep pulse)" ] && MIXER="pulse"
[ -n "$(lsmod | grep jack)" ] && MIXER="jackplug"
MIXER="${2:-$MIXER}"

# The instance option sets the control to report and configure
# This defaults to the first control of your selected mixer
# For a list of the available, use `amixer -D $Your_Mixer scontrols`
SCONTROL="${BLOCK_INSTANCE:-$(amixer -D $MIXER scontrols |
                  sed -n "s/Simple mixer control '\([A-Za-z ]*\)',0/\1/p" |
                  head -n1
                )}"

# The first parameter sets the step to change the volume by (and units to display)
# This may be in in % or dB (eg. 5% or vloume3dB)
STEP="${1:-5%}"

capability() { # Return "Capture" if the device is a capture device
  amixer -D $MIXER get $SCONTROL |
    sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
}

amixer -q -D $MIXER sset $SCONTROL $(capability) ${STEP}+ unmute
pkill -RTMIN+1 i3blocks
