;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

extern _malloc, _free

section .data

ini dd 0

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
    add esp,4
%endmacro


Print_List:
    mov ebp, esp
    mov esi, dword[ebp + 4]
    
    
    PRINT_STRING "list: COUNT:"
    PRINT_DEC 4, [esi+8]
    NEWLINE
    
    mov edi, [esi]
    PRINT_STRING "First Number"
    PRINT_DEC 4, [edi]
    NEWLINE
    
    ;mov edi, [esi + 4]
    ;PRINT_STRING "Last Number:"
    ;cmp dword[edi],0
    ;JE KK
    ;PRINT_DEC 4, [edi]
    ;NEWLINE
    
    mov esi, dword[esi]    
   
   ;KK:
   
    do:
        PRINT_DEC 4, [esi]
        NEWLINE
        cmp dword[esi + 4], 0
        JE END
        mov esi, dword[esi + 4]
        JMP do
    
    END:
        ret

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
   
   call _init_list

   
   ;*****************
   mov ebx, 5
   
   push ebx
   push eax
   
   call _add
   
   
   pop eax
   add esp,4
   ;*****************
   
   ;*****************
   mov ebx, 23
   
   push ebx
   push eax
   
   call _add
   
   
   pop eax
   add esp,4
   ;*****************
   
   ;*****************
   mov ebx, 40
   
   push ebx
   push eax
   
   call _add
   
   
   pop eax
   add esp,4
   ;*****************
   
   ;*****************
   mov ebx, 16
   
   push ebx
   push eax
   
   call _add
   
   
   pop eax
   add esp,4
   ;*****************
   
   
   ;*************
   mov ebx, 100
   mov ecx, 0
   
   push ecx
   push ebx
   push eax
   
   call _insert
   
   
   pop eax
   add esp,8
   ;******************
   
   
   ;***********************
   mov ecx, 37
   
   push ecx
   push eax
   
   call _delete
   
   
   pop eax
   add esp,4
   ;****************
   
   

   push eax
   call Print_List
   add esp, 4


   EXIT:
        xor eax, eax
        ret
        
        
        

