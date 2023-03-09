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
    sub     rsp, 32

    call    _CRT_INIT

    jmp     function_for

increment_for:
    mov     eax, DWORD[rsp]
    inc     eax
    mov     DWORD[rsp], eax

function_for:
    cmp     DWORD[rsp], 5
    jge     closemain
    mov     edx, DWORD[rsp]
    lea     rcx, msg
    sub     rsp, 8
    call    printf
    add     rsp, 8
    jmp     increment_for

closemain:
    add     rsp, 32
    xor     rax, rax
    call    ExitProcess
