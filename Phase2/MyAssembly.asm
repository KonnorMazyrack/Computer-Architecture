includelib ucrt.lib
includelib legacy_stdio_definitions.lib

ExitProcess PROTO

EXTERN printf: PROC

.data
	myString db "%d ", 0
	ourNumber dq 0
.code
check_index PROC
	test rbx, 1
	jnz odd

	mov rax, 0
	ret

odd:
	mov rax, 1
	ret
check_index ENDP
	

mainCRTStartup PROC
	mov r10, 20
	mov r11, 10
	mov r12, 14
	mov r13, 32
	mov r14, 27
	mov r15, 30
	mov rbx, 0 ;index

	push r15
	push r14
	push r13
	push r12
	push r11
	push r10 ;push all digits onto tthe stack

myloop:
	pop rsi
	pop rdi ;pop 2 numbers
	
	call check_index ;check index indicated
	cmp rax, 1
	je odd_number

even_number:
	cmp rsi, rdi
	jl is_less
	
odd_number:
	cmp rsi, rdi
	jg is_greater

is_greater:
	cmp rbx, 4
	push rsi
	push rdi
	pop rsi
	pop rdi
	jmp last

last:
	mov rcx, offset myString
	mov rdx, rsi
	
	sub rsp, 32 ;add shadow spacing, stack is already alligned

	call printf 

	add rsp, 32
	
	push rdi
	inc rbx
	cmp rbx, 5
	jge stop
	jmp myloop

is_less:
	mov rcx, offset myString
	mov rdx, rsi

	sub rsp, 32 ;add shadow spacing

	sub rsp, 8	;stack alignment

	call printf

	add rsp, 40 ;cleans up the stack

	push rdi
	inc rbx
	cmp rbx, 5
	jge stop
	jmp myloop
stop:

	mov rcx, offset myString
	mov rdx, rdi
	
	call printf ;prints the last digit from register rdi

	mov ecx, 0
	call ExitProcess
mainCRTStartup ENDP
END