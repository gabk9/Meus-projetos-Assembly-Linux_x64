global _start

section .data
    input1 db "Enter the 1st string: ", 0
    input1Len equ $ - input1

    input2 db "Enter the 2nd string: ", 0
    input2Len equ $ - input2

    Equal db "The 1st string is equal to the 2nd one", 10, 0
    EqualLen equ $ - Equal

    notEqual db "The 1st string is different from the 2nd one", 10, 0
    notEqualLen equ $ - notEqual

    newline db 10
    MAXCHAR equ 256

section .bss
    str1 resb MAXCHAR
    str2 resb MAXCHAR

section .text
_start:
    push rbp
    mov rbp, rsp

    mov rax, 1
    mov rdi, 1
    mov rsi, input1
    mov rdx, input1Len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, str1
    mov rdx, MAXCHAR
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, input2
    mov rdx, input1Len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, str2
    mov rdx, MAXCHAR
    syscall

    xor rbx, rbx

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall


.cmp_loop:
    mov al, [str1 + rbx]
    mov dl, [str2 + rbx]

    cmp al, 0
    jne .check_continue
    cmp dl, 0
    jne not_equal
    jmp is_equal

.check_continue:
    cmp al, dl
    jne not_equal

    inc rbx
    jmp .cmp_loop

not_equal:
    mov rax, 1
    mov rdi, 1
    mov rsi, notEqual
    mov rdx, notEqualLen
    syscall

    jmp end

is_equal:
    mov rax, 1
    mov rdi, 1
    mov rsi, Equal
    mov rdx, EqualLen
    syscall

end:
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall
    ret