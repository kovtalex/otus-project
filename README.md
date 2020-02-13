# Курсовой проект

[![coverage report](https://gitlab.com/kovtalex/otus-project/badges/master/coverage.svg?job=unit_test_crawler)](https://gitlab.com/kovtalex/otus-project/tree/master/src/search_engine_crawler) [![coverage report](https://gitlab.com/kovtalex/otus-project/badges/master/coverage.svg?job=unit_test_ui)](https://gitlab.com/kovtalex/otus-project/tree/master/src/search_engine_ui)

## Выполненные задачи проекта

- Автоматизированны процессы создания и управления платформой.
  - Ресурсы GCP для развертывания окружений, контейнеризации проекта и деплоя в процессе пайплайна.
  - Инфраструктура для CI/CD развернута на GitLab.com.
  - Инфраструктура для сбора обратной связи.
- Использованы практики IaC (Infrastructure as Code) для управления конфигурацией и инфраструктурой.
- Настроен процесс CI/CD для обеспечения пайплайна.
- Все, что имеет отношение к проекту хранится в GitLab.
- Настроен процесс сбора обратной связи.
  - Мониторинг (сбор метрик, алертинг, визуализация) с помощью Prometheus, Alertmanager и Grafana.
  - Логирование микросервисного приложения в ElasticSearch с отображением в Kibana.
  - ChatOps интеграция с каналом в Slack.
- Документация.
  - README по работе с репозиторием, описанием приложения и его архитектурой.
  - How to start.
  - CHANGELOG с описанием выполненной работы.

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

### Архитектура основных компонентов

![App Diagram1](/app1.png)

Основные компонентами проекта - микросервисное приложение, состоящее из поискового бота **Crawler** для сбора текстовой информации с веб-страниц и ссылок; веб-интерфейса **Web_UI** поиска слов и фраз на проиндексированных ботом сайтах; **RabbitMQ** менеджера очереди сообщений для хранения адресов веб-страниц; базы данных **MongoDB** для хранения связей между сайтами.

![App Diagram2](/app2.png)

После развертывания и запуска проекта бот **Crawler** помещает переданный ему при запуске **url** в очередь и затем начинает обрабатывать все **url** в очереди. Для каждого **url** бот загружает содержимое страницы, записывая в БД связи между сайтами, между сайтами и словами. Все найденые на странице **url** помещает обратно в очередь.

![App Diagram3](/app3.png)

Для поиска слов и фраз на проиндексированных сайтах используется простой веб-интерфейс **Web-ui**. Используя данный интерфейс пользователь вводит искомые слова или фразы в строку для запроса. В процессе поиска в базе данных обрабатываются только те страницы, на которых были найдены все слова из запроса.
Результатом обработки будут записи с оценкой полезности ссылки (чем больше, тем лучше).

### Архитектура мониторинга и логирования

![Monitoring and Logging Diagram](/mon_log.png)

Для своевременной обратной связи в проекте используется мониторинг, логирование, алертинк и логирование.

В проекте представлены следующие готовые дашборды Grafana:

- Application - мониторинг метрик микросервисного приложения.
- RabbitMQ-Overview - мониторинг состояние RabbitMQ.
- MongoDB-Overview - мониторинг состояния базы данных.
- Docker and system monitoring - мониторинг состояния docker контейнеров.
- Node Exporter - мониторинг состояния хоста.

![Application Monitoring](/app_mon.png)

Мониторинг метрик микросервисного приложения.

## Доступ к сервисам проекта

- <http://URL:80> - веб-интерфейс поиска слов и фраз на проиндексированных ботом сайтах микросервисного приложения.
- <http://URL:15672> - менеджмент RabbitMQ (guest/guest).
- <http://URL:9090> - Prometheus.
- <http://URL:3000> - Grafana (admin/admin).
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

### Для запуска проекта требуется

- настроенный доступ на <https://gitlab.com/> или свой GitLab CI.
- настроенный доступ на GCP.
- установленный Terraform, Packer, Ansible.
- созданные ключи пользователя, к примеру **appuser**.

### Подготовка

- Клонируем репозитарий <https://gitlab.com/kovtalex/otus-project.git>.

### Запекание образа будущих окружений с помощью Packer и установкой docker и docker-compose с помощью Ansible

- Переходим в корень репозитория.
- Копируем variables.json.example в variables.json.
- Запекаем образ для наших будущих окружений c помощью команды **packer build -var-file=infra/packer/variables.json infra/packer/docker.json**.

### Развертывание окружений с помощью Terraform

- Переходим в папку otus-project/infra/terraform.
- Копируем terraform.tfvars.examples в terraform.tfvars.
- Выполняем **gcloud auth application-default login**.
- Выполняем **terraform init**
- Выполняем **terraform apply**
- Прописываем внешние IP окружений в переменные в GitLab CI (см список переменных окружений ниже).

### Пуш изменений в Gitlab

- Создаем ветку, к примеру infra_gitlab.
- Вносим изменения в конфигурацию инфраструктуры.
- Коммитим и пушим изменения в наш GitLab.

### Пайплайн

- Переходим на страницу **CI/CD -> Pipelines** и для нашей ветки наблюдаем выполнение этапов пайплайна.
- Если сборка контейнеров и юнит тесты прошли успешно, то внесенные нами изменения выкатываются на **dev** окружение с тэгом **хеша коммита**.
- Переходим на страницу **Operations -> Environments** и наблюдаем **dev** окружение.
- По кнопке **Open live environment** попадаем в веб интерфейс поиска слов и фраз на проиндексированных сайтах.
- Ввводим слово, ждем поиск и получает результат в виде списка.
- Далее можно остановить наше dev окружение по кнопке.

### Merge Request

- При мерже наших веток в master, создается пайплайн с возможность выкатить изменения на preprod и prod окружения по кнопке.
- Также на созданные docker образы нашего проекта назначается тэг **latest**.

### На GitLab CI прописываем переменных оружения

Key | Value | Notes
--- | ----- | -----
CI_REGISTRY | <https://index.docker.io/v1/> | Если используется Docker Hub как репозитарий артефактов.
CI_REGISTRY_BASE64 | вывод команды "echo -n USER:PASSWORD \| base64" с данными авторизации к Docker Hub.
CI_REGISTRY_PASS | пароль к Docker Hub |
CI_REGISTRY_USERNAME | Docker ID |
GOOGLE_PROJECT_ID | docker | Имя проекта.
GOOGLE_COMPUTE_ZONE | europe-west1-b | Имя зоны инстансов.
GCLOUD_SERVICE_KEY | json ключ | Создадим service account на GCP с соответствующей ролью и сгенерируем ключ в формете json.
URL_DEV | <http://url> dev окружения | К примеру внешний IP инстанса GCP.
URL_PREPROD | <http://url> preprod окружения | К примеру внешний IP инстанса GCP.
URL_PROD | <http://url> prod окружения | К примеру внешний IP инстанса GCP.
URL | url ресурса для анализа | К примеру <http://mediactive.com/>.
EXCLUDE_URLS | url ресурсов через запятую для исключения из анализа | К примеру .*github.com.
