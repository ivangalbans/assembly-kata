;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"


;Determina si un numero es primo O(sqrt(n))

section .data


section .text

isPrime:
    
    mov ecx, 1
    
    FOR:
    inc ecx; i++
    
    mov eax,ebx
    div ecx; Dividir
    
    ;Ver si resto fue cero
    cmp edx,0
        jz NO; Salir si el resto fue cero
        
    ;Maximo valor de i
    cmp ecx,65535
        jz NO
        
    ;Elevar al cuadrado
    mov eax, ecx
    mul ecx 
    
    cmp eax,ebx
    JBE FOR
    
    YES:
        PRINT_STRING "true"
        JMP EXIT
     
    NO:
        PRINT_STRING "false"
        JMP EXIT
     
    EXIT:
        ret

    
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
   
    GET_DEC 4, ebx
    call isPrime
    
    END:
    xor eax, eax
    ret
    
    
    
