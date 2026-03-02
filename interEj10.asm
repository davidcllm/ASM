;David Ceballos Mata
;Ana Camila Lopez Sanchez 
 
;programa que lee una cadena de caracteres del teclado de n letras, una cadeoa de
;caracteres del teclado de m numeros y que genere una cadena con la combinación alternada de ambas.
;nota n=m

org 100h

jmp start

msgLetras db 'Captura letras: $'
msgNums db 0Dh,0Ah, 'Captura numeros: $'
msgShuffle db 0Dh,0Ah, 'Shuffle: $'

; Definicion de buffers (Estructura para funcion 0Ah de INT 21h)
; Byte 0: Maximo, Byte 1: Leidos, Byte 2...: Datos
letras db 15h,0,15h dup('$')   ; Buffer para 20 letras + metadatos
numeros db 15h,0,15h dup('$')  ; Buffer para 20 numeros + metadatos
shuffle db 29h dup('$')       ; Espacio para la cadena mezclada final

start:
    ; Mostrar mensaje para capturar letras
    mov ah, 09h         ; Funcion para imprimir cadena
    lea dx, msgLetras   ; Carga direccion de msgLetras
    int 21h             ; Llamada al sistema

    ; Captura de cadena de letras
    mov ah, 0Ah         ; Funcion para entrada de cadena amortiguada
    lea dx, letras      ; DX apunta al buffer de letras
    int 21h             ; El usuario escribe y presiona ENTER

    ; Mostrar mensaje para capturar numeros
    mov ah, 09h         
    lea dx, msgNums     
    int 21h             

    ; Captura de cadena de numeros
    mov ah, 0Ah         
    lea dx, numeros     
    int 21h             

    ; Preparar punteros para la mezcla
    lea si, letras+2    ; SI apunta al inicio del texto de letras (salta metadatos)
    lea di, numeros+2   ; DI apunta al inicio del texto de numeros (salta metadatos)
    lea bx, shuffle     ; BX apunta al destino de la mezcla

    ; Configurar contador basado en la cantidad de letras leidas
    mov cl, [letras+1]  ; Carga en CL la cantidad de caracteres capturados en 'letras'
    mov ch, 0           ; Limpia CH para usar CX como contador de bucle

bucle:
    ; Toma un caracter del buffer de letras
    mov al, [si]        ; Carga caracter de letras en AL
    mov [bx], al        ; Lo guarda en la posicion actual de shuffle
    inc si              ; Avanza al siguiente caracter de letras
    inc bx              ; Avanza posicion en el destino

    ; Toma un caracter del buffer de numeros
    mov al, [di]        ; Carga caracter de numeros en AL
    mov [bx], al        ; Lo guarda en la siguiente posicion de shuffle
    inc di              ; Avanza al siguiente caracter de numeros
    inc bx              ; Avanza posicion en el destino

    loop bucle          ; Decrementa CX y repite hasta que CX sea 0

    ; Finalizar la cadena de mezcla
    mov byte ptr [bx], '$' ; Agrega terminador para poder imprimirla despues

    ; Mostrar mensaje "Shuffle:"
    mov ah, 09h         
    lea dx, msgShuffle  
    int 21h             

    ; Mostrar la cadena final mezclada
    lea dx, shuffle     
    int 21h             

    ; Terminar el programa correctamente
    mov ax, 4C00h       ; Funcion 4Ch con codigo de retorno 00
    int 21h             

ret