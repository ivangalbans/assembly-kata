;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

;Busqueda Binaria

section .data

data db 1, 2, 4, 5, 6, 8, 10, 14, 15, 16, 18, 19, 20, 21, 22, 24, 25, 27, 30, 31, 32, 33, 34, 36, 39, 44, 45, 46, 48, 50, 51, 52, 53

size db 33
item db 0

low db 0
middle db 0
high db 33


section .text


BinarySearch:
    
    Search:
    xor EDX,EDX
    xor EAX,EAX
    xor EBX,EBX

    mov al, [low]
    mov bl, [high]
    
    ;Si los punteros se invierten
    CMP al, bl
        JAE NotFound
    
    add ax,bx
    
    ;Dividir entre dos
    mov bx,2
    div bx

    ;Obtener valor actual en AL
    mov [middle], al
    xor ebx,ebx
    mov bl, [middle]
    mov al, [data+ebx]
    
    
    ;Comparar
    cmp [item], al
    
    ;Si es menor
    JB LESS
    
    ;Si es mayor
    JA MORE
    
    ;Sino es Igual
    PRINT_DEC 1, [middle]
    JMP EXIT
    
    LESS:
        mov al, [middle]
        mov [high], al
        JMP Search
        
    MORE:
        mov al, [middle]
        add al,1
        mov [low], al
        JMP Search
    
    NotFound:
        PRINT_STRING "-1"
    
    EXIT:
        ret


global CMAIN
CMAIN:
    
   GET_DEC 2,ax
   mov [item],al
   
   Call BinarySearch
   
    xor eax, eax
    ret