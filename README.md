# Курсовой проект

[![coverage report](https://gitlab.com/kovtalex/otus-project/badges/master/coverage.svg?job=unit_test_crawler)](https://gitlab.com/kovtalex/otus-project/tree/master/src/search_engine_crawler) [![coverage report](https://gitlab.com/kovtalex/otus-project/badges/master/coverage.svg?job=unit_test_ui)](https://gitlab.com/kovtalex/otus-project/tree/master/src/search_engine_ui)

## Состав приложения

- [search_engine_crawler](https://github.com/express42/search_engine_crawler) - поисковый бот для сбора текстовой информации с веб-страниц и ссылок.
- [search_engine_ui](https://github.com/express42/search_engine_ui) - веб-интерфейс поиска слов и фраз на проиндексированных ботом сайтах.
- rabbimq - менеджер очереди сообщений.
- mongodb - база данных.
- prometheus - мониторинг инфраструктуры.
- grafana - визуализация мониторинга.
- alertmanager - менеджер оповещений.

## Состав git

- Terraform конфигурация инфраструктуры для окружений dev, preprod, prod
- Packer конфигурация для запекания образов окружения
- Ansible конфинурация установки docker, docker-compose на инстанс окружения
- Docker-compose конфигурация для развертывания приложения и мониторинга
- Dockefile's сервисов alertmanager, grafana, prometheus, rabbitmq и приложения
- .gitlab-ci.yml с описание пайплайна gitlab

## Доступ к сервисам

- <http://URL:80> - веб-интерфейс поиска слов и фраз на проиндексированных ботом сайтах.
- <http://URL:15672> - менеджмент RabbitMQ.
- <http://URL:9090> - Prometheus.
- <http://URL:3000> - Grafana.
- <http://URL:9093> - AlertManager.
- <http://URL:5601> - Kibana.

## Описание пайплайна

- юнит тесты микросервисов приложения.
- билд docker images микросервисов и вспомогательных компонентов (alertmanager, grafana, prometheus, rabbitmq) и пуш в docker hub c тегом хеша коммита
- назначение тегов latest для docker images ветки master и пуш в docker hub.
- назначение тегов tag для docker images для коммитов с тегами и пуш в docker hub.
- развертывание приложения в GCP в dev окружении из образов с тегами хешей коммитов.
- развертывание приложения в GCP в preprod окружении из docker образов с тегом latest.
- развертывание приложения в GCP в prod окружении из docker образов с тегом latest.

## Для удобства работы

- при правке кода приложения создаем ветки feature__* и затем мержим в master.
- при правке кода инфраструктуры создаем ветки infra_* и затем мержим в master.


## Мониторинг и логирование

![Monitoring and Logging Diagram](/mon_log.png)

## How to start...
