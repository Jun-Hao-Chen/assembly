;E1406
;
	ORG	0000H
	AJMP	MAIN
;========================
;  	串列中斷服務程式
;========================
	ORG	0023H
	JNB	RI,NON
	CLR	RI
	MOV	P0,SBUF
	AJMP	OK
NON:	CLR TI
OK:	RETI
;========================
;  	主程式
;========================
MAIN:	MOV	TMOD,#00100000B
	MOV	TH1,#232
	MOV	TL1,#232
	SETB	TR1
;========================
;  	設定串列工作模式
;========================
	MOV	SCON,#01110000B
	CLR	RI
	CLR	TI
	SETB 	ES
	SETB	EA
LOOP:	
	MOV	P1,#11111101B
	JNB	P2.0,TRANS
	JNB	P2.1,TRANS
	JNB	P2.2,TRANS
	JNB	P2.3,TRANS
	AJMP	LOOP
TRANS:	MOV	SBUF,P1
WAIT:	CALL 	DELAY
	MOV	A,P1
	CJNE	A,#11111111B,WAIT
	AJMP	LOOP

;========================
;	延時副程式
;========================
;延時0.1秒
DELAY:	MOV	R6,#250
DL1:	MOV	R7,#200
DL2:	DJNZ	R7,DL2
	DJNZ	R6,DL1
	RET
;
	END

