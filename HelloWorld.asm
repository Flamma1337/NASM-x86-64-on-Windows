bits 64
default rel

segment .data
    msg db "Hello World", 0xd, 0xa, 0
    nmber db "%d", 0xd, 0xa, 0

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
    call    hola

    xor     rax, rax
    call    ExitProcess

hola:
    ; hola function to print 'Hello World' in the console
    push    rbp
    mov     rbp, rsp
    
    lea     rcx, [msg]
    mov     eax, 0
    sub     rsp, 8
    call    printf
    add     rsp, 8
    
    pop     rbp
    ret
