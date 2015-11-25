
	.globl x
	.data
	.align 8
	.type   x, @object
	.size   x, 8
x:
	.quad   1000

	.globl x1
	.data
	.align 8
	.type   x1, @object
	.size   x1, 8
x1:
	.quad   500

	.globl x2
	.data
	.align 8
	.type   x2, @object
	.size   x2, 8
x2:
	.quad   15

	.globl x3
	.data
	.align 8
	.type   x3, @object
	.size   x3, 8
x3:
	.quad   10

	.globl x4
	.data
	.align 8
	.type   x4, @object
	.size   x4, 8
x4:
	.quad   6

	.globl x5
	.data
	.align 8
	.type   x5, @object
	.size   x5, 8
x5:
	.quad   256

	.globl x6
	.data
	.align 8
	.type   x6, @object
	.size   x6, 8
x6:
	.quad   11

	.globl y
	.data
	.align 8
	.type   y, @object
	.size   y, 8
y:
	.quad   111

	.globl z

	section	.rodata
.str0:
	.string "i am global"
	.data
	.align 8
	.type   z, @object
	.size   z, 8
z:
	.quad   .str0

	.globl t1
	.data
	.align 8
	.type   t1, @object
	.size   t1, 8
t1:
	.quad   0

	.globl t2
	.data
	.align 8
	.type   t2, @object
	.size   t2, 8
t2:
	.quad   0
	.comm global_uninit_int, 8, 8
	.comm global_uninit_char, 8, 8
	.comm global_uninit_str, 8, 8
	.comm global_uninit_boolean, 8, 8
	.text
	.globl	func
	.type	func, @function
func:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	subq	$32, %rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	-8(%rbp), %rbx
	movq	x(%rip), %r10
	addq	%rbx, %r10
	movq	-32(%rbp), %rbx
	addq	%r10, %rbx
	movq	-40(%rbp), %r10
	addq	%rbx, %r10
	movq	-8(%rbp), %rbx
	movq	x(%rip), %r10
	addq	%rbx, %r10
	movq	-8(%rbp), %rbx
	movq	-40(%rbp), %r10
	addq	%rbx, %r10
	movq	-8(%rbp), %rbx
	movq	$1, %r10
	addq	%rbx, %r10
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	func, .-func
	.text
	.globl	f
	.type	f, @function
f:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	$35, %rbx
	movq	$92, %rbx
	movq	$0, %rbx
	movq	$13, %rbx
	movq	$10, %rbx
	movq	$9, %rbx
	movq	$53, %rbx

	section	.rodata
.str1:
	.string "h\t\n"
	.string "\\ello"
	.string "haiyan"

	section	.rodata
.str2:
	.string "hello\t\\\n"
	.string "world"

	section	.rodata
.str3:
	.string "haiyan\tmeng\\gezi\npeng"
	.string "end"

	section	.rodata
.str4:
	.string "h\t\n\\ello"
	.string ""
	movq	$1, %rbx
	movq	$0, %rbx
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE1:
	.size	f, .-f
