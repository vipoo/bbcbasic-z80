
QUEUED_CMD	EQU	0
QUEUED_FLAGS	EQU	0
QUEUED_CHAN	EQU	1		; 1 byte for channel - top bit indicates currently playing/or queued for playing
QUEUED_VOL	EQU	2		; 1 byte for vol
QUEUED_NOTE	EQU	3		; 1 byte for NOTE
QUEUED_DUR	EQU	4		; 2 byte for duration
QUEUED_TAR	EQU	6		; 2 byte for target time
QUEUED_CMD_SIZE	EQU	8

QUEUED_CMD_CNT	EQU	16			; MAX NUMBER OF QUEUED COMMANDS

AUD_BFFREE	EQU	0			; IF ALL BITS UNSET - BUFFER IS FREE
AUD_BFALLOC	EQU	1			; BUFFER HAS BEEN CLAIMED FOR USE.  		NEXT STATE -> AUD_BFPLAY OR AUD_BFQUED
AUD_BFPLAY	EQU	2			; BUFFER IS ALLOCATED AND PLAYING NOW. 		NEXT STATE -> AUD_BFFREE
AUD_BFQUED	EQU	3			; BUFFER IS ALLOCATED AND WAITING TO PLAY	NEXT STATE -> AUD_BFPLAY

AUD_BMFREE	EQU	$00
AUD_BMALLOC	EQU	$01			; AUD_BFALLOC
AUD_BMACTIVE	EQU	$06			; AUD_BFPLAY | AUD_BFQUED
AUD_BMPLAY	EQU	$02			; AUD_BFPLAY
AUD_BMQUEUD	EQU	$04			; AUD_BFQUED

BEL	EQU	7
BS	EQU	8
HT	EQU	9
LF	EQU	0AH
VT	EQU	0BH
CR	EQU	0DH
ESC	EQU	1BH
DOUBLE_QUOTE	EQU	'"'
