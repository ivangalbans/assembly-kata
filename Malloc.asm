;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

extern _malloc

section .data

n dd 0
d dd 0

section .text


global CMAIN
CMAIN:
   
   ;Tamano lista
   GET_DEC 4,eax
   
   ;Introducir tamano
   push eax
   call _malloc
   pop edx
   
   ;Guardar puntero del espacio reservado
    mov [d],eax
    
   ;d es el puntero del espacio reservado

    mov dword[d],1
    mov dword[d + 4],2

   PRINT_DEC 4,[d + 4]
   
   
    xor eax, eax
    ret