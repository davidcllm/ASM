;David Ceballos Mata
;Ana Camila Lopez Sanchez 
 
;Programa que lee n numeros de palabras del teclado y que el programa diga cuantas palabras son 

org 100h

jmp start

msgFrase db "Dame una frase: $", 
msgTotal db 0Dh,0Ah,"Total de palabras: $"
vecnom  db 80 dup(?)

start:    
    ; Mostrar mensaje inicial
    lea dx, msgFrase   
    mov ah, 09h         
    int 21h             

    ; Inicializar registros
    mov si, 0           ; Indice para recorrer el vector del nombre/frase
    mov cx, 0           ; Contador de palabras
    mov bl, 0           ; Bandera: 0 si estamos en espacio, 1 si estamos en una palabra

leer:
    ; Leer caracter por caracter
    mov ah, 01h         ; Funcion para leer un caracter con eco
    int 21h             ; El caracter queda en AL

    cmp al, 0Dh         ; Compara si el usuario presiono ENTER (Carriage Return)
    je conteoPalabras   ; Si es ENTER, termina la captura e inicia el conteo

    mov vecnom[si], al  ; Guarda el caracter capturado en el vector
    inc si              ; Incrementa el indice del vector
    jmp leer            ; Repite para capturar el siguiente caracter

conteoPalabras:
    ; Preparar la cadena para el analisis
    mov vecnom[si], ' '  ; Agrega un espacio al final para detectar la ultima palabra
    mov vecnom[si+1], '$'; Agrega el terminador de cadena
    mov si, 0           ; Reinicia SI para recorrer el vector desde el inicio
    mov cx, 0           ; Reinicia CX para usarlo como contador de palabras real
    mov bl, 0           ; Reinicia bandera (estado fuera de palabra)

contador:
    mov al, vecnom[si]  ; Carga el caracter actual en AL
    cmp al, '$'         ; ¿Llegamos al final de la cadena?
    je mostrarResultado ; Si es asi, salta a mostrar el total

    cmp al, ' '         ; ¿El caracter actual es un espacio?
    je encontrarEspacio ; Si es espacio, cambia el estado de la bandera

    ; Si llegamos aqui, el caracter es parte de una palabra
    cmp bl, 1           ; ¿Ya estabamos dentro de una palabra?
    je siguienteChar    ; Si ya estabamos dentro, solo pasa al siguiente caracter

    inc cx              ; Si es el inicio de una palabra nueva, incrementa el contador
    mov bl, 1           ; Cambia estado a: "dentro de una palabra"
    jmp siguienteChar

encontrarEspacio:
    mov bl, 0           ; Cambia estado a: "fuera de una palabra" (en un espacio)

siguienteChar:
    inc si              ; Mueve el puntero al siguiente caracter del vector
    jmp contador        ; Repite el bucle de analisis

mostrarResultado:
    ; Imprimir etiqueta de resultado
    lea dx, msgTotal    ; Carga mensaje de "Total de palabras:"
    mov ah, 09h         
    int 21h             

    ; Imprimir el numero acumulado en CX
    mov ax, cx          ; Mueve el conteo a AX para la rutina de impresion
    call imprimirNum    ; Llama al procedimiento que convierte valor a texto

    ; Finalizar ejecucion
    mov ah, 4Ch         ; Funcion para terminar proceso
    int 21h             


;  Procedimiento para imprimir un numero de varios digitos 
imprimirNum proc
    cmp ax, 0           ; Compara si el numero es cero
    jne loopNum         ; Si no es cero, inicia la conversion
    mov dl, '0'         ; Si es cero, imprime el caracter '0' directamente
    mov ah, 02h         
    int 21h             
    ret

loopNum:
    mov bx, 10          ; Divisor para obtener digitos decimales
    mov cx, 0           ; Contador de digitos para el stack

conversion:
    mov dx, 0           ; Limpia DX para la division de 16 bits
    div bx              ; Divide AX entre 10. Cociente en AX, Residuo en DX
    push dx             ; Guarda el residuo (el digito) en la pila
    inc cx              ; Cuenta cuantos digitos llevamos
    cmp ax, 0           ; ¿Queda algo por dividir?
    jne conversion      ; Si el cociente no es cero, sigue dividiendo

imprimir:
    pop dx              ; Recupera los digitos en orden inverso (del primero al ultimo)
    add dl, '0'         ; Convierte el valor numerico a su caracter ASCII
    mov ah, 02h         ; Funcion para imprimir un caracter
    int 21h             
    loop imprimir       ; Repite segun la cantidad de digitos guardados en CX

    ret
imprimirNum endp

end start

ret




