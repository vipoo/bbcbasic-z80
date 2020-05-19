REM MOCK: SYSGET SNDCNT sound adapter installed.
> B:F8 C:50
< E:01

10 SOUND 0, 0, 1, 1
20 SOUND 1, 0, 2, 1
30 SOUND 2, 0, 3, 1
40 SOUND 3, 0, 4, 1

RUN

./expect 4 'HBIOS: BF_SNDVOL, Driver in C 00, Volume in L: 00'
./expect 1 'HBIOS: BF_SNDNOTE, Driver in C 00, Note in HL: 0031'
./expect 1 'HBIOS: BF_SNDNOTE, Driver in C 00, Note in HL: 0032'
./expect 1 'HBIOS: BF_SNDNOTE, Driver in C 00, Note in HL: 0033'
./expect 1 'HBIOS: BF_SNDNOTE, Driver in C 00, Note in HL: 0034'

./expect 1 'HBIOS: BF_SNDPLAY, Driver in C 00, Channel in D: FF'
./expect 1 'HBIOS: BF_SNDPLAY, Driver in C 00, Channel in D: 00'
./expect 1 'HBIOS: BF_SNDPLAY, Driver in C 00, Channel in D: 01'
./expect 1 'HBIOS: BF_SNDPLAY, Driver in C 00, Channel in D: 02'
