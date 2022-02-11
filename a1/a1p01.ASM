;Write and test a MASM program to Display your name and program title on the output screen.

.model small
.stack 100h
.data
    s1 db "Sayantan Biswas$"
    s2 db "a1p01$"
.code
    main proc
        mov ax,@data    ;Getting address of Data Segment   
        mov ds,ax       
        
        lea dx,s1   ;load s1
        mov ah,9
        int 21h
        
        mov ah,2
        mov dl,0dh  ;carriage return(\r)
        int 21h
        
        mov dl,0ah  ;line feed(\n)
        int 21h
        
        lea dx,s2   ;load s2
        mov ah,9
        int 21h
        
        mov ah,4ch  ;terminate program
        int 21h
    main endp
end
