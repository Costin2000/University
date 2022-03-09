%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

    ;; Initialize eax and ebx registers
    xor eax, eax
    xor ebx, ebx

;; Loop that uses plaintext's and ciphertext's length
resume:
    
    ;; Move one byte at a time from the ciphertext and plaintext
    mov al, [esi + ecx - 1]
    mov bl, [edi + ecx -1]

    ;; After applying xor, move the resulted byte in edx
    xor al, bl
    mov [edx + ecx -1], al

    ;; Reinitialize to ensure safety
    xor eax, eax
    xor ebx, ebx

    loop resume 

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY