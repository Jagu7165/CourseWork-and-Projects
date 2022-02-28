TITLE CS2810 Assembler Template

; Student Name:
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here

	vSemester byte "CS2810 Summer Semester 2021", 0
	vAss byte "Assembler 5", 0
	vName byte "Jorge Aguinaga", 0

	vPrompt byte "Guess a number between 0 and 100 : ", 0
	vAgain byte "Would you like to play again? (1 for yes, 0 for no)", 0

	vHigh byte  " is to high", 0
	vLow byte " is to low", 0 
	vCor byte " is correct", 0
	vGuess byte "Guess again : ", 0
	vCarriageReturn byte 13,10,0


.code
main PROC
	;--------- Enter Code Below Here

	OuterLoop: 
	call clrscr

	mov dh, 4
	mov dl, 0
	call gotoxy
	mov edx, offset vSemester
	call writestring

	mov dh, 5
	mov dl, 0
	call gotoxy
	mov edx, offset vAss
	call writestring

	mov dh, 6
	mov dl, 0
	call gotoxy
	mov edx, offset vName
	call writestring

;	--------------------------
	

	call randomize 

	mov dh, 8
	mov dl, 0
	call gotoxy 

	mov eax, 101
	call randomrange
	mov ebx, eax

	mov edx, offset vPrompt
	call writestring

	call readdec

	cmp ebx, eax
	jl ToHigh
	jg ToLow



	ToHigh:
	call writedec
	mov edx, offset vHigh
	call writestring
	mov edx, offset vCarriageReturn
	call writestring
	mov edx, offset vGuess
	call writestring
	call readdec

	cmp ebx, eax
	jl ToHigh
	jg ToLow
	jz Correct

	ret

	ToLow:
	call writedec
	mov edx, offset vLow
	call writestring
	mov edx, offset vCarriageReturn
	call writestring
	mov edx, offset vGuess
	call writestring
	call readdec

	cmp ebx, eax
	jl ToHigh
	jg ToLow
	jz Correct

	ret

	Correct:
	call writedec
	mov edx, offset vCor
	call writestring
	mov edx, offset vCarriageReturn
	call writestring
	mov edx, offset vAgain
	call writestring
	mov edx, offset vCarriageReturn
	call writestring

	call readdec
	cmp eax, 0
	jnz OuterLoop

	ret

	xor ecx, ecx
	call ReadChar

	exit
main ENDP

END main