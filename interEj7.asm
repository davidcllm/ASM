
;David Ceballos Mata
;Ana Camila Lopez Sanchez 
 
;Programa que lee n caracteres en minusculas del teclado y que los muestre en mayusculas.

org 100h

jmp start

msgMin db "Minusculas: $"
msgMay db 0Dh, 0Ah, "Mayusculas: $"
buffer db 80
db ?
db 80 dup(?)

start: 
    ;mostrar mensaje
    lea dx, msgMin
    mov ah, 09h
    int 21h

    ; Capturar cadena desde el teclado
    mov ah, 0Ah         ; Funcion DOS para entrada de cadena amortiguada
    lea dx, buffer      ; DX apunta a la estructura del buffer
    int 21h             ; Espera a que el usuario escriba y presione ENTER

    ; Preparar contador para el bucle
    mov al, buffer+1    ; Mueve la cantidad de caracteres leidos a AL
    mov ah, 0           ; Limpia AH para tener el valor completo en AX
    mov si, ax          ; Usa SI como contador total de caracteres a procesar

    ; Mostrar mensaje "Mayusculas:"
    lea dx, msgMay        ; Prepara la etiqueta de salida
    mov ah, 09h         ; Funcion de impresion de cadena
    int 21h             ; Muestra el mensaje en pantalla

    mov di, 2           ; DI apunta al inicio del texto real (el buffer empieza en el byte 2)

convertir:
    mov al, buffer[di]  ; Mueve el caracter actual del buffer al registro AL
    cmp al, 0Dh         ; Compara si es un Carriage Return (ENTER)
    je terminarConversion   ; Si es ENTER, termina el proceso

    ; Verificar si el caracter esta en el rango de minusculas ('a' a 'z')
    cmp al, 'a'         ; Compara con el limite inferior 'a' (97 ASCII)
    jb siguienteChar        ; Si es menor, no es minuscula; salta a imprimirlo tal cual
    cmp al, 'z'         ; Compara con el limite superior 'z' (122 ASCII)
    ja siguienteChar        ; Si es mayor, no es minuscula; salta a imprimirlo tal cual

    ; Conversion a mayuscula
    sub al, 32          ; Resta 32 al valor ASCII para convertir de minuscula a mayuscula

siguienteChar:
    ; Imprimir el caracter (ya sea convertido o el original)
    mov dl, al          ; Mueve el caracter a DL para la funcion de salida
    mov ah, 02h         ; Funcion DOS para imprimir un solo caracter en pantalla
    int 21h             ; Llamada al sistema para mostrar el caracter

    inc di              ; Incrementa el indice para apuntar al siguiente caracter del buffer
    dec si              ; Decrementa el contador de caracteres leidos
    jnz convertir       ; Si el contador no es cero, repite el bucle para el siguiente bit

terminarConversion:
    ; Finalizar programa
    mov ah, 4Ch         ; Funcion DOS para terminar el proceso
    int 21h             ; Devuelve el control al sistema operativo