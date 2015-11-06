;10101010101010101010101010101010101010
; &&     author: Iván Galbán Smith   &&
; <<    Computer Science, UH         >>
;01010101010101010101010101010101010101

%include "io.inc"

section .data

nums dd 4,5,6,323,4

section .text
global CMAIN
CMAIN:

    mov ecx, 1
    mov edx, 6
    MOV EBX, 0
    
    CMP ecx,edx
    FOR:
        JZ Continue
        
    Mostrar:    
        
        PRINT_DEC 4, [nums+EBX]
        PRINT_STRING " "
    add ecx, 1
    ADD EBX,4
    CMP ecx,edx
    
    JMP FOR
    
    Continue:
    
    xor eax, eax
    ret