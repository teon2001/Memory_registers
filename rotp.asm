%include "io.mac"

section .text
    global rotp
    extern printf

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    mov ebp, 0

    ;am luat separat cazul cu 0
    ;am facut xor intre ultimul byte din plaintext
    ;si primul din cheie
    mov al, byte [esi + ecx - 1] 
    mov bl, byte [edi + 0]  
    xor al, bl
    mov [edx + ecx - 1], al
    sub ecx, 1                
    add ebp, 1    

    ;dupa care, am continuat scazand/crescand
    ;cei 2 contori pe care ii folosesc     
func:
    mov al, byte [esi + ecx - 1]  
    mov bl, byte [edi + ebp]      
    xor al, bl
    mov [edx + ecx - 1], al
    add ebp, 1
    loop func   ;loop scade el singur 1 din ecx

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY