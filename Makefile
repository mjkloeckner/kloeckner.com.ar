KEY       = ${HOME}/.ssh/key-mini
DOMAIN    = kloeckner.com.ar
ROOT_PATH = $(CURDIR)

all: sync

build:
	./scripts/build.sh ${ROOT_PATH}
	./scripts/sync.sh ${ROOT_PATH}

sync: build
	sudo ./scripts/deploy_local.sh ${ROOT_PATH}

deploy:
	rsync -e "ssh -i $(KEY)" -rhvPt \
		--delete --exclude=.git --exclude=${ROOT_PATH}/scripts \
		--delete-excluded ./ root@$(DOMAIN):/var/www/html/
	rsync -e "ssh -i $(KEY)" -rhvPt --exclude=index.html\
		./git/ root@$(DOMAIN):/var/www/git/
	ssh -i $(KEY) root@$(DOMAIN) -t 'systemctl restart nginx'

.PHONY: build sync deploy
