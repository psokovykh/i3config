#!/bin/sh

USER=
PASS=

COUNT=`curl -su $USER:$PASS https://mail.google.com/mail/feed/atom || echo "<fullcount>unknown number of</fullcount>"`
COUNT=`echo "$COUNT" | grep -oPm1 "(?<=<fullcount>)[^<]+" `


if [ "$COUNT" != "0" ]; then
	echo $COUNT
	echo $COUNT
	echo "#64FFDA"
fi

case $BLOCK_BUTTON in
  1) xdg-open "http://gmail.com" ;;
esac
