bits 64 
default rel

section .data
    num0 db '%-2d : ', 0x0
    num1 db '%d ',  0x0
    nn db '', 0x0a

section .bss
    inner resb 32
    outer resb 32

section .text

global main

extern _CRT_INIT
extern ExitProcess
extern printf
extern scanf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    call    _CRT_INIT

    mov     QWORD [inner], 0
    mov     QWORD [outer], 0

    jmp     outer_loop

inner_loop:
    mov     rax, [inner]
    inc     rax
    mov     [inner], rax

    mov     rdx, [inner]
    lea     rcx, [num1]
    sub     rsp, 8
    call    printf
    add     rsp, 8
    
    mov     rax, [inner]
    cmp     rax, QWORD [outer]
    jl     inner_loop


outer_loop:

    lea     rcx, [nn]
    sub     rsp, 8
    call    printf
    add     rsp, 8

    mov     QWORD [inner], 0
    mov     rax, [outer]
    inc     rax
    mov     [outer], rax

    cmp     QWORD [outer], 50
    ja     exit

    mov     rdx, [outer]
    lea     rcx, [num0]
    sub     rsp, 8
    call    printf

    add     rsp, 8

    cmp     QWORD [outer], 50
    jl     inner_loop

    mov     rax, [inner]
    inc     rax
    mov     [inner], rax

    mov     rdx, [inner]
    lea     rcx, [num1]
    sub     rsp, 8
    call    printf
    add     rsp, 8

    mov     rax, [inner]
    cmp     rax, QWORD [outer]
    jl     inner_loop


exit:
    add     rsp, 32
    xor     rax, rax
    call    ExitProcess
