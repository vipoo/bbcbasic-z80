
MODE 2
./expect 1 "OUTPUT: 13077"
./clear

S = 1024/192

MOVE 0, 1023
DRAW 20, 999
00
00
00
00
00

./expect 1 "OUTPUT: 13078: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13079: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13080: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13081: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13082: addr = 80BE  DATA = 80"
./expect 1 "OUTPUT: 13083: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 13084: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13085: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 13086: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13087: addr = 40BE  DATA = 40"
./expect 1 "OUTPUT: 13088: addr = 02BF  DATA = 02"
./expect 1 "OUTPUT: 13089: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13090: addr = 02BF  DATA = 02"
./expect 1 "OUTPUT: 13091: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13092: addr = 20BE  DATA = 20"
./expect 1 "OUTPUT: 13093: addr = 03BF  DATA = 03"
./expect 1 "OUTPUT: 13094: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13095: addr = 03BF  DATA = 03"
./expect 1 "OUTPUT: 13096: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13097: addr = 10BE  DATA = 10"
./expect 1 "OUTPUT: 13098: addr = 04BF  DATA = 04"
./expect 1 "OUTPUT: 13099: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13100: addr = 04BF  DATA = 04"
./expect 1 "OUTPUT: 13101: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13102: addr = 08BE  DATA = 08"
./expect 5 "INPUT : addr = 0BE    DATA = 00"

./clear


MOVE 0, 999
DRAW 20, 1023
00
00
00
00
00

./expect 1 "OUTPUT: 13103: addr = 04BF  DATA = 04"
./expect 1 "OUTPUT: 13104: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13105: addr = 04BF  DATA = 04"
./expect 1 "OUTPUT: 13106: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13107: addr = 80BE  DATA = 80"
./expect 1 "OUTPUT: 13108: addr = 03BF  DATA = 03"
./expect 1 "OUTPUT: 13109: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13110: addr = 03BF  DATA = 03"
./expect 1 "OUTPUT: 13111: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13112: addr = 40BE  DATA = 40"
./expect 1 "OUTPUT: 13113: addr = 02BF  DATA = 02"
./expect 1 "OUTPUT: 13114: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13115: addr = 02BF  DATA = 02"
./expect 1 "OUTPUT: 13116: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13117: addr = 20BE  DATA = 20"
./expect 1 "OUTPUT: 13118: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 13119: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13120: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 13121: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13122: addr = 10BE  DATA = 10"
./expect 1 "OUTPUT: 13123: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13124: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13125: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13126: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13127: addr = 08BE  DATA = 08"
./expect 5 "INPUT : addr = 0BE    DATA = 00"
