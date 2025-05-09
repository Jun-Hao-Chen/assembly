	ORG	0000H
	AJMP MAIN
;

	ORG     0003H               ; �~�����_ 0 �V�q�]INT0�^
        PUSH    P1                  ; �O�s SFR P1
        PUSH    07h                 ; �O�s R7
        PUSH    06h                 ; �O�s R6
        PUSH    05h                 ; �O�s R5
        PUSH    04h                 ; �O�s R4
        PUSH    03h                 ; �O�s R3

        MOV     R3, #3              ; 3 ���{�{�p��


ALARM: MOV	P0, #00000000B
	ACALL DELAY
	MOV	P0, #11111111B
	ACALL DELAY
	DJNZ	R5,ALARM
;
	ACALL   DELAY
;
	 MOV     P0, #00000000B
        ACALL   DELAY
        MOV     P0, #11111111B
        ACALL   DELAY
	
	 POP     03h
        POP     04h
        POP     05h
        POP     06h
        POP     07h
        POP     P1
;
	RETI
;

MAIN:	SETB	P3.2
	SETB	IT0
	SETB	EX0
	SETB	EA
;
LOOP:	MOV	P0, #00001111B
	ACALL	DELAY
	MOV	P0, #11110000B
	ACALL DELAY
	AJMP LOOP
;

DELAY: MOV	R6,#250
DL1:	 MOV	R7,#200
DL2:	DJNZ	R7,DL2
	DJNZ	R6,DL1
	RET
;
	END
	
