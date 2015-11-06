;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

extern _scanf
extern _strlen

section .data

text times 101 db 0
format db '%s',0

section .text


global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
   
   ;Leer Palabra
   push text
   push format
   call _scanf
   add esp,8
   
   
   xor edi,edi
   
   Recorrer:
       cmp byte[text+edi],0
       JE Continue
       inc edi
       JMP Recorrer
   
   Continue:
   
   ;Situar edi en ultimo caracter
   dec edi
   
   xor esi,esi
   
   For:
       mov al, byte[text+esi]
       mov bl, byte[text+edi]
       cmp al, bl
       JNE NotPalindrome
       inc esi
       dec edi
       cmp esi,edi
       JB For
   
   
   Palindrome:
       PRINT_STRING "YES"
       JMP Exit
   
   NotPalindrome:
       PRINT_STRING "NO"
       JMP Exit
   
   Exit:
    xor eax, eax
    ret