deploy:
	@docker-compose -f docker-compose.all.yml up -d nfdb
	@docker-compose -f docker-compose.all.yml up -d naturalist
	docker exec -it naturalist bash
	#deploy the naturalist.war-file 

up-database:
	@docker-compose -f docker-compose.all.yml up -d nfdb

up-naturalist:
	@docker-compose -f docker-compose.all.yml up -d naturalist

ps-all : 
	docker-compose -f docker-compose.all.yml ps

logs-all:
	docker-compose -f docker-compose.all.yml logs -f	

logs-naturalist:
	docker-compose -f docker-compose.all.yml logs -f naturalist

logs-database:
	docker-compose -f docker-compose.all.yml logs -f nfdb 

down-all : 
	docker-compose -f docker-compose.all.yml down


# deploy jar
login-naturalist:
	docker exec -it naturalist bash

copy-war-naturalist:
	docker cp naturalist.war naturalist:/tmp

startup:
	xdg-open http://naturforskaren.dina-web.net/naturalist/



naturalist-down:
	docker-compose -f docker-compose.all.yml rm -f -s -v naturalist

naturalist-copy:
	docker cp /home/dina/repos/artifact/naturalist.war naturalist:/tmp

naturalist-ls:
	docker exec  naturalist sh -c "ls /tmp"

naturalist-check-deployments:
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='ls deployment'"

naturalist-undeploy:
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='undeploy naturalist.war'"

naturalist-deploy:
	docker cp /home/dina/repos/artifact/naturalist.war naturalist:/tmp
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='deploy /tmp/naturalist.war'"
