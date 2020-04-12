10 SOUND 1, -10, 250, 1

RUN

./expect 1 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 01, Volume in L: AA'
./expect 1 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 01, Pitch in HL: FA00'
