#ifdef TRACING

#define DEBUG(S) 	CALL	PRTSTRD \
			defm	S \
			defb	'$'
#else

#define DEBUG(S)

#endif
