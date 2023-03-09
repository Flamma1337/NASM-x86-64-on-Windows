bits 64
default rel

segment .data
    msg db 'type a number: ', 0x0
    msg2 db '%d', 0x0a, 0x0
    num db '%d', 0x0

section .bss
    input resb 32 ; this will store the number which the user will type

section .text
global main

extern ExitProcess
extern _CRT_INIT
extern scanf
extern printf

main:
    push    rbp
    mov     rbp, rsp

    ; initialize _CRT_INIT
    call    _CRT_INIT

    ; display message
    sub     rsp, 8
    lea     rcx, [msg]
    call    printf
    add     rsp, 8

    ; call scanf
    lea     rdx, [input]
    lea     rcx, [num]
    call    scanf

    mov     rax,    [input]
    inc     rax
    mov     [input], rax
    
    ; call for_loop
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    mov     DWORD[rsp], 0
    jmp for_loop


increment_for:
    mov     eax, DWORD[rsp]
    inc     eax
    mov     DWORD[rsp], eax

for_loop:
    mov     rax, [input]
    cmp     DWORD[rsp], eax
    jge     exitfunc

    mov     edx, DWORD[rsp]
    lea     rcx, [msg2]

    sub     rsp, 8
    call    printf
    add     rsp, 8

    jmp     increment_for

exitfunc:
    add     rsp, 32
    xor     rax, rax
    call ExitProcess
