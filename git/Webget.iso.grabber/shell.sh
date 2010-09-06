#!/bin/bash
DE_ISO=`cat /var/tmp/iso_addr`
ISO_DIR="/.iso"
cd $ISO_DIR
wget -c -t 0 --timeout=60 --waitretry=60 $DE_ISO &
