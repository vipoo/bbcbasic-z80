10 SOUND 1, -10, 250, 1

RUN

./expect 1 'HBIOS: BF_SNDVOL, Driver in C 00, Volume in L: AA'
./expect 1 'HBIOS: BF_SNDNOTE, Driver in C 00, Note in HL: 00FA'
./expect 1 'HBIOS: BF_SNDPLAY, Driver in C 00, Channel in D: 00'
