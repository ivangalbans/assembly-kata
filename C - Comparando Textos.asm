;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

extern _scanf
extern _strlen
extern _strcmp

section .data

a times 101 db 0
b times 101 db 0

format db '%s',0
sizeA dd 0
sizeB dd 0

section .text


global CMAIN
CMAIN:
   
   ;Read a
   push a
   push format
   call _scanf
   add esp,8
   
   ;Read b
   push b
   push format
   call _scanf
   add esp,8

   
   push b
   push a
   call _strcmp
   add esp,8
   
   PRINT_DEC 4,eax
   
   
    xor eax, eax
    ret