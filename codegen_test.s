	.text
	.globl	sum
	.type	sum, @function
sum:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rdi
	pushq	%rsi
	subq	$16, %rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	-8(%rbp), %rbx
	movq	-16(%rbp), %r10
	cmpq	%r10, %rbx
	setg	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L0

	.section	.rodata
.str0:
	.string "the first parameter should be <= the second parameter!\n"

.text
	lea	.str0, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$1, %rbx
	movq	$0, %rax
	subq	%rbx, %rax
	movq	%rax, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	exit
	popq	%r11
	popq	%r10
	movq	%rax, %rbx
	nop
	nop
	jmp	.L1
.L0:
	nop
.L1:
	movq	-8(%rbp), %rbx
	movq	-16(%rbp), %r10
	cmpq	%r10, %rbx
	sete	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L2
	movq	-8(%rbp), %rbx
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
	movq	$0, %rbx
	movq	%rbx, -24(%rbp)
	movq	-8(%rbp), %rbx
	movq	%rbx, -32(%rbp)
.L4:
	movq	-32(%rbp), %r10
	movq	-16(%rbp), %r11
	cmpq	%r11, %r10
	setle	%al
	movzx	%al, %rax
	movq	%rax, %r11
	cmpq	$0, %r11
	je	.L5
	movq	-24(%rbp), %rbx
	movq	-32(%rbp), %r10
	addq	%rbx, %r10
	movq	%r10, -24(%rbp)
	nop
	movq	-32(%rbp), %rbx
	addq	$1, -32(%rbp)
	jmp	.L4
.L5:
	movq	-24(%rbp), %rbx
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
.L3:
	nop
	nop
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	sum, .-sum
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
	movq	$1, %rbx
	movq	%rbx, %rdi
	movq	$5, %rbx
	movq	%rbx, %rsi
	pushq	%r10
	pushq	%r11
	call	sum
	popq	%r11
	popq	%r10
	movq	%rax, %rbx
	movq	%rbx, %rdi
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
	movq	$5, %rbx
	movq	%rbx, %rsi
	pushq	%r10
	pushq	%r11
	call	sum
	popq	%r11
	popq	%r10
	movq	%rax, %rbx
	movq	%rbx, %rdi
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
	movq	$10, %rbx
	movq	%rbx, %rsi
	pushq	%r10
	pushq	%r11
	call	sum
	popq	%r11
	popq	%r10
	movq	%rax, %rbx
	movq	%rbx, %rdi
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
	movq	$0, %rax
	subq	%rbx, %rax
	movq	%rax, %rbx
	movq	%rbx, %rdi
	movq	$1, %rbx
	movq	$0, %rax
	subq	%rbx, %rax
	movq	%rax, %rbx
	movq	%rbx, %rsi
	pushq	%r10
	pushq	%r11
	call	sum
	popq	%r11
	popq	%r10
	movq	%rax, %rbx
	movq	%rbx, %rdi
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
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE1:
	.size	main, .-main
