%include "io.mac"
; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages
    extern printf

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    mov ebp, 0

functie_principala:
    xor eax, eax
    xor ebx, ebx
    ;prima data vreau sa vad daca exista un an mai mare de 
    ;nastere decat data curenta, pentru ca atunci pun zero direct
    mov eax, dword [esi + my_date.year]
    mov ebx, dword [edi + 8 * (edx - 1) + my_date.year]

    cmp  eax, ebx
    jle e_zero
    xor eax, eax
    xor ebx, ebx
    ;intra aici daca suntem in cazul normal, adica
    ;data curenta > data nasterii
    ;in continuare, compar lunile
    mov ax, word [esi + my_date.month]
    ;acest 8 este de fapt size de structura si am vazut
    ;ca ziua si luna sunt pe 2 octeti, iar anul este pe 4
    ;deci 8
    mov bx, word [edi + 8 * (edx - 1) + my_date.month]
    ;si evident, am 3 cazuri (luna curenta > / < / = luna nasterii)
    cmp ax, bx
    jg e_luna_mare
    je e_luna_zero
    jl e_luna_mica
    popa
    leave
    ret

e_zero:
    xor eax, eax
    xor ebx, ebx
    ;aceasta e functia care imi pune zero, pentru ca
    ;anul curent e mai mic decat anul de nastere
    mov [ecx + 4 * (edx - 1)], eax
    sub edx, 1
    jnz functie_principala
    popa
    leave
    ret

e_luna_mare:
    ;daca luna curenta e mai mare decat luna nasterii, 
    ;evident, persoana a implinit varsta, deci nu trebuie
    ;sa mai scad 1 din diferenta
    xor eax ,eax
    xor ebx, ebx
    mov eax, dword [esi + my_date.year] 
    mov ebx, dword [edi + 8 * (edx - 1) + my_date.year]
    
    sub eax, ebx
    mov [ecx + 4 * (edx - 1)], eax
    sub edx, 1
    jnz functie_principala
    popa
    leave
    ret

e_luna_zero:
    ;cand am luniile agale, trebuie sa verific cu zilele
    xor eax ,eax
    xor ebx, ebx
    mov ax, word [esi + my_date.day] 
    mov bx, word [edi + 8 * (edx - 1) + my_date.day]
    ;si am in continuare 3 cazuri, dar cazurile cand zilele
    ;sunt egale sau ziua curenta e mai mare le iau impreuna
    ;caci inseamna ca nu trebuie sa mai scad 1, ca a implinit
    cmp eax, ebx
    jl e_zi_mic
    xor eax ,eax
    xor ebx, ebx
    mov eax, dword [esi + my_date.year] 
    mov ebx, dword [edi + 8 * (edx - 1) + my_date.year]
    sub eax, ebx
    mov [ecx + 4 * (edx - 1)], eax
    sub edx, 1
    jnz functie_principala
    popa
    leave
    ret    

e_zi_mic:
    ;aici tratez cazul cand nu a implinit varsta, deci
    ;difera doar zilele, nu si luna
    xor eax ,eax
    xor ebx, ebx
    mov eax, dword [esi + my_date.year] 
    mov ebx, dword [edi + 8 * (edx - 1) + my_date.year] 
    sub eax, ebx
    sub eax, 1
    mov [ecx + 4 * (edx - 1)], eax
    sub edx, 1
    jnz functie_principala
    popa
    leave
    ret

e_luna_mica:
    ;daca luna curenta e mai mica decat luna nasterii, 
    ;evident, persoana nu a implinit inca varsta, deci trebuie
    ;sa mai scad 1 din diferenta
    xor eax, eax
    xor ebx, ebx
    mov eax, dword [esi + my_date.year]
    mov ebx, dword [edi + 8 * (edx - 1) + my_date.year]
    sub eax, ebx
    sub eax, 1
    mov [ecx + 4 * (edx - 1)], eax
    sub edx, 1
    jnz functie_principala

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
