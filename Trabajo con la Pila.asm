;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

section .data


section .text


global CMAIN
CMAIN:
   
   mov eax,5
   mov ebx,6
   mov ecx,7
   mov edx,8
   
   push eax
   push ebx
   push ecx
   push edx
   
   pop eax
   pop ebx
   pop ecx
   pop edx
   
   PRINT_DEC 4,eax
   NEWLINE
   PRINT_DEC 4,ebx
   NEWLINE
   PRINT_DEC 4,ecx
   NEWLINE
   PRINT_DEC 4,edx
   
    xor eax, eax
    ret