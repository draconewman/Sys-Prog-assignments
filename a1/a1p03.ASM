;Write and test a MASM program to add two Hexadecimal Numbers

.MODEL SMALL
.STACK 100H
.DATA 
    L1 db 13,10,"Enter the 1st number: $"
    L2 db 13,10,"Enter the 2nd number: $"
    L3 db 13,10,"The result after addition is: $"

.CODE
   MAIN PROC
          MOV AX,@DATA                         
          MOV DS,AX
                    
          XOR BX,BX      ;set BX value to 0
          MOV CL,4      
          
          LEA DX, L1     ;show L1
          MOV AH, 9
          INT 21H

          MOV AH,1       ;for taking input
          INT 21H
      
      
      INPUT1:
          CMP AL,0DH     ;compare whether the pressed key is 'ENTER' or not
          JE LINE1       ;If it is equal to 'Enter' then stop taking first value. JE = Jump if equal
         
          CMP AL,39H     ;compare the input whether it is letter or digit. 39h is the ascii value of 9
          JG LETTER1     ;JG = Jump if greater or equal
          
          AND AL,0FH     ;if it is digit then convert it's ascii value to real value, clear the high-order bits to zero
          JMP SHIFT1
          
      LETTER1:           ;if it is letter then subtract 37h from it to find it's real value. 41h is the ASCII code for a letter 'A', (41h - 10d) = (41h - 0Ah) = 37h
          SUB AL,37h
       
      SHIFT1:
          SHL BX, CL     ;shift the bits left
          OR  BL,AL      ;making 'or' to add the current value with previous value
          
          INT 21H
          JMP INPUT1
      
      LINE1:
          LEA DX, L2      ;show L2
          MOV AH, 9
          INT 21H

          XOR DX,DX       ;set DX value zero

          MOV AH,1
          INT 21H

      
      INPUT2:
          CMP AL,0DH      ;compare whether the pressed key is 'ENTER' or not
          JE LINE2        ;If it is equal to 'Enter' then stop taking first value. JE = Jump if equal
         
          CMP AL,39H      ;compare the input whether it is letter or digit. 39h is the ascii value of 9
          JG LETTER2      ;JG = Jump if greater or equal
          
          AND AL,0FH      ;if it is digit then convert it's ascii value to real value, clear the high-order bits to zero
          JMP SHIFT2
          
      LETTER2:            ;if it is letter then subtract 37h from it to find it's real value. 41h is the ASCII code for a letter 'A', (41h - 10d) = (41h - 0Ah) = 37h
          SUB AL,37H
       
      SHIFT2:
          SHL DX, CL
          OR  DL,AL       ;making 'or' to add the current value with previous value
            
          INT 21H
          JMP INPUT2
      LINE2:
          XOR CX,CX
          MOV CX,DX

          MOV DH,16
      
      SUM:
          ADD BX,CX       ;add two number which are stored in BX and CX register
          JC PC1          ;if the register is overflowed then print an extra 1

          mov cl, 4
      
          LEA DX, L3      ;show L3
          MOV AH, 9
          INT 21H

      OUTPUT:             ;for printing the sum
          
          MOV CH,BH
          SHR CH, CL
          AND CH,0FH

          CMP CH,10       ;convert decimal to binary
          ADD CH,48
          CMP CH,':'
          JL TAG          ;Jump to Label
          ADD CH,7
      
      TAG:                ; 4 Tags for 4 digit display
          MOV DL,CH
          MOV AH,2
          INT 21H

          MOV CH,BH
          AND CH,0FH
          CMP CH,10
          ADD CH,48
          CMP CH,':'
          JL TAG1
          ADD CH,7
      
      TAG1:
          MOV DL,CH
          MOV AH,2
          INT 21H

          MOV CH,BL
          SHR CH, CL
          AND CH,0FH
          CMP CH,10
          ADD CH,48
          CMP CH,':'
          JL TAG2
          ADD CH,7
      
      TAG2:
          MOV DL,CH
          MOV AH,2
          INT 21H

          MOV CH,BL
          AND CH,0FH
          CMP CH,10
          ADD CH,48
          CMP CH,':'
          JL TAG3
          ADD CH,7
      
      TAG3:
          MOV DL,CH
          MOV AH,2
          INT 21H

          JMP EXIT
      
      PC1:               ;for printing overflowed 1
          MOV DL,'1'
          MOV AH,2
          INT 21H
          JMP OUTPUT
      
      EXIT:
          MOV AH, 4CH    
          INT 21H
        
    MAIN ENDP
   END MAIN