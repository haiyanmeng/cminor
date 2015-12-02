
	.globl global_x
	.data
	.align 8
	.type   global_x, @object
	.size   global_x, 8
global_x:
	.quad   1000

	.globl global_x1
	.data
	.align 8
	.type   global_x1, @object
	.size   global_x1, 8
global_x1:
	.quad   500

	.globl global_x2
	.data
	.align 8
	.type   global_x2, @object
	.size   global_x2, 8
global_x2:
	.quad   15

	.globl global_x3
	.data
	.align 8
	.type   global_x3, @object
	.size   global_x3, 8
global_x3:
	.quad   10

	.globl global_x4
	.data
	.align 8
	.type   global_x4, @object
	.size   global_x4, 8
global_x4:
	.quad   6

	.globl global_x5
	.data
	.align 8
	.type   global_x5, @object
	.size   global_x5, 8
global_x5:
	.quad   256

	.globl global_x6
	.data
	.align 8
	.type   global_x6, @object
	.size   global_x6, 8
global_x6:
	.quad   11

	.globl global_y
	.data
	.align 8
	.type   global_y, @object
	.size   global_y, 8
global_y:
	.quad   111

	.globl global_z

	.section	.rodata
.str0:
	.string "i am global"
	.data
	.align 8
	.type   global_z, @object
	.size   global_z, 8
global_z:
	.quad   .str0

	.globl global_t1
	.data
	.align 8
	.type   global_t1, @object
	.size   global_t1, 8
global_t1:
	.quad   1

	.globl global_t2
	.data
	.align 8
	.type   global_t2, @object
	.size   global_t2, 8
global_t2:
	.quad   0
	.comm global_global_uninit_int, 8, 8
	.comm global_global_uninit_char, 8, 8
	.comm global_global_uninit_str, 8, 8
	.comm global_global_uninit_boolean, 8, 8
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
	movq	global_x(%rip), %r10
	addq	%rbx, %r10
	movq	-32(%rbp), %rbx
	addq	%r10, %rbx
	movq	-40(%rbp), %r10
	addq	%rbx, %r10
	movq	-8(%rbp), %rbx
	movq	global_x(%rip), %r10
	addq	%rbx, %r10
	movq	-8(%rbp), %rbx
	movq	-40(%rbp), %r10
	addq	%rbx, %r10
	movq	-8(%rbp), %rbx
	movq	$1, %r10
	addq	%rbx, %r10
	movq	%r10, %rax
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

	.section	.rodata
.str1:
	.string "h\t\n"
	.string "\\ello"
	.string "haiyan"

.text
	lea	.str1, %rbx

	.section	.rodata
.str2:
	.string "hello\t\\\n"
	.string "world"

.text
	lea	.str2, %rbx

	.section	.rodata
.str3:
	.string "haiyan\tmeng\\gezi\npeng"
	.string "end"

.text
	lea	.str3, %rbx

	.section	.rodata
.str4:
	.string "h\t\n\\ello"
	.string ""

.text
	lea	.str4, %rbx
	movq	$1, %rbx
	movq	$0, %rbx
	nop
	nop
.LFE1:
	.size	f, .-f
	.text
	.globl	print_func
	.type	print_func, @function
