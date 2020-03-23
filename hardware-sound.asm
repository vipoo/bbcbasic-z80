;	TITLE	BBC BASIC (C) R.T.RUSSELL 1987
;
;BBC BASIC INTERPRETER - Z80 VERSION
;HARDWARE SOUND INTERFACE
;(C) COPYRIGHT  R.T.RUSSELL  1984
; extensions by Dean Netherton 2020

include "config.inc"
include "constants.inc"

SN76489_PORT_LEFT 	EQU	$00FC	; Ports for accessing the SN76489 Chip
SN76489_PORT_RIGHT 	EQU	$00F8

SOUND_CMD_TONE_1:	DEFB	0
SOUND_CMD_TONE_2:	DEFB	0
SOUND_VOLUMN_CMD:	DEFB	0

	PUBLIC	SOUND
	EXTERN	EXPRI
	EXTERN	COMMA
	EXTERN	XEQ



SOUND:
if !USE_HBIOS
	CALL	EXPRI			; Arg C (Channel)
	CALL	COMMA ;
	CALL	EXPRI			; Arg V (Volume) -15 loudest, 0 silent
	CALL	COMMA
	CALL	EXPRI			; Arg P (Pitch) 0 to 255
	CALL	COMMA
	CALL	EXPRI			; Arg D (Duration) -- ignored for moment

	RET				; Not supported
endif

	CALL	EXPRI			; Arg C (Channel)
	EXX
	LD	D, L
	PUSH	DE			; Save channel

	CALL	COMMA ;
	CALL	EXPRI			; Arg V (Volume) -15 loudest, 0 silent
	EXX
	LD	A, L
	ADD	$F
	AND	$F
	RLCA
	RLCA
	RLCA
	RLCA
	POP	DE
	LD	E, A			; Volume 0 - silent, 255 loudest
	PUSH	DE

	LD	B, BF_SNDVOL		; Issue command to HBIOS
	LD	C, 0
	RST	HBIOS

	CALL	COMMA
	CALL	EXPRI			; Arg P (Pitch) 0 to 255
	EXX
	LD	A, L
	LD	H, A
	LD	L, 0			; HL contains pitch 0 to 0xFFFF

	POP	DE			; restore channel

	LD	B, BF_SNDPIT		; Issue command to HBIOS
	LD	C, 0
	RST	HBIOS

	CALL	COMMA
	CALL	EXPRI			; Arg D (Duration) -- ignored for moment

	JP	XEQ
