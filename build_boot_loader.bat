nasm asm/bootloader.asm -f bin -o bootloader.bin
nasm asm/extendedSpace.asm -f bin -o extendedSpace.bin

copy /b bootloader.bin+extendedSpace.bin bootloader.flp

pause