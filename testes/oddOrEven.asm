global _start

section .data
    oddMsg db "Odd", 0
    oddLen equ $ - oddMsg
    evenMsg db "Even", 0
    evenLen equ $ - evenMsg
    zeroMsg db "Neutral", 0
    zeroLen equ $ - zeroMsg

section .text
_start:
    push rbp
    mov rbp, rsp

    mov rax, 0  

    test rax, 1
    jnz is_odd

    cmp rax, 0
    je is_zero

    mov rax, 1
    mov rdi, 1
    mov rsi, evenMsg
    mov rdx, evenLen
    syscall

    jmp end

is_odd:
    mov rax, 1
    mov rdi, 1
    mov rsi, oddMsg
    mov rdx, oddLen
    syscall

    jmp end

is_zero:
    mov rax, 1
    mov rdi, 1
    mov rsi, zeroMsg
    mov rdx, zeroLen
    syscall

end:
    pop rbp 
    mov rax, 60
    xor rdi, rdi
    syscall
    ret