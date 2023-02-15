#!/bin/bash
echo "Enter the full path from the directory:"
read dir
if [ -d $dir ]; then
	echo "The $dir directory already exists";
else
	mkdir -p $dir; echo "The $dir directory created successfully";
fi;
