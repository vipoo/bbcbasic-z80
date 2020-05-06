stksiz	equ	$40		; Working stack size
restart	equ	$0000		; CP/M restart vector
bdos	equ	$0005		; BDOS invocation vector

DESTLOC	EQU	$7000 ;+ APPSIZE - 1
	ORG	$100

	LD	sp, stack		; set new stack
	LD	HL, (6)		;DE = HIMEM
	DEC	HL
	LD	L, 0		; 256 BOUNDARY
	DEC	HL

	PUSH	HL
	POP	IX
	LD	DE, HL

	LD	HL, APP + APPSIZE - 1
	LD	BC, APPSIZE
	LDDR

	INC	DE

	PUSH	DE			; capture start point in IX
	POP	IX

	ex	de, hl
	ld	de, $100
	sub	hl, de
	PUSH	HL
	POP	IY			; offset value (IX - 100)

	PUSH	IX
	POP	DE			; Start of code
	LD	HL, RELOC
	LD	BC, RELOCSIZE / 2

LOOP:
	CALL	TRANSPOSE

	INC	HL
	INC	HL
	DEC	BC
	LD	A, B
	OR	C
	JR	NZ, LOOP

	PUSH	IX
	POP	HL

	JP	(IX)

TRANSPOSE:
	PUSH	HL
	PUSH	BC
	PUSH	DE

	LD	E, (HL)
	INC	HL
	LD	D, (HL)

	EX	DE, HL
	PUSH	IX
	POP	DE
	ADD	HL, DE

	LD	C, (HL)
	INC	HL
	LD	B, (HL)

	PUSH	IY
	POP	DE

	PUSH	HL
	LD	HL, DE
	ADD	HL, BC
	LD	D, H
	LD	E, L
	POP	HL

	LD	(HL), D
	DEC	HL
	LD	(HL), E
	POP	DE
	POP	BC
	POP	HL
	RET

RELOC:
BINARY	"_bbcbasic.reloc"
RELOCSIZE:	EQU	ASMPC - RELOC


stksav:		DEFW	0		; stack pointer saved at start
		DEFS	stksiz	; stack
stack:		EQU	ASMPC		; stack top

	DEFS	8


APP:
BINARY "_bbcbasic.com"
	defs 	256 - ((ASMPC - APP) % 256)
APPSIZE:	EQU	ASMPC - APP

MSG1:	DEFM	"1111$", 0, 0, 0
