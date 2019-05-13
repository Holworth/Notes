	.file	"printtest.c"
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "%d\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB10:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$64, %esp
	call	___main
	movl	$1, 20(%esp)
	movl	$2, 24(%esp)
	movl	$3, 28(%esp)
	movl	$4, 32(%esp)
	movl	$5, 36(%esp)
	movl	$6, 40(%esp)
	movl	$7, 44(%esp)
	movl	$8, 48(%esp)
	movl	$9, 52(%esp)
	movl	$0, 56(%esp)
	movl	$0, 60(%esp)
	jmp	L2
L3:
	movl	60(%esp), %eax
	movl	20(%esp,%eax,4), %eax
	movl	%eax, 4(%esp)
	movl	$LC0, (%esp)
	call	_printf
	addl	$1, 60(%esp)
L2:
	cmpl	$9, 60(%esp)
	jle	L3
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE10:
	.ident	"GCC: (GNU) 5.3.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
