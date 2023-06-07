#!/bin/bash
#set -x
app=$(cat .config | grep appname | cut -d "=" -f2)
ports=$(cat .config | grep ports | cut -d "=" -f2)
docker stop $(docker ps | grep $app | awk '{print $1}')

docker rm --force $app

docker build -t $app .

#docker run -p 80:80 -d python-api-rest 
docker run -p $ports $app