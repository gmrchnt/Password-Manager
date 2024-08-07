INCLUDE Irvine32.inc
.data

	resetter PROTO, string:ptr BYTE, stringlength: DWORD
	nullAgeChecker PROTO,stringSource:ptr BYTE,stringDestination:ptr BYTE,lengthofSource:DWORD
	nullChecker PROTO,stringSource:ptr BYTE,stringDestination:ptr BYTE
	displayMultiLiner PROTO,string: ptr BYTE
	displayOneLiner PROTO,string: ptr BYTE,stringLen:DWORD
	len PROTO, bareMin:DWORD
	symNumChecker PROTO,string1: ptr BYTE
	numberChecker PROTO, string: ptr BYTE
	bufferBreaker PROTO, pBuffer:ptr BYTE,pStoredPass:ptr BYTE
	bufferLen PROTO,pStoredPass:ptr BYTE
	dataViewer PROTO, msg:ptr BYTE,lenMsg: DWORD, storedData:ptr BYTE,lenStoredData:DWORD


	buffer BYTE 500 DUP(?),0
	fileHandle HANDLE ?
	userFileName BYTE "file",60 DUP(?),0
	text BYTE ".txt",0
	username BYTE 50 DUP(?),0
	storedUName BYTE 50 DUP(?),0
	range DWORD 95
	counter DWORD 0
	passReq DWORD 0
	choice BYTE 1 DUP(?),0
	password BYTE 32 DUP(?),0
	storedPass BYTE 32 DUP(?),0
	Pname BYTE 50 DUP(?),0
	storedName BYTE 50 DUP(?),0
	age DWORD 0
	ageArr BYTE "000",0
	storedAge BYTE 3 DUP(?),0
	degree BYTE 50 DUP(?),0
	storedDeg BYTE 50 DUP(?),0
	university BYTE 50 DUP(?),0
	storedUni BYTE 50 DUP(?),0
	symbols BYTE "!#$%&'""()*+,-./:;<=>?@[\]^_`{|}~",0
	charSet BYTE "!#$%&'""()*+,-./:;<=>?@[\]^_`{|}~0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",0
	symNum BYTE "!#$%&'""()*+,-./:;<=>?@[\]^_`{|}~0123456789",0


	msgPassReq BYTE "Password MUST have UpperCaps character(s)",0ah,0dh
		BYTE "Password MUST have LowerCaps character(s)",0ah,0dh
		BYTE "Password MUST have Number(s)",0ah,0dh
		BYTE "Password MUST be bigger than 7 character",0ah,0dh
		BYTE "Password MUST have Symbol(s)",0ah,0dh,0
	msgFail BYTE "Password is not Strong.",0ah,0dh,0
	msgPass BYTE "Password is Strong.",0ah,0dh,0
	msgGenPass BYTE "Password Generated: ",0
	msgInputPass BYTE "Input Password: ",0
	msgIntro BYTE "Hello, Welcome",0ah,0dh
		BYTE " -to the password management portal",0ah,0dh,0
	msgWait BYTE "(Please press any key to continue)",0
	msgReturn BYTE " (Please press any key to return)",0
	msgBooleanChoice BYTE "(Enter 0 to Exit)",0ah,0dh
		BYTE "(Enter 1 to Retry)",0ah,0dh,0
	msgErrorChoice BYTE "Please enter correctly",0ah,0dh,0
	msgMenu BYTE " MENU",0ah,0dh,0ah,0dh
		BYTE " 1- Login",0ah,0dh
		BYTE " 2- Sign Up",0ah,0dh
		BYTE " 0- Exit",0ah,0dh,0
	msgMenuII BYTE " MENU",0ah,0dh,0ah,0dh
		BYTE " 1- View Data",0ah,0dh
		BYTE " 2- Change Data",0ah,0dh
		BYTE " 0- Exit",0ah,0dh,0ah,0dh,0
	msgLogin BYTE "LOGIN",0ah,0dh,0ah,0dh,0
	msgLoginU BYTE "Username: ",0
	msgLoginP BYTE "Password: ",0
	msgFileA BYTE "Age: ",0
	msgFileU BYTE "University: ",0
	msgFileD BYTE "Degree: ",0
	msgSign BYTE " SIGN UP",0ah,0dh,0ah,0dh,0
	msgSignUN BYTE "Username(Must Be More than 3 characters): ",0
	msgSignN BYTE "Name: ",0
	msgSignA BYTE "Age(Must Be between 15 and 150): ",0
	msgSignU BYTE "University(Must Be More than 1 character): ",0
	msgSignD BYTE "Degree(Must Be More than 1 character): ",0
	msgSignSuc BYTE "Sign Up Successful.",0ah,0dh,0
	msgSignTer BYTE "Sign Up Terminated.",0ah,0dh,0
	msgFileNL BYTE 10,13
	msgFileError BYTE "User doesn't exist.",0ah,0dh,0
	msgIncorPass BYTE "Password is incorrect.",0ah,0dh,0
	msgCorPass BYTE "Welcome- ",0
	msgPassChanged BYTE "Password has been changed to: ",0
	msgUnchangeable BYTE "Sorry, Username cannot be changed.",0ah,0dh,0
	msgChangePass BYTE "Do you want to change your password? ",0ah,0dh
		BYTE "1- Yes",0ah,0dh
		BYTE "2- No",0ah,0dh,0
	msgGenOrEnter BYTE "Do you want to generate a random password? ",0ah,0dh
		BYTE "1- Yes",0ah,0dh
		BYTE "2- No",0ah,0dh,0
	msgChanging BYTE " CHANGING DATA",0ah,0dh,0ah,0dh,0
	msgViewing BYTE " VIEWING DATA",0ah,0dh,0ah,0dh,0

