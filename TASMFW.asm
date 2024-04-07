;████████╗ █████╗ ███████╗███╗   ███╗    ███████╗██╗    ██╗
;╚══██╔══╝██╔══██╗██╔════╝████╗ ████║    ██╔════╝██║    ██║
;   ██║   ███████║███████╗██╔████╔██║    █████╗  ██║ █╗ ██║
;   ██║   ██╔══██║╚════██║██║╚██╔╝██║    ██╔══╝  ██║███╗██║
;   ██║   ██║  ██║███████║██║ ╚═╝ ██║    ██║     ╚███╔███╔╝
;   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝    ╚═╝      ╚══╝╚══╝ 
;	┳┓    ┓┏          
;	┣┫┓┏  ┣┫┏┓┏┓┓┏┏┓┏╋
;	┻┛┗┫  ┛┗┗┻┛ ┗┛┗ ┛┗
;  	   ┛              

.MODEL SMALL
; ----------------------------=[MACROS]=----------------------------
	
	INITSTRINGS MACRO
		; Initialize SEG & OFF for String display
		MOV AX, @DATA ; Initialize DS & ES (Segment & Offset)
		MOV DS, AX
		MOV ES, AX
	ENDM	
	
	PRINTSTR MACRO variable 
		; Displays a string from a variable
		MOV AH, 09H ; Request display string
		LEA DX, variable ; Load effective address of the string
		INT 21H ; Return to DOS
	ENDM
	
	READSTR MACRO variable
		; Keyboard string input
		MOV AH, 3FH ; Request input
		MOV BX, 00D ; Input code (00)
		MOV CX, 30D ; Write max string length
		LEA DX, variable ; Assigns entered string to variable
		INT 21H
	ENDM
	
	CASTTODECIMAL MACRO ascii
		; Casts an ascii character to a decimal
		SUB ascii, 48D
	ENDM

	CASTTOASCII MACRO decimal
		; Casts a decimal to an ascii character
		ADD decimal, 48D
	ENDM
	
	PRINTCHR MACRO character
		; Writes one character into the screen
		MOV AH, 02H ; Request print one character
		MOV DL, character ; The character to be printed
		INT 21H ; Return to DOS
	ENDM
	
	CLEAR MACRO
		; Clears the screen
		MOV AH, 00H ; Set video mode
		MOV AL, 03H ; Video mode 03 = 80 x 25
		INT 10H
	ENDM
	
	EXIT MACRO
		; Ends the program
		PRINTSTR newLine
		PRINTSTR newLine
		MOV AH, 4CH
		INT 21H
	ENDM
	
	REGSTAT MACRO
	; Casts the registers content to ASCII and displays them
	
		PRINTSTR sepRegstat
		PRINTSTR newLine
		PRINTSTR ahVignette
		MOV wildnum, AH
		CASTTOASCII wildnum
		PRINTSTR wildnum
		
		PRINTSTR newLine
		PRINTSTR alVignette
		MOV wildnum, AL
		CASTTOASCII wildnum
		PRINTSTR wildnum
		
		PRINTSTR newLine
		PRINTSTR bhVignette
		MOV wildnum, BH
		CASTTOASCII wildnum
		PRINTSTR wildnum
		
		PRINTSTR newLine
		PRINTSTR blVignette
		MOV wildnum, BL
		CASTTOASCII wildnum
		PRINTSTR wildnum
		
		PRINTSTR newLine
		PRINTSTR chVignette
		MOV wildnum, CH
		CASTTOASCII wildnum
		PRINTSTR wildnum
		
		PRINTSTR newLine
		PRINTSTR clVignette
		MOV wildnum, CL
		CASTTOASCII wildnum
		PRINTSTR wildnum
		
		PRINTSTR newLine
		PRINTSTR dhVignette
		MOV wildnum, DH
		CASTTOASCII wildnum
		PRINTSTR wildnum
		
		PRINTSTR newLine
		PRINTSTR dlVignette
		MOV wildnum, DL
		CASTTOASCII wildnum
		PRINTSTR wildnum
		
		PRINTSTR sepRegstat
		PRINTSTR newLine
	
	ENDM
	
; ----------------------------=[MACROS]=----------------------------
.STACK
.DATA

	; [!] Harvest framework variables (DO NOT MODIFY) [!]
		sepRegstat DB 0AH, "[REGISTERS STATUS (ASCII)]$"
		newLine DB 0AH, 0DH, "$"
		vignette DB "[*]$"
		ahVignette DB "[AH] $"
		alVignette DB "[AL] $"
		bhVignette DB "[BH] $"
		blVignette DB "[BL] $"
		chVignette DB "[CH] $"
		clVignette DB "[CL] $"
		dhVignette DB "[DH] $"
		dlVignette DB "[DL] $"
		wildnum DB 10 DUP("$")
		msgDebug DB 0AH, "[DEBUG MESSAGE]"
	; [!] Harvest framework variables (DO NOT MODIFY) [!]

	msg1 DB "<YOUR_TEXT>$"
	msg2 DB 0AH, "<YOUR_TEXT>$"
	n1 DB 10 DUP("$")

.CODE
MAIN PROC FAR
; -----------------------------=[CODE]=-----------------------------	
	CLEAR
	INITSTRINGS
	
	; TODO Your code goes here
	
	
	
	EXIT
; -----------------------------=[CODE]=-----------------------------	
MAIN ENDP
; Processes
PRINT16BITNUM PROC
	; Prints a 16 bit number stored in AX
	; Don't forget to do MOV DX, AX before storing the number in AX
	; and calling the process
	; Also, if any operation involves AX, don't forget to store AX 
	; in another variable (word) to restore it later
	MOV CX, 0
	MOV DX, 0
	label1:
	CMP AX, 0
	JE print1
	MOV BX, 10
	DIV BX
	PUSH DX
	INC CX
	XOR DX, DX
	JMP label1

	print1:
	CMP CX, 0
	JE exitProc

	POP DX
	ADD DX, 48

	MOV AH, 02H
	INT 21H

	DEC CX
	jmp print1

	exitProc:
	ret
PRINT16BITNUM ENDP
; Processes
END MAIN
