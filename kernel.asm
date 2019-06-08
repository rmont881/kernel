;;kernel.asm
bits 32                                     ;nasm directive -32 bit
section .text
    ;multiboot spec
    align 4
    dd 0x1BADB002                           ;magic bit
    dd 0x00                                 ;flags
    dd - (0x1BADB002 + 0x00)                ;chksm. m+f+c should be zero

global start
global keyboard_handler
global read_port
global write_port
global load_idt

extern kmain                                ;kmain is in c file
external keyboard_handler_main

read_port:
    mov edx, [esp + 4]
    in al, dx                               ;al is lower 8bit eax, dx is lower 16bit edx
    ret

write_port:
    mov edx, [esp + 4]
    mov al, [esp + 4 + 4]
    out dx, al
    ret

load_idt:
    mov edx, [esp + 4]
    lidt [edx]
    sti                                     ;turn on interrupts
    ret

keyboard_handler:
    call keyboard_handler_main
    iretd

start: 
    cli                                     ;clear/block interrupts
    mov esp, stack_space                    ;set stack pointer
    call kmain
    hlt                                     ;hault cpu

section .bss
resb 8192                                   ;8kb stack
stack_space: