.PHONY: help build run test

help:
	@echo "Commands:"
	@echo "  build: Build the Docker image"
	@echo "  run: Run the Docker container"
	@echo "  test: Run the tests"

build:
	docker-compose build

run:
	docker-compose up

test:
	docker-compose run app pytest
