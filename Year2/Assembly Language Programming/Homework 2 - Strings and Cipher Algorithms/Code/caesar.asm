%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher
    
    ;; Initialize eax and ebx registers
    xor eax, eax
    xor ebx, ebx

;; Loop that uses plaintext's length
resume:
    
    ;; Move to ebx to access 8 and 16 bit registers
    mov ebx, edi

    ;; Move one byte at a time
    mov al, byte [esi + ecx - 1]

    ;; Check for ASCII values between lower and upper letter values
    cmp al, 91
    jge potential_character
    jmp letters

potential_character:
    cmp al, 96
    jle other_characters

letters:
    ;; Check for potential lower letter
    cmp al, 97
    jge upper_boundary
    jmp uppercase

upper_boundary:
    cmp al, 122
    jle next_lowercase ;; Confirms that it is a lower letter
    jg other_characters ;; Else it's a random ASCII value

uppercase:
    ;; Check for potential upper letter
    cmp al, 90
    jle lower_boundary

lower_boundary:
    cmp al, 65
    jge next_uppercase ;; Confirms that it is an upper letter
    jl other_characters ;; Else it's a random ASCII value

next_lowercase:
    sub al, 97 ;; Turn char byte to a number
    
    add al, bl ;; Add the key

    ;; Check if the new letter index is below 25
    cmp al, 25
    jle easy_key
    jmp key

easy_key:
    add al, 97 ;; Turn back to letter
    mov [edx + ecx - 1], al ;; Move the letter in the ciphertext 
    jmp done

key: 
    mov bl, 26 ;; Divide the value by 26 in order to get the remainder
    div bl

    xor ebx, ebx
    mov bl, ah

    add bl, 97 ;; Turn the value into the new ciphered letter
    mov [edx + ecx - 1], bl ;; Move the letter in the ciphertext 
    jmp done

next_uppercase:
    sub al, 65 ;; Turn char byte to a number

    add al, bl ;; Add the key

    ;; Check if the new letter index is below 25
    cmp al, 25
    jle easy_uppercase_key
    jmp uppercase_key

easy_uppercase_key:
    add al, 65 ;; Turn back to letter
    mov [edx + ecx - 1], al ;; Move the letter in the ciphertext 
    jmp done

uppercase_key:
    mov bl, 26 ;; Divide the value by 26 in order to get the remainder
    div bl

    xor ebx, ebx
    mov bl, ah

    add bl, 65 ;; Turn the value into the new ciphered letter
    mov [edx + ecx - 1], bl ;; Move the letter in the ciphertext 
    jmp done

other_characters:
    mov [edx + ecx - 1], al ;; Move the random ASCII value in the ciphertext 
    jmp done

done:
    ;; Reinitialize to ensure safety
    xor eax, eax
    loop resume 

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY