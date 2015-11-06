;10101010101010101010101010101010101010
; &&     author: Iván Galbán Smith   &&
; <<    Computer Science, UH         >>
;01010101010101010101010101010101010101

%include "io.inc"

section .data


section .text
global CMAIN
CMAIN:
    
    PRINT_STRING "Hello World"
    
    xor eax, eax
    ret