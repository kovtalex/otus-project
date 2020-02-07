FROM python:3.6.0-alpine

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . $APP_HOME
RUN pip install -r /$APP_HOME/requirements.txt
WORKDIR $APP_HOME/crawler
CMD python -u crawler.py $URL
