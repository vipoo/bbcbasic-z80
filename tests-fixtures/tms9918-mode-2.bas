10 MODE 2
RUN

./expect 1 '0: addr = 07BF  DATA = 00'
./expect 1 '1: addr = 07BF  DATA = 80'
./expect 1 '2: addr = 06BF  DATA = 80'
./expect 1 '3: addr = 06BF  DATA = 81'
./expect 1 '4: addr = 05BF  DATA = 0E'
./expect 1 '5: addr = 05BF  DATA = 82'
./expect 1 '6: addr = 04BF  DATA = 80'
./expect 1 '7: addr = 04BF  DATA = 83'
./expect 1 '8: addr = 03BF  DATA = 00'
./expect 1 '9: addr = 03BF  DATA = 84'
./expect 1 '10: addr = 02BF  DATA = 77'
./expect 1 '11: addr = 02BF  DATA = 85'
./expect 1 '12: addr = 01BF  DATA = 03'
./expect 1 '13: addr = 01BF  DATA = 86'
./expect 1 '14: addr = 00BF  DATA = F0'
./expect 1 '15: addr = 00BF  DATA = 87'
./expect 1 '16: addr = 00BF  DATA = 00'
./expect 1 '17: addr = 00BF  DATA = 40'

#Begin clearing VRAM
./expect 164 '18: addr = 00BE  DATA = 00'
./expect 164 '19: addr = 00BE  DATA = 00'
./expect 164 '20: addr = 00BE  DATA = 00'

#Final io
./expect 1 '17179: addr = 81BF  DATA = 81'
