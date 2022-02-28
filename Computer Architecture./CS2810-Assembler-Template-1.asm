TITLE CS2810 Assembler Template

; Student Name:
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester Byte "CS2810 Summer 2021", 0
	vAss Byte "Assembler Assignment 2", 0
	vName Byte "Jorge Aguinaga", 0
	vPrompt Byte "Please enter FAT16 file time in HEX: ", 0
	vTimeField Byte "--:--:--", 0

	

.code
main PROC
	;--------- Enter Code Below Here

	CALL clrscr
	mov dh, 15
	mov dl, 20

	CALL gotoxy
	mov edx, offset vSemester
	CALL writestring

	mov dh, 16
	mov dl, 20

	CALL gotoxy
	mov edx, offset vASS
	CALL writestring


	mov dh, 17
	mov dl, 20

	CALL gotoxy
	mov edx, offset vName
	CALL writestring

	mov dh, 18
	mov dl, 20

	CALL gotoxy
	mov edx, offset vPrompt 
	CALL writestring

	mov dh, 19
	mov dl, 20

	CALL gotoxy
	CALL ReadHex
	ror ax, 8

	mov cx, ax
	and ax, 1111100000000000b
	shr ax, 11

	mov bl, 10 
	div bl
	add ax, 3030h

	mov word ptr vTimeField, ax

	mov ax, cx
	and ax, 0000011111100000b
	shr ax, 5

	mov bl, 10
	div bl
	add ax, 3030h

	mov word ptr [vTimeField + 3], ax

	mov ax, cx
	and ax, 0000000000011111b
	shl ax, 1

	mov bl, 10
	div bl
	add ax, 3030h

	mov word ptr [vTimeField + 6], ax

	
	mov dh, 20
	mov dl, 20

	CALL gotoxy
	mov edx, offset vTimeField 
	Call writestring 



	
	xor ecx, ecx
	call ReadChar

	exit
main ENDP

END main