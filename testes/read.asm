global _start

section .data
    msg1 db "Enter a string: ", 0
    len1 equ $ - msg1  
    msg2 db "You typed: ", 0
    len2 equ $ - msg2
    newline db 10

section .bss
    input resb 32
    inputLen equ $ - input

section .text
_start:
    push rbp
    mov rbp, rsp

    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, len1
    syscall
    
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, inputLen
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, len2
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, inputLen
    syscall

    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall 
    ret