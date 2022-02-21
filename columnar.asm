%include "io.mac"

section .data
    extern len_cheie, len_haystack
    extern printf
    contor_cheie dd 0
    valoare_contor_cheie dd 0
    contor_parcurgere_cipher dd 0
    c_plainText dd 0


section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    
parcurg_vector_cheie:
    xor eax, eax
    xor ecx, ecx
    mov ecx, [contor_cheie]
    mov eax, [edi + 4 * ecx]
    mov [valoare_contor_cheie], eax
    ;c_plainText e foarte important, deoarece
    ;el imi arata unde se afla litera respectiva
    ;in textul meu, deci as putea mereu compara'
    ;sa nu depaseasca size.ul textului meu
    mov [c_plainText], eax
    add ecx, 1
    mov [contor_cheie], ecx
    cmp ecx, [len_cheie]
    jl fct_de_calcul
    jg exit

fct_de_calcul:
    xor eax, eax
    xor ecx, ecx
    mov eax, [c_plainText]
    ;am luat cate un byte, deoarece suprascriam ceva
    ;din reftext si primeam seg
    mov cl, byte [esi + eax]
    xor eax, eax
    mov eax, [contor_parcurgere_cipher]
    mov [ebx + eax], cl

    add eax, 1
    mov [contor_parcurgere_cipher], eax
    
    xor eax, eax
    mov eax, [c_plainText]
    add eax, [len_cheie]
    mov [c_plainText], eax
    cmp eax, [len_haystack]
    ;daca nu a depasit size.ul textului primit, 
    ;ma "duc in jos", adica mai adun lungime
    ;cheie pana se termina coloana
    ;daca se termina, ma duc la o noua coloana
    jl fct_de_calcul
    jge parcurg_vector_cheie

exit:
    xor eax, eax
    mov [contor_parcurgere_cipher], eax
    mov [contor_cheie], eax
    mov [c_plainText], eax
    mov [valoare_contor_cheie], eax
    popa
    leave
    ret

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY