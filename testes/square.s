global _start

section .data
    star db "*"
    newline db 0xA

    height equ 10
    width equ 25

section .text
putchar:
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
    ret

_start:
    mov r12, height
    
    .outer_loop:
        mov r13, width
        
        .inner_loop:
            mov rsi, star
            call putchar

            dec r13
            jnz .inner_loop
        
        mov rsi, newline
        call putchar
    
        dec r12
        jnz .outer_loop

    mov rsi, newline
    call putchar        

    mov rax, 60
    xor rdi, rdi
    syscall