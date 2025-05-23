	ORG	0000H
	AJMP	MAIN             ; 開機跳轉到主程式

;===========================
; 串列中斷處理程式（地址0023H）
;===========================
	ORG	0023H
	JNB	RI, NON           ; 若未接收資料則跳過
	CLR	RI

RECEV:
	MOV	A, SBUF           ; 讀取接收到的資料
	
	CJNE A, #'1', CHK2
	CLR	P0.0
	AJMP RESP
CHK2:	CJNE A, #'2', CHK3
	SETB	P0.0
	AJMP RESP
CHK3:	CJNE A, #'3', CHK4
	CLR	P0.1
	AJMP RESP
CHK4:	CJNE A, #'4', OK
	SETB	P0.1
	AJMP RESP

RESP:	MOV	SBUF, P0         ; 回傳 P0 狀態
	AJMP	OK

NON:	CLR TI
OK:	RETI

;===========================
; 主程式起點
;===========================
MAIN:
	MOV	TMOD, #00100000B   ; Timer1，Mode 2，自動重載
	MOV	TH1, #232          ; 設定波特率約 1200 bps
	SETB	TR1               ; 啟動 Timer1

	MOV	SCON, #01110000B   ; 串列控制，模式1，允許接收
	CLR	RI
	CLR	TI
	SETB	ES                ; 開啟串列中斷
	SETB	EA                ; 開啟總中斷

;===========================
; 主迴圈：掃描按鍵矩陣
;===========================
LOOP:
	MOV	P1, #11111110B     ; 掃描第一列
	JNB	P2.0, KEY1
	JNB	P2.1, KEY2
	JNB	P2.2, KEY3
	JNB	P2.3, KEY4

	MOV	P1, #11111101B     ; 掃描第二列
	JNB	P2.0, KEY5
	JNB	P2.1, KEY6
	JNB	P2.2, KEY7
	JNB	P2.3, KEY8

	AJMP LOOP

;===========================
; 按鍵處理（設定P0位元）
;===========================
KEY1:	CLR	P0.0
	AJMP	TRANS
KEY2:	SETB	P0.0
	AJMP	TRANS
KEY3:	CLR	P0.1
	AJMP	TRANS
KEY4:	SETB	P0.1
	AJMP	TRANS
KEY5:	CLR	P0.2
	AJMP	TRANS
KEY6:	SETB	P0.2
	AJMP	TRANS
KEY7:	CLR	P0.3
	AJMP	TRANS
KEY8:	SETB	P0.3
	AJMP	TRANS

;===========================
; 傳送狀態到 UART
;===========================
TRANS:
	MOV	SBUF, P0           ; 傳送 P0 狀態
	AJMP	WAIT

;===========================
; 等待按鍵鬆開（防彈跳）
;===========================
WAIT:
	CALL DELAY
	MOV	A, P2
	CJNE	A, #11111111B, WAIT
	AJMP	LOOP

;===========================
; 軟體延遲副程式（約 0.1 秒）
;===========================
DELAY:
	MOV	R6, #250
DL1:	MOV	R7, #200
DL2:	DJNZ	R7, DL2
	DJNZ	R6, DL1
	RET

	END
