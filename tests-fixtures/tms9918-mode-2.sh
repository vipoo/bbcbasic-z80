#!/bin/bash
set -xe

./tst '0: addr = 07BF  DATA = 00'
./tst '1: addr = 07BF  DATA = 80'
./tst '2: addr = 06BF  DATA = 80'
./tst '3: addr = 06BF  DATA = 81'
./tst '4: addr = 05BF  DATA = 0E'
./tst '5: addr = 05BF  DATA = 82'
./tst '6: addr = 04BF  DATA = 80'
./tst '7: addr = 04BF  DATA = 83'
./tst '8: addr = 03BF  DATA = 00'
./tst '9: addr = 03BF  DATA = 84'
./tst '10: addr = 02BF  DATA = 77'
./tst '11: addr = 02BF  DATA = 85'
./tst '12: addr = 01BF  DATA = 03'
./tst '13: addr = 01BF  DATA = 86'
./tst '14: addr = 00BF  DATA = F0'
./tst '15: addr = 00BF  DATA = 87'
./tst '16: addr = 00BF  DATA = 00'
./tst '17: addr = 00BF  DATA = 40'

#Begin clearing VRAM
./tst '18: addr = 00BE  DATA = 00'
./tst '19: addr = 00BE  DATA = 00'
./tst '20: addr = 00BE  DATA = 00'

#Final io
./tst '17179: addr = 81BF  DATA = 81'