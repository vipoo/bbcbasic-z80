REM MOCK: SYSGET SNDCNT sound adapter installed.
> B:F8 C:50
< E:00

10 REM SOUND is ignored if no h/w found
10 SOUND 1, -8, 250, 1
RUN

./expect 0 'HBIOS: BF_SNDPIT'
./expect 0 'HBIOS: BF_SNDPIT'
./expect 0 'HBIOS: BF_SNDVOL'
