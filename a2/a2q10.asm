; Write and test a MASM program to print prime numbers between 1 to 100.
.model small
.stack 100
.data
    res db 3 dup(0)
    msg db "Primes from 1 to 100 : ",13,10,"$"
.code
main proc
mov ax,@data
mov ds,ax

lea dx,msg
mov ah,9
int 21h

mov dl,1
mov cx,25 ;total 25
l1:
   mov bl, 02
   add dl, 01h

   cmp dl, 02h
   je print
   cmp dl, 03h
   je print
   cmp dl, 04h
   jge Logic

    logic:
          mov ah, 00
          mov al, dl
          div bl
          cmp ah, 00
      je l1
          add bl, 01h
          cmp bl, al  
          jle Logic
      jmp print

    print:
       mov al, dl
       mov ah,00
       call output
       loop l1

    exit:
       mov ah, 4ch
       int 21h
    ret
main endp
        
output proc ;data is in ax as always
    push ax
    push bx
    push cx
    push dx
    mov cx,0
    mov bx,10
    mov si,offset res
loop1: 
       mov dx,0
       div bx
       add dl,30h
       push dx
       inc cx
       cmp ax,9
       jg loop1
     
       add al,30h
       mov [si],al
     
loop2: 
       pop ax
       inc si
       mov [si],al
       loop loop2    

    mov dl,res[0]
    mov ah,2
    int 21h

    mov dl,res[1]
    int 21h

    mov dl,32
    int 21h

    pop dx 
    pop cx
    pop bx
    pop ax
    ret
output endp 

end main