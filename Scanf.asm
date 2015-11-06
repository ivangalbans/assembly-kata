;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

extern _scanf

section .data

text times 101 dd 0

format db '%s',0

section .text


global CMAIN
CMAIN:
   
   ;Introducir parametros en pila
   push text
   push format
   
   call _scanf
   
   ;Cambiar stack pointer
   add esp,8
   
   ;Mostrar String
   PRINT_STRING text
   
    xor eax, eax
    ret