.code
	main PROC
		call DramaticIntro
		call Menu1
		exit
	main ENDP

	DramaticIntro PROC USES eax ecx edx esi ;Procedure to stylize the console
		mov edx,offset msgIntro
		mov esi,0
		mov ecx,0
			J1:
				inc ecx
				movzx eax,byte ptr msgIntro[esi]
				inc esi
				cmp eax,0
			jne J1
		mov eax,red+(white*16)
		call setTextColor
		call clrscr
		mov dh,10
		mov dl,20
		call gotoxy
		mov esi,0
			L1:
				movzx eax,byte ptr msgIntro[esi]
				call writeChar
				cmp eax,13
				jne J2
					inc dh
					mov dl,22
					call gotoxy
				J2:
					inc esi
					mov eax,20
					call delay
			loop L1
		mov ecx,lengthof msgWait
		mov esi,0
		add dh,3
		mov dl,16
		call gotoxy
			L2:
				movzx eax,byte ptr msgWait[esi]
				call writeChar
				mov eax,20
				call delay
				inc esi
			loop L2
		call readChar
		call Clrscr
		ret
	DramaticIntro ENDP


	Menu1 PROC ;First Menu of the program, it prompts for Login or Sign Up
		mov eax,0
		J7:
			invoke displayMultiLiner,addr msgMenu
			call crlf
			J5:
				mov eax,0
				call readChar
			cmp al,'1'
			je J2
			cmp al,'2'
			je J3
			cmp al,'0'
			je J4
			invoke displayOneLiner,addr msgErrorChoice,lengthof msgErrorChoice
			jmp J5
			J2:
				call Login
			jc J6
			call Clrscr
			jmp J7
			J6:
				call Clrscr
				call Menu2
			J3:
				call clrscr
				call SignUP
		jnc J7
		exit
		J4:
			exit
		ret
	Menu1 ENDP


	Menu2 PROC
	invoke displayMultiLiner,addr msgMenuII
	call bufferBreakerII
	J5:
	mov eax,0
	call readChar
	cmp al,'1'
	je J2
	cmp al,'2'
	je J7
	cmp al,'0'
	je J3
	invoke displayOneLiner,addr msgErrorChoice,lengthof msgErrorChoice
	jmp J5
	J2:
	call clrscr
	invoke displayOneLiner,addr msgViewing,lengthof msgViewing
	invoke dataViewer,addr msgLoginU,lengthof msgLoginU,addr storedUName,lengthof storedUName
	invoke dataViewer,addr msgLoginP,lengthof msgLoginP,addr storedPass,lengthof storedPass
	invoke dataViewer,addr msgSignN,lengthof msgSignN,addr storedName,lengthof storedName
	invoke dataViewer,addr msgFileA,lengthof msgFileA,addr storedAge,lengthof storedAge
	invoke dataViewer,addr msgFileU,lengthof msgFileU,addr storedUni,lengthof storedUni
	invoke dataViewer,addr msgFileD,lengthof msgFileD,addr storedDeg,lengthof storedDeg
	call crlf
	call crlf
	invoke displayOneLiner,addr msgReturn,lengthof msgReturn
	call readChar
	call clrscr
	invoke displayMultiLiner,addr msgMenuII
	jmp J5
	J7:
	call clrscr
	invoke displayOneLiner,addr msgChanging,lengthof msgChanging
	call changeDetails
	call settingData
	call crlf
	call crlf
	invoke displayOneLiner,addr msgReturn,lengthof msgReturn
	call readChar
	call clrscr
	mov eax,0
	mov esi,0
	J8:
	mov al,msgMenuII[esi]
	call writeChar
	inc esi
	cmp msgMenuII[esi],0
	jne J8
	jmp J5
	J3:
	call clrscr
	mov eax,0
	call Menu1
	J4:
	ret
	Menu2 ENDP
