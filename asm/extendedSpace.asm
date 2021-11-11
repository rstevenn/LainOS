; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

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
%include "asm/cpuID.asm"
%include "asm/64bitsPadging.asm"


[bits 32]
BEGIN_PM:
mov ebx, JUMP_TO_32BIT_MOD_MESSAGE
call print_string_os ; debug

; check CPUID
call CHECK_CPUID

mov ebx, CPUID_EXIST_MESSAGE
call print_string_os ; debug

; check long mode
call CHECK_LONG_MOD

mov ebx, LONG_MODE_EXIST_MESSAGE
call print_string_os ; debug

jmp $

OUT_OF_SCOPE_MESSAGE:
    db '[+] Out of bootloader', 10, 13, 'Jump to 32bits protected mod...', 0

JUMP_TO_32BIT_MOD_MESSAGE:
    db '[+] 32bits loaded. Check CPUID...', 0

CPUID_EXIST_MESSAGE:
	db '[+] CPUID exist. Check LONGMODE...',0

LONG_MODE_EXIST_MESSAGE:
	db '[+] LONGMODE exist. Setup Paging...',0


times 2048 -( $ - $$ ) db 0