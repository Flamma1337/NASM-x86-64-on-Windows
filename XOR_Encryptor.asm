bits 64
default rel

section .data
    enc_str db '0x%-2X, ', 0x0
    msg     db 'Type a word: ', 0x0
    msg1     db 'Type a key: ', 0x0
    format  db '%s', 0x0
    
section .bss
    input   resb 32
    key     resb 32
    int_j   resq 2
    int_i   resq 2

section .text
global main

extern  _CRT_INIT
extern  ExitProcess
extern  printf
extern  scanf
extern  strlen

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    call    _CRT_INIT

    sub     rsp, 8
    lea     rcx, [msg]
    call    printf
    add     rsp, 8

    lea     rdx, [input]
    lea     rcx, [format]
    call    scanf

    sub     rsp, 8
    lea     rcx, [msg1]
    call    printf
    add     rsp, 8

    lea     rdx, [key]
    lea     rcx, [format]
    call    scanf

    lea     rcx, input
    call    strlen
    mov     r12, rax
    dec     r12

    lea     rcx, key
    call    strlen
    mov     r13, rax
    dec     r13

xorenc:
    mov     rbx, [int_j]
    mov     rax, [int_i]

    cmp     [int_j], r13
    jg      zero_intj

    cmp     [int_i], r12
    jg      exitMain
    
    lea     r10, input
    lea     r11, key
    movzx   r9, byte [r10+rax]
    movzx   r8, byte [r11+rbx]
    xor     r9, r8

    mov     rax, [int_i]
    inc     rax
    mov     [int_i], rax

    mov     rbx, [int_j]
    inc     rbx
    mov     [int_j], rbx

    sub     rsp, 8
    mov     rdx, r9
    lea     rcx, [enc_str]
    call    printf
    add     rsp, 8
    jmp     xorenc

zero_intj:
    mov     QWORD[int_j], 0
    jmp     xorenc

exitMain:
    add     rsp, 32
    pop     rbp
    xor     rax, rax
    call    ExitProcess
