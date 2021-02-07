#!/bin/bash

IP=$(wget http://ipinfo.io/ip -qO -)

if [[ "$IP" != "" ]]; then
	echo -e "$IP"
	echo -e "$IP"
	echo -e "#4CAF50"
else
	echo -e "down"
	echo -e "down"
	echo -e "#FF5722"
fi
