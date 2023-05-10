.DEFAULT_GOAL := help
COMPOSE_CMD=docker-compose
COMPOSE_FILE="./docker-compose.yml"

up: ## Start all microservices
	${COMPOSE_CMD} -f ${COMPOSE_FILE} up -d

build: ## Build all microservices
	${COMPOSE_CMD} -f ${COMPOSE_FILE} build

down: ## Shutdown all microservices
	${COMPOSE_CMD} -f ${COMPOSE_FILE} down

kill: ## Kill all microservices
	${COMPOSE_CMD} -f ${COMPOSE_FILE} kill

rm: ## Remove all microservices
	${COMPOSE_CMD} -f ${COMPOSE_FILE} rm

copy-site-packages: ## Copy site-packages, node_modules to project root for better IDE support
	${COMPOSE_CMD} cp api:app/node_modules/ ./

tests: ## Run tests
	${COMPOSE_CMD} exec api npm run test
	${COMPOSE_CMD} exec api npm run test:e2e
	

help: ## Show this help
	@echo ''
	@echo '--------------------------------------------------------------------------------------------------------'
	@echo 'Available commands to manage docker services during development'
	@echo '--------------------------------------------------------------------------------------------------------'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

