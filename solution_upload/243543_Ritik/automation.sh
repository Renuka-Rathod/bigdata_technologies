#!/bin/bash

# Author: Ritik Sharma
# Created on: 04-06-2024
# Modification date: 04-06-2024
# Description: It creates directory, delete directory, merge files to hdfs.

# Default HDFS path
hdfs_path="/user/cloudera/"


if [ -n "$1" ]; then
    hdfs_path+="$1"
fi


echo "Displaying all directories in HDFS (default path: /user/cloudera)"
hdfs dfs -ls "$hdfs_path"
echo " "


if [ -n "$2" ]; then
    if hdfs dfs -test -e "$2"; then
        echo "Directory already exists"
    else
        hdfs dfs -mkdir -p "$2"
        echo "Directory created at $2"
    fi
else
    hdfs dfs -mkdir -p test/test1/test2
    echo "Default directory created: test/test1/test2"
fi
echo " "


if [ -n "$3" ]; then
    if hdfs dfs -test -e "$3"; then
        hdfs dfs -rm -R "$3"
        echo "Directory removed"
    else
        echo "Directory doesn't exist"
    fi
else
    hdfs dfs -rm -R test/test1
    echo "Default directory removed: test/test1"
fi
echo " "


if [ -n "$4" ] && [ -n "$5" ]; then
    hdfs dfs -put "$4" "$5"
else
    echo "Default file added"
    hdfs dfs -put /home/cloudera/shared/small_blocks.txt test/
fi
echo " "


if [ -n "$6" ]; then
    hdfs dfs -getmerge "$6" /tmp/merged.txt
    echo "Input folder merged"
else
    hdfs dfs -getmerge test /tmp/merged.txt
    echo "Default folder merged: test"
fi
echo " "
