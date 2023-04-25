#!/bin/bash
docker-compose up -d nfdb
sleep 15s
docker-compose rm -f -s -v naturalist
sleep 5s
docker-compose up -d naturalist
sleep 15s

# cp from wildfly-dir if not available in ...
#cp /home/s-research/repos/naturforskaren/docker/wildfly-custom/customization/naturalist.war /home/s-research/repos/naturforskaren/artifact/naturalist.war


# copy the artifact to the docker-container
docker cp artifact/naturalist.war naturalist:/tmp

# deploy the artifact to jboss/wildfly
docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='deploy /tmp/naturalist.war --force'"

