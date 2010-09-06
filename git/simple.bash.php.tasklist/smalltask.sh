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

#alles wat met het script meegegeven wordt geld als taak
TODO="$@"

#wel even kijken of de taak niet leeg is
if [ -z "$TODO" ]; then
	echo "Er is geen todo item meegegeven.";
	#en als dat wel zo is stop dan.
	exit 1;
fi

#filteren van de taak op rare tekens
export TODOs="${TODO//[^a-zA-Z0-9 .,]/}"

#kijk of het takenlijstje er is en zoniet maak het dan
#voeg dan de taak eraan toe
#de rest wordt door het cronscript gedaan.
if [ -f ~/todo ]; then
			   echo "$TODOs" >> ~/todo
			   echo "Added task to todo file."
else
			   echo 'Todo file does not exist. Creating it now under ~/todo.'
			   touch ~/todo
			   echo "$TODOs" >> ~/todo
			   echo 'File made an task added.'
fi
