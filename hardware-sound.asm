;	TITLE	BBC BASIC (C) R.T.RUSSELL 1987
;
;BBC BASIC INTERPRETER - Z80 VERSION
;HARDWARE SOUND INTERFACE
;(C) COPYRIGHT  R.T.RUSSELL  1984
; extensions by Dean Netherton 2020

include "hbios.inc"
include "constants.inc"
#include "tracing.inc"

	PUBLIC	SOUND
	PUBLIC	SOUND_INIT

	EXTERN	EXPRI
	EXTERN	COMMA
	EXTERN	XEQ
	EXTERN	SOUND_ENABLED
	EXTERN	QUEUE_CMDBUF
	EXTERN	QUEUE_CMDBUFED
	EXTERN	QUEUE_CMD_WORK
	EXTERN	TIMESTOREH
	EXTERN	TIMESTOREL
	EXTERN	SUB
	EXTERN	TICKFREQ
	EXTERN	CENTSTOTICKS
	EXTERN	ERROR
	EXTERN	AUD_TIMERTICK

SOUND_INIT:
	LD	BC, SYSGET_SNDCNT	; RETRIEVE SOUND DRIVER COUNTS
	CALL_HBIOS

	LD	A, E
	LD	(SOUND_ENABLED), A

	LD	BC, SYSGET_TIMER	; CAPTURE TIMER TICK FREQUENCY
	CALL_HBIOS			; AND CURRENT TIME
	ld	a, c
	LD	(TICKFREQ), A
	LD	(TIMESTOREH), DE
	LD	(TIMESTOREL), HL

	LD	HL, QUEUE_CMDBUF	; INITIALISE AUDIO BUFFERS
	LD	(QUEUE_CMD_WORK), HL
	RET

AUD_TIMERTICK:
	LD	BC, SYSGET_TIMER
	CALL_HBIOS	; DE:HL

	PUSH	HL
	PUSH	HL
	EXX
	LD	DE, (TIMESTOREL)	; D'E' = STOREL
	POP	HL			; H'L' = HL
	LD	(TIMESTOREL), HL	; STOREL = HL
	EXX
	EX	DE, HL			; HL = DE
	LD	DE, (TIMESTOREH)	; DE = STOREH
	POP	BC			; BC = HL
	LD	(TIMESTOREH), BC	; (TIMESTOREH) = HL (ORIGINAL)

	CALL	SUB

	EXX
	PUSH	HL
	EXX
	POP	HL		; HL = H'L' - DIFFERENCE OF TIME

	LD	B, L		; ONLY EXPECT SMALL NUMBERS?

STEP1:
	LD	A, B
	OR	A
	RET	Z

LOOP:
	CALL	AUD_TIMER
	DEC	B
	JR	NZ, LOOP
	RET


SOUND:
	LD	A, (SOUND_ENABLED)
	OR	A
	JR	NZ, SKIP1

	CALL	EXPRI			; Arg C (Channel)
	CALL	COMMA
	CALL	EXPRI			; Arg V (Volume) -15 loudest, 0 silent
	CALL	COMMA
	CALL	EXPRI			; Arg P (Pitch) 0 to 255
	CALL	COMMA
	CALL	EXPRI			; Arg D (Duration) -- ignored for moment
	JP	XEQ

SKIP1:
	CALL	EXPRI			; Arg C (Channel)
	EXX
	PUSH	HL
	LD	A, l

	CALL	COMMA
	CALL	EXPRI			; Arg V (Volume) -15 loudest, 0 silent
	EXX
	PUSH	HL

	CALL	COMMA
	CALL	EXPRI			; Arg P (Pitch) 0 to 255
	EXX
	PUSH	HL

	CALL	COMMA
	CALL	EXPRI			; Arg D (Duration) -- ignored for moment
	EXX

	CALL	GET_NXTBUFF		; LOAD IX WITH TABLE
	JP	NZ, ERROR		; TODO NEED TO BLOCK AND WAIT FOR DEQUE

	CALL	AUD_DURATION

	POP	HL
	LD	(IX + QUEUED_NOTE), L	;STORE NOTE REQUEST

	POP	HL
	LD	A, 0
	SUB	L
	AND	$0F
	LD	B, A
	RLCA
	RLCA
	RLCA
	RLCA
	OR	B
	LD	L, A			; Volume 0 - silent, 255 loudest
	LD	A, L			; STORE VOL AMOUNT
	LD	(IX + QUEUED_VOL), A

	POP	HL
	DEC	HL
	LD	D, L
	CALL	AUD_PLAY

	JP	XEQ

