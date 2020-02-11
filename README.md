# Курсовой проект

[![coverage report](https://gitlab.com/kovtalex/otus-project/badges/master/coverage.svg?job=unit_test_crawler)](https://gitlab.com/kovtalex/otus-project/tree/master/src/search_engine_crawler) [![coverage report](https://gitlab.com/kovtalex/otus-project/badges/master/coverage.svg?job=unit_test_ui)](https://gitlab.com/kovtalex/otus-project/tree/master/src/search_engine_ui)

## Описание микросервисного приложения проекта

### Search Engine Crawler

Поисковый бот для сбора текстовой информации с веб-страниц и ссылок.

Бот помещает в очередь **url** переданный ему при запуске. Затем он начинает обрабатывать все **url** в очереди. Для каждого **url** бот загружает содержимое страницы, записывая в БД связи между сайтами, между сайтами и словами. Все найденые на странице **url** помещает обратно в очередь.

### Search Engine UI

Веб-интерфейс поиска слов и фраз на проиндексированных ботом сайтах.

Веб-интерфейс минимален, предоставляет пользователю строку для запроса и результаты. Поиск происходит только по индексированным сайтам. Результат содержит только те страницы, на которых были найдены все слова из запроса. Рядом с каждой записью результата отображается оценка полезности ссылки (чем больше, тем лучше).

## Состав проекта

- Микросервисное приложение [search_engine_crawler](https://github.com/express42/search_engine_crawler) - поисковый бот для сбора текстовой информации с веб-страниц и ссылок.
- Микросервисное приложение [search_engine_ui](https://github.com/express42/search_engine_ui) - веб-интерфейс поиска слов и фраз на проиндексированных ботом сайтах.
- RabbiMQ - менеджер очереди сообщений.
- MongoDB - база данных.
- Prometheus - мониторинг инфраструктуры.
- Grafana - визуализация мониторинга.
- AlertManager - менеджер оповещений.
- Node-Exporter - экспортер метрик хоста.
- MongoDB-Exporter - экспортер метрик базы данных.
- cAdvisor - утилита сборки, агрегации, обработки и экспорта информации о запущенных контейнерах.
- Fluentd - коллектор логов микросервисного приложения.
- ElasticSearch - поисковая и аналитическая система.
- Kibana - визуализация логов.

## Архитектура

### Архитектура микросервисного приложения

![App Diagram1](/app1.png)

Добавить описание.

![App Diagram2](/app2.png)

Добавить описание.

![App Diagram3](/app3.png)

Добавить описание.

### Архитектура мониторинга и логирования

![Monitoring and Logging Diagram](/mon_log.png)

Добавить описание. Привести скрин бизнес метрик.

## Доступ к сервисам проекта

- <http://URL:80> - веб-интерфейс поиска слов и фраз на проиндексированных ботом сайтах микросервисного приложения.
- <http://URL:15672> - менеджмент RabbitMQ.
- <http://URL:9090> - Prometheus.
- <http://URL:3000> - Grafana.
- <http://URL:9093> - AlertManager.
- <http://URL:5601> - Kibana.

## Состав репозитария проекта

- Terraform конфигурация инфраструктуры для окружений dev, preprod, prod.
  - \infra\terraform
- Packer конфигурация для запекания образа окружения.
  - \infra\packer
- Ansible конфигурация установки docker, docker-compose на инстансы окружений.
  - \infra\ansible
- Docker-compose конфигурации для развертывания микросервсного приложения, мониторинга и логирования.
  - .env.example
  - \docker\docker-compose.yml
  - \docker\docker-compose-monitoring.yml
  - \docker\docker-compose-logging.yml
- Код микросервисного приложения и Dockefile's для сборки docker образов.
  - \src\crawler
  - \src\ui
- Dockefile's сервисов rabbitmq, alertmanager, grafana, prometheus, fluentd для сборки docker образов.
  - \services\rabbitmq
  - \services\monitoring\alermanager
  - \services\monitoring\grafana
  - \services\monitoring\prometheus
  - \services\monitoring\grafana
  - \services\logging\fluentd
- .gitlab-ci.yml с описанием пайплайна GitLab.

## Описание пайплайна

- Билд docker образов микросервисного приложения, сервисов (rabbitmq, alertmanager, grafana, prometheus, fluentd) и пуш в Docker Hub c тегом хеша коммита.
- Выполнение юнит тестов микросервисов приложения.
- Назначение тега latest для docker образов ветки master и пуш в Docker Hub.
- Назначение тега tag для docker образов пуша с тегом версии и пуш в Docker Hub.
- Развертывание приложения в GCP в dev окружении из образов с тегом хеша коммита.
- Развертывание приложения в GCP в preprod окружении из docker образов с тегом latest по кнопке.
- Развертывание приложения в GCP в prod окружении из docker образов с тегом latest по кнопке.

## Для удобства работы

- При правке кода приложения создаем ветки feature__* и затем мержим в master.
- При правке кода инфраструктуры создаем ветки infra_* и затем мержим в master.

## How to start

## Выполненные задачи проекта

- Автоматизированны процессы создания и управления платформой.
  - Ресурсы GCP для развертывания окружений и приложения в процессе пайплайна.
  - Инфраструктура для CI/CD развернута на GitLab.com.
  - Инфраструктура для сбора обратной связи на основе docker контейнеров.
- Использованы практики IaC (Infrastructure as Code) для управления конфигурацией и инфраструктурой.
- Настроен процесс CI/CD для обеспечения пайплайна.
- Все, что имеет отношение к проекту хранится в GitLab.
- Настроен процесс сбора обратной связи.
  - Мониторинг (сбор метрик, алертинг, визуализация) с помощью prometheus, alertmanager и grafana.
  - Логирование микросервисного приложения в elasticsearch с отображением в kibana.
  - ChatOps интеграция с каналом в Slack.
- Документация.
  - README по работе с репозиторием, описанием приложения и его архитектурой.
  - How to start.
  - CHANGELOG с описанием выполненной работы.
