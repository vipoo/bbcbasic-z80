stksiz	equ	$10		; Working stack size
restart	equ	$0000		; CP/M restart vector
bdos	equ	$0005		; BDOS invocation vector

include "consts.inc"

IFNDEF __LISTEND
DEFC __LISTEND=0
ENDIF

IFNDEF __LIST1
DEFC __LIST1=0
ENDIF

	PUBLIC CONST_LIST1
	PUBLIC CONST_LISTEND
	ORG	100H

;	phase	$1000
	LD	sp, stack		; set new stack
	LD	HL, __LISTEND - __LIST1
	ld	a, H
	call	prthex
	ld	a, L
	call	prthex
	CALL	crlf			; formatting

	LD	HL, HELLO
	CALL	prtstrz
	CALL	crlf			; formatting

	;LD	sp, (stksav)		; restore stack

	JP	restart				; return to CP/M

;===============================================================================
; Print character in A without destroying any registers

prtchr:
	PUSH	bc			; save registers
	PUSH	de
	PUSH	hl
	LD	e, a			; character to print in E
	LD	c, $02			; BDOS function to output a character
	CALL	bdos			; do it
	POP	hl			; restore registers
	POP	de
	POP	bc
	RET

;===============================================================================
; Print a $ terminated string at (HL) without destroying any registers
prtstrz:
	LD	a, (hl)			; get next char
	INC	hl
	CP	'$'
	RET	z
	CALL	prtchr
	JR	prtstrz

;===============================================================================
; Print the value in A in hex without destroying any registers

prthex:
	PUSH	af			; save AF
	PUSH	de			; save DE
	CALL	hexascii		; convert value in A to hex chars in DE
	LD	a, d			; get the high order hex char
	CALL	prtchr			; print it
	LD	a, e			; get the low order hex char
	CALL	prtchr			; print it
	POP	de			; restore DE
	POP	af			; restore AF
	RET				; done

;===============================================================================
; Convert binary value in A to ascii hex characters in DE

hexascii:
	LD	d, a			; save A in D
	CALL	hexconv			; convert low nibble of A to hex
	LD	e, a			; save it in E
	LD	a, d			; get original value back
	RLCA				; rotate high order nibble to low bits
	RLCA
	RLCA
	RLCA
	CALL	hexconv			; convert nibble
	LD	d, a			; save it in D
	RET				; done

;===============================================================================
; Convert low nibble of A to ascii hex

hexconv:
	AND	$0F	     		; low nibble only
	ADD	a, $90
	DAA
	ADC	a, $40
	DAA
	RET

;===============================================================================
; Start a new line

crlf:
	LD	a, 13			; <CR>
	CALL	prtchr			; print it
	LD	a, 10			; <LF>
	JR	prtchr			; print it



stksav:		DEFW	0		; stack pointer saved at start
		DEFS	stksiz	; stack
stack:		EQU	ASMPC		; stack top

	DEFS	4

CONST_LIST1:	DEFB	1
	DEFB	2
	DEFB	3
	DEFB	4
	DEFB	6
	DEFB	7
	DEFB	8

CONST_LISTEND:
;DEFC	LIST1L = CONST_LISTEND - CONST_LIST1
HELLO:	DEFM	"HELLO$", 0, 0, 0, 0

	;dephase