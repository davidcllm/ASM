;David Ceballos Mata
;Ana Camila Lopez Sanchez 
 
;programa que separa n caracteres capturados por el usuario por medio del teclado en letras y numeros

org 100h

jmp start

msgCaptura db "Captura: $"          
msgLetras db 0Dh,0Ah,"Letras: $"    ; regreso al inicio, salto de linea
msgNumeros db 0Dh,0Ah,"Numeros: $"

;buffers: espacio de memoria temporales para que sean procesados o trasladados entre dos lugares                            
BUFSIZE equ 80                      ; define el tamano constante maximo del buffer en 80 bytes

buffer db BUFSIZE
db ?
db BUFSIZE dup(?)

;buffers para almacenar letras y numeros por separado
letras db BUFSIZE dup(?)
numeros db BUFSIZE dup(?)

start:
    ;mostrar mensaje "Captura:"
    lea dx, msgCaptura
    mov ah, 09h                     ;imprime cadena terminada en $
    int 21h

    mov ah, 0Ah                     ; lee linea completa
    lea dx, buffer                  ;comprueba que contenga el tamano maximo permitido
    ;mov byte ptr [buffer], BUFSIZE-2    
    int 21h

    ;preparar indices
    mov si, 2                       ;si apunta al primer caracter real, los dos primeros son metadatos    
    mov cl, [buffer+1]              ; Carga en CL el numero real de caracteres leidos (contador)
    mov di, 0                       ; Inicializa di como indice para el buffer de 'letras'
    mov bx, 0                       ; Inicializa BX como indice para el buffer de 'numeros'

separacion:
    cmp cl, 0                       ; Compara si el contador de caracteres restantes llego a cero
    je terminarSeparacion           ; Si termino de procesar todos, salta a la seccion de cierre

    mov al, [buffer+si]             ; Mueve el caracter actual del buffer al registro AL
    
    ;verificar si es un digito
    cmp al, '0'                     ; Compara el caracter con el codigo ASCII del cero
    jb checarLetra                  ; Si es menor (ASCII < 48), no es numero; salta a checar letras
    cmp al, '9'                     ; Compara con el codigo ASCII del nueve
    ja checarLetra                  ; Si es mayor (ASCII > 57), no es numero; salta a checar letras

    ;si es un digito
    mov [numeros+bx], al            ; Guarda el caracter en la posición actual del buffer 'numeros'
    inc bx                          ; Incrementa el indice de numeros para la siguiente posicion
    jmp siguienteChar               ; Salta al final del bucle para procesar el siguiente caracter

checarLetra:
    ; Rango de mayusculas (A-Z)
    cmp al, 'A'                     ; Compara con 'A' (65 ASCII)
    jb siguienteChar                ; Si es menor, es un simbolo especial; lo ignora
    cmp al, 'Z'                     ; Compara con 'Z' (90 ASCII)
    jbe guardarLetra                ; Si esta entre A-Z, salta a la rutina de guardado

    ; Rango de minusculas (a-z)
    cmp al, 'a'                     ; Compara con 'a' (97 ASCII)
    jb siguienteChar                ; Si es menor (entre Z y a), es simbolo; lo ignora
    cmp al, 'z'                     ; Compara con 'z' (122 ASCII)
    jbe guardarLetra                ; Si esta entre a-z, salta a la rutina de guardado
    
    jmp siguienteChar               ; Si llego aqui es mayor a 'z', se ignora

guardarLetra:
    mov [letras+di], al             ; Almacena el caracter en el buffer de 'letras'
    inc di                          ; Incrementa el indice de letras para el siguiente espacio

siguienteChar:
    inc si                          ; Mueve el puntero del buffer original al siguiente caracter
    dec cl                          ; Decrementa el contador de caracteres restantes por procesar
    jmp separacion                  ; Repite el bucle

terminarSeparacion:
    ;terminar las cadenas con '$'
    mov [letras+di], '$'            ; Coloca terminador de cadena requerido por la funcion 09h de DOS
    mov [numeros+bx], '$'           ; Repite para el buffer de numeros

    ;imprimir letras
    lea dx, msgLetras               ; Prepara la direccion del mensaje de etiqueta "Letras:"
    mov ah, 09h                     
    int 21h                         
    
    lea dx, letras                  ; Prepara la direccion de la cadena de letras filtradas
    int 21h                         ; Imprime la lista de letras procesadas

    ;imprimir numeros
    lea dx, msgNumeros              
    int 21h                         

    lea dx, numeros                 ; Prepara la direccion de la cadena de numeros filtrados
    int 21h                         ; Imprime la lista de numeros procesados

    ;terminar el programa
    mov ah, 4Ch                     ; Funcion DOS para terminar proceso con codigo de retorno
    int 21h                     

end start                           

ret                                 