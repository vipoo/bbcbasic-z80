

NEW
OSCLI "DIR"
10 OSCLI "DIR"
20 OUT 257, 16
30 PRINT "D=";IN(23)
RUN
10

./expect 0 "Bad command"
./expect 0 "Mistake at line"
./expect 1 "OUTPUT: 0: addr = 0101  DATA = 10"
./expect 1 "D=INPUT : addr = 017    DATA = 10"

./clear
LIST
./expect 1 "10 OSCLI \"DIR\""
./expect 1 "20 OUT 257, 1"
./expect 1 "30 PRINT \"D=\";INP(23)"


NEW
HIMEM=HIMEM-1
./clear
PRINT "HIMEM=";HIMEM
./expect 1 "HIMEM=[0-9]\+"

NEW
AUTO
PRINT "lomem="; LOMEM
PRINT "page="; PAGE
PRINT "himem="; HIMEM
CLEAR
DATA 9981
READ A%
PRINT "DATA=";A%
REM COMMENT
PROC_BLAH("SOME TEXT")
DIM A(10)
FOR I = 0 TO 10
A(I) = I
NEXT I
PRINT "A(.)=";A(0);" ";A(10)
END
DEF PROC_BLAH(Title$)
CLS
PRINT TAB(2);Title$
ENDPROC
.ESC

./clear
RUN

./expect 1 'page=256'
./expect 1 'himem=[0-9]\+'
./expect 1 'DATA=9981'
./expect 1 'A(.)=0 10'
./expect 1 'lomem=509'


LOMEM=LOMEM+1
./clear
PRINT LOMEM
./expect 1 "510"

NEW
PAGE=512
./clear
PRINT PAGE
./expect 1 "512"


NEW
10 I = 1
20 REPEAT
30  PRINT I
40  I = I + 1
50 UNTIL I > 10
./clear
RUN

./expect 1 "4"
./expect 1 "5"
./expect 1 "6"


NEW
WIDTH 5
10 PRINT "1234567890"
./clear
RUN
./expect 1 "12345\b"
./expect 1 "67890\b"
WIDTH 300

NEW
10 PRINT "10"
11 PRINT "11"
13 REM BLAH
RENUMBER
./clear
LIST
./expect 1 "20 PRINT \"11\""


NEW
AUTO
PRINT "time=";TIME
TIME=20
PRINT TIME
STOP
.ESC
./clear
RUN

./expect 1 "time=[0-9]\+"
./expect 1 "HBIOS: BF_SYSSET, Subfunction: in C D0, DE:HL: 0000:000A"
./expect 1 "STOP at line 40"

NEW
AUTO
A=4
B=FN_Square(A)
PRINT A;" squared is ";B
END
DEF FN_Square(Num)
=Num^\\^2
.ESC
./clear
RUN

./expect 1 "4 squared is 16"

NEW
AUTO
A = OPENOUT("TEST.TXT")
FOR Z=1 TO 10
  Z$="Z=" + STR$(Z)
  PRINT#A, Z$
NEXT
CLOSE#A
END
.ESC
RUN

NEW
AUTO
A = OPENIN "TEST.TXT"
FOR i=1 TO 10
  INPUT#A,A$
  PRINT A$
NEXT
CLOSE#A
.ESC
./clear
RUN

./expect 1 "Z=2"
./expect 1 "Z=3"
./expect 1 "Z=10"

NEW
AUTO
PRINT TAN(2)
PRINT "SQR: "; SQR(16)
PRINT "SIN: "; SIN(20)
PRINT "SGN: "; SGN(-20)
PRINT "RND: "; RND
PRINT "RAD: "; RAD(2)
PRINT "PI: "; PI
PRINT "NOT: "; NOT FALSE
PRINT "LOG: "; LOG(23)
PRINT "LN: "; LN(23)
PRINT "LEN: "; LEN("ABCD")
PRINT "INT: "; INT(23.33)
PRINT "DEG: "; DEG(20)
PRINT "COS: "; COS(2)
PRINT "ATN: "; ATN(2)
PRINT "ASN: "; ASN(0.5)
PRINT "ACS: "; ACS(0.2)
PRINT "ABS: "; ABS(-1.2)
PRINT "x="; 2*3+4-6/2

.ESC
./clear
RUN

./expect 1 "\-2.18503986"
./expect 1 "SQR: 4"
./expect 1 "SIN: 0.912945251"
./expect 1 "SGN: \-1"
./expect 1 "RND: [0-9]\+"
./expect 1 "RAD: 3.49065851E-2"
./expect 1 "PI: 3.14159265"
./expect 1 "NOT: \-1"
./expect 1 "LOG: 1.36172784"
./expect 1 "LN: 3.13549422"
./expect 1 "LEN: 4"
./expect 1 "INT: 23"
./expect 1 "DEG: 1145.91559"
./expect 1 "COS: \-0.416146837"
./expect 1 "ATN: 1.10714872"
./expect 1 "ASN: 0.523598776"
./expect 1 "ACS: 1.36943841"
./expect 1 "ABS: 1.2"
./expect 1 "x=7"

NEW
10 PRINT STRING$(2, "B")
20 PRINT STR$(9812); "X"
30 PRINT RIGHT$("abcd", 2)
40 PRINT MID$("ABCDEFGH", 3, 3); "|"
50 PRINT LEFT$("ZXY", 2); "|"
60 PRINT CHR$(65); "|"
70 PRINT VPOS, POS
80 IF TRUE PRINT TRUE
90 PRINT INSTR("ABCDEFGH", "DEF"); "|"
100 PRINT "ABCD:"; COUNT; "|"
110 PRINT "|"; ASC("A"); "|"

./clear
RUN

./expect 1 "BB"
./expect 1 "9812X"
./expect 1 "cd"
./expect 1 "CDE|"
./expect 1 "ZX|"
./expect 1 "A|"
./expect 1 "\-1"
./expect 1 "4|"
./expect 1 "ABCD:5|"
./expect 1 "|65|"

NEW
AUTO
LET A$="OUTER"
PROC_BLAH
PRINT "A$=";A$
END
DEF PROC_BLAH
LOCAL A$
A$="INNER"
PRINT "BLAH=";A$
ENDPROC
.ESC
./clear
RUN

./expect 1 "A$=OUTER"
./expect 1 "BLAH=INNER"


NEW
10 GOSUB 100
20 PRINT "20|";
30 GOTO 200
40 PRINT "40|"
50 END
100 PRINT "100|";
110 RETURN
200 PRINT "200|";
210 GOTO 40
./clear

RUN

./expect 1 "100|20|200|40"



NEW
10 IF 0 THEN PRINT "FALSE"
20 IF 1 THEN PRINT "TRUE"
30 INPUT A$
40 PRINT "A$=";A$
50 LET B$="XXX"
60 PRINT "B$=";B$
70 IF 1 AND 1 PRINT "1 AND 1"
./clear
RUN
BOB
./expect 1 "TRUE"
./expect 0 "FALSE"
./expect 1 "A$=BOB"
./expect 1 "B$=XXX"
./expect 1 "1 AND 1"

