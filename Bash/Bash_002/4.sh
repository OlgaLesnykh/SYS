#!/bin/bash
Regular="^[+-]?[0-9]+$"
select operation in "a+b" "a-b" "a*b" "a/b"; do
	echo "Enter value a"
	read a
	echo "Enter value b"
	read b	
 	if [[ ! $a =~ $Regular ]] && [[ ! $b =~ $Regular ]]; then
	echo "Error! The entered value is not a number"
	else	
	case $operation in
		"a+b")
			c1=$((a+b))
			echo "a + b = $c1"
			;;
		"a-b")
			c2=$((a-b))
			echo "a - b = $c2"
			;;
		"a*b")
			c3=$((a*b))
			echo "a * b = $c3"
			;;
		"a/b")
			if [[ $b = 0 ]]; then
				echo "Error! Can't divide by 0"
			else
			c4=$(bc<<<"scale=2;$a/$b")
			echo "a / b = $c4"
			fi
			;;
		*)
			echo "Invalid operation"
			;;
	esac
	fi;
done
