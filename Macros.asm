;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

%define TRUE 1
%define FALSE 0

%define SUCESOR(x) x+1

%macro PCL 1
    PRINT_CHAR %1
    
%endmacro

%macro Max 2
    cmp %1,%2
    JA Uno
    JMP Dos
    Uno:
        mov eax, %1
        jmp Exit
    Dos:
        mov eax, %2
        jmp Exit
    Exit:
%endmacro

%macro WL 1

    xor ecx,ecx
    mov edi,%1
    
    FOR:
    CMP byte[edi+ecx],0
    JE Continue
    PRINT_CHAR [edi+ecx]
    inc ecx
    JMP FOR
    
    NEWLINE

    Continue:

%endmacro

section .data

s db "Pepe",0

section .text


global CMAIN
CMAIN:
   
   
   PRINT_DEC 1,TRUE
   NEWLINE
   PRINT_DEC 1,SUCESOR(5)
   NEWLINE
   
   PCL '4'
   NEWLINE
   
   mov ebx,4
   Max ebx,5
   PRINT_DEC 4,EAX
   NEWLINE
   
   WL s
   
   
   
    xor eax, eax
    ret