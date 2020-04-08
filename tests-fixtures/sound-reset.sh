#!/bin/bash
set -xe

./expect 1 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 00, Volume in L: 00'
./expect 1 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 00, Pitch in HL: 0100'
./expect 1 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 01, Volume in L: 00'
./expect 1 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 01, Pitch in HL: 0100'
./expect 1 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 02, Volume in L: 00'
./expect 1 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 02, Pitch in HL: 0100'
./expect 1 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 03, Volume in L: 00'
./expect 1 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 03, Pitch in HL: 0100'