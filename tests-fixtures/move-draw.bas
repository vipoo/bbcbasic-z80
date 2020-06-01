
S = 1024/192

MOVE 0, 1023
DRAW 20, 999
00
00
00
00
00

./expect 1 "OUTPUT: 0: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 1: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 2: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 3: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 4: addr = 80BE  DATA = 80"
./expect 1 "OUTPUT: 5: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 6: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 7: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 8: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 9: addr = 40BE  DATA = 40"
./expect 1 "OUTPUT: 10: addr = 02BF  DATA = 02"
./expect 1 "OUTPUT: 11: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 12: addr = 02BF  DATA = 02"
./expect 1 "OUTPUT: 13: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 14: addr = 20BE  DATA = 20"
./expect 1 "OUTPUT: 15: addr = 03BF  DATA = 03"
./expect 1 "OUTPUT: 16: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 17: addr = 03BF  DATA = 03"
./expect 1 "OUTPUT: 18: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 19: addr = 10BE  DATA = 10"
./expect 1 "OUTPUT: 20: addr = 04BF  DATA = 04"
./expect 1 "OUTPUT: 21: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 22: addr = 04BF  DATA = 04"
./expect 1 "OUTPUT: 23: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 24: addr = 08BE  DATA = 08"
./expect 5 "INPUT : addr = 0BE    DATA = 00"

./clear


MOVE 0, 999
DRAW 20, 1023
00
00
00
00
00

./expect 1 "OUTPUT: 42: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 43: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 44: addr = 10BE  DATA = 10"
./expect 1 "OUTPUT: 45: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 46: addr = 00BF  DATA = 00"
./expect 5 "INPUT : addr = 0BE    DATA = 00"
./expect 1 "OUTPUT: 47: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 48: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 49: addr = 08BE  DATA = 08"
