#!/bin/bash
rm file_*.txt
for ((i=0; i<4; i++)); do
   touch file_$i.txt
done
