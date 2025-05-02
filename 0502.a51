	ORG	0000H
;
LOOP: MOV   P1, #11111110B  
	JNB   P2.0, SOL      ; 0鍵是否閉合？
	JNB   P2.1, LAL      ; 1鍵是否閉合？
	JNB   P2.2, SIL      ; 2鍵是否閉合？
	JNB   P2.3, DO      ; 3鍵是否閉合？
;
      MOV   P1, #11111101B  ;
      JNB   P2.0, RE      ; 4鍵是否閉合？
      JNB   P2.1, MI      ; 5鍵是否閉合？
      JNB   P2.2, FA      ; 6鍵是否閉合？
      JNB   P2.3, SO      ; 7鍵是否閉合？
;
      MOV   P1, #11111011B  ;
      JNB   P2.0, LA      ; 8鍵是否閉合？
      JNB   P2.1, SI      ; 9鍵是否閉合？
      JNB   P2.2, DOH      ; A鍵是否閉合？
      AJMP	LOOP
;

SOL:   MOV   P1, #170
        AJMP  OUTPUT
LAL:   MOV   P1, #150
        AJMP  OUTPUT
SIL:   MOV   P1, #134
        AJMP  OUTPUT
DO:   MOV   P1, #126
        AJMP  OUTPUT
RE:   MOV   P1, #113
        AJMP  OUTPUT
MI:   MOV   P1, #100
        AJMP  OUTPUT
FA:   MOV   P1, #95
        AJMP  OUTPUT
SO:   MOV   P1, #85
        AJMP  OUTPUT
LA:   MOV   P1, #75
        AJMP  OUTPUT
SI:   MOV   P1, #67
        AJMP  OUTPUT
DOH:	MOV   P1, #63
        AJMP  OUTPUT
;

OUTPUT: CLR	P2.6
	ACALL	DELAY
	SETB	P2.6
	ACALL	DELAY
	AJMP LOOP
;

DELAY: MOV	B,P1
DL:	MOV	R7,#6
	DJNZ	R7,$
	DJNZ	R6,DL
	MOV	R6,B
	RET
;
	END

