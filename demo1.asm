;PROGRAMA LEER INPUT DE USUARIO Y DESPLEGARLO

ORG 100h

JMP START    

;data string 
MSG1 DB "Nombre: ", 24h             ;$
MSG2 DB 0Dh, 0Ah, "Hola ", 24h      ;<ret> + new line + msg2 + $
MSG3 DB " !!!", 0Dh, 0Ah, 24h       ;<ret> + new line + $

VECNOM DB 80 DUP(?)                 ;guardar 80 loc memoria

START:
    LEA DX, MSG1              ;direccion de memoria 
    MOV AH, 09h               ;imprime en pantalla
    INT 21h
    
    MOV SI, 0                 ;contador de caracteres
LEER:    
    MOV AH, 01h               ;leer caracter de teclado y guardarlo en AL
    INT 21h
    
    MOV VECNOM [SI], AL       ;se guarda el caracter en el string
    INC SI                    ;incremento del contador para ell sig caracter
    CMP AL, 0Dh               ;verificar que el caracter no se <ret>
    JNE LEER                  ;no fue <enter>, leo el siguiente caracter
                              ;el caracter enter termina la captura
    DEC SI                    ;se refresa una posicion en el string
    MOV VECNOM[SI], 24h       ;se coloca el $ al final del string
    
    LEA DX, MSG2              ;se eescribe Hola en pantalla
    
    MOV AH, 09h               ;imprime en pantalla
    INT 21h
                              
    LEA DX, VECNOM            ;escribir nombre en pantalla
                              
    MOV AH, 09h               ;imprime en pantalla
    INT 21h
    
    LEA DX, MSG3              ;escribir !!! en pantalla
    
    MOV AH, 09h               ;imprime en pantalla
    INT 21h
    
    MOV AH, 0h                ; press any key...
    INT 16h  
    
    
    
RET   
    
    




