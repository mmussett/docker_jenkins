#! /bin/bash -e
docker-compose up -d

exec docker logs puppet_jenkins 2>&1 | grep -A 2 "\Please use the following password to proceed to installation:"