Pipfile.lock: Pipfile
	docker-compose build --build-arg RUN_PIPENV_LOCK=true

build:
	docker compose build

.PHONY:shell
shell: build ## Brings up the bash shell in dev docker
	docker-compose --progress=plain run --rm --name protein_predictor_shell dev /bin/sh
