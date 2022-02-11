; Write and test a MASM program to Print all the characters from A-Z.

.MODEL SMALL
.STACK 100H
.DATA
    SPACE DB ' '
.CODE 
MAIN PROC	
	MOV AX,@DATA
	MOV DS,AX

	MOV BX,65   ;ascii A
	MOV CX,0

	LABEL1: 
		MOV AH,02H  ;print A-Z
		MOV DL,BL
		INT 21H
 
		MOV AH,02H  ;print spaces
		MOV DL,SPACE
		INT 21H

		INC BX      
		INC CX
		CMP CX,26   ;compare if space count is 26		
	JNE LABEL1

	MOV AH,4CH
	INT 21H
MAIN ENDP
END