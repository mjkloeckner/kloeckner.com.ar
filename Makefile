build:
	./scripts/build.sh
	./scripts/sync.sh

sync: build
	sudo ./scripts/deploy_local.sh

deploy:
	rsync -e "ssh -i ~/.ssh/key-mini" -uorahvP --delete ./** root@kloeckner.com.ar:/var/www/html/

.PHONY: build sync deploy
