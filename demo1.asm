;PROGRAMA QUE MUESTRA EL FUNCIONAMIENTO 
;DE LA INSTRUCCION SUMA Y RESTA

name "add-sub"
ORG 100h 

MOV AL,5
MOV BL,10

;5+10=15 DECIMAL
ADD BL,AL   ;BL=BL+AL

SUB BL,1    ;BL=BL-1

;int 21h INTERRUPCION
MOV AH,0 
INT 16h ;press any key to continue


RET ; return, regresa el control al SO, es la ultima instruccion que se debe de tener








