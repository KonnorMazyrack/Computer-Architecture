includelib ucrt.lib
includelib legacy_stdio_definitions.lib

ExitProcess PROTO

EXTERN printf: PROC

.data
	myString db "%d ", 0
	array db "3,7,2,9,1,8,4,5,6,0", 0
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
	mov r14, 1500

start:
	cmp r14, 0
	jz end_code
	mov r13, 0
	lea r13, [array]
	mov r11, 0
	mov r12, 0
	mov rbx, 0

next_element:
    lea r10, [r13]
    cmp byte ptr [r10], 0     
    je myloop
    movzx r10, byte ptr [r13]  
    sub r10, '0'              
    imul r11, r11, 10         
    mov r11, r10               
	test r13, 1
	jz pushDigit
    inc r13  
	cmp r11, '0'
	jl next_element

pushDigit:
	push r11
	inc r13
	jmp next_element

myloop:
	pop rsi
	pop rdi 
	call check_index 
	cmp rax, 1
	je is_greater
	cmp rsi, rdi
	jl is_less

is_greater:
	cmp rbx, 8
	push rsi
	push rdi
	pop rsi
	pop rdi

is_less:
	mov rcx, offset myString
	mov rdx, rsi
	sub rsp, 32 
	sub rsp, 8	
	call printf
	add rsp, 40 
	push rdi
	inc rbx
	cmp rbx, 9
	jge stop
	jmp myloop

stop:
	mov rcx, offset myString
	mov rdx, rdi
	call printf 
	dec r14
	jmp start

end_code:
	mov ecx, 0
	call ExitProcess
mainCRTStartup ENDP
END