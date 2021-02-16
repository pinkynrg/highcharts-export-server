FROM node:stretch-slim

ENV LANG C.UTF-8
ENV PYTHONPATH /opt/client_web
ENV ACCEPT_HIGHCHARTS_LICENSE=y
ENV HIGHCHARTS_VERSION=4.2.2
ENV HIGHCHARTS_USE_STYLED=n
ENV HIGHCHARTS_USE_MAPS=n
ENV HIGHCHARTS_USE_GANTT=n
ENV HIGHCHARTS_MOMENT=n
ENV OPENSSL_CONF=""

RUN apt-get update && apt-get install --no-install-recommends -yy \
    ca-certificates \
    bzip2 \ 
    libsqlite3-dev \
    libfontconfig \ 
    libssl1.0.2 \ 
    libicu57

COPY . /tmp/install
RUN cd /tmp/install && /bin/bash ./install.sh
RUN rm -R /tmp/install

CMD highcharts-export-server -enableServer 1 -workers 1 -workLimit 1 -host 0.0.0.0 -port 7801