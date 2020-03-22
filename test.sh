#!/bin/bash

SCRIPT_TO_RUN=$1
sudo rm /tmp/output.txt
SCREEN_PID=$(sudo screen -ls | grep bbcbasictestrunner | cut -d. -f1 | awk '{print $1}')
if [ "$SCREEN_PID" != "" ]; then
  sudo kill $SCREEN_PID
fi

echo "${SCRIPT_TO_RUN}:"
sudo screen -d -m -L -Logfile /tmp/output.txt -S "bbcbasictestrunner" ./cpm/cpm
input="./tests-fixtures/${SCRIPT_TO_RUN}.bas"
sudo screen -S bbcbasictestrunner -p 0 -X stuff "BBCBASIC^M"

while IFS= read -r line
do
  sudo screen -S bbcbasictestrunner -p 0 -X stuff "${line}^M"
done < "$input"

sudo screen -S bbcbasictestrunner -p 0 -X stuff "RUN^M"
sudo screen -S bbcbasictestrunner -p 0 -X stuff "*bye^M"
sudo screen -S bbcbasictestrunner -p 0 -X stuff "bye^M"

SCREEN_PID=$(sudo screen -ls | grep bbcbasictestrunner | cut -d. -f1 | awk '{print $1}')
if [ "$SCREEN_PID" != "" ]; then
  sudo kill $SCREEN_PID
  cat /tmp/output.txt

  echo
  echo "Session failed to exit"
else
  awk '/RUN/,/efg/' /tmp/output.txt > ./.test-output.txt
  #cp /tmp/output.txt ./.test-output.txt

  cd ./tests-fixtures
  if ./${SCRIPT_TO_RUN}.sh ../.test-output.txt; then
    echo "PASSED"
  else
    echo "FAILED"
#    cat ../.test-output.txt
  fi
fi

