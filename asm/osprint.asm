[bits 32]
; define const
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints string pointed be EDX
print_string_os:
    pusha

    mov edx, VIDEO_MEMORY

; empty the video memory
    mov cx, 0
empty_loop:

    mov al, ' '
    mov ah, WHITE_ON_BLACK 
    mov [edx], ax

    cmp cx, 2000
    je empty_end

    add edx, 2

    add cx, 1

    jmp empty_loop

empty_end:

    mov edx, VIDEO_MEMORY

print_string_os_loop:
    mov al, [ebx] ; store ebx to al
    mov ah, WHITE_ON_BLACK ; print white on black

    cmp al, 0x00
    je print_string_os_end ; check if end of screen

    mov [edx], ax

    add ebx, 1 ; go to the nex char on list
    add edx, 2 ; go to the next char on screen

    jmp print_string_os_loop

print_string_os_end:
    popa
    ret