print_func:
.LFB2:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	-8(%rbp), %rbx
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
	movq	-16(%rbp), %rbx
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
	call	print_character
	popq	%r11
	popq	%r10
	movq	-24(%rbp), %rbx
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
	movq	-32(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
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
.LFE2:
	.size	print_func, .-print_func
	.text
	.globl	sum
	.type	sum, @function
sum:
.LFB3:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rdi
	pushq	%rsi
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	-8(%rbp), %rbx
	movq	-16(%rbp), %r10
	addq	%rbx, %r10
	movq	%r10, %rax
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
.LFE3:
	.size	sum, .-sum
	.text
	.globl	incr
	.type	incr, @function
incr:
.LFB4:
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
	addq	%rbx, %r10
	movq	%r10, %rax
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
.LFE4:
	.size	incr, .-incr
	.text
	.globl	main
	.type	main, @function
main:
.LFB5:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	subq	$48, %rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15

	.section	.rodata
.str5:
	.string "2^4"

.text
	lea	.str5, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$4, %r10
	movq	%rbx, %rdi
	movq	%r10, %rsi
	pushq	%r10
	pushq	%r11
	call	integer_power
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
	movq	$0, %r10
	movq	%rbx, %rdi
	movq	%r10, %rsi
	pushq	%r10
	pushq	%r11
	call	integer_power
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
	movq	$10, %r10
	movq	$0, %rax
	subq	%r10, %rax
	movq	%rax, %r10
	movq	%rbx, %rdi
	movq	%r10, %rsi
	pushq	%r10
	pushq	%r11
	call	integer_power
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
	movq	$3, %r10
	subq	%r10, %rbx
	movq	$0, %r10
	addq	%rbx, %r10
	movq	$2, %rbx
	addq	%r10, %rbx
	movq	$2, %r10
	subq	%r10, %rbx
	movq	$2, %r10
	addq	%rbx, %r10
	movq	$2, %rbx
	subq	%rbx, %r10
	movq	$2, %rbx
	movq	$1, %r11
	movq	%rbx, %rax
	cqo
	idivq	%r11
	movq	%rdx, %r11
	addq	%r10, %r11
	movq	$2, %rbx
	movq	$20, %r10
	movq	%rbx, %rax
	cqo
	idivq	%r10
	movq	%rax, %r10
	addq	%r11, %r10
	movq	$0, %rbx
	movq	$34343, %r11
	movq	%rbx, %rax
	imulq	%r11
	movq	%rax, %r11
	addq	%r10, %r11
	movq	$20, %rbx
	movq	$10, %r10
	subq	%r10, %rbx
	movq	%r11, %rdi
	movq	%rbx, %rsi
	pushq	%r10
	pushq	%r11
	call	integer_power
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
	movq	$2, %rbx
	movq	$3, %r10
	cmpq	%r10, %rbx
	setl	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L0

	.section	.rodata
.str6:
	.string "2<3\n"

.text
	lea	.str6, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	nop
	nop
	jmp	.L1
.L0:

	.section	.rodata
.str7:
	.string "never happen\n"

.text
	lea	.str7, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	nop
	nop
.L1:

	.section	.rodata
.str8:
	.string "2+4"

.text
	lea	.str8, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$4, %r10
	addq	%rbx, %r10
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

	.section	.rodata
.str9:
	.string "2-4"

.text
	lea	.str9, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$4, %r10
	subq	%r10, %rbx
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

	.section	.rodata
.str10:
	.string "2*4"

.text
	lea	.str10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$4, %r10
	movq	%rbx, %rax
	imulq	%r10
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

	.section	.rodata
.str11:
	.string "29/4"

.text
	lea	.str11, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$29, %rbx
	movq	$4, %r10
	movq	%rbx, %rax
	cqo
	idivq	%r10
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

	.section	.rodata
.str12:
	.string "29%4"

.text
	lea	.str12, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$29, %rbx
	movq	$4, %r10
	movq	%rbx, %rax
	cqo
	idivq	%r10
	movq	%rdx, %r10
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

	.section	.rodata
.str13:
	.string "true && true"

.text
	lea	.str13, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$1, %r10
	cmpq	$0, %rbx
	je	.L2
	cmpq	$0, %r10
	je	.L2
	movq	$1, %r10
	jmp	.L3
.L2:
	movq	$0, %r10
.L3:
	movq	%r10, %rdi
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

	.section	.rodata
.str14:
	.string "false && false"

.text
	lea	.str14, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$0, %r10
	cmpq	$0, %rbx
	je	.L4
	cmpq	$0, %r10
	je	.L4
	movq	$1, %r10
	jmp	.L5
.L4:
	movq	$0, %r10
.L5:
	movq	%r10, %rdi
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

	.section	.rodata
.str15:
	.string "true && false"

.text
	lea	.str15, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$0, %r10
	cmpq	$0, %rbx
	je	.L6
	cmpq	$0, %r10
	je	.L6
	movq	$1, %r10
	jmp	.L7
.L6:
	movq	$0, %r10
.L7:
	movq	%r10, %rdi
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

	.section	.rodata
.str16:
	.string "true || true"

.text
	lea	.str16, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$1, %r10
	cmpq	$0, %rbx
	jne	.L8
	cmpq	$0, %r10
	jne	.L8
	movq	$0, %r10
	jmp	.L9
.L8:
	movq	$1, %r10
.L9:
	movq	%r10, %rdi
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

	.section	.rodata
.str17:
	.string "false || false"

.text
	lea	.str17, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$0, %r10
	cmpq	$0, %rbx
	jne	.L10
	cmpq	$0, %r10
	jne	.L10
	movq	$0, %r10
	jmp	.L11
.L10:
	movq	$1, %r10
.L11:
	movq	%r10, %rdi
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

	.section	.rodata
.str18:
	.string "true || false"

.text
	lea	.str18, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$0, %r10
	cmpq	$0, %rbx
	jne	.L12
	cmpq	$0, %r10
	jne	.L12
	movq	$0, %r10
	jmp	.L13
.L12:
	movq	$1, %r10
.L13:
	movq	%r10, %rdi
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

	.section	.rodata
.str19:
	.string "1 <= 2"

.text
	lea	.str19, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$2, %r10
	cmpq	%r10, %rbx
	setle	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str20:
	.string "12345 <= 2"

.text
	lea	.str20, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$12345, %rbx
	movq	$2, %r10
	cmpq	%r10, %rbx
	setle	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str21:
	.string " 500 +9 < 234"

.text
	lea	.str21, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$500, %rbx
	movq	$9, %r10
	addq	%rbx, %r10
	movq	$234, %rbx
	cmpq	%rbx, %r10
	setl	%al
	movzx	%al, %rax
	movq	%rax, %rbx
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

	.section	.rodata
.str22:
	.string " 5 +9 < 234"

.text
	lea	.str22, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$9, %r10
	addq	%rbx, %r10
	movq	$234, %rbx
	cmpq	%rbx, %r10
	setl	%al
	movzx	%al, %rax
	movq	%rax, %rbx
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

	.section	.rodata
.str23:
	.string "1 < 2"

.text
	lea	.str23, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$2, %r10
	cmpq	%r10, %rbx
	setl	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str24:
	.string "1 >= 2"

.text
	lea	.str24, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$2, %r10
	cmpq	%r10, %rbx
	setge	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str25:
	.string "12345 >= 2"

.text
	lea	.str25, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$12345, %rbx
	movq	$2, %r10
	cmpq	%r10, %rbx
	setge	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str26:
	.string " 500 +9 > 234"

.text
	lea	.str26, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$500, %rbx
	movq	$9, %r10
	addq	%rbx, %r10
	movq	$234, %rbx
	cmpq	%rbx, %r10
	setg	%al
	movzx	%al, %rax
	movq	%rax, %rbx
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

	.section	.rodata
.str27:
	.string " 5 +9 > 234"

.text
	lea	.str27, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$9, %r10
	addq	%rbx, %r10
	movq	$234, %rbx
	cmpq	%rbx, %r10
	setg	%al
	movzx	%al, %rax
	movq	%rax, %rbx
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

	.section	.rodata
.str28:
	.string "1 > 2"

.text
	lea	.str28, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$2, %r10
	cmpq	%r10, %rbx
	setg	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str29:
	.string "true == false"

.text
	lea	.str29, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$0, %r10
	cmpq	%r10, %rbx
	sete	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str30:
	.string "true == true"

.text
	lea	.str30, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$1, %r10
	cmpq	%r10, %rbx
	sete	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str31:
	.string "3 == 5"

.text
	lea	.str31, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$5, %r10
	cmpq	%r10, %rbx
	sete	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str32:
	.string "(2+1+0/234) == (5/4+2*1)"

.text
	lea	.str32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$1, %r10
	addq	%rbx, %r10
	movq	$0, %rbx
	movq	$234, %r11
	movq	%rbx, %rax
	cqo
	idivq	%r11
	movq	%rax, %r11
	addq	%r10, %r11
	movq	$5, %rbx
	movq	$4, %r10
	movq	%rbx, %rax
	cqo
	idivq	%r10
	movq	%rax, %r10
	movq	$2, %rbx
	movq	$1, %r12
	movq	%rbx, %rax
	imulq	%r12
	movq	%rax, %r12
	addq	%r10, %r12
	cmpq	%r12, %r11
	sete	%al
	movzx	%al, %rax
	movq	%rax, %r12
	movq	%r12, %rdi
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

	.section	.rodata
.str33:
	.string "hello"

.text
	lea	.str33, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10

	.section	.rodata
.str34:
	.string " == "

.text
	lea	.str34, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10

	.section	.rodata
.str35:
	.string "word"

.text
	lea	.str35, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10

	.section	.rodata
.str36:
	.string "hello"

.text
	lea	.str36, %rbx

	.section	.rodata
.str37:
	.string "word"

.text
	lea	.str37, %r10
	movq	%rbx, %rdi
	movq	%r10, %rsi
	pushq	%r10
	pushq	%r11
	call	strcmp
	popq	%r11
	popq	%r10
	cmpq	$0, %rax
	je	.L14
	movq	$0, %r10
	jmp	.L15
.L14:
	movq	$1, %r10
.L15:
	movq	%r10, %rdi
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

	.section	.rodata
.str38:
	.string "hello"

.text
	lea	.str38, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10

	.section	.rodata
.str39:
	.string " != "

.text
	lea	.str39, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10

	.section	.rodata
.str40:
	.string "word"

.text
	lea	.str40, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10

	.section	.rodata
.str41:
	.string "hello"

.text
	lea	.str41, %rbx

	.section	.rodata
.str42:
	.string "word"

.text
	lea	.str42, %r10
	movq	%rbx, %rdi
	movq	%r10, %rsi
	pushq	%r10
	pushq	%r11
	call	strcmp
	popq	%r11
	popq	%r10
	cmpq	$0, %rax
	jne	.L16
	movq	$0, %r10
	jmp	.L17
.L16:
	movq	$1, %r10
.L17:
	movq	%r10, %rdi
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

	.section	.rodata
.str43:
	.string "hello111"

.text
	lea	.str43, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10

	.section	.rodata
.str44:
	.string " == "

.text
	lea	.str44, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10

	.section	.rodata
.str45:
	.string "hello111"

.text
	lea	.str45, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10

	.section	.rodata
.str46:
	.string "hello111"

.text
	lea	.str46, %rbx

	.section	.rodata
.str47:
	.string "hello111"

.text
	lea	.str47, %r10
	movq	%rbx, %rdi
	movq	%r10, %rsi
	pushq	%r10
	pushq	%r11
	call	strcmp
	popq	%r11
	popq	%r10
	cmpq	$0, %rax
	je	.L18
	movq	$0, %r10
	jmp	.L19
.L18:
	movq	$1, %r10
.L19:
	movq	%r10, %rdi
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
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.section	.rodata
.str48:
	.string "'c' == 'd'"

.text
	lea	.str48, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$99, %rbx
	movq	$100, %r10
	cmpq	%r10, %rbx
	sete	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret

	.section	.rodata
.str49:
	.string "3!=5"

.text
	lea	.str49, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$5, %r10
	cmpq	%r10, %rbx
	setne	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str50:
	.string "'c' != 'd'"

.text
	lea	.str50, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$99, %rbx
	movq	$100, %r10
	cmpq	%r10, %rbx
	setne	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str51:
	.string "true != false"

.text
	lea	.str51, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$0, %r10
	cmpq	%r10, %rbx
	setne	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str52:
	.string "false != false"

.text
	lea	.str52, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$0, %r10
	cmpq	%r10, %rbx
	setne	%al
	movzx	%al, %rax
	movq	%rax, %r10
	movq	%r10, %rdi
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
	movq	$1, %rbx
	movq	$23, %r10
	addq	%rbx, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10

	.section	.rodata
.str53:
	.string "hello"

.text
	lea	.str53, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$117, %rbx
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
	call	print_boolean
	popq	%r11
	popq	%r10
	movq	$0, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_boolean
	popq	%r11
	popq	%r10
	movq	$1, %rbx
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

	.section	.rodata
.str54:
	.string "hello"

.text
	lea	.str54, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$117, %rbx
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
	call	print_character
	popq	%r11
	popq	%r10
	movq	$1, %rbx
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

	.section	.rodata
.str55:
	.string "sum(3+20)"

.text
	lea	.str55, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$20, %r10
	movq	%rbx, %rdi
	movq	%r10, %rsi
	pushq	%r10
	pushq	%r11
	call	sum
	popq	%r11
	popq	%r10
	movq	%rax, %r11
	movq	%r11, %rdi
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

	.section	.rodata
.str56:
	.string "!(3<20)"

.text
	lea	.str56, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
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
	movq	$20, %r10
	cmpq	%r10, %rbx
	setl	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$1, %r10
	je	.L20
	movq	$1, %r10
.L20:
	movq	$0, %r10
	movq	%r10, %rdi
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

	.section	.rodata
.str57:
	.string "-(30-5)"

.text
	lea	.str57, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$30, %rbx
	movq	$5, %r10
	subq	%r10, %rbx
	movq	$0, %rax
	subq	%rbx, %rax
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
	movq	$2, %rbx
	movq	%rbx, -40(%rbp)
	movq	$3, %rbx
	movq	%rbx, -48(%rbp)
	movq	$4, %rbx
	movq	%rbx, -56(%rbp)
	movq	$5, %rbx
	movq	%rbx, -64(%rbp)
	movq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-48(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-56(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-64(%rbp), %rbx
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
	movq	-40(%rbp), %rbx
	movq	$12, %r10
	addq	%rbx, %r10
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

	.section	.rodata
.str58:
	.string "x=2\n"

.text
	lea	.str58, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10

	.section	.rodata
.str59:
	.string "x++ = "

.text
	lea	.str59, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-40(%rbp), %rbx
	addq	$1, -40(%rbp)
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10

	.section	.rodata
.str60:
	.string ", x= "

.text
	lea	.str60, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-40(%rbp), %rbx
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

	.section	.rodata
.str61:
	.string "x++ = "

.text
	lea	.str61, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-40(%rbp), %rbx
	addq	$1, -40(%rbp)
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10

	.section	.rodata
.str62:
	.string ", x= "

.text
	lea	.str62, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-40(%rbp), %rbx
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

	.section	.rodata
.str63:
	.string "x3=5\n"

.text
	lea	.str63, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10

	.section	.rodata
.str64:
	.string "x3-- = "

.text
	lea	.str64, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-64(%rbp), %rbx
	subq	$1, -64(%rbp)
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10

	.section	.rodata
.str65:
	.string ", x3= "

.text
	lea	.str65, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-64(%rbp), %rbx
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

	.section	.rodata
.str66:
	.string "x3-- = "

.text
	lea	.str66, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-64(%rbp), %rbx
	subq	$1, -64(%rbp)
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10

	.section	.rodata
.str67:
	.string ", x3= "

.text
	lea	.str67, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-64(%rbp), %rbx
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
	movq	-40(%rbp), %rbx
	movq	-48(%rbp), %r10
	movq	-64(%rbp), %r11
	movq	-56(%rbp), %r12
	movq	%r12, -64(%rbp)
	movq	%r12, -48(%rbp)
	movq	%r12, -40(%rbp)
	movq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10

	.section	.rodata
.str68:
	.string " "

.text
	lea	.str68, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-48(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-56(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-64(%rbp), %rbx
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
	movq	$222, %rbx
	movq	$126, %r10
	movq	$1, %r11

	.section	.rodata
.str69:
	.string "hello haiyan meng"

.text
	lea	.str69, %r12
	movq	%rbx, %rdi
	movq	%r10, %rsi
	movq	%r11, %rdx
	movq	%r12, %rcx
	pushq	%r10
	pushq	%r11
	call	print_func
	popq	%r11
	popq	%r10
	movq	%rax, %r13
	movq	$222, %rbx
	movq	$126, %r10
	movq	$1, %r11

	.section	.rodata
.str70:
	.string "hello haiyan meng"

.text
	lea	.str70, %r12
	movq	%rbx, %rdi
	movq	%r10, %rsi
	movq	%r11, %rdx
	movq	%r12, %rcx
	pushq	%r10
	pushq	%r11
	call	print_func
	popq	%r11
	popq	%r10
	movq	%rax, %r13
	movq	-40(%rbp), %rbx
	movq	$8, %r10
	movq	%r10, -40(%rbp)

	.section	.rodata
.str71:
	.string "x=8\n"

.text
	lea	.str71, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-40(%rbp), %rbx
	subq	$1, -40(%rbp)
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-40(%rbp), %rbx
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
	movq	-40(%rbp), %rbx
	movq	$4, %r10
	movq	%r10, -40(%rbp)

	.section	.rodata
.str72:
	.string "x=4\n"

.text
	lea	.str72, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	-40(%rbp), %rbx
	addq	$1, -40(%rbp)
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-40(%rbp), %rbx
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
	movq	-40(%rbp), %rbx
	movq	$3, %r10
	movq	%r10, -40(%rbp)
	movq	$1, %rbx
	movq	$2, %r10
	addq	%rbx, %r10
	movq	$3, %rbx
	movq	%r10, %rax
	imulq	%rbx
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
	movq	-8(%rbp), %rbx
	movq	$23, %r10
	movq	%r10, -8(%rbp)
	movq	-16(%rbp), %rbx
	movq	$112, %r10
	movq	%r10, -16(%rbp)
	movq	-24(%rbp), %rbx

	.section	.rodata
.str73:
	.string "i am param3"

.text
	lea	.str73, %r10
	movq	%r10, -24(%rbp)
	movq	-32(%rbp), %rbx
	movq	$1, %r10
	movq	$0, %r11
	cmpq	$0, %r10
	je	.L21
	cmpq	$0, %r11
	je	.L21
	movq	$1, %r11
	jmp	.L22
.L21:
	movq	$0, %r11
.L22:
	movq	%r11, -32(%rbp)
	movq	-8(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-16(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-32(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_boolean
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-24(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-8(%rbp), %rbx
	movq	-16(%rbp), %r10
	movq	-32(%rbp), %r11
	movq	-24(%rbp), %r12
	movq	%rbx, %rdi
	movq	%r10, %rsi
	movq	%r11, %rdx
	movq	%r12, %rcx
	pushq	%r10
	pushq	%r11
	call	print_func
	popq	%r11
	popq	%r10
	movq	%rax, %r13
	movq	global_x(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_x1(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_x2(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_x3(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_x4(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_x5(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_x6(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_y(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_z(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_t1(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_boolean
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_t2(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_boolean
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_int(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_char(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_str(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_boolean(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_boolean
	popq	%r11
	popq	%r10
	movq	$32, %rbx
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
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_int(%rip), %rbx
	movq	$432, %r10
	movq	%r10, global_global_uninit_int(%rip)
	movq	global_global_uninit_char(%rip), %rbx
	movq	$105, %r10
	movq	%r10, global_global_uninit_char(%rip)
	movq	global_global_uninit_str(%rip), %rbx

	.section	.rodata
.str74:
	.string "new string"

.text
	lea	.str74, %r10
	movq	%r10, global_global_uninit_str(%rip)
	movq	global_global_uninit_boolean(%rip), %rbx
	movq	$0, %r10
	movq	$1, %r11
	cmpq	$0, %r10
	jne	.L23
	cmpq	$0, %r11
	jne	.L23
	movq	$0, %r11
	jmp	.L24
.L23:
	movq	$1, %r11
.L24:
	movq	%r11, global_global_uninit_boolean(%rip)
	movq	global_global_uninit_int(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_char(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_str(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_boolean(%rip), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_boolean
	popq	%r11
	popq	%r10
	movq	$32, %rbx
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
	call	print_character
	popq	%r11
	popq	%r10
	movq	global_global_uninit_int(%rip), %rbx
	movq	$100, %r10
	cmpq	%r10, %rbx
	setg	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L25

	.section	.rodata
.str75:
	.string "greater\n"

.text
	lea	.str75, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	nop
	nop
	jmp	.L26
.L25:
	nop
.L26:
	movq	global_global_uninit_int(%rip), %rbx
	movq	$1000, %r10
	cmpq	%r10, %rbx
	setg	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L27
	nop
	nop
	jmp	.L28
.L27:

	.section	.rodata
.str76:
	.string "less\n"

.text
	lea	.str76, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	nop
	nop
.L28:
	movq	$0, %rbx
	movq	%rbx, -80(%rbp)
	movq	-72(%rbp), %rbx
	movq	$1, %r10
	movq	%r10, -72(%rbp)
.L29:
	movq	-72(%rbp), %rbx
	movq	$5, %r11
	cmpq	%r11, %rbx
	setl	%al
	movzx	%al, %rax
	movq	%rax, %r11
	cmpq	$0, %r11
	je	.L30
	movq	-80(%rbp), %rbx
	movq	-80(%rbp), %r10
	movq	-72(%rbp), %r11
	addq	%r10, %r11
	movq	%r11, -80(%rbp)
	movq	-72(%rbp), %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$32, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	nop
	nop
	movq	-72(%rbp), %rbx
	addq	$1, -72(%rbp)
	jmp	.L29
.L30:
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_character
	popq	%r11
	popq	%r10
	movq	-72(%rbp), %rbx
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
	movq	-80(%rbp), %rbx
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
	movq	global_global_uninit_int(%rip), %rbx
	movq	$4032, %r10
	movq	%r10, global_global_uninit_int(%rip)
	movq	global_global_uninit_int(%rip), %rbx
	movq	$1000, %r10
	cmpq	%r10, %rbx
	setg	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L31

	.section	.rodata
.str77:
	.string "i am greater than 1000\n"

.text
	lea	.str77, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	nop
	nop
	jmp	.L32
.L31:

	.section	.rodata
.str78:
	.string "less\n"

.text
	lea	.str78, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	nop
	nop
.L32:
	movq	$1, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$2, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$3, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$4, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$5, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$6, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$7, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_integer
	popq	%r11
	popq	%r10
	movq	$8, %rbx
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
	movq	$10, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	incr
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	incr
	popq	%r11
	popq	%r10
	movq	%rax, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	incr
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	incr
	popq	%r11
	popq	%r10
	movq	%rax, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	incr
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	incr
	popq	%r11
	popq	%r10
	movq	%rax, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	incr
	popq	%r11
	popq	%r10
	movq	%rax, %r10
	movq	%r10, %rdi
	pushq	%r10
	pushq	%r11
	call	incr
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
	movq	$2, %rbx
	movq	$3, %r10
	cmpq	%r10, %rbx
	setl	%al
	movzx	%al, %rax
	movq	%rax, %r10
	cmpq	$0, %r10
	je	.L33

	.section	.rodata
.str79:
	.string "2<3\n"

.text
	lea	.str79, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	nop
	nop
	jmp	.L34
.L33:

	.section	.rodata
.str80:
	.string "never happen\n"

.text
	lea	.str80, %rbx
	movq	%rbx, %rdi
	pushq	%r10
	pushq	%r11
	call	print_string
	popq	%r11
	popq	%r10
	nop
	nop
.L34:
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	movq	%rbp, %rsp
	popq	%rbp
	ret
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
.LFE5:
	.size	main, .-main
