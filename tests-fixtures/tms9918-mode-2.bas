10 MODE 2
RUN

./expect 1 'OUTPUT: 0: addr = 02BF  DATA = 02'
./expect 1 'OUTPUT: 1: addr = 80BF  DATA = 80'
./expect 1 'OUTPUT: 2: addr = E2BF  DATA = E2'
./expect 1 'OUTPUT: 3: addr = 81BF  DATA = 81'
./expect 1 'OUTPUT: 4: addr = 0EBF  DATA = 0E'
./expect 1 'OUTPUT: 5: addr = 82BF  DATA = 82'
./expect 1 'OUTPUT: 6: addr = FFBF  DATA = FF'
./expect 1 'OUTPUT: 7: addr = 83BF  DATA = 83'
./expect 1 'OUTPUT: 8: addr = 03BF  DATA = 03'
./expect 1 'OUTPUT: 9: addr = 84BF  DATA = 84'
./expect 1 'OUTPUT: 10: addr = 76BF  DATA = 76'
./expect 1 'OUTPUT: 11: addr = 85BF  DATA = 85'
./expect 1 'OUTPUT: 12: addr = 03BF  DATA = 03'
./expect 1 'OUTPUT: 13: addr = 86BF  DATA = 86'
./expect 1 'OUTPUT: 14: addr = F1BF  DATA = F1'
./expect 1 'OUTPUT: 15: addr = 87BF  DATA = 87'
./expect 1 'OUTPUT: 16: addr = 00BF  DATA = 00'
./expect 1 'OUTPUT: 17: addr = 78BF  DATA = 78'

REM # last byte name table
./expect 1 'OUTPUT: 785: addr = FFBE  DATA = FF'

REM # last byte for color table
./expect 1 'OUTPUT: 6931: addr = F1BE  DATA = F1'

REM # last byte for pattern table
./expect 1 'OUTPUT: 13077: addr = 00BE  DATA = 00'