AUD_PLAY:
	LD	A, (IX + QUEUED_FLAGS)
	AND	AUD_BMPLAY | AUD_BMQUEUD
	JR	NZ, AUD_PLAY2

	LD	A, D
	LD	(IX + QUEUED_CHAN), A

	CALL	TST_PLAYING
	JR	NZ, AUD_PLAYNXT
	LD	(IX + QUEUED_FLAGS), AUD_BMQUEUD | AUD_BMALLOC
	RET

AUD_PLAYNXT:
	LD	B, BF_SNDVOL
	LD	C, 0
	LD	H, 0
	LD	A, (IX + QUEUED_VOL)
	LD	L, A
	CALL_HBIOS

	LD	B, BF_SNDNOTE
	LD	C, 0
	LD	L, (IX + QUEUED_NOTE)
	LD	H, 0
	LD	DE, 48			; ADJUST NOTE RANGE FOR HBIOS
	ADD	HL, DE
	CALL_HBIOS

	LD	B, BF_SNDPLAY
	LD	C, 0
	LD	D, (IX + QUEUED_CHAN)
	CALL_HBIOS

	LD	(IX + QUEUED_FLAGS), AUD_BMPLAY | AUD_BMALLOC
	RET

AUD_PLAY2:
	POP	IX
	OR	$FF
	RET

AUD_DURATION:
	;HL = HL * freq / 100
	LD	A, (TICKFREQ)		; TODO: LOSING ACCURACY - HANDLER 0, 1, ETC
	ld	C, A
	LD	DE, 0
	CALL	CENTSTOTICKS

	LD	(IX + QUEUED_DUR), L
	LD	(IX + QUEUED_DUR + 1), H
	LD	(IX + QUEUED_TAR), L
	LD	(IX + QUEUED_TAR + 1), H

	RET

; -------------------------------

GET_NXTBUFF:
	PUSH	HL
	PUSH	DE
	PUSH	BC

	LD	HL, (QUEUE_CMD_WORK)
	LD	B, QUEUED_CMD_CNT

GET_NXTBUFF1:
	LD	A, (HL)
	AND	AUD_BMACTIVE		; IS CURRENTLY USED
	JR	NZ, GET_NXTBUFF2

	LD	(QUEUE_CMD_WORK), HL
	LD	(HL), AUD_BMALLOC	; ALLOC THIS BUFFER - BUT NOT YET ACTIVE

	PUSH	HL
	POP	IX

	POP	BC
	POP	DE
	POP	HL
	XOR	A			; RETURN Z -- FREE BUFFER
	RET

GET_NXTBUFF2:
	CALL	AUD_BUFFER_INC
	DEC	B
	JR	NZ, GET_NXTBUFF1

	POP	BC
	POP	DE
	POP	HL
	OR	$FF			; NO FREE BUFFERS
	RET				; RETURN NZ


TST_PLAYING:				; IF CHANNEL IN A CURRENTLY PLAYING
					; SCAN BUFFER FOR THIS CHAN
	LD	HL, QUEUE_CMDBUF
	LD	DE, QUEUED_CMD_SIZE - 1
	LD	B, QUEUED_CMD_CNT
	LD	C, A

TST_PLAYING1:
	LD	A, (HL)
	INC	HL
	AND	AUD_BMPLAY
	JR	Z, TST_PLAYING2

					; TEST QUEUED_CHAN
	LD	A, (HL)
	CP	C
	JR	NZ, TST_PLAYING2
	RET				; RETURN Z - MATCH FOUND

TST_PLAYING2:
	ADD	HL, DE
	DEC	B
	JR	NZ, TST_PLAYING1
	OR	$FF			; RETURN NZ - MATCH NOT FOUND
	RET

AUD_BUFFER_INC:				; BUFFER POINTED AT BY HL, IS INCREMENT
					; AND WRAPPED IF REQUIRED
	PUSH	AF
	PUSH	BC
	PUSH	DE
	LD	BC, QUEUED_CMD_SIZE
	ADD	HL, BC
	PUSH	HL
	LD	DE, QUEUE_CMDBUFED
	OR	A                       ; CLEAR CARRY FLAG
	SBC	HL, DE
	JR	NC, AUD_WRAP_BUFFER
	POP	HL
	JR	AUD_BUFFER_INCRET

AUD_WRAP_BUFFER:
	POP	HL
	LD	HL, QUEUE_CMDBUF      ; RESTART AT START OF BUFFERS

