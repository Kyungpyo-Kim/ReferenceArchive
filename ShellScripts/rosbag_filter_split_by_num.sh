#!/bin/bash
# provide input bag, output bags prefix, and num of fraction
echo $1, $2, $3

t0=`rosbag info -y -k start $1`
t1=`rosbag info -y -k end $1`

echo $t0
echo $t1

for i in $(seq 1 $3)
do

tfr0=`echo "$t0 + ($i-1) * ($t1 - $t0) / $3" | bc -l`
tfr1=`echo "$t0 + $i * ($t1 - $t0) / $3" | bc -l`
echo $tfr0
echo $tfr1
rosbag filter $1 $2_$i.bag "t.secs > $tfr0 and t.secs <= $tfr1"

done # end for i in $(seq 1 $3)
