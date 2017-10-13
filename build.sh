#!/bin/bash
docker stop logdemon && docker rm logdemon
docker build --no-cache -t automox/logdemon:latest -f Dockerfile .
docker run -d --name logdemon automox/logdemon:latest

