#!/bin/bash

# Ubuntu 14.04 phusion/baseimage - English
cd baseimage-0.9.19-14.04 && make build NAME=baseimage-14.04 && cd ../
docker build -t ffrouin:system-14.04 system-14.04
docker build -t ffrouin:lamp-14.04 lamp-14.04
docker build -t ffrouin:wordpress-14.04 wordpress-14.04
docker build -t ffrouin:desktop-14.04 desktop-14.04
docker build -t ffrouin:desktop-14.04-fr desktop-14.04-fr

# Ubuntu 16.04 phusion/baseimage - English
docker build -t ffrouin:system-16.04 system-16.04
docker build -t ffrouin:lamp-16.04 lamp-16.04
docker build -t ffrouin:wordpress-16.04 wordpress-16.04
docker build -t ffrouin:desktop-16.04 desktop-16.04
docker build -t ffrouin:desktop-16.04-fr desktop-16.04-fr
