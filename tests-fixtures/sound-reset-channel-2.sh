#!/bin/bash
set -xe

./tst 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 02, Volume in E: F0'
./tst 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 02, Pitch in HL: 0100'