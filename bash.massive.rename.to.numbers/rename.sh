#!/bin/bash
RAYMIIWALL=1

#convert everything to lowercase - you need the rename command.
rename 'y/A-Z/a-z/' *

#Do the magic
for i in {*.jpg,*.jpeg};
do mv -f -v "$i" "$RAYMIIWALL.jpg";
let "RAYMIIWALL += 1"
done
exit 0
