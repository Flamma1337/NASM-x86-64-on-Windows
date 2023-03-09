bits 64
default rel


segment .data
    msg db 'Enter the first number: ', 0x0
    msg2 db 'The number is: %d', 0x0
    num db '%d', 0x0

section .bss
    inpt resb 32

segment .text
global main


extern _CRT_INIT
extern ExitProcess
extern scanf
extern printf


main:
    push    rbp
    mov     rbp, rsp
    call    _CRT_INIT

    call    scan

    xor     rax, rax
    call    ExitProcess

scan:
    nop
    nop
    nop

    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    
    lea     rcx, [msg]
    call    printf

    lea     rdx, [inpt]
    lea     rcx, [num]
    call    scanf

    mov     rdx, [inpt]
    lea     rcx, [msg2]
    call    printf

    add     rsp, 32
    pop     rbp
    ret
