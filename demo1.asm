;PROGRAMA IMPRIMIR LETRA UN NUMERO DE VECES ESPECIFICO

org 100h
jmp start


msg1 db "dame un numero entero (0...9):", 24h 
msg2 db 0Ah, 0Dh, "dame una letra:", 24h

start:
    lea dx,msg1        ;poner msg 1 en pantalla
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    
    sub al,30h
    
    cmp al,0
    je stop
    
    mov cl,al
    
    lea dx,msg2
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    
    mov bl,al
    
    mov dl,0Ah
    mov ah,02h
    int 21h
    
    mov dl,0Dh
    mov ah,02h
    int 21h
    
    mov dl,bl
    
    
ciclo: 
    mov ah,02h
    int 21h
    
    loop ciclo
stop:
    
RET   
    
    




