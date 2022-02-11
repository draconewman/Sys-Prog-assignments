; Write and test a MASM program to Take a character from the keyboard and print it.

.MODEL SMALL
.STACK 100H
.DATA
.CODE
    MAIN PROC
        MOV AH,01H
        INT 21H
        
        MOV BL,AL
        MOV DL,0AH
        MOV AH,02H
        INT 21H
        
        MOV DL,0DH
        MOV AH,02H
        INT 21H
        
        MOV DL,BL
        MOV AH,02H
        INT 21H
        
        MOV AH,4CH
        INT 21H
    MAIN ENDP
END