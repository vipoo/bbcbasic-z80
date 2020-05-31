

#ifdef TRACING

	EXTERN	PRTSTRD
	EXTERN	PRTHEXWORDHL
	EXTERN	PRTHEX

#define DEBUG(S) 	CALL	PRTSTRD 		!
			defm	S 			!
			defb	'$'

#define TRACE_HL	CALL	PRTHEXWORDHL
#define TRACE_IX	PUSH 	HL 			!
			PUSH	IX			!
			POP	HL			!
			CALL	PRTHEXWORDHL		!
			POP	HL

#define TRACE_DE	PUSH 	HL 			!
			PUSH	DE			!
			POP	HL			!
			CALL	PRTHEXWORDHL		!
			POP	HL

#define TRACE_D		PUSH	AF 			!
			LD	A, D 			!
			CALL	PRTHEX 			!
			POP	AF

#define TRACE_C		PUSH	AF 			!
			LD	A, C 			!
			CALL	PRTHEX 			!
			POP	AF

#define TRACE_B		PUSH	AF 			!
			LD	A, B 			!
			CALL	PRTHEX 			!
			POP	AF

#define TRACE_A		CALL	PRTHEX

#else

#define DEBUG(S)
#define TRACE_HL
#define TRACE_D
#define TRACE_A
#define TRACE_C

#endif
