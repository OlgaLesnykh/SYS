#!/bin/bash
echo "Enter the first number A:"
read a
echo "Enter the second number B:"
read b
if [[ $a -gt $b ]]; then
	echo "A - B = $((a-b))";
elif [[ $a -eq $b ]]; then
	echo "A^B = $((a**a))";
else
	echo "B - A = $((b-a))";
fi;