AUD_BUFFER_INCRET:
	POP	DE
	POP	BC
	POP	AF
	RET

AUD_FINDNXT:				; IX NOTE JUST FINISHED
	LD	D, (IX + QUEUED_CHAN)
	PUSH	IX
	POP	HL
	LD	B, QUEUED_CMD_CNT - 1	; LOOP ALL BUT CURRENT ITEM

AUD_FINDNXT1:
	CALL	AUD_BUFFER_INC

	LD	A, (HL)
	AND	AUD_BMQUEUD
	JR	Z, AUD_FINDNXT2

	INC	HL
	LD	A, (HL)
	DEC	HL
	CP	D
	JR	NZ, AUD_FINDNXT2

	PUSH	HL
	POP	IX
	XOR	A			; RETURN Z - match
	RET

AUD_FINDNXT2:
	DEC	B
	JR	NZ, AUD_FINDNXT1
	OR	$FF			; NOT FOUND
	RET				; RETURN NZ

; Interrupt handler

AUD_TARNXT:
	LD	B, BF_SNDVOL
	LD	C, 0
	LD	H, 0
	LD	A, (IX + QUEUED_VOL)
	LD	L, A
	CALL_HBIOS

	LD	B, BF_SNDNOTE
	LD	C, 0
	LD	L, (IX + QUEUED_NOTE)
	LD	H, 0
	LD	DE, 48			; ADJUST NOTE RANGE FOR HBIOS
	ADD	HL, DE
	CALL_HBIOS

	LD	B, BF_SNDPLAY
	LD	C, 0
	LD	D, (IX + QUEUED_CHAN)
	CALL_HBIOS

	LD	L, (IX + QUEUED_TAR)		; NEED TO INCREASE DURATION BY 1
	LD	H, (IX + QUEUED_TAR + 1)	; TO KEEP SYNC WITH TIME CALCULATION.
	INC	HL				; THIS VALUE WILL BE DECEMENTED
	LD	(IX + QUEUED_TAR), L		; DURING THE COMPLETION OF THIS TIMER TICK
	LD	(IX + QUEUED_TAR + 1), H

 	LD      (IX + QUEUED_FLAGS), AUD_BMPLAY | AUD_BMALLOC
	RET

AUD_TARGET:					; DECREMENT TARGET TIME COUNT
						; IF 0 STOP SOUND - OR GOTO NEXT SOUND
	PUSH	DE
	PUSH	BC
	PUSH	IX

	LD	L, (IX + QUEUED_TAR)
	LD	H, (IX + QUEUED_TAR + 1)

	DEC	HL
	LD	(IX + QUEUED_TAR), L
	LD	(IX + QUEUED_TAR + 1), H
	LD	A, H
	OR	L
	JR	NZ, AUD_TARGET2

	LD	(IX + QUEUED_FLAGS), AUD_BMFREE

	CALL	AUD_FINDNXT			; INC IX TO NEXT NOTE TO PLAY ON THIS CHAN
	JR	NZ, AUD_TARGET1			; NONE FOUND, SO STOP SOUND

	CALL	AUD_TARNXT			; START PLAYING NEXT NOTE
	JR	AUD_TARGET2

AUD_TARGET1:					; TERMINATE SOUND
	LD	B, BF_SNDVOL
	LD	C, 0
	LD	H, 0
	LD	L, 0
	CALL_HBIOS

	LD	B, BF_SNDPLAY
	LD	C, 0
	LD	A, (IX + QUEUED_CHAN)
	LD	D, A
	CALL_HBIOS

AUD_TARGET2:
	POP	IX
	POP	BC
	POP	DE
	RET

AUD_TIMER:
	PUSH	HL
	PUSH	IX
	PUSH	DE
	PUSH	BC
	PUSH	AF

	LD	IX, QUEUE_CMDBUF
	LD	DE, QUEUED_CMD_SIZE
	LD	B, QUEUED_CMD_CNT

AUD_TIMER1:
	LD	A, (IX + QUEUED_FLAGS)
	AND	AUD_BMPLAY
	CALL	NZ, AUD_TARGET

	LD	DE, QUEUED_CMD_SIZE
	ADD	IX, DE
	DEC	B
	JR	NZ, AUD_TIMER1

skip:
	POP	AF
	POP	BC
	POP	DE
	POP	IX
	POP	HL
	RET				; OVERWRITTEN WITH NEXT HANDLER


