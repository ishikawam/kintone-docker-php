# meore

# mac: homebrew, git, docker, php 7.1

NAME=kintone-docker-php

setup:
	brew install git jq awscli amazon-ecs-cli

install:
	git submodule update --init
	npm install
	npm run dev
	make up
	docker exec -it $(NAME)_php_1 sh -c "php composer.phar install"
	docker exec -it $(NAME)_php_1 sh -c "php artisan clear-compiled"

migrate:
	docker exec -it $(NAME)_php_1 sh -c "php artisan migrate"

migrate-rollback:
	docker exec -it $(NAME)_php_1 sh -c "php artisan migrate:rollback"

seed:
	docker exec -it $(NAME)_php_1 sh -c "php artisan migrate:refresh --seed"

up:
	docker-compose -p $(NAME) up -d --build

down:
	docker-compose -p $(NAME) down

logs:
	docker-compose -p $(NAME) logs -f

log:
	tail -f ./storage/logs/*

start:
	docker-compose -p $(NAME) start

stop:
	docker-compose -p $(NAME) stop

restart:
	docker-compose -p $(NAME) restart

open:
	open http://localhost:10082

ssh:
	docker exec -it $(NAME)_php_1 sh


ssh-web:
	docker exec -it $(NAME)_web_1 sh

ssh-firefox:
	docker exec -it $(NAME)_firefox_1 bash


clear:
	docker exec -it $(NAME)_php_1 sh -c "php composer.phar dump-autoload --optimize"
	docker exec -it $(NAME)_php_1 sh -c "php artisan clear-compiled ; php artisan config:clear"
