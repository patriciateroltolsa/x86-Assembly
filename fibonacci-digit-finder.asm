TITLE fibonacci-digit-finder

;; Author: Patricia Terol
;; Course: CSE 3120
;; Project: assign08

INCLUDE Irvine32.inc

.data
init	DWORD 0
start   DWORD 0
runtime DWORD 0
result  DWORD 0
header BYTE "Patricia Terol - CSE 3120 - Assignment # 8", 0
msg1    BYTE  "Enter the initial value: ", 0
msg3	BYTE  "Fibonacci(", 0
msg4    BYTE  ") = ", 0
msg5    BYTE  "Program Run Time (milliseconds): ", 0

.code

fibonacci PROC, num:DWORD; recursive Fibonacci function
LOCAL minusOne : DWORD
LOCAL minusTwo : DWORD
LOCAL temp : DWORD

; Set up the variables with the appropiate values
	mov ebx, num
	mov eax, 0
	mov minusOne, ebx
	sub minusOne, 1
	mov minusTwo, ebx
	sub minusTwo, 2

;Check if n is zero
	cmp num, 0
	jne not_zero
	mov eax, 0
	jmp done

	not_zero :
	; Check if n is one
		cmp num, 1
		jne others
		mov eax, 1
		jmp done

	others:
	; If n is not zero or one, call the recursive function on n-1 and n-2
		INVOKE fibonacci, minusOne
		mov temp, eax
		INVOKE fibonacci, minusTwo
		add eax, temp

	done :
		ret; the result is in EAX

fibonacci ENDP


main PROC

	 ; print header and get input from user
	 call	Crlf
	 mov	edx, OFFSET header
	 call	WriteString
	 call	Crlf
	 call	Crlf
	 mov	edx, OFFSET msg1
	 call	WriteString
	 call	ReadDec
	 mov	init, eax; get N from user
	 call	Crlf

	 ; start the recursion with the timer counting
	 INVOKE  GetTickCount; get start time
	 mov	start, eax

	 INVOKE 	fibonacci, init; call recursive Fibonacci function
	 mov	result, eax

	 INVOKE	GetTickCount; get end time
	 sub	eax, start; calculate runtime
	 mov	runtime, eax

	 ; print result and runtime
	 mov	edx, OFFSET msg3
	 call	WriteString
	 mov	eax, init
	 call	WriteDec
	 mov	edx, OFFSET msg4
	 call	WriteString
	 mov	eax, result
	 call	WriteDec
	 call	Crlf
	 call	Crlf
	 mov	edx, OFFSET msg5
	 call	WriteString
	 mov	eax, runtime
	 call	WriteDec
	 call	Crlf
	 call	Crlf

	 exit

main ENDP

END main

