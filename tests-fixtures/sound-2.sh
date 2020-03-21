#!/bin/bash
set -xe

./tst 'addr = A1FC  DATA = A1'
./tst 'addr = A1F8  DATA = A1'
./tst 'addr = 10FC  DATA = 10'
./tst 'addr = 10F8  DATA = 10'
./tst 'addr = B7FC  DATA = B7'
./tst 'addr = B7F8  DATA = B7'