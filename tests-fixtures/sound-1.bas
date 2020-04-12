10 SOUND 1, -8, 16, 17185
RUN

./expect 1 'HBIOS: BF_SNDVOL, Driver in C 00, Channel in D: 01, Volume in L: 88'
./expect 1 'HBIOS: BF_SNDPIT, Driver in C 00, Channel in D: 01, Pitch in HL: 1000'
./expect 1 'HBIOS: BF_SNDDUR, Driver in C 00, Channel in D: 01, Duration in HL: 4321'
./expect 1 'HBIOS: BF_SNDPLAY'
