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


#####################################
## Raymii.org Thumbr script        ##
## Version 0.2. Just bugfixes...   ##
#####################################

NUMMR=1

EXTENSION="jpg";
mkdir work
mkdir -p finished/pics

GALL=./finished/gallery.html
rm -rf $GALL
echo "Made with raymii.orgs gallery thumber" > $GALL
tabhead=" <table border=\"0\" bordercolor=\"0\" >"
tabfeet=" </table >"
echo $tabhead >> $GALL


for i in *.$EXTENSION;
do cp -rf -v "$i" "./work/$NUMMR.$EXTENSION";

convert ./work/$NUMMR.$EXTENSION -auto-orient \
 -thumbnail 160x160 -unsharp 0x.5 ./work/$NUMMR.w1.png


convert ./work/$NUMMR.w1.png \
 -bordercolor white -border 6 \
 -bordercolor grey60 -border 1 \
 -bordercolor none -background none \
 \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
 \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
 \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
 \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
 -delete 0 -border 100x100 -gravity center \
 -crop 200x200+0+0 +repage -flatten -trim +repage \
 -background black \( +clone -shadow 60x4+4+4 \) +swap \
 -background none -flatten \
 "./work/$NUMMR.thumb.png"




cp ./work/$NUMMR.thumb.png ./finished/pics/$NUMMR.png

evenline=" <tr > <td > <a href=\"\"><img src=\"pics/$NUMMR.png\" alt=\" pic $NUMMR - made by raymii.org script\" / > </a></td >"
oddline=" <td > <a href=\"\"><img src=\"pics/$NUMMR.png\" alt=\" pic $NUMMR - made by raymii.org script\" / > </td > </a></tr >"

 slot=$(( $NUMMR % 2 ))
if [ $slot -eq 0 ]
then
 echo $oddline >> $GALL
else
 echo $evenline >> $GALL
fi
let "NUMMR += 1"
done

echo $tabfeet >> $GALL
rm -rf ./work
exit 0
