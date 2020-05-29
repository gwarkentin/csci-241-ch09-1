; Program: Replace_Char_In_String (Chapter 9)
; Description: Replace characters in user inputed string
; Student:     Gabriel Warkentin
; Date:        04/14/2020
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
maxLen = 64
msg1 BYTE "Enter a string: ",0
msg2 BYTE "Enter a char to be replaced (Enter key to quit): ",0
msg3 BYTE "Enter a new char to replace (Enter key to quit): ",0
msg4 BYTE " char(s) replaced.",0dh,0ah,0
msg5 BYTE "Now the string is : ",0
inputStr BYTE maxLen - 1 DUP(?), 0

.code
;------------------------------------------------------------------
StrReplace PROC USES ebx, source:PTR BYTE, oldch: BYTE, newch: BYTE
;
; Replace old char with new char in the source string
; Receives: source, a text message string address
;           oldch, a char in the string to be replaced
;           newch, a new char to replace the old one
; Returns:  EAX, the number of characters to be replaced
;------------------------------------------------------------------
	mov esi, source
	mov eax, 0
RepLoop:
	test BYTE PTR [esi], -1
	jz NullTerm
	mov bl, BYTE PTR [esi]
	cmp bl, oldch
	jne nextChar
	mov bl, newch
	mov [esi], bl
	inc eax
NextChar:
	inc esi
	jmp RepLoop
NullTerm:
	ret
StrReplace ENDP

;------------------------------------------------------------------
GetCharInput PROC, prompt:PTR BYTE
;
; Get a char and check if the Enter key
; Receives: prompt, A prompt string offset asking user to enter key
; Returns:  AL, the char the user entered
;           CF=1 if the char is Enter key, else CF=0
;------------------------------------------------------------------
	mov edx, prompt
	call WriteString
	call ReadChar
	cmp al, 0dh
	je EnterKey
	call WriteChar
	call CRLF
	jmp LeaveLoop
EnterKey:
	call CRLF
	stc
LeaveLoop:
	ret
GetCharInput ENDP


main13 PROC
	mov edx, OFFSET msg1
	call WriteString
	mov edx, OFFSET inputStr
	mov ecx, maxLen-1
	call ReadString

MainLoop:
	INVOKE GetCharInput, OFFSET msg2
	jc quit
	mov bl, al
	INVOKE GetCharInput, OFFSET msg3
	jc quit
	Invoke StrReplace, OFFSET inputStr, bl, al
	call WriteDec
	mov edx, OFFSET msg4
	call WriteString
	mov edx, OFFSET msg5
	call WriteString
	mov edx, OFFSET inputStr
	call WriteString
	call CrLf
	call CrLf
	jmp MainLoop
quit:
	call WaitMsg
	exit
main13 ENDP

END ;main13