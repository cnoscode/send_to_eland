#!/bin/bash

for file in /Users/cjose/Desktop/fastq1/*   
do    
  echo "Unzipping ${file}..."
  gunzip $file
done
