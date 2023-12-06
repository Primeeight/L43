extern printf
extern puts
  section .text                  ; Code section.
        global main             ;the standard gcc entry point
main:
        ;save registers.
        push rdi
        push rsi                ;save registers
        sub rsp, 8              ;allign the stack.
	xor r13d, r13d 		;create a counter.
populate:
	mov eax, r13d
	mul r13d		;mov the counter into eax, and square it.
	mov edx, sqrArr		;edx points to the array.
        mov [edx + (r13d*4)], eax	;store the square value in the array at the pointer's index.
	inc r13d
	cmp dword r13d, 10
	jne populate		;setting the top of the loop as populate, may change as needed.
	xor r13d, r13d		;reset the counter
	xor eax, eax		;clear eax
	jmp display
display:
	mov edx, sqrArr		;edx points to the array.
	mov esi, [edx + (r13d*4)]	;retrive the elmement from the array at the pointer's index.
	jmp print
display_end:			;second half of the display loop.
	inc r13d	
	cmp dword r13d, 10
	jne display
	mov r13d, 10		;reset the counter.
	xor eax, eax
	inc dword [dpr]    ;set the boolean value to 1, enables printing array in reverse.
	jmp putm
putm:
	mov edi, revMsg
	call puts
	jmp displayr
displayr:
        mov edx, sqrArr
        mov esi, [edx + ((r13d-1)*4)]
        jmp print
displayr_end:
        dec r13d
        cmp dword r13d, 0
        jne displayr
        xor r13d, r13d
	xor eax, eax
        jmp addition

addition:
        mov edx, sqrArr         ;edx points to the array.
        add eax, [edx + (r13d*4)]       ;store the square value in the array at the pointer's index.
	inc r13d
	cmp dword r13d, 10
	jne addition
	mov ebx, eax
	xor r13d, r13d
	xor eax, eax
	jmp division
division:
	mov r13d, dword 10
	cvtsi2sd xmm0, ebx
	cvtsi2sd xmm1, r13d
	divsd xmm0, xmm1
	jmp printfloat
print:
	mov edi, ifmt
	xor eax, eax
	call printf
	cmp dword [dpr], dword 1
	jne display_end
	jmp displayr_end
printfloat:
	mov edi, ffmt
	mov eax, 1
	call printf
	jmp restore 	
restore:
        add rsp, 8              ;restore stack to prealigned value.
        pop rsi
        pop rdi
return:

        ;return
        mov eax, 1
        mov ebx, 0
        int 80h

section .data
        sqrArr TIMES 10 dd 0	;define an array of size 10 and initialize all values to 0.
	ifmt db "%d",10,0	;decimal format
	ffmt db "%The average is %f",10,0
	dpr dd 0 		;Boolean value to determine if the array will be printed in reverse
	revMsg db "Printing array in reverse"
