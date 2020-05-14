FROM node:buster-slim

ENV LANG C.UTF-8
ENV PYTHONPATH /opt/client_web
ENV ACCEPT_HIGHCHARTS_LICENSE=y
ENV HIGHCHARTS_VERSION=4.2.2
ENV HIGHCHARTS_USE_STYLED=n
ENV HIGHCHARTS_USE_MAPS=n
ENV HIGHCHARTS_USE_GANTT=n
ENV HIGHCHARTS_MOMENT=n
ENV OPENSSL_CONF=""

RUN apt-get update && apt-get install -yy \
    bzip2

RUN npm install --unsafe-perm -g highcharts-export-server@2.0.28

CMD highcharts-export-server -enableServer 1 -host 0.0.0.0 -port 7801