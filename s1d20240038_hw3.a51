
	ORG	0000H


LOOP: JNB	P2.0,CASE1
	JNB	P2.1,CASE2
	JNB	P2.2,CASE3
	JNB	P2.3,CASE4
	AJMP	LOOP

CASE1: MOV	P0,#00001111B
	 AJMP	LOOP
CASE2: MOV	P0,#11110000B
	 AJMP	LOOP
CASE3: MOV	P0,#11111111B
	 AJMP	LOOP
CASE4: MOV	P0,#00000000B
	 AJMP	LOOP
;
	END
