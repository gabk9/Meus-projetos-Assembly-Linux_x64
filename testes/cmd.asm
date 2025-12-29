global _start

section .data
    prompt db "enter prompt: ", 0x00
    promptLen equ $ - prompt

    invalidCmd db "Invalid command!", 0xA, 0x00
    invalidLen equ $ - invalidCmd
    
    MAX_CHAR equ 0x400

    exit db "exit", 0x0A, 0x00
    exit_len equ $ - exit

section .bss
    input resb MAX_CHAR

section .text

strncmp:
    xor rbx, rbx
.cmp_loop:
    cmp rbx, rcx
    jge .equal
    
    mov al, [rsi + rbx]
    mov dl, [rdi + rbx]
    
    cmp al, dl
    jne .not_equal
    
    inc rbx
    jmp .cmp_loop
    
.equal:
    xor rax, rax
    ret
    
.not_equal:
    mov rax, 1
    ret

_start:
    push rbp
    mov rbp, rsp

.main_loop:
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, promptLen
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, MAX_CHAR
    syscall
    
    mov r8, rax
    
    cmp r8, 4
    jl .invalid
    
    mov rsi, input
    mov rdi, exit
    mov rcx, 4
    call strncmp
    test rax, rax
    jz .exit_program

.invalid:
    mov rax, 1
    mov rdi, 1
    mov rsi, invalidCmd
    mov rdx, invalidLen
    syscall
    
    jmp .main_loop

.exit_program:
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall