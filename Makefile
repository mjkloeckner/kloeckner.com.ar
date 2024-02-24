KEY       = ${HOME}/.ssh/key-x441
DOMAIN    = kloeckner.com.ar
ROOT_PATH = $(CURDIR)

all: sync

build:
	./scripts/build.sh ${ROOT_PATH}
	./scripts/sync.sh ${ROOT_PATH}

sync: build
	sudo ./scripts/deploy_local.sh ${ROOT_PATH}

force-sync:
	./scripts/build.sh ${ROOT_PATH}
	./scripts/sync.sh --force-update ${ROOT_PATH}
	sudo ./scripts/deploy_local.sh ${ROOT_PATH}

deploy:
	rsync -e "ssh -i $(KEY)" -rahvPt --delete \ --exclude=.git \
		--exclude=${ROOT_PATH}/scripts --exclude=${ROOT_PATH}/style/git.css \
		--delete-excluded ./ root@$(DOMAIN):/var/www/html/
	rsync -e "ssh -i $(KEY)" -rahvPt \
		./style/git.css root@$(DOMAIN):/var/www/git/
	ssh -i $(KEY) root@$(DOMAIN) -t 'systemctl restart nginx'

.PHONY: build sync force-sync deploy
