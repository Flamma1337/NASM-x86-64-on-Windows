bits 64
default rel


section .data
    msg db 'Type a word: ', 0x0
    format db '%s', 0x0
    out_msg1 db "'%s' is a palindrome", 0x0a, 0x0
    out_msg2 db "'%s' is not a palindrome", 0x0a, 0x0

section .bss
    in_msg resb 32
    left   resq 2
    right  resq 2

section .text
global main

extern _CRT_INIT
extern ExitProcess
extern printf
extern scanf
extern strlen


main:
    push    rbp
    mov     rbp, rsp
    call    _CRT_INIT

    lea     rcx, [msg]
    call    printf

    lea     rdx, [in_msg]
    lea     rcx, [format]
    call    scanf

    lea     rcx, [in_msg]
    call    strlen
    
    mov     rbx, rax
    dec     rbx
    mov     QWORD [right], rbx
    mov     QWORD [left], 0

is_palindrome:
    cmp     rax, 2
    jg      check_palindrome

    jmp     print_msg
index:
    mov     rbx, QWORD [left]
    inc     rbx
    mov     [left], rbx
    
    mov     rax, [right]
    dec     rax
    mov     [right], rax
    
    cmp     rbx, rax
    jle      print_msg

check_palindrome:
    mov     rbx, QWORD [right]
    mov     rax, QWORD [left]
    lea     rcx, in_msg
    
    movzx   r8, byte [rcx+rax]
    movzx   r9, byte [rcx+rbx]
    cmp     r8, r9
    je      index
    
    lea     rdx, [in_msg]
    lea     rcx, [out_msg2]
    call    printf

    jmp     exitMain

print_msg:
    lea     rdx, [in_msg]
    lea     rcx, [out_msg1]
    call    printf

exitMain:
    xor     rax, rax
    call    ExitProcess
