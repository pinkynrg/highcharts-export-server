#!/bin/bash -e

if [ "$(uname -m)" == "armv7l" ]; then
  cp ./phantomjs-arm /usr/bin/phantomjs
  chmod -x /usr/bin/phantomjs
  chmod 775 /usr/bin/phantomjs
fi

npm install --unsafe-perm -g highcharts-export-server@2.0.28