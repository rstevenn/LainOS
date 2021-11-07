; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

; the load disk to escape the predifine bootloader space

BOOT_DRIVE: db 0

disk_load:
    push dx ; store dx on the stack if needed

    mov ah, 0x02 ; set read disk routine form BIOS
    mov al, dh ; red dh sector

    mov ch, 0x00 ; select the first cylinder
    mov dh, 0x00 ; select the head 0
    mov cl, 0x02 ; select the second sector

    int 0x13 ; call the routine

    pop dx ; resort dx
    cmp dh, al ; check if the sectore are read
    jne disk_error

    ret

disk_error:
    mov bx, DISK_ERROR_MESSAGE
    call print_string
    jmp $

DISK_ERROR_MESSAGE:
    db '[-] Disk loading error, failure :-(', 10, 13, 'Stand by...', 10, 13, 0
