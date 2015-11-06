;10101010101010101010101010101010101010
; &&     author: Iván Galbán Smith   &&
; <<    Computer Science, UH         >>
;01010101010101010101010101010101010101

%include "io.inc"

section .data


section .text
global CMAIN
CMAIN:

    GET_DEC 2,AX
    AND AX,1
    
    JZ PAR
   
    PRINT_STRING "IMPAR"
    
    JMP CONTINUE
    
    PAR:
    PRINT_STRING "PAR"
        
    CONTINUE:
       

    ;write your code here
    xor eax, eax
    ret