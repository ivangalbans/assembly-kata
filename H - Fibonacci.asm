;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

extern _malloc

section .data

n dd 0
fib dd 0

section .text


global CMAIN
CMAIN:
   
    GET_DEC 4,eax
    mov dword[n],eax
    
    inc eax
    mov ebx, 4
    mul ebx
    push eax
    call _malloc
    add esp,4
    
    mov [fib], eax
    
    ;fib(0) = 0, fib(1) = 1
    mov esi,[fib]
    mov dword[esi],0
    mov dword[esi + 4],1
   
   mov ecx, 2
   
   cmp dword[n],0
       JE UNO
   
   For:
       cmp ecx, dword[n]
       JA Continue
       mov eax, [esi + (ecx - 1)*4]
       add eax, [esi + (ecx - 2)*4]
       mov [esi + ecx * 4], eax
       inc ecx 
       jmp For
       
   UNO:
       PRINT_STRING "0"
       JMP EXIT
       
   Continue:
       dec ecx
       mov eax, [esi + ecx * 4]
       PRINT_DEC 4,eax
   
   EXIT:
    xor eax, eax
    ret