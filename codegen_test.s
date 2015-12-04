	.text
	.globl	f
	.type	f, @function
f:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	-8(%rbp), %rbx
	movq	-16(%rbp), %r10
	addq	%rbx, %r10
	movq	-24(%rbp), %rbx
	addq	%r10, %rbx
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
.LFE0:
	.size	f, .-f
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	$1, %rbx
	movq	%rbx, -8(%rbp)
	movq	$2, %rbx
	movq	%rbx, -16(%rbp)
	movq	$3, %rbx
	movq	%rbx, -24(%rbp)
	movq	$2, %rbx
	movq	%rbx, -32(%rbp)
	movq	$5, %rbx
	movq	%rbx, -40(%rbp)
	movq	$80, %rbx
	movq	%rbx, -48(%rbp)
	movq	$400, %rbx
	movq	%rbx, -56(%rbp)
	movq	$1, %rbx
	movq	%rbx, -64(%rbp)
	movq	$0, %rbx
	movq	%rbx, -72(%rbp)
	movq	-72(%rbp), %rbx
	movq	-64(%rbp), %r10
	movq	-56(%rbp), %r11
	movq	-48(%rbp), %r12
	movq	-40(%rbp), %r13
	movq	-32(%rbp), %r14
	movq	%r13, %rax
	imulq	%r14
	movq	%rax, %r14
	addq	%r12, %r14
	cmpq	%r14, %r11
	sete	%al
	movzx	%al, %rax
	movq	%rax, %r14
	cmpq	$0, %r10
	je	.L0
	cmpq	$0, %r14
	je	.L0
	movq	$1, %r14
	jmp	.L1
.L0:
	movq	$0, %r14
.L1:
	cmpq	$0, %rbx
	jne	.L2
	cmpq	$0, %r14
	jne	.L2
	movq	$0, %r14
	jmp	.L3
.L2:
	movq	$1, %r14
.L3:
	movq	%r14, -80(%rbp)
	movq	-80(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_boolean
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-72(%rbp), %rbx
	movq	-64(%rbp), %r10
	movq	-56(%rbp), %r11
	movq	-48(%rbp), %r12
	movq	-40(%rbp), %r13
	movq	-32(%rbp), %r14
	movq	-8(%rbp), %r15
	movq	%r15, %rdi
	movq	-16(%rbp), %r15
	movq	%r15, %rsi
	movq	-24(%rbp), %r15
	movq	%r15, %rdx
	pushq	%r10
	pushq	%r11
	call	f
	popq	%r11
	popq	%r10
	movq	%rax, %r15
	movq	%r14, %rdi
	movq	%r15, %rsi
	pushq	%r10
	pushq	%r11
	call	integer_power
	popq	%r11
	popq	%r10
	movq	%rax, %r15
	movq	%r13, %rax
	imulq	%r15
	movq	%rax, %r15
	addq	%r12, %r15
	cmpq	%r15, %r11
	sete	%al
	movzx	%al, %rax
	movq	%rax, %r15
	cmpq	$0, %r10
	je	.L4
	cmpq	$0, %r15
	je	.L4
	movq	$1, %r15
	jmp	.L5
.L4:
	movq	$0, %r15
.L5:
	cmpq	$0, %rbx
	jne	.L6
	cmpq	$0, %r15
	jne	.L6
	movq	$0, %r15
	jmp	.L7
.L6:
	movq	$1, %r15
.L7:
	movq	%r15, -80(%rbp)
	movq	-80(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_boolean
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
