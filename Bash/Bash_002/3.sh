#!/bin/bash
dir=$1
avgfile () {
	if [ ! -d $dir ]; then
		echo "The $dir directory does not exist";
	else
		for file in $( ls -a  $dir ); do
			if [ -f $file ]; then
				file_size=`stat -c %s $file`
				sum_file_size=$((sum_file_size+file_size))
				count_file=1
				sum_count_file=$((sum_count_file+count_file))
			fi;
		done
		avg_file_size=$(bc<<<"scale=2;$sum_file_size/$sum_count_file")
	echo "Average file size $avg_file_size bytes"
	fi;
}
avgfile $dir
