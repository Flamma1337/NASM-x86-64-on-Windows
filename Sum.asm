bits 64
default rel

segment .data
    msg db  '%d', 0x0a, 0x0
segment .text
global main

extern ExitProcess
extern _CRT_INIT
extern printf


main:
    ; Main function
    push    rbp
    mov     rbp, rsp

    call    _CRT_INIT
    call    sum

    xor     rax, rax
    call    ExitProcess

sum:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    ; summing two numbers 5 & 10
    mov     rdx, 5
    add     rdx, 10
    lea     rcx, [msg]
    call    printf

    add     rsp, 32
    pop     rbp
    ret
