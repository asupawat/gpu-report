#!/bin/bash
while true
do
nvidia-smi --query-gpu=count --format=csv,noheader > gpu_report.txt
gpu_count=$(head -n 1 gpu_report.txt)
gpu_count=$((gpu_count-1))
data="RIG2"$'\n'
for((id=0;id<=$gpu_count;id++))
do
data+=$(nvidia-smi -i $id --query-gpu=index,name,temperature.gpu,fan.speed,clocks.gr,power.draw --format=csv,noheader)$'\n\n'
done
curl -X POST -d "$data" https://qwave.easyio.tech/gpu/gpu_report.php
sleep 60
done
