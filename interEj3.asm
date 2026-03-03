;David Ceballos Mata
;Ana Camila Lopez Sanchez 

;INTERSECCION DE DOS VECTORES DE TAMANO N

org 100h
jmp start

;vectores
vecA db 1,3,4,6,8,3,0       ;vector A
vecB db 2,4,6,3,8,9,2       ;vector B
n db 7                      ;tamano de los vectores

msg1 db 0Dh,0Ah, 'Interseccion: $'       ;mensaje que se imprime antes del resultado
coma db ', $'               ;representa una coma y un espacio


start: 
    lea dx,msg1             ;carga la direccion del mensaje en DX
    mov ah,09h              ;imprimir cadena
    int 21h                 ;llamada para imprimir "Interseccion: "
    
    mov si,0                ;SI es el indice del vector A (empieza en 0)
    
outerloop:                  ;recorre vecA
    cmp si,7                ;compara SI con 7
    jge fin                 ;si SI es mayor o igual a 7 terminamos vecA, sale del programa
    
    mov al,vecA[si]         ;AL = valor actual del vector A
    mov di,0                ;DI es el indice del vector B
    
innerloop:                  ;recorre vecB
    cmp di,7                ;compara DI con 7
    jge nextA               ;si ya recorrio vecB pasa al siguiente valor de vecA
    
    mov bl,vecB[di]         ;BL = valor actual de vecB
    cmp al,bl               ;compara el valor de vecA con el valor de vecB
    jne nextB               ;si no son iguales, pasa alm siguiente elemento de vecB
    
    add al,30h              ;convierte el numero a ASCII
    mov dl,al               ;DL = caracter que se va a imprimir 
    mov ah,02h              ;imprimir solo un caracter
    int 21h                 ;imprime el numero en la pantalla
    
    lea dx,coma             ;carga la coma en DX
    mov ah,09h              ;imprimir cadena
    int 21h                 ;imprime la coma y el espacio
    
    mov byte ptr vecB[di],0FFh      ;marca este valor vecB como usado para que no se vuelva a imprimir
    jmp nextA               ;se encuentra la coincidencia se pasa al sig A
    
nextB:                      
    inc di                  ;avanza al siguiente valor de B
    jmp innerloop           ;se regresa a comparar con el siguiente de B
    
nextA:
    inc si                  ;avanza al siguiente valor de A
    jmp outerloop           ;vuelve a empezar la busqueda con el nuevo A
    
    
fin:
    ret




