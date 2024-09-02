build:
	docker compose build

.PHONY:shell
shell: ## Brings up the bash shell in dev docker
	docker-compose --progress=plain run --rm --name protein_predictor_shell dev /bin/sh
