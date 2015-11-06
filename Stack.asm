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

; PARAMETERS
;    1. Value
; RETURN:
;    POINTER TO NRE LINKED NODE
_init_node:
    mov ebp, esp
    mov ebx, [ebp + 4]    ;Value
    MALLOC 8
    mov dword[eax], ebx    ;node.value = value
    mov dword[eax + 4], 0      ;node.next = null
    ret

%macro Print 2
    PRINT_STRING %1
    mov ebx, dword %2
    PRINT_DEC 4, ebx
    NEWLINE
%endmacro
    
_init_stack:
    MALLOC 8
    mov dword[eax], 0      ; Ptr to Top
    mov dword[eax + 4], 0   ; Count
    ret
   
    
; PARAMETERS:
;    2. Value
;    1. Ptr to stack
; Return:
;    Void
_push:
    mov ebp, esp
    mov esi, [ebp + 4]       ; ptrStack
    lea edi, [esi]           ; node Top
    mov ebx, [ebp + 8]       ; Value
    
    add dword[esi + 4], 1    ; Count++

    INIT_NODE ebx            ;new Node(value)
    mov ebx, [esi]
    mov dword[eax + 4], ebx  ;
    mov dword[esi], eax      ;
    
    .EXIT:
        ret

; PARAMETERS:
;    1. Ptr to Stack
; Return:
;    Value if there is element            
;    Else: FFFFFFFFH 
_top:
    mov ebp, esp
    mov esi, [ebp + 4]        ;ptr Stack
    mov edi, [ebp + 4]        ;ptrTemp Stack
    
    cmp dword[esi + 4], 0
    JE _top.not_item
    ; if Count == 0 :
    ;    goto not_item
    ; Else:
        sub dword[esi + 4], 1    ;Count--
        mov esi, [esi]
        mov eax, [esi]
        mov ebx, [esi + 4]       ;top.next
        mov dword[edi], ebx      ;top = top.next
        ret
    
    .not_item:
        mov eax, -1
        ret
    
    
    
    ret

                
global CMAIN
CMAIN:
   
   call _init_stack
   
   
   ;*********************
   mov ebx, 15
   push ebx
   push eax
   call _push
   pop eax
   add esp, 4
   ;*********************
   
   ;*********************
   mov ebx, 24
   push ebx
   push eax
   call _push
   pop eax
   add esp, 4
   ;*********************
   
   ;*********************
   mov ebx, 100
   push ebx
   push eax
   call _push
   pop eax
   add esp, 4
   ;*********************
   
   
   ;***************************
   push eax
   mov esi, [eax]
   Print "Count: ", [eax + 4]
   call _top
   Print "Top ", eax
   pop eax
   ;***************************
   
   
   ;***************************
   push eax
   mov esi, [eax]
   Print "Count: ", [eax + 4]
   call _top
   Print "Top ", eax
   pop eax
   ;***************************
   
   
   ;***************************
   push eax
   mov esi, [eax]
   Print "Count: ", [eax + 4]
   call _top
   Print "Top ", eax
   pop eax
   ;***************************
   
   ;***************************
   push eax
   mov esi, [eax]
   Print "Count: ", [eax + 4]
   call _top
   Print "Top ", eax
   pop eax
   ;***************************
   
   EXIT:
        xor eax, eax
        ret