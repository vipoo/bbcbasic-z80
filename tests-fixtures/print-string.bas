10 PRINT "Hello World"
20 PRINT "Something else"
RUN

./expect 2 "Hello World"
./expect 2 "Something else"
