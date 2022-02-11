;write And Test A Masm Program To Loop Until The User Decides To Quit

.MODEL SMALL
.STACK 100H

.DATA
S1 DB 10,13,"Enter Q to quit or any other to continue loop: $"
S2 DB 10,13,"LOOP$"

.CODE

MAIN PROC

	MOV AX,@DATA
	MOV DS,AX

	LABEL1:
		LEA DX,S2
		MOV AH,09H
		INT 21H

		LEA DX,S1
		MOV AH,09H
		INT 21H

		MOV AH,01H ;accept a character
		INT 21H

		CMP AL,'Q' ;check if chacracter is Q, (uppercase)
		JNE LABEL1

	MOV AH,4CH
	INT 21H
MAIN ENDP
END MAIN