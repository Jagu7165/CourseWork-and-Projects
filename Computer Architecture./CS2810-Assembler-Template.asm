TITLE CS2810 Assembler Template

; Student Name:
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester Byte "CS 2810 Summer 2021", 0
	vAss Byte "Assember Assignment 1", 0 
	vName Byte "Jorge Aguinaga", 0

.code
main PROC
	;--------- Enter Code Below Here
	
	CALL clrscr
	mov dh, 2
	mov dl, 12

	Call gotoxy
	mov edx, offset vSemester
	CALL writestring

	mov dh, 3
	mov dl, 12

	CALL gotoxy
	mov edx, offset vAss
	CALL writestring

	mov dh, 4
	mov dl, 12
	
	CALL gotoxy
	mov edx, offset vName
	CALL writestring

	xor ecx, ecx
	call ReadChar

	exit
main ENDP

END main