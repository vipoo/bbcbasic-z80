#!/bin/bash
set -xe

./tst 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 01, Volume in E: 70'
./tst 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 01, Pitch in HL: 1000'