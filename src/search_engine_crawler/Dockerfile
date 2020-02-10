FROM python:3.6.0-alpine

ENV APP_HOME /app
ENV URL https://vitkhab.github.io/search_engine_test_site/
ENV EXCLUDE_URLS .*github.com
WORKDIR $APP_HOME
COPY . $APP_HOME
RUN pip install -r /$APP_HOME/requirements.txt
WORKDIR $APP_HOME/crawler
CMD python -u crawler.py $URL
