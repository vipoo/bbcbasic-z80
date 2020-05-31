
S = 1024/192

PLOT 0, 191 * S
00
./expect 1 "OUTPUT: 4: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 5: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 6: addr = 80BE  DATA = 80"
./clear

PLOT 0, 190 * S
01
./expect 1 "OUTPUT: 11: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 12: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13: addr = 81BE  DATA = 81"
./clear

PLOT 1 * 5, 183 * S
FF
./expect 1 "OUTPUT: 18: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 19: addr = 41BF  DATA = 41"
./expect 1 "OUTPUT: 20: addr = FFBE  DATA = FF"
