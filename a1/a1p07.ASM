; Write and test a MASM program to validate second numbers is less than the first.

.MODEL SMALL
.STACK 100H
.DATA
    S1 DB 0AH,0DH,"Enter 1st number: $"
    S2 DB 0AH,0DH,"Enter 2nd number: $"
    S3 DB 0AH,0DH,"2nd number is less than 1st number$"
    S4 DB 0AH,0DH,"2nd number is greater than 1st number$"
    S5 DB 0AH,0DH,"Two numbers are equal$"
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        LEA DX,S1
        MOV AH,09H
        INT 21H
        
        MOV AH,01H
        INT 21H
        
        MOV BL,AL
        LEA DX,S2
        MOV AH,09H
        INT 21H
        
        MOV AH,01H
        INT 21H
        
        CMP BL,AL
        JG COND1
        JL COND2        
        LEA DX,S5
        MOV AH,09H
        INT 21H
        
        MOV AH,4CH
        INT 21H
        
        COND1:
            LEA DX,S3
            MOV AH,09H
            INT 21H
            MOV AH,4CH
            INT 21H
        
        COND2:
            LEA DX,S4
            MOV AH,09H
            INT 21H        
            MOV AH,4CH
            INT 21H
        MAIN ENDP
END