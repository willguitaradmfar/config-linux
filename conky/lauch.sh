#!/bin/bash
sleep 5
killall conky 
cd
sleep 2
conky -d -c .conkyrc1;
sleep 2
conky -d -c .conkyrc2;
sleep 2
conky -d -c .conkyrc3;
exit
