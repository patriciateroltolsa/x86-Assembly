TITLE number-finder

;; Author: Patricia Terol
;; Course: CSE 3120
;; Project: assign03

INCLUDE Irvine32.inc

.data
array DWORD 31, 52, 19, 75, 43, 94, 87, 29, 60, 08
count DWORD 10
input DWORD 0
msg1 BYTE "Patricia Terol - CSE 3120 Assignment # 3", 0
msg2 BYTE "Enter number to search for: ", 0
msg3 BYTE "Number found at location: ", 0
msg4 BYTE "Number not found.", 0


.code
searcher PROC
; Set up the stack frame
	push ebp
	mov ebp, esp

; Get the values from the stack
	push esi
	push edi
	push ecx
	mov esi, [ebp + 16]   ; array offset
	mov edi, [ebp + 8]    ; input
	mov ecx, [ebp + 12]   ; count

; Search for the input in the array
	mov eax, -1
L1:
	cmp edi, [esi]
	je found
	jne continue
found:
	mov eax, 10
	sub eax, ecx
continue:
	add esi, TYPE DWORD
	loop L1

; Restore registers used
	pop ecx
	pop edi
	pop esi

; Clear the stack frame and return
	pop ebp
	ret

searcher ENDP

main PROC
; Print the introduction message
	mov edx, OFFSET msg1
	call WriteString
	call Crlf

; Prompt the user for a number
mov edx, OFFSET msg2
	call WriteString
	call ReadInt
	mov input, eax
	call Crlf

; Use the stack to pass the numbers into the
; compare procedure and call the procedure
	push OFFSET array
	push count
	push input
	call searcher

; Print the result message
	cmp eax, -1
	jz missing
	jnz found
found:
	mov edx, OFFSET msg3
	call WriteString
	call WriteDec
	call Crlf
	call Crlf
	jmp continue
missing: 
	mov edx, OFFSET msg4
	call WriteString
	call Crlf
	call Crlf
	jmp continue
continue:
	exit

main ENDP

END main