dataViewer PROC, msg:ptr BYTE,lenMsg: DWORD, storedData:ptr BYTE,lenStoredData:DWORD
mov eax,0
mov esi,msg
mov ecx,lenMsg
J1:
mov al,[esi]
call writeChar
mov al,20
call Delay
inc esi
mov al,0
cmp [esi],al
jne J1
mov eax,0
mov esi,storedData
mov ecx,lenStoredData
J2:
mov al,[esi]
call writeChar
mov al,20
call Delay
inc esi
mov al,0
cmp [esi],al
jne J2
call crlf
ret
dataViewer ENDP
passwordReset PROC USES eax ebx ecx edx esi ;Procedure to clear password
mov edx,offset password
mov ecx,lengthof password
mov esi,0
L1:
mov password[esi],0
inc esi
loop L1
ret
passwordReset ENDP
SignUp PROC ;Procedure for Sign Up
J3:
cmp choice[0],49
jne J9
call ClrScr
J9:
call passwordReset
mov edx,0
mov dh,0
mov dl,5
call gotoxy
mov ecx,lengthof msgSign
mov esi,0
L1:
movzx eax,byte ptr msgSign[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L1
mov ecx,lengthof msgSignUN
mov esi,0
L2:
movzx eax,byte ptr msgSignUN[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L2
mov edx,offset username
mov ecx,lengthof username
call readString
call usernameLen
cmp eax,4
jle J1
INVOKE Str_ucase, ADDR username
J6:
mov ecx,lengthof msgLoginP
mov esi,0
L3:
movzx eax,byte ptr msgLoginP[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L3
mov edx,offset password
mov ecx,lengthof password
call readString
call passwordCheck
jnc J12
mov ecx,lengthof msgPass
mov esi,0
L21:
movzx eax,byte ptr msgPass[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L21
call crlf
jmp J14
J12:
mov ecx,lengthof msgFail
mov esi,0
L20:
movzx eax,byte ptr msgFail[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L20
call crlf
mov esi,0
J13:
movzx eax,byte ptr msgPassReq[esi]
call writeChar
mov eax,20
call delay
inc esi
mov al,0
cmp msgPassReq[esi],al
jne J13
J14:
cmp passReq,5
jl J6
J7:
mov ecx,lengthof msgSignN
mov esi,0
L4:
movzx eax,byte ptr msgSignN[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L4
mov edx,offset Pname
mov ecx,lengthof Pname
call readString
invoke symNumChecker,addr Pname
jnc J7
call nameLen
cmp eax,1
jle J7
INVOKE Str_ucase, ADDR Pname
J8:
mov ecx,lengthof msgSignA
mov esi,0
L5:
movzx eax,byte ptr msgSignA[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L5
call readInt
mov age,eax
cmp age,15
jle J8
cmp age,150
jge J8
call ageConvertor
J10:
mov ecx,lengthof msgSignU
mov esi,0
L6:
movzx eax,byte ptr msgSignU[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L6
mov edx,offset university
mov ecx,lengthof university
call readString
invoke symNumChecker,addr university
jnc J10
mov esi,offset university
invoke len,2
cmp ecx,2
jl J10
INVOKE Str_ucase, ADDR university
J11:
mov ecx,lengthof msgSignD
mov esi,0
L7:
movzx eax,byte ptr msgSignD[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L7
mov edx,offset degree
mov ecx,lengthof degree
call readString
invoke symNumChecker,addr degree
jnc J11
mov esi,offset degree
invoke len,2
cmp ecx,2
jl J11
INVOKE Str_ucase, ADDR degree
mov edx,offset msgSignSuc
call writeString
call readChar
call Clrscr
call fileWriter
stc
ret
J1:
mov esi,0
J2:
movzx eax,byte ptr msgBooleanChoice[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp msgBooleanChoice[esi],0
jne J2
call Crlf
mov edx,offset choice
mov ecx,lengthof choice
call readString
cmp choice[0],49
je J3
cmp choice[0],48
je J4
J5:
mov ecx,lengthof msgErrorChoice
mov esi,0
L8:
movzx eax,byte ptr msgErrorChoice[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L8
mov edx,offset choice
mov ecx,lengthof choice
call readString
cmp choice[0],49
je J3
cmp choice[0],48
je J4
jmp J5
J4:
mov edx,offset msgSignTer
call writeString
call readChar
clc
call clrScr
ret
SignUp ENDP
fileWriter PROC ;Procedure to write info into a file
mov esi, 4
J1:
mov al, username[esi - 4]
mov userFileName[esi], al
inc esi
cmp al, 0
jne J1
mov ebx,0
dec esi
J2:
mov al, text[ebx]
mov userFileName[esi], al
inc esi
inc ebx
cmp al, 0
jne J2
mov edx,offset userFileName
call createOutputFile
mov fileHandle,eax
mov edx,offset password
mov esi,offset password
invoke len,0
mov eax,fileHandle
call writeToFile
mov edx,offset msgFileNL
mov ecx,sizeof msgFileNL
mov eax,fileHandle
call writeToFile
mov edx,offset username
mov esi,offset username
invoke len,0
mov eax,fileHandle
call writeToFile
mov edx,offset msgFileNL
mov ecx,sizeof msgFileNL
mov eax,fileHandle
call writeToFile
mov edx,offset Pname
mov esi,offset Pname
invoke len,0
mov eax,fileHandle
call writeToFile
mov edx,offset msgFileNL
mov ecx,sizeof msgFileNL
mov eax,fileHandle
call writeToFile
mov edx,offset ageArr
mov ecx,3
mov eax,fileHandle
call writeToFile
mov edx,offset msgFileNL
mov ecx,sizeof msgFileNL
mov eax,fileHandle
call writeToFile
mov edx,offset university
mov esi,offset university
invoke len,0
mov eax,fileHandle
call writeToFile
mov edx,offset msgFileNL
mov ecx,sizeof msgFileNL
mov eax,fileHandle
call writeToFile
mov edx,offset degree
mov esi,offset degree
invoke len,0
mov eax,fileHandle
call writeToFile
mov edx,offset msgFileNL
mov ecx,sizeof msgFileNL
mov eax,fileHandle
call writeToFile
mov eax,fileHandle
call closeFile
ret
fileWriter ENDP
passwordCheck PROC ;Procedure to check validity of Password
mov passReq,0
mov ecx, LENGTHOF password
cmp ecx,0
je J1
mov esi, 0
L1:
movzx eax, byte ptr password[esi]
cmp eax, 65
jl NotCap
cmp eax, 90
jg NotCap
jmp Cap
NotCap:
inc esi
loop L1
; Capital letter found, print the message
jmp J1
Cap:
inc passReq
mov ecx, LENGTHOF password
mov esi, 0
L2:
movzx eax, byte ptr password[esi]
cmp eax, 48
jl NotNum
cmp eax, 57
jg NotNum
jmp Num
NotNum:
inc esi
loop L2
jmp J2
;Number found, print the message
Num:
inc passReq
mov ecx, LENGTHOF password
mov esi, 0
L3:
movzx eax, byte ptr password[esi]
cmp eax, 97
jl reCap
cmp eax, 122
jg reCap
jmp reNotCap
reCap:
inc esi
loop L3
; LowerCaps character found, print the message
jmp J3
reNotCap:
inc passReq
mov ecx, LENGTHOF password
mov esi, 0
L4:
movzx eax, byte ptr password[esi]
cmp eax,0
inc counter
je breakJump
inc esi
loop L4
breakJump:
cmp counter,8
jl J4
inc passReq
mov ecx, LENGTHOF password
mov esi, 0
L5:
mov al, byte ptr password[esi]
mov ebx,ecx
mov ecx,LENGTHOF symbols
sub ecx,2
J6:
cmp al, symbols[ecx]
je Sym
dec ecx
cmp ecx,0
jge J6
mov ecx,ebx
inc esi
loop L5
jmp J5
Sym:
;Symbol found, print message
inc passReq
J5:
J4:
J3:
J2:
J1:
cmp passReq,5
jl J7
stc
jmp J8
J7:
clc
J8:
ret
passwordCheck ENDP
usernameLen PROC ;Procedure to get len of username
mov esi,0
mov ecx,0
J1:
movzx eax,byte ptr username[esi]
inc ecx
inc esi
cmp eax,0
jne J1
mov eax,ecx
cmp eax,4
jg J2
mov edx,offset msgErrorChoice
mov ecx,lengthof msgErrorChoice
call writeString
call crlf
J2:
ret
usernameLen ENDP
nameLen PROC ;Procedure to get len of name
mov esi,0
mov ecx,0
J1:
movzx eax, byte ptr Pname[esi]
inc ecx
inc esi
cmp eax,0
jne J1
mov eax,ecx
cmp eax,1
jne J2
mov edx,offset msgErrorChoice
mov ecx,lengthof msgErrorChoice
call writeString
call crlf
J2:
ret
nameLen ENDP
passLen PROC
mov ecx,0
J1:
mov al, [esi]
inc ecx
inc esi
cmp al,0
jne J1
mov eax,ecx
call writeDec
ret
passLen ENDP
len PROC USES esi, bareMin:DWORD ;Procedure to get len of UNI/DEG
mov eax,0
mov ecx,0
J1:
mov al, [esi]
inc ecx
inc esi
cmp al,0
jne J1
dec ecx
mov eax,ecx
cmp eax,bareMin
jge J2
mov edx,offset msgErrorChoice
mov ecx,lengthof msgErrorChoice
call writeString
call crlf
mov ecx,eax
J2:
ret
len ENDP
ageConvertor PROC ;Procedure to convert age into ageArr
mov ecx,3
mov eax,age
L1:
mov edx,0
mov ebx,10
div ebx
add dl,48
mov ageArr[ecx-1],dl
loop L1
ret
ageConvertor ENDP
Login PROC USES eax ecx edx esi ;Procedure for Login
J1:
clc
call ClrScr
mov edx,0
mov dh,0
mov dl,5
call gotoxy
mov ecx,lengthof msgLogin
mov esi,0
L1:
movzx eax,byte ptr msgLogin[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L1
mov ecx,lengthof msgLoginU
mov esi,0
L2:
movzx eax,byte ptr msgLoginU[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L2
mov edx,offset username
mov ecx,lengthof username
call readString
INVOKE Str_ucase, ADDR username
call fileNameReader
mov edx,offset userFileName
call OpenInputFile
cmp eax,INVALID_HANDLE_VALUE
jne J3
mov eax,0
mov esi,0
mov ecx,lengthof msgFileError
L3:
mov al,msgFileError[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L3
call Crlf
mov eax,0
mov esi,0
mov ecx,lengthof msgBooleanChoice
J4:
mov al,msgBooleanChoice[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp msgBooleanChoice[esi],0
jne J4
call Crlf
J2:
mov eax,0
call readChar
cmp al,'0'
je endd
cmp al,'1'
je J1
call crlf
mov esi,0
mov eax,0
mov ecx,lengthof msgErrorChoice
L7:
mov al,msgErrorChoice[esi]
call writeChar
mov al,20
call Delay
inc esi
loop L7
jmp J2
J3:
call closeFile
call bufferBreakerII
mov ecx,lengthof msgLoginP
mov esi,0
L5:
movzx eax,byte ptr msgLoginP[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L5
mov edx,offset password
mov ecx,lengthof password
call readString
call LoginCheck
jc endd
mov eax,0
mov esi,0
J6:
mov al,msgBooleanChoice[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp msgBooleanChoice[esi],0
jne J6
J5:
mov eax,0
call readChar
cmp al,'0'
je endd
cmp al,'1'
je J1
call Crlf
mov ecx,lengthof msgErrorChoice
mov esi,0
L8:
movzx eax,byte ptr msgErrorChoice[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L8
jmp J5
endd:
ret
Login ENDP
fileNameReader PROC ;Procedure to Check if a file with a specific name exists
mov esi, 4
J1:
mov al, username[esi - 4]
mov userFileName[esi], al
inc esi
cmp al, 0
jne J1
mov ebx,0
dec esi
J2:
mov al, text[ebx]
mov userFileName[esi], al
inc esi
inc ebx
cmp al, 0
jne J2
ret
fileNameReader ENDP
LoginCheck PROC ;Procedure to check entered name and stored name
mov ebx,0
mov esi,offset storedPass
invoke len,0
mov esi,offset storedPass
mov edi,offset password
L1:
mov al,[esi]
cmp [edi],al
jne J1
inc ebx
J1:
inc esi
inc edi
loop L1
mov esi,offset storedPass
invoke len,0
cmp ebx,ecx
jne J2
mov dh,8
mov dl,17
call gotoxy
mov eax,0
mov esi,0
J5:
mov al,msgCorPass[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp msgCorPass[esi],0
jne J5
mov eax,0
mov esi,0
J4:
mov al,storedUName[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp storedUName[esi],0
jne J4
mov dh,9
mov dl,10
call gotoxy
mov esi,0
mov ecx,lengthof msgWait
L2:
movzx eax,byte ptr msgWait[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L2
call readChar
stc
ret
J2:
mov eax,0
mov esi,0
J6:
mov al,msgIncorPass[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp msgIncorPass[esi],0
jne J6
call Crlf
clc
ret
LoginCheck ENDP
fileReader PROC ;Reads from User File
mov edx,offset userFileName
call OpenInputFile
mov fileHandle,eax
mov edx,offset buffer
mov ecx,lengthof buffer
call readFromFile
mov eax,fileHandle
call closeFile
ret
fileReader ENDP
bufferLen PROC,pStoredPass:ptr BYTE
mov esi,pStoredPass
J1:
inc ecx
inc esi
mov al,0
cmp [esi],al
jne J1
add ecx,2
ret
bufferLen ENDP
bufferBreaker PROC, pBuffer:ptr BYTE,pStoredPass:ptr BYTE
mov eax,0
mov esi,pBuffer
mov edi,pStoredPass
J1:
mov al,[esi+ecx]
mov [edi],al
inc esi
inc edi
mov al,10
cmp [esi+ecx],al
jne J1
invoke bufferLen,pStoredPass
ret
bufferBreaker ENDP
bufferBreakerII PROC
mov esi, 4
J1:
mov al, username[esi - 4]
mov userFileName[esi], al
inc esi
cmp al, 0
jne J1
mov ebx,0
dec esi
J2:
mov al, text[ebx]
mov userFileName[esi], al
inc esi
inc ebx
cmp al, 0
jne J2
mov edx,offset userFileName
call OpenInputFile
mov fileHandle,eax
mov edx,offset buffer
mov ecx,lengthof buffer
call ReadFromFile
mov eax,fileHandle
call closeFile
mov ecx,0
Invoke bufferBreaker,addr buffer,addr storedPass
Invoke bufferBreaker,addr buffer,addr StoredUName
Invoke bufferBreaker,addr buffer,addr storedName
Invoke bufferBreaker,addr buffer,addr storedAge
Invoke bufferBreaker,addr buffer,addr storedUni
Invoke bufferBreaker,addr buffer,addr storedDeg
ret
bufferBreakerII ENDP
changeDetails PROC
call bufferBreakerII
cld
mov eax,0
mov esi,0
J1:
mov al,msgLoginU[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp msgLoginU[esi],0
jne J1
mov eax,0
mov esi,0
J2:
mov al,storedUName[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp storedUName[esi],0
jne J2
call Crlf
mov esi,0
mov eax,0
J3:
mov al,msgUnchangeable[esi]
call writeChar
mov eax,20
call delay
inc esi
cmp msgUnchangeable[esi],0
jne J3
J4:
invoke resetter,addr Pname,lengthof Pname
mov ecx,lengthof msgSignN
mov esi,0
L4:
movzx eax,byte ptr msgSignN[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L4
mov edx,offset Pname
mov ecx,lengthof Pname
call readString
invoke nullChecker,addr Pname,addr storedName
invoke symNumChecker,addr Pname
jnc J4
call nameLen
cmp eax,1
jle J4
INVOKE Str_ucase, ADDR Pname
J5:
mov ecx,lengthof msgSignA
mov esi,0
L5:
movzx eax,byte ptr msgSignA[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L5
mov eax,0
call readInt
mov age,eax
cmp eax,0
je J44
mov age,eax
cmp age,15
jle J5
cmp age,150
jge J5
call ageConvertor
jmp J45
J44:
invoke nullAgeChecker,addr ageArr,addr storedAge,lengthof ageArr
J45:
J6:
invoke resetter,addr university,lengthof university
mov ecx,lengthof msgSignU
mov esi,0
L6:
movzx eax,byte ptr msgSignU[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L6
mov edx,offset university
mov ecx,lengthof university
call readString
invoke nullChecker,addr university,addr storedUni
invoke symNumChecker,addr university
jnc J6
mov esi,offset university
invoke len,2
cmp eax,2
jl J6
INVOKE Str_ucase, ADDR university
J7:
invoke resetter,addr degree,lengthof degree
mov ecx,lengthof msgSignD
mov esi,0
L7:
movzx eax,byte ptr msgSignD[esi]
call writeChar
mov eax,20
call delay
inc esi
loop L7
mov edx,offset degree
mov ecx,lengthof degree
call readString
invoke nullChecker,addr degree,addr storedDeg
invoke symNumChecker,addr degree
jnc J7
mov esi,offset degree
invoke len,2
cmp eax,2
jl J7
INVOKE Str_ucase, ADDR degree
call crlf
call changePass
call fileWriter
ret
changeDetails ENDP
numberChecker PROC, string: ptr BYTE
mov esi,string
mov eax,0
J1:
mov al,[esi]
cmp al,48
jl J2
cmp al,57
jg J2
jmp J3
J2:
inc esi
mov al,0
cmp [esi],al
jne J1
stc
ret
J3:
invoke displayOneLiner,addr msgErrorChoice,lengthof msgErrorChoice
clc
ret
numberChecker ENDP
changePass PROC
mov esi,0
mov eax,0
J1:
mov al,msgChangePass[esi]
call writeChar
mov al,20
call delay
inc esi
mov al,0
cmp msgChangePass[esi],al
jne J1
J8:
call readChar
cmp al,'1'
je J2
cmp al,'2'
je J7
mov esi,0
mov eax,0
mov ecx,lengthof msgErrorChoice
L3:
mov al,msgErrorChoice[esi]
call writeChar
mov al,20
call delay
inc esi
loop L3
jmp J8
J7:
ret
J2:
mov esi,0
mov eax,0
J3:
mov al,msgGenOrEnter[esi]
call writeChar
mov al,20
call delay
inc esi
mov al,0
cmp msgGenOrEnter[esi],al
jne J3
J6:
call readChar
cmp al,'1'
je J4
cmp al,'2'
je J5
mov esi,0
mov eax,0
mov ecx,lengthof msgErrorChoice
L2:
mov al,msgErrorChoice[esi]
call writeChar
mov al,20
call delay
inc esi
loop L2
jmp J6
J5:
invoke displayOneLiner,addr msgLoginP,lengthof msgLoginP
mov edx,offset password
mov ecx,lengthof password
invoke resetter,addr password,lengthof password
call readString
call passwordChecker
jnc J5
invoke displayOneLiner,addr msgPassChanged,lengthof msgPassChanged
mov esi,offset password
invoke len,0
invoke displayOneLiner,addr password,ecx
ret
J4:
call passGen
invoke displayOneLiner,addr msgPassChanged,lengthof msgPassChanged
mov esi,offset password
invoke len,0
invoke displayOneLiner,addr password,ecx
ret
changePass ENDP
passwordChecker PROC
call passwordCheck
jnc J1
mov esi,0
mov ecx,lengthof msgPass
L2:
mov al,msgPass[esi]
call writeChar
mov al,20
call delay
inc esi
loop L2
stc
ret
J1:
mov esi,0
mov ecx,lengthof msgFail
L1:
mov al,msgFail[esi]
call writeChar
mov al,20
call delay
inc esi
loop L1
call crlf
mov esi,0
J2:
mov al,msgPassReq[esi]
call writeChar
mov al,20
call delay
inc esi
mov al,0
cmp msgPassReq[esi],al
jne J2
clc
ret
passwordChecker ENDP
passGen PROC
J1:
call randomize
mov eax,25
call RandomRange
add eax,8
mov ecx,eax
mov esi,0
mov ebx,0
L1:
mov eax,95
call randomRange
mov bl,charset[eax]
mov password[esi],bl
inc esi
loop L1
call passwordCheck
jnc J1
ret
passGen ENDP
displayOneLiner PROC,string: ptr BYTE,stringLen:DWORD
mov esi,string
mov eax,0
mov ecx,stringLen
L1:
mov al,[esi]
call writeChar
mov al,20
call delay
inc esi
loop L1
ret
displayOneLiner ENDP
displayMultiLiner PROC,string: ptr BYTE
mov esi,string
mov eax,0
J1:
mov al,[esi]
call writeChar
mov al,20
call delay
inc esi
mov al,0
cmp [esi],al
jne J1
ret
displayMultiLiner ENDP
settingData PROC
mov esi,offset username
mov edi,offset storedUName
J1:
mov al,[esi]
mov [edi],al
inc esi
inc edi
mov al,0
cmp [esi],al
jne J1
invoke resetter,addr storedPass,lengthof storedPass
mov esi,offset password
mov edi,offset storedPass
J2:
mov al,[esi]
mov [edi],al
inc esi
inc edi
mov al,0
cmp [esi],al
jne J2
mov esi,offset ageArr
mov edi,offset storedAge
mov ecx,3
L1:
mov al,[esi]
mov [edi],al
inc esi
inc edi
loop L1
invoke resetter,addr storedName,lengthof storedName
mov esi,offset Pname
mov edi,offset storedName
J3:
mov al,[esi]
mov [edi],al
inc esi
inc edi
mov al,0
cmp [esi],al
jne J3
invoke resetter,addr storedDeg,lengthof storedDeg
mov esi,offset degree
mov edi,offset storedDeg
J4:
mov al,[esi]
mov [edi],al
inc esi
inc edi
mov al,0
cmp [esi],al
jne J4
invoke resetter,addr storedUni,lengthof storedUni
mov esi,offset university
mov edi,offset storedUni
J5:
mov al,[esi]
mov [edi],al
inc esi
inc edi
mov al,0
cmp [esi],al
jne J5
ret
settingData ENDP
symNumChecker PROC USES esi,string1: ptr BYTE
mov esi,string1
J1:
mov al,[esi]
mov ecx,lengthof symNum
mov edi,0
L1:
cmp al,symNum[edi]
je J2
inc edi
loop L1
inc esi
mov al,0
cmp [esi],al
jne J1
stc
ret
J2:
invoke displayOneLiner,addr msgErrorChoice,lengthof msgErrorChoice
clc
ret
symNumChecker ENDP
nullChecker PROC,stringSource:ptr BYTE,stringDestination:ptr BYTE
mov esi,stringSource
mov al,0
cmp [esi],al
je J1
clc
ret
J1:
mov eax,0
mov esi,stringDestination
mov edi,stringSource
J2:
mov al,[esi]
mov [edi],al
inc esi
inc edi
mov al,0
cmp [esi],al
jne J2
stc
ret
nullChecker ENDP
nullAgeChecker PROC,stringSource:ptr BYTE,stringDestination:ptr BYTE,lengthofSource:DWORD
mov esi,stringDestination
mov edi,stringSource
mov ecx,lengthofSource
mov eax,0
L1:
mov al,[esi]
mov [edi],al
inc esi
inc edi
loop L1
ret
nullAgeChecker ENDP
resetter PROC USES ecx, string:ptr BYTE, stringlength: DWORD
mov esi,string
mov ecx,stringlength
mov al,0
L1:
mov [esi],al
inc esi
loop L1
ret
resetter ENDP
END main