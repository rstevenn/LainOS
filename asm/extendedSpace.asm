; the out of scope code
[org 0x7e00]

mov bp, 0x9000  ; set the stack
mov sp, bp

mov bx, OUT_OF_SCOPE_MESSAGE ; debug
call print_string

call switch_to_pm ; no return, switch to 32 bits mod
jmp $


%include "asm/print.asm"
%include "asm/osprint.asm"
%include "asm/gdt.asm"
%include "asm/switchToPm.asm"


[bits 32]
BEGIN_PM:
mov ebx, JUMP_TO_32BIT_MOD_MESSAGE
call print_string_os ; debug
jmp $

OUT_OF_SCOPE_MESSAGE:
    db '[+] Out of bootloader', 10, 13, 'Jump to 32bits protected mod...', 0

JUMP_TO_32BIT_MOD_MESSAGE:
    db '[+] 32bits loaded. Stand by...', 0

times 2048 -( $ - $$ ) db 0