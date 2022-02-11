;Write and test a MASM program to convert a letter from uppercase to lowercase
.model small
.stack 100h
.data  
.code
    main proc
        mov ah,01h  ;Takes only one character from user. The input is taken in reg AL
        int 21h
        
        add al,32
        mov bl,al
        
        mov dl,0ah  ;line feed       
        
        mov ah,02h  ;Displays only single character whose ASCII value is in DL reg
        int 21h
        
        mov dl,0dh  ;carriage return
        mov ah,02h
        int 21h
        
        mov dl,bl
        mov ah,02h
        int 21h
        
        mov ah,4ch
        int 21h
    main endp
end