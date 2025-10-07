global _start
extern printf

section .data
    msg db "%d + %d = %d", 10, 0 

section .text
_start:
    push rbp
    mov rbp, rsp

    mov rax, 5
    mov rbx, 10
    mov r10, rax
    add rax, rbx    

    lea rdi, [rel msg]
    mov rsi, r10
    mov rdx, rbx
    mov rcx, rax
    xor rax, rax
    call printf
    
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall
    ret