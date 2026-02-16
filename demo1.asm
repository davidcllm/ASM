;PROGRAMA SUMA DE VECTORES

org 100h
jmp start


vec1 db 1, 2, 1, 6
vec2 db 3, 5, 7, 1
vec3 db ?, ?, ?, ?

start:

lea si, vec1        ;ontener la direccion de memoria y posicion inicial
lea bx, vec2
lea di, vec3

mov cx, 4           ;numero de veces que se hace la suma

sum: 
    mov ax, [si]    ;el contenido de la direccion de mem SI se pasa a AC
    add ax, [bx]    ;realiza la suma y el resultado lo guarda en AL
    mov [di], al    ;guardar el lresultado de la sum aen di=vec3
    
    add al, 30h     ;desfaza el codigo ascii para que sea un numero
    
    mov dl, al
    mov ah, 02h
    int 21h         ;imprimir en pantalla
    
    inc si          ;cambio a la siguiente posicion del vector
    inc bx
    inc di
    
    loop sum        ;instruccion que hace un ciclo a la etiqueta sum
                    ;el numero de veces del ciclo es lo que se encuentra   
    
RET   
    
    




