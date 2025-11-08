global _start

section .data
    input db "Enter a string: ", 0
    inputLen equ $ - input

    msg db "Reversed: ", 0
    msgLen equ $ - msg
    
    newline db 10
    MAXCHAR equ 256
    
section .bss
    buffer resb MAXCHAR

section .text
_start: 
    push rbp
    mov rbp, rsp

    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, inputLen
    syscall

    mov rax, 0  
    mov rdi, 0
    mov rsi, buffer
    mov rdx, MAXCHAR
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msgLen
    syscall

    mov rsi, buffer
    xor rbx, rbx

.strlen:
    cmp byte [rsi + rbx], 0
    je .found_end
    cmp byte [rsi + rbx], 10
    je .found_end
    inc rbx
    jmp .strlen

.found_end:

.revertLoop:
    test rbx, rbx
    jz .end_loop 
    
    mov rax, 1
    mov rdi, 1
    lea rsi, [buffer + rbx - 1]
    mov rdx, 1
    syscall
    
    dec rbx 
    jmp .revertLoop

.end_loop:
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall