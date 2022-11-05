#!/bin/bash

docker-compose stop oracle
docker-compose rm oracle
docker-compose up -d
docker-compose logs -f oracle


