#!/bin/bash
### Copyright (c) 2010 Remy van Elst
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.
dhclient
clear
echo "################################"
echo "# Daniel Imager for Erasmus MC #"
echo "#      By Raymii & David       #"
echo "#     Based on Clonezilla      #"
echo "#       Made on 01-04-10       #"
echo "################################"
echo
echo
echo "Mounting the image share. If asked for a password, enter 1234"
echo
mount -t cifs -o username="administrator",password="emcdaniel" //192.168.1.2/image /home/partimag
#clear
cd /home/partimag
echo "We zitten in map:"
pwd
echo ;
DIRS="$(ls -d */ | grep '\<schoon[0-9][0-9]*\>')"
GROOTSTE_GETAL=0
# Met alle directories gaan we een voor een aan de slag
for DIR in $DIRS;
do
  # Stop de naam van de directory in RUWE_STRING
  RUWE_STRING=$DIR
  # Haal de slash aan het eind van RUWE_STRING af
  RUWE_STRING=${RUWE_STRING%\/}
  # Haal aan het begin van RUWE_STRING "schoon" af. We houden nu het GEZOCHTE_GETAL over
  GEZOCHTE_GETAL=${RUWE_STRING#schoon}
  # De volgende twee commando's zorgen er voor dat als GEZOCHTE_GETAL geen getal is
  # deze de waarde 0 krijgt
  let GEZOCHTE_GETAL++
  let GEZOCHTE_GETAL--
  # Als GEZOCHTE_GETAL ongelijk is aan 0 dan gaan we er mee aan de gang
  if (( $GEZOCHTE_GETAL > 0 ))
  then
    # Als GEZOCHTE_GETAL groter is dan GROOTSTE_GETAL
    # dan wordt GROOTSTE_GETAL gelijk gemaakt aan GEZOCHTE_GETAL
    if (( $GEZOCHTE_GETAL > $GROOTSTE_GETAL ))
    then
      GROOTSTE_GETAL=$GEZOCHTE_GETAL
    fi
  fi
done

# Als GROOTSTE_GETAL groter is dan nul is er een schone backup aanwezig en
# kunnen we met de restore beginnen. Zo niet dan geven we de error terug
if (( $GROOTSTE_GETAL > 0 ))
then
  echo "Start met restore van schoon$GROOTSTE_GETAL"
  NAME="schoon$GROOTSTE_GETAL"
  /opt/drbl/sbin/ocs-sr -g auto -e1  auto -e2 -j2 -p true restoredisk "$NAME" "sda"
else
  echo "Er is geen schone restore aanwezig."
  echo "Controleer of de server aanstaat en of de share aanwezig is. Maak anders een nieuw image."
  echo "Selecteer dadelijk de optie Start Over."
fi
