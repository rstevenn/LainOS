; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

[bits 16]

; switch from 16 bits real mode to 32 bits protected mod
switch_to_pm:
    cli ; disable interupts until we set them up manuallys

    lgdt [gdt_descriptor] ; load the GDT descriptor

    ; setup a control register for switching to 32 bits
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    ; jump to a 32 bits section and flush the cache with this jump
    jmp CODE_SEG:init_pm

[bits 32]
init_pm:
    ; move our segemnt register to the data seg we defined
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; mov the stack
    mov ebp, 0x7e00
    mov esp, ebp

    ; jump to our code
    call BEGIN_PM