;David Ceballos Mata
;Ana Camila Lopez Sanchez 
 
;Programa que lee caracter del teclado y se imprime n veces. 

org 100h
jmp start
       
msg1 db "Captura: $"            ;db datatype, el $ sirve para detener el mensaje
msg2 db 0Ah,0Dh, "Veces: $"     ;0Ah line feed, baja a la siguiente linea
msg3 db 0Ah,0Dh, "Resultado: $"  ;0Dh Carriage return, Regresa al inicio de la linea
char db 0                       ; almacenar caracter y numero de repeticiones, ambos incializados en cero
numVeces db 0

start:
    lea dx, msg1                ;direccion de memoria del mensaje 1
    mov ah, 09h                 ;imprime en pantalla la cadena 
    int 21h                     ;muestra el msj y espera a que se presione una tecla
    
    mov ah, 01h                 ;lee el caracter con eco, es decir, lo muestra en pantalla
    int 21h  
    mov char, al                ;mueve el caracter leido a la variale char
    
    lea dx, msg2                ;direccion de memoria del mensaje 2
    mov ah, 09h                 ;imprimir
    int 21h                     ;espera input
    
    mov ah, 01h                 
    int 21h                     
    sub al, "0"                 ;convierte el ascci a num real, ej. 5 (35h) - 0 (30h) = 5
    mov numVeces, al            ;guarda el input a la variable numVeces
    
    lea dx, msg3
    mov ah, 09h                 
    int 21h
    
    mov cl, numVeces            ;carga el num de repeticiones desde cl
    mov ah, 02h                 ;mueve ah a 02h, funcion para imprimir caracter                 
    
imprimir:
    mov dl, char                ;se coloca el caracter en dl 
    int 21h                     ;imprime
    loop imprimir               ;va decremenando cx hasta terminar de imprimir
    
    
ret





