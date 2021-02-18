#!/bin/bash -e

if [ "$(uname -m)" == "armv7l" ]; then
  cp ./phantomjs-arm /usr/bin/phantomjs
  chmod -x /usr/bin/phantomjs
  chmod 775 /usr/bin/phantomjs
fi

cp -R /tmp/install/fonts/* /usr/share/fonts/truetype

npm install --unsafe-perm -g highcharts-export-server@2.0.30