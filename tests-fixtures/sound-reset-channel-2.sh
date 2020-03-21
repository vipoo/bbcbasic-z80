#!/bin/bash
set -xe

./tst 'addr = C1FC  DATA = C1' # Latch and set pitch
./tst 'addr = C1F8  DATA = C1'
./tst 'addr = 00FC  DATA = 00' # set pitch high bits
./tst 'addr = 00F8  DATA = 00'
./tst 'addr = DFFC  DATA = DF' # set volume to silent
./tst 'addr = DFF8  DATA = DF'