#!bin/bash
echo "Enter file name with filename extension"
read file_name
case $file_name in *.jpg | *.gif | *.png)
	echo image
;;
*.mp3 | *.wav)
	echo audio
;;
*.txt | *.doc)
	echo text
;;
*)
	echo unknow
;;
esac
