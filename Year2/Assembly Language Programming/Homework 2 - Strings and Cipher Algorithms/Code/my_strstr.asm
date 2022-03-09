%include "io.mac"

section .data
    haystack_backup: dd 0 ;; Backup for haystack
    needle_backup: dd 0 ;; Backup for needle
    match: dd 0

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr

    ;; Initialize eax register
    xor eax, eax

    ;; Backup ecx and edx
    mov dword [haystack_backup], ecx
    mov dword [needle_backup], edx

    ;; Reset both registers for further use
    xor edx, edx
    xor ecx, ecx

;; Conditional jump loop that uses haystack's length
resume:

    ;; Move one byte at a time from the haystack and the needle
    mov al, [esi + ecx]
    mov ah, [ebx + edx]

    cmp al, ah
    je potential_match ;; Check for a match
    jmp reset ;; If not found, go to next letter in haystack

potential_match:
    ;xor eax, eax
    cmp edx, 0 
    je first_match ;; Found first letter that matches in both strings

continue:
    add edx, 1 ;; Increment the needle
    mov eax, dword [needle_backup]
    cmp edx, eax ;; If the number of edx iterations reached needle_backup
    je match_found ;; we found a full match
    jmp finish

first_match:
    mov dword [match], ecx ;; Remeber the index of the first "matched" haystack letter
    jmp continue

match_found:
    xor ecx, ecx
    mov ecx, dword [match] ;; If a match was found, the remebered ecx is the result we want
    mov [edi], ecx ;; it will be moved to edi
    jmp final_end

;; Reset needle counter and try again with next haystack letter
reset:
    mov edx, 0
    jmp finish

finish:
    xor eax, eax
    add ecx, 1
    mov eax, dword [haystack_backup]
    cmp ecx, eax ;; If the length of haystack was reached
    je end ;; go to the end of the program, else resume
    xor eax, eax
    jmp resume

end:
    xor eax, eax
    test edi, eax ;; If all bits are set to 0, no match was found
    jz not_found
    jmp final_end

not_found:
    xor eax, eax
    mov eax, dword [haystack_backup]
    add eax, 1 ;; If no match was found, display the length of haystack + 1
    mov [edi], eax

final_end:
  
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
