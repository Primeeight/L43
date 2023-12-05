extern  printf
extern  atoi
extern  puts

 section .text           	; Code section.
        global main     	;the standard gcc entry point
main:
        ;save registers.
        push rdi
        push rsi		;save registers
        sub rsp, 8      	;allign the stack.
        cmp rdi, 4      	;if arguments are not 3, print an error.
        jne errora
	mov r12, rsi    	;r12 points to arguments.
        add r12, 8		;skip the first argument: the program name.
        xor r13d, r13d		;create a count.
convert:
	mov rdi, [r12]
	call atoi		;convert args to number.
	mov edx, ArgArr		;edx pints to array.
	mov [edx+(r13d*4)], eax	;store the value at each address of ArgArr
	inc r13d		;inc count
	add r12, 8		;point to next arg
	cmp dword r13d, 3
	jne convert		;loop
	xor r13d, r13d		;restore count to 0.
sqr:
	mov eax, [edx+8]	;process third arg first
	mov ebx, [edx+4]	;process second arg second
	
	mul eax			;square third arg
	mov ecx, eax		;store third arg
	mov eax, ebx
	mul eax			;square second arg
	mov ebx, eax		;store second arg
	mov edx, ArgArr
	mov eax, [edx]		
	mul eax			;square first arg, already stored in eax.
addition:
	add eax, ebx
compare:
	cmp eax, ecx		;compare if first arg^2 + second arg^2 = third arg^2
	je printa
	jmp printb 

printa:
	mov edi, fmt		;print a message if the arguments represent a right triangle.
	mov esi, gdMsg
        xor eax, eax
        call printf
        jmp print_int
printb:
        mov edi, fmt            ;print a message if the arguments don't represent a right triangle.
        mov esi, bdMsg
        xor eax, eax
        call printf
        jmp print_int
print_int:			;prints the arguments used.
	mov edi, ifmt		
	mov edx, ArgArr		;edx points to array.
	mov esi, [edx+(r13d*4)]	;access each element of array.
	xor eax, eax
	call printf
	inc r13d
	cmp dword r13d, 3
	jne print_int
	jmp restore
errora:
        mov edi, badArgCount
        call puts
        jmp restore
restore:
        add rsp, 8      	;restore stack to prealigned value.
        pop rsi
        pop rdi
return:

        ;return
        mov eax, 1
        mov ebx, 0
        int 80h
section .data
	ArgArr TIMES 3 dd 0	;intialize an array of size 3 to 0.
	gdMsg dw "The theorem does hold for the pararamters entered:",10,0
	bdMsg dw "The theorem does not hold for the pararamters entered:",10,0
	badArgCount db "Three arguments are required.", 10, 0
	fmt db "%s",0
	ifmt db "%d",10,0
	
