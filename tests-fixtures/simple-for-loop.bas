10 FOR I = 1 TO 10
20 PRINT I
30 NEXT I

./clear
RUN

./expect 1 $'1\r'
./expect 1 '2'
./expect 1 '3'
./expect 1 '4'
./expect 1 '5'
./expect 1 '6'
./expect 1 '7'
./expect 1 '8'
./expect 1 '9'
./expect 1 '10'