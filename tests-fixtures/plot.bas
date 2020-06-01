
S = 1024/192

PLOT 0, 191 * S
00
./expect 1 "OUTPUT: 0: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 1: addr = 00BF  DATA = 00"
./expect 1 "INPUT : addr = 0BE    DATA = 00"
./expect 1 "OUTPUT: 2: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 3: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 4: addr = 80BE  DATA = 80"
./clear

PLOT 0, 190 * S
01
./expect 1 "OUTPUT: 5: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 6: addr = 00BF  DATA = 00"
./expect 1 "INPUT : addr = 0BE    DATA = 01"
./expect 1 "OUTPUT: 7: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 8: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 9: addr = 81BE  DATA = 81"
./clear

PLOT 1 * 5, 183 * S
FF
./expect 1 "OUTPUT: 10: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 11: addr = 01BF  DATA = 01"
./expect 1 "INPUT : addr = 1BE    DATA = FF"
./expect 1 "OUTPUT: 12: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13: addr = 41BF  DATA = 41"
./expect 1 "OUTPUT: 14: addr = FFBE  DATA = FF"

./clear

PLOT 1.0 * 5, 183.0 * S
FF
./expect 1 "OUTPUT: 15: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 16: addr = 01BF  DATA = 01"
./expect 1 "INPUT : addr = 1BE    DATA = FF"
./expect 1 "OUTPUT: 17: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 18: addr = 41BF  DATA = 41"
./expect 1 "OUTPUT: 19: addr = FFBE  DATA = FF"
./clear

PLOT 255 * 5, 0
00
./expect 1 "OUTPUT: 20: addr = FFBF  DATA = FF"
./expect 1 "OUTPUT: 21: addr = 17BF  DATA = 17"
./expect 1 "INPUT : addr = 17BE    DATA = 00"
./expect 1 "OUTPUT: 22: addr = FFBF  DATA = FF"
./expect 1 "OUTPUT: 23: addr = 57BF  DATA = 57"
./expect 1 "OUTPUT: 24: addr = 01BE  DATA = 01"
