> B:F9 C:D0
< A:00
> B:F8 C:D0
< A:00 C:3C D:00 E:10 H:00 L:00

10 TIME = 1747627

RUN

./expect 1 'HBIOS: BF_SYSSET, Subfunction: in C D0, DE:HL: 0010:0000'

