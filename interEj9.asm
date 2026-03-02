;David Ceballos Mata
;Ana Camila Lopez Sanchez 
 
;Programa que lee n caracteres del teclado y que indique cuantos caracteres son.

org 100h

jmp start

msg1 db "Input: $"
msgTotal db 0Dh,0Ah,"Total de caracteres: $"
vecnom db 80 dup(?)

start:
    ; Mostrar mensaje "Input:"
    lea dx, msg1        
    mov ah, 09h         ; Funcion DOS para imprimir cadena
    int 21h             

    mov si, 0           ; Inicializa SI como indice para el vector
    mov cx, 0           ; Inicializa CX como contador de caracteres

leer:
    ; Leer un caracter del teclado
    mov ah, 01h         ; Funcion DOS para leer caracter con eco
    int 21h             ; El caracter ASCII queda en AL

    cmp al, 0Dh         ; Compara si el usuario presiono ENTER (Carriage Return)
    je mostrarResultado ; Si es ENTER, termina la lectura

    mov vecnom[si], al  ; Guarda el caracter en el vector vecnom
    inc si              ; Incrementa el indice del vector
    inc cx              ; Incrementa el contador de caracteres
    jmp leer            ; Repite el bucle para el siguiente caracter

mostrarResultado:
    ; Mostrar etiqueta de "Total de caracteres:"
    lea dx, msgTotal    ; Carga la direccion del mensaje de total
    mov ah, 09h         ; Funcion para imprimir cadena
    int 21h             ; Llamada al sistema

    ; Preparar valor para imprimir
    mov ax, cx          ; Mueve el contador acumulado en CX a AX para procesarlo
    call printNum       ; Llama al procedimiento que imprime numeros de varios digitos

    ; Finalizar programa
    mov ah, 4Ch         ; Funcion DOS para terminar proceso
    int 21h             ; Devuelve el control al sistema operativo


; --- Procedimiento para imprimir un numero almacenado en AX ---
printNum proc
    cmp ax, 0           ; Verifica si el numero es cero
    jne numLoop         ; Si no es cero, inicia la conversion de digitos
    
    ; Si el numero es exactamente cero
    mov dl, '0'         ; Carga el caracter ASCII '0'
    mov ah, 02h         ; Funcion para imprimir un solo caracter
    int 21h             ; Imprime el cero
    ret                 ; Regresa al flujo principal

numLoop:
    mov bx, 10          ; Divisor para obtener los digitos decimales
    mov cx, 0           ; Limpia CX para contar cuantos digitos se extraen

conversion:
    mov dx, 0           ; Limpia DX para la division de 16 bits (DX:AX / BX)
    div bx              ; Divide AX entre 10. Cociente en AX, Residuo en DX
    push dx             ; Guarda el residuo (el digito) en la pila (stack)
    inc cx              ; Incrementa el contador de digitos en la pila
    cmp ax, 0           ; ¿El cociente es cero?
    jne conversion      ; Si no es cero, sigue extrayendo el siguiente digito

imprimir:
    pop dx              ; Recupera el ultimo digito guardado (orden correcto)
    add dl, '0'         ; Convierte el valor numerico a caracter ASCII
    mov ah, 02h         ; Funcion para imprimir un caracter
    int 21h             ; Muestra el digito en pantalla
    loop imprimir       ; Repite segun la cantidad de digitos en CX

    ret                 ; Regresa al flujo principal
printNum endp

end start

ret