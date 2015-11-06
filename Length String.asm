;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

section .data

msg  db "Hello, world!"   ;our dear string
len  equ  $ - msg

section .text


global CMAIN
CMAIN:
   
    mov eax,len
    PRINT_DEC 4,EAX
   
    xor eax, eax
    ret