;PROGRAMA HELLO WORLD 2
NAME "HI"

ORG 100h

JMP START    

;data string 
MSG DB "Hello, world!", 0Dh, 0Ah, 24h    ;agregar el caracter nulo = 0

START:
    ;obtener dir mem de msg
    LEA DX, MSG            
    MOV AH, 09h
    INT 21h
    MOV AH, 0
    INT 16h    ;wait for any key
    
RET   
    
    




