FROM python:3.6.0-alpine

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . $APP_HOME
RUN pip install -r /$APP_HOME/requirements.txt
WORKDIR $APP_HOME/ui
CMD FLASK_APP=ui.py gunicorn ui:app -b 0.0.0.0
