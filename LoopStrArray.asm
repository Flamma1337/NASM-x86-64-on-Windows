bits 64
default rel


section .data
    msg dq 'Hello World', 0x0a, 0x0
    format db '%c', 0x0a, 0x0

section .text
global main

extern _CRT_INIT
extern ExitProcess
extern printf


main:
    push    rbp
    mov     rbp, rsp
    call    _CRT_INIT
    sub     rsp, 32

    mov     rbx, 0

midloop:
    lea     rcx, msg
    movzx   rax, byte [rcx+rbx]
    inc     rbx
    mov     rdx, rax
    lea     rcx, [format]
    sub     rsp, 8
    call    printf
    add     rsp, 8
    cmp     rbx, 11
    jl       midloop

exitMain:
    add     rsp, 32
    xor     rax, rax
    call    ExitProcess
