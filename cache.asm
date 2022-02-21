;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS
%include "io.mac"

section .text
    global load
    extern printf

section .data 
    contor dd 0
    contor_actual dd 0
    offset dd 0
    tag dd 0
    contor_prin_cache dd 0
    to_repl dd 0
    adresa_data dd 0
    numarul_meu_buun dd 0
    cache dd 0
    registru dd 0



;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE

    mov [registru], eax
    mov [adresa_data], edx
    mov [cache], ecx
    mov ebp, edx

    shl edx, 29           
    shr edx, 29             ;offsetul
    mov [offset], edx

    shr ebp, 3              ;tag-ul
    mov [tag], ebp

    mov [to_repl], edi

    xor edx, edx
    xor ebp, ebp
    xor esi, esi
    xor edi, edi


f1:
    mov ebp, [contor]
    mov esi, [ebx + ebp * 4]     ;tag curent

    add ebp, 1
    mov [contor], ebp
   
    mov edx, [tag]

    cmp edx, esi
    je exit
    cmp ebp, CACHE_LINES
    jge not_exist
    jl f1

not_exist:
    mov edi, [to_repl]
    mov ebp, [tag]
    mov [ebx + edi * 4], ebp  ; il pun in tag pe pozitia 7

    mov edx, [tag]

    shl edx, 3
    mov ebp, [contor_prin_cache]    ;contorul de la 0 la 7
    
    add edx, ebp         ; prima dresa de pus in cache, a doua....
    xor eax, eax

    mov al, byte [edx]   ; iau, pe rand un byte de la adresele tag+000/001/010..... 

    mov [numarul_meu_buun], eax ;il retin in ceva

    xor eax, eax
    mov eax, [to_repl]
    mov ecx, 8
    mul ecx               ;deci avem in eax linia de pus in chache
                          ;eu stiu ca e linia to_replace, doar ca
                          ;trebuie inmultita cu 8 ca attea coloane
                          ;are o linie de cache
    
    add eax, ebp
    
    mov esi, [numarul_meu_buun]
    
    mov ecx, [cache]    
    mov [ecx + eax], esi        ;edi = 56 + 0 1 2 
                                ;se pune in cache pe coloana corespunzatoare

    mov eax, [registru]
   
    add ebp, 1
    mov [contor_prin_cache], ebp

    cmp ebp, 8
    jge e_oki
    jl not_exist

e_oki:
    mov edi, [to_repl]
    ;e timpul sa mutam acum in registru
    ;un byte de la adresa data
    ;si sa-l pun la continutul lui eax
    mov esi, [adresa_data]
    xor edx, edx
    mov dl, byte [esi]
    mov [eax], dl

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY

exit:
    xor esi, esi
    mov [contor], esi
    mov [contor_actual], esi
    mov [offset], esi
    mov [tag], esi
    mov [contor_prin_cache], esi
    mov [to_repl], esi
    mov [adresa_data], esi
    mov [numarul_meu_buun], esi
    mov [cache], esi
    mov [registru], esi
    popa
    leave
    ret
    ;; DO NOT MODIFY


