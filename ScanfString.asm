bits 64
default rel


section .data
    msg db 'Type a word: ', 0x0
    msg_in db '%s', 0x0
    msg_out db 'The message is: %s', 0x0a, 0x0

section .bss
    wrd_in resq 4

section .text
global main

extern _CRT_INIT
extern ExitProcess
extern scanf
extern printf

main:
    push    rbp
    mov     rbp,  rsp
    call    _CRT_INIT
    sub     rsp, 32

    sub     rsp, 8
    lea     rcx, [msg]
    call    printf
    add     rsp, 8

    lea     rdx, QWORD [wrd_in]
    lea     rcx, [msg_in]
    call    scanf

    lea     rdx, [wrd_in]
    lea     rcx, [msg_out]
    sub     rsp, 8
    call    printf
    add     rsp, 8

    add     rsp, 32
    call    ExitProcess
