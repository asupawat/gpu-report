#!/bin/bash
while true
do
nvidia-smi --query-gpu=count --format=csv,noheader > GPU.txt
gpu_count=$(head -n 1 GPU.txt)
gpu_count=$((gpu_count-1))
data="message=RIG2"$'\n'
for((id=0;id<=$gpu_count;id++))
do
data+=$(nvidia-smi -i $id --query-gpu=index,name,temperature.gpu,fan.speed,clocks.gr,clocks.mem,power.draw --format=csv,noheader)$'\n\n'
done
curl -X POST -H "Authorization: Bearer 8e4ntMJHzJBmZdJtvB35Uyfb4BhuNzvx0zEr9ggWEqy" -F "$data" https://notify-api.line.me/api/notify
sleep 3600
done
