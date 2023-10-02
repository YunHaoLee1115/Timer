;�|�ӫ��s���O��	+  -  �T�{ RESET
;�e�|�ӿO��mode1~4
;=======================================

		ORG	0000H ;�D�{���q0000�}�l

		MOV	P1,#11111110B		
		MOV	R0,#00000001B

;===============�]�w�ɶ�========================

MODE1:	MOV	P0,#10000000B 	;�Ҧ����:���b�]�w�������Q���
		MOV	R1,#00000000B	  ;��l�Ƭ�0�A�H�U�ϥΪ̶}�l�]�w�Ʀr

SET1:		MOV	A,#10000000B  ;�ܼ�A�C������s��1000 0000
		ADD	A,R1		;�N�O��A�PR1(�ϥΪ̳]�w���Ʀr)�ۥ[�A�è��NA�쥻�Ҧs���ܼ�
		MOV	P0,A		;�NA��X��O(P0)�W�A���ɦ���mode1���O���H�ΨϥΪ̩ҳ]�w���ܼ�(�G�i�����)

		ACALL	DELAY2

		JNB	P2.0,KEY00	;�Y���U�̥��䪺���sR1�[�@
		JNB	P2.1,KEY01	;�Y���U����ƹL�ӲĤG�����sR1��@
		JNB	P2.2,MODE2	;�Y���U�ĤT�������mode2
		JNB	P2.3,MODE1
		AJMP	SET1		;�p�G�S���U�A�h���^set1���~�򵥫ݨϥΪ̾ާ@

MODE2:	MOV	P0,#01000000B ;�Ҧ����:���b�]�w�������Ӧ��
		MOV	R2,#00000000B

SET2:		MOV	A,#01000000B
		ADD	A,R2
		MOV	P0,A	

		ACALL	DELAY2

		JNB	P2.0,KEY02
		JNB	P2.1,KEY03
		JNB	P2.2,MODE3
		JNB	P2.3,MODE1

		AJMP	SET2

MODE3:	MOV	P0,#00100000B ;�Ҧ����:���b�]�w���Q���
		MOV	R3,#00000000B

SET3:		MOV	A,#00100000B
		ADD	A,R3
		MOV	P0,A	

		ACALL	DELAY2

		JNB	P2.0,KEY04
		JNB	P2.1,KEY05
		JNB	P2.2,MODE4
		JNB	P2.3,MODE1

		AJMP	SET3

MODE4:	MOV	P0,#00010000B ;�Ҧ����:���b�]�w���Ӧ��
		MOV	R4,#00000000B

		

SET4:		MOV	A,#00010000B
		ADD	A,R4
		MOV	P0,A	

		ACALL	DELAY2

		JNB	P2.0,KEY06
		JNB	P2.1,KEY07
		JNB	P2.2,START ;���U�T�{��}�l�˼ƭp��
		JNB	P2.3,MODE01

		AJMP	SET4

;============������================

MODE01:	AJMP	MODE1

KEY00:	AJMP 	KEY0
KEY01:	AJMP 	KEY1
KEY02:	AJMP 	KEY2
KEY03:	AJMP 	KEY3
KEY04:	AJMP 	KEY4
KEY05:	AJMP 	KEY5
KEY06:	AJMP 	KEY6
KEY07:	AJMP 	KEY7

;=============�}�l�˼�=====================================
;----------�P�_��J�O�_��0-----------
START:	MOV	P0,#11110000B	;�e�|�ӿO�{�{�N��b�˼�
	
		INC	R4		
		DJNZ	R4,SEC2
START01:	INC	R3
		DJNZ	R3,SEC1
START02:	INC	R2
		DJNZ	R2,MIN2
START03:	INC	R1
		DJNZ	R1,MIN1
		
		AJMP	TOUT	
	
;------------------��Ӧ��----------------
		
SEC2:		ACALL	DELAY1	;�@����
		DJNZ	R4,SEC2 	;�˼�DELAY�@�����@��A�@�˼�R4�Ӥ@��

		AJMP	START01

;------------------��Q���-----------------

SEC1:		MOV	R5,#10	;�˼�R3��10��
DL1:		ACALL	DELAY1	;�@����
		DJNZ	R5,DL1	
		DJNZ	R3,SEC1

		AJMP	START02
	
;------------------���Ӧ��----------------

MIN2:		MOV	R5,#60	;�˼�R2��60��  ;�@����60��
DL2:		ACALL	DELAY1 	;�@����
		DJNZ	R5,DL2
	
		AJMP	START03

;-----------------���Q���------------------

MIN1:		MOV	R5,#60	;�˼�R1��600��  ;�Q����600��	;�]����600�|����A�ҥH�60*10
DL3:		MOV	R6,#10	;�Q����600��
DL4:		ACALL	DELAY1 	;�@����
		DJNZ	R6,DL4			
		DJNZ	R5,DL3	
		DJNZ	R1,MIN1

;=============�ɶ���===================

TOUT:		MOV	P0,#00000000B ;�ɶ��� �{�{�O
		ACALL	DELAY1
		MOV	P0,#11111111B
		ACALL	DELAY1
		JNB	P2.2,MODE01   ;���U�T�{�� �^��mode1���s�]�w�ɶ�
		AJMP	TOUT          ;�Ϊ̬O�H��Ĳ�o���_�]��^��mode1	

;==========���s�ʧ@================
KEY0:		INC	R1	;R1+1
		AJMP	SET1
KEY1:		DEC	R1	;R1-1
		AJMP	SET1
KEY2:		INC	R2
		AJMP	SET2
KEY3:		DEC	R2
		AJMP	SET2
KEY4:		INC	R3
		AJMP	SET3
KEY5:		DEC	R3
		AJMP	SET3
KEY6:		INC	R4
		AJMP	SET4
KEY7:		DEC	R4
		AJMP	SET4

;============DELAY============
;----------1------------
DELAY1:	PUSH	05
		PUSH	06
		PUSH	07

		MOV	R5,#1	;10*0.1��=1��
D1:		MOV	R6,#250	
D2:		MOV	R7,#200
D3:		DJNZ	R7,D3
		DJNZ	R6,D2
		DJNZ	R5,D1

		POP	07
		POP	06
		POP	05
		
		RET

;----------2-----------
DELAY2:	PUSH	05
		PUSH	06
		PUSH	07

		MOV	R5,#1	;10*0.1��=1��
D4:		MOV	R6,#250
D5:		MOV	R7,#250
D6:		DJNZ	R7,D6
		DJNZ	R6,D5
		DJNZ	R5,D4

		POP	07
		POP	06
		POP	05

		RET