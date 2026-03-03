;David Ceballos Mata
;Ana Camila Lopez Sanchez 

;PROGRAMA QUE CALCULA EL PROMEDIO DE 4 NUMEROS DE UN DIGITO

org 100h
jmp start       ;saltar al inicio del programa

msg1 db 0Dh,0Ah, 'Numero: $'        ;pide los numeros (0Dh,0Ah=salto de linea)
msg2 db 0Dh,0Ah, 'Promedio: $'      ;se muestra antes de imprimir el resultado 
res db 0                            ;variable para guardar el resultado del promedio

start:
    mov cx,4        ;cx = 4 contador para leer 4 numeros 
    mov bl,0        ;bl = 0 donde se guarda la suma 
      
leer:
    lea dx,msg1     ;carga en dx la direccion del mensaje de "Numero:$"
    mov ah,09h      ;mostrar "Numero: "
    int 21h         ;imprime el mensaje en pantalla
    
    mov ah,01h      ;lee un caracer en el teclado
    int 21h         ;espera a que el usuario lea un caracter
    
    sub al,30h      ;convierte el carcater ASCII en numero real
    add bl,al       ;suma  el numero que se leyo
    
    mov ah,01h      ;vuelve a leer un caracter del teclado
    int 21h         ;espera el enter del usuario
    
    loop leer       ;decrementa el contador y si no es 0, regresa a la etiqueta leer
    
    mov al,bl       ;copia la suma total a AL para poder dividirla
    mov ah,0        ;limpia AH 
    mov bl,4        ;BL = 4 (divisor para sacar el promedio)
    div bl          ;divide AX entre BL AL = resultado (promedio) AH = residuo
    
    add al,30h      ;convierte el promedio a ASCII para imprimirlo
    mov res,al      ;guarda el caracter del promedio en res
    
    lea dx,msg2     ;carga DX en la direccion de "Promedio: $"
    mov ah,09h      ;imprimir cadena
    int 21h         ;imprime el texto "Promedio: " en pantalla
    
    mov dl,res      ;carga en DL el caracter del promedio guardado en res
    mov ah,02h      ;imprime solo un caracter
    int 21h         ;imprime el numero del promedio en pantalla
    
    
ret



