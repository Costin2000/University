%include "io.mac"

section .data
    backup_edx: dd 0
    hex_size: dd 0
    backup_ecx: dd 0
    backup_ebx: dd 0
    fixed_hex_size: dd 0
    sum: dd 0

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    mov eax, ecx
    mov ebx, 4
    div ebx

    cmp edx, 1
    jge modify
    jmp size

modify:
    add eax, 1

size:
    mov dword [hex_size], eax
    mov dword [fixed_hex_size], eax

    xor eax, eax
    xor ebx, ebx
    xor edx, edx

    mov dword [backup_ecx], ecx

remake:

    xor ecx, ecx
    mov ecx, 4

resume:

    xor eax, eax
    xor ebx, ebx
    push ecx
    xor ecx, ecx
    mov ecx, dword [backup_ecx]
    mov al, byte [esi + ecx - 1]
    dec ecx
    mov dword [backup_ecx], ecx
    xor ecx, ecx
    pop ecx

    cmp al, 49
    je addition
    jmp end_loop

addition:
    
    cmp ecx, 4
    je add_4

    cmp ecx, 3
    je add_3

    cmp ecx, 2
    je add_2

    cmp ecx, 1
    je add_1
    jmp end_loop

add_4:
    add bl, 1
    jmp end_loop

add_3:
    add bl, 2
    jmp end_loop

add_2:
    add bl, 4
    jmp end_loop

add_1:
    add bl, 8
    jmp end_loop
    

end_loop:

    loop resume

    cmp bl, 9
    jle number_add
    ;jmp letter_add

number_add:
    xor eax, eax
    mov eax, dword [hex_size]
    cmp eax, 1
    jg add
    jmp fix

add:
    ;mov [edx + eax - 1], bl
    dec eax
    mov dword [hex_size], eax

    xor ecx, ecx
    mov ecx, dword [backup_ecx]
    cmp ecx, 4
    jg remake
    jmp fix

fix:

    xor eax, eax
    mov eax, dword[hex_size]

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY