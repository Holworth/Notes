	.file	"addr_space.c"
	.text
	.globl	myname
	.section	.rodata
.LC0:
	.string	"Bao Yungang"
	.section	.data.rel.local,"aw",@progbits
	.align 8
	.type	myname, @object
	.size	myname, 8
myname:
	.quad	.LC0
	.comm	gdata,128,32
	.globl	bdata
	.data
	.align 16
	.type	bdata, @object
	.size	bdata, 16
bdata:
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.zero	12
	.section	.rodata
	.align 8
.LC1:
	.string	"gdata: %llX\nbdata:%llX\nldata:%llx\nddata:%llx\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$16, %edi
	call	malloc@PLT
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rdx
	leaq	-144(%rbp), %rax
	movq	%rdx, %r8
	movq	%rax, %rcx
	leaq	bdata(%rip), %rdx
	leaq	gdata(%rip), %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-152(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L3
	call	__stack_chk_fail@PLT
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-16ubuntu3) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
