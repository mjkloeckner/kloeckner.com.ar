KEY       = ${HOME}/.ssh/key-x441
DOMAIN    = kloeckner.com.ar
ROOT_PATH = $(CURDIR)

all: sync

minify-css:
	./scripts/css-minificator.py

build:
	./scripts/build.sh ${ROOT_PATH}
	./scripts/sync.sh ${ROOT_PATH}

sync: build minify-css
	sudo ./scripts/deploy_local.sh ${ROOT_PATH}

force-sync:
	./scripts/build.sh ${ROOT_PATH}
	./scripts/sync.sh --force-update ${ROOT_PATH}
	sudo ./scripts/deploy_local.sh ${ROOT_PATH}

deploy: minify-css
	rsync -e "ssh -i $(KEY)" -rahvPt --delete --delete-excluded \
		--exclude=.git \
		--exclude=./scripts/^js \
		--exclude=./style/git.css \
		--exclude=./common/logo.webp \
		--exclude=Makefile \
		./ root@$(DOMAIN):/var/www/html/
	rsync -e "ssh -i $(KEY)" -rahvPt --delete --delete-excluded \
		--exclude=.git \
		./css/git.css root@$(DOMAIN):/var/www/git/style.css
	rsync -e "ssh -i $(KEY)" -rahvPt --delete --delete-excluded \
		--exclude=.git \
		./common/logo.webp root@$(DOMAIN):/var/www/git/logo.png
	rsync -e "ssh -i $(KEY)" -rahvPt --delete --delete-excluded \
		--exclude=.git \
		./favicon.png root@$(DOMAIN):/var/www/git/favicon.png

	ssh -i $(KEY) root@$(DOMAIN) -t 'systemctl restart nginx'

.PHONY: build sync force-sync deploy
