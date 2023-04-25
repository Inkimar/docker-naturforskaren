up:
	@docker-compose  up -d

up-database:
	@docker-compose up -d nfdb

up-naturalist:
	@docker-compose  up -d naturalist

ps: 
	docker-compose  ps

logs-all:
	docker-compose logs -f	

logs-naturalist:
	docker-compose logs -f naturalist

logs-database:
	docker-compose  logs -f nfdb 

down: 
	docker-compose  down

naturalist-down:
	docker-compose rm -f -s -v naturalist

check-deployments:
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='ls deployment'"

naturalist-undeploy:
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='undeploy naturalist.war'"

naturalist-deploy:
	docker cp ./artifact/naturalist.war naturalist:/tmp
	docker exec  naturalist sh -c "exec bin/jboss-cli.sh --connect --command='deploy /tmp/naturalist.war'"

naturalist-contextRoot:
	docker exec naturalist sh -c "exec bin/jboss-cli.sh --connect --command='/subsystem=undertow/server=default-server/host=default-host:write-attribute(name=default-web-module,value=naturalist.war)'"
	docker exec naturalist sh -c "exec bin/jboss-cli.sh --connect --command=':reload'"
