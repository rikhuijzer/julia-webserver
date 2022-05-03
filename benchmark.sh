#!/usr/bin/env sh

# Credits for this script go to Tomas Fagerbekk
# https://notes.webutvikling.org/quick-http-benchmarking-with-curl/

# Note that this script doesn't run the requests concurrently.

iterations=$1
url=$2
echo "Running $iterations iterations for curl $url"
totaltime=0.0
for run in $(seq 1 $iterations)
do
 time=$(curl $url -s -o /dev/null -w "%{time_starttransfer}\n")
 totaltime=$(echo "$totaltime" + "$time" | bc)
done
avgtimeMs=$(echo "scale=4; 1000*$totaltime/$iterations" | bc)
echo "Averaged $avgtimeMs ms in $iterations iterations"
