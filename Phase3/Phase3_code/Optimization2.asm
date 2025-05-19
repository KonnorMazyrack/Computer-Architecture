includelib ucrt.lib
includelib legacy_stdio_definitions.lib

ExitProcess PROTO

EXTERN printf: PROC

.data
	myString db "%d ", 0
	array db "3,7,2,9,1,8,4,5,6,0", 0
	ourNumber dq 0
.code
check_index PROC
	cmp rbx, 1
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
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'                       
    mov r11, r10               
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13
	lea r10, [r13]
    movzx r10, byte ptr [r13]  
    sub r10, '0'               
	mov r11, r10
    inc r13  
	push r11
	inc r13

myloop:
	pop rsi
	pop rdi
	call check_index
	cmp rax, 1
	je odd_number

even_number:
	cmp r12, 8
	je is_less
	cmp rdi, rsi
	jg print
	
odd_number:
	cmp rdi, rsi
	jl is_less
	test rbx, 1
	jnz is_less
	

is_greater:
	cmp rbx, 8
	push rsi
	push rdi
	pop rdi
	pop rsi
	je is_less 

last:
	mov rcx, offset myString
	mov rdx, rsi
	jmp print


is_less:
	push rsi
	push rdi
	pop rsi
	pop rdi
	mov rcx, offset myString
	mov rdx, rsi
	jmp print

print:
	sub rsp, 32
	inc r12
	call printf
	add rsp, 32
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