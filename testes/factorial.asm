global _start
extern printf

section .data
    msg db "%d factorial is: %llu", 10, 0

section .text
_start:
    push rbp
    mov rbp, rsp

    mov rax, 10
    mov rbx, rax
    mov r10, 1

    cmp rax, 0
    je .is_zero

    jmp .loop

.is_zero:
    mov rdi, msg
    mov rsi, rax
    mov rdx, r10
    xor rax, rax
    call printf
    jmp end

.loop:
    imul r10, rbx
    dec rbx
    cmp rbx, 1
    jg .loop

    mov rdi, msg
    mov rsi, rax
    mov rdx, r10
    xor rax, rax
    call printf

end:
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall
    ret