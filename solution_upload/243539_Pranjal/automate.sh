#!/bin/bash
# Author: Pranjal Pratap Singh
# Creation on: 02-06-2024
# Modification date: 02-06-2024
# Description: It will create directory, delete directory, upload files, merge files to hdfs.


num=1
while [ $num -gt 0 ]
do

echo "------------------------------------------------"
echo "                                                "
echo "To create a directory enter 1"
echo "To deleted a directory enter 2"
echo "To delete a file inside a directory 3"
echo "To upload file into directory enter 4"
echo "To merge files inside directory enter 5"
echo "To see file and directory in hdfs enter 6"
echo "To create block of merged file enter 7"
echo "to exist enter 10"
read _choice

case $_choice in
	1)	echo "-------------- CREATE A DIRECTORY --------------"
		echo "Enter directory name: "
		read dirName
		hdfs dfs -mkdir $dirName
	;;
	2)	echo "------------- DELETE A DIRECTORY ---------------"
		echo "Enter directory name: "
		read _dirName
		hdfs dfs -test -d $_dirName
		if [ $? == 0 ]
		then
			echo "directory exists......"
			echo "deleting directory......"
			hdfs dfs -rm -R $_dirName
		else 
			echo "directory does not exists"
		fi
	;;
	3)
		echo "-------- TO DELETE A FILE INSIDE A DIRECTORY-----------"
		echo "enter file name: "
 		read fileName3
		echo "enter directory name from where to delete a file: "
		read dirName3
		hdfs dfs -test -f $dirName3/$fileName3
		if [ $? == 0 ]
		then
			echo "deleting...................."
			hdfs dfs -rm -R $dirName3/$fileName3
		else
			echo "--------File/Directory does not exists"
		fi
	;;
	4)
		echo "----------- TO UPLOAD A FILE -------------"
		echo "Choose a file among the following files: "
		echo "enter file name: "
		read fileName
		echo "enter directory name where to upload: "
		read dirName1
		hdfs dfs -test -d $dirName1
		if [ $? == 0 ]
		 then
			echo "uploading..............."
			hdfs dfs -put /home/cloudera/shared/$fileName ./$dirName1
			echo "File uploaded"
		else
			echo "File/Directory does not exist."
		fi
	;;
	5)
		path="/home/cloudera/hdp/pigandhive/labs/demos"
		echo "-----------------TO SEE NAME,LOCATIONS OF BLOCKS-------------------"
		echo "---------- MERGE FILE --------------"
		echo "Enter directory name : "
		read dir
		echo "Enter name to be given to merged file: "
		read file
		hdfs dfs -getmerge $dir $path/$file.txt
		echo "Path of merged file: " $path/$file.txt 
	;;
	6)
		echo "------------TO SEE FILES/DIRECTORIES IN HDFS---------------"
		hdfs dfs -ls -R
	;;
	7)
		path="/home/cloudera/hdp/pigandhive/labs/demos"
		echo "-----------------CREATE BLOCKS OF MERGED FILE-------------------"
		echo "give name to file which is going to contain block info(do not put .txt): "
		read _file
		echo "enter name of merge file(put .txt): "
		read _file1
		echo "Creating blocks..........................."
		hdfs dfs -D dfs.blocksize=1048576 -put $path/$_file1 $_file.txt

		echo "************************************************************************"
		echo "-----------------TO SEE NUMBER OF BLOCKS----------------------"
		hdfs fsck /user/cloudera/$_file.txt

		echo "************************************************************************"
		echo "-----------------TO SEE NAME,LOCATIONS OF BLOCKS-------------------"
		hdfs fsck /user/cloudera/$_file.txt -files -blocks -locations
	;;
	10)
		num=-1
	;;

esac
done
