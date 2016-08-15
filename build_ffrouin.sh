#!/bin/bash

# Ubuntu 14.04 phusion/baseimage english branch
cd baseimage-0.9.19-14.04 && make build NAME=baseimage-14.04 && cd ../
docker build -t ffrouin:system-14.04 system-14.04
docker build -t ffrouin:lamp-14.04 lamp-14.04
docker build -t ffrouin:wordpress-14.04 wordpress-14.04

docker build -t ffrouin:system-16.04 system-16.04
docker build -t ffrouin:lamp-16.04 lamp-16.04