;    LINKED LIST *************************************

	; struct linkednode {
	;	int value;
	;	struct linkednode * next;
	;} LinkedNode;

	; struct linkedlist {
	; 	LinkedNode * root;
	;} LinkedList;



    ; NO PARAMETERS.
    ; RETURN:
    ; POINTER TO LINKED LIST
    _init_list:
        MALLOC 12                
        mov dword[eax], 0           ; POINTER TO FIRST NODE OF THE LINKED LIST
        mov dword[eax + 4], 0      ; POINTER TO LAST NODE OF THE LINKED LIST
        mov dword[eax + 8], 0       ; COUNT LIST
        ret
    
    
    ;PARAMETERS:
    ;    1. Value
    ;RETURN:
    ;    POINTER TO NEW LINKED NODE
    _init_node:
        mov ebp, esp
        mov ebx, [ebp + 4]
        MALLOC 8
        mov dword[eax], ebx      ;node.value = value
        mov dword[eax + 4], 0    ;node.next = 0
        ret
    
    ;PARAMETERS:
    ;    2. ELEMENT
    ;    1. POINTER TO LINKED LIST
    ;NO RETURN.
    _add:
        mov ebp, esp
        mov esi, [ebp + 4]    ;LIST
        mov edi, dword[esi + 4]    ;LAST POINTER TO LIST
        add dword[esi + 8], 1 ;inc Count
        mov ebx, [ebp + 8]    ;ELEMENT
        cmp dword[esi], 0
        JNE _add.no_empy
        ;if list.root == null
        ;    goto no_empy
        ;else:
            INIT_NODE ebx
            mov dword[esi], eax    ;list.root = new node(value)
            mov edi, dword[eax]
            JMP _add.end
            
        .no_empy:
            mov esi, [esi]
        
        .while:
            cmp dword[esi + 4], 0
            JE _add.insert
            ;if node.next == null
            ;    goto insert
            ;else:
            mov esi, [esi + 4]    ;node = node.next
            JMP _add.while
        
        .insert:
            INIT_NODE ebx
            mov dword[esi + 4], eax    ;node.next = new node
            mov edi, dword[eax]
        .end:
            xor eax, eax
            ret
    
    
        
    ;PARAMETERS:
    ;    2. INDEX
    ;    1. POINTER TO LIST
    ;    RETURNS:
    ;    VALUE        IF INDEX IN RANGE
    ;    FFFFFFFFH    ELSE
    _get:
        mov ebp, esp
        mov esi, [ebp + 4]    ;LIST
        mov ebx, [ebp + 8]    ;INDEX
        cmp ebx, 0
        JL _get.wrong_index
        ; if index < 0
        ;    goto wrong_index
        ; else:
            mov esi, [esi]    ;esi = node = list.root
            xor ecx, ecx      ;ecx = i = 0
            .while:
                cmp ecx, ebx
                JE _get.good_index
                ; if i == index :
                ;    goto good_index
                ; else :
                    cmp dword[esi + 4], 0
                    JE _get.wrong_index
                    ; if node.next == null :
                    ;    goto wrong_index
                    ; else :
                        mov esi, [esi + 4]
                        inc ecx ; i++
                    JMP _get.while
         .good_index:
             mov eax, [esi]
             ret
         .wrong_index:
             mov eax, -1
             ret
        
        
        
    ; PARAMETERS:
    ;    3. INDEX
    ;    2.ELEMENT
    ;    1. POINTER TO LIST
    ; RETURN:
    ; 0            IF INDEX IN RANGE
    ; FFFFFFFFH    ELSE
    _insert:
        mov ebp, esp
        mov esi, [ebp + 4]    ;list
        push esi
        mov edx, [ebp + 8]    ;ELEMENT
        mov ebx, [ebp + 12]   ; index
        cmp ebx, 0
        JL _insert.wrong_index
        ; if index < 0
        ;    goto wrong_index
        ; else :
          cmp ebx, [esi + 8]
          JG _insert.wrong_index
          ; if index >= Count
              ; goto wrong_index
          ; else : 
            cmp ebx, 0
            JNE _insert.no_root
            ; if index != 0 :
            ;    goto no_root
            ; else :
                cmp dword[esi], 0
                JE _insert.null_root
                ; if list.root == null :
                ;    goto null_root
                ; else :
                    INIT_NODE edx
                    mov ebx, [esi]          ; old_root
                    mov dword[esi], eax     ; list.root = new node
                    mov dword[eax + 4], ebx ; list.root.next = old_root
                    JMP _insert.good_index
                
                .null_root:
                    INIT_NODE edx
                    mov dword[esi], eax
                    JMP _insert.good_index
            .no_root:
                mov esi, [esi]    ;root
                mov ecx, 1        ;ecx = i = 1
                .while:
                    cmp ecx, ebx
                    JE _insert.insert
                        mov esi, [esi + 4]
                        inc ecx
                    JMP _insert.while
        .insert:
            INIT_NODE edx
            mov edx, [esi + 4]         ; sig = node.next
            mov dword[esi + 4], eax    ; node.next = new node
            mov dword[eax + 4], edx    ; node.next.next = sig
            
        .good_index:
            pop esi
            add dword[esi + 8], 1
            xor eax, eax
            ret
        .wrong_index:
            pop esi
            mov eax, -1
            ret        
        
        
        
        
    ;PARAMETERS:
    ;    2. INDEX
    ;    1. POINTER TO LIST
    ; RETURNS:
    ;    0            IF INDEX IN RANGE
    ;    FFFFFFFFH    ELSE
    _delete:
        mov ebp, esp
        push esi
        mov esi, [ebp + 4]    ;list
        ;push esi
        mov ebx, [ebp + 8]    ; index
        cmp ebx, 0
        JL _delete.wrong_index
        ; if index < 0 :
        ;    goto wrong_index
        ; else :
          cmp ebx, [esi + 8]
          JGE _delete.wrong_index
          ; if index >= Count :
          ;    goto wrong_index
          ; ELSE:
            cmp ebx, 0
            JNE _delete.no_root
            ; if index != 0 :
            ;    goto no_root
            ; else : (is root)
                cmp dword[esi], 0    ; root
                JE _delete.wrong_index
                ; if list.root == null
                ;    goto wrong_index
                ; else :
                    mov ebx, dword[esi]    ; root
                    mov edx, [ebx + 4]     ; root.next
                    mov dword[esi], edx    ; list.root = root.next
                    FREE ebx
                    JMP _delete.good_index
            
            .no_root:
                cmp dword[esi], 0    ; root
                JE _delete.wrong_index
                ; if list.root == index
                ;    goto wrong_index
                ; else :
                    mov esi, [esi]    ; esi = node = list.root
                    mov ecx, 1
                    
                    .while:
                        cmp ecx, ebx
                        JE _delete.delete
                        ; if i + 1 == index
                        ;    goto delete
                        ; else :
                            mov esi, [esi + 4]
                            inc ecx
                        JMP _delete.while
                    
                    .delete:
                        mov ebx, [esi + 4]       ; node to delete
                        mov edx, [ebx + 4]       ; next of node to delete
                        mov dword[esi + 4], edx  ; next of node before node to delete
                        FREE ebx
        .good_index: 
            pop esi
            sub dword[esi + 8], 1
            xor eax, eax
            ret
        .wrong_index:
            pop esi
            mov eax, -1
            ret            
        
        
        