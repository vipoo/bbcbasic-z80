REM MOCK: SYSGET SNDCNT sound adapter installed.
> B:F8 C:50
< E:01

10 SOUND 2, 0, 1, -1
RUN

./expect 1 'HBIOS: BF_SNDVOL, Driver in C 00, Volume in L: 00'
./expect 1 'HBIOS: BF_SNDNOTE, Driver in C 00, Note in HL: 0001'
./expect 1 'HBIOS: BF_SNDPLAY, Driver in C 00, Channel in D: 01'

