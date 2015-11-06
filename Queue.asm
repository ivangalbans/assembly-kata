;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"
extern _scanf, _printf, _malloc, _realloc, _free

section .data


section .text

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


;PARAMETERS
;    1. Value
;RETURN:
;    POINTER TO NEW LINKED NODE
_init_node:
    mov ebp, esp
    mov ebx, [ebp + 4]
    MALLOC 8
    mov dword[eax], ebx        ; node.value = value
    mov dword[eax + 4], 0      ; node.next = 0
    ret

_init_queue:
    MALLOC 12
    mov dword[eax], 0       ;Ptr to Front
    mov dword[eax + 4], 0   ;Ptr to Back
    mov dword[eax + 8], 0    ;Count
    ret


; PARAMETERS:
;    2. Value
;    1. Ptr to queue
; RETURNS:
;    Void
_push:
    mov ebp, esp
    mov esi, [ebp + 4]    ; Ptr to queue
    lea edi, [esi + 4]  ; Ptr to Back
;PRINT_DEC 4, EDI
;NEWLINE
    mov ebx, [ebp + 8]    ; Value
    add dword[esi + 8], 1 ;Count++
    
    ;PRINT_DEC 4, [ESI + 8]
    ;NEWLINE 

    INIT_NODE ebx
    
    cmp dword[esi], 0
    JE _push.empty_queue
    ; if ptrFirst == 0 :
    ;    goto empty_queue
    ; Else:
        mov edi, dword[esi + 4]
        mov dword[edi + 4], eax    ; back.next = new node
        mov dword[esi + 4], eax  ; ptrBack = new node
        ret
    .empty_queue:
        mov dword[esi], eax        ;ptrFist = new node
        mov dword[esi + 4], eax    ;ptrLast = new node
    ret


_pop:
    mov ebp, esp
    mov esi, [ebp + 4]
    mov eax, -1
    ;Si no contiene elementos
    cmp dword[esi + 8], 0
    JE _pop.exit
    
    mov edi, [esi]        ; First Node
    mov eax, [edi]        ; Value to Return
    push eax
    
    mov ebx, [edi + 4]    ; second Node
    mov dword[esi], ebx   ; First = Second
    sub dword[esi + 8], 1 ; Count--
    FREE edi
    
        
    ;Si habia un solo elemento
    cmp dword[esi + 8], 0
    JE _pop.one_item
    pop eax
    
    .exit:
        ret
        
    .one_item:
        mov dword[esi + 4], 0    ; Last = null
        pop eax
        JMP _pop.exit


_Print_Queue:
    mov ebp, esp
    mov esi, [ebp + 4]
    
    
    PRINT_STRING "QUEUE: COUNT:"
    PRINT_DEC 4, [esi + 8]
    NEWLINE
    
    cmp dword[esi + 8], 0
    JE while.END
    
    mov esi, [esi]
    
    PRINT_DEC 4, [esi]
    NEWLINE

    while:
        cmp dword[esi + 4], 0
        JE while.END
            mov esi, dword[esi + 4]
            PRINT_DEC 4, [esi]
            NEWLINE
        JMP while
    
    .END:
        ret

global CMAIN
CMAIN:
   
   call _init_queue
   
       ;PRINT_DEC 4, EAX
     ;NEWLINE
   
   ;*******************
   mov ebx, 15
   push ebx
   push eax   
   call _push   
   pop eax
   add esp, 4
   ;*******************

   ;*******************
   mov ebx, 24
   push ebx
   push eax   
   call _push   
   pop eax
   add esp, 4
   ;*******************
   
   
   ;*******************
   mov ebx, 100
   push ebx
   push eax   
   call _push   
   pop eax
   add esp, 4
   ;*******************
   
   
   ;*******************
   mov ebx, -9
   push ebx
   push eax   
   call _push   
   pop eax
   add esp, 4
   ;*******************
   
   ;*******************
   mov ebx, 3
   push ebx
   push eax   
   call _push   
   pop eax
   add esp, 4
   ;*******************
   
   
   ;*******************
   push eax
   call _pop
   PRINT_STRING "POP: "
   PRINT_DEC 4, eax
   NEWLINE
   pop eax
   ;*******************
   
   
   push eax
   call _Print_Queue
   pop eax

   
   EXIT:
        xor eax, eax
        ret