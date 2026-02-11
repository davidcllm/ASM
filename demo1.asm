; origen 100h, el codigo va a empezar en la localidad de memoria 100h (hexadecimal)
org 100h 

Jmp start ;satar al inicio del programa brinca a donde esta start:

;DATA SEGMENT                          
var1 DB 7       ;Guardar databyte (DB) con valor de 7 (var1=7) DB son 8 bits, 1 byte
var2 DW 1234h   ;var2=1234 en heexadecimal dataw (DW) son 16 bits, 2 bytes


start:      ;etiqueta, sirven para hacer brincos                       
    mov al,var1     ;al=var1  al registro de 8 bits
    mov bx,var2     ;bx=var2 bx registro de 16 bits                                                                                                          

ret ; return, regresa el control al SO, es la ultima instruccion que se debe de tener








