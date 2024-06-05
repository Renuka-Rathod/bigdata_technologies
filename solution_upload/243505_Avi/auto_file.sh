#!/bin/bash
# Author: Avi Bansal
# Creation_Date: 02-06-2024
# Modification_Date: 03-06-2024
# Description: Basic Hdfs commands
#Usage: auto_file.sh <HDFS path> <Directory Name(Created) > <Directory Name(Delete)> <File to be Uploaded><Destination><Folder to be merge> 
# $1->Hdfs path
hdfs_path="/user/cloudera/"
if [ $1 ]
then
hdfs_path+=$1
fi
echo "Display All the Directory in HDFS(Default Path /user/cloudera)"
hdfs dfs -ls $hdfs_path

echo "------------------------------------------------------------"
#$2->directory to be created
if [ $2 ]
then
if hdfs dfs -test -e $2 
then
echo "Directory already exist"
else
hdfs dfs -mkdir -p $2
echo "Directory created at $2"
fi
else
hdfs dfs -mkdir -p test/test1/test2
echo "Default directory created:- test/test1/test2"
fi
echo "---------------------------------------------------------------"

#$3-> Directory to be deleted 
if [ $3 ]
then
if hdfs dfs -test -e $3
then
hdfs dfs -rm -R $3
echo "Directory Removed"
else
echo "Directory doesn't exist"
fi
else
hdfs dfs -rm -R test/test1
echo "Default Directory Removed"
fi
echo "-----------------------------------------------------------------"

#4->File to be uploaded 5->Destination
if [ -n "$4" ] && [ -n "$5" ] #-n Check if string length is non -zero
then
hdfs dfs -put $4 $5
else
echo "Default File Added"
hdfs dfs -put /home/cloudera/shared/small_blocks.txt test/
fi 
echo "------------------------------------------------------------------"

#6->Folder to be merged
if [ $6 ]
then
hdfs dfs -getmerge $6 /tmp/merged.txt
echo "Input Folder Merged"
else
hdfs dfs -getmerge test /tmp/merged.txt
echo "Default Folder Merged"
fi
echo "----------------------------------------------------------------"