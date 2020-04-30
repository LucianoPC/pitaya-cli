## Build docker project
docker-build:
	@docker-compose build

## Build docker production project
docker-prod-build:
	@docker build . -f Dockerfile.prod -t pitaya-cli-prod:latest

## Run pitaya-cli on docker
docker-run:
	@docker-compose run --service-ports --rm pitaya-cli

## Enter on bash of docke project
docker-bash:
	@docker-compose run --service-ports --rm pitaya-cli bash

## Build app project
app-build:
	@mkdir -p out
	@go build -o ./out/pitaya-cli-darwin ./...

## Build app project for linux
app-build-linux:
	@mkdir -p out
	@GOOS=linux GOARCH=amd64 go build -o ./out/pitaya-cli-linux ./main.go

.DEFAULT_GOAL := show-help

.PHONY: show-help
show-help:
	@echo "$$(tput bold)Commands:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}'


