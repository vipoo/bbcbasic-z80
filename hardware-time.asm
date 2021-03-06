;	TITLE	BBC BASIC (C) R.T.RUSSELL 1987
;
;BBC BASIC INTERPRETER - Z80 VERSION
;HARDWARE SOUND INTERFACE
;(C) COPYRIGHT  R.T.RUSSELL  1984
; extensions by Dean Netherton 2020

include "hbios.inc"
include "constants.inc"

	PUBLIC	GETIME
	PUBLIC	PUTIME
	PUBLIC 	DEHL_TO_INT
	PUBLIC 	INT_TO_DEHL
	PUBLIC	TICKSTOCENTS
	PUBLIC	CENTSTOTICKS

	EXTERN	FMUL
	EXTERN	FDIV
	EXTERN	INT
	EXTERN	SFLOAT
	EXTERN	COPY
	EXTERN	SWAP
	EXTERN	TIMESTOREL
	EXTERN	TICKFREQ

; Read elapsed-time clock.
;	Outputs: DEHL = elapsed time (centiseconds)
;	Destroys: A,D,E,H,L,F
GETIME:
	LD	BC, SYSGET_TIMER
	CALL_HBIOS	; DE:HL
	JP	TICKSTOCENTS

; Load elapsed-time clock.
;	Inputs: DEHL = time to load (centiseconds)
; 	Destroys: A,D,E,H,L,F
PUTIME:
	LD	A, (TICKFREQ)
	LD	C, A
	CALL	CENTSTOTICKS

	LD	BC, SYSSET_TIMER
	CALL_HBIOS
	RET

; TRANSLATE SYSTIME TICKS TO 100TH SECONDS TICKS
; FREQUENCY IN C
TICKSTOCENTS:
	PUSH	BC		; CAPTURE TICK FREQUENCY
	CALL	DEHL_TO_INT
	CALL	SFLOAT
	CALL	COPY		; DED'E'B = HLH'L'C

	EXX
	POP	HL
	LD	H, 0		; RESTORE TICK FREQUENCY
	EXX
	LD	HL, 0
	LD	C, 0
	CALL	SFLOAT

	CALL	SWAP
	CALL	FDIV
	CALL	COPY		; DED'E'B = HLH'L'C

	EXX
	LD	HL, 100		; MULT BY 100
	EXX
	LD	HL, 0
	LD	C, 0
	CALL	SFLOAT
	CALL	FMUL
	CALL	INT

	JP	INT_TO_DEHL

CENTSTOTICKS:
	PUSH	BC		; STORE FREQ
	CALL	DEHL_TO_INT
	CALL	SFLOAT
	CALL	COPY		; DED'E'B = HLH'L'C

	EXX
	LD	HL, 100		; DIVIDE BY 100
	EXX
	LD	HL, 0
	LD	C, 0
	CALL	SFLOAT

	CALL	SWAP
	CALL	FDIV
	CALL	COPY		; DED'E'B = HLH'L'C

	EXX
	POP	HL		; RESTORE FREQ
	LD	H, 0
	EXX
	LD	HL, 0
	LD	C, 0
	CALL	SFLOAT
	CALL	FMUL
	CALL	INT
	JP	INT_TO_DEHL
;
; CONVERT 32 BIT INT IN DE:HL TO HLH'L'C
DEHL_TO_INT:
	PUSH	HL
	EX	DE, HL
	EXX
	POP	HL
	EXX
	LD	C, 0
	RET

;
; CONVERT 32 BIT INT IN HLH'L'C TO DE:HL
INT_TO_DEHL:
	EXX
	PUSH	HL
	EXX
	EX	DE, HL
	POP	HL
	RET