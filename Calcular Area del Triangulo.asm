;10101010101010101010101010101010101010
; &&     author: Iván Galbán Smith   &&
; <<    Computer Science, UH         >>
;01010101010101010101010101010101010101

%include "io.inc"

section .data


section .text
global CMAIN
CMAIN:

    GET_DEC 2, AX
    GET_DEC 2, BX
    
    MUL BX
    MOV CX,2
    DIV CX
    PRINT_DEC 2, AX
    
    
    xor eax, eax
    ret