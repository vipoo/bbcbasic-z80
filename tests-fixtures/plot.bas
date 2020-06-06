
MODE 2
./expect 1 "OUTPUT: 13077"
./clear

S = 1024/192

PLOT 0, 191 * S
00
./expect 1 "OUTPUT: 13078: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13079: addr = 00BF  DATA = 00"
./expect 1 "INPUT : addr = 0BE    DATA = 00"
./expect 1 "OUTPUT: 13080: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13081: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13082: addr = 80BE  DATA = 80"
./clear

PLOT 0, 190 * S
01
./expect 1 "OUTPUT: 13083: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 13084: addr = 00BF  DATA = 00"
./expect 1 "INPUT : addr = 0BE    DATA = 01"
./expect 1 "OUTPUT: 13085: addr = 01BF  DATA = 01"
./expect 1 "OUTPUT: 13086: addr = 40BF  DATA = 40"
./expect 1 "OUTPUT: 13087: addr = 81BE  DATA = 81"
./clear

PLOT 1 * 5, 183 * S
FF
./expect 1 "OUTPUT: 13088: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13089: addr = 01BF  DATA = 01"
./expect 1 "INPUT : addr = 1BE    DATA = FF"
./expect 1 "OUTPUT: 13090: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13091: addr = 41BF  DATA = 41"
./expect 1 "OUTPUT: 13092: addr = FFBE  DATA = FF"

./clear

PLOT 1.0 * 5, 183.0 * S
FF
./expect 1 "OUTPUT: 13093: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13094: addr = 01BF  DATA = 01"
./expect 1 "INPUT : addr = 1BE    DATA = FF"
./expect 1 "OUTPUT: 13095: addr = 00BF  DATA = 00"
./expect 1 "OUTPUT: 13096: addr = 41BF  DATA = 41"
./expect 1 "OUTPUT: 13097: addr = FFBE  DATA = FF"
./clear

PLOT 255 * 5, 0
00
./expect 1 "OUTPUT: 13098: addr = FFBF  DATA = FF"
./expect 1 "OUTPUT: 13099: addr = 17BF  DATA = 17"
./expect 1 "INPUT : addr = 17BE    DATA = 00"
./expect 1 "OUTPUT: 13100: addr = FFBF  DATA = FF"
./expect 1 "OUTPUT: 13101: addr = 57BF  DATA = 57"
./expect 1 "OUTPUT: 13102: addr = 01BE  DATA = 01"
