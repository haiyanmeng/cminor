	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	$2, %rbx
	movq	%rbx, -8(%rbp)
	movq	$2, %rbx
	movq	%rbx, -16(%rbp)
	movq	$2, %rbx
	movq	%rbx, -24(%rbp)
	movq	$2, %rbx
	movq	%rbx, -32(%rbp)
	movq	$2, %rbx
	movq	%rbx, -40(%rbp)
	movq	$2, %rbx
	movq	%rbx, -48(%rbp)
	movq	$2, %rbx
	movq	%rbx, -56(%rbp)
	movq	$2, %rbx
	movq	%rbx, -64(%rbp)
	movq	$2, %rbx
	movq	%rbx, -72(%rbp)
	movq	-72(%rbp), %rbx
	movq	-64(%rbp), %r10
	movq	-56(%rbp), %r11
	movq	-48(%rbp), %r12
	movq	-40(%rbp), %r13
	movq	-32(%rbp), %r14
	movq	-24(%rbp), %r15
