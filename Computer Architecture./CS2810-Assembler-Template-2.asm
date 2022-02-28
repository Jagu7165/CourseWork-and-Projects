TITLE CS2810 Assembler Template

; Student Name:
; Assignment Due Date:

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	

vSemester byte "CS2810 Summer Semester 2021", 0
	vAss byte "Assembler Assignment #3", 0
	vName byte "Jorge Aguinaga", 0
	vPrompt byte "Enter a Hex number for me to decode...", 0
	
	vMpeg25 byte "MPEG Version 2.5", 0
	vMpegRE byte "MPEG Version Reserved for future use.", 0
	vMpeg20 byte "MPEG Version 2.0", 0
	vMpeg10 byte "MPEG Version 1.0", 0
	

	vLayerRE byte "Layer Reserved", 0
	vLayer01 byte "Layer III", 0
	vLayer10 byte "Layer II", 0
	vLayer11 byte "Layer I", 0

	vMpeg1_00 byte "44100 Hz", 0
	vMpeg1_01 byte "48000 Hz", 0
	vMpeg1_10 byte "32000 Hz", 0
	vMpeg1_11 byte "Reserved", 0

	vMpeg2_00 byte "22050 Hz", 0
	vMpeg2_01 byte "24000 Hz", 0
	vMpeg2_10 byte "16000 Hz", 0
	vMpeg2_11 byte "Reserved", 0

	vMpeg25_00 byte "11025 Hz", 0
	vMpeg25_01 byte "12000 Hz", 0
	vMpeg25_10 byte "8000 Hz", 0
	vMpeg25_11 byte "Reserved", 0



.code
main PROC
	;--------- Enter Code Below Here

	call Semester
	call Assignment
	call DName
	call UserPrompt


	call DecodeAudioVersion
	call DisplayLayer
	call DisplayRate

	jmp OffACliff


	Semester:
	mov dh, 10
	mov dl, 12
	call gotoxy
	mov edx, offset vSemester
	call WriteString
	ret

	Assignment:
	mov dh, 11
	mov dl, 12
	call gotoxy
	mov edx, offset vAss
	call WriteString
	ret

	DName:
	mov dh, 12
	mov dl, 12
	call gotoxy
	mov edx, offset vName
	call WriteString
	ret
	
	UserPrompt:
	mov dh, 13
	mov dl, 12
	call gotoxy
	mov edx, offset vPrompt
	call WriteString
	ret

	DecodeAudioVersion:
	mov dh, 14
	mov dl, 12
	call gotoxy
	call ReadHex
	ror eax, 32


	mov ecx, eax
			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	and eax, 00000000000110000000000000000000b
	shr eax, 19

	mov dh, 15
	mov dl, 12
	call gotoxy

	cmp eax, 00b
	jz dMpeg25

	cmp eax, 01b
	jz dMpegRE

	cmp eax, 10b
	jz dMpeg20

	mov edx, offset vMpeg10
	jmp DisplayString

	dMpeg25:
	mov edx, offset vMpeg25
	jmp DisplayString

	dMpegRE:
	mov edx, offset vMpegRE
	jmp DisplayString

	dMpeg20:
	mov edx, offset vMpeg20
	jmp DisplayString

	DisplayString:
	call WriteString
	ret



	DisplayLayer:
	mov eax, ecx

	        ;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	and eax, 00000000000001100000000000000000b
	shr eax, 17

	mov dh, 16
	mov dl, 12
	call gotoxy

	cmp eax, 00b
	jz dLayerRE

	cmp eax, 01b
	jz dLayer01

	cmp eax, 10b
	jz dLayer10

	mov edx, offset vLayer11
	jmp DisplayString
	

	dLayerRE:
	mov edx, offset vLayerRE
	jmp DisplayString
	

	dLayer01:
	mov edx, offset vLayer01
	jmp DisplayString
	

	dLayer10:
	mov edx, offset vLayer10
	jmp DisplayString
	ret




	DisplayRate:
	mov eax, ecx
			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	and eax, 00000000000110000000110000000000b
	shr eax, 10

	mov dh, 17
	mov dl, 12
	call gotoxy

	;------------------------


	cmp eax, 00000000000b
	jz dMpeg25_00

	cmp eax, 00000000001b
	jz dMpeg25_01


	cmp eax, 00000000010b
	jz dMpeg25_10
			;BBCCDEEEEFF

	cmp eax, 00000000011b
	jz  dMpeg25_11

	;-------------------------
			; BBCCDEEEEFF
	cmp eax, 010000000000b
	jz dMpeg2_00
	
	cmp eax, 010000000001b
	jz dMpeg2_01
	
	cmp eax, 010000000010b
	jz dMpeg2_10

	cmp eax, 010000000011b
	jz dMpeg2_11

	;--------------------------

	cmp eax, 011000000000b
	jz dMpeg1_00

	cmp eax, 011000000011b
	jz dMpeg1_01
	
	cmp eax, 011000000011b
	jz dMpeg1_10
	
	cmp eax, 011000000011b
	jz dMpeg1_11
	
	;---------------------------

	dMpeg25_00:
	
	mov edx, offset vMpeg25_00
	jmp DisplayString
	
	
	dMpeg25_01:
	mov edx, offset vMpeg25_01
	jmp DisplayString
	
	
	dMpeg25_10:
	mov edx, offset vMpeg25_10
	jmp DisplayString
	
	
	dMpeg25_11:
	mov edx, offset vMpeg25_11
	jmp DisplayString
	
	;--------------------------------------

	dMpeg2_00:
	mov edx, offset vMpeg2_00
	jmp DisplayString
	
	
	dMpeg2_01:
	mov edx, offset vMpeg2_01
	jmp DisplayString
	
	
	dMpeg2_10:
	mov edx, offset vMpeg2_10
	jmp DisplayString
	
	
	dMpeg2_11:
	mov edx, offset vMpeg2_11
	jmp DisplayString
	;---------------------------------------

	dMpeg1_00:
	mov edx, offset vMpeg1_00
	jmp DisplayString
	
	
	dMpeg1_01:
	mov edx, offset vMpeg1_01
	jmp DisplayString
	
	
	dMpeg1_10:
	mov edx, offset vMpeg1_10
	jmp DisplayString
	
	
	dMpeg1_11:
	mov edx, offset vMpeg1_11
	jmp DisplayString
	ret



	OffACliff:
	
	xor ecx, ecx
	call ReadChar

	exit
main ENDP

END main