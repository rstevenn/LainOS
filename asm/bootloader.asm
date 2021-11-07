; the boot sector of LainOS
[org 0x7c00]

; get our boot dirve
mov [BOOT_DRIVE], dl

; set the stack
mov bp, 0x7c00
mov sp, bp 

; print the boot message
mov bx, BootMessage
call print_string

; load the disk
mov bx, LoadMessage
call print_string


mov bx, 0x7e00 
mov dh, 4
mov dl, [BOOT_DRIVE]
call disk_load

mov bx, DiskLoaded
call print_string

; jump to the newly load section
jmp 0x7e00

; the print function
%include "asm/print.asm"

; the read disk function
%include "asm/ReadDisk.asm"

; the messages
BootMessage:
    db 'Booting LainOS ...', 10, 13, 0

LoadMessage:
    db 'Load Disk ...', 10, 13, 0

DiskLoaded:
    db '[+] Disk loaded', 10, 13, 0, 'Jump out of bootloader ...', 10, 13, 0

; fil the rest of the file with 0 until the file is 512 bytes long
times 510 - ($-$$) db 0

; end of bootloader section
dw 0xaa55