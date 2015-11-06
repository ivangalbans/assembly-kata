;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

section .data

isP times 1000001 db 1
N dd 1000001
sqrtN dd 1001

A dd 0
B dd 0

section .text

Sieve:
    
     mov bl,1; True
     mov bh,0; False
    
    ;Marcar el 0 y 1 como false
    mov [isP],bh
    mov [isP+1],bh
    
    ;Recorrer los Pares------
    mov ecx, 4
    ForEven:
        mov [isP+ecx], bh; Marcar como false
        
        ;Incrementar en dos
        inc ecx
        inc ecx
        
        ;Ver si llegue al final
        cmp ecx,[N]
    JB ForEven
    ;------------------------
    
    ;Sieve
    
    mov ecx,1; Inicio
    
    ForPrime:
        ;Incrementar en dos
        inc ecx 
        inc ecx
        
        ;Si es menor q sqrtN Contine
        cmp ecx,[sqrtN]
        JNB Break
        
        ;Compara
        cmp [isP+ecx], bl
        
        ;No es Primo
        JNE ForPrime; Continue
        
        ;Si es Primo
        ;j(eax) = i*i
        mov eax, ecx
        mul ecx
        
        ForMarca:
            cmp eax,[N]
            JNB ForPrime; Si no es menor
            
            mov [isP+eax], bh
            ;j+=2*i
            mov edx, ecx
            shl edx,1
            add eax, edx
            
        JMP ForMarca

    
    Break:   
        ret

Cant:
    
    mov dl,1
    xor eax,eax
    mov ebx, [A]
    
    Begin:
        cmp [isP+ebx],dl
        JNE Continue
        
        inc eax
        Continue:
            inc ebx
            cmp ebx,[B]
            JNA Begin
    
    ret

global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
   
    Call Sieve
    
    GET_DEC 4,ecx
   
   Cases:
       GET_DEC 4,A
       GET_DEC 4,B
       
       Call Cant
       
       ;Mostrar cantidad
       PRINT_DEC 4, eax
       NEWLINE
       
       ;Decrementar y Comparar
       dec ecx
       cmp ecx,0
       JNZ Cases
       
    xor eax, eax
    ret