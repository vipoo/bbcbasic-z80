;	TITLE	BBC BASIC (C) R.T.RUSSELL 1987
;
;BBC BASIC INTERPRETER - Z80 VERSION
;HARDWARE SOUND INTERFACE
;(C) COPYRIGHT  R.T.RUSSELL  1984
; extensions by Dean Netherton 2020

include "hbios.inc"
include "constants.inc"

SN76489_PORT_LEFT 	EQU	$00FC	; Ports for accessing the SN76489 Chip
SN76489_PORT_RIGHT 	EQU	$00F8

	PUBLIC	SOUND
	PUBLIC	SOUND_INIT

	EXTERN	EXPRI
	EXTERN	COMMA
	EXTERN	XEQ
	EXTERN	SOUND_ENABLED


SOUND_INIT:
	LD	B, BF_SYSGET
	LD	C, BF_SYSGET_SNDCNT
	RST	08

	LD	A, E
	LD	(SOUND_ENABLED), A
	RET

SOUND:
if !USE_HBIOS
	CALL	EXPRI			; Arg C (Channel)
	CALL	COMMA
	CALL	EXPRI			; Arg V (Volume) -15 loudest, 0 silent
	CALL	COMMA
	CALL	EXPRI			; Arg P (Pitch) 0 to 255
	CALL	COMMA
	CALL	EXPRI			; Arg D (Duration) -- ignored for moment

	RET				; Not supported
endif

	CALL	EXPRI			; Arg C (Channel)
	EXX
	LD	A, L
	DEC	A
	LD	D, A
	PUSH	DE			; Save channel

	CALL	COMMA ;
	CALL	EXPRI			; Arg V (Volume) -15 loudest, 0 silent
	EXX

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

	POP	DE			; Restore channel
	PUSH	DE

	LD	A, (SOUND_ENABLED)
	OR	A
	JR	Z, SKIP1

	LD	B, BF_SNDVOL		; Issue command to HBIOS
	LD	C, 0
	RST	HBIOS

SKIP1:
	CALL	COMMA
	CALL	EXPRI			; Arg P (Pitch) 0 to 255
	EXX
	LD	H, 0			; HL contains pitch 0 to 0xFF

	POP	DE			; restore channel
	PUSH	DE

	LD	A, (SOUND_ENABLED)
	OR	A
	JR	Z, SKIP2

	LD	B, BF_SNDNOTE		; Issue command to HBIOS
	LD	C, 0
	RST	HBIOS

SKIP2:
	CALL	COMMA
	CALL	EXPRI			; Arg D (Duration) -- ignored for moment
	EXX

	POP	DE			; restore channel

	LD	A, (SOUND_ENABLED)
	OR	A
	JR	Z, SKIP3

	LD	B, BF_SNDPLAY		; Issue command to HBIOS
	LD	C, 0
	RST	HBIOS

SKIP3:
	JP	XEQ
