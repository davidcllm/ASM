;PROGRAMA HELLO WORLD 1

ORG 100h

JMP START    

;data string 
MSG DB 'Hello, world!', 0    ;agregar el caracter nulo = 0

START:
    ;set the index register
    MOV SI,0
    
NEXT_CHAR:
    ;get current character
    MOV AL, MSG[SI]    ;al = al contenid ode msg en la posicoin SI
                          
    ;is it zero?
    ;if so stop printing                      
    CMP AL,0
    JE STOP
                        
    ;print character in teletype mode                    
    MOV AH,0EH
    INT 10h                          
    
    ;update index register by 1
    INC SI                     
    
    ;go back to print another char
    JMP NEXT_CHAR
    
STOP:
    MOV AH,0 ;wait for any key press
    INT 16h
    
RET   
    
    




