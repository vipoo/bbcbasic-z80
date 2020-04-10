#!/bin/bash

TEST_RUNNER_DIR=./tests-fixtures/
SCRIPT_TO_RUN=$1
TAIL=${2}
MOCK_FILE=${TEST_RUNNER_DIR}${SCRIPT_TO_RUN}.mock

sudo rm -f /tmp/output.txt

SCREEN_PID=$(sudo screen -ls | grep bbcbasictestrunner | cut -d. -f1 | awk '{print $1}')
if [ "$SCREEN_PID" != "" ]; then
  sudo kill $SCREEN_PID
fi

echo "${SCRIPT_TO_RUN}:"

CMD=""
if test -f "$MOCK_FILE"; then
  CMD="--hbios-mocks $MOCK_FILE $CMD"
fi

STARTUP_FAILED=1
TAILPID=

function cleanup()
{
  if [ $TAILPID ]; then
    kill $TAILPID
  fi
  if [ "$STARTUP_FAILED" == "1" ]; then
    cat /tmp/output.txt
  fi
}

trap cleanup EXIT

set -e
sudo screen -d -m -L -Logfile /tmp/output.txt -S "bbcbasictestrunner" cpm $CMD
sudo screen -r bbcbasictestrunner -p0 -X logfile flush 0
input="${TEST_RUNNER_DIR}${SCRIPT_TO_RUN}.bas"
sudo screen -S bbcbasictestrunner -p 0 -X stuff "BBCBASIC^M"
set +e
STARTUP_FAILED=0

if [ "$TAIL" != "no-tail" ]; then
  tail -F -n50 /tmp/output.txt &
  tailpid=$!
fi

while IFS= read -r line
do
  sudo screen -S bbcbasictestrunner -p 0 -X stuff "${line}^M"
done < "$input"

sudo screen -S bbcbasictestrunner -p 0 -X stuff "RUN^M"
sudo screen -S bbcbasictestrunner -p 0 -X stuff "*bye^M"

( tail -F -n50 /tmp/output.txt  & ) | grep -q "*bye"

sudo screen -S bbcbasictestrunner -p 0 -X stuff "bye^M"

SCREEN_PID=$(sudo screen -ls | grep bbcbasictestrunner | cut -d. -f1 | awk '{print $1}')
if [ "$SCREEN_PID" != "" ]; then
  sudo kill $SCREEN_PID

  echo
  echo "Session failed to exit"
else
  awk '/RUN/,/efg/' /tmp/output.txt > ./.test-output.txt
  cp /tmp/output.txt ./.full-test-output.txt

  cd ./tests-fixtures
  if ./${SCRIPT_TO_RUN}.sh ../.test-output.txt; then
    echo "PASSED"
  else
    echo "FAILED"
    exit 1
  fi
fi

