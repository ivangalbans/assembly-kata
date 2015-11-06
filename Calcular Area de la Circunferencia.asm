;10101010101010101010101010101010101010
; &&     author: Iván Galbán Smith   &&
; <<    Computer Science, UH         >>
;01010101010101010101010101010101010101

%include "io.inc"

section .data

PI dw 3

section .text
global CMAIN
CMAIN:
    
    GET_DEC 1, AL  ;LEER RADIO
    MUL AL         ;ELEVAR AL CUADRADO
    MOV BX, [PI]   
    MUL BX         ;MULTIPLICAR POR PI
    PRINT_DEC 4, EAX
    
    xor eax, eax
    ret