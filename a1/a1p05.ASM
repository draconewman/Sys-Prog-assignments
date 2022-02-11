; Write and test a MASM program to display a terminating message

.MODEL SMALL
.STACK 100H

.DATA
  S1 DB 'Press Enter to terminate the program$'
  S2 DB 'Terminating...$'
 
.CODE
  MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX, S1
    MOV AH,9
    INT 21H

    MOV AH,1
    INT 21H

    MOV BL,AL

    MOV AH,2
    MOV DL,0DH
    INT 21H

    MOV DL,0AH
    INT 21H

    LEA DX, S2
    MOV AH,9
    INT 21H

    MOV AH,4CH
    INT 21H
  MAIN ENDP
END MAIN
