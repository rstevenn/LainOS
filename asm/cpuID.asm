; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

[bits 32]

CHECK_CPUID:
	; Check if CPUID to change to 64bits mode 
	pusha

	; Copy FLAGS to EAX
	pushfd
	pop eax

	; Copy to ECX to compare later
	mov ecx, eax 

	; Filp the ID bit
	xor eax, 1 << 21

	; Copy EAX to FLAGS via the stack
	push eax
	popfd

	; Copy FLAGS back to EAX
	pushfd
	pop eax

	; Restore the old FLAG
	push ecx
	popfd

	; compare EAX and ECX. 
	xor eax, ecx
	jz ERROR_CPUID	

	; return
	popa
    ret

ERROR_CPUID:
	mov ebx, ERROR_CPUID_NOT_SUPPORTED
	call print_string_os
	jmp $

ERROR_CPUID_NOT_SUPPORTED:
    db '[-] CPUID not supported. Stand by...', 0

CHECK_LONG_MOD:
	; check long mod

	; check if the detection of longmode is possible
	mov eax, 0x80000000 
	cpuid              
	cmp eax, 0x80000001
	jb NO_LONG_MODE

	; check longmode availability
	mov eax, 0x80000001 
	cpuid
	test edx, 1 << 29
	jz NO_LONG_MODE

	ret

NO_LONG_MODE:
	mov ebx, NO_LONG_MODE_MESSAGE
	call print_string_os
	jmp $

NO_LONG_MODE_MESSAGE:
    db '[-] LONG MODE not supported. Stand by...', 0