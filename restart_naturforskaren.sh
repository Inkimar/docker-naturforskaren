#!/bin/bash
/usr/local/bin/docker-compose -f docker-compose.yml up -d nfdb
sleep 15s
/usr/local/bin/docker-compose -f docker-compose.yml rm -f -s -v naturalist
sleep 5s
/usr/local/bin/docker-compose -f docker-compose.yml up -d naturalist
sleep 15s

# cp from wildfly-dir if not available in ...
cp /home/s-research/repos/naturforskaren/docker/wildfly-custom/customization/naturalist.war /home/s-research/repos/naturforskaren/artifact/naturalist.war
# copy the artifact to the docker-container
/usr/bin/docker cp /home/s-research/repos/naturforskaren/artifact/naturalist.war naturalist:/tmp
# deploy the artifact to jboss/wildfly
/usr/bin/docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='deploy /tmp/naturalist.war --force'"
