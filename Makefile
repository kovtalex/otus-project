USERNAME=kovtalex
APP_TAG=logging

# Деплоим всё
deploy: deploy_app deploy_mon

# Деплоим приложение
deploy_app:
	cd docker && docker-compose up -d

# Деплоим мониторинг
deploy_mon:
	cd docker && docker-compose -f docker-compose-monitoring.yml up -d

# Деплоим логирование
deploy_log:
	cd docker && docker-compose -f docker-compose-logging.yml up -d

# Останавливаем всё
stop: stop_app stop_mon

# Останавливаем приложение
stop_app:
	cd docker && docker-compose down

# Останавливаем мониторинг
stop_mon:
	cd docker && docker-compose -f docker-compose-monitoring.yml down

# Останавливаем логирование
stop_log:
	cd docker && docker-compose -f docker-compose-logging.yml down

# Билдим всё
build: build_app build_mon

# Билдим приложение
build_app: build_comment build_post build_ui

# Билдим мониторинг
build_mon: build_prometheus build_alertmanager

# Билдим логирование
build_mon: build_log

build_comment:
	export USER_NAME=$(USERNAME) && cd src/comment && bash docker_build.sh
build_post:
	export USER_NAME=$(USERNAME) && cd src/post-py && bash docker_build.sh
build_ui:
	export USER_NAME=$(USERNAME) && cd src/ui && bash docker_build.sh
build_prometheus:
	cd monitoring/prometheus && docker build -t $(USERNAME)/prometheus .
build_alertmanager:
	cd monitoring/alertmanager && docker build -t $(USER_NAME)/alertmanager .
build_log:
	cd logging/fluentd && docker build -t $(USER_NAME)/fluentd .

# Пушим всё

push: push_app push_mon

# Пушим приложение
push_app: push_comment push_post push_ui

# Пушим мониторинг
push_mon: push_prometheus push_alertmanager

push_comment:
	docker push $(USERNAME)/comment:$(APP_TAG)
push_post:
	docker push $(USERNAME)/post:$(APP_TAG)
push_ui:
	docker push $(USERNAME)/ui:$(APP_TAG)
push_prometheus:
	docker push $(USERNAME)/prometheus:latest
push_alertmanager:
	docker push $(USERNAME)/alertmanager:latest

# Билдим bugged приложение
build_bugged_app: build_bugged_comment build_bugged_post build_bugged_ui

build_bugged_comment:
	export USER_NAME=$(USERNAME) && cd bugged-code/comment && bash docker_build.sh
build_bugged_post:
	export USER_NAME=$(USERNAME) && cd bugged-code/post-py && bash docker_build.sh
build_bugged_ui:
	export USER_NAME=$(USERNAME) && cd bugged-code/ui && bash docker_build.sh

# Деплоим bugged приложение
deploy_bugged_app:
	cd docker && docker-compose -f docker-compose-bugged.yml up -d

# Останавливаем bugged приложение
stop_bugged_app:
	cd docker && docker-compose -f docker-compose-bugged.yml down
