	.text
	.globl	fib
	.type	fib, @function
fib:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rdi
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	-8(%rbp), %rbx
	movq	$1, %r10
	cmpq	%r10, %rbx
	setl	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L0
	movq	$0, %rbx
	movq	%rbx, %rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
	nop
	nop
	jmp	.L1
.L0:
	movq	-8(%rbp), %rbx
	movq	$2, %r10
	cmpq	%r10, %rbx
	setl	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L2
	movq	$1, %rbx
	movq	%rbx, %rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
	nop
	nop
	jmp	.L3
.L2:
	movq	-8(%rbp), %rbx
	movq	$1, %r10
	subq	%r10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	-8(%rbp), %rbx
	movq	$2, %r11
	subq	%r11, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r11
	addq	%r10, %r11
	movq	%r11, %rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
	nop
	nop
.L3:
	nop
	nop
.L1:
	nop
	nop
.LFE0:
	.size	fib, .-fib
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	$0, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$1, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$2, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$3, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$4, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$5, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$6, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$7, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$8, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$9, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	fib
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$0, %rbx
	movq	%rbx, %rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
	nop
	nop
.LFE1:
	.size	main, .-main
