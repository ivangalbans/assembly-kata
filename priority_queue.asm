;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"
extern _scanf, _printf, _malloc, _realloc, _free

section .data


section .text

%macro print 2
    PRINT_STRING %1
    mov ebx, dword %2
    PRINT_DEC 4, ebx
    NEWLINE
%endmacro

%macro MALLOC 1
    push dword %1
    call _malloc
    add esp, 4
%endmacro

%macro FREE 1
    push dword %1
    call _free
    add esp, 4
%endmacro
    
%macro INIT_NODE 1
    push dword %1
    call _init_node
    add esp, 4
%endmacro

; PARAMETERS:
;    2. Priority
;    1. Value
; Return:
;    Void
_init_node:
    mov ebp, esp
    MALLOC 12
    mov ebx, [esp + 4]     ; Value
    mov ecx, [esp + 8]     ; Priority
    mov dword[eax], ebx    ; this.value = value
    mov dword[eax + 4], 0  ; this.priority = priority
    mov dword[eax + 8], 0  ; this.next = next
    ret

; Parameters:
;    Void
; Return:
;    *ptrPriority_Queue
_init_priority_queue:
    MALLOC 8
    mov dword[eax], 0     ; ptrTop
    mov dword[eax + 4], 0 ; Count = 0
    ret

global CMAIN
CMAIN:
   
   call _init_priority_queue
   print "ID: ", eax
   
   EXIT:
        xor eax, eax
        ret