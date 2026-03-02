
;David Ceballos Mata
;Ana Camila Lopez Sanchez 
 
;Programa que pide un  número entero de dos digitos y que muestre su valor en binario.

org 100h

jmp start 

; variables           
msgNum db "Numero: $"
msgBin db 0Ah,0Dh,"Binario: $"  
num db 0   
binario db 8 dup("0"), "b$"    ; buffer de 8 bytes inicializado en '0' para construir la cadena binaria

start:
    lea dx, msgNum        ;direccion de memoria del mensaje 1
    mov ah, 09h         ;imprime en pantalla la cadena 
    int 21h             ;muestra el msj y espera a que se presione una tecla
         
    ;primer digito     
    mov ah, 01h         ;funcion DOS para leer un caracter del teclado con eco
    int 21h             ;llama a la interrupcion; el caracter ASCII queda en AL
    sub al, "0"         ;convierte el caracter ASCII a su valor numerico real (ej: '5' -> 5)
    mov bl, 10          ;prepara el multiplicador 10 para las decenas
    mul bl              ;multiplica AL por 10; el resultado se almacena en AX
    mov num, al         ;guarda temporalmente el valor de las decenas en la variable 'num'
    
    ;segundo digito
    mov ah, 01h         ;prepara funcion para leer el segundo caracter
    int 21h             ;lee el segundo digito del teclado
    sub al, "0"         ;convierte el segundo caracter ASCII a valor numerico restando de la misma forma
    add num, al         ;suma las unidades al valor de las decenas previamente guardado
    
    
    ;convierte a binario
    mov al, num         ;mueve el numero total (0-99) al registro AL para procesarlo
    lea di, binario     ;DI apunta al inicio del buffer donde escribiremos los '0's y '1's
    mov cx, 8           ;Inicializa el contador en 8 para procesar los 8 bits del byte
    
convertir:  
    shl al, 1           ;desplaza AL un bit a la izquierda; el bit mas significativo sale al Carry Flag (CF)
    
    ;El bit que salio de AL ahora esta en el indicador de acarreo (Carry)
    
    jc bitUno          ;si el Carry Flag es 1 (Jump if Carry), salta a la etiqueta bit_uno
    mov byte ptr [di], "0" ; si el Carry es 0, escribe el caracter ASCII "0" en la posicion de DI
    jmp siguienteBit   ; salta para evitar la etiqueta de bit_uno
    
bitUno:
    mov byte ptr [di], "1" ;escribe el caracter ASCII "1" en la memoria apuntada por DI

siguienteBit:
    inc di              ;incrementa DI para apuntar a la siguiente posicion del buffer 'binario'
    loop convertir     ;decrementa CX y salta a 'conversion' si CX no es cero (repite 8 veces)
    
    ;mostrar mensaje
    lea dx, msgBin        ;prepara la direccion del mensaje "Binario: "
    mov ah, 09h         ;funcion de impresion de cadena
    int 21h             ;muestra la etiqueta de resultado
    
    ;mostrar num en binario
    lea dx, binario     ;carga la direccion del buffer que ahora contiene los '0's y '1's calculados
    mov ah, 09h         ;funcion de impresion de cadena
    int 21h             ;imprime la representacion binaria en pantalla
    
    ;pausa final
    mov ah, 0           ;prepara la funcion 00h de la Int 16h
    int 16h             ;detiene la ejecucion hasta que el usuario presione cualquier tecla


ret