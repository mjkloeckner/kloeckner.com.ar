KEY    = ${HOME}/.ssh/key-mini
DOMAIN = kloeckner.com.ar

all: sync

build:
	./scripts/build.sh
	./scripts/sync.sh

sync: build
	sudo ./scripts/deploy_local.sh

deploy:
	rsync -e "ssh -i $(KEY)" -orahvPt \
		--delete --exclude=.git --exclude=scripts --delete-excluded \
		./ root@$(DOMAIN):/var/www/html/

	ssh -i $(KEY) root@$(DOMAIN) -t 'systemctl restart nginx'

.PHONY: build sync deploy
