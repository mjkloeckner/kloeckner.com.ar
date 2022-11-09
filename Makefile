all: sync

build:
	./scripts/build.sh
	./scripts/sync.sh

sync: build
	sudo ./scripts/deploy_local.sh

deploy:
	rsync -e "ssh -i ~/.ssh/key-x441" -orahvPt --delete --exclude=.git --delete-excluded . root@192.168.1.72:/var/www/html

.PHONY: build sync deploy
