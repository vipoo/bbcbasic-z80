#!/bin/bash
set -xe

./tst 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 01, Volume in L: AA'
./tst 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 01, Pitch in HL: FA00'