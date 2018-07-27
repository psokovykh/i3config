#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Copyright (C) 2016 James Murphy
# Licensed under the GPL version 2 only
#
# A battery indicator blocklet script for i3blocks

from subprocess import check_output
import sys
import codecs

sys.stdout = codecs.getwriter("utf-8")(sys.stdout.detach())

status = check_output(['acpi'], universal_newlines=True)

if not status:
    # stands for no battery found
    fulltext=""
    color=""
else:
    # if there is more than one battery in one laptop, the percentage left is 
    # available for each battery separately, although state and remaining 
    # time for overall block is shown in the status of the first battery 
    batteries = status.split("\n")
    state_batteries=[]
    commasplitstatus_batteries=[]
    percentleft_batteries=[]
    for battery in batteries:
        if battery!='':
            state_batteries.append(battery.split(": ")[1].split(", ")[0])
            commasplitstatus = battery.split(", ")
            percentleft_batteries.append(int(commasplitstatus[1].rstrip("%\n")))
            commasplitstatus_batteries.append(commasplitstatus)
    state = state_batteries[0]
    commasplitstatus = commasplitstatus_batteries[0]
    percentleft = int(sum(percentleft_batteries)/len(percentleft_batteries))
    # stands for charging
    FA_LIGHTNING = ""

    # stands for plugged in
    FA_PLUG = ""

    fulltext=""
    timeleft = ""
    color=""

    if percentleft < 30:
        fulltext=""
        color = "#FF5722"
    elif percentleft < 70:
        fulltext=""
        color = "#FF9800"
    else:
        fulltext=""
        color = "#4CAF50"

    if state == "Discharging":
        time = commasplitstatus[-1].split()[0]
        time = ":".join(time.split(":")[0:2])
        timeleft = " ({})".format(time)
    elif state == "Full":
        fulltext += "-"+FA_PLUG + " "
    elif state == "Unknown":
        fulltext += "??"
    else:
        fulltext += FA_LIGHTNING + " " + FA_PLUG + " "
        color="#4CAF50"

    fulltext += ": "+str(percentleft) +"% "
    #fulltext += timeleft

print(fulltext)
print(fulltext)
print(color)