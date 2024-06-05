#!/bin/bash

# Author: Chitresh Chopkar
# Created on : June 2 2024
# Desc: It will list all the files in current directory user have to specify the file with extension
# Features: It can upload to home directory or create another directory as per user requirement 


ls -l
read -p "Which file ?" file
filedirec=~/hdp/pigandhive/labs/demos
if [ -e $filedirec/$file ]
then
rm $filedirec/$file
cp ./${file} $filedirec/
else
cp ./${file} $filedirec/
fi
cd $filedirec/
echo "Enter the name of the directory you want to upload the file into"
read -p "(Type home for uploading to /user/cloudera): " direc
if [ "${direc}" == "home" ]
then
#tardirec=/user/cloudera/
if hdfs dfs -test -e ${file}
then
echo "File already exists deleting the file !!"
hdfs dfs -rm ${file}
echo "Uploading new file !!"
hdfs dfs -put ${file}
if hdfs dfs -test -e ${file}
then
echo "File uploaded successfully !"
fi
else
hdfs dfs -put ${file}
if hdfs dfs -test -e ${file}
then
echo "File uploaded successfully !!"
hdfs dfs -ls
fi
fi
else
tardirec=/user/cloudera/$direc
if hdfs dfs -test -d $tardirec
then
read -p "Directory exists delete the directory ? !!(y/n) " choice
if [ "${choice}" == "y" ]
then
hdfs dfs -rm -r $direc
hdfs dfs -mkdir $direc
echo "Uploading the file !!"
hdfs dfs -put ${file} $tardirec
if hdfs dfs -test -e $direc/$file
then
echo "file uploaded succesfully !!"
hdfs dfs -ls -h $direc
fi
else
if hdfs dfs -test -e $tardirec/${file}
then
echo "File already exists deleting the file !!"
hdfs dfs -rm $tardirec/${file}
hdfs dfs -put ${file} $tardirec
if hdfs dfs -test -e $tardirec/${file}
then
echo "File uploaded successfully"
hdfs dfs -ls -h $direc
fi
fi
fi
else
hdfs dfs -mkdir $direc
hdfs dfs -put ${file} $tardirec
if hdfs dfs -test -e $tardirec/${file}
then
echo "File uploaded successfully"
hdfs dfs -ls -h $direc
fi
fi
fi
