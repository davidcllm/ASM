; origen 100h, el codigo va a empezar en la localidad de memoria 100h (hexadecimal)
ORG 100h 

JMP start ;satar al inicio del programa brinca a donde esta start:

;DATA SEGMENT                          
VAR1 DB 22h       ;se guarda en memoria


START:      ;etiqueta, sirven para hacer brincos                       
    MOV AL, VAR1    ;contenido de var1, se mueve a AL
    LEA BX, VAR1    ;lee la direccion de memoria de var1 y se guarda en el registro BX
    MOV BYTE PTR [BX], 44h  ;se cambia el contenido de VAR1
    MOV AL, VAR1    ;                                                                                                         

RET ; return, regresa el control al SO, es la ultima instruccion que se debe de tener








