	ORG 0000H
START: 	MOV P0,#00100100B
		ACALL DELAY_2S
	

		MOV R0,#4
STATE2:	MOV P0,#00100010B
		ACALL DELAY_200MS
		MOV P0,#00100000B
		ACALL DELAY_200MS
		DJNZ R0,STATE2
	
		MOV P0,#10000001B
		ACALL DELAY_2S


		MOV R0,#4
STATE3:	MOV P0,#01000001B
		ACALL DELAY_200MS
		MOV P0,#00000001B
		ACALL DELAY_200MS	
		DJNZ R0,STATE3

		SJMP START

DELAY_200MS: MOV R2,#250
D200_LOOP1:	 MOV R1,#250
D200_LOOP2:	 DJNZ R1,D200_LOOP2
		 DJNZ R2,D200_LOOP1
		 RET

DELAY_2S:	 MOV R3,#10

D2_LOOP:	 ACALL DELAY_200MS
		 DJNZ R3,D2_LOOP
		 RET