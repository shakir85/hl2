#!/bin/bash

echo "Start testing..."

python3 yaml_parser.py

sleep 3

declare -a arr
IFS=$'\n' read -d '' -r -a arr < ./ports

for PORT in "${arr[@]}"
do
   STATUS_CODE=$(curl -sI http://127.0.0.1:"$PORT" | head -n 1 | cut -d$' ' -f2)
   if [ "$STATUS_CODE" != "200" ]; then
     echo "Port $PORT returned $STATUS_CODE , aborting..."
     exit 1
   else
     echo "Service is active, status code: $STATUS_CODE"
   fi
done

#STATUS_CODE=$(curl -sI http://127.0.0.1:$PORT | head -n 1 | cut -d$' ' -f2)

# if STATUS_CODE == 200  ||  STATUS_CODE = '' : proceed