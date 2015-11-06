
;10101010101010101010101010101010101010
; &&& author: Iván Galbán Smith     &&&
; <<<         Computer Science, UH  >>>
;01010101010101010101010101010101010101
%include "io.inc"

extern _malloc

section .data

a dd 0;Lista

n dd 0;Length

d dd 0; Tabla Acumulativa

section .text



Max_Element:
    
    xor ecx,ecx
    mov eax,[edi + ecx]
    inc ecx
    
    
    CICLO:
        cmp ecx,[n]
        JE EXIT3
        cmp eax,[edi+ecx*4]
        JNB CONTINUE3
        mov eax,[edi+ecx*4]
        CONTINUE3:
        inc ecx
        JMP CICLO
        
    EXIT3:
    ret

global CMAIN
CMAIN:
    
   ;Leer Datos Entrada--------------
   GET_DEC 4,eax
   mov [n],eax
   mov ebx,4
   mul ebx
   push eax
   call _malloc
   add esp,4
   
   ;Guardar la direccion de los datos
   mov [a],eax
   
   mov esi,[a]
   xor ecx,ecx
   FOR1:
       cmp ecx,[n]
       JE CONTINUE1
       GET_DEC 4,eax
       mov dword[esi + ecx*4],eax
       inc ecx
       JMP FOR1
   ;-------------------------------------------

   CONTINUE1:
   
   ;Crear array d
   mov eax,[n]
   mov ebx,4
   mul ebx
   push eax
   call _malloc
   add esp, 4
   
   mov [d], eax
   
   
   ;-------------
   
   xor ecx,ecx
   mov edi, [d]
   
   ;a->esi d->edi
   ;ecx->i ebx->j
   FOR2:
       cmp ecx,[n]
       JE CONTINUE2
       mov eax,1
       mov [edi + ecx*4],eax
           xor ebx,ebx        
           FOR3:
               cmp ebx,ecx
               JE BREAK
               mov eax,[esi + ecx*4]
               cmp [esi + ebx*4],eax
               JB Refresh
               
               SINO:
                   inc ebx
                   JMP FOR3
               
               Refresh:
                   mov eax, [edi + ebx*4]
                   inc eax
                   cmp eax, [edi + ecx*4]
                   JNA SINO
                   mov [edi + ecx*4], eax
                   JMP SINO
           
       BREAK:
           inc ecx
           JMP FOR2
   
   CONTINUE2:
  
    call Max_Element
   
   PRINT_UDEC 4,eax
   
   
   EXIT:
    xor eax, eax
    ret