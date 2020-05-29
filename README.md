# csci-241-ch09-1
Replace_Char_In_String

Write a procedure named StrReplace that replace an existing char with a new char in string in all occurences. Let the user enter a test string first just once, Then with two characters input received, the user can repeatedly modify the string, until press the Enter key. Try TestStrReplace.exe to test, with an output like:
Enter a string: This is a test string.

Enter a char to be replaced (Enter key to quit): t
Enter a new char to replace (Enter key to quit): p
3 char(s) replaced.
Now the string is : This is a pesp spring.

Enter a char to be replaced (Enter key to quit): p
Enter a new char to replace (Enter key to quit): t
3 char(s) replaced.
Now the string is : This is a test string.

Enter a char to be replaced (Enter key to quit):
Press any key to continue...
The StrReplace procedure should take three parameters here:
;------------------------------------------------------------------
StrReplace PROC USES ebx, source:PTR BYTE, oldch: BYTE, newch: BYTE
;
; Replace old char with new char in the source string
; Receives: source, a text message string address
;           oldch, a char in the string to be replaced
;           newch, a new char to replace the old one
; Returns:  EAX, the number of characters to be replaced
;------------------------------------------------------------------
To repeatedly receive two chars from the user, the following reusable procedure is required
;------------------------------------------------------------------
GetCharInput PROC, prompt:PTR BYTE
;
; Get a char and check if the Enter key
; Receives: prompt, A prompt string offset asking user to enter key
; Returns:  AL, the char the user entered
;           CF=1 if the char is Enter key, else CF=0
;------------------------------------------------------------------
- To check if the Enter key is pressed, you can compare 0Dh in AL after calling ReadChar
- As ReadChar is non-echo to screen, to show a char entered, your can call WriteChar somewhere after ReadChar
Now in the main procedure, you can

Read the user input to have a test string
A loop: modify the string by replacing chars
Get the old char and check CF if exit
Get the new char and check CF if exit
INVOKE StrReplace with three argument
Display the replaced string result
Attention to:
All arguments passed to StrReplace and GetCharInput must follow their parameter list. Don't pass a register implicitly beyond the calling interface
For string length calculation, it must be wrapped into the StrReplace logic from its source parameter. Actually not necessary, a better way is to track the zero terminator
To make your code more readable, manually CMP and simply MOV are suggested, instead of using primitives like SCASB and STOSB
