;10101010101010101010101010101010101010
; &&     author: Iván Galbán Smith   &&
; <<    Computer Science, UH         >>
;01010101010101010101010101010101010101

%include "io.inc"

section .text
global CMAIN
CMAIN:
    
    GET_DEC 1,AH 
    GET_DEC 1,AL
    
    ADD AH,AL
    
    PRINT_DEC 1,AH
    
    xor eax, eax
    ret