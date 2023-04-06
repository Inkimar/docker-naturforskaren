deploy:
	@docker-compose -f docker-compose.yml up -d nfdb
	@docker-compose -f docker-compose.yml up -d naturalist
	docker exec -it naturalist bash

up:
	@docker-compose -f docker-compose.yml up -d

up-database:
	@docker-compose -f docker-compose.yml up -d nfdb

up-naturalist:
	@docker-compose -f docker-compose.yml up -d naturalist

ps: 
	docker-compose -f docker-compose.yml ps

logs-all:
	docker-compose -f docker-compose.yml logs -f	

logs-naturalist:
	docker-compose -f docker-compose.yml logs -f naturalist

logs-database:
	docker-compose -f docker-compose.yml logs -f nfdb 

down: 
	docker-compose -f docker-compose.yml down

naturalist-down:
	docker-compose -f docker-compose.all.yml rm -f -s -v naturalist

naturalist-check-deployments:
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='ls deployment'"

naturalist-undeploy:
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='undeploy naturalist.war'"

naturalist-deploy:
	docker cp /home/s-research/repos/naturforskaren/docker/wildfly-custom/customization/naturalist.war naturalist:/tmp
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='deploy /tmp/naturalist.war'"
