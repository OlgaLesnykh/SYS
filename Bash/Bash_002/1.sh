#!/bin/bash
a=1
for (( a=1; a <= 100; a++ ))
do
b=$a%3
if [[ $b -eq 0 ]]; then
	echo $a
fi;
done;
