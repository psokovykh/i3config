#!/bin/sh

##You have to create such files, or choose another way of setting that $USER and $PASS variables
namefile="/home/dokel/.emailconfig/login"
passfile="/home/dokel/.emailconfig/password"

USER=$(cat "$namefile")
PASS=$(cat "$passfile")

COUNT=`curl -su $USER:$PASS https://mail.google.com/mail/feed/atom || echo "<fullcount>err</fullcount>"`
COUNT=`echo "$COUNT" | grep -oPm1 "(?<=<fullcount>)[^<]+" `

if [ "$COUNT" != "err" ]; then
	if [ "$COUNT" != "0" ]; then
		echo $COUNT
		echo $COUNT
		echo "#64FFDA"
	fi

	case $BLOCK_BUTTON in
	  1) xdg-open "http://gmail.com" ;;
	esac
else
	echo "err"
	echo "err"
	echo "#FF5722"
fi
