> B:F8 C:D0
< A:00 C:3C D:00 E:00 H:00 L:3C
> B:F9 C:D0
< A:00

10 TIME = 100
20 T=TIME
40 PRINT "TIME: "; T

RUN

./expect 1 'HBIOS: BF_SYSSET, Subfunction: in C D0, DE:HL: 0000:003C'
./expect 1 'TIME: 100'

