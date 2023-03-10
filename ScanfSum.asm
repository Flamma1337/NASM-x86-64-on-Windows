bits 64
default rel

section .data
    msg db 'type first number: ', 0x0
    msg2 db 'type second number: ', 0x0
    out_msg db 'the sum is: %d', 0x0a, 0x0
    in_msg db '%d', 0x0

section .bss
    num1 resb 32
    num2 resb 32

section .text
global main

extern _CRT_INIT
extern printf
extern scanf
extern ExitProcess

main:
    push    rbp
    mov     rbp, rsp
    call    _CRT_INIT
    sub     rsp, 32

    sub     rsp, 8
    lea     rcx, [msg]
    call    printf
    add     rsp, 8

    lea     rdx, [num1]
    lea     rcx, [in_msg]
    call    scanf

    sub     rsp, 8
    lea     rcx, [msg2]
    call    printf
    add     rsp, 8

    lea     rdx, [num2]
    lea     rcx, [in_msg]
    call    scanf

    mov     rax, [num1]
    add     rax, [num2]
    mov     rdx, rax
    lea     rcx, [out_msg]
    call    printf

    add     rsp, 32
    xor     rax, rax
    call    ExitProcess
