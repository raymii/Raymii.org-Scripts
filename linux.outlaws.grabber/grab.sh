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
declare -i START
declare -i END
#minimun start is 17
START=17;
#last podcast you want
END=150;
DLURL="http://linuxoutlaws.com/podcast"
if [ ! -f .links ]; then
 touch .links
fi
if [ ! -d ./podcasts ]; then
        mkdir ./podcasts
fi
#OK, lets start:
for i in $(seq $START $END); do
 echo "Getting Linux Outlaws podcast $DLURL/$i "
 curl --silent "$DLURL/$i/" > .page.$i  && grep -o http://[^[:space:]]*.mp3 .page.$i > .links.$i &
done
wait
for j in $(seq $START $END); do
 FILENAAM=".links.$j";
 sed -i 's/\">mp3//g' $FILENAAM
 sed -i 's/http\:\/\/feeds.feedburner.com\/linuxoutlaws//g' $FILENAAM
 sed -i '/^$/d' $FILENAAM
 cat $FILENAAM
 cat $FILENAAM >> ./urls
 wget --random-wait -c -i $FILENAAM -O ./podcasts/Linux.Outlaws.$j.mp3 &
done
wait
exit 0
