;PROGRAMA SUMA HEXADECIMAL Y DESPLEGA EN DEECIMAL

ORG 100h

MOV AH, 01h          ;leer un valor de la entrada estandar
INT 21h

MOV BL,AL           ;se guarda el valor leido al registro bl 

MOV AH, 01h         ;leer valor de entrada estandar
INT 21h

ADD AL,BL           ;suma valors leidos y se guarda en al
                    ;al=al+bl
                    
MOV BL, 30h         ;desplazamiento de los caracteres numericos
SUB AL,BL           ;al=al-bl

MOV DL,AL           ;valor a desplegar en la salida estandar

MOV AH, 02h         ;escribe el resultado en la salida estandar
INT 21h

MOV AH, 02h         ;escribe el resultado en la salida estandar

MOV AH, 0
INT 16h                 
    
    
RET   
    
    




