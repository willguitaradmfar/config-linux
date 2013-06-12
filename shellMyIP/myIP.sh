#!/bin/bash

which curl || sudo apt-get install curl

which mailx || sudo  apt-get install mailutils 

IP="`curl -s http://icanhazip.com 2>&1 | cat`"

SUBJECT="Your IP is:"
echo $IP | mailx -s "$SUBJECT" willguitaradmfar@gmail.com
