%include "io.mac"

section .data
    key_byte: dd 0 ;; Label used for backing up the ebx register
    length: dd 0 ;; Label used for backing up the ecx register

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher

    ;; Initialize eax register
    xor eax, eax

    mov dword [key_byte], ebx ;; Backup ebx
    mov dword [length], ecx ;; Backup ecx

    ;; Reset ecx and ebx for further use
    xor ebx, ebx
    xor ecx, ecx

;; Conditional jump loop that uses plaintext's length
resume:

    ;; Move one byte at a time
    mov al, [esi + ecx]

    ;; Check for potential upper letter
    cmp al, 90
    jle upper_letter

    ;; Check for potential lower letter
    cmp al, 122
    jle lower_letter
    jg done

    ;; If not a letter, move the random ASCII value in the ciphertext
    mov [edx + ecx], al
    jmp finish  

upper_letter:
    cmp al, 65
    jge prepare_upper ;; Confirms that it is an upper letter
    jg done

lower_letter:
    cmp al, 97
    jge prepare_lower ;; Confirms that it is a lower letter
    jmp done

;; In case the key is shorter than the plaintext
refill:
    xor ebx, ebx
    jmp finish

prepare_lower:
    sub al, 97 ;; Turn char byte to a number
    mov ah, [edi + ebx] ;; Iterate through the key with ebx
    add ebx, 1 ;; Increment the key for each loop
    push ebx ;; Save a copy of ebx to stack

    sub ah, 65 ;; We know the key is always an upper letter
    add al, ah ;; Add the key directly to the value corresponding to the letter
    xor ebx, ebx
    mov bl, al
    xor eax, eax
    mov al, bl
    xor ebx, ebx
    mov bl, 26
    div bl ;; Determine the index of the new letter based on the remainder
    add ah, 97
    mov [edx + ecx], ah ;; Move the ciphered letter in edx

    xor ebx, ebx
    pop ebx ;; Restore ebx from stack
    xor eax, eax
    mov eax, dword [key_byte]
    cmp ebx, eax ;; Continue the loop if the length of the key has not been reached
    je refill ;; else reset the iteration for the key
    jmp finish

prepare_upper:
    sub al, 65 ;; Turn char byte to a number
    mov ah, [edi + ebx] ;; Iterate through the key with ebx
    add ebx, 1 ;; Increment the key for each loop
    push ebx ;; Save a copy of ebx to stack

    sub ah, 65 ;; We know the key is always an upper letter
    add al, ah ;; Add the key directly to the value corresponding to the letter
    xor ebx, ebx
    mov bl, al
    xor eax, eax
    mov al, bl
    xor ebx, ebx
    mov bl, 26
    div bl ;; Determine the index of the new letter based on the remainder
    add ah, 65
    mov [edx + ecx], ah ;; Move the ciphered letter in edx

    xor ebx, ebx
    pop ebx
    xor eax, eax
    mov eax, dword [key_byte]
    cmp ebx, eax ;; Continue the loop if the length of the has not been reached
    je refill ;; else reset the iteration for the key
    jmp finish

;; Ensure random ASCII values are not ommited
done:
    mov [edx + ecx], al

;; End of one iteration of plaintext
finish:
    xor eax, eax ;; Reset for safety 
    add ecx, 1 ;; Increment ecx for next iteration
    mov eax, dword [length] ;; Restore original ecx into eax
    cmp ecx, eax ;; If the maximum length has not been reached continue
    je end ;; else go to the end of the program
    xor eax, eax
    jmp resume

end:
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY