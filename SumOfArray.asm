bits 64
default rel

section .data
    msg:
        db '%d', 0x0a, 0x0 
    x: 
        dd 2, 7, 10
    sum:
        db 0

section .text

global main

extern  _CRT_INIT
extern  ExitProcess
extern  printf

main:
    push    rbp
    mov     rbp, rsp
    call    _CRT_INIT

    mov     rax, 3
    mov     rbx, 0
    mov     rcx, x
    
midloop:
    add     rbx, [rcx]
    add     rcx, 4

    dec     rax
    jnz     midloop

exit:
    mov     [sum], rbx  

    mov     rdx, [sum]
    lea     rcx, [msg]
    sub     rsp, 8
    call    printf
    add     rsp, 8 

    xor     rax, rax
    call    ExitProcess
