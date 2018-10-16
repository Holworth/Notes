
obj/coremark/main.elf:     file format elf32-tradlittlemips
obj/coremark/main.elf


Disassembly of section .text:

bfc00000 <_ftext>:
/mnt/perf_lab2/start.S:52
bfc00000:	3c08bfaf 	lui	t0,0xbfaf
bfc00004:	3508fffc 	ori	t0,t0,0xfffc
/mnt/perf_lab2/start.S:53
bfc00008:	ad000000 	sw	zero,0(t0)
/mnt/perf_lab2/start.S:54
bfc0000c:	3c0a0040 	lui	t2,0x40
/mnt/perf_lab2/start.S:55
bfc00010:	3c1d8000 	lui	sp,0x8000
bfc00014:	27bd499c 	addiu	sp,sp,18844
/mnt/perf_lab2/start.S:56
bfc00018:	3c1c8001 	lui	gp,0x8001
bfc0001c:	279c89d0 	addiu	gp,gp,-30256
/mnt/perf_lab2/start.S:58
bfc00020:	041100db 	bal	bfc00390 <shell>
/mnt/perf_lab2/start.S:59
bfc00024:	00000000 	nop
/mnt/perf_lab2/start.S:61
bfc00028:	0bf00040 	j	bfc00100 <test_finish>
/mnt/perf_lab2/start.S:62
bfc0002c:	00000000 	nop
	...
/mnt/perf_lab2/start.S:65
bfc000ec:	3c088000 	lui	t0,0x8000
/mnt/perf_lab2/start.S:66
bfc000f0:	25290001 	addiu	t1,t1,1
/mnt/perf_lab2/start.S:67
bfc000f4:	01005025 	move	t2,t0
/mnt/perf_lab2/start.S:68
bfc000f8:	01ae5821 	addu	t3,t5,t6
/mnt/perf_lab2/start.S:69
bfc000fc:	8d0c0000 	lw	t4,0(t0)

bfc00100 <test_finish>:
/mnt/perf_lab2/start.S:72
bfc00100:	25080001 	addiu	t0,t0,1
/mnt/perf_lab2/start.S:73
bfc00104:	240900ff 	li	t1,255
/mnt/perf_lab2/start.S:74
bfc00108:	3c0abfaf 	lui	t2,0xbfaf
bfc0010c:	354afff0 	ori	t2,t2,0xfff0
/mnt/perf_lab2/start.S:75
bfc00110:	ad490000 	sw	t1,0(t2)
/mnt/perf_lab2/start.S:76
bfc00114:	1000fffa 	b	bfc00100 <test_finish>
/mnt/perf_lab2/start.S:77
bfc00118:	00000000 	nop
/mnt/perf_lab2/start.S:79
bfc0011c:	3c088000 	lui	t0,0x8000
/mnt/perf_lab2/start.S:80
bfc00120:	25290001 	addiu	t1,t1,1
/mnt/perf_lab2/start.S:81
bfc00124:	01005025 	move	t2,t0
/mnt/perf_lab2/start.S:82
bfc00128:	01ae5821 	addu	t3,t5,t6
/mnt/perf_lab2/start.S:83
bfc0012c:	8d0c0000 	lw	t4,0(t0)
	...
/mnt/perf_lab2/start.S:90
bfc00380:	25080001 	addiu	t0,t0,1
/mnt/perf_lab2/start.S:91
bfc00384:	1000fffe 	b	bfc00380 <test_finish+0x280>
/mnt/perf_lab2/start.S:92
bfc00388:	00000000 	nop
test_finish():
bfc0038c:	00000000 	nop

bfc00390 <shell>:
shell():
bfc00390:	27bdffd0 	addiu	sp,sp,-48
bfc00394:	afb00024 	sw	s0,36(sp)
bfc00398:	3c10bfaf 	lui	s0,0xbfaf
bfc0039c:	36068004 	ori	a2,s0,0x8004
bfc003a0:	24051234 	li	a1,4660
bfc003a4:	3c048000 	lui	a0,0x8000
bfc003a8:	acc50000 	sw	a1,0(a2)
bfc003ac:	24840000 	addiu	a0,a0,0
bfc003b0:	afb10028 	sw	s1,40(sp)
bfc003b4:	afbf002c 	sw	ra,44(sp)
bfc003b8:	0ff0280e 	jal	bfc0a038 <puts>
bfc003bc:	24110001 	li	s1,1
bfc003c0:	24020007 	li	v0,7
bfc003c4:	240307d0 	li	v1,2000
bfc003c8:	00002021 	move	a0,zero
bfc003cc:	00002821 	move	a1,zero
bfc003d0:	24060066 	li	a2,102
bfc003d4:	24070001 	li	a3,1
bfc003d8:	afa20010 	sw	v0,16(sp)
bfc003dc:	afa30018 	sw	v1,24(sp)
bfc003e0:	0ff00180 	jal	bfc00600 <core_mark>
bfc003e4:	afb10014 	sw	s1,20(sp)
bfc003e8:	10400011 	beqz	v0,bfc00430 <shell+0xa0>
bfc003ec:	3c188000 	lui	t8,0x8000
bfc003f0:	0ff0280e 	jal	bfc0a038 <puts>
bfc003f4:	27040028 	addiu	a0,t8,40
bfc003f8:	8fbf002c 	lw	ra,44(sp)
bfc003fc:	360cf000 	ori	t4,s0,0xf000
bfc00400:	360ff008 	ori	t7,s0,0xf008
bfc00404:	360ef004 	ori	t6,s0,0xf004
bfc00408:	240d0002 	li	t5,2
bfc0040c:	adf10000 	sw	s1,0(t7)
bfc00410:	8fb00024 	lw	s0,36(sp)
bfc00414:	adcd0000 	sw	t5,0(t6)
bfc00418:	8fb10028 	lw	s1,40(sp)
bfc0041c:	ad800000 	sw	zero,0(t4)
bfc00420:	03e00008 	jr	ra
bfc00424:	27bd0030 	addiu	sp,sp,48
	...
bfc00430:	3c0b8000 	lui	t3,0x8000
bfc00434:	0ff0280e 	jal	bfc0a038 <puts>
bfc00438:	25640018 	addiu	a0,t3,24
bfc0043c:	8fbf002c 	lw	ra,44(sp)
bfc00440:	3608f000 	ori	t0,s0,0xf000
bfc00444:	360af008 	ori	t2,s0,0xf008
bfc00448:	3609f004 	ori	t1,s0,0xf004
bfc0044c:	3407ffff 	li	a3,0xffff
bfc00450:	ad510000 	sw	s1,0(t2)
bfc00454:	8fb00024 	lw	s0,36(sp)
bfc00458:	ad310000 	sw	s1,0(t1)
bfc0045c:	8fb10028 	lw	s1,40(sp)
bfc00460:	ad070000 	sw	a3,0(t0)
bfc00464:	03e00008 	jr	ra
bfc00468:	27bd0030 	addiu	sp,sp,48
bfc0046c:	00000000 	nop

bfc00470 <iterate>:
iterate():
bfc00470:	27bdffd8 	addiu	sp,sp,-40
bfc00474:	afb30020 	sw	s3,32(sp)
bfc00478:	8c93001c 	lw	s3,28(a0)
bfc0047c:	afb00014 	sw	s0,20(sp)
bfc00480:	afbf0024 	sw	ra,36(sp)
bfc00484:	afb2001c 	sw	s2,28(sp)
bfc00488:	afb10018 	sw	s1,24(sp)
bfc0048c:	00808021 	move	s0,a0
bfc00490:	a4800038 	sh	zero,56(a0)
bfc00494:	a480003a 	sh	zero,58(a0)
bfc00498:	a480003c 	sh	zero,60(a0)
bfc0049c:	1260004d 	beqz	s3,bfc005d4 <iterate+0x164>
bfc004a0:	a480003e 	sh	zero,62(a0)
bfc004a4:	24050001 	li	a1,1
bfc004a8:	2662ffff 	addiu	v0,s3,-1
bfc004ac:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc004b0:	30520001 	andi	s2,v0,0x1
bfc004b4:	96050038 	lhu	a1,56(s0)
bfc004b8:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc004bc:	00402021 	move	a0,v0
bfc004c0:	a6020038 	sh	v0,56(s0)
bfc004c4:	2405ffff 	li	a1,-1
bfc004c8:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc004cc:	02002021 	move	a0,s0
bfc004d0:	96050038 	lhu	a1,56(s0)
bfc004d4:	24110001 	li	s1,1
bfc004d8:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc004dc:	00402021 	move	a0,v0
bfc004e0:	0233182b 	sltu	v1,s1,s3
bfc004e4:	a602003a 	sh	v0,58(s0)
bfc004e8:	1060003a 	beqz	v1,bfc005d4 <iterate+0x164>
bfc004ec:	a6020038 	sh	v0,56(s0)
bfc004f0:	12400013 	beqz	s2,bfc00540 <iterate+0xd0>
bfc004f4:	02002021 	move	a0,s0
bfc004f8:	24050001 	li	a1,1
bfc004fc:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00500:	02002021 	move	a0,s0
bfc00504:	96050038 	lhu	a1,56(s0)
bfc00508:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc0050c:	00402021 	move	a0,v0
bfc00510:	a6020038 	sh	v0,56(s0)
bfc00514:	2405ffff 	li	a1,-1
bfc00518:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc0051c:	02002021 	move	a0,s0
bfc00520:	96050038 	lhu	a1,56(s0)
bfc00524:	00402021 	move	a0,v0
bfc00528:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc0052c:	26310001 	addiu	s1,s1,1
bfc00530:	0233202b 	sltu	a0,s1,s3
bfc00534:	10800027 	beqz	a0,bfc005d4 <iterate+0x164>
bfc00538:	a6020038 	sh	v0,56(s0)
bfc0053c:	02002021 	move	a0,s0
bfc00540:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00544:	24050001 	li	a1,1
bfc00548:	96050038 	lhu	a1,56(s0)
bfc0054c:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00550:	00402021 	move	a0,v0
bfc00554:	a6020038 	sh	v0,56(s0)
bfc00558:	02002021 	move	a0,s0
bfc0055c:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00560:	2405ffff 	li	a1,-1
bfc00564:	96050038 	lhu	a1,56(s0)
bfc00568:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc0056c:	00402021 	move	a0,v0
bfc00570:	26320001 	addiu	s2,s1,1
bfc00574:	02002021 	move	a0,s0
bfc00578:	24050001 	li	a1,1
bfc0057c:	16200002 	bnez	s1,bfc00588 <iterate+0x118>
bfc00580:	a6020038 	sh	v0,56(s0)
bfc00584:	a602003a 	sh	v0,58(s0)
bfc00588:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc0058c:	00000000 	nop
bfc00590:	96050038 	lhu	a1,56(s0)
bfc00594:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00598:	00402021 	move	a0,v0
bfc0059c:	a6020038 	sh	v0,56(s0)
bfc005a0:	02002021 	move	a0,s0
bfc005a4:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc005a8:	2405ffff 	li	a1,-1
bfc005ac:	96050038 	lhu	a1,56(s0)
bfc005b0:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc005b4:	00402021 	move	a0,v0
bfc005b8:	16400002 	bnez	s2,bfc005c4 <iterate+0x154>
bfc005bc:	a6020038 	sh	v0,56(s0)
bfc005c0:	a602003a 	sh	v0,58(s0)
bfc005c4:	26510001 	addiu	s1,s2,1
bfc005c8:	0233282b 	sltu	a1,s1,s3
bfc005cc:	14a0ffdb 	bnez	a1,bfc0053c <iterate+0xcc>
bfc005d0:	00000000 	nop
bfc005d4:	8fbf0024 	lw	ra,36(sp)
bfc005d8:	00001021 	move	v0,zero
bfc005dc:	8fb30020 	lw	s3,32(sp)
bfc005e0:	8fb2001c 	lw	s2,28(sp)
bfc005e4:	8fb10018 	lw	s1,24(sp)
bfc005e8:	8fb00014 	lw	s0,20(sp)
bfc005ec:	03e00008 	jr	ra
bfc005f0:	27bd0028 	addiu	sp,sp,40
	...

bfc00600 <core_mark>:
core_mark():
bfc00600:	27bdf798 	addiu	sp,sp,-2152
bfc00604:	afb40850 	sw	s4,2128(sp)
bfc00608:	afb3084c 	sw	s3,2124(sp)
bfc0060c:	00c0a021 	move	s4,a2
bfc00610:	00a09821 	move	s3,a1
bfc00614:	afb20848 	sw	s2,2120(sp)
bfc00618:	afb00840 	sw	s0,2112(sp)
bfc0061c:	00809021 	move	s2,a0
bfc00620:	8fb00878 	lw	s0,2168(sp)
bfc00624:	8fa2087c 	lw	v0,2172(sp)
bfc00628:	8fa30880 	lw	v1,2176(sp)
bfc0062c:	3c048000 	lui	a0,0x8000
bfc00630:	afb10844 	sw	s1,2116(sp)
bfc00634:	2484003c 	addiu	a0,a0,60
bfc00638:	00e08821 	move	s1,a3
bfc0063c:	02402821 	move	a1,s2
bfc00640:	02603021 	move	a2,s3
bfc00644:	02803821 	move	a3,s4
bfc00648:	afbf0864 	sw	ra,2148(sp)
bfc0064c:	afbe0860 	sw	s8,2144(sp)
bfc00650:	afb7085c 	sw	s7,2140(sp)
bfc00654:	afb60858 	sw	s6,2136(sp)
bfc00658:	afb50854 	sw	s5,2132(sp)
bfc0065c:	afa20018 	sw	v0,24(sp)
bfc00660:	afa3001c 	sw	v1,28(sp)
bfc00664:	afb10010 	sw	s1,16(sp)
bfc00668:	0ff02748 	jal	bfc09d20 <printf>
bfc0066c:	afb00014 	sw	s0,20(sp)
bfc00670:	a7b20020 	sh	s2,32(sp)
bfc00674:	a7b30022 	sh	s3,34(sp)
bfc00678:	a7b40024 	sh	s4,36(sp)
bfc0067c:	16000002 	bnez	s0,bfc00688 <core_mark+0x88>
bfc00680:	afb1003c 	sw	s1,60(sp)
bfc00684:	24100007 	li	s0,7
bfc00688:	8fa30020 	lw	v1,32(sp)
bfc0068c:	00000000 	nop
bfc00690:	14600006 	bnez	v1,bfc006ac <core_mark+0xac>
bfc00694:	24070001 	li	a3,1
bfc00698:	87a50024 	lh	a1,36(sp)
bfc0069c:	00000000 	nop
bfc006a0:	10a0034b 	beqz	a1,bfc013d0 <core_mark+0xdd0>
bfc006a4:	24060066 	li	a2,102
bfc006a8:	24070001 	li	a3,1
bfc006ac:	1067034e 	beq	v1,a3,bfc013e8 <core_mark+0xde8>
bfc006b0:	00000000 	nop
bfc006b4:	87a60020 	lh	a2,32(sp)
bfc006b8:	32050001 	andi	a1,s0,0x1
bfc006bc:	27a70064 	addiu	a3,sp,100
bfc006c0:	24ac0001 	addiu	t4,a1,1
bfc006c4:	320b0002 	andi	t3,s0,0x2
bfc006c8:	afa70028 	sw	a3,40(sp)
bfc006cc:	a7a60020 	sh	a2,32(sp)
bfc006d0:	a7a00060 	sh	zero,96(sp)
bfc006d4:	afb00040 	sw	s0,64(sp)
bfc006d8:	3182ffff 	andi	v0,t4,0xffff
bfc006dc:	116002c0 	beqz	t3,bfc011e0 <core_mark+0xbe0>
bfc006e0:	240407d0 	li	a0,2000
bfc006e4:	00401821 	move	v1,v0
bfc006e8:	320d0004 	andi	t5,s0,0x4
bfc006ec:	11a002b8 	beqz	t5,bfc011d0 <core_mark+0xbd0>
bfc006f0:	24650001 	addiu	a1,v1,1
bfc006f4:	00a01021 	move	v0,a1
bfc006f8:	304effff 	andi	t6,v0,0xffff
bfc006fc:	15c00002 	bnez	t6,bfc00708 <core_mark+0x108>
bfc00700:	008e001b 	divu	zero,a0,t6
bfc00704:	0007000d 	break	0x7
bfc00708:	32030001 	andi	v1,s0,0x1
bfc0070c:	00002012 	mflo	a0
bfc00710:	10600003 	beqz	v1,bfc00720 <core_mark+0x120>
bfc00714:	afa40038 	sw	a0,56(sp)
bfc00718:	afa7002c 	sw	a3,44(sp)
bfc0071c:	24030001 	li	v1,1
bfc00720:	320f0002 	andi	t7,s0,0x2
bfc00724:	11e00007 	beqz	t7,bfc00744 <core_mark+0x144>
bfc00728:	32180004 	andi	t8,s0,0x4
bfc0072c:	00640018 	mult	v1,a0
bfc00730:	24770001 	addiu	s7,v1,1
bfc00734:	32e3ffff 	andi	v1,s7,0xffff
bfc00738:	0000b012 	mflo	s6
bfc0073c:	00f6a821 	addu	s5,a3,s6
bfc00740:	afb50030 	sw	s5,48(sp)
bfc00744:	13000005 	beqz	t8,bfc0075c <core_mark+0x15c>
bfc00748:	321f0001 	andi	ra,s0,0x1
bfc0074c:	00640018 	mult	v1,a0
bfc00750:	0000f012 	mflo	s8
bfc00754:	00fec821 	addu	t9,a3,s8
bfc00758:	afb90034 	sw	t9,52(sp)
bfc0075c:	13e00007 	beqz	ra,bfc0077c <core_mark+0x17c>
bfc00760:	32110002 	andi	s1,s0,0x2
bfc00764:	8fa5002c 	lw	a1,44(sp)
bfc00768:	0ff02230 	jal	bfc088c0 <core_list_init>
bfc0076c:	00000000 	nop
bfc00770:	8fb00040 	lw	s0,64(sp)
bfc00774:	afa20044 	sw	v0,68(sp)
bfc00778:	32110002 	andi	s1,s0,0x2
bfc0077c:	16200280 	bnez	s1,bfc01180 <core_mark+0xb80>
bfc00780:	00000000 	nop
bfc00784:	32120004 	andi	s2,s0,0x4
bfc00788:	16400069 	bnez	s2,bfc00930 <core_mark+0x330>
bfc0078c:	00000000 	nop
bfc00790:	8fa3003c 	lw	v1,60(sp)
bfc00794:	00000000 	nop
bfc00798:	1460006f 	bnez	v1,bfc00958 <core_mark+0x358>
bfc0079c:	3c168000 	lui	s6,0x8000
bfc007a0:	24020001 	li	v0,1
bfc007a4:	27b20020 	addiu	s2,sp,32
bfc007a8:	000228c0 	sll	a1,v0,0x3
bfc007ac:	00022040 	sll	a0,v0,0x1
bfc007b0:	00851021 	addu	v0,a0,a1
bfc007b4:	0ff02744 	jal	bfc09d10 <start_time>
bfc007b8:	afa2003c 	sw	v0,60(sp)
bfc007bc:	8fb3003c 	lw	s3,60(sp)
bfc007c0:	a7a00058 	sh	zero,88(sp)
bfc007c4:	a7a0005a 	sh	zero,90(sp)
bfc007c8:	a7a0005c 	sh	zero,92(sp)
bfc007cc:	1260004d 	beqz	s3,bfc00904 <core_mark+0x304>
bfc007d0:	a7a0005e 	sh	zero,94(sp)
bfc007d4:	2667ffff 	addiu	a3,s3,-1
bfc007d8:	24050001 	li	a1,1
bfc007dc:	02402021 	move	a0,s2
bfc007e0:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc007e4:	30f10001 	andi	s1,a3,0x1
bfc007e8:	97a50058 	lhu	a1,88(sp)
bfc007ec:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc007f0:	00402021 	move	a0,v0
bfc007f4:	2405ffff 	li	a1,-1
bfc007f8:	02402021 	move	a0,s2
bfc007fc:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00800:	a7a20058 	sh	v0,88(sp)
bfc00804:	97a50058 	lhu	a1,88(sp)
bfc00808:	24100001 	li	s0,1
bfc0080c:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00810:	00402021 	move	a0,v0
bfc00814:	0213302b 	sltu	a2,s0,s3
bfc00818:	a7a2005a 	sh	v0,90(sp)
bfc0081c:	10c00039 	beqz	a2,bfc00904 <core_mark+0x304>
bfc00820:	a7a20058 	sh	v0,88(sp)
bfc00824:	12200011 	beqz	s1,bfc0086c <core_mark+0x26c>
bfc00828:	24050001 	li	a1,1
bfc0082c:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00830:	02402021 	move	a0,s2
bfc00834:	97a50058 	lhu	a1,88(sp)
bfc00838:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc0083c:	00402021 	move	a0,v0
bfc00840:	2405ffff 	li	a1,-1
bfc00844:	02402021 	move	a0,s2
bfc00848:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc0084c:	a7a20058 	sh	v0,88(sp)
bfc00850:	97a50058 	lhu	a1,88(sp)
bfc00854:	26100001 	addiu	s0,s0,1
bfc00858:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc0085c:	00402021 	move	a0,v0
bfc00860:	0213882b 	sltu	s1,s0,s3
bfc00864:	12200027 	beqz	s1,bfc00904 <core_mark+0x304>
bfc00868:	a7a20058 	sh	v0,88(sp)
bfc0086c:	02402021 	move	a0,s2
bfc00870:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00874:	24050001 	li	a1,1
bfc00878:	97a50058 	lhu	a1,88(sp)
bfc0087c:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00880:	00402021 	move	a0,v0
bfc00884:	02402021 	move	a0,s2
bfc00888:	2405ffff 	li	a1,-1
bfc0088c:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00890:	a7a20058 	sh	v0,88(sp)
bfc00894:	97a50058 	lhu	a1,88(sp)
bfc00898:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc0089c:	00402021 	move	a0,v0
bfc008a0:	26110001 	addiu	s1,s0,1
bfc008a4:	02402021 	move	a0,s2
bfc008a8:	24050001 	li	a1,1
bfc008ac:	16000002 	bnez	s0,bfc008b8 <core_mark+0x2b8>
bfc008b0:	a7a20058 	sh	v0,88(sp)
bfc008b4:	a7a2005a 	sh	v0,90(sp)
bfc008b8:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc008bc:	00000000 	nop
bfc008c0:	97a50058 	lhu	a1,88(sp)
bfc008c4:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc008c8:	00402021 	move	a0,v0
bfc008cc:	02402021 	move	a0,s2
bfc008d0:	2405ffff 	li	a1,-1
bfc008d4:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc008d8:	a7a20058 	sh	v0,88(sp)
bfc008dc:	97a50058 	lhu	a1,88(sp)
bfc008e0:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc008e4:	00402021 	move	a0,v0
bfc008e8:	16200002 	bnez	s1,bfc008f4 <core_mark+0x2f4>
bfc008ec:	a7a20058 	sh	v0,88(sp)
bfc008f0:	a7a2005a 	sh	v0,90(sp)
bfc008f4:	26300001 	addiu	s0,s1,1
bfc008f8:	0213302b 	sltu	a2,s0,s3
bfc008fc:	14c0ffdc 	bnez	a2,bfc00870 <core_mark+0x270>
bfc00900:	02402021 	move	a0,s2
bfc00904:	0ff02740 	jal	bfc09d00 <stop_time>
bfc00908:	00000000 	nop
bfc0090c:	0ff02718 	jal	bfc09c60 <get_time>
bfc00910:	00000000 	nop
bfc00914:	0ff02730 	jal	bfc09cc0 <time_in_secs>
bfc00918:	00402021 	move	a0,v0
bfc0091c:	14400234 	bnez	v0,bfc011f0 <core_mark+0xbf0>
bfc00920:	240c000a 	li	t4,10
bfc00924:	8fa2003c 	lw	v0,60(sp)
bfc00928:	0bf001eb 	j	bfc007ac <core_mark+0x1ac>
bfc0092c:	000228c0 	sll	a1,v0,0x3
bfc00930:	8fa40038 	lw	a0,56(sp)
bfc00934:	87a50020 	lh	a1,32(sp)
bfc00938:	8fa60034 	lw	a2,52(sp)
bfc0093c:	0ff01bc8 	jal	bfc06f20 <core_init_state>
bfc00940:	00000000 	nop
bfc00944:	8fa3003c 	lw	v1,60(sp)
bfc00948:	00000000 	nop
bfc0094c:	1060ff95 	beqz	v1,bfc007a4 <core_mark+0x1a4>
bfc00950:	24020001 	li	v0,1
bfc00954:	3c168000 	lui	s6,0x8000
bfc00958:	26c40068 	addiu	a0,s6,104
bfc0095c:	24150001 	li	s5,1
bfc00960:	0ff0280e 	jal	bfc0a038 <puts>
bfc00964:	af958010 	sw	s5,-32752(gp)
bfc00968:	3c19bfb0 	lui	t9,0xbfb0
bfc0096c:	af208ffc 	sw	zero,-28676(t9)
bfc00970:	af208ffc 	sw	zero,-28676(t9)
bfc00974:	af20fff8 	sw	zero,-8(t9)
bfc00978:	af208ffc 	sw	zero,-28676(t9)
bfc0097c:	af208ffc 	sw	zero,-28676(t9)
bfc00980:	8f208ffc 	lw	zero,-28676(t9)
bfc00984:	8f39fff8 	lw	t9,-8(t9)
bfc00988:	3c0fbfaf 	lui	t7,0xbfaf
bfc0098c:	35eefff8 	ori	t6,t7,0xfff8
bfc00990:	8dcd0000 	lw	t5,0(t6)
bfc00994:	00000000 	nop
bfc00998:	15a00205 	bnez	t5,bfc011b0 <core_mark+0xbb0>
bfc0099c:	3c178000 	lui	s7,0x8000
bfc009a0:	0ff02868 	jal	bfc0a1a0 <get_ns>
bfc009a4:	0000a821 	move	s5,zero
bfc009a8:	af828020 	sw	v0,-32736(gp)
bfc009ac:	24140001 	li	s4,1
bfc009b0:	3c19bfb0 	lui	t9,0xbfb0
bfc009b4:	af208ffc 	sw	zero,-28676(t9)
bfc009b8:	af208ffc 	sw	zero,-28676(t9)
bfc009bc:	af39fff8 	sw	t9,-8(t9)
bfc009c0:	af208ffc 	sw	zero,-28676(t9)
bfc009c4:	af208ffc 	sw	zero,-28676(t9)
bfc009c8:	8f208ffc 	lw	zero,-28676(t9)
bfc009cc:	8f39fff8 	lw	t9,-8(t9)
bfc009d0:	8fb3003c 	lw	s3,60(sp)
bfc009d4:	a7a00058 	sh	zero,88(sp)
bfc009d8:	a7a0005a 	sh	zero,90(sp)
bfc009dc:	a7a0005c 	sh	zero,92(sp)
bfc009e0:	1260004e 	beqz	s3,bfc00b1c <core_mark+0x51c>
bfc009e4:	a7a0005e 	sh	zero,94(sp)
bfc009e8:	27b10020 	addiu	s1,sp,32
bfc009ec:	2679ffff 	addiu	t9,s3,-1
bfc009f0:	24050001 	li	a1,1
bfc009f4:	02202021 	move	a0,s1
bfc009f8:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc009fc:	33320001 	andi	s2,t9,0x1
bfc00a00:	97a50058 	lhu	a1,88(sp)
bfc00a04:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00a08:	00402021 	move	a0,v0
bfc00a0c:	2405ffff 	li	a1,-1
bfc00a10:	02202021 	move	a0,s1
bfc00a14:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00a18:	a7a20058 	sh	v0,88(sp)
bfc00a1c:	97a50058 	lhu	a1,88(sp)
bfc00a20:	24100001 	li	s0,1
bfc00a24:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00a28:	00402021 	move	a0,v0
bfc00a2c:	0213c02b 	sltu	t8,s0,s3
bfc00a30:	a7a2005a 	sh	v0,90(sp)
bfc00a34:	13000039 	beqz	t8,bfc00b1c <core_mark+0x51c>
bfc00a38:	a7a20058 	sh	v0,88(sp)
bfc00a3c:	12400011 	beqz	s2,bfc00a84 <core_mark+0x484>
bfc00a40:	24050001 	li	a1,1
bfc00a44:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00a48:	02202021 	move	a0,s1
bfc00a4c:	97a50058 	lhu	a1,88(sp)
bfc00a50:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00a54:	00402021 	move	a0,v0
bfc00a58:	2405ffff 	li	a1,-1
bfc00a5c:	02202021 	move	a0,s1
bfc00a60:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00a64:	a7a20058 	sh	v0,88(sp)
bfc00a68:	97a50058 	lhu	a1,88(sp)
bfc00a6c:	26100001 	addiu	s0,s0,1
bfc00a70:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00a74:	00402021 	move	a0,v0
bfc00a78:	0213902b 	sltu	s2,s0,s3
bfc00a7c:	12400027 	beqz	s2,bfc00b1c <core_mark+0x51c>
bfc00a80:	a7a20058 	sh	v0,88(sp)
bfc00a84:	02202021 	move	a0,s1
bfc00a88:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00a8c:	24050001 	li	a1,1
bfc00a90:	97a50058 	lhu	a1,88(sp)
bfc00a94:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00a98:	00402021 	move	a0,v0
bfc00a9c:	02202021 	move	a0,s1
bfc00aa0:	2405ffff 	li	a1,-1
bfc00aa4:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00aa8:	a7a20058 	sh	v0,88(sp)
bfc00aac:	97a50058 	lhu	a1,88(sp)
bfc00ab0:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00ab4:	00402021 	move	a0,v0
bfc00ab8:	26120001 	addiu	s2,s0,1
bfc00abc:	02202021 	move	a0,s1
bfc00ac0:	24050001 	li	a1,1
bfc00ac4:	16000002 	bnez	s0,bfc00ad0 <core_mark+0x4d0>
bfc00ac8:	a7a20058 	sh	v0,88(sp)
bfc00acc:	a7a2005a 	sh	v0,90(sp)
bfc00ad0:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00ad4:	00000000 	nop
bfc00ad8:	97a50058 	lhu	a1,88(sp)
bfc00adc:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00ae0:	00402021 	move	a0,v0
bfc00ae4:	02202021 	move	a0,s1
bfc00ae8:	2405ffff 	li	a1,-1
bfc00aec:	0ff0246c 	jal	bfc091b0 <core_bench_list>
bfc00af0:	a7a20058 	sh	v0,88(sp)
bfc00af4:	97a50058 	lhu	a1,88(sp)
bfc00af8:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc00afc:	00402021 	move	a0,v0
bfc00b00:	16400002 	bnez	s2,bfc00b0c <core_mark+0x50c>
bfc00b04:	a7a20058 	sh	v0,88(sp)
bfc00b08:	a7a2005a 	sh	v0,90(sp)
bfc00b0c:	26500001 	addiu	s0,s2,1
bfc00b10:	0213f82b 	sltu	ra,s0,s3
bfc00b14:	17e0ffdc 	bnez	ra,bfc00a88 <core_mark+0x488>
bfc00b18:	02202021 	move	a0,s1
bfc00b1c:	3c19bfb0 	lui	t9,0xbfb0
bfc00b20:	af208ffc 	sw	zero,-28676(t9)
bfc00b24:	af208ffc 	sw	zero,-28676(t9)
bfc00b28:	af20fff8 	sw	zero,-8(t9)
bfc00b2c:	af208ffc 	sw	zero,-28676(t9)
bfc00b30:	af208ffc 	sw	zero,-28676(t9)
bfc00b34:	8f208ffc 	lw	zero,-28676(t9)
bfc00b38:	8f39fff8 	lw	t9,-8(t9)
bfc00b3c:	3c11bfaf 	lui	s1,0xbfaf
bfc00b40:	363ffff8 	ori	ra,s1,0xfff8
bfc00b44:	8ffe0000 	lw	s8,0(ra)
bfc00b48:	00000000 	nop
bfc00b4c:	17c001b4 	bnez	s8,bfc01220 <core_mark+0xc20>
bfc00b50:	00000000 	nop
bfc00b54:	0ff02868 	jal	bfc0a1a0 <get_ns>
bfc00b58:	00000000 	nop
bfc00b5c:	af828014 	sw	v0,-32748(gp)
bfc00b60:	8f898020 	lw	t1,-32736(gp)
bfc00b64:	00000000 	nop
bfc00b68:	00495023 	subu	t2,v0,t1
bfc00b6c:	af8a8018 	sw	t2,-32744(gp)
bfc00b70:	3c19bfb0 	lui	t9,0xbfb0
bfc00b74:	af208ffc 	sw	zero,-28676(t9)
bfc00b78:	af208ffc 	sw	zero,-28676(t9)
bfc00b7c:	af39fff8 	sw	t9,-8(t9)
bfc00b80:	af208ffc 	sw	zero,-28676(t9)
bfc00b84:	af208ffc 	sw	zero,-28676(t9)
bfc00b88:	8f208ffc 	lw	zero,-28676(t9)
bfc00b8c:	8f39fff8 	lw	t9,-8(t9)
bfc00b90:	3c138000 	lui	s3,0x8000
bfc00b94:	0ff0280e 	jal	bfc0a038 <puts>
bfc00b98:	26640084 	addiu	a0,s3,132
bfc00b9c:	87a40020 	lh	a0,32(sp)
bfc00ba0:	0ff01800 	jal	bfc06000 <crc16>
bfc00ba4:	00002821 	move	a1,zero
bfc00ba8:	87a40022 	lh	a0,34(sp)
bfc00bac:	0ff01800 	jal	bfc06000 <crc16>
bfc00bb0:	00402821 	move	a1,v0
bfc00bb4:	87a40024 	lh	a0,36(sp)
bfc00bb8:	0ff01800 	jal	bfc06000 <crc16>
bfc00bbc:	00402821 	move	a1,v0
bfc00bc0:	87a40038 	lh	a0,56(sp)
bfc00bc4:	0ff01800 	jal	bfc06000 <crc16>
bfc00bc8:	00402821 	move	a1,v0
bfc00bcc:	24147b05 	li	s4,31493
bfc00bd0:	1054026f 	beq	v0,s4,bfc01590 <core_mark+0xf90>
bfc00bd4:	0040b021 	move	s6,v0
bfc00bd8:	2c527b06 	sltiu	s2,v0,31494
bfc00bdc:	16400198 	bnez	s2,bfc01240 <core_mark+0xc40>
bfc00be0:	240318f2 	li	v1,6386
bfc00be4:	34048a02 	li	a0,0x8a02
bfc00be8:	10440262 	beq	v0,a0,bfc01574 <core_mark+0xf74>
bfc00bec:	3c068000 	lui	a2,0x8000
bfc00bf0:	3405e9f5 	li	a1,0xe9f5
bfc00bf4:	10450205 	beq	v0,a1,bfc0140c <core_mark+0xe0c>
bfc00bf8:	3c098000 	lui	t1,0x8000
bfc00bfc:	3410ffff 	li	s0,0xffff
bfc00c00:	0ff016e0 	jal	bfc05b80 <check_data_types>
bfc00c04:	00000000 	nop
bfc00c08:	0202f021 	addu	s8,s0,v0
bfc00c0c:	001ebc00 	sll	s7,s8,0x10
bfc00c10:	00179c03 	sra	s3,s7,0x10
bfc00c14:	3c19bfb0 	lui	t9,0xbfb0
bfc00c18:	af208ffc 	sw	zero,-28676(t9)
bfc00c1c:	af208ffc 	sw	zero,-28676(t9)
bfc00c20:	af20fff8 	sw	zero,-8(t9)
bfc00c24:	af208ffc 	sw	zero,-28676(t9)
bfc00c28:	af208ffc 	sw	zero,-28676(t9)
bfc00c2c:	8f208ffc 	lw	zero,-28676(t9)
bfc00c30:	8f39fff8 	lw	t9,-8(t9)
bfc00c34:	3c04bfaf 	lui	a0,0xbfaf
bfc00c38:	3494fff8 	ori	s4,a0,0xfff8
bfc00c3c:	8e910000 	lw	s1,0(s4)
bfc00c40:	00000000 	nop
bfc00c44:	1620023a 	bnez	s1,bfc01530 <core_mark+0xf30>
bfc00c48:	3c188000 	lui	t8,0x8000
bfc00c4c:	8f8d8018 	lw	t5,-32744(gp)
bfc00c50:	348ef010 	ori	t6,a0,0xf010
bfc00c54:	adcd0000 	sw	t5,0(t6)
bfc00c58:	3c1f8000 	lui	ra,0x8000
bfc00c5c:	8fa50038 	lw	a1,56(sp)
bfc00c60:	27e4020c 	addiu	a0,ra,524
bfc00c64:	0ff02748 	jal	bfc09d20 <printf>
bfc00c68:	241203e8 	li	s2,1000
bfc00c6c:	3c0c8000 	lui	t4,0x8000
bfc00c70:	8f858018 	lw	a1,-32744(gp)
bfc00c74:	0ff02748 	jal	bfc09d20 <printf>
bfc00c78:	25840224 	addiu	a0,t4,548
bfc00c7c:	8f8b8018 	lw	t3,-32744(gp)
bfc00c80:	16400002 	bnez	s2,bfc00c8c <core_mark+0x68c>
bfc00c84:	0172001b 	divu	zero,t3,s2
bfc00c88:	0007000d 	break	0x7
bfc00c8c:	8f978010 	lw	s7,-32752(gp)
bfc00c90:	8fb4003c 	lw	s4,60(sp)
bfc00c94:	3c113b9a 	lui	s1,0x3b9a
bfc00c98:	3626ca00 	ori	a2,s1,0xca00
bfc00c9c:	3c1e8000 	lui	s8,0x8000
bfc00ca0:	27c40234 	addiu	a0,s8,564
bfc00ca4:	00003812 	mflo	a3
	...
bfc00cb0:	02970018 	mult	s4,s7
bfc00cb4:	00005012 	mflo	t2
	...
bfc00cc0:	01460018 	mult	t2,a2
bfc00cc4:	00002812 	mflo	a1
bfc00cc8:	00000000 	nop
bfc00ccc:	14e00002 	bnez	a3,bfc00cd8 <core_mark+0x6d8>
bfc00cd0:	00a7001b 	divu	zero,a1,a3
bfc00cd4:	0007000d 	break	0x7
bfc00cd8:	00002812 	mflo	a1
bfc00cdc:	0ff02748 	jal	bfc09d20 <printf>
bfc00ce0:	3c100115 	lui	s0,0x115
bfc00ce4:	8f958018 	lw	s5,-32744(gp)
bfc00ce8:	8fa2003c 	lw	v0,60(sp)
bfc00cec:	16400002 	bnez	s2,bfc00cf8 <core_mark+0x6f8>
bfc00cf0:	02b2001b 	divu	zero,s5,s2
bfc00cf4:	0007000d 	break	0x7
bfc00cf8:	36036b88 	ori	v1,s0,0x6b88
bfc00cfc:	3c048000 	lui	a0,0x8000
bfc00d00:	24840250 	addiu	a0,a0,592
bfc00d04:	24050037 	li	a1,55
bfc00d08:	00004812 	mflo	t1
	...
bfc00d14:	00430018 	mult	v0,v1
bfc00d18:	00004012 	mflo	t0
bfc00d1c:	00000000 	nop
bfc00d20:	15200002 	bnez	t1,bfc00d2c <core_mark+0x72c>
bfc00d24:	0109001b 	divu	zero,t0,t1
bfc00d28:	0007000d 	break	0x7
bfc00d2c:	0000c812 	mflo	t9
bfc00d30:	0ff02748 	jal	bfc09d20 <printf>
bfc00d34:	af99801c 	sw	t9,-32740(gp)
bfc00d38:	3c188000 	lui	t8,0x8000
bfc00d3c:	8f85801c 	lw	a1,-32740(gp)
bfc00d40:	0ff02748 	jal	bfc09d20 <printf>
bfc00d44:	27040270 	addiu	a0,t8,624
bfc00d48:	3c0f8000 	lui	t7,0x8000
bfc00d4c:	0ff0280e 	jal	bfc0a038 <puts>
bfc00d50:	25e4028c 	addiu	a0,t7,652
bfc00d54:	3c0e8000 	lui	t6,0x8000
bfc00d58:	0ff0280e 	jal	bfc0a038 <puts>
bfc00d5c:	25c402e8 	addiu	a0,t6,744
bfc00d60:	3c0d8000 	lui	t5,0x8000
bfc00d64:	0ff0280e 	jal	bfc0a038 <puts>
bfc00d68:	25a4032c 	addiu	a0,t5,812
bfc00d6c:	8fa5003c 	lw	a1,60(sp)
bfc00d70:	3c0c8000 	lui	t4,0x8000
bfc00d74:	8f868018 	lw	a2,-32744(gp)
bfc00d78:	0ff02748 	jal	bfc09d20 <printf>
bfc00d7c:	25840368 	addiu	a0,t4,872
bfc00d80:	3c0b8000 	lui	t3,0x8000
bfc00d84:	25640394 	addiu	a0,t3,916
bfc00d88:	0ff02748 	jal	bfc09d20 <printf>
bfc00d8c:	00002821 	move	a1,zero
bfc00d90:	3c19bfb0 	lui	t9,0xbfb0
bfc00d94:	af208ffc 	sw	zero,-28676(t9)
bfc00d98:	af208ffc 	sw	zero,-28676(t9)
bfc00d9c:	af39fff8 	sw	t9,-8(t9)
bfc00da0:	af208ffc 	sw	zero,-28676(t9)
bfc00da4:	af208ffc 	sw	zero,-28676(t9)
bfc00da8:	8f208ffc 	lw	zero,-28676(t9)
bfc00dac:	8f39fff8 	lw	t9,-8(t9)
bfc00db0:	8f878010 	lw	a3,-32752(gp)
bfc00db4:	8fb2003c 	lw	s2,60(sp)
bfc00db8:	3c158000 	lui	s5,0x8000
bfc00dbc:	00f20018 	mult	a3,s2
bfc00dc0:	26a403c4 	addiu	a0,s5,964
bfc00dc4:	00002812 	mflo	a1
bfc00dc8:	0ff02748 	jal	bfc09d20 <printf>
bfc00dcc:	3c108000 	lui	s0,0x8000
bfc00dd0:	3c048000 	lui	a0,0x8000
bfc00dd4:	248403dc 	addiu	a0,a0,988
bfc00dd8:	0ff02748 	jal	bfc09d20 <printf>
bfc00ddc:	260503f4 	addiu	a1,s0,1012
bfc00de0:	3c038000 	lui	v1,0x8000
bfc00de4:	3c028000 	lui	v0,0x8000
bfc00de8:	24640400 	addiu	a0,v1,1024
bfc00dec:	0ff02748 	jal	bfc09d20 <printf>
bfc00df0:	24450418 	addiu	a1,v0,1048
bfc00df4:	3c098000 	lui	t1,0x8000
bfc00df8:	3c088000 	lui	t0,0x8000
bfc00dfc:	252404c8 	addiu	a0,t1,1224
bfc00e00:	0ff02748 	jal	bfc09d20 <printf>
bfc00e04:	250504e0 	addiu	a1,t0,1248
bfc00e08:	3c198000 	lui	t9,0x8000
bfc00e0c:	02c02821 	move	a1,s6
bfc00e10:	0ff02748 	jal	bfc09d20 <printf>
bfc00e14:	27240530 	addiu	a0,t9,1328
bfc00e18:	8fa30040 	lw	v1,64(sp)
bfc00e1c:	00000000 	nop
bfc00e20:	30760001 	andi	s6,v1,0x1
bfc00e24:	16c0017e 	bnez	s6,bfc01420 <core_mark+0xe20>
bfc00e28:	00000000 	nop
bfc00e2c:	8f868010 	lw	a2,-32752(gp)
bfc00e30:	30710002 	andi	s1,v1,0x2
bfc00e34:	12200041 	beqz	s1,bfc00f3c <core_mark+0x93c>
bfc00e38:	30700004 	andi	s0,v1,0x4
bfc00e3c:	10c0003f 	beqz	a2,bfc00f3c <core_mark+0x93c>
bfc00e40:	3c0e8000 	lui	t6,0x8000
bfc00e44:	25d20568 	addiu	s2,t6,1384
bfc00e48:	00008021 	move	s0,zero
bfc00e4c:	27b10020 	addiu	s1,sp,32
bfc00e50:	00101980 	sll	v1,s0,0x6
bfc00e54:	00102080 	sll	a0,s0,0x2
bfc00e58:	00831021 	addu	v0,a0,v1
bfc00e5c:	02224821 	addu	t1,s1,v0
bfc00e60:	9526003c 	lhu	a2,60(t1)
bfc00e64:	02002821 	move	a1,s0
bfc00e68:	0ff02748 	jal	bfc09d20 <printf>
bfc00e6c:	02402021 	move	a0,s2
bfc00e70:	26080001 	addiu	t0,s0,1
bfc00e74:	3110ffff 	andi	s0,t0,0xffff
bfc00e78:	8f868010 	lw	a2,-32752(gp)
bfc00e7c:	0010b080 	sll	s6,s0,0x2
bfc00e80:	0010c980 	sll	t9,s0,0x6
bfc00e84:	02d9c021 	addu	t8,s6,t9
bfc00e88:	0206782b 	sltu	t7,s0,a2
bfc00e8c:	02402021 	move	a0,s2
bfc00e90:	02381821 	addu	v1,s1,t8
bfc00e94:	11e00026 	beqz	t7,bfc00f30 <core_mark+0x930>
bfc00e98:	02002821 	move	a1,s0
bfc00e9c:	9466003c 	lhu	a2,60(v1)
bfc00ea0:	0ff02748 	jal	bfc09d20 <printf>
bfc00ea4:	00000000 	nop
bfc00ea8:	260e0001 	addiu	t6,s0,1
bfc00eac:	31d0ffff 	andi	s0,t6,0xffff
bfc00eb0:	8f868010 	lw	a2,-32752(gp)
bfc00eb4:	00106080 	sll	t4,s0,0x2
bfc00eb8:	00106980 	sll	t5,s0,0x6
bfc00ebc:	018d5821 	addu	t3,t4,t5
bfc00ec0:	0206f02b 	sltu	s8,s0,a2
bfc00ec4:	02402021 	move	a0,s2
bfc00ec8:	022b1821 	addu	v1,s1,t3
bfc00ecc:	13c00018 	beqz	s8,bfc00f30 <core_mark+0x930>
bfc00ed0:	02002821 	move	a1,s0
bfc00ed4:	9466003c 	lhu	a2,60(v1)
bfc00ed8:	0ff02748 	jal	bfc09d20 <printf>
bfc00edc:	00000000 	nop
bfc00ee0:	26080001 	addiu	t0,s0,1
bfc00ee4:	3110ffff 	andi	s0,t0,0xffff
bfc00ee8:	8f868010 	lw	a2,-32752(gp)
bfc00eec:	0010b080 	sll	s6,s0,0x2
bfc00ef0:	0010c980 	sll	t9,s0,0x6
bfc00ef4:	02d9c021 	addu	t8,s6,t9
bfc00ef8:	0206782b 	sltu	t7,s0,a2
bfc00efc:	02402021 	move	a0,s2
bfc00f00:	02381821 	addu	v1,s1,t8
bfc00f04:	11e0000a 	beqz	t7,bfc00f30 <core_mark+0x930>
bfc00f08:	02002821 	move	a1,s0
bfc00f0c:	9466003c 	lhu	a2,60(v1)
bfc00f10:	0ff02748 	jal	bfc09d20 <printf>
bfc00f14:	00000000 	nop
bfc00f18:	26020001 	addiu	v0,s0,1
bfc00f1c:	8f868010 	lw	a2,-32752(gp)
bfc00f20:	3050ffff 	andi	s0,v0,0xffff
bfc00f24:	0206482b 	sltu	t1,s0,a2
bfc00f28:	1520ffca 	bnez	t1,bfc00e54 <core_mark+0x854>
bfc00f2c:	00101980 	sll	v1,s0,0x6
bfc00f30:	8fa30040 	lw	v1,64(sp)
bfc00f34:	00000000 	nop
bfc00f38:	30700004 	andi	s0,v1,0x4
bfc00f3c:	1200003d 	beqz	s0,bfc01034 <core_mark+0xa34>
bfc00f40:	00000000 	nop
bfc00f44:	10c00077 	beqz	a2,bfc01124 <core_mark+0xb24>
bfc00f48:	00000000 	nop
bfc00f4c:	3c158000 	lui	s5,0x8000
bfc00f50:	26b20584 	addiu	s2,s5,1412
bfc00f54:	00008021 	move	s0,zero
bfc00f58:	27b10020 	addiu	s1,sp,32
bfc00f5c:	00106080 	sll	t4,s0,0x2
bfc00f60:	00103180 	sll	a2,s0,0x6
bfc00f64:	01865821 	addu	t3,t4,a2
bfc00f68:	022bf021 	addu	s8,s1,t3
bfc00f6c:	97c6003e 	lhu	a2,62(s8)
bfc00f70:	02002821 	move	a1,s0
bfc00f74:	02402021 	move	a0,s2
bfc00f78:	0ff02748 	jal	bfc09d20 <printf>
bfc00f7c:	26170001 	addiu	s7,s0,1
bfc00f80:	32f0ffff 	andi	s0,s7,0xffff
bfc00f84:	8f868010 	lw	a2,-32752(gp)
bfc00f88:	00105080 	sll	t2,s0,0x2
bfc00f8c:	0010a180 	sll	s4,s0,0x6
bfc00f90:	01542821 	addu	a1,t2,s4
bfc00f94:	0206382b 	sltu	a3,s0,a2
bfc00f98:	02251821 	addu	v1,s1,a1
bfc00f9c:	02402021 	move	a0,s2
bfc00fa0:	10e00024 	beqz	a3,bfc01034 <core_mark+0xa34>
bfc00fa4:	02002821 	move	a1,s0
bfc00fa8:	9466003e 	lhu	a2,62(v1)
bfc00fac:	0ff02748 	jal	bfc09d20 <printf>
bfc00fb0:	00000000 	nop
bfc00fb4:	26030001 	addiu	v1,s0,1
bfc00fb8:	3070ffff 	andi	s0,v1,0xffff
bfc00fbc:	8f868010 	lw	a2,-32752(gp)
bfc00fc0:	00104880 	sll	t1,s0,0x2
bfc00fc4:	00101180 	sll	v0,s0,0x6
bfc00fc8:	01224021 	addu	t0,t1,v0
bfc00fcc:	0206c82b 	sltu	t9,s0,a2
bfc00fd0:	02402021 	move	a0,s2
bfc00fd4:	02281821 	addu	v1,s1,t0
bfc00fd8:	13200016 	beqz	t9,bfc01034 <core_mark+0xa34>
bfc00fdc:	02002821 	move	a1,s0
bfc00fe0:	9466003e 	lhu	a2,62(v1)
bfc00fe4:	0ff02748 	jal	bfc09d20 <printf>
bfc00fe8:	26140001 	addiu	s4,s0,1
bfc00fec:	3290ffff 	andi	s0,s4,0xffff
bfc00ff0:	8f868010 	lw	a2,-32752(gp)
bfc00ff4:	00102880 	sll	a1,s0,0x2
bfc00ff8:	00105180 	sll	t2,s0,0x6
bfc00ffc:	00aa3821 	addu	a3,a1,t2
bfc01000:	0206a82b 	sltu	s5,s0,a2
bfc01004:	02402021 	move	a0,s2
bfc01008:	02271821 	addu	v1,s1,a3
bfc0100c:	12a00009 	beqz	s5,bfc01034 <core_mark+0xa34>
bfc01010:	02002821 	move	a1,s0
bfc01014:	9466003e 	lhu	a2,62(v1)
bfc01018:	0ff02748 	jal	bfc09d20 <printf>
bfc0101c:	26170001 	addiu	s7,s0,1
bfc01020:	8f868010 	lw	a2,-32752(gp)
bfc01024:	32f0ffff 	andi	s0,s7,0xffff
bfc01028:	0206202b 	sltu	a0,s0,a2
bfc0102c:	1480ffcb 	bnez	a0,bfc00f5c <core_mark+0x95c>
bfc01030:	00000000 	nop
bfc01034:	10c0003b 	beqz	a2,bfc01124 <core_mark+0xb24>
bfc01038:	00000000 	nop
bfc0103c:	3c1f8000 	lui	ra,0x8000
bfc01040:	27f205a0 	addiu	s2,ra,1440
bfc01044:	00008021 	move	s0,zero
bfc01048:	27b10020 	addiu	s1,sp,32
bfc0104c:	00101080 	sll	v0,s0,0x2
bfc01050:	00102180 	sll	a0,s0,0x6
bfc01054:	00444821 	addu	t1,v0,a0
bfc01058:	02294021 	addu	t0,s1,t1
bfc0105c:	95060038 	lhu	a2,56(t0)
bfc01060:	02002821 	move	a1,s0
bfc01064:	0ff02748 	jal	bfc09d20 <printf>
bfc01068:	02402021 	move	a0,s2
bfc0106c:	26190001 	addiu	t9,s0,1
bfc01070:	3330ffff 	andi	s0,t9,0xffff
bfc01074:	8f8e8010 	lw	t6,-32752(gp)
bfc01078:	0010c080 	sll	t8,s0,0x2
bfc0107c:	0010b180 	sll	s6,s0,0x6
bfc01080:	03167821 	addu	t7,t8,s6
bfc01084:	020e682b 	sltu	t5,s0,t6
bfc01088:	02402021 	move	a0,s2
bfc0108c:	022f1821 	addu	v1,s1,t7
bfc01090:	11a00024 	beqz	t5,bfc01124 <core_mark+0xb24>
bfc01094:	02002821 	move	a1,s0
bfc01098:	94660038 	lhu	a2,56(v1)
bfc0109c:	0ff02748 	jal	bfc09d20 <printf>
bfc010a0:	26170001 	addiu	s7,s0,1
bfc010a4:	32f0ffff 	andi	s0,s7,0xffff
bfc010a8:	8f878010 	lw	a3,-32752(gp)
bfc010ac:	00105080 	sll	t2,s0,0x2
bfc010b0:	0010a180 	sll	s4,s0,0x6
bfc010b4:	01542821 	addu	a1,t2,s4
bfc010b8:	0207a82b 	sltu	s5,s0,a3
bfc010bc:	02251821 	addu	v1,s1,a1
bfc010c0:	02402021 	move	a0,s2
bfc010c4:	12a00017 	beqz	s5,bfc01124 <core_mark+0xb24>
bfc010c8:	02002821 	move	a1,s0
bfc010cc:	94660038 	lhu	a2,56(v1)
bfc010d0:	0ff02748 	jal	bfc09d20 <printf>
bfc010d4:	00000000 	nop
bfc010d8:	260e0001 	addiu	t6,s0,1
bfc010dc:	31d0ffff 	andi	s0,t6,0xffff
bfc010e0:	8f8b8010 	lw	t3,-32752(gp)
bfc010e4:	00103080 	sll	a2,s0,0x2
bfc010e8:	00106980 	sll	t5,s0,0x6
bfc010ec:	00cd6021 	addu	t4,a2,t5
bfc010f0:	020bf02b 	sltu	s8,s0,t3
bfc010f4:	02402021 	move	a0,s2
bfc010f8:	022c1821 	addu	v1,s1,t4
bfc010fc:	13c00009 	beqz	s8,bfc01124 <core_mark+0xb24>
bfc01100:	02002821 	move	a1,s0
bfc01104:	94660038 	lhu	a2,56(v1)
bfc01108:	0ff02748 	jal	bfc09d20 <printf>
bfc0110c:	26160001 	addiu	s6,s0,1
bfc01110:	8f988010 	lw	t8,-32752(gp)
bfc01114:	32d0ffff 	andi	s0,s6,0xffff
bfc01118:	0218782b 	sltu	t7,s0,t8
bfc0111c:	15e0ffcb 	bnez	t7,bfc0104c <core_mark+0xa4c>
bfc01120:	00000000 	nop
bfc01124:	1260010a 	beqz	s3,bfc01550 <core_mark+0xf50>
bfc01128:	3c128000 	lui	s2,0x8000
bfc0112c:	1a60010c 	blez	s3,bfc01560 <core_mark+0xf60>
bfc01130:	3c118000 	lui	s1,0x8000
bfc01134:	0ff0280e 	jal	bfc0a038 <puts>
bfc01138:	26240608 	addiu	a0,s1,1544
bfc0113c:	0ff0273c 	jal	bfc09cf0 <portable_fini>
bfc01140:	27a40062 	addiu	a0,sp,98
bfc01144:	8fbf0864 	lw	ra,2148(sp)
bfc01148:	02601021 	move	v0,s3
bfc0114c:	8fbe0860 	lw	s8,2144(sp)
bfc01150:	8fb7085c 	lw	s7,2140(sp)
bfc01154:	8fb60858 	lw	s6,2136(sp)
bfc01158:	8fb50854 	lw	s5,2132(sp)
bfc0115c:	8fb40850 	lw	s4,2128(sp)
bfc01160:	8fb3084c 	lw	s3,2124(sp)
bfc01164:	8fb20848 	lw	s2,2120(sp)
bfc01168:	8fb10844 	lw	s1,2116(sp)
bfc0116c:	8fb00840 	lw	s0,2112(sp)
bfc01170:	03e00008 	jr	ra
bfc01174:	27bd0868 	addiu	sp,sp,2152
	...
bfc01180:	87b30022 	lh	s3,34(sp)
bfc01184:	87b40020 	lh	s4,32(sp)
bfc01188:	00138400 	sll	s0,s3,0x10
bfc0118c:	8fa40038 	lw	a0,56(sp)
bfc01190:	8fa50030 	lw	a1,48(sp)
bfc01194:	02143025 	or	a2,s0,s4
bfc01198:	0ff00570 	jal	bfc015c0 <core_init_matrix>
bfc0119c:	27a70048 	addiu	a3,sp,72
bfc011a0:	8fb00040 	lw	s0,64(sp)
bfc011a4:	0bf001e2 	j	bfc00788 <core_mark+0x188>
bfc011a8:	32120004 	andi	s2,s0,0x4
bfc011ac:	00000000 	nop
bfc011b0:	0ff0280e 	jal	bfc0a038 <puts>
bfc011b4:	26e40074 	addiu	a0,s7,116
bfc011b8:	24150001 	li	s5,1
bfc011bc:	0bf0026c 	j	bfc009b0 <core_mark+0x3b0>
bfc011c0:	24140002 	li	s4,2
	...
bfc011d0:	0bf001be 	j	bfc006f8 <core_mark+0xf8>
bfc011d4:	00601021 	move	v0,v1
	...
bfc011e0:	0bf001ba 	j	bfc006e8 <core_mark+0xe8>
bfc011e4:	00a01821 	move	v1,a1
	...
bfc011f0:	14400002 	bnez	v0,bfc011fc <core_mark+0xbfc>
bfc011f4:	0182001b 	divu	zero,t4,v0
bfc011f8:	0007000d 	break	0x7
bfc011fc:	8fa9003c 	lw	t1,60(sp)
bfc01200:	00005812 	mflo	t3
bfc01204:	256a0001 	addiu	t2,t3,1
bfc01208:	00000000 	nop
bfc0120c:	012a0018 	mult	t1,t2
bfc01210:	00004012 	mflo	t0
bfc01214:	0bf00255 	j	bfc00954 <core_mark+0x354>
bfc01218:	afa8003c 	sw	t0,60(sp)
bfc0121c:	00000000 	nop
bfc01220:	3c108000 	lui	s0,0x8000
bfc01224:	0ff0280e 	jal	bfc0a038 <puts>
bfc01228:	26040074 	addiu	a0,s0,116
bfc0122c:	0bf002dc 	j	bfc00b70 <core_mark+0x570>
bfc01230:	0280a821 	move	s5,s4
	...
bfc01240:	104300d8 	beq	v0,v1,bfc015a4 <core_mark+0xfa4>
bfc01244:	24024eaf 	li	v0,20143
bfc01248:	16c2fe6d 	bne	s6,v0,bfc00c00 <core_mark+0x600>
bfc0124c:	3410ffff 	li	s0,0xffff
bfc01250:	3c088000 	lui	t0,0x8000
bfc01254:	0ff0280e 	jal	bfc0a038 <puts>
bfc01258:	250400f0 	addiu	a0,t0,240
bfc0125c:	24050002 	li	a1,2
bfc01260:	8f8b8010 	lw	t3,-32752(gp)
bfc01264:	00000000 	nop
bfc01268:	11600054 	beqz	t3,bfc013bc <core_mark+0xdbc>
bfc0126c:	3c1e8000 	lui	s8,0x8000
bfc01270:	00056840 	sll	t5,a1,0x1
bfc01274:	27d906b8 	addiu	t9,s8,1720
bfc01278:	3c178000 	lui	s7,0x8000
bfc0127c:	3c0e8000 	lui	t6,0x8000
bfc01280:	01b9c021 	addu	t8,t5,t9
bfc01284:	26ef06a0 	addiu	t7,s7,1696
bfc01288:	25cc06ac 	addiu	t4,t6,1708
bfc0128c:	afb80838 	sw	t8,2104(sp)
bfc01290:	01afb821 	addu	s7,t5,t7
bfc01294:	01acf021 	addu	s8,t5,t4
bfc01298:	00008821 	move	s1,zero
bfc0129c:	27b40020 	addiu	s4,sp,32
bfc012a0:	00119880 	sll	s3,s1,0x2
bfc012a4:	00119180 	sll	s2,s1,0x6
bfc012a8:	02721821 	addu	v1,s3,s2
bfc012ac:	02838021 	addu	s0,s4,v1
bfc012b0:	8e080020 	lw	t0,32(s0)
bfc012b4:	00000000 	nop
bfc012b8:	311f0001 	andi	ra,t0,0x1
bfc012bc:	13e0000f 	beqz	ra,bfc012fc <core_mark+0xcfc>
bfc012c0:	a6000040 	sh	zero,64(s0)
bfc012c4:	9609003a 	lhu	t1,58(s0)
bfc012c8:	96e20000 	lhu	v0,0(s7)
bfc012cc:	3c048000 	lui	a0,0x8000
bfc012d0:	02202821 	move	a1,s1
bfc012d4:	24840178 	addiu	a0,a0,376
bfc012d8:	01203021 	move	a2,t1
bfc012dc:	11220007 	beq	t1,v0,bfc012fc <core_mark+0xcfc>
bfc012e0:	00403821 	move	a3,v0
bfc012e4:	0ff02748 	jal	bfc09d20 <printf>
bfc012e8:	00000000 	nop
bfc012ec:	96060040 	lhu	a2,64(s0)
bfc012f0:	8e080020 	lw	t0,32(s0)
bfc012f4:	24c50001 	addiu	a1,a2,1
bfc012f8:	a6050040 	sh	a1,64(s0)
bfc012fc:	02725021 	addu	t2,s3,s2
bfc01300:	31070002 	andi	a3,t0,0x2
bfc01304:	10e0000f 	beqz	a3,bfc01344 <core_mark+0xd44>
bfc01308:	028a8021 	addu	s0,s4,t2
bfc0130c:	960c003c 	lhu	t4,60(s0)
bfc01310:	97cb0000 	lhu	t3,0(s8)
bfc01314:	3c0d8000 	lui	t5,0x8000
bfc01318:	02202821 	move	a1,s1
bfc0131c:	25a401a8 	addiu	a0,t5,424
bfc01320:	01803021 	move	a2,t4
bfc01324:	118b0007 	beq	t4,t3,bfc01344 <core_mark+0xd44>
bfc01328:	01603821 	move	a3,t3
bfc0132c:	0ff02748 	jal	bfc09d20 <printf>
bfc01330:	00000000 	nop
bfc01334:	960f0040 	lhu	t7,64(s0)
bfc01338:	8e080020 	lw	t0,32(s0)
bfc0133c:	25ee0001 	addiu	t6,t7,1
bfc01340:	a60e0040 	sh	t6,64(s0)
bfc01344:	0272c821 	addu	t9,s3,s2
bfc01348:	31180004 	andi	t8,t0,0x4
bfc0134c:	13000010 	beqz	t8,bfc01390 <core_mark+0xd90>
bfc01350:	02998021 	addu	s0,s4,t9
bfc01354:	8fa30838 	lw	v1,2104(sp)
bfc01358:	961f003e 	lhu	ra,62(s0)
bfc0135c:	94680000 	lhu	t0,0(v1)
bfc01360:	3c028000 	lui	v0,0x8000
bfc01364:	02202821 	move	a1,s1
bfc01368:	244401dc 	addiu	a0,v0,476
bfc0136c:	03e03021 	move	a2,ra
bfc01370:	13e80007 	beq	ra,t0,bfc01390 <core_mark+0xd90>
bfc01374:	01003821 	move	a3,t0
bfc01378:	0ff02748 	jal	bfc09d20 <printf>
bfc0137c:	00000000 	nop
bfc01380:	96040040 	lhu	a0,64(s0)
bfc01384:	00000000 	nop
bfc01388:	24890001 	addiu	t1,a0,1
bfc0138c:	a6090040 	sh	t1,64(s0)
bfc01390:	02725021 	addu	t2,s3,s2
bfc01394:	028a3821 	addu	a3,s4,t2
bfc01398:	94e50040 	lhu	a1,64(a3)
bfc0139c:	26260001 	addiu	a2,s1,1
bfc013a0:	8f928010 	lw	s2,-32752(gp)
bfc013a4:	30d1ffff 	andi	s1,a2,0xffff
bfc013a8:	02a59821 	addu	s3,s5,a1
bfc013ac:	0013ac00 	sll	s5,s3,0x10
bfc013b0:	0232802b 	sltu	s0,s1,s2
bfc013b4:	1600ffba 	bnez	s0,bfc012a0 <core_mark+0xca0>
bfc013b8:	0015ac03 	sra	s5,s5,0x10
bfc013bc:	0bf00300 	j	bfc00c00 <core_mark+0x600>
bfc013c0:	32b0ffff 	andi	s0,s5,0xffff
	...
bfc013d0:	a7a00020 	sh	zero,32(sp)
bfc013d4:	a7a00022 	sh	zero,34(sp)
bfc013d8:	8fa30020 	lw	v1,32(sp)
bfc013dc:	24070001 	li	a3,1
bfc013e0:	1467fcb4 	bne	v1,a3,bfc006b4 <core_mark+0xb4>
bfc013e4:	a7a60024 	sh	a2,36(sp)
bfc013e8:	87a80024 	lh	t0,36(sp)
bfc013ec:	00000000 	nop
bfc013f0:	1500fcb0 	bnez	t0,bfc006b4 <core_mark+0xb4>
bfc013f4:	24093415 	li	t1,13333
bfc013f8:	240a0066 	li	t2,102
bfc013fc:	a7a90022 	sh	t1,34(sp)
bfc01400:	a7aa0024 	sh	t2,36(sp)
bfc01404:	0bf001ad 	j	bfc006b4 <core_mark+0xb4>
bfc01408:	a7a90020 	sh	t1,32(sp)
bfc0140c:	0ff0280e 	jal	bfc0a038 <puts>
bfc01410:	25240120 	addiu	a0,t1,288
bfc01414:	0bf00498 	j	bfc01260 <core_mark+0xc60>
bfc01418:	24050003 	li	a1,3
bfc0141c:	00000000 	nop
bfc01420:	8f868010 	lw	a2,-32752(gp)
bfc01424:	00000000 	nop
bfc01428:	10c0fe81 	beqz	a2,bfc00e30 <core_mark+0x830>
bfc0142c:	3c058000 	lui	a1,0x8000
bfc01430:	24b2054c 	addiu	s2,a1,1356
bfc01434:	00008021 	move	s0,zero
bfc01438:	27b10020 	addiu	s1,sp,32
bfc0143c:	0010f880 	sll	ra,s0,0x2
bfc01440:	00106980 	sll	t5,s0,0x6
bfc01444:	03ed3021 	addu	a2,ra,t5
bfc01448:	02266021 	addu	t4,s1,a2
bfc0144c:	9586003a 	lhu	a2,58(t4)
bfc01450:	02002821 	move	a1,s0
bfc01454:	0ff02748 	jal	bfc09d20 <printf>
bfc01458:	02402021 	move	a0,s2
bfc0145c:	260b0001 	addiu	t3,s0,1
bfc01460:	3170ffff 	andi	s0,t3,0xffff
bfc01464:	8f868010 	lw	a2,-32752(gp)
bfc01468:	0010b880 	sll	s7,s0,0x2
bfc0146c:	0010f180 	sll	s8,s0,0x6
bfc01470:	02fea021 	addu	s4,s7,s8
bfc01474:	0206502b 	sltu	t2,s0,a2
bfc01478:	02402021 	move	a0,s2
bfc0147c:	02341821 	addu	v1,s1,s4
bfc01480:	11400026 	beqz	t2,bfc0151c <core_mark+0xf1c>
bfc01484:	02002821 	move	a1,s0
bfc01488:	9466003a 	lhu	a2,58(v1)
bfc0148c:	0ff02748 	jal	bfc09d20 <printf>
bfc01490:	00000000 	nop
bfc01494:	260a0001 	addiu	t2,s0,1
bfc01498:	3150ffff 	andi	s0,t2,0xffff
bfc0149c:	8f868010 	lw	a2,-32752(gp)
bfc014a0:	00102880 	sll	a1,s0,0x2
bfc014a4:	00101980 	sll	v1,s0,0x6
bfc014a8:	00a33821 	addu	a3,a1,v1
bfc014ac:	0206a82b 	sltu	s5,s0,a2
bfc014b0:	02402021 	move	a0,s2
bfc014b4:	02271821 	addu	v1,s1,a3
bfc014b8:	12a00018 	beqz	s5,bfc0151c <core_mark+0xf1c>
bfc014bc:	02002821 	move	a1,s0
bfc014c0:	9466003a 	lhu	a2,58(v1)
bfc014c4:	0ff02748 	jal	bfc09d20 <printf>
bfc014c8:	00000000 	nop
bfc014cc:	260c0001 	addiu	t4,s0,1
bfc014d0:	3190ffff 	andi	s0,t4,0xffff
bfc014d4:	8f868010 	lw	a2,-32752(gp)
bfc014d8:	0010f080 	sll	s8,s0,0x2
bfc014dc:	00105980 	sll	t3,s0,0x6
bfc014e0:	03cbb821 	addu	s7,s8,t3
bfc014e4:	0206a02b 	sltu	s4,s0,a2
bfc014e8:	02402021 	move	a0,s2
bfc014ec:	02371821 	addu	v1,s1,s7
bfc014f0:	1280000a 	beqz	s4,bfc0151c <core_mark+0xf1c>
bfc014f4:	02002821 	move	a1,s0
bfc014f8:	9466003a 	lhu	a2,58(v1)
bfc014fc:	0ff02748 	jal	bfc09d20 <printf>
bfc01500:	00000000 	nop
bfc01504:	260d0001 	addiu	t5,s0,1
bfc01508:	8f868010 	lw	a2,-32752(gp)
bfc0150c:	31b0ffff 	andi	s0,t5,0xffff
bfc01510:	0206202b 	sltu	a0,s0,a2
bfc01514:	1480ffca 	bnez	a0,bfc01440 <core_mark+0xe40>
bfc01518:	0010f880 	sll	ra,s0,0x2
bfc0151c:	8fa30040 	lw	v1,64(sp)
bfc01520:	0bf0038d 	j	bfc00e34 <core_mark+0x834>
bfc01524:	30710002 	andi	s1,v1,0x2
	...
bfc01530:	0ff0280e 	jal	bfc0a038 <puts>
bfc01534:	270403ac 	addiu	a0,t8,940
bfc01538:	266f0001 	addiu	t7,s3,1
bfc0153c:	000f9c00 	sll	s3,t7,0x10
bfc01540:	0bf00364 	j	bfc00d90 <core_mark+0x790>
bfc01544:	00139c03 	sra	s3,s3,0x10
	...
bfc01550:	0ff0280e 	jal	bfc0a038 <puts>
bfc01554:	264405bc 	addiu	a0,s2,1468
bfc01558:	0bf0044f 	j	bfc0113c <core_mark+0xb3c>
bfc0155c:	00000000 	nop
bfc01560:	3c038000 	lui	v1,0x8000
bfc01564:	0ff0280e 	jal	bfc0a038 <puts>
bfc01568:	24640618 	addiu	a0,v1,1560
bfc0156c:	0bf0044f 	j	bfc0113c <core_mark+0xb3c>
bfc01570:	00000000 	nop
bfc01574:	0ff0280e 	jal	bfc0a038 <puts>
bfc01578:	24c40098 	addiu	a0,a2,152
bfc0157c:	0bf00498 	j	bfc01260 <core_mark+0xc60>
bfc01580:	00002821 	move	a1,zero
	...
bfc01590:	3c078000 	lui	a3,0x8000
bfc01594:	0ff0280e 	jal	bfc0a038 <puts>
bfc01598:	24e400c4 	addiu	a0,a3,196
bfc0159c:	0bf00498 	j	bfc01260 <core_mark+0xc60>
bfc015a0:	24050001 	li	a1,1
bfc015a4:	3c0a8000 	lui	t2,0x8000
bfc015a8:	0ff0280e 	jal	bfc0a038 <puts>
bfc015ac:	2544014c 	addiu	a0,t2,332
bfc015b0:	0bf00498 	j	bfc01260 <core_mark+0xc60>
bfc015b4:	24050004 	li	a1,4
	...

bfc015c0 <core_init_matrix>:
core_init_matrix():
bfc015c0:	27bdffe8 	addiu	sp,sp,-24
bfc015c4:	afb50014 	sw	s5,20(sp)
bfc015c8:	afb40010 	sw	s4,16(sp)
bfc015cc:	afb3000c 	sw	s3,12(sp)
bfc015d0:	afb20008 	sw	s2,8(sp)
bfc015d4:	afb10004 	sw	s1,4(sp)
bfc015d8:	afb00000 	sw	s0,0(sp)
bfc015dc:	00c06821 	move	t5,a2
bfc015e0:	14c00002 	bnez	a2,bfc015ec <core_init_matrix+0x2c>
bfc015e4:	00e0a821 	move	s5,a3
bfc015e8:	240d0001 	li	t5,1
bfc015ec:	108000e3 	beqz	a0,bfc0197c <core_init_matrix+0x3bc>
bfc015f0:	00004821 	move	t1,zero
bfc015f4:	25260001 	addiu	a2,t1,1
bfc015f8:	00c60018 	mult	a2,a2
bfc015fc:	24cf0007 	addiu	t7,a2,7
bfc01600:	24ca0003 	addiu	t2,a2,3
bfc01604:	24cb0004 	addiu	t3,a2,4
bfc01608:	24cc0005 	addiu	t4,a2,5
bfc0160c:	00003812 	mflo	a3
bfc01610:	000718c0 	sll	v1,a3,0x3
bfc01614:	0064102b 	sltu	v0,v1,a0
bfc01618:	10400039 	beqz	v0,bfc01700 <core_init_matrix+0x140>
bfc0161c:	24ce0006 	addiu	t6,a2,6
bfc01620:	24c80001 	addiu	t0,a2,1
bfc01624:	01080018 	mult	t0,t0
bfc01628:	00009012 	mflo	s2
bfc0162c:	001288c0 	sll	s1,s2,0x3
bfc01630:	0224802b 	sltu	s0,s1,a0
bfc01634:	12000032 	beqz	s0,bfc01700 <core_init_matrix+0x140>
bfc01638:	00c04821 	move	t1,a2
bfc0163c:	25190001 	addiu	t9,t0,1
bfc01640:	03390018 	mult	t9,t9
bfc01644:	00009812 	mflo	s3
bfc01648:	001390c0 	sll	s2,s3,0x3
bfc0164c:	0244882b 	sltu	s1,s2,a0
bfc01650:	1220002b 	beqz	s1,bfc01700 <core_init_matrix+0x140>
bfc01654:	01004821 	move	t1,t0
bfc01658:	014a0018 	mult	t2,t2
bfc0165c:	00003812 	mflo	a3
bfc01660:	0007c0c0 	sll	t8,a3,0x3
bfc01664:	0304a02b 	sltu	s4,t8,a0
bfc01668:	12800025 	beqz	s4,bfc01700 <core_init_matrix+0x140>
bfc0166c:	24c90002 	addiu	t1,a2,2
bfc01670:	016b0018 	mult	t3,t3
bfc01674:	01404821 	move	t1,t2
bfc01678:	00001812 	mflo	v1
bfc0167c:	000380c0 	sll	s0,v1,0x3
bfc01680:	0204502b 	sltu	t2,s0,a0
bfc01684:	1140001e 	beqz	t2,bfc01700 <core_init_matrix+0x140>
bfc01688:	018c0018 	mult	t4,t4
bfc0168c:	01604821 	move	t1,t3
bfc01690:	00003012 	mflo	a2
bfc01694:	000610c0 	sll	v0,a2,0x3
bfc01698:	0044582b 	sltu	t3,v0,a0
bfc0169c:	11600018 	beqz	t3,bfc01700 <core_init_matrix+0x140>
bfc016a0:	01ce0018 	mult	t6,t6
bfc016a4:	01804821 	move	t1,t4
bfc016a8:	00008812 	mflo	s1
bfc016ac:	001140c0 	sll	t0,s1,0x3
bfc016b0:	0104602b 	sltu	t4,t0,a0
bfc016b4:	11800012 	beqz	t4,bfc01700 <core_init_matrix+0x140>
bfc016b8:	01ef0018 	mult	t7,t7
bfc016bc:	01c04821 	move	t1,t6
bfc016c0:	00009812 	mflo	s3
bfc016c4:	001390c0 	sll	s2,s3,0x3
bfc016c8:	0244702b 	sltu	t6,s2,a0
bfc016cc:	11c0000c 	beqz	t6,bfc01700 <core_init_matrix+0x140>
bfc016d0:	25e60001 	addiu	a2,t7,1
bfc016d4:	01e04821 	move	t1,t7
bfc016d8:	00c60018 	mult	a2,a2
bfc016dc:	24cf0007 	addiu	t7,a2,7
bfc016e0:	24ca0003 	addiu	t2,a2,3
bfc016e4:	24cb0004 	addiu	t3,a2,4
bfc016e8:	24cc0005 	addiu	t4,a2,5
bfc016ec:	00003812 	mflo	a3
bfc016f0:	000718c0 	sll	v1,a3,0x3
bfc016f4:	0064102b 	sltu	v0,v1,a0
bfc016f8:	1440ffc9 	bnez	v0,bfc01620 <core_init_matrix+0x60>
bfc016fc:	24ce0006 	addiu	t6,a2,6
bfc01700:	01290018 	mult	t1,t1
bfc01704:	24a8ffff 	addiu	t0,a1,-1
bfc01708:	2404fffc 	li	a0,-4
bfc0170c:	01042824 	and	a1,t0,a0
bfc01710:	24b10004 	addiu	s1,a1,4
bfc01714:	00003012 	mflo	a2
bfc01718:	0006a040 	sll	s4,a2,0x1
bfc0171c:	1120009f 	beqz	t1,bfc0199c <core_init_matrix+0x3dc>
bfc01720:	02349021 	addu	s2,s1,s4
bfc01724:	0120c021 	move	t8,t1
bfc01728:	3c108000 	lui	s0,0x8000
bfc0172c:	3619ffff 	ori	t9,s0,0xffff
bfc01730:	00189840 	sll	s3,t8,0x1
bfc01734:	24080001 	li	t0,1
bfc01738:	00003821 	move	a3,zero
bfc0173c:	00002821 	move	a1,zero
bfc01740:	3c10ffff 	lui	s0,0xffff
bfc01744:	01a80018 	mult	t5,t0
bfc01748:	270affff 	addiu	t2,t8,-1
bfc0174c:	314f0001 	andi	t7,t2,0x1
bfc01750:	02457021 	addu	t6,s2,a1
bfc01754:	00004812 	mflo	t1
bfc01758:	01393024 	and	a2,t1,t9
bfc0175c:	04c00080 	bltz	a2,bfc01960 <core_init_matrix+0x3a0>
bfc01760:	02255021 	addu	t2,s1,a1
bfc01764:	310bffff 	andi	t3,t0,0xffff
bfc01768:	01666021 	addu	t4,t3,a2
bfc0176c:	3183ffff 	andi	v1,t4,0xffff
bfc01770:	006b1021 	addu	v0,v1,t3
bfc01774:	24090001 	li	t1,1
bfc01778:	304d00ff 	andi	t5,v0,0xff
bfc0177c:	0138202b 	sltu	a0,t1,t8
bfc01780:	a5c30000 	sh	v1,0(t6)
bfc01784:	25080001 	addiu	t0,t0,1
bfc01788:	a54d0000 	sh	t5,0(t2)
bfc0178c:	25cc0002 	addiu	t4,t6,2
bfc01790:	00c06821 	move	t5,a2
bfc01794:	1080005b 	beqz	a0,bfc01904 <core_init_matrix+0x344>
bfc01798:	254b0002 	addiu	t3,t2,2
bfc0179c:	11e00032 	beqz	t7,bfc01868 <core_init_matrix+0x2a8>
bfc017a0:	01a80018 	mult	t5,t0
bfc017a4:	00c80018 	mult	a2,t0
bfc017a8:	00007812 	mflo	t7
bfc017ac:	01f93024 	and	a2,t7,t9
bfc017b0:	04c0006f 	bltz	a2,bfc01970 <core_init_matrix+0x3b0>
bfc017b4:	24cdffff 	addiu	t5,a2,-1
bfc017b8:	3104ffff 	andi	a0,t0,0xffff
bfc017bc:	00c06821 	move	t5,a2
bfc017c0:	00863021 	addu	a2,a0,a2
bfc017c4:	30c3ffff 	andi	v1,a2,0xffff
bfc017c8:	00647821 	addu	t7,v1,a0
bfc017cc:	25290001 	addiu	t1,t1,1
bfc017d0:	31e200ff 	andi	v0,t7,0xff
bfc017d4:	0138302b 	sltu	a2,t1,t8
bfc017d8:	a5c30002 	sh	v1,2(t6)
bfc017dc:	25080001 	addiu	t0,t0,1
bfc017e0:	a5420002 	sh	v0,2(t2)
bfc017e4:	258c0002 	addiu	t4,t4,2
bfc017e8:	14c0001e 	bnez	a2,bfc01864 <core_init_matrix+0x2a4>
bfc017ec:	256b0002 	addiu	t3,t3,2
bfc017f0:	0bf00642 	j	bfc01908 <core_init_matrix+0x348>
bfc017f4:	24e70001 	addiu	a3,a3,1
	...
bfc01800:	004a0018 	mult	v0,t2
bfc01804:	01021821 	addu	v1,t0,v0
bfc01808:	306dffff 	andi	t5,v1,0xffff
bfc0180c:	01a81021 	addu	v0,t5,t0
bfc01810:	304600ff 	andi	a2,v0,0xff
bfc01814:	a58d0000 	sh	t5,0(t4)
bfc01818:	a5660000 	sh	a2,0(t3)
bfc0181c:	00002012 	mflo	a0
bfc01820:	00993024 	and	a2,a0,t9
bfc01824:	04c00027 	bltz	a2,bfc018c4 <core_init_matrix+0x304>
bfc01828:	24cbffff 	addiu	t3,a2,-1
bfc0182c:	00c06821 	move	t5,a2
bfc01830:	3146ffff 	andi	a2,t2,0xffff
bfc01834:	00cd4021 	addu	t0,a2,t5
bfc01838:	3103ffff 	andi	v1,t0,0xffff
bfc0183c:	00661021 	addu	v0,v1,a2
bfc01840:	25290001 	addiu	t1,t1,1
bfc01844:	304c00ff 	andi	t4,v0,0xff
bfc01848:	0138202b 	sltu	a0,t1,t8
bfc0184c:	a5c30000 	sh	v1,0(t6)
bfc01850:	25480001 	addiu	t0,t2,1
bfc01854:	a5ec0000 	sh	t4,0(t7)
bfc01858:	25eb0002 	addiu	t3,t7,2
bfc0185c:	10800029 	beqz	a0,bfc01904 <core_init_matrix+0x344>
bfc01860:	25cc0002 	addiu	t4,t6,2
bfc01864:	01a80018 	mult	t5,t0
bfc01868:	250a0001 	addiu	t2,t0,1
bfc0186c:	258e0002 	addiu	t6,t4,2
bfc01870:	3108ffff 	andi	t0,t0,0xffff
bfc01874:	256f0002 	addiu	t7,t3,2
bfc01878:	00006812 	mflo	t5
bfc0187c:	01b91024 	and	v0,t5,t9
bfc01880:	0441ffdf 	bgez	v0,bfc01800 <core_init_matrix+0x240>
bfc01884:	25290001 	addiu	t1,t1,1
bfc01888:	2443ffff 	addiu	v1,v0,-1
bfc0188c:	00701025 	or	v0,v1,s0
bfc01890:	24420001 	addiu	v0,v0,1
bfc01894:	004a0018 	mult	v0,t2
bfc01898:	01021821 	addu	v1,t0,v0
bfc0189c:	306dffff 	andi	t5,v1,0xffff
bfc018a0:	01a81021 	addu	v0,t5,t0
bfc018a4:	304600ff 	andi	a2,v0,0xff
bfc018a8:	a58d0000 	sh	t5,0(t4)
bfc018ac:	a5660000 	sh	a2,0(t3)
bfc018b0:	00002012 	mflo	a0
bfc018b4:	00993024 	and	a2,a0,t9
bfc018b8:	04c1ffdd 	bgez	a2,bfc01830 <core_init_matrix+0x270>
bfc018bc:	00c06821 	move	t5,a2
bfc018c0:	24cbffff 	addiu	t3,a2,-1
bfc018c4:	01704025 	or	t0,t3,s0
bfc018c8:	25060001 	addiu	a2,t0,1
bfc018cc:	00c06821 	move	t5,a2
bfc018d0:	3146ffff 	andi	a2,t2,0xffff
bfc018d4:	00cd4021 	addu	t0,a2,t5
bfc018d8:	3103ffff 	andi	v1,t0,0xffff
bfc018dc:	00661021 	addu	v0,v1,a2
bfc018e0:	25290001 	addiu	t1,t1,1
bfc018e4:	304c00ff 	andi	t4,v0,0xff
bfc018e8:	0138202b 	sltu	a0,t1,t8
bfc018ec:	a5c30000 	sh	v1,0(t6)
bfc018f0:	25480001 	addiu	t0,t2,1
bfc018f4:	a5ec0000 	sh	t4,0(t7)
bfc018f8:	25eb0002 	addiu	t3,t7,2
bfc018fc:	1480ffd9 	bnez	a0,bfc01864 <core_init_matrix+0x2a4>
bfc01900:	25cc0002 	addiu	t4,t6,2
bfc01904:	24e70001 	addiu	a3,a3,1
bfc01908:	00f8582b 	sltu	t3,a3,t8
bfc0190c:	1560ff8d 	bnez	t3,bfc01744 <core_init_matrix+0x184>
bfc01910:	00b32821 	addu	a1,a1,s3
bfc01914:	2699ffff 	addiu	t9,s4,-1
bfc01918:	02597821 	addu	t7,s2,t9
bfc0191c:	2413fffc 	li	s3,-4
bfc01920:	01f37024 	and	t6,t7,s3
bfc01924:	25cc0004 	addiu	t4,t6,4
bfc01928:	aeb10004 	sw	s1,4(s5)
bfc0192c:	aeb20008 	sw	s2,8(s5)
bfc01930:	aeac000c 	sw	t4,12(s5)
bfc01934:	aeb80000 	sw	t8,0(s5)
bfc01938:	03001021 	move	v0,t8
bfc0193c:	8fb50014 	lw	s5,20(sp)
bfc01940:	8fb40010 	lw	s4,16(sp)
bfc01944:	8fb3000c 	lw	s3,12(sp)
bfc01948:	8fb20008 	lw	s2,8(sp)
bfc0194c:	8fb10004 	lw	s1,4(sp)
bfc01950:	8fb00000 	lw	s0,0(sp)
bfc01954:	03e00008 	jr	ra
bfc01958:	27bd0018 	addiu	sp,sp,24
bfc0195c:	00000000 	nop
bfc01960:	24c4ffff 	addiu	a0,a2,-1
bfc01964:	00904825 	or	t1,a0,s0
bfc01968:	0bf005d9 	j	bfc01764 <core_init_matrix+0x1a4>
bfc0196c:	25260001 	addiu	a2,t1,1
bfc01970:	01b02025 	or	a0,t5,s0
bfc01974:	0bf005ee 	j	bfc017b8 <core_init_matrix+0x1f8>
bfc01978:	24860001 	addiu	a2,a0,1
bfc0197c:	24b8ffff 	addiu	t8,a1,-1
bfc01980:	2407fffc 	li	a3,-4
bfc01984:	0307a024 	and	s4,t8,a3
bfc01988:	26920006 	addiu	s2,s4,6
bfc0198c:	26910004 	addiu	s1,s4,4
bfc01990:	2418ffff 	li	t8,-1
bfc01994:	0bf005ca 	j	bfc01728 <core_init_matrix+0x168>
bfc01998:	24140002 	li	s4,2
bfc0199c:	0bf00645 	j	bfc01914 <core_init_matrix+0x354>
bfc019a0:	0000c021 	move	t8,zero
	...

bfc019b0 <matrix_sum>:
matrix_sum():
bfc019b0:	00063400 	sll	a2,a2,0x10
bfc019b4:	00807021 	move	t6,a0
bfc019b8:	108000c7 	beqz	a0,bfc01cd8 <matrix_sum+0x328>
bfc019bc:	00063403 	sra	a2,a2,0x10
bfc019c0:	0004c080 	sll	t8,a0,0x2
bfc019c4:	00004021 	move	t0,zero
bfc019c8:	00001821 	move	v1,zero
bfc019cc:	00004821 	move	t1,zero
bfc019d0:	00007821 	move	t7,zero
bfc019d4:	8cac0000 	lw	t4,0(a1)
bfc019d8:	3122ffff 	andi	v0,t1,0xffff
bfc019dc:	010c5021 	addu	t2,t0,t4
bfc019e0:	006c402a 	slt	t0,v1,t4
bfc019e4:	00485821 	addu	t3,v0,t0
bfc019e8:	2447000a 	addiu	a3,v0,10
bfc019ec:	25cdffff 	addiu	t5,t6,-1
bfc019f0:	0007cc00 	sll	t9,a3,0x10
bfc019f4:	000b4c00 	sll	t1,t3,0x10
bfc019f8:	00ca402a 	slt	t0,a2,t2
bfc019fc:	31a40003 	andi	a0,t5,0x3
bfc01a00:	00193c03 	sra	a3,t9,0x10
bfc01a04:	150000a6 	bnez	t0,bfc01ca0 <matrix_sum+0x2f0>
bfc01a08:	00091403 	sra	v0,t1,0x10
bfc01a0c:	00404821 	move	t1,v0
bfc01a10:	15000002 	bnez	t0,bfc01a1c <matrix_sum+0x6c>
bfc01a14:	00004021 	move	t0,zero
bfc01a18:	01404021 	move	t0,t2
bfc01a1c:	240b0001 	li	t3,1
bfc01a20:	016ec82b 	sltu	t9,t3,t6
bfc01a24:	24aa0004 	addiu	t2,a1,4
bfc01a28:	13200087 	beqz	t9,bfc01c48 <matrix_sum+0x298>
bfc01a2c:	01801821 	move	v1,t4
bfc01a30:	1080003f 	beqz	a0,bfc01b30 <matrix_sum+0x180>
bfc01a34:	00000000 	nop
bfc01a38:	108b0028 	beq	a0,t3,bfc01adc <matrix_sum+0x12c>
bfc01a3c:	24070002 	li	a3,2
bfc01a40:	10870013 	beq	a0,a3,bfc01a90 <matrix_sum+0xe0>
bfc01a44:	3139ffff 	andi	t9,t1,0xffff
bfc01a48:	8d440000 	lw	a0,0(t2)
bfc01a4c:	00000000 	nop
bfc01a50:	01046821 	addu	t5,t0,a0
bfc01a54:	0184402a 	slt	t0,t4,a0
bfc01a58:	03281821 	addu	v1,t9,t0
bfc01a5c:	2722000a 	addiu	v0,t9,10
bfc01a60:	00024c00 	sll	t1,v0,0x10
bfc01a64:	00036400 	sll	t4,v1,0x10
bfc01a68:	00cd402a 	slt	t0,a2,t5
bfc01a6c:	00093c03 	sra	a3,t1,0x10
bfc01a70:	1500008f 	bnez	t0,bfc01cb0 <matrix_sum+0x300>
bfc01a74:	000c1403 	sra	v0,t4,0x10
bfc01a78:	1500008f 	bnez	t0,bfc01cb8 <matrix_sum+0x308>
bfc01a7c:	00404821 	move	t1,v0
bfc01a80:	01a04021 	move	t0,t5
bfc01a84:	256b0001 	addiu	t3,t3,1
bfc01a88:	254a0004 	addiu	t2,t2,4
bfc01a8c:	00801821 	move	v1,a0
bfc01a90:	8d440000 	lw	a0,0(t2)
bfc01a94:	3122ffff 	andi	v0,t1,0xffff
bfc01a98:	0064c82a 	slt	t9,v1,a0
bfc01a9c:	00591821 	addu	v1,v0,t9
bfc01aa0:	2449000a 	addiu	t1,v0,10
bfc01aa4:	01046021 	addu	t4,t0,a0
bfc01aa8:	00093c00 	sll	a3,t1,0x10
bfc01aac:	00036c00 	sll	t5,v1,0x10
bfc01ab0:	00cc402a 	slt	t0,a2,t4
bfc01ab4:	00073c03 	sra	a3,a3,0x10
bfc01ab8:	15000085 	bnez	t0,bfc01cd0 <matrix_sum+0x320>
bfc01abc:	000d1403 	sra	v0,t5,0x10
bfc01ac0:	00404821 	move	t1,v0
bfc01ac4:	15000002 	bnez	t0,bfc01ad0 <matrix_sum+0x120>
bfc01ac8:	00004021 	move	t0,zero
bfc01acc:	01804021 	move	t0,t4
bfc01ad0:	256b0001 	addiu	t3,t3,1
bfc01ad4:	254a0004 	addiu	t2,t2,4
bfc01ad8:	00801821 	move	v1,a0
bfc01adc:	8d440000 	lw	a0,0(t2)
bfc01ae0:	3122ffff 	andi	v0,t1,0xffff
bfc01ae4:	01046021 	addu	t4,t0,a0
bfc01ae8:	0064402a 	slt	t0,v1,a0
bfc01aec:	00481821 	addu	v1,v0,t0
bfc01af0:	2449000a 	addiu	t1,v0,10
bfc01af4:	00093c00 	sll	a3,t1,0x10
bfc01af8:	00036c00 	sll	t5,v1,0x10
bfc01afc:	00cc402a 	slt	t0,a2,t4
bfc01b00:	00073c03 	sra	a3,a3,0x10
bfc01b04:	1500006e 	bnez	t0,bfc01cc0 <matrix_sum+0x310>
bfc01b08:	000d1403 	sra	v0,t5,0x10
bfc01b0c:	00404821 	move	t1,v0
bfc01b10:	15000002 	bnez	t0,bfc01b1c <matrix_sum+0x16c>
bfc01b14:	00004021 	move	t0,zero
bfc01b18:	01804021 	move	t0,t4
bfc01b1c:	256b0001 	addiu	t3,t3,1
bfc01b20:	016e602b 	sltu	t4,t3,t6
bfc01b24:	254a0004 	addiu	t2,t2,4
bfc01b28:	11800047 	beqz	t4,bfc01c48 <matrix_sum+0x298>
bfc01b2c:	00801821 	move	v1,a0
bfc01b30:	8d440000 	lw	a0,0(t2)
bfc01b34:	312dffff 	andi	t5,t1,0xffff
bfc01b38:	01044821 	addu	t1,t0,a0
bfc01b3c:	0064402a 	slt	t0,v1,a0
bfc01b40:	01a81821 	addu	v1,t5,t0
bfc01b44:	25ac000a 	addiu	t4,t5,10
bfc01b48:	000c3c00 	sll	a3,t4,0x10
bfc01b4c:	00031400 	sll	v0,v1,0x10
bfc01b50:	00c9402a 	slt	t0,a2,t1
bfc01b54:	00073c03 	sra	a3,a3,0x10
bfc01b58:	11000002 	beqz	t0,bfc01b64 <matrix_sum+0x1b4>
bfc01b5c:	00021403 	sra	v0,v0,0x10
bfc01b60:	00e01021 	move	v0,a3
bfc01b64:	11000002 	beqz	t0,bfc01b70 <matrix_sum+0x1c0>
bfc01b68:	01203821 	move	a3,t1
bfc01b6c:	00003821 	move	a3,zero
bfc01b70:	8d480004 	lw	t0,4(t2)
bfc01b74:	304cffff 	andi	t4,v0,0xffff
bfc01b78:	0088682a 	slt	t5,a0,t0
bfc01b7c:	2582000a 	addiu	v0,t4,10
bfc01b80:	00e84821 	addu	t1,a3,t0
bfc01b84:	018d1821 	addu	v1,t4,t5
bfc01b88:	00023c00 	sll	a3,v0,0x10
bfc01b8c:	0003cc00 	sll	t9,v1,0x10
bfc01b90:	00c9202a 	slt	a0,a2,t1
bfc01b94:	256b0001 	addiu	t3,t3,1
bfc01b98:	00073c03 	sra	a3,a3,0x10
bfc01b9c:	00191403 	sra	v0,t9,0x10
bfc01ba0:	10800002 	beqz	a0,bfc01bac <matrix_sum+0x1fc>
bfc01ba4:	254c0004 	addiu	t4,t2,4
bfc01ba8:	00e01021 	move	v0,a3
bfc01bac:	14800002 	bnez	a0,bfc01bb8 <matrix_sum+0x208>
bfc01bb0:	00003821 	move	a3,zero
bfc01bb4:	01203821 	move	a3,t1
bfc01bb8:	8d840004 	lw	a0,4(t4)
bfc01bbc:	3042ffff 	andi	v0,v0,0xffff
bfc01bc0:	0104182a 	slt	v1,t0,a0
bfc01bc4:	00e44821 	addu	t1,a3,a0
bfc01bc8:	0043c821 	addu	t9,v0,v1
bfc01bcc:	2447000a 	addiu	a3,v0,10
bfc01bd0:	00076c00 	sll	t5,a3,0x10
bfc01bd4:	00195400 	sll	t2,t9,0x10
bfc01bd8:	00c9402a 	slt	t0,a2,t1
bfc01bdc:	000d3c03 	sra	a3,t5,0x10
bfc01be0:	11000002 	beqz	t0,bfc01bec <matrix_sum+0x23c>
bfc01be4:	000a1403 	sra	v0,t2,0x10
bfc01be8:	00e01021 	move	v0,a3
bfc01bec:	1500001c 	bnez	t0,bfc01c60 <matrix_sum+0x2b0>
bfc01bf0:	00004021 	move	t0,zero
bfc01bf4:	8d870008 	lw	a3,8(t4)
bfc01bf8:	01204021 	move	t0,t1
bfc01bfc:	3042ffff 	andi	v0,v0,0xffff
bfc01c00:	01075021 	addu	t2,t0,a3
bfc01c04:	0087402a 	slt	t0,a0,a3
bfc01c08:	0048c821 	addu	t9,v0,t0
bfc01c0c:	244d000a 	addiu	t5,v0,10
bfc01c10:	000d2400 	sll	a0,t5,0x10
bfc01c14:	00194c00 	sll	t1,t9,0x10
bfc01c18:	00ca402a 	slt	t0,a2,t2
bfc01c1c:	00042403 	sra	a0,a0,0x10
bfc01c20:	1500001b 	bnez	t0,bfc01c90 <matrix_sum+0x2e0>
bfc01c24:	00091403 	sra	v0,t1,0x10
bfc01c28:	1500001b 	bnez	t0,bfc01c98 <matrix_sum+0x2e8>
bfc01c2c:	00404821 	move	t1,v0
bfc01c30:	01404021 	move	t0,t2
bfc01c34:	256b0003 	addiu	t3,t3,3
bfc01c38:	016ec82b 	sltu	t9,t3,t6
bfc01c3c:	258a000c 	addiu	t2,t4,12
bfc01c40:	1720ffbb 	bnez	t9,bfc01b30 <matrix_sum+0x180>
bfc01c44:	00e01821 	move	v1,a3
bfc01c48:	25ef0001 	addiu	t7,t7,1
bfc01c4c:	01ee202b 	sltu	a0,t7,t6
bfc01c50:	1480ff60 	bnez	a0,bfc019d4 <matrix_sum+0x24>
bfc01c54:	00b82821 	addu	a1,a1,t8
bfc01c58:	03e00008 	jr	ra
bfc01c5c:	01201021 	move	v0,t1
bfc01c60:	8d870008 	lw	a3,8(t4)
bfc01c64:	3042ffff 	andi	v0,v0,0xffff
bfc01c68:	01075021 	addu	t2,t0,a3
bfc01c6c:	0087402a 	slt	t0,a0,a3
bfc01c70:	0048c821 	addu	t9,v0,t0
bfc01c74:	244d000a 	addiu	t5,v0,10
bfc01c78:	000d2400 	sll	a0,t5,0x10
bfc01c7c:	00194c00 	sll	t1,t9,0x10
bfc01c80:	00ca402a 	slt	t0,a2,t2
bfc01c84:	00042403 	sra	a0,a0,0x10
bfc01c88:	1100ffe7 	beqz	t0,bfc01c28 <matrix_sum+0x278>
bfc01c8c:	00091403 	sra	v0,t1,0x10
bfc01c90:	1100ffe7 	beqz	t0,bfc01c30 <matrix_sum+0x280>
bfc01c94:	00804821 	move	t1,a0
bfc01c98:	0bf0070d 	j	bfc01c34 <matrix_sum+0x284>
bfc01c9c:	00004021 	move	t0,zero
bfc01ca0:	0bf00684 	j	bfc01a10 <matrix_sum+0x60>
bfc01ca4:	00e04821 	move	t1,a3
	...
bfc01cb0:	1100ff73 	beqz	t0,bfc01a80 <matrix_sum+0xd0>
bfc01cb4:	00e04821 	move	t1,a3
bfc01cb8:	0bf006a1 	j	bfc01a84 <matrix_sum+0xd4>
bfc01cbc:	00004021 	move	t0,zero
bfc01cc0:	0bf006c4 	j	bfc01b10 <matrix_sum+0x160>
bfc01cc4:	00e04821 	move	t1,a3
	...
bfc01cd0:	0bf006b1 	j	bfc01ac4 <matrix_sum+0x114>
bfc01cd4:	00e04821 	move	t1,a3
bfc01cd8:	00004821 	move	t1,zero
bfc01cdc:	03e00008 	jr	ra
bfc01ce0:	01201021 	move	v0,t1
	...

bfc01cf0 <matrix_mul_const>:
matrix_mul_const():
bfc01cf0:	27bdfff0 	addiu	sp,sp,-16
bfc01cf4:	00077400 	sll	t6,a3,0x10
bfc01cf8:	afb2000c 	sw	s2,12(sp)
bfc01cfc:	afb10008 	sw	s1,8(sp)
bfc01d00:	afb00004 	sw	s0,4(sp)
bfc01d04:	0080c821 	move	t9,a0
bfc01d08:	10800083 	beqz	a0,bfc01f18 <matrix_mul_const+0x228>
bfc01d0c:	000e7403 	sra	t6,t6,0x10
bfc01d10:	00a0c021 	move	t8,a1
bfc01d14:	00c07821 	move	t7,a2
bfc01d18:	00049080 	sll	s2,a0,0x2
bfc01d1c:	00048840 	sll	s1,a0,0x1
bfc01d20:	00008021 	move	s0,zero
bfc01d24:	85e70000 	lh	a3,0(t7)
bfc01d28:	240d0001 	li	t5,1
bfc01d2c:	01c70018 	mult	t6,a3
bfc01d30:	272cffff 	addiu	t4,t9,-1
bfc01d34:	01b9482b 	sltu	t1,t5,t9
bfc01d38:	31830007 	andi	v1,t4,0x7
bfc01d3c:	25eb0002 	addiu	t3,t7,2
bfc01d40:	270c0004 	addiu	t4,t8,4
bfc01d44:	00004012 	mflo	t0
bfc01d48:	1120006e 	beqz	t1,bfc01f04 <matrix_mul_const+0x214>
bfc01d4c:	af080000 	sw	t0,0(t8)
bfc01d50:	10600040 	beqz	v1,bfc01e54 <matrix_mul_const+0x164>
bfc01d54:	00000000 	nop
bfc01d58:	106d0035 	beq	v1,t5,bfc01e30 <matrix_mul_const+0x140>
bfc01d5c:	24060002 	li	a2,2
bfc01d60:	1066002c 	beq	v1,a2,bfc01e14 <matrix_mul_const+0x124>
bfc01d64:	24050003 	li	a1,3
bfc01d68:	10650023 	beq	v1,a1,bfc01df8 <matrix_mul_const+0x108>
bfc01d6c:	24040004 	li	a0,4
bfc01d70:	1064001a 	beq	v1,a0,bfc01ddc <matrix_mul_const+0xec>
bfc01d74:	24020005 	li	v0,5
bfc01d78:	10620011 	beq	v1,v0,bfc01dc0 <matrix_mul_const+0xd0>
bfc01d7c:	240a0006 	li	t2,6
bfc01d80:	106a0008 	beq	v1,t2,bfc01da4 <matrix_mul_const+0xb4>
bfc01d84:	00000000 	nop
bfc01d88:	85690000 	lh	t1,0(t3)
bfc01d8c:	240d0002 	li	t5,2
bfc01d90:	01c90018 	mult	t6,t1
bfc01d94:	25eb0004 	addiu	t3,t7,4
bfc01d98:	00001812 	mflo	v1
bfc01d9c:	ad830000 	sw	v1,0(t4)
bfc01da0:	270c0008 	addiu	t4,t8,8
bfc01da4:	85670000 	lh	a3,0(t3)
bfc01da8:	25ad0001 	addiu	t5,t5,1
bfc01dac:	01c70018 	mult	t6,a3
bfc01db0:	256b0002 	addiu	t3,t3,2
bfc01db4:	00004012 	mflo	t0
bfc01db8:	ad880000 	sw	t0,0(t4)
bfc01dbc:	258c0004 	addiu	t4,t4,4
bfc01dc0:	85650000 	lh	a1,0(t3)
bfc01dc4:	25ad0001 	addiu	t5,t5,1
bfc01dc8:	01c50018 	mult	t6,a1
bfc01dcc:	256b0002 	addiu	t3,t3,2
bfc01dd0:	00003012 	mflo	a2
bfc01dd4:	ad860000 	sw	a2,0(t4)
bfc01dd8:	258c0004 	addiu	t4,t4,4
bfc01ddc:	85620000 	lh	v0,0(t3)
bfc01de0:	25ad0001 	addiu	t5,t5,1
bfc01de4:	01c20018 	mult	t6,v0
bfc01de8:	256b0002 	addiu	t3,t3,2
bfc01dec:	00002012 	mflo	a0
bfc01df0:	ad840000 	sw	a0,0(t4)
bfc01df4:	258c0004 	addiu	t4,t4,4
bfc01df8:	85630000 	lh	v1,0(t3)
bfc01dfc:	25ad0001 	addiu	t5,t5,1
bfc01e00:	01c30018 	mult	t6,v1
bfc01e04:	256b0002 	addiu	t3,t3,2
bfc01e08:	00005012 	mflo	t2
bfc01e0c:	ad8a0000 	sw	t2,0(t4)
bfc01e10:	258c0004 	addiu	t4,t4,4
bfc01e14:	85680000 	lh	t0,0(t3)
bfc01e18:	25ad0001 	addiu	t5,t5,1
bfc01e1c:	01c80018 	mult	t6,t0
bfc01e20:	256b0002 	addiu	t3,t3,2
bfc01e24:	00004812 	mflo	t1
bfc01e28:	ad890000 	sw	t1,0(t4)
bfc01e2c:	258c0004 	addiu	t4,t4,4
bfc01e30:	85650000 	lh	a1,0(t3)
bfc01e34:	25ad0001 	addiu	t5,t5,1
bfc01e38:	01c50018 	mult	t6,a1
bfc01e3c:	01b9382b 	sltu	a3,t5,t9
bfc01e40:	256b0002 	addiu	t3,t3,2
bfc01e44:	00003012 	mflo	a2
bfc01e48:	ad860000 	sw	a2,0(t4)
bfc01e4c:	10e0002d 	beqz	a3,bfc01f04 <matrix_mul_const+0x214>
bfc01e50:	258c0004 	addiu	t4,t4,4
bfc01e54:	856a0000 	lh	t2,0(t3)
bfc01e58:	85630002 	lh	v1,2(t3)
bfc01e5c:	01ca0018 	mult	t6,t2
bfc01e60:	85640004 	lh	a0,4(t3)
bfc01e64:	85650006 	lh	a1,6(t3)
bfc01e68:	85660008 	lh	a2,8(t3)
bfc01e6c:	8567000a 	lh	a3,10(t3)
bfc01e70:	8568000c 	lh	t0,12(t3)
bfc01e74:	8569000e 	lh	t1,14(t3)
bfc01e78:	25ad0008 	addiu	t5,t5,8
bfc01e7c:	01b9502b 	sltu	t2,t5,t9
bfc01e80:	256b0010 	addiu	t3,t3,16
bfc01e84:	00001012 	mflo	v0
bfc01e88:	ad820000 	sw	v0,0(t4)
bfc01e8c:	00000000 	nop
bfc01e90:	01c30018 	mult	t6,v1
bfc01e94:	00001812 	mflo	v1
bfc01e98:	ad830004 	sw	v1,4(t4)
bfc01e9c:	00000000 	nop
bfc01ea0:	01c40018 	mult	t6,a0
bfc01ea4:	00002012 	mflo	a0
bfc01ea8:	ad840008 	sw	a0,8(t4)
bfc01eac:	00000000 	nop
bfc01eb0:	01c50018 	mult	t6,a1
bfc01eb4:	00002812 	mflo	a1
bfc01eb8:	ad85000c 	sw	a1,12(t4)
bfc01ebc:	00000000 	nop
bfc01ec0:	01c60018 	mult	t6,a2
bfc01ec4:	00003012 	mflo	a2
bfc01ec8:	ad860010 	sw	a2,16(t4)
bfc01ecc:	00000000 	nop
bfc01ed0:	01c70018 	mult	t6,a3
bfc01ed4:	00003812 	mflo	a3
bfc01ed8:	ad870014 	sw	a3,20(t4)
bfc01edc:	00000000 	nop
bfc01ee0:	01c80018 	mult	t6,t0
bfc01ee4:	00004012 	mflo	t0
bfc01ee8:	ad880018 	sw	t0,24(t4)
bfc01eec:	00000000 	nop
bfc01ef0:	01c90018 	mult	t6,t1
bfc01ef4:	00004812 	mflo	t1
bfc01ef8:	ad89001c 	sw	t1,28(t4)
bfc01efc:	1540ffd5 	bnez	t2,bfc01e54 <matrix_mul_const+0x164>
bfc01f00:	258c0020 	addiu	t4,t4,32
bfc01f04:	26100001 	addiu	s0,s0,1
bfc01f08:	0219582b 	sltu	t3,s0,t9
bfc01f0c:	0312c021 	addu	t8,t8,s2
bfc01f10:	1560ff84 	bnez	t3,bfc01d24 <matrix_mul_const+0x34>
bfc01f14:	01f17821 	addu	t7,t7,s1
bfc01f18:	8fb2000c 	lw	s2,12(sp)
bfc01f1c:	8fb10008 	lw	s1,8(sp)
bfc01f20:	8fb00004 	lw	s0,4(sp)
bfc01f24:	03e00008 	jr	ra
bfc01f28:	27bd0010 	addiu	sp,sp,16
bfc01f2c:	00000000 	nop

bfc01f30 <matrix_add_const>:
matrix_add_const():
bfc01f30:	00061400 	sll	v0,a2,0x10
bfc01f34:	00807821 	move	t7,a0
bfc01f38:	10800061 	beqz	a0,bfc020c0 <matrix_add_const+0x190>
bfc01f3c:	00021403 	sra	v0,v0,0x10
bfc01f40:	304dffff 	andi	t5,v0,0xffff
bfc01f44:	00a07021 	move	t6,a1
bfc01f48:	0004c840 	sll	t9,a0,0x1
bfc01f4c:	0000c021 	move	t8,zero
bfc01f50:	95c80000 	lhu	t0,0(t6)
bfc01f54:	240c0001 	li	t4,1
bfc01f58:	01a81021 	addu	v0,t5,t0
bfc01f5c:	25e9ffff 	addiu	t1,t7,-1
bfc01f60:	018f502b 	sltu	t2,t4,t7
bfc01f64:	a5c20000 	sh	v0,0(t6)
bfc01f68:	31230007 	andi	v1,t1,0x7
bfc01f6c:	11400050 	beqz	t2,bfc020b0 <matrix_add_const+0x180>
bfc01f70:	25cb0002 	addiu	t3,t6,2
bfc01f74:	10600032 	beqz	v1,bfc02040 <matrix_add_const+0x110>
bfc01f78:	00000000 	nop
bfc01f7c:	106c0029 	beq	v1,t4,bfc02024 <matrix_add_const+0xf4>
bfc01f80:	24070002 	li	a3,2
bfc01f84:	10670022 	beq	v1,a3,bfc02010 <matrix_add_const+0xe0>
bfc01f88:	24060003 	li	a2,3
bfc01f8c:	1066001b 	beq	v1,a2,bfc01ffc <matrix_add_const+0xcc>
bfc01f90:	24050004 	li	a1,4
bfc01f94:	10650014 	beq	v1,a1,bfc01fe8 <matrix_add_const+0xb8>
bfc01f98:	24040005 	li	a0,5
bfc01f9c:	1064000d 	beq	v1,a0,bfc01fd4 <matrix_add_const+0xa4>
bfc01fa0:	240a0006 	li	t2,6
bfc01fa4:	106a0006 	beq	v1,t2,bfc01fc0 <matrix_add_const+0x90>
bfc01fa8:	00000000 	nop
bfc01fac:	95690000 	lhu	t1,0(t3)
bfc01fb0:	240c0002 	li	t4,2
bfc01fb4:	01a91821 	addu	v1,t5,t1
bfc01fb8:	a5630000 	sh	v1,0(t3)
bfc01fbc:	25cb0004 	addiu	t3,t6,4
bfc01fc0:	95680000 	lhu	t0,0(t3)
bfc01fc4:	258c0001 	addiu	t4,t4,1
bfc01fc8:	01a81021 	addu	v0,t5,t0
bfc01fcc:	a5620000 	sh	v0,0(t3)
bfc01fd0:	256b0002 	addiu	t3,t3,2
bfc01fd4:	95660000 	lhu	a2,0(t3)
bfc01fd8:	258c0001 	addiu	t4,t4,1
bfc01fdc:	01a63821 	addu	a3,t5,a2
bfc01fe0:	a5670000 	sh	a3,0(t3)
bfc01fe4:	256b0002 	addiu	t3,t3,2
bfc01fe8:	95640000 	lhu	a0,0(t3)
bfc01fec:	258c0001 	addiu	t4,t4,1
bfc01ff0:	01a42821 	addu	a1,t5,a0
bfc01ff4:	a5650000 	sh	a1,0(t3)
bfc01ff8:	256b0002 	addiu	t3,t3,2
bfc01ffc:	95630000 	lhu	v1,0(t3)
bfc02000:	258c0001 	addiu	t4,t4,1
bfc02004:	01a35021 	addu	t2,t5,v1
bfc02008:	a56a0000 	sh	t2,0(t3)
bfc0200c:	256b0002 	addiu	t3,t3,2
bfc02010:	95620000 	lhu	v0,0(t3)
bfc02014:	258c0001 	addiu	t4,t4,1
bfc02018:	01a24821 	addu	t1,t5,v0
bfc0201c:	a5690000 	sh	t1,0(t3)
bfc02020:	256b0002 	addiu	t3,t3,2
bfc02024:	95660000 	lhu	a2,0(t3)
bfc02028:	258c0001 	addiu	t4,t4,1
bfc0202c:	01a63821 	addu	a3,t5,a2
bfc02030:	018f402b 	sltu	t0,t4,t7
bfc02034:	a5670000 	sh	a3,0(t3)
bfc02038:	1100001d 	beqz	t0,bfc020b0 <matrix_add_const+0x180>
bfc0203c:	256b0002 	addiu	t3,t3,2
bfc02040:	95630000 	lhu	v1,0(t3)
bfc02044:	95640002 	lhu	a0,2(t3)
bfc02048:	95650004 	lhu	a1,4(t3)
bfc0204c:	95660006 	lhu	a2,6(t3)
bfc02050:	95670008 	lhu	a3,8(t3)
bfc02054:	9568000a 	lhu	t0,10(t3)
bfc02058:	9569000c 	lhu	t1,12(t3)
bfc0205c:	956a000e 	lhu	t2,14(t3)
bfc02060:	258c0008 	addiu	t4,t4,8
bfc02064:	01a31021 	addu	v0,t5,v1
bfc02068:	01a41821 	addu	v1,t5,a0
bfc0206c:	01a52021 	addu	a0,t5,a1
bfc02070:	01a62821 	addu	a1,t5,a2
bfc02074:	01a73021 	addu	a2,t5,a3
bfc02078:	01a83821 	addu	a3,t5,t0
bfc0207c:	01a94021 	addu	t0,t5,t1
bfc02080:	01aa4821 	addu	t1,t5,t2
bfc02084:	018f502b 	sltu	t2,t4,t7
bfc02088:	a5620000 	sh	v0,0(t3)
bfc0208c:	a5630002 	sh	v1,2(t3)
bfc02090:	a5640004 	sh	a0,4(t3)
bfc02094:	a5650006 	sh	a1,6(t3)
bfc02098:	a5660008 	sh	a2,8(t3)
bfc0209c:	a567000a 	sh	a3,10(t3)
bfc020a0:	a568000c 	sh	t0,12(t3)
bfc020a4:	a569000e 	sh	t1,14(t3)
bfc020a8:	1540ffe5 	bnez	t2,bfc02040 <matrix_add_const+0x110>
bfc020ac:	256b0010 	addiu	t3,t3,16
bfc020b0:	27180001 	addiu	t8,t8,1
bfc020b4:	030f582b 	sltu	t3,t8,t7
bfc020b8:	1560ffa5 	bnez	t3,bfc01f50 <matrix_add_const+0x20>
bfc020bc:	01d97021 	addu	t6,t6,t9
bfc020c0:	03e00008 	jr	ra
bfc020c4:	00000000 	nop
	...

bfc020d0 <matrix_mul_vect>:
matrix_mul_vect():
bfc020d0:	27bdffd8 	addiu	sp,sp,-40
bfc020d4:	afb70020 	sw	s7,32(sp)
bfc020d8:	afb40014 	sw	s4,20(sp)
bfc020dc:	afbe0024 	sw	s8,36(sp)
bfc020e0:	afb6001c 	sw	s6,28(sp)
bfc020e4:	afb50018 	sw	s5,24(sp)
bfc020e8:	afb30010 	sw	s3,16(sp)
bfc020ec:	afb2000c 	sw	s2,12(sp)
bfc020f0:	afb10008 	sw	s1,8(sp)
bfc020f4:	afb00004 	sw	s0,4(sp)
bfc020f8:	0080a021 	move	s4,a0
bfc020fc:	10800093 	beqz	a0,bfc0234c <matrix_mul_vect+0x27c>
bfc02100:	00e0b821 	move	s7,a3
bfc02104:	00a0b021 	move	s6,a1
bfc02108:	00c09821 	move	s3,a2
bfc0210c:	0004f040 	sll	s8,a0,0x1
bfc02110:	0000a821 	move	s5,zero
bfc02114:	86e40000 	lh	a0,0(s7)
bfc02118:	86620000 	lh	v0,0(s3)
bfc0211c:	24110001 	li	s1,1
bfc02120:	00820018 	mult	a0,v0
bfc02124:	2683ffff 	addiu	v1,s4,-1
bfc02128:	0234282b 	sltu	a1,s1,s4
bfc0212c:	30630007 	andi	v1,v1,0x7
bfc02130:	26780002 	addiu	t8,s3,2
bfc02134:	00009012 	mflo	s2
bfc02138:	10a0007e 	beqz	a1,bfc02334 <matrix_mul_vect+0x264>
bfc0213c:	26f90002 	addiu	t9,s7,2
bfc02140:	10600047 	beqz	v1,bfc02260 <matrix_mul_vect+0x190>
bfc02144:	00000000 	nop
bfc02148:	1071003b 	beq	v1,s1,bfc02238 <matrix_mul_vect+0x168>
bfc0214c:	24100002 	li	s0,2
bfc02150:	10700031 	beq	v1,s0,bfc02218 <matrix_mul_vect+0x148>
bfc02154:	24070003 	li	a3,3
bfc02158:	10670027 	beq	v1,a3,bfc021f8 <matrix_mul_vect+0x128>
bfc0215c:	240f0004 	li	t7,4
bfc02160:	106f001d 	beq	v1,t7,bfc021d8 <matrix_mul_vect+0x108>
bfc02164:	24060005 	li	a2,5
bfc02168:	10660013 	beq	v1,a2,bfc021b8 <matrix_mul_vect+0xe8>
bfc0216c:	240e0006 	li	t6,6
bfc02170:	106e0009 	beq	v1,t6,bfc02198 <matrix_mul_vect+0xc8>
bfc02174:	00000000 	nop
bfc02178:	87190000 	lh	t9,0(t8)
bfc0217c:	86f80002 	lh	t8,2(s7)
bfc02180:	24110002 	li	s1,2
bfc02184:	03190018 	mult	t8,t9
bfc02188:	26780004 	addiu	t8,s3,4
bfc0218c:	26f90004 	addiu	t9,s7,4
bfc02190:	00002812 	mflo	a1
bfc02194:	02459021 	addu	s2,s2,a1
bfc02198:	87290000 	lh	t1,0(t9)
bfc0219c:	87040000 	lh	a0,0(t8)
bfc021a0:	26310001 	addiu	s1,s1,1
bfc021a4:	01240018 	mult	t1,a0
bfc021a8:	27180002 	addiu	t8,t8,2
bfc021ac:	27390002 	addiu	t9,t9,2
bfc021b0:	00006812 	mflo	t5
bfc021b4:	024d9021 	addu	s2,s2,t5
bfc021b8:	87220000 	lh	v0,0(t9)
bfc021bc:	870b0000 	lh	t3,0(t8)
bfc021c0:	26310001 	addiu	s1,s1,1
bfc021c4:	004b0018 	mult	v0,t3
bfc021c8:	27180002 	addiu	t8,t8,2
bfc021cc:	27390002 	addiu	t9,t9,2
bfc021d0:	00006012 	mflo	t4
bfc021d4:	024c9021 	addu	s2,s2,t4
bfc021d8:	87280000 	lh	t0,0(t9)
bfc021dc:	87030000 	lh	v1,0(t8)
bfc021e0:	26310001 	addiu	s1,s1,1
bfc021e4:	01030018 	mult	t0,v1
bfc021e8:	27180002 	addiu	t8,t8,2
bfc021ec:	27390002 	addiu	t9,t9,2
bfc021f0:	00005012 	mflo	t2
bfc021f4:	024a9021 	addu	s2,s2,t2
bfc021f8:	87270000 	lh	a3,0(t9)
bfc021fc:	870f0000 	lh	t7,0(t8)
bfc02200:	26310001 	addiu	s1,s1,1
bfc02204:	00ef0018 	mult	a3,t7
bfc02208:	27180002 	addiu	t8,t8,2
bfc0220c:	27390002 	addiu	t9,t9,2
bfc02210:	00008012 	mflo	s0
bfc02214:	02509021 	addu	s2,s2,s0
bfc02218:	872e0000 	lh	t6,0(t9)
bfc0221c:	87050000 	lh	a1,0(t8)
bfc02220:	26310001 	addiu	s1,s1,1
bfc02224:	01c50018 	mult	t6,a1
bfc02228:	27180002 	addiu	t8,t8,2
bfc0222c:	27390002 	addiu	t9,t9,2
bfc02230:	00003012 	mflo	a2
bfc02234:	02469021 	addu	s2,s2,a2
bfc02238:	87240000 	lh	a0,0(t9)
bfc0223c:	870c0000 	lh	t4,0(t8)
bfc02240:	26310001 	addiu	s1,s1,1
bfc02244:	008c0018 	mult	a0,t4
bfc02248:	0234682b 	sltu	t5,s1,s4
bfc0224c:	27180002 	addiu	t8,t8,2
bfc02250:	27390002 	addiu	t9,t9,2
bfc02254:	00004812 	mflo	t1
bfc02258:	11a00036 	beqz	t5,bfc02334 <matrix_mul_vect+0x264>
bfc0225c:	02499021 	addu	s2,s2,t1
bfc02260:	87280000 	lh	t0,0(t9)
bfc02264:	87030000 	lh	v1,0(t8)
bfc02268:	872b0002 	lh	t3,2(t9)
bfc0226c:	01030018 	mult	t0,v1
bfc02270:	870a0002 	lh	t2,2(t8)
bfc02274:	87240004 	lh	a0,4(t9)
bfc02278:	870c0004 	lh	t4,4(t8)
bfc0227c:	87250006 	lh	a1,6(t9)
bfc02280:	870d0006 	lh	t5,6(t8)
bfc02284:	87260008 	lh	a2,8(t9)
bfc02288:	870e0008 	lh	t6,8(t8)
bfc0228c:	8727000a 	lh	a3,10(t9)
bfc02290:	870f000a 	lh	t7,10(t8)
bfc02294:	8728000c 	lh	t0,12(t9)
bfc02298:	8710000c 	lh	s0,12(t8)
bfc0229c:	8723000e 	lh	v1,14(t9)
bfc022a0:	00001012 	mflo	v0
bfc022a4:	26310008 	addiu	s1,s1,8
bfc022a8:	02421021 	addu	v0,s2,v0
bfc022ac:	27390010 	addiu	t9,t9,16
bfc022b0:	016a0018 	mult	t3,t2
bfc022b4:	870b000e 	lh	t3,14(t8)
bfc022b8:	0234502b 	sltu	t2,s1,s4
bfc022bc:	27180010 	addiu	t8,t8,16
bfc022c0:	00004812 	mflo	t1
	...
bfc022cc:	008c0018 	mult	a0,t4
bfc022d0:	00496021 	addu	t4,v0,t1
bfc022d4:	00002012 	mflo	a0
bfc022d8:	01841021 	addu	v0,t4,a0
bfc022dc:	00000000 	nop
bfc022e0:	00ad0018 	mult	a1,t5
bfc022e4:	00002812 	mflo	a1
	...
bfc022f0:	00ce0018 	mult	a2,t6
bfc022f4:	00457021 	addu	t6,v0,a1
bfc022f8:	00009012 	mflo	s2
bfc022fc:	01d26021 	addu	t4,t6,s2
bfc02300:	00000000 	nop
bfc02304:	00ef0018 	mult	a3,t7
bfc02308:	00006812 	mflo	t5
bfc0230c:	018d4821 	addu	t1,t4,t5
bfc02310:	00000000 	nop
bfc02314:	01100018 	mult	t0,s0
bfc02318:	00004012 	mflo	t0
bfc0231c:	01283021 	addu	a2,t1,t0
bfc02320:	00000000 	nop
bfc02324:	006b0018 	mult	v1,t3
bfc02328:	00003812 	mflo	a3
bfc0232c:	1540ffcc 	bnez	t2,bfc02260 <matrix_mul_vect+0x190>
bfc02330:	00c79021 	addu	s2,a2,a3
bfc02334:	26b50001 	addiu	s5,s5,1
bfc02338:	02b4882b 	sltu	s1,s5,s4
bfc0233c:	aed20000 	sw	s2,0(s6)
bfc02340:	027e9821 	addu	s3,s3,s8
bfc02344:	1620ff73 	bnez	s1,bfc02114 <matrix_mul_vect+0x44>
bfc02348:	26d60004 	addiu	s6,s6,4
bfc0234c:	8fbe0024 	lw	s8,36(sp)
bfc02350:	8fb70020 	lw	s7,32(sp)
bfc02354:	8fb6001c 	lw	s6,28(sp)
bfc02358:	8fb50018 	lw	s5,24(sp)
bfc0235c:	8fb40014 	lw	s4,20(sp)
bfc02360:	8fb30010 	lw	s3,16(sp)
bfc02364:	8fb2000c 	lw	s2,12(sp)
bfc02368:	8fb10008 	lw	s1,8(sp)
bfc0236c:	8fb00004 	lw	s0,4(sp)
bfc02370:	03e00008 	jr	ra
bfc02374:	27bd0028 	addiu	sp,sp,40
	...

bfc02380 <matrix_mul_matrix>:
matrix_mul_matrix():
bfc02380:	27bdffc8 	addiu	sp,sp,-56
bfc02384:	afb50028 	sw	s5,40(sp)
bfc02388:	afbe0034 	sw	s8,52(sp)
bfc0238c:	afb70030 	sw	s7,48(sp)
bfc02390:	afb6002c 	sw	s6,44(sp)
bfc02394:	afb40024 	sw	s4,36(sp)
bfc02398:	afb30020 	sw	s3,32(sp)
bfc0239c:	afb2001c 	sw	s2,28(sp)
bfc023a0:	afb10018 	sw	s1,24(sp)
bfc023a4:	afb00014 	sw	s0,20(sp)
bfc023a8:	0080a821 	move	s5,a0
bfc023ac:	108000a8 	beqz	a0,bfc02650 <matrix_mul_matrix+0x2d0>
bfc023b0:	afa70044 	sw	a3,68(sp)
bfc023b4:	00041080 	sll	v0,a0,0x2
bfc023b8:	00c0f021 	move	s8,a2
bfc023bc:	afa50004 	sw	a1,4(sp)
bfc023c0:	00049840 	sll	s3,a0,0x1
bfc023c4:	afa20000 	sw	v0,0(sp)
bfc023c8:	afa00008 	sw	zero,8(sp)
bfc023cc:	8fb40044 	lw	s4,68(sp)
bfc023d0:	8fb70004 	lw	s7,4(sp)
bfc023d4:	0000b021 	move	s6,zero
bfc023d8:	86840000 	lh	a0,0(s4)
bfc023dc:	87c60000 	lh	a2,0(s8)
bfc023e0:	24190001 	li	t9,1
bfc023e4:	00860018 	mult	a0,a2
bfc023e8:	26a3ffff 	addiu	v1,s5,-1
bfc023ec:	0335282b 	sltu	a1,t9,s5
bfc023f0:	30630007 	andi	v1,v1,0x7
bfc023f4:	27d80002 	addiu	t8,s8,2
bfc023f8:	00009012 	mflo	s2
bfc023fc:	10a00084 	beqz	a1,bfc02610 <matrix_mul_matrix+0x290>
bfc02400:	02935021 	addu	t2,s4,s3
bfc02404:	10600047 	beqz	v1,bfc02524 <matrix_mul_matrix+0x1a4>
bfc02408:	00000000 	nop
bfc0240c:	1079003b 	beq	v1,t9,bfc024fc <matrix_mul_matrix+0x17c>
bfc02410:	240b0002 	li	t3,2
bfc02414:	106b0031 	beq	v1,t3,bfc024dc <matrix_mul_matrix+0x15c>
bfc02418:	24090003 	li	t1,3
bfc0241c:	10690027 	beq	v1,t1,bfc024bc <matrix_mul_matrix+0x13c>
bfc02420:	24110004 	li	s1,4
bfc02424:	1071001d 	beq	v1,s1,bfc0249c <matrix_mul_matrix+0x11c>
bfc02428:	24020005 	li	v0,5
bfc0242c:	10620013 	beq	v1,v0,bfc0247c <matrix_mul_matrix+0xfc>
bfc02430:	24050006 	li	a1,6
bfc02434:	10650009 	beq	v1,a1,bfc0245c <matrix_mul_matrix+0xdc>
bfc02438:	00000000 	nop
bfc0243c:	870c0000 	lh	t4,0(t8)
bfc02440:	854d0000 	lh	t5,0(t2)
bfc02444:	24190002 	li	t9,2
bfc02448:	01ac0018 	mult	t5,t4
bfc0244c:	01535021 	addu	t2,t2,s3
bfc02450:	27d80004 	addiu	t8,s8,4
bfc02454:	00001812 	mflo	v1
bfc02458:	02439021 	addu	s2,s2,v1
bfc0245c:	85460000 	lh	a2,0(t2)
bfc02460:	870e0000 	lh	t6,0(t8)
bfc02464:	27390001 	addiu	t9,t9,1
bfc02468:	00ce0018 	mult	a2,t6
bfc0246c:	27180002 	addiu	t8,t8,2
bfc02470:	01535021 	addu	t2,t2,s3
bfc02474:	00002012 	mflo	a0
bfc02478:	02449021 	addu	s2,s2,a0
bfc0247c:	854f0000 	lh	t7,0(t2)
bfc02480:	87080000 	lh	t0,0(t8)
bfc02484:	27390001 	addiu	t9,t9,1
bfc02488:	01e80018 	mult	t7,t0
bfc0248c:	27180002 	addiu	t8,t8,2
bfc02490:	01535021 	addu	t2,t2,s3
bfc02494:	00003812 	mflo	a3
bfc02498:	02479021 	addu	s2,s2,a3
bfc0249c:	854b0000 	lh	t3,0(t2)
bfc024a0:	87090000 	lh	t1,0(t8)
bfc024a4:	27390001 	addiu	t9,t9,1
bfc024a8:	01690018 	mult	t3,t1
bfc024ac:	27180002 	addiu	t8,t8,2
bfc024b0:	01535021 	addu	t2,t2,s3
bfc024b4:	00008012 	mflo	s0
bfc024b8:	02509021 	addu	s2,s2,s0
bfc024bc:	85420000 	lh	v0,0(t2)
bfc024c0:	87050000 	lh	a1,0(t8)
bfc024c4:	27390001 	addiu	t9,t9,1
bfc024c8:	00450018 	mult	v0,a1
bfc024cc:	27180002 	addiu	t8,t8,2
bfc024d0:	01535021 	addu	t2,t2,s3
bfc024d4:	00008812 	mflo	s1
bfc024d8:	02519021 	addu	s2,s2,s1
bfc024dc:	854d0000 	lh	t5,0(t2)
bfc024e0:	870c0000 	lh	t4,0(t8)
bfc024e4:	27390001 	addiu	t9,t9,1
bfc024e8:	01ac0018 	mult	t5,t4
bfc024ec:	27180002 	addiu	t8,t8,2
bfc024f0:	01535021 	addu	t2,t2,s3
bfc024f4:	00001812 	mflo	v1
bfc024f8:	02439021 	addu	s2,s2,v1
bfc024fc:	854e0000 	lh	t6,0(t2)
bfc02500:	87070000 	lh	a3,0(t8)
bfc02504:	27390001 	addiu	t9,t9,1
bfc02508:	01c70018 	mult	t6,a3
bfc0250c:	0335202b 	sltu	a0,t9,s5
bfc02510:	27180002 	addiu	t8,t8,2
bfc02514:	01535021 	addu	t2,t2,s3
bfc02518:	00003012 	mflo	a2
bfc0251c:	1080003c 	beqz	a0,bfc02610 <matrix_mul_matrix+0x290>
bfc02520:	02469021 	addu	s2,s2,a2
bfc02524:	854f0000 	lh	t7,0(t2)
bfc02528:	87080000 	lh	t0,0(t8)
bfc0252c:	01533821 	addu	a3,t2,s3
bfc02530:	01e80018 	mult	t7,t0
bfc02534:	870d0002 	lh	t5,2(t8)
bfc02538:	84ec0000 	lh	t4,0(a3)
bfc0253c:	00f37021 	addu	t6,a3,s3
bfc02540:	87110004 	lh	s1,4(t8)
bfc02544:	85c90000 	lh	t1,0(t6)
bfc02548:	01d33021 	addu	a2,t6,s3
bfc0254c:	87100006 	lh	s0,6(t8)
bfc02550:	84c80000 	lh	t0,0(a2)
bfc02554:	00d32021 	addu	a0,a2,s3
bfc02558:	870f0008 	lh	t7,8(t8)
bfc0255c:	84870000 	lh	a3,0(a0)
bfc02560:	00932821 	addu	a1,a0,s3
bfc02564:	00001012 	mflo	v0
bfc02568:	870e000a 	lh	t6,10(t8)
bfc0256c:	84a60000 	lh	a2,0(a1)
bfc02570:	00b31821 	addu	v1,a1,s3
bfc02574:	018d0018 	mult	t4,t5
bfc02578:	84640000 	lh	a0,0(v1)
bfc0257c:	870c000c 	lh	t4,12(t8)
bfc02580:	00735021 	addu	t2,v1,s3
bfc02584:	870d000e 	lh	t5,14(t8)
bfc02588:	85430000 	lh	v1,0(t2)
bfc0258c:	02421021 	addu	v0,s2,v0
bfc02590:	27390008 	addiu	t9,t9,8
bfc02594:	0335282b 	sltu	a1,t9,s5
bfc02598:	27180010 	addiu	t8,t8,16
bfc0259c:	01535021 	addu	t2,t2,s3
bfc025a0:	00005812 	mflo	t3
bfc025a4:	004b1021 	addu	v0,v0,t3
bfc025a8:	00000000 	nop
bfc025ac:	01310018 	mult	t1,s1
bfc025b0:	00004812 	mflo	t1
bfc025b4:	00499021 	addu	s2,v0,t1
bfc025b8:	00000000 	nop
bfc025bc:	01100018 	mult	t0,s0
bfc025c0:	00004012 	mflo	t0
bfc025c4:	02488021 	addu	s0,s2,t0
bfc025c8:	00000000 	nop
bfc025cc:	00ef0018 	mult	a3,t7
bfc025d0:	00008812 	mflo	s1
	...
bfc025dc:	00ce0018 	mult	a2,t6
bfc025e0:	02117021 	addu	t6,s0,s1
bfc025e4:	00007812 	mflo	t7
bfc025e8:	01cf4821 	addu	t1,t6,t7
bfc025ec:	00000000 	nop
bfc025f0:	008c0018 	mult	a0,t4
bfc025f4:	00005812 	mflo	t3
bfc025f8:	012b3821 	addu	a3,t1,t3
bfc025fc:	00000000 	nop
bfc02600:	006d0018 	mult	v1,t5
bfc02604:	00004012 	mflo	t0
bfc02608:	14a0ffc6 	bnez	a1,bfc02524 <matrix_mul_matrix+0x1a4>
bfc0260c:	00e89021 	addu	s2,a3,t0
bfc02610:	26d60001 	addiu	s6,s6,1
bfc02614:	02d5c02b 	sltu	t8,s6,s5
bfc02618:	aef20000 	sw	s2,0(s7)
bfc0261c:	26940002 	addiu	s4,s4,2
bfc02620:	1700ff6d 	bnez	t8,bfc023d8 <matrix_mul_matrix+0x58>
bfc02624:	26f70004 	addiu	s7,s7,4
bfc02628:	8fb00008 	lw	s0,8(sp)
bfc0262c:	8fb70004 	lw	s7,4(sp)
bfc02630:	8fb90000 	lw	t9,0(sp)
bfc02634:	26120001 	addiu	s2,s0,1
bfc02638:	02f9b021 	addu	s6,s7,t9
bfc0263c:	0255a02b 	sltu	s4,s2,s5
bfc02640:	afb20008 	sw	s2,8(sp)
bfc02644:	03d3f021 	addu	s8,s8,s3
bfc02648:	1680ff60 	bnez	s4,bfc023cc <matrix_mul_matrix+0x4c>
bfc0264c:	afb60004 	sw	s6,4(sp)
bfc02650:	8fbe0034 	lw	s8,52(sp)
bfc02654:	8fb70030 	lw	s7,48(sp)
bfc02658:	8fb6002c 	lw	s6,44(sp)
bfc0265c:	8fb50028 	lw	s5,40(sp)
bfc02660:	8fb40024 	lw	s4,36(sp)
bfc02664:	8fb30020 	lw	s3,32(sp)
bfc02668:	8fb2001c 	lw	s2,28(sp)
bfc0266c:	8fb10018 	lw	s1,24(sp)
bfc02670:	8fb00014 	lw	s0,20(sp)
bfc02674:	03e00008 	jr	ra
bfc02678:	27bd0038 	addiu	sp,sp,56
bfc0267c:	00000000 	nop

bfc02680 <matrix_mul_matrix_bitextract>:
matrix_mul_matrix_bitextract():
bfc02680:	27bdffd8 	addiu	sp,sp,-40
bfc02684:	afbe0024 	sw	s8,36(sp)
bfc02688:	afb00004 	sw	s0,4(sp)
bfc0268c:	afb70020 	sw	s7,32(sp)
bfc02690:	afb6001c 	sw	s6,28(sp)
bfc02694:	afb50018 	sw	s5,24(sp)
bfc02698:	afb40014 	sw	s4,20(sp)
bfc0269c:	afb30010 	sw	s3,16(sp)
bfc026a0:	afb2000c 	sw	s2,12(sp)
bfc026a4:	afb10008 	sw	s1,8(sp)
bfc026a8:	00808021 	move	s0,a0
bfc026ac:	1080008e 	beqz	a0,bfc028e8 <matrix_mul_matrix_bitextract+0x268>
bfc026b0:	00e0f021 	move	s8,a3
bfc026b4:	00c0a021 	move	s4,a2
bfc026b8:	00a0a821 	move	s5,a1
bfc026bc:	0004c840 	sll	t9,a0,0x1
bfc026c0:	0004b880 	sll	s7,a0,0x2
bfc026c4:	0000b021 	move	s6,zero
bfc026c8:	03c08821 	move	s1,s8
bfc026cc:	02a09021 	move	s2,s5
bfc026d0:	00009821 	move	s3,zero
bfc026d4:	86290000 	lh	t1,0(s1)
bfc026d8:	868a0000 	lh	t2,0(s4)
bfc026dc:	240f0001 	li	t7,1
bfc026e0:	012a0018 	mult	t1,t2
bfc026e4:	2604ffff 	addiu	a0,s0,-1
bfc026e8:	01f0282b 	sltu	a1,t7,s0
bfc026ec:	30840003 	andi	a0,a0,0x3
bfc026f0:	268d0002 	addiu	t5,s4,2
bfc026f4:	00004012 	mflo	t0
bfc026f8:	00083083 	sra	a2,t0,0x2
bfc026fc:	00083943 	sra	a3,t0,0x5
bfc02700:	30e2007f 	andi	v0,a3,0x7f
bfc02704:	30c3000f 	andi	v1,a2,0xf
bfc02708:	00430018 	mult	v0,v1
bfc0270c:	0000c012 	mflo	t8
bfc02710:	10a0006a 	beqz	a1,bfc028bc <matrix_mul_matrix_bitextract+0x23c>
bfc02714:	02397021 	addu	t6,s1,t9
bfc02718:	10800031 	beqz	a0,bfc027e0 <matrix_mul_matrix_bitextract+0x160>
bfc0271c:	00000000 	nop
bfc02720:	108f001f 	beq	a0,t7,bfc027a0 <matrix_mul_matrix_bitextract+0x120>
bfc02724:	24030002 	li	v1,2
bfc02728:	1083000f 	beq	a0,v1,bfc02768 <matrix_mul_matrix_bitextract+0xe8>
bfc0272c:	00000000 	nop
bfc02730:	85a70000 	lh	a3,0(t5)
bfc02734:	85cc0000 	lh	t4,0(t6)
bfc02738:	240f0002 	li	t7,2
bfc0273c:	01870018 	mult	t4,a3
bfc02740:	01d97021 	addu	t6,t6,t9
bfc02744:	268d0004 	addiu	t5,s4,4
bfc02748:	00004812 	mflo	t1
bfc0274c:	00091083 	sra	v0,t1,0x2
bfc02750:	00092943 	sra	a1,t1,0x5
bfc02754:	30a8007f 	andi	t0,a1,0x7f
bfc02758:	304a000f 	andi	t2,v0,0xf
bfc0275c:	010a0018 	mult	t0,t2
bfc02760:	00002012 	mflo	a0
bfc02764:	0304c021 	addu	t8,t8,a0
bfc02768:	85c20000 	lh	v0,0(t6)
bfc0276c:	85a50000 	lh	a1,0(t5)
bfc02770:	25ef0001 	addiu	t7,t7,1
bfc02774:	00450018 	mult	v0,a1
bfc02778:	25ad0002 	addiu	t5,t5,2
bfc0277c:	01d97021 	addu	t6,t6,t9
bfc02780:	00004012 	mflo	t0
bfc02784:	00082083 	sra	a0,t0,0x2
bfc02788:	00085143 	sra	t2,t0,0x5
bfc0278c:	314b007f 	andi	t3,t2,0x7f
bfc02790:	3083000f 	andi	v1,a0,0xf
bfc02794:	01630018 	mult	t3,v1
bfc02798:	00003012 	mflo	a2
bfc0279c:	0306c021 	addu	t8,t8,a2
bfc027a0:	85ca0000 	lh	t2,0(t6)
bfc027a4:	85a80000 	lh	t0,0(t5)
bfc027a8:	25ef0001 	addiu	t7,t7,1
bfc027ac:	01480018 	mult	t2,t0
bfc027b0:	01f0482b 	sltu	t1,t7,s0
bfc027b4:	25ad0002 	addiu	t5,t5,2
bfc027b8:	01d97021 	addu	t6,t6,t9
bfc027bc:	00002012 	mflo	a0
bfc027c0:	00045883 	sra	t3,a0,0x2
bfc027c4:	00041943 	sra	v1,a0,0x5
bfc027c8:	306c007f 	andi	t4,v1,0x7f
bfc027cc:	3166000f 	andi	a2,t3,0xf
bfc027d0:	01860018 	mult	t4,a2
bfc027d4:	00003812 	mflo	a3
bfc027d8:	11200038 	beqz	t1,bfc028bc <matrix_mul_matrix_bitextract+0x23c>
bfc027dc:	0307c021 	addu	t8,t8,a3
bfc027e0:	85c60000 	lh	a2,0(t6)
bfc027e4:	85ab0000 	lh	t3,0(t5)
bfc027e8:	01d96021 	addu	t4,t6,t9
bfc027ec:	00cb0018 	mult	a2,t3
bfc027f0:	85a90002 	lh	t1,2(t5)
bfc027f4:	85850000 	lh	a1,0(t4)
bfc027f8:	01997021 	addu	t6,t4,t9
bfc027fc:	85aa0004 	lh	t2,4(t5)
bfc02800:	85c40000 	lh	a0,0(t6)
bfc02804:	01d93821 	addu	a3,t6,t9
bfc02808:	85ab0006 	lh	t3,6(t5)
bfc0280c:	84e60000 	lh	a2,0(a3)
bfc02810:	00f97021 	addu	t6,a3,t9
bfc02814:	25ef0004 	addiu	t7,t7,4
bfc02818:	01f0602b 	sltu	t4,t7,s0
bfc0281c:	25ad0008 	addiu	t5,t5,8
bfc02820:	00001012 	mflo	v0
bfc02824:	00024083 	sra	t0,v0,0x2
bfc02828:	00021143 	sra	v0,v0,0x5
bfc0282c:	00a90018 	mult	a1,t1
bfc02830:	3042007f 	andi	v0,v0,0x7f
bfc02834:	3108000f 	andi	t0,t0,0xf
bfc02838:	00001812 	mflo	v1
bfc0283c:	00034883 	sra	t1,v1,0x2
bfc02840:	00032943 	sra	a1,v1,0x5
bfc02844:	008a0018 	mult	a0,t2
bfc02848:	30a5007f 	andi	a1,a1,0x7f
bfc0284c:	3129000f 	andi	t1,t1,0xf
bfc02850:	00005012 	mflo	t2
bfc02854:	000a3883 	sra	a3,t2,0x2
bfc02858:	000a2143 	sra	a0,t2,0x5
bfc0285c:	00cb0018 	mult	a2,t3
bfc02860:	30ea000f 	andi	t2,a3,0xf
bfc02864:	3084007f 	andi	a0,a0,0x7f
bfc02868:	00001812 	mflo	v1
bfc0286c:	00033083 	sra	a2,v1,0x2
bfc02870:	00031943 	sra	v1,v1,0x5
bfc02874:	00480018 	mult	v0,t0
bfc02878:	3063007f 	andi	v1,v1,0x7f
bfc0287c:	30c6000f 	andi	a2,a2,0xf
bfc02880:	00005812 	mflo	t3
bfc02884:	030b1021 	addu	v0,t8,t3
bfc02888:	00000000 	nop
bfc0288c:	00a90018 	mult	a1,t1
bfc02890:	00004012 	mflo	t0
bfc02894:	0048c021 	addu	t8,v0,t0
bfc02898:	00000000 	nop
bfc0289c:	008a0018 	mult	a0,t2
bfc028a0:	00003812 	mflo	a3
bfc028a4:	03075821 	addu	t3,t8,a3
bfc028a8:	00000000 	nop
bfc028ac:	00660018 	mult	v1,a2
bfc028b0:	00002812 	mflo	a1
bfc028b4:	1580ffca 	bnez	t4,bfc027e0 <matrix_mul_matrix_bitextract+0x160>
bfc028b8:	0165c021 	addu	t8,t3,a1
bfc028bc:	26730001 	addiu	s3,s3,1
bfc028c0:	0270682b 	sltu	t5,s3,s0
bfc028c4:	ae580000 	sw	t8,0(s2)
bfc028c8:	26310002 	addiu	s1,s1,2
bfc028cc:	15a0ff81 	bnez	t5,bfc026d4 <matrix_mul_matrix_bitextract+0x54>
bfc028d0:	26520004 	addiu	s2,s2,4
bfc028d4:	26d60001 	addiu	s6,s6,1
bfc028d8:	02d0782b 	sltu	t7,s6,s0
bfc028dc:	0299a021 	addu	s4,s4,t9
bfc028e0:	15e0ff79 	bnez	t7,bfc026c8 <matrix_mul_matrix_bitextract+0x48>
bfc028e4:	02b7a821 	addu	s5,s5,s7
bfc028e8:	8fbe0024 	lw	s8,36(sp)
bfc028ec:	8fb70020 	lw	s7,32(sp)
bfc028f0:	8fb6001c 	lw	s6,28(sp)
bfc028f4:	8fb50018 	lw	s5,24(sp)
bfc028f8:	8fb40014 	lw	s4,20(sp)
bfc028fc:	8fb30010 	lw	s3,16(sp)
bfc02900:	8fb2000c 	lw	s2,12(sp)
bfc02904:	8fb10008 	lw	s1,8(sp)
bfc02908:	8fb00004 	lw	s0,4(sp)
bfc0290c:	03e00008 	jr	ra
bfc02910:	27bd0028 	addiu	sp,sp,40
	...

bfc02920 <matrix_test>:
matrix_test():
bfc02920:	27bdffa0 	addiu	sp,sp,-96
bfc02924:	87a20070 	lh	v0,112(sp)
bfc02928:	afb40048 	sw	s4,72(sp)
bfc0292c:	afbf005c 	sw	ra,92(sp)
bfc02930:	afbe0058 	sw	s8,88(sp)
bfc02934:	afb70054 	sw	s7,84(sp)
bfc02938:	afb60050 	sw	s6,80(sp)
bfc0293c:	afb5004c 	sw	s5,76(sp)
bfc02940:	afb30044 	sw	s3,68(sp)
bfc02944:	afb20040 	sw	s2,64(sp)
bfc02948:	afb1003c 	sw	s1,60(sp)
bfc0294c:	afb00038 	sw	s0,56(sp)
bfc02950:	0080a021 	move	s4,a0
bfc02954:	afa50028 	sw	a1,40(sp)
bfc02958:	afa6002c 	sw	a2,44(sp)
bfc0295c:	afa70030 	sw	a3,48(sp)
bfc02960:	108005ad 	beqz	a0,bfc04018 <matrix_test+0x16f8>
bfc02964:	afa20034 	sw	v0,52(sp)
bfc02968:	304dffff 	andi	t5,v0,0xffff
bfc0296c:	00049040 	sll	s2,a0,0x1
bfc02970:	afa60014 	sw	a2,20(sp)
bfc02974:	00c07021 	move	t6,a2
bfc02978:	00007821 	move	t7,zero
bfc0297c:	95c90000 	lhu	t1,0(t6)
bfc02980:	240c0001 	li	t4,1
bfc02984:	01a95021 	addu	t2,t5,t1
bfc02988:	269fffff 	addiu	ra,s4,-1
bfc0298c:	0194f02b 	sltu	s8,t4,s4
bfc02990:	a5ca0000 	sh	t2,0(t6)
bfc02994:	33e30007 	andi	v1,ra,0x7
bfc02998:	13c00050 	beqz	s8,bfc02adc <matrix_test+0x1bc>
bfc0299c:	25cb0002 	addiu	t3,t6,2
bfc029a0:	10600032 	beqz	v1,bfc02a6c <matrix_test+0x14c>
bfc029a4:	00000000 	nop
bfc029a8:	106c0029 	beq	v1,t4,bfc02a50 <matrix_test+0x130>
bfc029ac:	24100002 	li	s0,2
bfc029b0:	10700022 	beq	v1,s0,bfc02a3c <matrix_test+0x11c>
bfc029b4:	24170003 	li	s7,3
bfc029b8:	1077001b 	beq	v1,s7,bfc02a28 <matrix_test+0x108>
bfc029bc:	24080004 	li	t0,4
bfc029c0:	10680014 	beq	v1,t0,bfc02a14 <matrix_test+0xf4>
bfc029c4:	24150005 	li	s5,5
bfc029c8:	1075000d 	beq	v1,s5,bfc02a00 <matrix_test+0xe0>
bfc029cc:	24160006 	li	s6,6
bfc029d0:	10760006 	beq	v1,s6,bfc029ec <matrix_test+0xcc>
bfc029d4:	00000000 	nop
bfc029d8:	95730000 	lhu	s3,0(t3)
bfc029dc:	240c0002 	li	t4,2
bfc029e0:	01b31821 	addu	v1,t5,s3
bfc029e4:	a5630000 	sh	v1,0(t3)
bfc029e8:	25cb0004 	addiu	t3,t6,4
bfc029ec:	95710000 	lhu	s1,0(t3)
bfc029f0:	258c0001 	addiu	t4,t4,1
bfc029f4:	01b1c821 	addu	t9,t5,s1
bfc029f8:	a5790000 	sh	t9,0(t3)
bfc029fc:	256b0002 	addiu	t3,t3,2
bfc02a00:	95620000 	lhu	v0,0(t3)
bfc02a04:	258c0001 	addiu	t4,t4,1
bfc02a08:	01a2c021 	addu	t8,t5,v0
bfc02a0c:	a5780000 	sh	t8,0(t3)
bfc02a10:	256b0002 	addiu	t3,t3,2
bfc02a14:	95690000 	lhu	t1,0(t3)
bfc02a18:	258c0001 	addiu	t4,t4,1
bfc02a1c:	01a9f021 	addu	s8,t5,t1
bfc02a20:	a57e0000 	sh	s8,0(t3)
bfc02a24:	256b0002 	addiu	t3,t3,2
bfc02a28:	95670000 	lhu	a3,0(t3)
bfc02a2c:	258c0001 	addiu	t4,t4,1
bfc02a30:	01a72821 	addu	a1,t5,a3
bfc02a34:	a5650000 	sh	a1,0(t3)
bfc02a38:	256b0002 	addiu	t3,t3,2
bfc02a3c:	956a0000 	lhu	t2,0(t3)
bfc02a40:	258c0001 	addiu	t4,t4,1
bfc02a44:	01aa3021 	addu	a2,t5,t2
bfc02a48:	a5660000 	sh	a2,0(t3)
bfc02a4c:	256b0002 	addiu	t3,t3,2
bfc02a50:	95700000 	lhu	s0,0(t3)
bfc02a54:	258c0001 	addiu	t4,t4,1
bfc02a58:	01b0f821 	addu	ra,t5,s0
bfc02a5c:	0194202b 	sltu	a0,t4,s4
bfc02a60:	a57f0000 	sh	ra,0(t3)
bfc02a64:	1080001d 	beqz	a0,bfc02adc <matrix_test+0x1bc>
bfc02a68:	256b0002 	addiu	t3,t3,2
bfc02a6c:	95790000 	lhu	t9,0(t3)
bfc02a70:	95780002 	lhu	t8,2(t3)
bfc02a74:	95770004 	lhu	s7,4(t3)
bfc02a78:	95760006 	lhu	s6,6(t3)
bfc02a7c:	95750008 	lhu	s5,8(t3)
bfc02a80:	9573000a 	lhu	s3,10(t3)
bfc02a84:	9571000c 	lhu	s1,12(t3)
bfc02a88:	9570000e 	lhu	s0,14(t3)
bfc02a8c:	258c0008 	addiu	t4,t4,8
bfc02a90:	01b91021 	addu	v0,t5,t9
bfc02a94:	01b81821 	addu	v1,t5,t8
bfc02a98:	01b72021 	addu	a0,t5,s7
bfc02a9c:	01b62821 	addu	a1,t5,s6
bfc02aa0:	01b53021 	addu	a2,t5,s5
bfc02aa4:	01b33821 	addu	a3,t5,s3
bfc02aa8:	01b14021 	addu	t0,t5,s1
bfc02aac:	01b04821 	addu	t1,t5,s0
bfc02ab0:	0194502b 	sltu	t2,t4,s4
bfc02ab4:	a5620000 	sh	v0,0(t3)
bfc02ab8:	a5630002 	sh	v1,2(t3)
bfc02abc:	a5640004 	sh	a0,4(t3)
bfc02ac0:	a5650006 	sh	a1,6(t3)
bfc02ac4:	a5660008 	sh	a2,8(t3)
bfc02ac8:	a567000a 	sh	a3,10(t3)
bfc02acc:	a568000c 	sh	t0,12(t3)
bfc02ad0:	a569000e 	sh	t1,14(t3)
bfc02ad4:	1540ffe5 	bnez	t2,bfc02a6c <matrix_test+0x14c>
bfc02ad8:	256b0010 	addiu	t3,t3,16
bfc02adc:	25ef0001 	addiu	t7,t7,1
bfc02ae0:	01f4582b 	sltu	t3,t7,s4
bfc02ae4:	1560ffa5 	bnez	t3,bfc0297c <matrix_test+0x5c>
bfc02ae8:	01d27021 	addu	t6,t6,s2
bfc02aec:	8fac0028 	lw	t4,40(sp)
bfc02af0:	00146880 	sll	t5,s4,0x2
bfc02af4:	8faf002c 	lw	t7,44(sp)
bfc02af8:	afad001c 	sw	t5,28(sp)
bfc02afc:	afac0020 	sw	t4,32(sp)
bfc02b00:	01807021 	move	t6,t4
bfc02b04:	00008021 	move	s0,zero
bfc02b08:	85f10000 	lh	s1,0(t7)
bfc02b0c:	8fa50034 	lw	a1,52(sp)
bfc02b10:	240d0001 	li	t5,1
bfc02b14:	00b10018 	mult	a1,s1
bfc02b18:	2695ffff 	addiu	s5,s4,-1
bfc02b1c:	01b4382b 	sltu	a3,t5,s4
bfc02b20:	32a30007 	andi	v1,s5,0x7
bfc02b24:	25eb0002 	addiu	t3,t7,2
bfc02b28:	25cc0004 	addiu	t4,t6,4
bfc02b2c:	00004012 	mflo	t0
bfc02b30:	10e00077 	beqz	a3,bfc02d10 <matrix_test+0x3f0>
bfc02b34:	adc80000 	sw	t0,0(t6)
bfc02b38:	10600047 	beqz	v1,bfc02c58 <matrix_test+0x338>
bfc02b3c:	00000000 	nop
bfc02b40:	106d003b 	beq	v1,t5,bfc02c30 <matrix_test+0x310>
bfc02b44:	241e0002 	li	s8,2
bfc02b48:	107e0031 	beq	v1,s8,bfc02c10 <matrix_test+0x2f0>
bfc02b4c:	24090003 	li	t1,3
bfc02b50:	10690027 	beq	v1,t1,bfc02bf0 <matrix_test+0x2d0>
bfc02b54:	24050004 	li	a1,4
bfc02b58:	1065001d 	beq	v1,a1,bfc02bd0 <matrix_test+0x2b0>
bfc02b5c:	24070005 	li	a3,5
bfc02b60:	10670013 	beq	v1,a3,bfc02bb0 <matrix_test+0x290>
bfc02b64:	24060006 	li	a2,6
bfc02b68:	10660009 	beq	v1,a2,bfc02b90 <matrix_test+0x270>
bfc02b6c:	00000000 	nop
bfc02b70:	85640000 	lh	a0,0(t3)
bfc02b74:	8fab0034 	lw	t3,52(sp)
bfc02b78:	240d0002 	li	t5,2
bfc02b7c:	01640018 	mult	t3,a0
bfc02b80:	25eb0004 	addiu	t3,t7,4
bfc02b84:	00005012 	mflo	t2
bfc02b88:	ad8a0000 	sw	t2,0(t4)
bfc02b8c:	25cc0008 	addiu	t4,t6,8
bfc02b90:	85770000 	lh	s7,0(t3)
bfc02b94:	8fa30034 	lw	v1,52(sp)
bfc02b98:	25ad0001 	addiu	t5,t5,1
bfc02b9c:	00770018 	mult	v1,s7
bfc02ba0:	256b0002 	addiu	t3,t3,2
bfc02ba4:	0000f812 	mflo	ra
bfc02ba8:	ad9f0000 	sw	ra,0(t4)
bfc02bac:	258c0004 	addiu	t4,t4,4
bfc02bb0:	85750000 	lh	s5,0(t3)
bfc02bb4:	8fb60034 	lw	s6,52(sp)
bfc02bb8:	25ad0001 	addiu	t5,t5,1
bfc02bbc:	02d50018 	mult	s6,s5
bfc02bc0:	256b0002 	addiu	t3,t3,2
bfc02bc4:	00004012 	mflo	t0
bfc02bc8:	ad880000 	sw	t0,0(t4)
bfc02bcc:	258c0004 	addiu	t4,t4,4
bfc02bd0:	85790000 	lh	t9,0(t3)
bfc02bd4:	8fb10034 	lw	s1,52(sp)
bfc02bd8:	25ad0001 	addiu	t5,t5,1
bfc02bdc:	02390018 	mult	s1,t9
bfc02be0:	256b0002 	addiu	t3,t3,2
bfc02be4:	00009812 	mflo	s3
bfc02be8:	ad930000 	sw	s3,0(t4)
bfc02bec:	258c0004 	addiu	t4,t4,4
bfc02bf0:	85620000 	lh	v0,0(t3)
bfc02bf4:	8fbe0034 	lw	s8,52(sp)
bfc02bf8:	25ad0001 	addiu	t5,t5,1
bfc02bfc:	03c20018 	mult	s8,v0
bfc02c00:	256b0002 	addiu	t3,t3,2
bfc02c04:	0000c012 	mflo	t8
bfc02c08:	ad980000 	sw	t8,0(t4)
bfc02c0c:	258c0004 	addiu	t4,t4,4
bfc02c10:	85650000 	lh	a1,0(t3)
bfc02c14:	8fa70034 	lw	a3,52(sp)
bfc02c18:	25ad0001 	addiu	t5,t5,1
bfc02c1c:	00e50018 	mult	a3,a1
bfc02c20:	256b0002 	addiu	t3,t3,2
bfc02c24:	00004812 	mflo	t1
bfc02c28:	ad890000 	sw	t1,0(t4)
bfc02c2c:	258c0004 	addiu	t4,t4,4
bfc02c30:	85640000 	lh	a0,0(t3)
bfc02c34:	8fbf0034 	lw	ra,52(sp)
bfc02c38:	25ad0001 	addiu	t5,t5,1
bfc02c3c:	03e40018 	mult	ra,a0
bfc02c40:	01b4302b 	sltu	a2,t5,s4
bfc02c44:	256b0002 	addiu	t3,t3,2
bfc02c48:	00005012 	mflo	t2
bfc02c4c:	ad8a0000 	sw	t2,0(t4)
bfc02c50:	10c0002f 	beqz	a2,bfc02d10 <matrix_test+0x3f0>
bfc02c54:	258c0004 	addiu	t4,t4,4
bfc02c58:	85690000 	lh	t1,0(t3)
bfc02c5c:	8fb30034 	lw	s3,52(sp)
bfc02c60:	8fb10034 	lw	s1,52(sp)
bfc02c64:	02690018 	mult	s3,t1
bfc02c68:	856a0002 	lh	t2,2(t3)
bfc02c6c:	857f0004 	lh	ra,4(t3)
bfc02c70:	85790006 	lh	t9,6(t3)
bfc02c74:	85780008 	lh	t8,8(t3)
bfc02c78:	8577000a 	lh	s7,10(t3)
bfc02c7c:	8576000c 	lh	s6,12(t3)
bfc02c80:	8575000e 	lh	s5,14(t3)
bfc02c84:	25ad0008 	addiu	t5,t5,8
bfc02c88:	01b4982b 	sltu	s3,t5,s4
bfc02c8c:	256b0010 	addiu	t3,t3,16
bfc02c90:	00001012 	mflo	v0
bfc02c94:	ad820000 	sw	v0,0(t4)
bfc02c98:	00000000 	nop
bfc02c9c:	022a0018 	mult	s1,t2
bfc02ca0:	0000f012 	mflo	s8
bfc02ca4:	ad9e0004 	sw	s8,4(t4)
bfc02ca8:	00000000 	nop
bfc02cac:	023f0018 	mult	s1,ra
bfc02cb0:	00002012 	mflo	a0
bfc02cb4:	ad840008 	sw	a0,8(t4)
bfc02cb8:	00000000 	nop
bfc02cbc:	02390018 	mult	s1,t9
bfc02cc0:	00001812 	mflo	v1
bfc02cc4:	ad83000c 	sw	v1,12(t4)
bfc02cc8:	00000000 	nop
bfc02ccc:	02380018 	mult	s1,t8
bfc02cd0:	00003012 	mflo	a2
bfc02cd4:	ad860010 	sw	a2,16(t4)
bfc02cd8:	00000000 	nop
bfc02cdc:	02370018 	mult	s1,s7
bfc02ce0:	00002812 	mflo	a1
bfc02ce4:	ad850014 	sw	a1,20(t4)
bfc02ce8:	00000000 	nop
bfc02cec:	02360018 	mult	s1,s6
bfc02cf0:	00004012 	mflo	t0
bfc02cf4:	ad880018 	sw	t0,24(t4)
bfc02cf8:	00000000 	nop
bfc02cfc:	02350018 	mult	s1,s5
bfc02d00:	00003812 	mflo	a3
bfc02d04:	ad87001c 	sw	a3,28(t4)
bfc02d08:	1660ffd3 	bnez	s3,bfc02c58 <matrix_test+0x338>
bfc02d0c:	258c0020 	addiu	t4,t4,32
bfc02d10:	26100001 	addiu	s0,s0,1
bfc02d14:	8fac001c 	lw	t4,28(sp)
bfc02d18:	0214582b 	sltu	t3,s0,s4
bfc02d1c:	01cc7021 	addu	t6,t6,t4
bfc02d20:	1560ff79 	bnez	t3,bfc02b08 <matrix_test+0x1e8>
bfc02d24:	01f27821 	addu	t7,t7,s2
bfc02d28:	8faf0034 	lw	t7,52(sp)
bfc02d2c:	240ef000 	li	t6,-4096
bfc02d30:	8fab0028 	lw	t3,40(sp)
bfc02d34:	01eef025 	or	s8,t7,t6
bfc02d38:	00003021 	move	a2,zero
bfc02d3c:	00001821 	move	v1,zero
bfc02d40:	00002021 	move	a0,zero
bfc02d44:	00006021 	move	t4,zero
bfc02d48:	2687ffff 	addiu	a3,s4,-1
bfc02d4c:	30ea0003 	andi	t2,a3,0x3
bfc02d50:	01604021 	move	t0,t3
bfc02d54:	1140003f 	beqz	t2,bfc02e54 <matrix_test+0x534>
bfc02d58:	00004821 	move	t1,zero
bfc02d5c:	8d670000 	lw	a3,0(t3)
bfc02d60:	3093ffff 	andi	s3,a0,0xffff
bfc02d64:	0067c82a 	slt	t9,v1,a3
bfc02d68:	00c73021 	addu	a2,a2,a3
bfc02d6c:	0279b821 	addu	s7,s3,t9
bfc02d70:	2676000a 	addiu	s6,s3,10
bfc02d74:	0016ac00 	sll	s5,s6,0x10
bfc02d78:	0017fc00 	sll	ra,s7,0x10
bfc02d7c:	03c6282a 	slt	a1,s8,a2
bfc02d80:	00151403 	sra	v0,s5,0x10
bfc02d84:	10a00002 	beqz	a1,bfc02d90 <matrix_test+0x470>
bfc02d88:	001f2403 	sra	a0,ra,0x10
bfc02d8c:	00402021 	move	a0,v0
bfc02d90:	10a00002 	beqz	a1,bfc02d9c <matrix_test+0x47c>
bfc02d94:	24090001 	li	t1,1
bfc02d98:	00003021 	move	a2,zero
bfc02d9c:	0134882b 	sltu	s1,t1,s4
bfc02da0:	1220007b 	beqz	s1,bfc02f90 <matrix_test+0x670>
bfc02da4:	25680004 	addiu	t0,t3,4
bfc02da8:	1149002a 	beq	t2,t1,bfc02e54 <matrix_test+0x534>
bfc02dac:	00e01821 	move	v1,a3
bfc02db0:	24180002 	li	t8,2
bfc02db4:	11580014 	beq	t2,t8,bfc02e08 <matrix_test+0x4e8>
bfc02db8:	308fffff 	andi	t7,a0,0xffff
bfc02dbc:	8d050000 	lw	a1,0(t0)
bfc02dc0:	00000000 	nop
bfc02dc4:	00c55021 	addu	t2,a2,a1
bfc02dc8:	00e5302a 	slt	a2,a3,a1
bfc02dcc:	01e68021 	addu	s0,t7,a2
bfc02dd0:	25e7000a 	addiu	a3,t7,10
bfc02dd4:	00071400 	sll	v0,a3,0x10
bfc02dd8:	00107400 	sll	t6,s0,0x10
bfc02ddc:	03ca302a 	slt	a2,s8,t2
bfc02de0:	00021403 	sra	v0,v0,0x10
bfc02de4:	10c00002 	beqz	a2,bfc02df0 <matrix_test+0x4d0>
bfc02de8:	000e2403 	sra	a0,t6,0x10
bfc02dec:	00402021 	move	a0,v0
bfc02df0:	14c00002 	bnez	a2,bfc02dfc <matrix_test+0x4dc>
bfc02df4:	00003021 	move	a2,zero
bfc02df8:	01403021 	move	a2,t2
bfc02dfc:	25290001 	addiu	t1,t1,1
bfc02e00:	25080004 	addiu	t0,t0,4
bfc02e04:	00a01821 	move	v1,a1
bfc02e08:	8d050000 	lw	a1,0(t0)
bfc02e0c:	3097ffff 	andi	s7,a0,0xffff
bfc02e10:	0065182a 	slt	v1,v1,a1
bfc02e14:	00c53821 	addu	a3,a2,a1
bfc02e18:	02e36821 	addu	t5,s7,v1
bfc02e1c:	26ff000a 	addiu	ra,s7,10
bfc02e20:	001f2400 	sll	a0,ra,0x10
bfc02e24:	000d5400 	sll	t2,t5,0x10
bfc02e28:	03c7302a 	slt	a2,s8,a3
bfc02e2c:	00041403 	sra	v0,a0,0x10
bfc02e30:	10c00002 	beqz	a2,bfc02e3c <matrix_test+0x51c>
bfc02e34:	000a2403 	sra	a0,t2,0x10
bfc02e38:	00402021 	move	a0,v0
bfc02e3c:	14c00002 	bnez	a2,bfc02e48 <matrix_test+0x528>
bfc02e40:	00003021 	move	a2,zero
bfc02e44:	00e03021 	move	a2,a3
bfc02e48:	25290001 	addiu	t1,t1,1
bfc02e4c:	25080004 	addiu	t0,t0,4
bfc02e50:	00a01821 	move	v1,a1
bfc02e54:	8d070000 	lw	a3,0(t0)
bfc02e58:	3082ffff 	andi	v0,a0,0xffff
bfc02e5c:	0067502a 	slt	t2,v1,a3
bfc02e60:	004a1821 	addu	v1,v0,t2
bfc02e64:	245f000a 	addiu	ra,v0,10
bfc02e68:	00c73021 	addu	a2,a2,a3
bfc02e6c:	001fcc00 	sll	t9,ra,0x10
bfc02e70:	00032400 	sll	a0,v1,0x10
bfc02e74:	03c6282a 	slt	a1,s8,a2
bfc02e78:	00191403 	sra	v0,t9,0x10
bfc02e7c:	10a00002 	beqz	a1,bfc02e88 <matrix_test+0x568>
bfc02e80:	00042403 	sra	a0,a0,0x10
bfc02e84:	00402021 	move	a0,v0
bfc02e88:	10a00002 	beqz	a1,bfc02e94 <matrix_test+0x574>
bfc02e8c:	00000000 	nop
bfc02e90:	00003021 	move	a2,zero
bfc02e94:	25290001 	addiu	t1,t1,1
bfc02e98:	0134982b 	sltu	s3,t1,s4
bfc02e9c:	1260003c 	beqz	s3,bfc02f90 <matrix_test+0x670>
bfc02ea0:	250a0004 	addiu	t2,t0,4
bfc02ea4:	8d050004 	lw	a1,4(t0)
bfc02ea8:	3098ffff 	andi	t8,a0,0xffff
bfc02eac:	00c54021 	addu	t0,a2,a1
bfc02eb0:	00e5302a 	slt	a2,a3,a1
bfc02eb4:	03066821 	addu	t5,t8,a2
bfc02eb8:	2717000a 	addiu	s7,t8,10
bfc02ebc:	0017b400 	sll	s6,s7,0x10
bfc02ec0:	000d8400 	sll	s0,t5,0x10
bfc02ec4:	03c8302a 	slt	a2,s8,t0
bfc02ec8:	00162403 	sra	a0,s6,0x10
bfc02ecc:	10c00002 	beqz	a2,bfc02ed8 <matrix_test+0x5b8>
bfc02ed0:	00101403 	sra	v0,s0,0x10
bfc02ed4:	00801021 	move	v0,a0
bfc02ed8:	14c00002 	bnez	a2,bfc02ee4 <matrix_test+0x5c4>
bfc02edc:	00003821 	move	a3,zero
bfc02ee0:	01003821 	move	a3,t0
bfc02ee4:	8d460004 	lw	a2,4(t2)
bfc02ee8:	3059ffff 	andi	t9,v0,0xffff
bfc02eec:	00a6882a 	slt	s1,a1,a2
bfc02ef0:	00e63821 	addu	a3,a3,a2
bfc02ef4:	0331a821 	addu	s5,t9,s1
bfc02ef8:	2733000a 	addiu	s3,t9,10
bfc02efc:	0013b400 	sll	s6,s3,0x10
bfc02f00:	00154400 	sll	t0,s5,0x10
bfc02f04:	03c7282a 	slt	a1,s8,a3
bfc02f08:	00162403 	sra	a0,s6,0x10
bfc02f0c:	10a00002 	beqz	a1,bfc02f18 <matrix_test+0x5f8>
bfc02f10:	00081403 	sra	v0,t0,0x10
bfc02f14:	00801021 	move	v0,a0
bfc02f18:	10a00002 	beqz	a1,bfc02f24 <matrix_test+0x604>
bfc02f1c:	00000000 	nop
bfc02f20:	00003821 	move	a3,zero
bfc02f24:	8d450008 	lw	a1,8(t2)
bfc02f28:	304fffff 	andi	t7,v0,0xffff
bfc02f2c:	00c5682a 	slt	t5,a2,a1
bfc02f30:	25e2000a 	addiu	v0,t7,10
bfc02f34:	00e53821 	addu	a3,a3,a1
bfc02f38:	01ed7021 	addu	t6,t7,t5
bfc02f3c:	00028400 	sll	s0,v0,0x10
bfc02f40:	000ec400 	sll	t8,t6,0x10
bfc02f44:	03c7302a 	slt	a2,s8,a3
bfc02f48:	00101403 	sra	v0,s0,0x10
bfc02f4c:	10c00002 	beqz	a2,bfc02f58 <matrix_test+0x638>
bfc02f50:	00182403 	sra	a0,t8,0x10
bfc02f54:	00402021 	move	a0,v0
bfc02f58:	14c00009 	bnez	a2,bfc02f80 <matrix_test+0x660>
bfc02f5c:	00000000 	nop
bfc02f60:	00e03021 	move	a2,a3
bfc02f64:	25290003 	addiu	t1,t1,3
bfc02f68:	2548000c 	addiu	t0,t2,12
bfc02f6c:	0bf00b95 	j	bfc02e54 <matrix_test+0x534>
bfc02f70:	00a01821 	move	v1,a1
	...
bfc02f80:	0bf00bd9 	j	bfc02f64 <matrix_test+0x644>
bfc02f84:	00003021 	move	a2,zero
	...
bfc02f90:	258c0001 	addiu	t4,t4,1
bfc02f94:	8fa8001c 	lw	t0,28(sp)
bfc02f98:	0194482b 	sltu	t1,t4,s4
bfc02f9c:	11200003 	beqz	t1,bfc02fac <matrix_test+0x68c>
bfc02fa0:	01685821 	addu	t3,t3,t0
bfc02fa4:	0bf00b52 	j	bfc02d48 <matrix_test+0x428>
bfc02fa8:	00e01821 	move	v1,a3
bfc02fac:	0ff01800 	jal	bfc06000 <crc16>
bfc02fb0:	00002821 	move	a1,zero
bfc02fb4:	8fb60028 	lw	s6,40(sp)
bfc02fb8:	8fb5002c 	lw	s5,44(sp)
bfc02fbc:	0040f821 	move	ra,v0
bfc02fc0:	0000b821 	move	s7,zero
bfc02fc4:	8faf0030 	lw	t7,48(sp)
bfc02fc8:	86a50000 	lh	a1,0(s5)
bfc02fcc:	85ee0000 	lh	t6,0(t7)
bfc02fd0:	24130001 	li	s3,1
bfc02fd4:	01c50018 	mult	t6,a1
bfc02fd8:	8fac0030 	lw	t4,48(sp)
bfc02fdc:	2691ffff 	addiu	s1,s4,-1
bfc02fe0:	0274582b 	sltu	t3,s3,s4
bfc02fe4:	32230007 	andi	v1,s1,0x7
bfc02fe8:	25980002 	addiu	t8,t4,2
bfc02fec:	0000c812 	mflo	t9
bfc02ff0:	1160007f 	beqz	t3,bfc031f0 <matrix_test+0x8d0>
bfc02ff4:	26b10002 	addiu	s1,s5,2
bfc02ff8:	10600048 	beqz	v1,bfc0311c <matrix_test+0x7fc>
bfc02ffc:	00000000 	nop
bfc03000:	1073003c 	beq	v1,s3,bfc030f4 <matrix_test+0x7d4>
bfc03004:	240b0002 	li	t3,2
bfc03008:	106b0032 	beq	v1,t3,bfc030d4 <matrix_test+0x7b4>
bfc0300c:	24090003 	li	t1,3
bfc03010:	10690028 	beq	v1,t1,bfc030b4 <matrix_test+0x794>
bfc03014:	24050004 	li	a1,4
bfc03018:	1065001e 	beq	v1,a1,bfc03094 <matrix_test+0x774>
bfc0301c:	240c0005 	li	t4,5
bfc03020:	106c0014 	beq	v1,t4,bfc03074 <matrix_test+0x754>
bfc03024:	24070006 	li	a3,6
bfc03028:	1067000a 	beq	v1,a3,bfc03054 <matrix_test+0x734>
bfc0302c:	00000000 	nop
bfc03030:	8faa0030 	lw	t2,48(sp)
bfc03034:	86380000 	lh	t8,0(s1)
bfc03038:	85480002 	lh	t0,2(t2)
bfc0303c:	24130002 	li	s3,2
bfc03040:	01180018 	mult	t0,t8
bfc03044:	26b10004 	addiu	s1,s5,4
bfc03048:	25580004 	addiu	t8,t2,4
bfc0304c:	00003012 	mflo	a2
bfc03050:	0326c821 	addu	t9,t9,a2
bfc03054:	870d0000 	lh	t5,0(t8)
bfc03058:	86240000 	lh	a0,0(s1)
bfc0305c:	26730001 	addiu	s3,s3,1
bfc03060:	01a40018 	mult	t5,a0
bfc03064:	26310002 	addiu	s1,s1,2
bfc03068:	27180002 	addiu	t8,t8,2
bfc0306c:	00007812 	mflo	t7
bfc03070:	032fc821 	addu	t9,t9,t7
bfc03074:	87020000 	lh	v0,0(t8)
bfc03078:	862e0000 	lh	t6,0(s1)
bfc0307c:	26730001 	addiu	s3,s3,1
bfc03080:	004e0018 	mult	v0,t6
bfc03084:	26310002 	addiu	s1,s1,2
bfc03088:	27180002 	addiu	t8,t8,2
bfc0308c:	00001812 	mflo	v1
bfc03090:	0323c821 	addu	t9,t9,v1
bfc03094:	870b0000 	lh	t3,0(t8)
bfc03098:	86290000 	lh	t1,0(s1)
bfc0309c:	26730001 	addiu	s3,s3,1
bfc030a0:	01690018 	mult	t3,t1
bfc030a4:	26310002 	addiu	s1,s1,2
bfc030a8:	27180002 	addiu	t8,t8,2
bfc030ac:	00008012 	mflo	s0
bfc030b0:	0330c821 	addu	t9,t9,s0
bfc030b4:	870c0000 	lh	t4,0(t8)
bfc030b8:	86270000 	lh	a3,0(s1)
bfc030bc:	26730001 	addiu	s3,s3,1
bfc030c0:	01870018 	mult	t4,a3
bfc030c4:	26310002 	addiu	s1,s1,2
bfc030c8:	27180002 	addiu	t8,t8,2
bfc030cc:	00002812 	mflo	a1
bfc030d0:	0325c821 	addu	t9,t9,a1
bfc030d4:	870a0000 	lh	t2,0(t8)
bfc030d8:	86280000 	lh	t0,0(s1)
bfc030dc:	26730001 	addiu	s3,s3,1
bfc030e0:	01480018 	mult	t2,t0
bfc030e4:	26310002 	addiu	s1,s1,2
bfc030e8:	27180002 	addiu	t8,t8,2
bfc030ec:	00003012 	mflo	a2
bfc030f0:	0326c821 	addu	t9,t9,a2
bfc030f4:	87040000 	lh	a0,0(t8)
bfc030f8:	86230000 	lh	v1,0(s1)
bfc030fc:	26730001 	addiu	s3,s3,1
bfc03100:	00830018 	mult	a0,v1
bfc03104:	0274782b 	sltu	t7,s3,s4
bfc03108:	26310002 	addiu	s1,s1,2
bfc0310c:	27180002 	addiu	t8,t8,2
bfc03110:	00006812 	mflo	t5
bfc03114:	11e00036 	beqz	t7,bfc031f0 <matrix_test+0x8d0>
bfc03118:	032dc821 	addu	t9,t9,t5
bfc0311c:	87080000 	lh	t0,0(t8)
bfc03120:	86230000 	lh	v1,0(s1)
bfc03124:	87100002 	lh	s0,2(t8)
bfc03128:	01030018 	mult	t0,v1
bfc0312c:	862a0002 	lh	t2,2(s1)
bfc03130:	87040004 	lh	a0,4(t8)
bfc03134:	862b0004 	lh	t3,4(s1)
bfc03138:	87050006 	lh	a1,6(t8)
bfc0313c:	862c0006 	lh	t4,6(s1)
bfc03140:	87060008 	lh	a2,8(t8)
bfc03144:	862d0008 	lh	t5,8(s1)
bfc03148:	8707000a 	lh	a3,10(t8)
bfc0314c:	862e000a 	lh	t6,10(s1)
bfc03150:	8708000c 	lh	t0,12(t8)
bfc03154:	862f000c 	lh	t7,12(s1)
bfc03158:	8703000e 	lh	v1,14(t8)
bfc0315c:	00001012 	mflo	v0
bfc03160:	26730008 	addiu	s3,s3,8
bfc03164:	03221021 	addu	v0,t9,v0
bfc03168:	27180010 	addiu	t8,t8,16
bfc0316c:	020a0018 	mult	s0,t2
bfc03170:	8630000e 	lh	s0,14(s1)
bfc03174:	0274502b 	sltu	t2,s3,s4
bfc03178:	26310010 	addiu	s1,s1,16
bfc0317c:	00004812 	mflo	t1
bfc03180:	0049c821 	addu	t9,v0,t1
bfc03184:	00000000 	nop
bfc03188:	008b0018 	mult	a0,t3
bfc0318c:	00002012 	mflo	a0
	...
bfc03198:	00ac0018 	mult	a1,t4
bfc0319c:	03246021 	addu	t4,t9,a0
bfc031a0:	00002812 	mflo	a1
bfc031a4:	01851021 	addu	v0,t4,a1
bfc031a8:	00000000 	nop
bfc031ac:	00cd0018 	mult	a2,t5
bfc031b0:	00005812 	mflo	t3
bfc031b4:	004bc821 	addu	t9,v0,t3
bfc031b8:	00000000 	nop
bfc031bc:	00ee0018 	mult	a3,t6
bfc031c0:	00004812 	mflo	t1
bfc031c4:	03293021 	addu	a2,t9,t1
bfc031c8:	00000000 	nop
bfc031cc:	010f0018 	mult	t0,t7
bfc031d0:	00002012 	mflo	a0
	...
bfc031dc:	00700018 	mult	v1,s0
bfc031e0:	00c48021 	addu	s0,a2,a0
bfc031e4:	00006812 	mflo	t5
bfc031e8:	1540ffcc 	bnez	t2,bfc0311c <matrix_test+0x7fc>
bfc031ec:	020dc821 	addu	t9,s0,t5
bfc031f0:	26f70001 	addiu	s7,s7,1
bfc031f4:	02f4c02b 	sltu	t8,s7,s4
bfc031f8:	aed90000 	sw	t9,0(s6)
bfc031fc:	02b2a821 	addu	s5,s5,s2
bfc03200:	1700ff70 	bnez	t8,bfc02fc4 <matrix_test+0x6a4>
bfc03204:	26d60004 	addiu	s6,s6,4
bfc03208:	8fab0028 	lw	t3,40(sp)
bfc0320c:	00003021 	move	a2,zero
bfc03210:	00001821 	move	v1,zero
bfc03214:	00002021 	move	a0,zero
bfc03218:	00006021 	move	t4,zero
bfc0321c:	2687ffff 	addiu	a3,s4,-1
bfc03220:	30ea0003 	andi	t2,a3,0x3
bfc03224:	01604021 	move	t0,t3
bfc03228:	1140003f 	beqz	t2,bfc03328 <matrix_test+0xa08>
bfc0322c:	00004821 	move	t1,zero
bfc03230:	8d670000 	lw	a3,0(t3)
bfc03234:	3099ffff 	andi	t9,a0,0xffff
bfc03238:	0067c02a 	slt	t8,v1,a3
bfc0323c:	00c73021 	addu	a2,a2,a3
bfc03240:	0338a821 	addu	s5,t9,t8
bfc03244:	2733000a 	addiu	s3,t9,10
bfc03248:	0013b400 	sll	s6,s3,0x10
bfc0324c:	0015bc00 	sll	s7,s5,0x10
bfc03250:	03c6282a 	slt	a1,s8,a2
bfc03254:	00161403 	sra	v0,s6,0x10
bfc03258:	10a00002 	beqz	a1,bfc03264 <matrix_test+0x944>
bfc0325c:	00172403 	sra	a0,s7,0x10
bfc03260:	00402021 	move	a0,v0
bfc03264:	10a00002 	beqz	a1,bfc03270 <matrix_test+0x950>
bfc03268:	24090001 	li	t1,1
bfc0326c:	00003021 	move	a2,zero
bfc03270:	0134782b 	sltu	t7,t1,s4
bfc03274:	11e0007a 	beqz	t7,bfc03460 <matrix_test+0xb40>
bfc03278:	25680004 	addiu	t0,t3,4
bfc0327c:	1149002a 	beq	t2,t1,bfc03328 <matrix_test+0xa08>
bfc03280:	00e01821 	move	v1,a3
bfc03284:	240d0002 	li	t5,2
bfc03288:	114d0014 	beq	t2,t5,bfc032dc <matrix_test+0x9bc>
bfc0328c:	308effff 	andi	t6,a0,0xffff
bfc03290:	8d050000 	lw	a1,0(t0)
bfc03294:	00000000 	nop
bfc03298:	00c55021 	addu	t2,a2,a1
bfc0329c:	00e5302a 	slt	a2,a3,a1
bfc032a0:	01c61821 	addu	v1,t6,a2
bfc032a4:	25c2000a 	addiu	v0,t6,10
bfc032a8:	00022400 	sll	a0,v0,0x10
bfc032ac:	00033c00 	sll	a3,v1,0x10
bfc032b0:	03ca302a 	slt	a2,s8,t2
bfc032b4:	00041403 	sra	v0,a0,0x10
bfc032b8:	10c00002 	beqz	a2,bfc032c4 <matrix_test+0x9a4>
bfc032bc:	00072403 	sra	a0,a3,0x10
bfc032c0:	00402021 	move	a0,v0
bfc032c4:	14c00002 	bnez	a2,bfc032d0 <matrix_test+0x9b0>
bfc032c8:	00003021 	move	a2,zero
bfc032cc:	01403021 	move	a2,t2
bfc032d0:	25290001 	addiu	t1,t1,1
bfc032d4:	25080004 	addiu	t0,t0,4
bfc032d8:	00a01821 	move	v1,a1
bfc032dc:	8d050000 	lw	a1,0(t0)
bfc032e0:	3095ffff 	andi	s5,a0,0xffff
bfc032e4:	0065b02a 	slt	s6,v1,a1
bfc032e8:	00c53821 	addu	a3,a2,a1
bfc032ec:	02b68021 	addu	s0,s5,s6
bfc032f0:	26b7000a 	addiu	s7,s5,10
bfc032f4:	00178c00 	sll	s1,s7,0x10
bfc032f8:	00105400 	sll	t2,s0,0x10
bfc032fc:	03c7302a 	slt	a2,s8,a3
bfc03300:	00111403 	sra	v0,s1,0x10
bfc03304:	10c00002 	beqz	a2,bfc03310 <matrix_test+0x9f0>
bfc03308:	000a2403 	sra	a0,t2,0x10
bfc0330c:	00402021 	move	a0,v0
bfc03310:	14c00002 	bnez	a2,bfc0331c <matrix_test+0x9fc>
bfc03314:	00003021 	move	a2,zero
bfc03318:	00e03021 	move	a2,a3
bfc0331c:	25290001 	addiu	t1,t1,1
bfc03320:	25080004 	addiu	t0,t0,4
bfc03324:	00a01821 	move	v1,a1
bfc03328:	8d070000 	lw	a3,0(t0)
bfc0332c:	3085ffff 	andi	a1,a0,0xffff
bfc03330:	0067102a 	slt	v0,v1,a3
bfc03334:	00a26821 	addu	t5,a1,v0
bfc03338:	24a4000a 	addiu	a0,a1,10
bfc0333c:	00c73021 	addu	a2,a2,a3
bfc03340:	0004cc00 	sll	t9,a0,0x10
bfc03344:	000d7400 	sll	t6,t5,0x10
bfc03348:	03c6282a 	slt	a1,s8,a2
bfc0334c:	00191403 	sra	v0,t9,0x10
bfc03350:	10a00002 	beqz	a1,bfc0335c <matrix_test+0xa3c>
bfc03354:	000e2403 	sra	a0,t6,0x10
bfc03358:	00402021 	move	a0,v0
bfc0335c:	10a00002 	beqz	a1,bfc03368 <matrix_test+0xa48>
bfc03360:	00000000 	nop
bfc03364:	00003021 	move	a2,zero
bfc03368:	25290001 	addiu	t1,t1,1
bfc0336c:	0134802b 	sltu	s0,t1,s4
bfc03370:	1200003b 	beqz	s0,bfc03460 <matrix_test+0xb40>
bfc03374:	250a0004 	addiu	t2,t0,4
bfc03378:	8d050004 	lw	a1,4(t0)
bfc0337c:	3091ffff 	andi	s1,a0,0xffff
bfc03380:	00e5782a 	slt	t7,a3,a1
bfc03384:	00c54021 	addu	t0,a2,a1
bfc03388:	022fb021 	addu	s6,s1,t7
bfc0338c:	2633000a 	addiu	s3,s1,10
bfc03390:	0013bc00 	sll	s7,s3,0x10
bfc03394:	0016ac00 	sll	s5,s6,0x10
bfc03398:	03c8302a 	slt	a2,s8,t0
bfc0339c:	00172403 	sra	a0,s7,0x10
bfc033a0:	10c00002 	beqz	a2,bfc033ac <matrix_test+0xa8c>
bfc033a4:	00151403 	sra	v0,s5,0x10
bfc033a8:	00801021 	move	v0,a0
bfc033ac:	14c00002 	bnez	a2,bfc033b8 <matrix_test+0xa98>
bfc033b0:	00003821 	move	a3,zero
bfc033b4:	01003821 	move	a3,t0
bfc033b8:	8d460004 	lw	a2,4(t2)
bfc033bc:	304fffff 	andi	t7,v0,0xffff
bfc033c0:	00a6682a 	slt	t5,a1,a2
bfc033c4:	00e63821 	addu	a3,a3,a2
bfc033c8:	01ed9821 	addu	s3,t7,t5
bfc033cc:	25f8000a 	addiu	t8,t7,10
bfc033d0:	0018cc00 	sll	t9,t8,0x10
bfc033d4:	00134400 	sll	t0,s3,0x10
bfc033d8:	03c7282a 	slt	a1,s8,a3
bfc033dc:	00192403 	sra	a0,t9,0x10
bfc033e0:	10a00002 	beqz	a1,bfc033ec <matrix_test+0xacc>
bfc033e4:	00081403 	sra	v0,t0,0x10
bfc033e8:	00801021 	move	v0,a0
bfc033ec:	10a00002 	beqz	a1,bfc033f8 <matrix_test+0xad8>
bfc033f0:	00000000 	nop
bfc033f4:	00003821 	move	a3,zero
bfc033f8:	8d450008 	lw	a1,8(t2)
bfc033fc:	3050ffff 	andi	s0,v0,0xffff
bfc03400:	00c5882a 	slt	s1,a2,a1
bfc03404:	00e53821 	addu	a3,a3,a1
bfc03408:	02111821 	addu	v1,s0,s1
bfc0340c:	260e000a 	addiu	t6,s0,10
bfc03410:	000e1400 	sll	v0,t6,0x10
bfc03414:	00032400 	sll	a0,v1,0x10
bfc03418:	03c7302a 	slt	a2,s8,a3
bfc0341c:	00021403 	sra	v0,v0,0x10
bfc03420:	10c00002 	beqz	a2,bfc0342c <matrix_test+0xb0c>
bfc03424:	00042403 	sra	a0,a0,0x10
bfc03428:	00402021 	move	a0,v0
bfc0342c:	14c00008 	bnez	a2,bfc03450 <matrix_test+0xb30>
bfc03430:	00000000 	nop
bfc03434:	00e03021 	move	a2,a3
bfc03438:	25290003 	addiu	t1,t1,3
bfc0343c:	2548000c 	addiu	t0,t2,12
bfc03440:	0bf00cca 	j	bfc03328 <matrix_test+0xa08>
bfc03444:	00a01821 	move	v1,a1
	...
bfc03450:	0bf00d0e 	j	bfc03438 <matrix_test+0xb18>
bfc03454:	00003021 	move	a2,zero
	...
bfc03460:	258c0001 	addiu	t4,t4,1
bfc03464:	8faa001c 	lw	t2,28(sp)
bfc03468:	0194482b 	sltu	t1,t4,s4
bfc0346c:	11200003 	beqz	t1,bfc0347c <matrix_test+0xb5c>
bfc03470:	016a5821 	addu	t3,t3,t2
bfc03474:	0bf00c87 	j	bfc0321c <matrix_test+0x8fc>
bfc03478:	00e01821 	move	v1,a3
bfc0347c:	03e02821 	move	a1,ra
bfc03480:	0ff01800 	jal	bfc06000 <crc16>
bfc03484:	00000000 	nop
bfc03488:	8fa60028 	lw	a2,40(sp)
bfc0348c:	8fb7002c 	lw	s7,44(sp)
bfc03490:	afa20018 	sw	v0,24(sp)
bfc03494:	afa60010 	sw	a2,16(sp)
bfc03498:	afa00024 	sw	zero,36(sp)
bfc0349c:	8fb60010 	lw	s6,16(sp)
bfc034a0:	8fb30030 	lw	s3,48(sp)
bfc034a4:	0000a821 	move	s5,zero
bfc034a8:	86ff0000 	lh	ra,0(s7)
bfc034ac:	86680000 	lh	t0,0(s3)
bfc034b0:	24190001 	li	t9,1
bfc034b4:	011f0018 	mult	t0,ra
bfc034b8:	268bffff 	addiu	t3,s4,-1
bfc034bc:	0334602b 	sltu	t4,t9,s4
bfc034c0:	31630007 	andi	v1,t3,0x7
bfc034c4:	26f80002 	addiu	t8,s7,2
bfc034c8:	0000f812 	mflo	ra
bfc034cc:	11800084 	beqz	t4,bfc036e0 <matrix_test+0xdc0>
bfc034d0:	02725021 	addu	t2,s3,s2
bfc034d4:	10600047 	beqz	v1,bfc035f4 <matrix_test+0xcd4>
bfc034d8:	00000000 	nop
bfc034dc:	1079003b 	beq	v1,t9,bfc035cc <matrix_test+0xcac>
bfc034e0:	240b0002 	li	t3,2
bfc034e4:	106b0031 	beq	v1,t3,bfc035ac <matrix_test+0xc8c>
bfc034e8:	24090003 	li	t1,3
bfc034ec:	10690027 	beq	v1,t1,bfc0358c <matrix_test+0xc6c>
bfc034f0:	24050004 	li	a1,4
bfc034f4:	1065001d 	beq	v1,a1,bfc0356c <matrix_test+0xc4c>
bfc034f8:	240c0005 	li	t4,5
bfc034fc:	106c0013 	beq	v1,t4,bfc0354c <matrix_test+0xc2c>
bfc03500:	24070006 	li	a3,6
bfc03504:	10670009 	beq	v1,a3,bfc0352c <matrix_test+0xc0c>
bfc03508:	00000000 	nop
bfc0350c:	87020000 	lh	v0,0(t8)
bfc03510:	85440000 	lh	a0,0(t2)
bfc03514:	24190002 	li	t9,2
bfc03518:	00820018 	mult	a0,v0
bfc0351c:	01525021 	addu	t2,t2,s2
bfc03520:	26f80004 	addiu	t8,s7,4
bfc03524:	00003012 	mflo	a2
bfc03528:	03e6f821 	addu	ra,ra,a2
bfc0352c:	854e0000 	lh	t6,0(t2)
bfc03530:	87100000 	lh	s0,0(t8)
bfc03534:	27390001 	addiu	t9,t9,1
bfc03538:	01d00018 	mult	t6,s0
bfc0353c:	27180002 	addiu	t8,t8,2
bfc03540:	01525021 	addu	t2,t2,s2
bfc03544:	00004012 	mflo	t0
bfc03548:	03e8f821 	addu	ra,ra,t0
bfc0354c:	854f0000 	lh	t7,0(t2)
bfc03550:	870d0000 	lh	t5,0(t8)
bfc03554:	27390001 	addiu	t9,t9,1
bfc03558:	01ed0018 	mult	t7,t5
bfc0355c:	27180002 	addiu	t8,t8,2
bfc03560:	01525021 	addu	t2,t2,s2
bfc03564:	00008812 	mflo	s1
bfc03568:	03f1f821 	addu	ra,ra,s1
bfc0356c:	854b0000 	lh	t3,0(t2)
bfc03570:	87090000 	lh	t1,0(t8)
bfc03574:	27390001 	addiu	t9,t9,1
bfc03578:	01690018 	mult	t3,t1
bfc0357c:	27180002 	addiu	t8,t8,2
bfc03580:	01525021 	addu	t2,t2,s2
bfc03584:	00001812 	mflo	v1
bfc03588:	03e3f821 	addu	ra,ra,v1
bfc0358c:	854c0000 	lh	t4,0(t2)
bfc03590:	87070000 	lh	a3,0(t8)
bfc03594:	27390001 	addiu	t9,t9,1
bfc03598:	01870018 	mult	t4,a3
bfc0359c:	27180002 	addiu	t8,t8,2
bfc035a0:	01525021 	addu	t2,t2,s2
bfc035a4:	00002812 	mflo	a1
bfc035a8:	03e5f821 	addu	ra,ra,a1
bfc035ac:	85440000 	lh	a0,0(t2)
bfc035b0:	87020000 	lh	v0,0(t8)
bfc035b4:	27390001 	addiu	t9,t9,1
bfc035b8:	00820018 	mult	a0,v0
bfc035bc:	27180002 	addiu	t8,t8,2
bfc035c0:	01525021 	addu	t2,t2,s2
bfc035c4:	00003012 	mflo	a2
bfc035c8:	03e6f821 	addu	ra,ra,a2
bfc035cc:	85500000 	lh	s0,0(t2)
bfc035d0:	87110000 	lh	s1,0(t8)
bfc035d4:	27390001 	addiu	t9,t9,1
bfc035d8:	02110018 	mult	s0,s1
bfc035dc:	0334402b 	sltu	t0,t9,s4
bfc035e0:	27180002 	addiu	t8,t8,2
bfc035e4:	01525021 	addu	t2,t2,s2
bfc035e8:	00007012 	mflo	t6
bfc035ec:	1100003c 	beqz	t0,bfc036e0 <matrix_test+0xdc0>
bfc035f0:	03eef821 	addu	ra,ra,t6
bfc035f4:	854f0000 	lh	t7,0(t2)
bfc035f8:	87080000 	lh	t0,0(t8)
bfc035fc:	01523821 	addu	a3,t2,s2
bfc03600:	01e80018 	mult	t7,t0
bfc03604:	870d0002 	lh	t5,2(t8)
bfc03608:	84ec0000 	lh	t4,0(a3)
bfc0360c:	00f27021 	addu	t6,a3,s2
bfc03610:	87110004 	lh	s1,4(t8)
bfc03614:	85c90000 	lh	t1,0(t6)
bfc03618:	01d23021 	addu	a2,t6,s2
bfc0361c:	87100006 	lh	s0,6(t8)
bfc03620:	84c80000 	lh	t0,0(a2)
bfc03624:	00d22021 	addu	a0,a2,s2
bfc03628:	870f0008 	lh	t7,8(t8)
bfc0362c:	84870000 	lh	a3,0(a0)
bfc03630:	00922821 	addu	a1,a0,s2
bfc03634:	00001012 	mflo	v0
bfc03638:	870e000a 	lh	t6,10(t8)
bfc0363c:	03e21021 	addu	v0,ra,v0
bfc03640:	84a60000 	lh	a2,0(a1)
bfc03644:	018d0018 	mult	t4,t5
bfc03648:	00b21821 	addu	v1,a1,s2
bfc0364c:	870c000c 	lh	t4,12(t8)
bfc03650:	84640000 	lh	a0,0(v1)
bfc03654:	00725021 	addu	t2,v1,s2
bfc03658:	85430000 	lh	v1,0(t2)
bfc0365c:	870d000e 	lh	t5,14(t8)
bfc03660:	27390008 	addiu	t9,t9,8
bfc03664:	0334282b 	sltu	a1,t9,s4
bfc03668:	27180010 	addiu	t8,t8,16
bfc0366c:	01525021 	addu	t2,t2,s2
bfc03670:	00005812 	mflo	t3
	...
bfc0367c:	01310018 	mult	t1,s1
bfc03680:	004b8821 	addu	s1,v0,t3
bfc03684:	00004812 	mflo	t1
bfc03688:	02295821 	addu	t3,s1,t1
bfc0368c:	00000000 	nop
bfc03690:	01100018 	mult	t0,s0
bfc03694:	0000f812 	mflo	ra
bfc03698:	017f4821 	addu	t1,t3,ra
bfc0369c:	00000000 	nop
bfc036a0:	00ef0018 	mult	a3,t7
bfc036a4:	00003812 	mflo	a3
bfc036a8:	01271021 	addu	v0,t1,a3
bfc036ac:	00000000 	nop
bfc036b0:	00ce0018 	mult	a2,t6
bfc036b4:	00008012 	mflo	s0
bfc036b8:	00507821 	addu	t7,v0,s0
bfc036bc:	00000000 	nop
bfc036c0:	008c0018 	mult	a0,t4
bfc036c4:	00007012 	mflo	t6
bfc036c8:	01ee8821 	addu	s1,t7,t6
bfc036cc:	00000000 	nop
bfc036d0:	006d0018 	mult	v1,t5
bfc036d4:	00001812 	mflo	v1
bfc036d8:	14a0ffc6 	bnez	a1,bfc035f4 <matrix_test+0xcd4>
bfc036dc:	0223f821 	addu	ra,s1,v1
bfc036e0:	26b50001 	addiu	s5,s5,1
bfc036e4:	02b4c02b 	sltu	t8,s5,s4
bfc036e8:	aedf0000 	sw	ra,0(s6)
bfc036ec:	26730002 	addiu	s3,s3,2
bfc036f0:	1700ff6d 	bnez	t8,bfc034a8 <matrix_test+0xb88>
bfc036f4:	26d60004 	addiu	s6,s6,4
bfc036f8:	8fb00024 	lw	s0,36(sp)
bfc036fc:	8fb30010 	lw	s3,16(sp)
bfc03700:	8fb9001c 	lw	t9,28(sp)
bfc03704:	261f0001 	addiu	ra,s0,1
bfc03708:	0279b021 	addu	s6,s3,t9
bfc0370c:	03f4a82b 	sltu	s5,ra,s4
bfc03710:	afbf0024 	sw	ra,36(sp)
bfc03714:	02f2b821 	addu	s7,s7,s2
bfc03718:	16a0ff60 	bnez	s5,bfc0349c <matrix_test+0xb7c>
bfc0371c:	afb60010 	sw	s6,16(sp)
bfc03720:	8fab0028 	lw	t3,40(sp)
bfc03724:	00003021 	move	a2,zero
bfc03728:	00001821 	move	v1,zero
bfc0372c:	00002021 	move	a0,zero
bfc03730:	00006021 	move	t4,zero
bfc03734:	2687ffff 	addiu	a3,s4,-1
bfc03738:	30ea0003 	andi	t2,a3,0x3
bfc0373c:	01604021 	move	t0,t3
bfc03740:	1140003f 	beqz	t2,bfc03840 <matrix_test+0xf20>
bfc03744:	00004821 	move	t1,zero
bfc03748:	8d670000 	lw	a3,0(t3)
bfc0374c:	3090ffff 	andi	s0,a0,0xffff
bfc03750:	0067982a 	slt	s3,v1,a3
bfc03754:	00c73021 	addu	a2,a2,a3
bfc03758:	0213a821 	addu	s5,s0,s3
bfc0375c:	2616000a 	addiu	s6,s0,10
bfc03760:	00167400 	sll	t6,s6,0x10
bfc03764:	0015bc00 	sll	s7,s5,0x10
bfc03768:	03c6282a 	slt	a1,s8,a2
bfc0376c:	000e1403 	sra	v0,t6,0x10
bfc03770:	10a00002 	beqz	a1,bfc0377c <matrix_test+0xe5c>
bfc03774:	00172403 	sra	a0,s7,0x10
bfc03778:	00402021 	move	a0,v0
bfc0377c:	10a00002 	beqz	a1,bfc03788 <matrix_test+0xe68>
bfc03780:	24090001 	li	t1,1
bfc03784:	00003021 	move	a2,zero
bfc03788:	0134c82b 	sltu	t9,t1,s4
bfc0378c:	13200078 	beqz	t9,bfc03970 <matrix_test+0x1050>
bfc03790:	25680004 	addiu	t0,t3,4
bfc03794:	1149002a 	beq	t2,t1,bfc03840 <matrix_test+0xf20>
bfc03798:	00e01821 	move	v1,a3
bfc0379c:	24110002 	li	s1,2
bfc037a0:	11510014 	beq	t2,s1,bfc037f4 <matrix_test+0xed4>
bfc037a4:	309fffff 	andi	ra,a0,0xffff
bfc037a8:	8d050000 	lw	a1,0(t0)
bfc037ac:	00000000 	nop
bfc037b0:	00c55021 	addu	t2,a2,a1
bfc037b4:	00e5302a 	slt	a2,a3,a1
bfc037b8:	03e67821 	addu	t7,ra,a2
bfc037bc:	27e7000a 	addiu	a3,ra,10
bfc037c0:	00076c00 	sll	t5,a3,0x10
bfc037c4:	000fc400 	sll	t8,t7,0x10
bfc037c8:	03ca302a 	slt	a2,s8,t2
bfc037cc:	000d1403 	sra	v0,t5,0x10
bfc037d0:	10c00002 	beqz	a2,bfc037dc <matrix_test+0xebc>
bfc037d4:	00182403 	sra	a0,t8,0x10
bfc037d8:	00402021 	move	a0,v0
bfc037dc:	14c00002 	bnez	a2,bfc037e8 <matrix_test+0xec8>
bfc037e0:	00003021 	move	a2,zero
bfc037e4:	01403021 	move	a2,t2
bfc037e8:	25290001 	addiu	t1,t1,1
bfc037ec:	25080004 	addiu	t0,t0,4
bfc037f0:	00a01821 	move	v1,a1
bfc037f4:	8d050000 	lw	a1,0(t0)
bfc037f8:	3097ffff 	andi	s7,a0,0xffff
bfc037fc:	0065a82a 	slt	s5,v1,a1
bfc03800:	26e2000a 	addiu	v0,s7,10
bfc03804:	00c53821 	addu	a3,a2,a1
bfc03808:	02f51821 	addu	v1,s7,s5
bfc0380c:	00022400 	sll	a0,v0,0x10
bfc03810:	00035400 	sll	t2,v1,0x10
bfc03814:	03c7302a 	slt	a2,s8,a3
bfc03818:	00041403 	sra	v0,a0,0x10
bfc0381c:	10c00002 	beqz	a2,bfc03828 <matrix_test+0xf08>
bfc03820:	000a2403 	sra	a0,t2,0x10
bfc03824:	00402021 	move	a0,v0
bfc03828:	14c00002 	bnez	a2,bfc03834 <matrix_test+0xf14>
bfc0382c:	00003021 	move	a2,zero
bfc03830:	00e03021 	move	a2,a3
bfc03834:	25290001 	addiu	t1,t1,1
bfc03838:	25080004 	addiu	t0,t0,4
bfc0383c:	00a01821 	move	v1,a1
bfc03840:	8d070000 	lw	a3,0(t0)
bfc03844:	3085ffff 	andi	a1,a0,0xffff
bfc03848:	0067a82a 	slt	s5,v1,a3
bfc0384c:	00b52021 	addu	a0,a1,s5
bfc03850:	24b8000a 	addiu	t8,a1,10
bfc03854:	00c73021 	addu	a2,a2,a3
bfc03858:	00187c00 	sll	t7,t8,0x10
bfc0385c:	00045400 	sll	t2,a0,0x10
bfc03860:	03c6282a 	slt	a1,s8,a2
bfc03864:	000f1403 	sra	v0,t7,0x10
bfc03868:	10a00002 	beqz	a1,bfc03874 <matrix_test+0xf54>
bfc0386c:	000a2403 	sra	a0,t2,0x10
bfc03870:	00402021 	move	a0,v0
bfc03874:	10a00002 	beqz	a1,bfc03880 <matrix_test+0xf60>
bfc03878:	00000000 	nop
bfc0387c:	00003021 	move	a2,zero
bfc03880:	25290001 	addiu	t1,t1,1
bfc03884:	0134b02b 	sltu	s6,t1,s4
bfc03888:	12c00039 	beqz	s6,bfc03970 <matrix_test+0x1050>
bfc0388c:	250a0004 	addiu	t2,t0,4
bfc03890:	8d050004 	lw	a1,4(t0)
bfc03894:	308effff 	andi	t6,a0,0xffff
bfc03898:	00e5182a 	slt	v1,a3,a1
bfc0389c:	25c2000a 	addiu	v0,t6,10
bfc038a0:	00c54021 	addu	t0,a2,a1
bfc038a4:	01c38821 	addu	s1,t6,v1
bfc038a8:	00026c00 	sll	t5,v0,0x10
bfc038ac:	0011bc00 	sll	s7,s1,0x10
bfc038b0:	03c8302a 	slt	a2,s8,t0
bfc038b4:	000d2403 	sra	a0,t5,0x10
bfc038b8:	10c00002 	beqz	a2,bfc038c4 <matrix_test+0xfa4>
bfc038bc:	00171403 	sra	v0,s7,0x10
bfc038c0:	00801021 	move	v0,a0
bfc038c4:	14c00002 	bnez	a2,bfc038d0 <matrix_test+0xfb0>
bfc038c8:	00003821 	move	a3,zero
bfc038cc:	01003821 	move	a3,t0
bfc038d0:	8d460004 	lw	a2,4(t2)
bfc038d4:	3053ffff 	andi	s3,v0,0xffff
bfc038d8:	00a6c82a 	slt	t9,a1,a2
bfc038dc:	00e63821 	addu	a3,a3,a2
bfc038e0:	02797021 	addu	t6,s3,t9
bfc038e4:	2670000a 	addiu	s0,s3,10
bfc038e8:	0010b400 	sll	s6,s0,0x10
bfc038ec:	000e4400 	sll	t0,t6,0x10
bfc038f0:	03c7282a 	slt	a1,s8,a3
bfc038f4:	00162403 	sra	a0,s6,0x10
bfc038f8:	10a00002 	beqz	a1,bfc03904 <matrix_test+0xfe4>
bfc038fc:	00081403 	sra	v0,t0,0x10
bfc03900:	00801021 	move	v0,a0
bfc03904:	10a00002 	beqz	a1,bfc03910 <matrix_test+0xff0>
bfc03908:	00000000 	nop
bfc0390c:	00003821 	move	a3,zero
bfc03910:	8d450008 	lw	a1,8(t2)
bfc03914:	305fffff 	andi	ra,v0,0xffff
bfc03918:	00c5182a 	slt	v1,a2,a1
bfc0391c:	00e53821 	addu	a3,a3,a1
bfc03920:	03e3c021 	addu	t8,ra,v1
bfc03924:	27ed000a 	addiu	t5,ra,10
bfc03928:	000d7c00 	sll	t7,t5,0x10
bfc0392c:	00188c00 	sll	s1,t8,0x10
bfc03930:	03c7302a 	slt	a2,s8,a3
bfc03934:	000f1403 	sra	v0,t7,0x10
bfc03938:	10c00002 	beqz	a2,bfc03944 <matrix_test+0x1024>
bfc0393c:	00112403 	sra	a0,s1,0x10
bfc03940:	00402021 	move	a0,v0
bfc03944:	14c00006 	bnez	a2,bfc03960 <matrix_test+0x1040>
bfc03948:	00000000 	nop
bfc0394c:	00e03021 	move	a2,a3
bfc03950:	25290003 	addiu	t1,t1,3
bfc03954:	2548000c 	addiu	t0,t2,12
bfc03958:	0bf00e10 	j	bfc03840 <matrix_test+0xf20>
bfc0395c:	00a01821 	move	v1,a1
bfc03960:	0bf00e54 	j	bfc03950 <matrix_test+0x1030>
bfc03964:	00003021 	move	a2,zero
	...
bfc03970:	258c0001 	addiu	t4,t4,1
bfc03974:	8fa8001c 	lw	t0,28(sp)
bfc03978:	0194482b 	sltu	t1,t4,s4
bfc0397c:	11200003 	beqz	t1,bfc0398c <matrix_test+0x106c>
bfc03980:	01685821 	addu	t3,t3,t0
bfc03984:	0bf00dcd 	j	bfc03734 <matrix_test+0xe14>
bfc03988:	00e01821 	move	v1,a3
bfc0398c:	8fa50018 	lw	a1,24(sp)
bfc03990:	0ff01800 	jal	bfc06000 <crc16>
bfc03994:	0000b021 	move	s6,zero
bfc03998:	8fb8002c 	lw	t8,44(sp)
bfc0399c:	8fb50028 	lw	s5,40(sp)
bfc039a0:	0040b821 	move	s7,v0
bfc039a4:	8fb10030 	lw	s1,48(sp)
bfc039a8:	02a09821 	move	s3,s5
bfc039ac:	0000c821 	move	t9,zero
bfc039b0:	862e0000 	lh	t6,0(s1)
bfc039b4:	87030000 	lh	v1,0(t8)
bfc039b8:	240f0001 	li	t7,1
bfc039bc:	01c30018 	mult	t6,v1
bfc039c0:	268dffff 	addiu	t5,s4,-1
bfc039c4:	01f4582b 	sltu	t3,t7,s4
bfc039c8:	31a40003 	andi	a0,t5,0x3
bfc039cc:	02327021 	addu	t6,s1,s2
bfc039d0:	00001012 	mflo	v0
bfc039d4:	00028143 	sra	s0,v0,0x5
bfc039d8:	0002f883 	sra	ra,v0,0x2
bfc039dc:	320c007f 	andi	t4,s0,0x7f
bfc039e0:	33e6000f 	andi	a2,ra,0xf
bfc039e4:	01860018 	mult	t4,a2
bfc039e8:	00008012 	mflo	s0
bfc039ec:	1160006a 	beqz	t3,bfc03b98 <matrix_test+0x1278>
bfc039f0:	270d0002 	addiu	t5,t8,2
bfc039f4:	10800031 	beqz	a0,bfc03abc <matrix_test+0x119c>
bfc039f8:	00000000 	nop
bfc039fc:	108f001f 	beq	a0,t7,bfc03a7c <matrix_test+0x115c>
bfc03a00:	240b0002 	li	t3,2
bfc03a04:	108b000f 	beq	a0,t3,bfc03a44 <matrix_test+0x1124>
bfc03a08:	00000000 	nop
bfc03a0c:	85af0000 	lh	t7,0(t5)
bfc03a10:	85cd0000 	lh	t5,0(t6)
bfc03a14:	01d27021 	addu	t6,t6,s2
bfc03a18:	01af0018 	mult	t5,t7
bfc03a1c:	240f0002 	li	t7,2
bfc03a20:	270d0004 	addiu	t5,t8,4
bfc03a24:	00004012 	mflo	t0
bfc03a28:	00085083 	sra	t2,t0,0x2
bfc03a2c:	00083143 	sra	a2,t0,0x5
bfc03a30:	30c7007f 	andi	a3,a2,0x7f
bfc03a34:	3145000f 	andi	a1,t2,0xf
bfc03a38:	00e50018 	mult	a3,a1
bfc03a3c:	00004812 	mflo	t1
bfc03a40:	02098021 	addu	s0,s0,t1
bfc03a44:	85c90000 	lh	t1,0(t6)
bfc03a48:	85a50000 	lh	a1,0(t5)
bfc03a4c:	25ef0001 	addiu	t7,t7,1
bfc03a50:	01250018 	mult	t1,a1
bfc03a54:	25ad0002 	addiu	t5,t5,2
bfc03a58:	01d27021 	addu	t6,t6,s2
bfc03a5c:	00005812 	mflo	t3
bfc03a60:	000b2083 	sra	a0,t3,0x2
bfc03a64:	000b1143 	sra	v0,t3,0x5
bfc03a68:	305f007f 	andi	ra,v0,0x7f
bfc03a6c:	3083000f 	andi	v1,a0,0xf
bfc03a70:	03e30018 	mult	ra,v1
bfc03a74:	00006012 	mflo	t4
bfc03a78:	020c8021 	addu	s0,s0,t4
bfc03a7c:	85c40000 	lh	a0,0(t6)
bfc03a80:	85a20000 	lh	v0,0(t5)
bfc03a84:	25ef0001 	addiu	t7,t7,1
bfc03a88:	00820018 	mult	a0,v0
bfc03a8c:	01f4382b 	sltu	a3,t7,s4
bfc03a90:	25ad0002 	addiu	t5,t5,2
bfc03a94:	01d27021 	addu	t6,t6,s2
bfc03a98:	00001812 	mflo	v1
bfc03a9c:	00036083 	sra	t4,v1,0x2
bfc03aa0:	0003f943 	sra	ra,v1,0x5
bfc03aa4:	33e6007f 	andi	a2,ra,0x7f
bfc03aa8:	3188000f 	andi	t0,t4,0xf
bfc03aac:	00c80018 	mult	a2,t0
bfc03ab0:	00005012 	mflo	t2
bfc03ab4:	10e00038 	beqz	a3,bfc03b98 <matrix_test+0x1278>
bfc03ab8:	020a8021 	addu	s0,s0,t2
bfc03abc:	85c60000 	lh	a2,0(t6)
bfc03ac0:	85a30000 	lh	v1,0(t5)
bfc03ac4:	01d26021 	addu	t4,t6,s2
bfc03ac8:	00c30018 	mult	a2,v1
bfc03acc:	85a90002 	lh	t1,2(t5)
bfc03ad0:	85850000 	lh	a1,0(t4)
bfc03ad4:	01927021 	addu	t6,t4,s2
bfc03ad8:	85aa0004 	lh	t2,4(t5)
bfc03adc:	85c40000 	lh	a0,0(t6)
bfc03ae0:	01d23821 	addu	a3,t6,s2
bfc03ae4:	85a30006 	lh	v1,6(t5)
bfc03ae8:	84e60000 	lh	a2,0(a3)
bfc03aec:	00f27021 	addu	t6,a3,s2
bfc03af0:	25ef0004 	addiu	t7,t7,4
bfc03af4:	01f4602b 	sltu	t4,t7,s4
bfc03af8:	25ad0008 	addiu	t5,t5,8
bfc03afc:	0000f812 	mflo	ra
bfc03b00:	001f4083 	sra	t0,ra,0x2
bfc03b04:	001f1143 	sra	v0,ra,0x5
bfc03b08:	00a90018 	mult	a1,t1
bfc03b0c:	305f007f 	andi	ra,v0,0x7f
bfc03b10:	3108000f 	andi	t0,t0,0xf
bfc03b14:	00005812 	mflo	t3
bfc03b18:	000b4883 	sra	t1,t3,0x2
bfc03b1c:	000b2943 	sra	a1,t3,0x5
bfc03b20:	008a0018 	mult	a0,t2
bfc03b24:	30a5007f 	andi	a1,a1,0x7f
bfc03b28:	3129000f 	andi	t1,t1,0xf
bfc03b2c:	00003812 	mflo	a3
bfc03b30:	00075083 	sra	t2,a3,0x2
bfc03b34:	00072143 	sra	a0,a3,0x5
bfc03b38:	00c30018 	mult	a2,v1
bfc03b3c:	3084007f 	andi	a0,a0,0x7f
bfc03b40:	3147000f 	andi	a3,t2,0xf
bfc03b44:	00005812 	mflo	t3
bfc03b48:	000b1943 	sra	v1,t3,0x5
bfc03b4c:	000b3083 	sra	a2,t3,0x2
bfc03b50:	03e80018 	mult	ra,t0
bfc03b54:	30cb000f 	andi	t3,a2,0xf
bfc03b58:	3068007f 	andi	t0,v1,0x7f
bfc03b5c:	00001012 	mflo	v0
bfc03b60:	0202f821 	addu	ra,s0,v0
bfc03b64:	00000000 	nop
bfc03b68:	00a90018 	mult	a1,t1
bfc03b6c:	00005012 	mflo	t2
bfc03b70:	03ea4821 	addu	t1,ra,t2
bfc03b74:	00000000 	nop
bfc03b78:	00870018 	mult	a0,a3
bfc03b7c:	00002012 	mflo	a0
bfc03b80:	01245021 	addu	t2,t1,a0
bfc03b84:	00000000 	nop
bfc03b88:	010b0018 	mult	t0,t3
bfc03b8c:	00002812 	mflo	a1
bfc03b90:	1580ffca 	bnez	t4,bfc03abc <matrix_test+0x119c>
bfc03b94:	01458021 	addu	s0,t2,a1
bfc03b98:	27390001 	addiu	t9,t9,1
bfc03b9c:	0334782b 	sltu	t7,t9,s4
bfc03ba0:	ae700000 	sw	s0,0(s3)
bfc03ba4:	26310002 	addiu	s1,s1,2
bfc03ba8:	15e0ff81 	bnez	t7,bfc039b0 <matrix_test+0x1090>
bfc03bac:	26730004 	addiu	s3,s3,4
bfc03bb0:	26d60001 	addiu	s6,s6,1
bfc03bb4:	8fb9001c 	lw	t9,28(sp)
bfc03bb8:	02d4982b 	sltu	s3,s6,s4
bfc03bbc:	0312c021 	addu	t8,t8,s2
bfc03bc0:	1660ff78 	bnez	s3,bfc039a4 <matrix_test+0x1084>
bfc03bc4:	02b9a821 	addu	s5,s5,t9
bfc03bc8:	00003021 	move	a2,zero
bfc03bcc:	00001821 	move	v1,zero
bfc03bd0:	00002021 	move	a0,zero
bfc03bd4:	00005821 	move	t3,zero
bfc03bd8:	2687ffff 	addiu	a3,s4,-1
bfc03bdc:	30ea0003 	andi	t2,a3,0x3
bfc03be0:	8fa80020 	lw	t0,32(sp)
bfc03be4:	11400040 	beqz	t2,bfc03ce8 <matrix_test+0x13c8>
bfc03be8:	00004821 	move	t1,zero
bfc03bec:	8d070000 	lw	a3,0(t0)
bfc03bf0:	3096ffff 	andi	s6,a0,0xffff
bfc03bf4:	0067802a 	slt	s0,v1,a3
bfc03bf8:	00c73021 	addu	a2,a2,a3
bfc03bfc:	02d07021 	addu	t6,s6,s0
bfc03c00:	26cc000a 	addiu	t4,s6,10
bfc03c04:	000c7c00 	sll	t7,t4,0x10
bfc03c08:	000e6c00 	sll	t5,t6,0x10
bfc03c0c:	03c6282a 	slt	a1,s8,a2
bfc03c10:	000f1403 	sra	v0,t7,0x10
bfc03c14:	10a00002 	beqz	a1,bfc03c20 <matrix_test+0x1300>
bfc03c18:	000d2403 	sra	a0,t5,0x10
bfc03c1c:	00402021 	move	a0,v0
bfc03c20:	10a00002 	beqz	a1,bfc03c2c <matrix_test+0x130c>
bfc03c24:	24090001 	li	t1,1
bfc03c28:	00003021 	move	a2,zero
bfc03c2c:	8fa30020 	lw	v1,32(sp)
bfc03c30:	0134282b 	sltu	a1,t1,s4
bfc03c34:	10a0007b 	beqz	a1,bfc03e24 <matrix_test+0x1504>
bfc03c38:	24680004 	addiu	t0,v1,4
bfc03c3c:	1149002a 	beq	t2,t1,bfc03ce8 <matrix_test+0x13c8>
bfc03c40:	00e01821 	move	v1,a3
bfc03c44:	24020002 	li	v0,2
bfc03c48:	11420014 	beq	t2,v0,bfc03c9c <matrix_test+0x137c>
bfc03c4c:	3091ffff 	andi	s1,a0,0xffff
bfc03c50:	8d050000 	lw	a1,0(t0)
bfc03c54:	00000000 	nop
bfc03c58:	00e5c02a 	slt	t8,a3,a1
bfc03c5c:	02382021 	addu	a0,s1,t8
bfc03c60:	00c55021 	addu	t2,a2,a1
bfc03c64:	2639000a 	addiu	t9,s1,10
bfc03c68:	00199c00 	sll	s3,t9,0x10
bfc03c6c:	00043c00 	sll	a3,a0,0x10
bfc03c70:	03ca302a 	slt	a2,s8,t2
bfc03c74:	00131403 	sra	v0,s3,0x10
bfc03c78:	10c00002 	beqz	a2,bfc03c84 <matrix_test+0x1364>
bfc03c7c:	00072403 	sra	a0,a3,0x10
bfc03c80:	00402021 	move	a0,v0
bfc03c84:	14c00002 	bnez	a2,bfc03c90 <matrix_test+0x1370>
bfc03c88:	00003021 	move	a2,zero
bfc03c8c:	01403021 	move	a2,t2
bfc03c90:	25290001 	addiu	t1,t1,1
bfc03c94:	25080004 	addiu	t0,t0,4
bfc03c98:	00a01821 	move	v1,a1
bfc03c9c:	8d050000 	lw	a1,0(t0)
bfc03ca0:	308fffff 	andi	t7,a0,0xffff
bfc03ca4:	00c53821 	addu	a3,a2,a1
bfc03ca8:	0065302a 	slt	a2,v1,a1
bfc03cac:	01e6a821 	addu	s5,t7,a2
bfc03cb0:	25ee000a 	addiu	t6,t7,10
bfc03cb4:	000e6c00 	sll	t5,t6,0x10
bfc03cb8:	00155400 	sll	t2,s5,0x10
bfc03cbc:	03c7302a 	slt	a2,s8,a3
bfc03cc0:	000d1403 	sra	v0,t5,0x10
bfc03cc4:	10c00002 	beqz	a2,bfc03cd0 <matrix_test+0x13b0>
bfc03cc8:	000a2403 	sra	a0,t2,0x10
bfc03ccc:	00402021 	move	a0,v0
bfc03cd0:	14c00002 	bnez	a2,bfc03cdc <matrix_test+0x13bc>
bfc03cd4:	00003021 	move	a2,zero
bfc03cd8:	00e03021 	move	a2,a3
bfc03cdc:	25290001 	addiu	t1,t1,1
bfc03ce0:	25080004 	addiu	t0,t0,4
bfc03ce4:	00a01821 	move	v1,a1
bfc03ce8:	8d070000 	lw	a3,0(t0)
bfc03cec:	3085ffff 	andi	a1,a0,0xffff
bfc03cf0:	0067702a 	slt	t6,v1,a3
bfc03cf4:	00ae5021 	addu	t2,a1,t6
bfc03cf8:	24bf000a 	addiu	ra,a1,10
bfc03cfc:	00c73021 	addu	a2,a2,a3
bfc03d00:	001f1400 	sll	v0,ra,0x10
bfc03d04:	000a2400 	sll	a0,t2,0x10
bfc03d08:	03c6282a 	slt	a1,s8,a2
bfc03d0c:	00021403 	sra	v0,v0,0x10
bfc03d10:	10a00002 	beqz	a1,bfc03d1c <matrix_test+0x13fc>
bfc03d14:	00042403 	sra	a0,a0,0x10
bfc03d18:	00402021 	move	a0,v0
bfc03d1c:	10a00002 	beqz	a1,bfc03d28 <matrix_test+0x1408>
bfc03d20:	00000000 	nop
bfc03d24:	00003021 	move	a2,zero
bfc03d28:	25290001 	addiu	t1,t1,1
bfc03d2c:	0134602b 	sltu	t4,t1,s4
bfc03d30:	1180003b 	beqz	t4,bfc03e20 <matrix_test+0x1500>
bfc03d34:	250a0004 	addiu	t2,t0,4
bfc03d38:	8d050004 	lw	a1,4(t0)
bfc03d3c:	3090ffff 	andi	s0,a0,0xffff
bfc03d40:	00e5682a 	slt	t5,a3,a1
bfc03d44:	00c54021 	addu	t0,a2,a1
bfc03d48:	020dc021 	addu	t8,s0,t5
bfc03d4c:	2616000a 	addiu	s6,s0,10
bfc03d50:	0016ac00 	sll	s5,s6,0x10
bfc03d54:	00188c00 	sll	s1,t8,0x10
bfc03d58:	03c8302a 	slt	a2,s8,t0
bfc03d5c:	00152403 	sra	a0,s5,0x10
bfc03d60:	10c00002 	beqz	a2,bfc03d6c <matrix_test+0x144c>
bfc03d64:	00111403 	sra	v0,s1,0x10
bfc03d68:	00801021 	move	v0,a0
bfc03d6c:	14c00002 	bnez	a2,bfc03d78 <matrix_test+0x1458>
bfc03d70:	00003821 	move	a3,zero
bfc03d74:	01003821 	move	a3,t0
bfc03d78:	8d460004 	lw	a2,4(t2)
bfc03d7c:	305fffff 	andi	ra,v0,0xffff
bfc03d80:	00a6182a 	slt	v1,a1,a2
bfc03d84:	00e63821 	addu	a3,a3,a2
bfc03d88:	03e36021 	addu	t4,ra,v1
bfc03d8c:	27f0000a 	addiu	s0,ra,10
bfc03d90:	0010b400 	sll	s6,s0,0x10
bfc03d94:	000c4400 	sll	t0,t4,0x10
bfc03d98:	03c7282a 	slt	a1,s8,a3
bfc03d9c:	00162403 	sra	a0,s6,0x10
bfc03da0:	10a00002 	beqz	a1,bfc03dac <matrix_test+0x148c>
bfc03da4:	00081403 	sra	v0,t0,0x10
bfc03da8:	00801021 	move	v0,a0
bfc03dac:	10a00002 	beqz	a1,bfc03db8 <matrix_test+0x1498>
bfc03db0:	00000000 	nop
bfc03db4:	00003821 	move	a3,zero
bfc03db8:	8d450008 	lw	a1,8(t2)
bfc03dbc:	3051ffff 	andi	s1,v0,0xffff
bfc03dc0:	00c5c02a 	slt	t8,a2,a1
bfc03dc4:	00e53821 	addu	a3,a3,a1
bfc03dc8:	02389821 	addu	s3,s1,t8
bfc03dcc:	2639000a 	addiu	t9,s1,10
bfc03dd0:	00191400 	sll	v0,t9,0x10
bfc03dd4:	00132400 	sll	a0,s3,0x10
bfc03dd8:	03c7302a 	slt	a2,s8,a3
bfc03ddc:	00021403 	sra	v0,v0,0x10
bfc03de0:	10c00002 	beqz	a2,bfc03dec <matrix_test+0x14cc>
bfc03de4:	00042403 	sra	a0,a0,0x10
bfc03de8:	00402021 	move	a0,v0
bfc03dec:	14c00008 	bnez	a2,bfc03e10 <matrix_test+0x14f0>
bfc03df0:	00000000 	nop
bfc03df4:	00e03021 	move	a2,a3
bfc03df8:	25290003 	addiu	t1,t1,3
bfc03dfc:	2548000c 	addiu	t0,t2,12
bfc03e00:	0bf00f3a 	j	bfc03ce8 <matrix_test+0x13c8>
bfc03e04:	00a01821 	move	v1,a1
	...
bfc03e10:	0bf00f7e 	j	bfc03df8 <matrix_test+0x14d8>
bfc03e14:	00003021 	move	a2,zero
	...
bfc03e20:	8fa30020 	lw	v1,32(sp)
bfc03e24:	8faf001c 	lw	t7,28(sp)
bfc03e28:	256b0001 	addiu	t3,t3,1
bfc03e2c:	006f4821 	addu	t1,v1,t7
bfc03e30:	0174402b 	sltu	t0,t3,s4
bfc03e34:	11000003 	beqz	t0,bfc03e44 <matrix_test+0x1524>
bfc03e38:	afa90020 	sw	t1,32(sp)
bfc03e3c:	0bf00ef6 	j	bfc03bd8 <matrix_test+0x12b8>
bfc03e40:	00e01821 	move	v1,a3
bfc03e44:	0ff01800 	jal	bfc06000 <crc16>
bfc03e48:	02e02821 	move	a1,s7
bfc03e4c:	8fb70034 	lw	s7,52(sp)
bfc03e50:	00407821 	move	t7,v0
bfc03e54:	0017f023 	negu	s8,s7
bfc03e58:	33cdffff 	andi	t5,s8,0xffff
bfc03e5c:	00007021 	move	t6,zero
bfc03e60:	8fb30014 	lw	s3,20(sp)
bfc03e64:	240c0001 	li	t4,1
bfc03e68:	96780000 	lhu	t8,0(s3)
bfc03e6c:	2699ffff 	addiu	t9,s4,-1
bfc03e70:	01b88821 	addu	s1,t5,t8
bfc03e74:	0194b82b 	sltu	s7,t4,s4
bfc03e78:	a6710000 	sh	s1,0(s3)
bfc03e7c:	33230007 	andi	v1,t9,0x7
bfc03e80:	12e00051 	beqz	s7,bfc03fc8 <matrix_test+0x16a8>
bfc03e84:	266b0002 	addiu	t3,s3,2
bfc03e88:	10600033 	beqz	v1,bfc03f58 <matrix_test+0x1638>
bfc03e8c:	00000000 	nop
bfc03e90:	106c002a 	beq	v1,t4,bfc03f3c <matrix_test+0x161c>
bfc03e94:	24060002 	li	a2,2
bfc03e98:	10660023 	beq	v1,a2,bfc03f28 <matrix_test+0x1608>
bfc03e9c:	24150003 	li	s5,3
bfc03ea0:	1075001c 	beq	v1,s5,bfc03f14 <matrix_test+0x15f4>
bfc03ea4:	24160004 	li	s6,4
bfc03ea8:	10760015 	beq	v1,s6,bfc03f00 <matrix_test+0x15e0>
bfc03eac:	24100005 	li	s0,5
bfc03eb0:	1070000e 	beq	v1,s0,bfc03eec <matrix_test+0x15cc>
bfc03eb4:	240a0006 	li	t2,6
bfc03eb8:	106a0007 	beq	v1,t2,bfc03ed8 <matrix_test+0x15b8>
bfc03ebc:	00000000 	nop
bfc03ec0:	95690000 	lhu	t1,0(t3)
bfc03ec4:	8fbf0014 	lw	ra,20(sp)
bfc03ec8:	01a94021 	addu	t0,t5,t1
bfc03ecc:	a5680000 	sh	t0,0(t3)
bfc03ed0:	240c0002 	li	t4,2
bfc03ed4:	27eb0004 	addiu	t3,ra,4
bfc03ed8:	95650000 	lhu	a1,0(t3)
bfc03edc:	258c0001 	addiu	t4,t4,1
bfc03ee0:	01a53821 	addu	a3,t5,a1
bfc03ee4:	a5670000 	sh	a3,0(t3)
bfc03ee8:	256b0002 	addiu	t3,t3,2
bfc03eec:	95630000 	lhu	v1,0(t3)
bfc03ef0:	258c0001 	addiu	t4,t4,1
bfc03ef4:	01a32021 	addu	a0,t5,v1
bfc03ef8:	a5640000 	sh	a0,0(t3)
bfc03efc:	256b0002 	addiu	t3,t3,2
bfc03f00:	957e0000 	lhu	s8,0(t3)
bfc03f04:	258c0001 	addiu	t4,t4,1
bfc03f08:	01be1021 	addu	v0,t5,s8
bfc03f0c:	a5620000 	sh	v0,0(t3)
bfc03f10:	256b0002 	addiu	t3,t3,2
bfc03f14:	95730000 	lhu	s3,0(t3)
bfc03f18:	258c0001 	addiu	t4,t4,1
bfc03f1c:	01b3b821 	addu	s7,t5,s3
bfc03f20:	a5770000 	sh	s7,0(t3)
bfc03f24:	256b0002 	addiu	t3,t3,2
bfc03f28:	95710000 	lhu	s1,0(t3)
bfc03f2c:	258c0001 	addiu	t4,t4,1
bfc03f30:	01b1c821 	addu	t9,t5,s1
bfc03f34:	a5790000 	sh	t9,0(t3)
bfc03f38:	256b0002 	addiu	t3,t3,2
bfc03f3c:	95750000 	lhu	s5,0(t3)
bfc03f40:	258c0001 	addiu	t4,t4,1
bfc03f44:	01b53021 	addu	a2,t5,s5
bfc03f48:	0194c02b 	sltu	t8,t4,s4
bfc03f4c:	a5660000 	sh	a2,0(t3)
bfc03f50:	1300001d 	beqz	t8,bfc03fc8 <matrix_test+0x16a8>
bfc03f54:	256b0002 	addiu	t3,t3,2
bfc03f58:	95620000 	lhu	v0,0(t3)
bfc03f5c:	95630002 	lhu	v1,2(t3)
bfc03f60:	95640004 	lhu	a0,4(t3)
bfc03f64:	95650006 	lhu	a1,6(t3)
bfc03f68:	95670008 	lhu	a3,8(t3)
bfc03f6c:	9569000a 	lhu	t1,10(t3)
bfc03f70:	9568000c 	lhu	t0,12(t3)
bfc03f74:	957f000e 	lhu	ra,14(t3)
bfc03f78:	258c0008 	addiu	t4,t4,8
bfc03f7c:	01a25021 	addu	t2,t5,v0
bfc03f80:	01a38021 	addu	s0,t5,v1
bfc03f84:	01a4b021 	addu	s6,t5,a0
bfc03f88:	01a5a821 	addu	s5,t5,a1
bfc03f8c:	01a73021 	addu	a2,t5,a3
bfc03f90:	01a9c021 	addu	t8,t5,t1
bfc03f94:	01a88821 	addu	s1,t5,t0
bfc03f98:	01bfc821 	addu	t9,t5,ra
bfc03f9c:	0194982b 	sltu	s3,t4,s4
bfc03fa0:	a56a0000 	sh	t2,0(t3)
bfc03fa4:	a5700002 	sh	s0,2(t3)
bfc03fa8:	a5760004 	sh	s6,4(t3)
bfc03fac:	a5750006 	sh	s5,6(t3)
bfc03fb0:	a5660008 	sh	a2,8(t3)
bfc03fb4:	a578000a 	sh	t8,10(t3)
bfc03fb8:	a571000c 	sh	s1,12(t3)
bfc03fbc:	a579000e 	sh	t9,14(t3)
bfc03fc0:	1660ffe5 	bnez	s3,bfc03f58 <matrix_test+0x1638>
bfc03fc4:	256b0010 	addiu	t3,t3,16
bfc03fc8:	8fbe0014 	lw	s8,20(sp)
bfc03fcc:	25ce0001 	addiu	t6,t6,1
bfc03fd0:	03d26021 	addu	t4,s8,s2
bfc03fd4:	01d4582b 	sltu	t3,t6,s4
bfc03fd8:	1560ffa1 	bnez	t3,bfc03e60 <matrix_test+0x1540>
bfc03fdc:	afac0014 	sw	t4,20(sp)
bfc03fe0:	8fbf005c 	lw	ra,92(sp)
bfc03fe4:	000f9400 	sll	s2,t7,0x10
bfc03fe8:	00121403 	sra	v0,s2,0x10
bfc03fec:	8fbe0058 	lw	s8,88(sp)
bfc03ff0:	8fb70054 	lw	s7,84(sp)
bfc03ff4:	8fb60050 	lw	s6,80(sp)
bfc03ff8:	8fb5004c 	lw	s5,76(sp)
bfc03ffc:	8fb40048 	lw	s4,72(sp)
bfc04000:	8fb30044 	lw	s3,68(sp)
bfc04004:	8fb20040 	lw	s2,64(sp)
bfc04008:	8fb1003c 	lw	s1,60(sp)
bfc0400c:	8fb00038 	lw	s0,56(sp)
bfc04010:	03e00008 	jr	ra
bfc04014:	27bd0060 	addiu	sp,sp,96
bfc04018:	0ff01800 	jal	bfc06000 <crc16>
bfc0401c:	00002821 	move	a1,zero
bfc04020:	00402821 	move	a1,v0
bfc04024:	0ff01800 	jal	bfc06000 <crc16>
bfc04028:	00002021 	move	a0,zero
bfc0402c:	00402821 	move	a1,v0
bfc04030:	0ff01800 	jal	bfc06000 <crc16>
bfc04034:	00002021 	move	a0,zero
bfc04038:	00402821 	move	a1,v0
bfc0403c:	8fbf005c 	lw	ra,92(sp)
bfc04040:	8fbe0058 	lw	s8,88(sp)
bfc04044:	8fb70054 	lw	s7,84(sp)
bfc04048:	8fb60050 	lw	s6,80(sp)
bfc0404c:	8fb5004c 	lw	s5,76(sp)
bfc04050:	8fb40048 	lw	s4,72(sp)
bfc04054:	8fb30044 	lw	s3,68(sp)
bfc04058:	8fb20040 	lw	s2,64(sp)
bfc0405c:	8fb1003c 	lw	s1,60(sp)
bfc04060:	8fb00038 	lw	s0,56(sp)
bfc04064:	00002021 	move	a0,zero
bfc04068:	0bf01800 	j	bfc06000 <crc16>
bfc0406c:	27bd0060 	addiu	sp,sp,96

bfc04070 <core_bench_matrix>:
core_bench_matrix():
bfc04070:	27bdff98 	addiu	sp,sp,-104
bfc04074:	8c820008 	lw	v0,8(a0)
bfc04078:	8c83000c 	lw	v1,12(a0)
bfc0407c:	afb40050 	sw	s4,80(sp)
bfc04080:	00052c00 	sll	a1,a1,0x10
bfc04084:	8c940000 	lw	s4,0(a0)
bfc04088:	8c840004 	lw	a0,4(a0)
bfc0408c:	00052c03 	sra	a1,a1,0x10
bfc04090:	30c6ffff 	andi	a2,a2,0xffff
bfc04094:	afbf0064 	sw	ra,100(sp)
bfc04098:	afbe0060 	sw	s8,96(sp)
bfc0409c:	afb7005c 	sw	s7,92(sp)
bfc040a0:	afb60058 	sw	s6,88(sp)
bfc040a4:	afb50054 	sw	s5,84(sp)
bfc040a8:	afb3004c 	sw	s3,76(sp)
bfc040ac:	afb20048 	sw	s2,72(sp)
bfc040b0:	afb10044 	sw	s1,68(sp)
bfc040b4:	afb00040 	sw	s0,64(sp)
bfc040b8:	afa50034 	sw	a1,52(sp)
bfc040bc:	afa60038 	sw	a2,56(sp)
bfc040c0:	afa20028 	sw	v0,40(sp)
bfc040c4:	afa30030 	sw	v1,48(sp)
bfc040c8:	128005a8 	beqz	s4,bfc0576c <core_bench_matrix+0x16fc>
bfc040cc:	afa4002c 	sw	a0,44(sp)
bfc040d0:	30adffff 	andi	t5,a1,0xffff
bfc040d4:	00149040 	sll	s2,s4,0x1
bfc040d8:	afa40010 	sw	a0,16(sp)
bfc040dc:	00807021 	move	t6,a0
bfc040e0:	00007821 	move	t7,zero
bfc040e4:	95c90000 	lhu	t1,0(t6)
bfc040e8:	240c0001 	li	t4,1
bfc040ec:	01a95021 	addu	t2,t5,t1
bfc040f0:	2685ffff 	addiu	a1,s4,-1
bfc040f4:	0194302b 	sltu	a2,t4,s4
bfc040f8:	a5ca0000 	sh	t2,0(t6)
bfc040fc:	30a30007 	andi	v1,a1,0x7
bfc04100:	10c00050 	beqz	a2,bfc04244 <core_bench_matrix+0x1d4>
bfc04104:	25cb0002 	addiu	t3,t6,2
bfc04108:	10600032 	beqz	v1,bfc041d4 <core_bench_matrix+0x164>
bfc0410c:	00000000 	nop
bfc04110:	106c0029 	beq	v1,t4,bfc041b8 <core_bench_matrix+0x148>
bfc04114:	24100002 	li	s0,2
bfc04118:	10700022 	beq	v1,s0,bfc041a4 <core_bench_matrix+0x134>
bfc0411c:	24170003 	li	s7,3
bfc04120:	1077001b 	beq	v1,s7,bfc04190 <core_bench_matrix+0x120>
bfc04124:	24080004 	li	t0,4
bfc04128:	10680014 	beq	v1,t0,bfc0417c <core_bench_matrix+0x10c>
bfc0412c:	24130005 	li	s3,5
bfc04130:	1073000d 	beq	v1,s3,bfc04168 <core_bench_matrix+0xf8>
bfc04134:	24190006 	li	t9,6
bfc04138:	10790006 	beq	v1,t9,bfc04154 <core_bench_matrix+0xe4>
bfc0413c:	00000000 	nop
bfc04140:	95750000 	lhu	s5,0(t3)
bfc04144:	240c0002 	li	t4,2
bfc04148:	01b51821 	addu	v1,t5,s5
bfc0414c:	a5630000 	sh	v1,0(t3)
bfc04150:	25cb0004 	addiu	t3,t6,4
bfc04154:	95710000 	lhu	s1,0(t3)
bfc04158:	258c0001 	addiu	t4,t4,1
bfc0415c:	01b1b021 	addu	s6,t5,s1
bfc04160:	a5760000 	sh	s6,0(t3)
bfc04164:	256b0002 	addiu	t3,t3,2
bfc04168:	95620000 	lhu	v0,0(t3)
bfc0416c:	258c0001 	addiu	t4,t4,1
bfc04170:	01a2c021 	addu	t8,t5,v0
bfc04174:	a5780000 	sh	t8,0(t3)
bfc04178:	256b0002 	addiu	t3,t3,2
bfc0417c:	95690000 	lhu	t1,0(t3)
bfc04180:	258c0001 	addiu	t4,t4,1
bfc04184:	01a9f021 	addu	s8,t5,t1
bfc04188:	a57e0000 	sh	s8,0(t3)
bfc0418c:	256b0002 	addiu	t3,t3,2
bfc04190:	95670000 	lhu	a3,0(t3)
bfc04194:	258c0001 	addiu	t4,t4,1
bfc04198:	01a72821 	addu	a1,t5,a3
bfc0419c:	a5650000 	sh	a1,0(t3)
bfc041a0:	256b0002 	addiu	t3,t3,2
bfc041a4:	956a0000 	lhu	t2,0(t3)
bfc041a8:	258c0001 	addiu	t4,t4,1
bfc041ac:	01aa3021 	addu	a2,t5,t2
bfc041b0:	a5660000 	sh	a2,0(t3)
bfc041b4:	256b0002 	addiu	t3,t3,2
bfc041b8:	95700000 	lhu	s0,0(t3)
bfc041bc:	258c0001 	addiu	t4,t4,1
bfc041c0:	01b0f821 	addu	ra,t5,s0
bfc041c4:	0194202b 	sltu	a0,t4,s4
bfc041c8:	a57f0000 	sh	ra,0(t3)
bfc041cc:	1080001d 	beqz	a0,bfc04244 <core_bench_matrix+0x1d4>
bfc041d0:	256b0002 	addiu	t3,t3,2
bfc041d4:	95620000 	lhu	v0,0(t3)
bfc041d8:	95630002 	lhu	v1,2(t3)
bfc041dc:	957f0004 	lhu	ra,4(t3)
bfc041e0:	957e0006 	lhu	s8,6(t3)
bfc041e4:	95790008 	lhu	t9,8(t3)
bfc041e8:	9578000a 	lhu	t8,10(t3)
bfc041ec:	9577000c 	lhu	s7,12(t3)
bfc041f0:	9576000e 	lhu	s6,14(t3)
bfc041f4:	258c0008 	addiu	t4,t4,8
bfc041f8:	01a2a821 	addu	s5,t5,v0
bfc041fc:	01a39821 	addu	s3,t5,v1
bfc04200:	01bf2021 	addu	a0,t5,ra
bfc04204:	01be8821 	addu	s1,t5,s8
bfc04208:	01b98021 	addu	s0,t5,t9
bfc0420c:	01b83821 	addu	a3,t5,t8
bfc04210:	01b74021 	addu	t0,t5,s7
bfc04214:	01b64821 	addu	t1,t5,s6
bfc04218:	0194502b 	sltu	t2,t4,s4
bfc0421c:	a5750000 	sh	s5,0(t3)
bfc04220:	a5730002 	sh	s3,2(t3)
bfc04224:	a5640004 	sh	a0,4(t3)
bfc04228:	a5710006 	sh	s1,6(t3)
bfc0422c:	a5700008 	sh	s0,8(t3)
bfc04230:	a567000a 	sh	a3,10(t3)
bfc04234:	a568000c 	sh	t0,12(t3)
bfc04238:	a569000e 	sh	t1,14(t3)
bfc0423c:	1540ffe5 	bnez	t2,bfc041d4 <core_bench_matrix+0x164>
bfc04240:	256b0010 	addiu	t3,t3,16
bfc04244:	25ef0001 	addiu	t7,t7,1
bfc04248:	01f4582b 	sltu	t3,t7,s4
bfc0424c:	1560ffa5 	bnez	t3,bfc040e4 <core_bench_matrix+0x74>
bfc04250:	01d27021 	addu	t6,t6,s2
bfc04254:	8fac0030 	lw	t4,48(sp)
bfc04258:	00146880 	sll	t5,s4,0x2
bfc0425c:	8faf002c 	lw	t7,44(sp)
bfc04260:	afad001c 	sw	t5,28(sp)
bfc04264:	afac0020 	sw	t4,32(sp)
bfc04268:	01807021 	move	t6,t4
bfc0426c:	00008021 	move	s0,zero
bfc04270:	85f10000 	lh	s1,0(t7)
bfc04274:	8fa40034 	lw	a0,52(sp)
bfc04278:	240d0001 	li	t5,1
bfc0427c:	00910018 	mult	a0,s1
bfc04280:	2695ffff 	addiu	s5,s4,-1
bfc04284:	01b4382b 	sltu	a3,t5,s4
bfc04288:	32a30007 	andi	v1,s5,0x7
bfc0428c:	25eb0002 	addiu	t3,t7,2
bfc04290:	25cc0004 	addiu	t4,t6,4
bfc04294:	00004012 	mflo	t0
bfc04298:	10e00077 	beqz	a3,bfc04478 <core_bench_matrix+0x408>
bfc0429c:	adc80000 	sw	t0,0(t6)
bfc042a0:	10600047 	beqz	v1,bfc043c0 <core_bench_matrix+0x350>
bfc042a4:	00000000 	nop
bfc042a8:	106d003b 	beq	v1,t5,bfc04398 <core_bench_matrix+0x328>
bfc042ac:	241e0002 	li	s8,2
bfc042b0:	107e0031 	beq	v1,s8,bfc04378 <core_bench_matrix+0x308>
bfc042b4:	24090003 	li	t1,3
bfc042b8:	10690027 	beq	v1,t1,bfc04358 <core_bench_matrix+0x2e8>
bfc042bc:	24050004 	li	a1,4
bfc042c0:	1065001d 	beq	v1,a1,bfc04338 <core_bench_matrix+0x2c8>
bfc042c4:	24070005 	li	a3,5
bfc042c8:	10670013 	beq	v1,a3,bfc04318 <core_bench_matrix+0x2a8>
bfc042cc:	24060006 	li	a2,6
bfc042d0:	10660009 	beq	v1,a2,bfc042f8 <core_bench_matrix+0x288>
bfc042d4:	00000000 	nop
bfc042d8:	85640000 	lh	a0,0(t3)
bfc042dc:	8fab0034 	lw	t3,52(sp)
bfc042e0:	240d0002 	li	t5,2
bfc042e4:	01640018 	mult	t3,a0
bfc042e8:	25eb0004 	addiu	t3,t7,4
bfc042ec:	00005012 	mflo	t2
bfc042f0:	ad8a0000 	sw	t2,0(t4)
bfc042f4:	25cc0008 	addiu	t4,t6,8
bfc042f8:	85770000 	lh	s7,0(t3)
bfc042fc:	8fa30034 	lw	v1,52(sp)
bfc04300:	25ad0001 	addiu	t5,t5,1
bfc04304:	00770018 	mult	v1,s7
bfc04308:	256b0002 	addiu	t3,t3,2
bfc0430c:	0000f812 	mflo	ra
bfc04310:	ad9f0000 	sw	ra,0(t4)
bfc04314:	258c0004 	addiu	t4,t4,4
bfc04318:	85730000 	lh	s3,0(t3)
bfc0431c:	8fb90034 	lw	t9,52(sp)
bfc04320:	25ad0001 	addiu	t5,t5,1
bfc04324:	03330018 	mult	t9,s3
bfc04328:	256b0002 	addiu	t3,t3,2
bfc0432c:	00004012 	mflo	t0
bfc04330:	ad880000 	sw	t0,0(t4)
bfc04334:	258c0004 	addiu	t4,t4,4
bfc04338:	85760000 	lh	s6,0(t3)
bfc0433c:	8fb10034 	lw	s1,52(sp)
bfc04340:	25ad0001 	addiu	t5,t5,1
bfc04344:	02360018 	mult	s1,s6
bfc04348:	256b0002 	addiu	t3,t3,2
bfc0434c:	0000a812 	mflo	s5
bfc04350:	ad950000 	sw	s5,0(t4)
bfc04354:	258c0004 	addiu	t4,t4,4
bfc04358:	85620000 	lh	v0,0(t3)
bfc0435c:	8fbe0034 	lw	s8,52(sp)
bfc04360:	25ad0001 	addiu	t5,t5,1
bfc04364:	03c20018 	mult	s8,v0
bfc04368:	256b0002 	addiu	t3,t3,2
bfc0436c:	0000c012 	mflo	t8
bfc04370:	ad980000 	sw	t8,0(t4)
bfc04374:	258c0004 	addiu	t4,t4,4
bfc04378:	85650000 	lh	a1,0(t3)
bfc0437c:	8fa70034 	lw	a3,52(sp)
bfc04380:	25ad0001 	addiu	t5,t5,1
bfc04384:	00e50018 	mult	a3,a1
bfc04388:	256b0002 	addiu	t3,t3,2
bfc0438c:	00004812 	mflo	t1
bfc04390:	ad890000 	sw	t1,0(t4)
bfc04394:	258c0004 	addiu	t4,t4,4
bfc04398:	85640000 	lh	a0,0(t3)
bfc0439c:	8fbf0034 	lw	ra,52(sp)
bfc043a0:	25ad0001 	addiu	t5,t5,1
bfc043a4:	03e40018 	mult	ra,a0
bfc043a8:	01b4302b 	sltu	a2,t5,s4
bfc043ac:	256b0002 	addiu	t3,t3,2
bfc043b0:	00005012 	mflo	t2
bfc043b4:	ad8a0000 	sw	t2,0(t4)
bfc043b8:	10c0002f 	beqz	a2,bfc04478 <core_bench_matrix+0x408>
bfc043bc:	258c0004 	addiu	t4,t4,4
bfc043c0:	85730000 	lh	s3,0(t3)
bfc043c4:	8fa50034 	lw	a1,52(sp)
bfc043c8:	8fb10034 	lw	s1,52(sp)
bfc043cc:	00b30018 	mult	a1,s3
bfc043d0:	85690002 	lh	t1,2(t3)
bfc043d4:	856a0004 	lh	t2,4(t3)
bfc043d8:	85660006 	lh	a2,6(t3)
bfc043dc:	857e0008 	lh	s8,8(t3)
bfc043e0:	8578000a 	lh	t8,10(t3)
bfc043e4:	8576000c 	lh	s6,12(t3)
bfc043e8:	8575000e 	lh	s5,14(t3)
bfc043ec:	25ad0008 	addiu	t5,t5,8
bfc043f0:	01b4982b 	sltu	s3,t5,s4
bfc043f4:	256b0010 	addiu	t3,t3,16
bfc043f8:	00001012 	mflo	v0
bfc043fc:	ad820000 	sw	v0,0(t4)
bfc04400:	00000000 	nop
bfc04404:	02290018 	mult	s1,t1
bfc04408:	00001812 	mflo	v1
bfc0440c:	ad830004 	sw	v1,4(t4)
bfc04410:	00000000 	nop
bfc04414:	022a0018 	mult	s1,t2
bfc04418:	0000f812 	mflo	ra
bfc0441c:	ad9f0008 	sw	ra,8(t4)
bfc04420:	00000000 	nop
bfc04424:	02260018 	mult	s1,a2
bfc04428:	0000c812 	mflo	t9
bfc0442c:	ad99000c 	sw	t9,12(t4)
bfc04430:	00000000 	nop
bfc04434:	023e0018 	mult	s1,s8
bfc04438:	0000b812 	mflo	s7
bfc0443c:	ad970010 	sw	s7,16(t4)
bfc04440:	00000000 	nop
bfc04444:	02380018 	mult	s1,t8
bfc04448:	00002012 	mflo	a0
bfc0444c:	ad840014 	sw	a0,20(t4)
bfc04450:	00000000 	nop
bfc04454:	02360018 	mult	s1,s6
bfc04458:	00004012 	mflo	t0
bfc0445c:	ad880018 	sw	t0,24(t4)
bfc04460:	00000000 	nop
bfc04464:	02350018 	mult	s1,s5
bfc04468:	00003812 	mflo	a3
bfc0446c:	ad87001c 	sw	a3,28(t4)
bfc04470:	1660ffd3 	bnez	s3,bfc043c0 <core_bench_matrix+0x350>
bfc04474:	258c0020 	addiu	t4,t4,32
bfc04478:	26100001 	addiu	s0,s0,1
bfc0447c:	8fac001c 	lw	t4,28(sp)
bfc04480:	0214582b 	sltu	t3,s0,s4
bfc04484:	01cc7021 	addu	t6,t6,t4
bfc04488:	1560ff79 	bnez	t3,bfc04270 <core_bench_matrix+0x200>
bfc0448c:	01f27821 	addu	t7,t7,s2
bfc04490:	8faf0034 	lw	t7,52(sp)
bfc04494:	240ef000 	li	t6,-4096
bfc04498:	8fab0030 	lw	t3,48(sp)
bfc0449c:	01eef025 	or	s8,t7,t6
bfc044a0:	00003021 	move	a2,zero
bfc044a4:	00001821 	move	v1,zero
bfc044a8:	00002021 	move	a0,zero
bfc044ac:	00006021 	move	t4,zero
bfc044b0:	2687ffff 	addiu	a3,s4,-1
bfc044b4:	30ea0003 	andi	t2,a3,0x3
bfc044b8:	01604021 	move	t0,t3
bfc044bc:	1140003f 	beqz	t2,bfc045bc <core_bench_matrix+0x54c>
bfc044c0:	00004821 	move	t1,zero
bfc044c4:	8d670000 	lw	a3,0(t3)
bfc044c8:	3095ffff 	andi	s5,a0,0xffff
bfc044cc:	0067b02a 	slt	s6,v1,a3
bfc044d0:	00c73021 	addu	a2,a2,a3
bfc044d4:	02b6b821 	addu	s7,s5,s6
bfc044d8:	26b9000a 	addiu	t9,s5,10
bfc044dc:	00199c00 	sll	s3,t9,0x10
bfc044e0:	0017fc00 	sll	ra,s7,0x10
bfc044e4:	03c6282a 	slt	a1,s8,a2
bfc044e8:	00131403 	sra	v0,s3,0x10
bfc044ec:	10a00002 	beqz	a1,bfc044f8 <core_bench_matrix+0x488>
bfc044f0:	001f2403 	sra	a0,ra,0x10
bfc044f4:	00402021 	move	a0,v0
bfc044f8:	10a00002 	beqz	a1,bfc04504 <core_bench_matrix+0x494>
bfc044fc:	24090001 	li	t1,1
bfc04500:	00003021 	move	a2,zero
bfc04504:	0134882b 	sltu	s1,t1,s4
bfc04508:	12200079 	beqz	s1,bfc046f0 <core_bench_matrix+0x680>
bfc0450c:	25680004 	addiu	t0,t3,4
bfc04510:	1149002a 	beq	t2,t1,bfc045bc <core_bench_matrix+0x54c>
bfc04514:	00e01821 	move	v1,a3
bfc04518:	24180002 	li	t8,2
bfc0451c:	11580014 	beq	t2,t8,bfc04570 <core_bench_matrix+0x500>
bfc04520:	308fffff 	andi	t7,a0,0xffff
bfc04524:	8d050000 	lw	a1,0(t0)
bfc04528:	00000000 	nop
bfc0452c:	00c55021 	addu	t2,a2,a1
bfc04530:	00e5302a 	slt	a2,a3,a1
bfc04534:	01e68021 	addu	s0,t7,a2
bfc04538:	25e7000a 	addiu	a3,t7,10
bfc0453c:	00071400 	sll	v0,a3,0x10
bfc04540:	00107400 	sll	t6,s0,0x10
bfc04544:	03ca302a 	slt	a2,s8,t2
bfc04548:	00021403 	sra	v0,v0,0x10
bfc0454c:	10c00002 	beqz	a2,bfc04558 <core_bench_matrix+0x4e8>
bfc04550:	000e2403 	sra	a0,t6,0x10
bfc04554:	00402021 	move	a0,v0
bfc04558:	14c00002 	bnez	a2,bfc04564 <core_bench_matrix+0x4f4>
bfc0455c:	00003021 	move	a2,zero
bfc04560:	01403021 	move	a2,t2
bfc04564:	25290001 	addiu	t1,t1,1
bfc04568:	25080004 	addiu	t0,t0,4
bfc0456c:	00a01821 	move	v1,a1
bfc04570:	8d050000 	lw	a1,0(t0)
bfc04574:	3097ffff 	andi	s7,a0,0xffff
bfc04578:	0065182a 	slt	v1,v1,a1
bfc0457c:	00c53821 	addu	a3,a2,a1
bfc04580:	02e36821 	addu	t5,s7,v1
bfc04584:	26ff000a 	addiu	ra,s7,10
bfc04588:	001f2400 	sll	a0,ra,0x10
bfc0458c:	000d5400 	sll	t2,t5,0x10
bfc04590:	03c7302a 	slt	a2,s8,a3
bfc04594:	00041403 	sra	v0,a0,0x10
bfc04598:	10c00002 	beqz	a2,bfc045a4 <core_bench_matrix+0x534>
bfc0459c:	000a2403 	sra	a0,t2,0x10
bfc045a0:	00402021 	move	a0,v0
bfc045a4:	14c00002 	bnez	a2,bfc045b0 <core_bench_matrix+0x540>
bfc045a8:	00003021 	move	a2,zero
bfc045ac:	00e03021 	move	a2,a3
bfc045b0:	25290001 	addiu	t1,t1,1
bfc045b4:	25080004 	addiu	t0,t0,4
bfc045b8:	00a01821 	move	v1,a1
bfc045bc:	8d070000 	lw	a3,0(t0)
bfc045c0:	3093ffff 	andi	s3,a0,0xffff
bfc045c4:	0067282a 	slt	a1,v1,a3
bfc045c8:	02651821 	addu	v1,s3,a1
bfc045cc:	2662000a 	addiu	v0,s3,10
bfc045d0:	00c73021 	addu	a2,a2,a3
bfc045d4:	00025400 	sll	t2,v0,0x10
bfc045d8:	0003fc00 	sll	ra,v1,0x10
bfc045dc:	03c6282a 	slt	a1,s8,a2
bfc045e0:	000a1403 	sra	v0,t2,0x10
bfc045e4:	10a00002 	beqz	a1,bfc045f0 <core_bench_matrix+0x580>
bfc045e8:	001f2403 	sra	a0,ra,0x10
bfc045ec:	00402021 	move	a0,v0
bfc045f0:	10a00002 	beqz	a1,bfc045fc <core_bench_matrix+0x58c>
bfc045f4:	00000000 	nop
bfc045f8:	00003021 	move	a2,zero
bfc045fc:	25290001 	addiu	t1,t1,1
bfc04600:	0134a82b 	sltu	s5,t1,s4
bfc04604:	12a0003a 	beqz	s5,bfc046f0 <core_bench_matrix+0x680>
bfc04608:	250a0004 	addiu	t2,t0,4
bfc0460c:	8d050004 	lw	a1,4(t0)
bfc04610:	3098ffff 	andi	t8,a0,0xffff
bfc04614:	00e5c82a 	slt	t9,a3,a1
bfc04618:	00c54021 	addu	t0,a2,a1
bfc0461c:	03196821 	addu	t5,t8,t9
bfc04620:	2717000a 	addiu	s7,t8,10
bfc04624:	0017b400 	sll	s6,s7,0x10
bfc04628:	000d8400 	sll	s0,t5,0x10
bfc0462c:	03c8302a 	slt	a2,s8,t0
bfc04630:	00162403 	sra	a0,s6,0x10
bfc04634:	10c00002 	beqz	a2,bfc04640 <core_bench_matrix+0x5d0>
bfc04638:	00101403 	sra	v0,s0,0x10
bfc0463c:	00801021 	move	v0,a0
bfc04640:	14c00002 	bnez	a2,bfc0464c <core_bench_matrix+0x5dc>
bfc04644:	00003821 	move	a3,zero
bfc04648:	01003821 	move	a3,t0
bfc0464c:	8d460004 	lw	a2,4(t2)
bfc04650:	3056ffff 	andi	s6,v0,0xffff
bfc04654:	00a6882a 	slt	s1,a1,a2
bfc04658:	00e63821 	addu	a3,a3,a2
bfc0465c:	02d19821 	addu	s3,s6,s1
bfc04660:	26d5000a 	addiu	s5,s6,10
bfc04664:	0015cc00 	sll	t9,s5,0x10
bfc04668:	00134400 	sll	t0,s3,0x10
bfc0466c:	03c7282a 	slt	a1,s8,a3
bfc04670:	00192403 	sra	a0,t9,0x10
bfc04674:	10a00002 	beqz	a1,bfc04680 <core_bench_matrix+0x610>
bfc04678:	00081403 	sra	v0,t0,0x10
bfc0467c:	00801021 	move	v0,a0
bfc04680:	10a00002 	beqz	a1,bfc0468c <core_bench_matrix+0x61c>
bfc04684:	00000000 	nop
bfc04688:	00003821 	move	a3,zero
bfc0468c:	8d450008 	lw	a1,8(t2)
bfc04690:	304fffff 	andi	t7,v0,0xffff
bfc04694:	00c5682a 	slt	t5,a2,a1
bfc04698:	25e2000a 	addiu	v0,t7,10
bfc0469c:	00e53821 	addu	a3,a3,a1
bfc046a0:	01ed7021 	addu	t6,t7,t5
bfc046a4:	00028400 	sll	s0,v0,0x10
bfc046a8:	000ec400 	sll	t8,t6,0x10
bfc046ac:	03c7302a 	slt	a2,s8,a3
bfc046b0:	00101403 	sra	v0,s0,0x10
bfc046b4:	10c00002 	beqz	a2,bfc046c0 <core_bench_matrix+0x650>
bfc046b8:	00182403 	sra	a0,t8,0x10
bfc046bc:	00402021 	move	a0,v0
bfc046c0:	14c00007 	bnez	a2,bfc046e0 <core_bench_matrix+0x670>
bfc046c4:	00000000 	nop
bfc046c8:	00e03021 	move	a2,a3
bfc046cc:	25290003 	addiu	t1,t1,3
bfc046d0:	2548000c 	addiu	t0,t2,12
bfc046d4:	0bf0116f 	j	bfc045bc <core_bench_matrix+0x54c>
bfc046d8:	00a01821 	move	v1,a1
bfc046dc:	00000000 	nop
bfc046e0:	0bf011b3 	j	bfc046cc <core_bench_matrix+0x65c>
bfc046e4:	00003021 	move	a2,zero
	...
bfc046f0:	258c0001 	addiu	t4,t4,1
bfc046f4:	8fa8001c 	lw	t0,28(sp)
bfc046f8:	0194482b 	sltu	t1,t4,s4
bfc046fc:	11200003 	beqz	t1,bfc0470c <core_bench_matrix+0x69c>
bfc04700:	01685821 	addu	t3,t3,t0
bfc04704:	0bf0112c 	j	bfc044b0 <core_bench_matrix+0x440>
bfc04708:	00e01821 	move	v1,a3
bfc0470c:	0ff01800 	jal	bfc06000 <crc16>
bfc04710:	00002821 	move	a1,zero
bfc04714:	8fb60030 	lw	s6,48(sp)
bfc04718:	8fb5002c 	lw	s5,44(sp)
bfc0471c:	0040f821 	move	ra,v0
bfc04720:	0000b821 	move	s7,zero
bfc04724:	8fae0028 	lw	t6,40(sp)
bfc04728:	86b10000 	lh	s1,0(s5)
bfc0472c:	85c40000 	lh	a0,0(t6)
bfc04730:	24130001 	li	s3,1
bfc04734:	00910018 	mult	a0,s1
bfc04738:	8fab0028 	lw	t3,40(sp)
bfc0473c:	268cffff 	addiu	t4,s4,-1
bfc04740:	0274302b 	sltu	a2,s3,s4
bfc04744:	31830007 	andi	v1,t4,0x7
bfc04748:	26b10002 	addiu	s1,s5,2
bfc0474c:	0000c812 	mflo	t9
bfc04750:	10c0007d 	beqz	a2,bfc04948 <core_bench_matrix+0x8d8>
bfc04754:	25780002 	addiu	t8,t3,2
bfc04758:	10600048 	beqz	v1,bfc0487c <core_bench_matrix+0x80c>
bfc0475c:	00000000 	nop
bfc04760:	1073003c 	beq	v1,s3,bfc04854 <core_bench_matrix+0x7e4>
bfc04764:	240b0002 	li	t3,2
bfc04768:	106b0032 	beq	v1,t3,bfc04834 <core_bench_matrix+0x7c4>
bfc0476c:	24090003 	li	t1,3
bfc04770:	10690028 	beq	v1,t1,bfc04814 <core_bench_matrix+0x7a4>
bfc04774:	24050004 	li	a1,4
bfc04778:	1065001e 	beq	v1,a1,bfc047f4 <core_bench_matrix+0x784>
bfc0477c:	240c0005 	li	t4,5
bfc04780:	106c0014 	beq	v1,t4,bfc047d4 <core_bench_matrix+0x764>
bfc04784:	24070006 	li	a3,6
bfc04788:	1067000a 	beq	v1,a3,bfc047b4 <core_bench_matrix+0x744>
bfc0478c:	00000000 	nop
bfc04790:	8faa0028 	lw	t2,40(sp)
bfc04794:	86280000 	lh	t0,0(s1)
bfc04798:	85580002 	lh	t8,2(t2)
bfc0479c:	24130002 	li	s3,2
bfc047a0:	03080018 	mult	t8,t0
bfc047a4:	26b10004 	addiu	s1,s5,4
bfc047a8:	25580004 	addiu	t8,t2,4
bfc047ac:	00003012 	mflo	a2
bfc047b0:	0326c821 	addu	t9,t9,a2
bfc047b4:	870d0000 	lh	t5,0(t8)
bfc047b8:	86240000 	lh	a0,0(s1)
bfc047bc:	26730001 	addiu	s3,s3,1
bfc047c0:	01a40018 	mult	t5,a0
bfc047c4:	26310002 	addiu	s1,s1,2
bfc047c8:	27180002 	addiu	t8,t8,2
bfc047cc:	00007812 	mflo	t7
bfc047d0:	032fc821 	addu	t9,t9,t7
bfc047d4:	87020000 	lh	v0,0(t8)
bfc047d8:	862e0000 	lh	t6,0(s1)
bfc047dc:	26730001 	addiu	s3,s3,1
bfc047e0:	004e0018 	mult	v0,t6
bfc047e4:	26310002 	addiu	s1,s1,2
bfc047e8:	27180002 	addiu	t8,t8,2
bfc047ec:	00001812 	mflo	v1
bfc047f0:	0323c821 	addu	t9,t9,v1
bfc047f4:	870b0000 	lh	t3,0(t8)
bfc047f8:	86290000 	lh	t1,0(s1)
bfc047fc:	26730001 	addiu	s3,s3,1
bfc04800:	01690018 	mult	t3,t1
bfc04804:	26310002 	addiu	s1,s1,2
bfc04808:	27180002 	addiu	t8,t8,2
bfc0480c:	00008012 	mflo	s0
bfc04810:	0330c821 	addu	t9,t9,s0
bfc04814:	870c0000 	lh	t4,0(t8)
bfc04818:	86270000 	lh	a3,0(s1)
bfc0481c:	26730001 	addiu	s3,s3,1
bfc04820:	01870018 	mult	t4,a3
bfc04824:	26310002 	addiu	s1,s1,2
bfc04828:	27180002 	addiu	t8,t8,2
bfc0482c:	00002812 	mflo	a1
bfc04830:	0325c821 	addu	t9,t9,a1
bfc04834:	870a0000 	lh	t2,0(t8)
bfc04838:	86280000 	lh	t0,0(s1)
bfc0483c:	26730001 	addiu	s3,s3,1
bfc04840:	01480018 	mult	t2,t0
bfc04844:	26310002 	addiu	s1,s1,2
bfc04848:	27180002 	addiu	t8,t8,2
bfc0484c:	00003012 	mflo	a2
bfc04850:	0326c821 	addu	t9,t9,a2
bfc04854:	87040000 	lh	a0,0(t8)
bfc04858:	86230000 	lh	v1,0(s1)
bfc0485c:	26730001 	addiu	s3,s3,1
bfc04860:	00830018 	mult	a0,v1
bfc04864:	0274782b 	sltu	t7,s3,s4
bfc04868:	26310002 	addiu	s1,s1,2
bfc0486c:	27180002 	addiu	t8,t8,2
bfc04870:	00006812 	mflo	t5
bfc04874:	11e00034 	beqz	t7,bfc04948 <core_bench_matrix+0x8d8>
bfc04878:	032dc821 	addu	t9,t9,t5
bfc0487c:	87080000 	lh	t0,0(t8)
bfc04880:	86230000 	lh	v1,0(s1)
bfc04884:	87100002 	lh	s0,2(t8)
bfc04888:	01030018 	mult	t0,v1
bfc0488c:	862a0002 	lh	t2,2(s1)
bfc04890:	87040004 	lh	a0,4(t8)
bfc04894:	862b0004 	lh	t3,4(s1)
bfc04898:	87050006 	lh	a1,6(t8)
bfc0489c:	862c0006 	lh	t4,6(s1)
bfc048a0:	87060008 	lh	a2,8(t8)
bfc048a4:	862d0008 	lh	t5,8(s1)
bfc048a8:	8707000a 	lh	a3,10(t8)
bfc048ac:	862e000a 	lh	t6,10(s1)
bfc048b0:	862f000c 	lh	t7,12(s1)
bfc048b4:	8708000c 	lh	t0,12(t8)
bfc048b8:	8703000e 	lh	v1,14(t8)
bfc048bc:	00001012 	mflo	v0
bfc048c0:	26730008 	addiu	s3,s3,8
bfc048c4:	03221021 	addu	v0,t9,v0
bfc048c8:	27180010 	addiu	t8,t8,16
bfc048cc:	020a0018 	mult	s0,t2
bfc048d0:	8630000e 	lh	s0,14(s1)
bfc048d4:	0274502b 	sltu	t2,s3,s4
bfc048d8:	26310010 	addiu	s1,s1,16
bfc048dc:	00004812 	mflo	t1
bfc048e0:	0049c821 	addu	t9,v0,t1
bfc048e4:	00000000 	nop
bfc048e8:	008b0018 	mult	a0,t3
bfc048ec:	00002012 	mflo	a0
bfc048f0:	03245821 	addu	t3,t9,a0
bfc048f4:	00000000 	nop
bfc048f8:	00ac0018 	mult	a1,t4
bfc048fc:	00006012 	mflo	t4
bfc04900:	016c4821 	addu	t1,t3,t4
bfc04904:	00000000 	nop
bfc04908:	00cd0018 	mult	a2,t5
bfc0490c:	00003012 	mflo	a2
bfc04910:	01261021 	addu	v0,t1,a2
bfc04914:	00000000 	nop
bfc04918:	00ee0018 	mult	a3,t6
bfc0491c:	00002812 	mflo	a1
bfc04920:	00456821 	addu	t5,v0,a1
bfc04924:	00000000 	nop
bfc04928:	010f0018 	mult	t0,t7
bfc0492c:	0000c812 	mflo	t9
bfc04930:	01b97821 	addu	t7,t5,t9
bfc04934:	00000000 	nop
bfc04938:	00700018 	mult	v1,s0
bfc0493c:	00008012 	mflo	s0
bfc04940:	1540ffce 	bnez	t2,bfc0487c <core_bench_matrix+0x80c>
bfc04944:	01f0c821 	addu	t9,t7,s0
bfc04948:	26f70001 	addiu	s7,s7,1
bfc0494c:	02f4c02b 	sltu	t8,s7,s4
bfc04950:	aed90000 	sw	t9,0(s6)
bfc04954:	02b2a821 	addu	s5,s5,s2
bfc04958:	1700ff72 	bnez	t8,bfc04724 <core_bench_matrix+0x6b4>
bfc0495c:	26d60004 	addiu	s6,s6,4
bfc04960:	8fab0030 	lw	t3,48(sp)
bfc04964:	00003021 	move	a2,zero
bfc04968:	00001821 	move	v1,zero
bfc0496c:	00002021 	move	a0,zero
bfc04970:	00006021 	move	t4,zero
bfc04974:	2687ffff 	addiu	a3,s4,-1
bfc04978:	30ea0003 	andi	t2,a3,0x3
bfc0497c:	01604021 	move	t0,t3
bfc04980:	1140003f 	beqz	t2,bfc04a80 <core_bench_matrix+0xa10>
bfc04984:	00004821 	move	t1,zero
bfc04988:	8d670000 	lw	a3,0(t3)
bfc0498c:	3095ffff 	andi	s5,a0,0xffff
bfc04990:	0067b02a 	slt	s6,v1,a3
bfc04994:	00c73021 	addu	a2,a2,a3
bfc04998:	02b6c021 	addu	t8,s5,s6
bfc0499c:	26b9000a 	addiu	t9,s5,10
bfc049a0:	00199c00 	sll	s3,t9,0x10
bfc049a4:	0018bc00 	sll	s7,t8,0x10
bfc049a8:	03c6282a 	slt	a1,s8,a2
bfc049ac:	00131403 	sra	v0,s3,0x10
bfc049b0:	10a00002 	beqz	a1,bfc049bc <core_bench_matrix+0x94c>
bfc049b4:	00172403 	sra	a0,s7,0x10
bfc049b8:	00402021 	move	a0,v0
bfc049bc:	10a00002 	beqz	a1,bfc049c8 <core_bench_matrix+0x958>
bfc049c0:	24090001 	li	t1,1
bfc049c4:	00003021 	move	a2,zero
bfc049c8:	0134782b 	sltu	t7,t1,s4
bfc049cc:	11e00078 	beqz	t7,bfc04bb0 <core_bench_matrix+0xb40>
bfc049d0:	25680004 	addiu	t0,t3,4
bfc049d4:	1149002a 	beq	t2,t1,bfc04a80 <core_bench_matrix+0xa10>
bfc049d8:	00e01821 	move	v1,a3
bfc049dc:	240d0002 	li	t5,2
bfc049e0:	114d0014 	beq	t2,t5,bfc04a34 <core_bench_matrix+0x9c4>
bfc049e4:	308effff 	andi	t6,a0,0xffff
bfc049e8:	8d050000 	lw	a1,0(t0)
bfc049ec:	00000000 	nop
bfc049f0:	00c55021 	addu	t2,a2,a1
bfc049f4:	00e5302a 	slt	a2,a3,a1
bfc049f8:	01c61821 	addu	v1,t6,a2
bfc049fc:	25c2000a 	addiu	v0,t6,10
bfc04a00:	00022400 	sll	a0,v0,0x10
bfc04a04:	00033c00 	sll	a3,v1,0x10
bfc04a08:	03ca302a 	slt	a2,s8,t2
bfc04a0c:	00041403 	sra	v0,a0,0x10
bfc04a10:	10c00002 	beqz	a2,bfc04a1c <core_bench_matrix+0x9ac>
bfc04a14:	00072403 	sra	a0,a3,0x10
bfc04a18:	00402021 	move	a0,v0
bfc04a1c:	14c00002 	bnez	a2,bfc04a28 <core_bench_matrix+0x9b8>
bfc04a20:	00003021 	move	a2,zero
bfc04a24:	01403021 	move	a2,t2
bfc04a28:	25290001 	addiu	t1,t1,1
bfc04a2c:	25080004 	addiu	t0,t0,4
bfc04a30:	00a01821 	move	v1,a1
bfc04a34:	8d050000 	lw	a1,0(t0)
bfc04a38:	3098ffff 	andi	t8,a0,0xffff
bfc04a3c:	0065982a 	slt	s3,v1,a1
bfc04a40:	00c53821 	addu	a3,a2,a1
bfc04a44:	03138021 	addu	s0,t8,s3
bfc04a48:	2717000a 	addiu	s7,t8,10
bfc04a4c:	00178c00 	sll	s1,s7,0x10
bfc04a50:	00105400 	sll	t2,s0,0x10
bfc04a54:	03c7302a 	slt	a2,s8,a3
bfc04a58:	00111403 	sra	v0,s1,0x10
bfc04a5c:	10c00002 	beqz	a2,bfc04a68 <core_bench_matrix+0x9f8>
bfc04a60:	000a2403 	sra	a0,t2,0x10
bfc04a64:	00402021 	move	a0,v0
bfc04a68:	14c00002 	bnez	a2,bfc04a74 <core_bench_matrix+0xa04>
bfc04a6c:	00003021 	move	a2,zero
bfc04a70:	00e03021 	move	a2,a3
bfc04a74:	25290001 	addiu	t1,t1,1
bfc04a78:	25080004 	addiu	t0,t0,4
bfc04a7c:	00a01821 	move	v1,a1
bfc04a80:	8d070000 	lw	a3,0(t0)
bfc04a84:	3085ffff 	andi	a1,a0,0xffff
bfc04a88:	0067102a 	slt	v0,v1,a3
bfc04a8c:	00a26821 	addu	t5,a1,v0
bfc04a90:	24a4000a 	addiu	a0,a1,10
bfc04a94:	00c73021 	addu	a2,a2,a3
bfc04a98:	0004cc00 	sll	t9,a0,0x10
bfc04a9c:	000d7400 	sll	t6,t5,0x10
bfc04aa0:	03c6282a 	slt	a1,s8,a2
bfc04aa4:	00191403 	sra	v0,t9,0x10
bfc04aa8:	10a00002 	beqz	a1,bfc04ab4 <core_bench_matrix+0xa44>
bfc04aac:	000e2403 	sra	a0,t6,0x10
bfc04ab0:	00402021 	move	a0,v0
bfc04ab4:	10a00002 	beqz	a1,bfc04ac0 <core_bench_matrix+0xa50>
bfc04ab8:	00000000 	nop
bfc04abc:	00003021 	move	a2,zero
bfc04ac0:	25290001 	addiu	t1,t1,1
bfc04ac4:	0134802b 	sltu	s0,t1,s4
bfc04ac8:	12000039 	beqz	s0,bfc04bb0 <core_bench_matrix+0xb40>
bfc04acc:	250a0004 	addiu	t2,t0,4
bfc04ad0:	8d050004 	lw	a1,4(t0)
bfc04ad4:	3091ffff 	andi	s1,a0,0xffff
bfc04ad8:	00e5782a 	slt	t7,a3,a1
bfc04adc:	00c54021 	addu	t0,a2,a1
bfc04ae0:	022fb821 	addu	s7,s1,t7
bfc04ae4:	2635000a 	addiu	s5,s1,10
bfc04ae8:	00159c00 	sll	s3,s5,0x10
bfc04aec:	0017b400 	sll	s6,s7,0x10
bfc04af0:	03c8302a 	slt	a2,s8,t0
bfc04af4:	00132403 	sra	a0,s3,0x10
bfc04af8:	10c00002 	beqz	a2,bfc04b04 <core_bench_matrix+0xa94>
bfc04afc:	00161403 	sra	v0,s6,0x10
bfc04b00:	00801021 	move	v0,a0
bfc04b04:	14c00002 	bnez	a2,bfc04b10 <core_bench_matrix+0xaa0>
bfc04b08:	00003821 	move	a3,zero
bfc04b0c:	01003821 	move	a3,t0
bfc04b10:	8d460004 	lw	a2,4(t2)
bfc04b14:	304fffff 	andi	t7,v0,0xffff
bfc04b18:	00a6682a 	slt	t5,a1,a2
bfc04b1c:	00e63821 	addu	a3,a3,a2
bfc04b20:	01edc821 	addu	t9,t7,t5
bfc04b24:	25f6000a 	addiu	s6,t7,10
bfc04b28:	0016ac00 	sll	s5,s6,0x10
bfc04b2c:	00194400 	sll	t0,t9,0x10
bfc04b30:	03c7282a 	slt	a1,s8,a3
bfc04b34:	00152403 	sra	a0,s5,0x10
bfc04b38:	10a00002 	beqz	a1,bfc04b44 <core_bench_matrix+0xad4>
bfc04b3c:	00081403 	sra	v0,t0,0x10
bfc04b40:	00801021 	move	v0,a0
bfc04b44:	10a00002 	beqz	a1,bfc04b50 <core_bench_matrix+0xae0>
bfc04b48:	00000000 	nop
bfc04b4c:	00003821 	move	a3,zero
bfc04b50:	8d450008 	lw	a1,8(t2)
bfc04b54:	3050ffff 	andi	s0,v0,0xffff
bfc04b58:	00c5882a 	slt	s1,a2,a1
bfc04b5c:	00e53821 	addu	a3,a3,a1
bfc04b60:	02111821 	addu	v1,s0,s1
bfc04b64:	260e000a 	addiu	t6,s0,10
bfc04b68:	000e1400 	sll	v0,t6,0x10
bfc04b6c:	00032400 	sll	a0,v1,0x10
bfc04b70:	03c7302a 	slt	a2,s8,a3
bfc04b74:	00021403 	sra	v0,v0,0x10
bfc04b78:	10c00002 	beqz	a2,bfc04b84 <core_bench_matrix+0xb14>
bfc04b7c:	00042403 	sra	a0,a0,0x10
bfc04b80:	00402021 	move	a0,v0
bfc04b84:	14c00006 	bnez	a2,bfc04ba0 <core_bench_matrix+0xb30>
bfc04b88:	00000000 	nop
bfc04b8c:	00e03021 	move	a2,a3
bfc04b90:	25290003 	addiu	t1,t1,3
bfc04b94:	2548000c 	addiu	t0,t2,12
bfc04b98:	0bf012a0 	j	bfc04a80 <core_bench_matrix+0xa10>
bfc04b9c:	00a01821 	move	v1,a1
bfc04ba0:	0bf012e4 	j	bfc04b90 <core_bench_matrix+0xb20>
bfc04ba4:	00003021 	move	a2,zero
	...
bfc04bb0:	258c0001 	addiu	t4,t4,1
bfc04bb4:	8faa001c 	lw	t2,28(sp)
bfc04bb8:	0194482b 	sltu	t1,t4,s4
bfc04bbc:	11200003 	beqz	t1,bfc04bcc <core_bench_matrix+0xb5c>
bfc04bc0:	016a5821 	addu	t3,t3,t2
bfc04bc4:	0bf0125d 	j	bfc04974 <core_bench_matrix+0x904>
bfc04bc8:	00e01821 	move	v1,a3
bfc04bcc:	03e02821 	move	a1,ra
bfc04bd0:	0ff01800 	jal	bfc06000 <crc16>
bfc04bd4:	00000000 	nop
bfc04bd8:	8fa60030 	lw	a2,48(sp)
bfc04bdc:	8fb6002c 	lw	s6,44(sp)
bfc04be0:	afa20018 	sw	v0,24(sp)
bfc04be4:	afa60014 	sw	a2,20(sp)
bfc04be8:	afa00024 	sw	zero,36(sp)
bfc04bec:	8fb70014 	lw	s7,20(sp)
bfc04bf0:	8fb30028 	lw	s3,40(sp)
bfc04bf4:	0000a821 	move	s5,zero
bfc04bf8:	86df0000 	lh	ra,0(s6)
bfc04bfc:	86680000 	lh	t0,0(s3)
bfc04c00:	24190001 	li	t9,1
bfc04c04:	011f0018 	mult	t0,ra
bfc04c08:	268bffff 	addiu	t3,s4,-1
bfc04c0c:	0334602b 	sltu	t4,t9,s4
bfc04c10:	31630007 	andi	v1,t3,0x7
bfc04c14:	26d80002 	addiu	t8,s6,2
bfc04c18:	0000f812 	mflo	ra
bfc04c1c:	11800084 	beqz	t4,bfc04e30 <core_bench_matrix+0xdc0>
bfc04c20:	02725021 	addu	t2,s3,s2
bfc04c24:	10600047 	beqz	v1,bfc04d44 <core_bench_matrix+0xcd4>
bfc04c28:	00000000 	nop
bfc04c2c:	1079003b 	beq	v1,t9,bfc04d1c <core_bench_matrix+0xcac>
bfc04c30:	240b0002 	li	t3,2
bfc04c34:	106b0031 	beq	v1,t3,bfc04cfc <core_bench_matrix+0xc8c>
bfc04c38:	24090003 	li	t1,3
bfc04c3c:	10690027 	beq	v1,t1,bfc04cdc <core_bench_matrix+0xc6c>
bfc04c40:	24050004 	li	a1,4
bfc04c44:	1065001d 	beq	v1,a1,bfc04cbc <core_bench_matrix+0xc4c>
bfc04c48:	240c0005 	li	t4,5
bfc04c4c:	106c0013 	beq	v1,t4,bfc04c9c <core_bench_matrix+0xc2c>
bfc04c50:	24070006 	li	a3,6
bfc04c54:	10670009 	beq	v1,a3,bfc04c7c <core_bench_matrix+0xc0c>
bfc04c58:	00000000 	nop
bfc04c5c:	87020000 	lh	v0,0(t8)
bfc04c60:	85440000 	lh	a0,0(t2)
bfc04c64:	24190002 	li	t9,2
bfc04c68:	00820018 	mult	a0,v0
bfc04c6c:	01525021 	addu	t2,t2,s2
bfc04c70:	26d80004 	addiu	t8,s6,4
bfc04c74:	00003012 	mflo	a2
bfc04c78:	03e6f821 	addu	ra,ra,a2
bfc04c7c:	854e0000 	lh	t6,0(t2)
bfc04c80:	87100000 	lh	s0,0(t8)
bfc04c84:	27390001 	addiu	t9,t9,1
bfc04c88:	01d00018 	mult	t6,s0
bfc04c8c:	27180002 	addiu	t8,t8,2
bfc04c90:	01525021 	addu	t2,t2,s2
bfc04c94:	00004012 	mflo	t0
bfc04c98:	03e8f821 	addu	ra,ra,t0
bfc04c9c:	854f0000 	lh	t7,0(t2)
bfc04ca0:	870d0000 	lh	t5,0(t8)
bfc04ca4:	27390001 	addiu	t9,t9,1
bfc04ca8:	01ed0018 	mult	t7,t5
bfc04cac:	27180002 	addiu	t8,t8,2
bfc04cb0:	01525021 	addu	t2,t2,s2
bfc04cb4:	00008812 	mflo	s1
bfc04cb8:	03f1f821 	addu	ra,ra,s1
bfc04cbc:	854b0000 	lh	t3,0(t2)
bfc04cc0:	87090000 	lh	t1,0(t8)
bfc04cc4:	27390001 	addiu	t9,t9,1
bfc04cc8:	01690018 	mult	t3,t1
bfc04ccc:	27180002 	addiu	t8,t8,2
bfc04cd0:	01525021 	addu	t2,t2,s2
bfc04cd4:	00001812 	mflo	v1
bfc04cd8:	03e3f821 	addu	ra,ra,v1
bfc04cdc:	854c0000 	lh	t4,0(t2)
bfc04ce0:	87070000 	lh	a3,0(t8)
bfc04ce4:	27390001 	addiu	t9,t9,1
bfc04ce8:	01870018 	mult	t4,a3
bfc04cec:	27180002 	addiu	t8,t8,2
bfc04cf0:	01525021 	addu	t2,t2,s2
bfc04cf4:	00002812 	mflo	a1
bfc04cf8:	03e5f821 	addu	ra,ra,a1
bfc04cfc:	85440000 	lh	a0,0(t2)
bfc04d00:	87020000 	lh	v0,0(t8)
bfc04d04:	27390001 	addiu	t9,t9,1
bfc04d08:	00820018 	mult	a0,v0
bfc04d0c:	27180002 	addiu	t8,t8,2
bfc04d10:	01525021 	addu	t2,t2,s2
bfc04d14:	00003012 	mflo	a2
bfc04d18:	03e6f821 	addu	ra,ra,a2
bfc04d1c:	85500000 	lh	s0,0(t2)
bfc04d20:	87110000 	lh	s1,0(t8)
bfc04d24:	27390001 	addiu	t9,t9,1
bfc04d28:	02110018 	mult	s0,s1
bfc04d2c:	0334402b 	sltu	t0,t9,s4
bfc04d30:	27180002 	addiu	t8,t8,2
bfc04d34:	01525021 	addu	t2,t2,s2
bfc04d38:	00007012 	mflo	t6
bfc04d3c:	1100003c 	beqz	t0,bfc04e30 <core_bench_matrix+0xdc0>
bfc04d40:	03eef821 	addu	ra,ra,t6
bfc04d44:	854f0000 	lh	t7,0(t2)
bfc04d48:	87080000 	lh	t0,0(t8)
bfc04d4c:	01523821 	addu	a3,t2,s2
bfc04d50:	01e80018 	mult	t7,t0
bfc04d54:	870d0002 	lh	t5,2(t8)
bfc04d58:	84ec0000 	lh	t4,0(a3)
bfc04d5c:	00f27021 	addu	t6,a3,s2
bfc04d60:	87110004 	lh	s1,4(t8)
bfc04d64:	85c90000 	lh	t1,0(t6)
bfc04d68:	01d23021 	addu	a2,t6,s2
bfc04d6c:	87100006 	lh	s0,6(t8)
bfc04d70:	84c80000 	lh	t0,0(a2)
bfc04d74:	00d22021 	addu	a0,a2,s2
bfc04d78:	870f0008 	lh	t7,8(t8)
bfc04d7c:	84870000 	lh	a3,0(a0)
bfc04d80:	00922821 	addu	a1,a0,s2
bfc04d84:	00001012 	mflo	v0
bfc04d88:	870e000a 	lh	t6,10(t8)
bfc04d8c:	03e21021 	addu	v0,ra,v0
bfc04d90:	84a60000 	lh	a2,0(a1)
bfc04d94:	018d0018 	mult	t4,t5
bfc04d98:	00b21821 	addu	v1,a1,s2
bfc04d9c:	870c000c 	lh	t4,12(t8)
bfc04da0:	84640000 	lh	a0,0(v1)
bfc04da4:	00725021 	addu	t2,v1,s2
bfc04da8:	85430000 	lh	v1,0(t2)
bfc04dac:	870d000e 	lh	t5,14(t8)
bfc04db0:	27390008 	addiu	t9,t9,8
bfc04db4:	0334282b 	sltu	a1,t9,s4
bfc04db8:	27180010 	addiu	t8,t8,16
bfc04dbc:	01525021 	addu	t2,t2,s2
bfc04dc0:	00005812 	mflo	t3
	...
bfc04dcc:	01310018 	mult	t1,s1
bfc04dd0:	004b8821 	addu	s1,v0,t3
bfc04dd4:	00004812 	mflo	t1
bfc04dd8:	02295821 	addu	t3,s1,t1
bfc04ddc:	00000000 	nop
bfc04de0:	01100018 	mult	t0,s0
bfc04de4:	0000f812 	mflo	ra
bfc04de8:	017f4821 	addu	t1,t3,ra
bfc04dec:	00000000 	nop
bfc04df0:	00ef0018 	mult	a3,t7
bfc04df4:	00003812 	mflo	a3
bfc04df8:	01271021 	addu	v0,t1,a3
bfc04dfc:	00000000 	nop
bfc04e00:	00ce0018 	mult	a2,t6
bfc04e04:	00008012 	mflo	s0
bfc04e08:	00507821 	addu	t7,v0,s0
bfc04e0c:	00000000 	nop
bfc04e10:	008c0018 	mult	a0,t4
bfc04e14:	00007012 	mflo	t6
bfc04e18:	01ee8821 	addu	s1,t7,t6
bfc04e1c:	00000000 	nop
bfc04e20:	006d0018 	mult	v1,t5
bfc04e24:	00001812 	mflo	v1
bfc04e28:	14a0ffc6 	bnez	a1,bfc04d44 <core_bench_matrix+0xcd4>
bfc04e2c:	0223f821 	addu	ra,s1,v1
bfc04e30:	26b50001 	addiu	s5,s5,1
bfc04e34:	02b4c02b 	sltu	t8,s5,s4
bfc04e38:	aeff0000 	sw	ra,0(s7)
bfc04e3c:	26730002 	addiu	s3,s3,2
bfc04e40:	1700ff6d 	bnez	t8,bfc04bf8 <core_bench_matrix+0xb88>
bfc04e44:	26f70004 	addiu	s7,s7,4
bfc04e48:	8fb00024 	lw	s0,36(sp)
bfc04e4c:	8fb50014 	lw	s5,20(sp)
bfc04e50:	8fb9001c 	lw	t9,28(sp)
bfc04e54:	261f0001 	addiu	ra,s0,1
bfc04e58:	02b99821 	addu	s3,s5,t9
bfc04e5c:	03f4b82b 	sltu	s7,ra,s4
bfc04e60:	afbf0024 	sw	ra,36(sp)
bfc04e64:	02d2b021 	addu	s6,s6,s2
bfc04e68:	16e0ff60 	bnez	s7,bfc04bec <core_bench_matrix+0xb7c>
bfc04e6c:	afb30014 	sw	s3,20(sp)
bfc04e70:	8fab0030 	lw	t3,48(sp)
bfc04e74:	00003021 	move	a2,zero
bfc04e78:	00001821 	move	v1,zero
bfc04e7c:	00002021 	move	a0,zero
bfc04e80:	00006021 	move	t4,zero
bfc04e84:	2687ffff 	addiu	a3,s4,-1
bfc04e88:	30ea0003 	andi	t2,a3,0x3
bfc04e8c:	01604021 	move	t0,t3
bfc04e90:	1140003f 	beqz	t2,bfc04f90 <core_bench_matrix+0xf20>
bfc04e94:	00004821 	move	t1,zero
bfc04e98:	8d670000 	lw	a3,0(t3)
bfc04e9c:	3090ffff 	andi	s0,a0,0xffff
bfc04ea0:	0067c82a 	slt	t9,v1,a3
bfc04ea4:	00c73021 	addu	a2,a2,a3
bfc04ea8:	0219c021 	addu	t8,s0,t9
bfc04eac:	2613000a 	addiu	s3,s0,10
bfc04eb0:	00137400 	sll	t6,s3,0x10
bfc04eb4:	0018bc00 	sll	s7,t8,0x10
bfc04eb8:	03c6282a 	slt	a1,s8,a2
bfc04ebc:	000e1403 	sra	v0,t6,0x10
bfc04ec0:	10a00002 	beqz	a1,bfc04ecc <core_bench_matrix+0xe5c>
bfc04ec4:	00172403 	sra	a0,s7,0x10
bfc04ec8:	00402021 	move	a0,v0
bfc04ecc:	10a00002 	beqz	a1,bfc04ed8 <core_bench_matrix+0xe68>
bfc04ed0:	24090001 	li	t1,1
bfc04ed4:	00003021 	move	a2,zero
bfc04ed8:	0134882b 	sltu	s1,t1,s4
bfc04edc:	12200078 	beqz	s1,bfc050c0 <core_bench_matrix+0x1050>
bfc04ee0:	25680004 	addiu	t0,t3,4
bfc04ee4:	1149002a 	beq	t2,t1,bfc04f90 <core_bench_matrix+0xf20>
bfc04ee8:	00e01821 	move	v1,a3
bfc04eec:	24150002 	li	s5,2
bfc04ef0:	11550014 	beq	t2,s5,bfc04f44 <core_bench_matrix+0xed4>
bfc04ef4:	309fffff 	andi	ra,a0,0xffff
bfc04ef8:	8d050000 	lw	a1,0(t0)
bfc04efc:	00000000 	nop
bfc04f00:	00c55021 	addu	t2,a2,a1
bfc04f04:	00e5302a 	slt	a2,a3,a1
bfc04f08:	03e67821 	addu	t7,ra,a2
bfc04f0c:	27e7000a 	addiu	a3,ra,10
bfc04f10:	00076c00 	sll	t5,a3,0x10
bfc04f14:	000fb400 	sll	s6,t7,0x10
bfc04f18:	03ca302a 	slt	a2,s8,t2
bfc04f1c:	000d1403 	sra	v0,t5,0x10
bfc04f20:	10c00002 	beqz	a2,bfc04f2c <core_bench_matrix+0xebc>
bfc04f24:	00162403 	sra	a0,s6,0x10
bfc04f28:	00402021 	move	a0,v0
bfc04f2c:	14c00002 	bnez	a2,bfc04f38 <core_bench_matrix+0xec8>
bfc04f30:	00003021 	move	a2,zero
bfc04f34:	01403021 	move	a2,t2
bfc04f38:	25290001 	addiu	t1,t1,1
bfc04f3c:	25080004 	addiu	t0,t0,4
bfc04f40:	00a01821 	move	v1,a1
bfc04f44:	8d050000 	lw	a1,0(t0)
bfc04f48:	3097ffff 	andi	s7,a0,0xffff
bfc04f4c:	0065c02a 	slt	t8,v1,a1
bfc04f50:	26e2000a 	addiu	v0,s7,10
bfc04f54:	00c53821 	addu	a3,a2,a1
bfc04f58:	02f81821 	addu	v1,s7,t8
bfc04f5c:	00022400 	sll	a0,v0,0x10
bfc04f60:	00035400 	sll	t2,v1,0x10
bfc04f64:	03c7302a 	slt	a2,s8,a3
bfc04f68:	00041403 	sra	v0,a0,0x10
bfc04f6c:	10c00002 	beqz	a2,bfc04f78 <core_bench_matrix+0xf08>
bfc04f70:	000a2403 	sra	a0,t2,0x10
bfc04f74:	00402021 	move	a0,v0
bfc04f78:	14c00002 	bnez	a2,bfc04f84 <core_bench_matrix+0xf14>
bfc04f7c:	00003021 	move	a2,zero
bfc04f80:	00e03021 	move	a2,a3
bfc04f84:	25290001 	addiu	t1,t1,1
bfc04f88:	25080004 	addiu	t0,t0,4
bfc04f8c:	00a01821 	move	v1,a1
bfc04f90:	8d070000 	lw	a3,0(t0)
bfc04f94:	3085ffff 	andi	a1,a0,0xffff
bfc04f98:	0067b82a 	slt	s7,v1,a3
bfc04f9c:	00b72021 	addu	a0,a1,s7
bfc04fa0:	24b8000a 	addiu	t8,a1,10
bfc04fa4:	00c73021 	addu	a2,a2,a3
bfc04fa8:	00187c00 	sll	t7,t8,0x10
bfc04fac:	00045400 	sll	t2,a0,0x10
bfc04fb0:	03c6282a 	slt	a1,s8,a2
bfc04fb4:	000f1403 	sra	v0,t7,0x10
bfc04fb8:	10a00002 	beqz	a1,bfc04fc4 <core_bench_matrix+0xf54>
bfc04fbc:	000a2403 	sra	a0,t2,0x10
bfc04fc0:	00402021 	move	a0,v0
bfc04fc4:	10a00002 	beqz	a1,bfc04fd0 <core_bench_matrix+0xf60>
bfc04fc8:	00000000 	nop
bfc04fcc:	00003021 	move	a2,zero
bfc04fd0:	25290001 	addiu	t1,t1,1
bfc04fd4:	0134982b 	sltu	s3,t1,s4
bfc04fd8:	12600039 	beqz	s3,bfc050c0 <core_bench_matrix+0x1050>
bfc04fdc:	250a0004 	addiu	t2,t0,4
bfc04fe0:	8d050004 	lw	a1,4(t0)
bfc04fe4:	308effff 	andi	t6,a0,0xffff
bfc04fe8:	00e5182a 	slt	v1,a3,a1
bfc04fec:	25c2000a 	addiu	v0,t6,10
bfc04ff0:	00c54021 	addu	t0,a2,a1
bfc04ff4:	01c38821 	addu	s1,t6,v1
bfc04ff8:	00026c00 	sll	t5,v0,0x10
bfc04ffc:	0011b400 	sll	s6,s1,0x10
bfc05000:	03c8302a 	slt	a2,s8,t0
bfc05004:	000d2403 	sra	a0,t5,0x10
bfc05008:	10c00002 	beqz	a2,bfc05014 <core_bench_matrix+0xfa4>
bfc0500c:	00161403 	sra	v0,s6,0x10
bfc05010:	00801021 	move	v0,a0
bfc05014:	14c00002 	bnez	a2,bfc05020 <core_bench_matrix+0xfb0>
bfc05018:	00003821 	move	a3,zero
bfc0501c:	01003821 	move	a3,t0
bfc05020:	8d460004 	lw	a2,4(t2)
bfc05024:	3059ffff 	andi	t9,v0,0xffff
bfc05028:	00a6882a 	slt	s1,a1,a2
bfc0502c:	00e63821 	addu	a3,a3,a2
bfc05030:	03317021 	addu	t6,t9,s1
bfc05034:	2730000a 	addiu	s0,t9,10
bfc05038:	00109c00 	sll	s3,s0,0x10
bfc0503c:	000e4400 	sll	t0,t6,0x10
bfc05040:	03c7282a 	slt	a1,s8,a3
bfc05044:	00132403 	sra	a0,s3,0x10
bfc05048:	10a00002 	beqz	a1,bfc05054 <core_bench_matrix+0xfe4>
bfc0504c:	00081403 	sra	v0,t0,0x10
bfc05050:	00801021 	move	v0,a0
bfc05054:	10a00002 	beqz	a1,bfc05060 <core_bench_matrix+0xff0>
bfc05058:	00000000 	nop
bfc0505c:	00003821 	move	a3,zero
bfc05060:	8d450008 	lw	a1,8(t2)
bfc05064:	305fffff 	andi	ra,v0,0xffff
bfc05068:	00c5182a 	slt	v1,a2,a1
bfc0506c:	00e53821 	addu	a3,a3,a1
bfc05070:	03e3b021 	addu	s6,ra,v1
bfc05074:	27ed000a 	addiu	t5,ra,10
bfc05078:	000d7c00 	sll	t7,t5,0x10
bfc0507c:	0016ac00 	sll	s5,s6,0x10
bfc05080:	03c7302a 	slt	a2,s8,a3
bfc05084:	000f1403 	sra	v0,t7,0x10
bfc05088:	10c00002 	beqz	a2,bfc05094 <core_bench_matrix+0x1024>
bfc0508c:	00152403 	sra	a0,s5,0x10
bfc05090:	00402021 	move	a0,v0
bfc05094:	14c00006 	bnez	a2,bfc050b0 <core_bench_matrix+0x1040>
bfc05098:	00000000 	nop
bfc0509c:	00e03021 	move	a2,a3
bfc050a0:	25290003 	addiu	t1,t1,3
bfc050a4:	2548000c 	addiu	t0,t2,12
bfc050a8:	0bf013e4 	j	bfc04f90 <core_bench_matrix+0xf20>
bfc050ac:	00a01821 	move	v1,a1
bfc050b0:	0bf01428 	j	bfc050a0 <core_bench_matrix+0x1030>
bfc050b4:	00003021 	move	a2,zero
	...
bfc050c0:	258c0001 	addiu	t4,t4,1
bfc050c4:	8fa8001c 	lw	t0,28(sp)
bfc050c8:	0194482b 	sltu	t1,t4,s4
bfc050cc:	11200003 	beqz	t1,bfc050dc <core_bench_matrix+0x106c>
bfc050d0:	01685821 	addu	t3,t3,t0
bfc050d4:	0bf013a1 	j	bfc04e84 <core_bench_matrix+0xe14>
bfc050d8:	00e01821 	move	v1,a3
bfc050dc:	8fa50018 	lw	a1,24(sp)
bfc050e0:	0ff01800 	jal	bfc06000 <crc16>
bfc050e4:	0000b021 	move	s6,zero
bfc050e8:	8fb3002c 	lw	s3,44(sp)
bfc050ec:	8fb50030 	lw	s5,48(sp)
bfc050f0:	0040b821 	move	s7,v0
bfc050f4:	8fb10028 	lw	s1,40(sp)
bfc050f8:	02a0c021 	move	t8,s5
bfc050fc:	0000c821 	move	t9,zero
bfc05100:	862e0000 	lh	t6,0(s1)
bfc05104:	86630000 	lh	v1,0(s3)
bfc05108:	240f0001 	li	t7,1
bfc0510c:	01c30018 	mult	t6,v1
bfc05110:	268dffff 	addiu	t5,s4,-1
bfc05114:	01f4582b 	sltu	t3,t7,s4
bfc05118:	31a40003 	andi	a0,t5,0x3
bfc0511c:	02327021 	addu	t6,s1,s2
bfc05120:	00001012 	mflo	v0
bfc05124:	00028143 	sra	s0,v0,0x5
bfc05128:	0002f883 	sra	ra,v0,0x2
bfc0512c:	320c007f 	andi	t4,s0,0x7f
bfc05130:	33e6000f 	andi	a2,ra,0xf
bfc05134:	01860018 	mult	t4,a2
bfc05138:	00008012 	mflo	s0
bfc0513c:	1160006a 	beqz	t3,bfc052e8 <core_bench_matrix+0x1278>
bfc05140:	266d0002 	addiu	t5,s3,2
bfc05144:	10800031 	beqz	a0,bfc0520c <core_bench_matrix+0x119c>
bfc05148:	00000000 	nop
bfc0514c:	108f001f 	beq	a0,t7,bfc051cc <core_bench_matrix+0x115c>
bfc05150:	240b0002 	li	t3,2
bfc05154:	108b000f 	beq	a0,t3,bfc05194 <core_bench_matrix+0x1124>
bfc05158:	00000000 	nop
bfc0515c:	85af0000 	lh	t7,0(t5)
bfc05160:	85cd0000 	lh	t5,0(t6)
bfc05164:	01d27021 	addu	t6,t6,s2
bfc05168:	01af0018 	mult	t5,t7
bfc0516c:	240f0002 	li	t7,2
bfc05170:	266d0004 	addiu	t5,s3,4
bfc05174:	00004012 	mflo	t0
bfc05178:	00085083 	sra	t2,t0,0x2
bfc0517c:	00083143 	sra	a2,t0,0x5
bfc05180:	30c7007f 	andi	a3,a2,0x7f
bfc05184:	3145000f 	andi	a1,t2,0xf
bfc05188:	00e50018 	mult	a3,a1
bfc0518c:	00004812 	mflo	t1
bfc05190:	02098021 	addu	s0,s0,t1
bfc05194:	85c90000 	lh	t1,0(t6)
bfc05198:	85a50000 	lh	a1,0(t5)
bfc0519c:	25ef0001 	addiu	t7,t7,1
bfc051a0:	01250018 	mult	t1,a1
bfc051a4:	25ad0002 	addiu	t5,t5,2
bfc051a8:	01d27021 	addu	t6,t6,s2
bfc051ac:	00005812 	mflo	t3
bfc051b0:	000b2083 	sra	a0,t3,0x2
bfc051b4:	000b1143 	sra	v0,t3,0x5
bfc051b8:	305f007f 	andi	ra,v0,0x7f
bfc051bc:	3083000f 	andi	v1,a0,0xf
bfc051c0:	03e30018 	mult	ra,v1
bfc051c4:	00006012 	mflo	t4
bfc051c8:	020c8021 	addu	s0,s0,t4
bfc051cc:	85c40000 	lh	a0,0(t6)
bfc051d0:	85a20000 	lh	v0,0(t5)
bfc051d4:	25ef0001 	addiu	t7,t7,1
bfc051d8:	00820018 	mult	a0,v0
bfc051dc:	01f4382b 	sltu	a3,t7,s4
bfc051e0:	25ad0002 	addiu	t5,t5,2
bfc051e4:	01d27021 	addu	t6,t6,s2
bfc051e8:	00001812 	mflo	v1
bfc051ec:	00036083 	sra	t4,v1,0x2
bfc051f0:	0003f943 	sra	ra,v1,0x5
bfc051f4:	33e6007f 	andi	a2,ra,0x7f
bfc051f8:	3188000f 	andi	t0,t4,0xf
bfc051fc:	00c80018 	mult	a2,t0
bfc05200:	00005012 	mflo	t2
bfc05204:	10e00038 	beqz	a3,bfc052e8 <core_bench_matrix+0x1278>
bfc05208:	020a8021 	addu	s0,s0,t2
bfc0520c:	85c60000 	lh	a2,0(t6)
bfc05210:	85a30000 	lh	v1,0(t5)
bfc05214:	01d26021 	addu	t4,t6,s2
bfc05218:	00c30018 	mult	a2,v1
bfc0521c:	85a90002 	lh	t1,2(t5)
bfc05220:	85850000 	lh	a1,0(t4)
bfc05224:	01927021 	addu	t6,t4,s2
bfc05228:	85aa0004 	lh	t2,4(t5)
bfc0522c:	85c40000 	lh	a0,0(t6)
bfc05230:	01d23821 	addu	a3,t6,s2
bfc05234:	85a30006 	lh	v1,6(t5)
bfc05238:	84e60000 	lh	a2,0(a3)
bfc0523c:	00f27021 	addu	t6,a3,s2
bfc05240:	25ef0004 	addiu	t7,t7,4
bfc05244:	01f4602b 	sltu	t4,t7,s4
bfc05248:	25ad0008 	addiu	t5,t5,8
bfc0524c:	0000f812 	mflo	ra
bfc05250:	001f4083 	sra	t0,ra,0x2
bfc05254:	001f1143 	sra	v0,ra,0x5
bfc05258:	00a90018 	mult	a1,t1
bfc0525c:	305f007f 	andi	ra,v0,0x7f
bfc05260:	3108000f 	andi	t0,t0,0xf
bfc05264:	00005812 	mflo	t3
bfc05268:	000b4883 	sra	t1,t3,0x2
bfc0526c:	000b2943 	sra	a1,t3,0x5
bfc05270:	008a0018 	mult	a0,t2
bfc05274:	30a5007f 	andi	a1,a1,0x7f
bfc05278:	3129000f 	andi	t1,t1,0xf
bfc0527c:	00003812 	mflo	a3
bfc05280:	00075083 	sra	t2,a3,0x2
bfc05284:	00072143 	sra	a0,a3,0x5
bfc05288:	00c30018 	mult	a2,v1
bfc0528c:	3084007f 	andi	a0,a0,0x7f
bfc05290:	3147000f 	andi	a3,t2,0xf
bfc05294:	00005812 	mflo	t3
bfc05298:	000b1943 	sra	v1,t3,0x5
bfc0529c:	000b3083 	sra	a2,t3,0x2
bfc052a0:	03e80018 	mult	ra,t0
bfc052a4:	30cb000f 	andi	t3,a2,0xf
bfc052a8:	3068007f 	andi	t0,v1,0x7f
bfc052ac:	00001012 	mflo	v0
bfc052b0:	0202f821 	addu	ra,s0,v0
bfc052b4:	00000000 	nop
bfc052b8:	00a90018 	mult	a1,t1
bfc052bc:	00005012 	mflo	t2
bfc052c0:	03ea4821 	addu	t1,ra,t2
bfc052c4:	00000000 	nop
bfc052c8:	00870018 	mult	a0,a3
bfc052cc:	00002012 	mflo	a0
bfc052d0:	01245021 	addu	t2,t1,a0
bfc052d4:	00000000 	nop
bfc052d8:	010b0018 	mult	t0,t3
bfc052dc:	00002812 	mflo	a1
bfc052e0:	1580ffca 	bnez	t4,bfc0520c <core_bench_matrix+0x119c>
bfc052e4:	01458021 	addu	s0,t2,a1
bfc052e8:	27390001 	addiu	t9,t9,1
bfc052ec:	0334782b 	sltu	t7,t9,s4
bfc052f0:	af100000 	sw	s0,0(t8)
bfc052f4:	26310002 	addiu	s1,s1,2
bfc052f8:	15e0ff81 	bnez	t7,bfc05100 <core_bench_matrix+0x1090>
bfc052fc:	27180004 	addiu	t8,t8,4
bfc05300:	26d60001 	addiu	s6,s6,1
bfc05304:	8fb1001c 	lw	s1,28(sp)
bfc05308:	02d4c82b 	sltu	t9,s6,s4
bfc0530c:	02729821 	addu	s3,s3,s2
bfc05310:	1720ff78 	bnez	t9,bfc050f4 <core_bench_matrix+0x1084>
bfc05314:	02b1a821 	addu	s5,s5,s1
bfc05318:	00003021 	move	a2,zero
bfc0531c:	00001821 	move	v1,zero
bfc05320:	00002021 	move	a0,zero
bfc05324:	00005821 	move	t3,zero
bfc05328:	2687ffff 	addiu	a3,s4,-1
bfc0532c:	30ea0003 	andi	t2,a3,0x3
bfc05330:	8fa80020 	lw	t0,32(sp)
bfc05334:	11400040 	beqz	t2,bfc05438 <core_bench_matrix+0x13c8>
bfc05338:	00004821 	move	t1,zero
bfc0533c:	8d070000 	lw	a3,0(t0)
bfc05340:	3093ffff 	andi	s3,a0,0xffff
bfc05344:	0067802a 	slt	s0,v1,a3
bfc05348:	00c73021 	addu	a2,a2,a3
bfc0534c:	02707021 	addu	t6,s3,s0
bfc05350:	266c000a 	addiu	t4,s3,10
bfc05354:	000c7c00 	sll	t7,t4,0x10
bfc05358:	000e6c00 	sll	t5,t6,0x10
bfc0535c:	03c6282a 	slt	a1,s8,a2
bfc05360:	000f1403 	sra	v0,t7,0x10
bfc05364:	10a00002 	beqz	a1,bfc05370 <core_bench_matrix+0x1300>
bfc05368:	000d2403 	sra	a0,t5,0x10
bfc0536c:	00402021 	move	a0,v0
bfc05370:	10a00002 	beqz	a1,bfc0537c <core_bench_matrix+0x130c>
bfc05374:	24090001 	li	t1,1
bfc05378:	00003021 	move	a2,zero
bfc0537c:	8fa30020 	lw	v1,32(sp)
bfc05380:	0134282b 	sltu	a1,t1,s4
bfc05384:	10a0007b 	beqz	a1,bfc05574 <core_bench_matrix+0x1504>
bfc05388:	24680004 	addiu	t0,v1,4
bfc0538c:	1149002a 	beq	t2,t1,bfc05438 <core_bench_matrix+0x13c8>
bfc05390:	00e01821 	move	v1,a3
bfc05394:	24020002 	li	v0,2
bfc05398:	11420014 	beq	t2,v0,bfc053ec <core_bench_matrix+0x137c>
bfc0539c:	3095ffff 	andi	s5,a0,0xffff
bfc053a0:	8d050000 	lw	a1,0(t0)
bfc053a4:	00000000 	nop
bfc053a8:	00e5b02a 	slt	s6,a3,a1
bfc053ac:	02b62021 	addu	a0,s5,s6
bfc053b0:	00c55021 	addu	t2,a2,a1
bfc053b4:	26b1000a 	addiu	s1,s5,10
bfc053b8:	0011cc00 	sll	t9,s1,0x10
bfc053bc:	00043c00 	sll	a3,a0,0x10
bfc053c0:	03ca302a 	slt	a2,s8,t2
bfc053c4:	00191403 	sra	v0,t9,0x10
bfc053c8:	10c00002 	beqz	a2,bfc053d4 <core_bench_matrix+0x1364>
bfc053cc:	00072403 	sra	a0,a3,0x10
bfc053d0:	00402021 	move	a0,v0
bfc053d4:	14c00002 	bnez	a2,bfc053e0 <core_bench_matrix+0x1370>
bfc053d8:	00003021 	move	a2,zero
bfc053dc:	01403021 	move	a2,t2
bfc053e0:	25290001 	addiu	t1,t1,1
bfc053e4:	25080004 	addiu	t0,t0,4
bfc053e8:	00a01821 	move	v1,a1
bfc053ec:	8d050000 	lw	a1,0(t0)
bfc053f0:	308fffff 	andi	t7,a0,0xffff
bfc053f4:	00c53821 	addu	a3,a2,a1
bfc053f8:	0065302a 	slt	a2,v1,a1
bfc053fc:	01e6c021 	addu	t8,t7,a2
bfc05400:	25ee000a 	addiu	t6,t7,10
bfc05404:	000e6c00 	sll	t5,t6,0x10
bfc05408:	00185400 	sll	t2,t8,0x10
bfc0540c:	03c7302a 	slt	a2,s8,a3
bfc05410:	000d1403 	sra	v0,t5,0x10
bfc05414:	10c00002 	beqz	a2,bfc05420 <core_bench_matrix+0x13b0>
bfc05418:	000a2403 	sra	a0,t2,0x10
bfc0541c:	00402021 	move	a0,v0
bfc05420:	14c00002 	bnez	a2,bfc0542c <core_bench_matrix+0x13bc>
bfc05424:	00003021 	move	a2,zero
bfc05428:	00e03021 	move	a2,a3
bfc0542c:	25290001 	addiu	t1,t1,1
bfc05430:	25080004 	addiu	t0,t0,4
bfc05434:	00a01821 	move	v1,a1
bfc05438:	8d070000 	lw	a3,0(t0)
bfc0543c:	3085ffff 	andi	a1,a0,0xffff
bfc05440:	0067702a 	slt	t6,v1,a3
bfc05444:	00ae5021 	addu	t2,a1,t6
bfc05448:	24bf000a 	addiu	ra,a1,10
bfc0544c:	00c73021 	addu	a2,a2,a3
bfc05450:	001f1400 	sll	v0,ra,0x10
bfc05454:	000a2400 	sll	a0,t2,0x10
bfc05458:	03c6282a 	slt	a1,s8,a2
bfc0545c:	00021403 	sra	v0,v0,0x10
bfc05460:	10a00002 	beqz	a1,bfc0546c <core_bench_matrix+0x13fc>
bfc05464:	00042403 	sra	a0,a0,0x10
bfc05468:	00402021 	move	a0,v0
bfc0546c:	10a00002 	beqz	a1,bfc05478 <core_bench_matrix+0x1408>
bfc05470:	00000000 	nop
bfc05474:	00003021 	move	a2,zero
bfc05478:	25290001 	addiu	t1,t1,1
bfc0547c:	0134602b 	sltu	t4,t1,s4
bfc05480:	1180003b 	beqz	t4,bfc05570 <core_bench_matrix+0x1500>
bfc05484:	250a0004 	addiu	t2,t0,4
bfc05488:	8d050004 	lw	a1,4(t0)
bfc0548c:	3090ffff 	andi	s0,a0,0xffff
bfc05490:	00e5682a 	slt	t5,a3,a1
bfc05494:	00c54021 	addu	t0,a2,a1
bfc05498:	020db021 	addu	s6,s0,t5
bfc0549c:	2613000a 	addiu	s3,s0,10
bfc054a0:	0013c400 	sll	t8,s3,0x10
bfc054a4:	0016ac00 	sll	s5,s6,0x10
bfc054a8:	03c8302a 	slt	a2,s8,t0
bfc054ac:	00182403 	sra	a0,t8,0x10
bfc054b0:	10c00002 	beqz	a2,bfc054bc <core_bench_matrix+0x144c>
bfc054b4:	00151403 	sra	v0,s5,0x10
bfc054b8:	00801021 	move	v0,a0
bfc054bc:	14c00002 	bnez	a2,bfc054c8 <core_bench_matrix+0x1458>
bfc054c0:	00003821 	move	a3,zero
bfc054c4:	01003821 	move	a3,t0
bfc054c8:	8d460004 	lw	a2,4(t2)
bfc054cc:	305fffff 	andi	ra,v0,0xffff
bfc054d0:	00a6182a 	slt	v1,a1,a2
bfc054d4:	00e63821 	addu	a3,a3,a2
bfc054d8:	03e36021 	addu	t4,ra,v1
bfc054dc:	27f0000a 	addiu	s0,ra,10
bfc054e0:	00109c00 	sll	s3,s0,0x10
bfc054e4:	000c4400 	sll	t0,t4,0x10
bfc054e8:	03c7282a 	slt	a1,s8,a3
bfc054ec:	00132403 	sra	a0,s3,0x10
bfc054f0:	10a00002 	beqz	a1,bfc054fc <core_bench_matrix+0x148c>
bfc054f4:	00081403 	sra	v0,t0,0x10
bfc054f8:	00801021 	move	v0,a0
bfc054fc:	10a00002 	beqz	a1,bfc05508 <core_bench_matrix+0x1498>
bfc05500:	00000000 	nop
bfc05504:	00003821 	move	a3,zero
bfc05508:	8d450008 	lw	a1,8(t2)
bfc0550c:	3055ffff 	andi	s5,v0,0xffff
bfc05510:	00c5b02a 	slt	s6,a2,a1
bfc05514:	00e53821 	addu	a3,a3,a1
bfc05518:	02b6c821 	addu	t9,s5,s6
bfc0551c:	26b1000a 	addiu	s1,s5,10
bfc05520:	00111400 	sll	v0,s1,0x10
bfc05524:	00192400 	sll	a0,t9,0x10
bfc05528:	03c7302a 	slt	a2,s8,a3
bfc0552c:	00021403 	sra	v0,v0,0x10
bfc05530:	10c00002 	beqz	a2,bfc0553c <core_bench_matrix+0x14cc>
bfc05534:	00042403 	sra	a0,a0,0x10
bfc05538:	00402021 	move	a0,v0
bfc0553c:	14c00008 	bnez	a2,bfc05560 <core_bench_matrix+0x14f0>
bfc05540:	00000000 	nop
bfc05544:	00e03021 	move	a2,a3
bfc05548:	25290003 	addiu	t1,t1,3
bfc0554c:	2548000c 	addiu	t0,t2,12
bfc05550:	0bf0150e 	j	bfc05438 <core_bench_matrix+0x13c8>
bfc05554:	00a01821 	move	v1,a1
	...
bfc05560:	0bf01552 	j	bfc05548 <core_bench_matrix+0x14d8>
bfc05564:	00003021 	move	a2,zero
	...
bfc05570:	8fa30020 	lw	v1,32(sp)
bfc05574:	8faf001c 	lw	t7,28(sp)
bfc05578:	256b0001 	addiu	t3,t3,1
bfc0557c:	006f4821 	addu	t1,v1,t7
bfc05580:	0174402b 	sltu	t0,t3,s4
bfc05584:	11000003 	beqz	t0,bfc05594 <core_bench_matrix+0x1524>
bfc05588:	afa90020 	sw	t1,32(sp)
bfc0558c:	0bf014ca 	j	bfc05328 <core_bench_matrix+0x12b8>
bfc05590:	00e01821 	move	v1,a3
bfc05594:	0ff01800 	jal	bfc06000 <crc16>
bfc05598:	02e02821 	move	a1,s7
bfc0559c:	8fb70034 	lw	s7,52(sp)
bfc055a0:	00407821 	move	t7,v0
bfc055a4:	0017f023 	negu	s8,s7
bfc055a8:	33cdffff 	andi	t5,s8,0xffff
bfc055ac:	00007021 	move	t6,zero
bfc055b0:	8fb90010 	lw	t9,16(sp)
bfc055b4:	240c0001 	li	t4,1
bfc055b8:	97360000 	lhu	s6,0(t9)
bfc055bc:	2691ffff 	addiu	s1,s4,-1
bfc055c0:	01b6a821 	addu	s5,t5,s6
bfc055c4:	0194b82b 	sltu	s7,t4,s4
bfc055c8:	a7350000 	sh	s5,0(t9)
bfc055cc:	32230007 	andi	v1,s1,0x7
bfc055d0:	12e00051 	beqz	s7,bfc05718 <core_bench_matrix+0x16a8>
bfc055d4:	272b0002 	addiu	t3,t9,2
bfc055d8:	10600033 	beqz	v1,bfc056a8 <core_bench_matrix+0x1638>
bfc055dc:	00000000 	nop
bfc055e0:	106c002a 	beq	v1,t4,bfc0568c <core_bench_matrix+0x161c>
bfc055e4:	24060002 	li	a2,2
bfc055e8:	10660023 	beq	v1,a2,bfc05678 <core_bench_matrix+0x1608>
bfc055ec:	24180003 	li	t8,3
bfc055f0:	1078001c 	beq	v1,t8,bfc05664 <core_bench_matrix+0x15f4>
bfc055f4:	24130004 	li	s3,4
bfc055f8:	10730015 	beq	v1,s3,bfc05650 <core_bench_matrix+0x15e0>
bfc055fc:	24100005 	li	s0,5
bfc05600:	1070000e 	beq	v1,s0,bfc0563c <core_bench_matrix+0x15cc>
bfc05604:	240a0006 	li	t2,6
bfc05608:	106a0007 	beq	v1,t2,bfc05628 <core_bench_matrix+0x15b8>
bfc0560c:	00000000 	nop
bfc05610:	95690000 	lhu	t1,0(t3)
bfc05614:	8fbf0010 	lw	ra,16(sp)
bfc05618:	01a94021 	addu	t0,t5,t1
bfc0561c:	a5680000 	sh	t0,0(t3)
bfc05620:	240c0002 	li	t4,2
bfc05624:	27eb0004 	addiu	t3,ra,4
bfc05628:	95650000 	lhu	a1,0(t3)
bfc0562c:	258c0001 	addiu	t4,t4,1
bfc05630:	01a53821 	addu	a3,t5,a1
bfc05634:	a5670000 	sh	a3,0(t3)
bfc05638:	256b0002 	addiu	t3,t3,2
bfc0563c:	95630000 	lhu	v1,0(t3)
bfc05640:	258c0001 	addiu	t4,t4,1
bfc05644:	01a32021 	addu	a0,t5,v1
bfc05648:	a5640000 	sh	a0,0(t3)
bfc0564c:	256b0002 	addiu	t3,t3,2
bfc05650:	957e0000 	lhu	s8,0(t3)
bfc05654:	258c0001 	addiu	t4,t4,1
bfc05658:	01be1021 	addu	v0,t5,s8
bfc0565c:	a5620000 	sh	v0,0(t3)
bfc05660:	256b0002 	addiu	t3,t3,2
bfc05664:	95790000 	lhu	t9,0(t3)
bfc05668:	258c0001 	addiu	t4,t4,1
bfc0566c:	01b9b821 	addu	s7,t5,t9
bfc05670:	a5770000 	sh	s7,0(t3)
bfc05674:	256b0002 	addiu	t3,t3,2
bfc05678:	95750000 	lhu	s5,0(t3)
bfc0567c:	258c0001 	addiu	t4,t4,1
bfc05680:	01b58821 	addu	s1,t5,s5
bfc05684:	a5710000 	sh	s1,0(t3)
bfc05688:	256b0002 	addiu	t3,t3,2
bfc0568c:	95780000 	lhu	t8,0(t3)
bfc05690:	258c0001 	addiu	t4,t4,1
bfc05694:	01b83021 	addu	a2,t5,t8
bfc05698:	0194b02b 	sltu	s6,t4,s4
bfc0569c:	a5660000 	sh	a2,0(t3)
bfc056a0:	12c0001d 	beqz	s6,bfc05718 <core_bench_matrix+0x16a8>
bfc056a4:	256b0002 	addiu	t3,t3,2
bfc056a8:	95620000 	lhu	v0,0(t3)
bfc056ac:	95630002 	lhu	v1,2(t3)
bfc056b0:	95640004 	lhu	a0,4(t3)
bfc056b4:	95650006 	lhu	a1,6(t3)
bfc056b8:	95670008 	lhu	a3,8(t3)
bfc056bc:	9569000a 	lhu	t1,10(t3)
bfc056c0:	9568000c 	lhu	t0,12(t3)
bfc056c4:	957f000e 	lhu	ra,14(t3)
bfc056c8:	258c0008 	addiu	t4,t4,8
bfc056cc:	01a25021 	addu	t2,t5,v0
bfc056d0:	01a38021 	addu	s0,t5,v1
bfc056d4:	01a49821 	addu	s3,t5,a0
bfc056d8:	01a5c021 	addu	t8,t5,a1
bfc056dc:	01a73021 	addu	a2,t5,a3
bfc056e0:	01a9b021 	addu	s6,t5,t1
bfc056e4:	01a8a821 	addu	s5,t5,t0
bfc056e8:	01bf8821 	addu	s1,t5,ra
bfc056ec:	0194c82b 	sltu	t9,t4,s4
bfc056f0:	a56a0000 	sh	t2,0(t3)
bfc056f4:	a5700002 	sh	s0,2(t3)
bfc056f8:	a5730004 	sh	s3,4(t3)
bfc056fc:	a5780006 	sh	t8,6(t3)
bfc05700:	a5660008 	sh	a2,8(t3)
bfc05704:	a576000a 	sh	s6,10(t3)
bfc05708:	a575000c 	sh	s5,12(t3)
bfc0570c:	a571000e 	sh	s1,14(t3)
bfc05710:	1720ffe5 	bnez	t9,bfc056a8 <core_bench_matrix+0x1638>
bfc05714:	256b0010 	addiu	t3,t3,16
bfc05718:	8fbe0010 	lw	s8,16(sp)
bfc0571c:	25ce0001 	addiu	t6,t6,1
bfc05720:	03d26021 	addu	t4,s8,s2
bfc05724:	01d4582b 	sltu	t3,t6,s4
bfc05728:	1560ffa1 	bnez	t3,bfc055b0 <core_bench_matrix+0x1540>
bfc0572c:	afac0010 	sw	t4,16(sp)
bfc05730:	000f9400 	sll	s2,t7,0x10
bfc05734:	8fa50038 	lw	a1,56(sp)
bfc05738:	00122403 	sra	a0,s2,0x10
bfc0573c:	8fbf0064 	lw	ra,100(sp)
bfc05740:	8fbe0060 	lw	s8,96(sp)
bfc05744:	8fb7005c 	lw	s7,92(sp)
bfc05748:	8fb60058 	lw	s6,88(sp)
bfc0574c:	8fb50054 	lw	s5,84(sp)
bfc05750:	8fb40050 	lw	s4,80(sp)
bfc05754:	8fb3004c 	lw	s3,76(sp)
bfc05758:	8fb20048 	lw	s2,72(sp)
bfc0575c:	8fb10044 	lw	s1,68(sp)
bfc05760:	8fb00040 	lw	s0,64(sp)
bfc05764:	0bf01800 	j	bfc06000 <crc16>
bfc05768:	27bd0068 	addiu	sp,sp,104
bfc0576c:	00002021 	move	a0,zero
bfc05770:	0ff01800 	jal	bfc06000 <crc16>
bfc05774:	00002821 	move	a1,zero
bfc05778:	00402821 	move	a1,v0
bfc0577c:	0ff01800 	jal	bfc06000 <crc16>
bfc05780:	00002021 	move	a0,zero
bfc05784:	00402821 	move	a1,v0
bfc05788:	0ff01800 	jal	bfc06000 <crc16>
bfc0578c:	00002021 	move	a0,zero
bfc05790:	00402821 	move	a1,v0
bfc05794:	0ff01800 	jal	bfc06000 <crc16>
bfc05798:	00002021 	move	a0,zero
bfc0579c:	0bf015cc 	j	bfc05730 <core_bench_matrix+0x16c0>
bfc057a0:	00407821 	move	t7,v0
	...

bfc057b0 <parseval>:
parseval():
bfc057b0:	80870000 	lb	a3,0(a0)
bfc057b4:	2402002d 	li	v0,45
bfc057b8:	10e2003d 	beq	a3,v0,bfc058b0 <parseval+0x100>
bfc057bc:	00802821 	move	a1,a0
bfc057c0:	24030030 	li	v1,48
bfc057c4:	10e3003f 	beq	a3,v1,bfc058c4 <parseval+0x114>
bfc057c8:	240a0001 	li	t2,1
bfc057cc:	24ebffd0 	addiu	t3,a3,-48
bfc057d0:	316900ff 	andi	t1,t3,0xff
bfc057d4:	2d28000a 	sltiu	t0,t1,10
bfc057d8:	1100002b 	beqz	t0,bfc05888 <parseval+0xd8>
bfc057dc:	00004021 	move	t0,zero
bfc057e0:	000868c0 	sll	t5,t0,0x3
bfc057e4:	00086040 	sll	t4,t0,0x1
bfc057e8:	018d4021 	addu	t0,t4,t5
bfc057ec:	00e85821 	addu	t3,a3,t0
bfc057f0:	80a70001 	lb	a3,1(a1)
bfc057f4:	2568ffd0 	addiu	t0,t3,-48
bfc057f8:	24e4ffd0 	addiu	a0,a3,-48
bfc057fc:	000848c0 	sll	t1,t0,0x3
bfc05800:	00083040 	sll	a2,t0,0x1
bfc05804:	308300ff 	andi	v1,a0,0xff
bfc05808:	00c91021 	addu	v0,a2,t1
bfc0580c:	2c79000a 	sltiu	t9,v1,10
bfc05810:	1320001d 	beqz	t9,bfc05888 <parseval+0xd8>
bfc05814:	00e21021 	addu	v0,a3,v0
bfc05818:	80a70002 	lb	a3,2(a1)
bfc0581c:	2448ffd0 	addiu	t0,v0,-48
bfc05820:	24e4ffd0 	addiu	a0,a3,-48
bfc05824:	000810c0 	sll	v0,t0,0x3
bfc05828:	00083040 	sll	a2,t0,0x1
bfc0582c:	309900ff 	andi	t9,a0,0xff
bfc05830:	00c21821 	addu	v1,a2,v0
bfc05834:	2f38000a 	sltiu	t8,t9,10
bfc05838:	13000013 	beqz	t8,bfc05888 <parseval+0xd8>
bfc0583c:	00e31821 	addu	v1,a3,v1
bfc05840:	80a70003 	lb	a3,3(a1)
bfc05844:	24a50004 	addiu	a1,a1,4
bfc05848:	24eeffd0 	addiu	t6,a3,-48
bfc0584c:	31c800ff 	andi	t0,t6,0xff
bfc05850:	2d09000a 	sltiu	t1,t0,10
bfc05854:	2468ffd0 	addiu	t0,v1,-48
bfc05858:	000868c0 	sll	t5,t0,0x3
bfc0585c:	00086040 	sll	t4,t0,0x1
bfc05860:	018d5821 	addu	t3,t4,t5
bfc05864:	11200008 	beqz	t1,bfc05888 <parseval+0xd8>
bfc05868:	00eb1821 	addu	v1,a3,t3
bfc0586c:	80a70000 	lb	a3,0(a1)
bfc05870:	00000000 	nop
bfc05874:	24f9ffd0 	addiu	t9,a3,-48
bfc05878:	333800ff 	andi	t8,t9,0xff
bfc0587c:	2f0f000a 	sltiu	t7,t8,10
bfc05880:	15e0ffd7 	bnez	t7,bfc057e0 <parseval+0x30>
bfc05884:	2468ffd0 	addiu	t0,v1,-48
bfc05888:	240e004b 	li	t6,75
bfc0588c:	10ee0028 	beq	a3,t6,bfc05930 <parseval+0x180>
bfc05890:	240f004d 	li	t7,77
bfc05894:	14ef0003 	bne	a3,t7,bfc058a4 <parseval+0xf4>
bfc05898:	010a0018 	mult	t0,t2
bfc0589c:	00084500 	sll	t0,t0,0x14
bfc058a0:	010a0018 	mult	t0,t2
bfc058a4:	00001012 	mflo	v0
bfc058a8:	03e00008 	jr	ra
bfc058ac:	00000000 	nop
bfc058b0:	24850001 	addiu	a1,a0,1
bfc058b4:	80a70000 	lb	a3,0(a1)
bfc058b8:	24030030 	li	v1,48
bfc058bc:	14e3ffc3 	bne	a3,v1,bfc057cc <parseval+0x1c>
bfc058c0:	240affff 	li	t2,-1
bfc058c4:	80a60001 	lb	a2,1(a1)
bfc058c8:	24040078 	li	a0,120
bfc058cc:	14c4ffc0 	bne	a2,a0,bfc057d0 <parseval+0x20>
bfc058d0:	24ebffd0 	addiu	t3,a3,-48
bfc058d4:	24a40002 	addiu	a0,a1,2
bfc058d8:	00004021 	move	t0,zero
bfc058dc:	80870000 	lb	a3,0(a0)
bfc058e0:	00084900 	sll	t1,t0,0x4
bfc058e4:	30e500ff 	andi	a1,a3,0xff
bfc058e8:	24b8ffd0 	addiu	t8,a1,-48
bfc058ec:	24afff9f 	addiu	t7,a1,-97
bfc058f0:	330e00ff 	andi	t6,t8,0xff
bfc058f4:	24e5ffd0 	addiu	a1,a3,-48
bfc058f8:	31ed00ff 	andi	t5,t7,0xff
bfc058fc:	2dcc000a 	sltiu	t4,t6,10
bfc05900:	28a6000a 	slti	a2,a1,10
bfc05904:	24840001 	addiu	a0,a0,1
bfc05908:	15800003 	bnez	t4,bfc05918 <parseval+0x168>
bfc0590c:	2da30006 	sltiu	v1,t5,6
bfc05910:	1060ffde 	beqz	v1,bfc0588c <parseval+0xdc>
bfc05914:	240e004b 	li	t6,75
bfc05918:	14c00002 	bnez	a2,bfc05924 <parseval+0x174>
bfc0591c:	00000000 	nop
bfc05920:	24e5ffa9 	addiu	a1,a3,-87
bfc05924:	0bf01637 	j	bfc058dc <parseval+0x12c>
bfc05928:	00a94021 	addu	t0,a1,t1
bfc0592c:	00000000 	nop
bfc05930:	00084280 	sll	t0,t0,0xa
bfc05934:	010a0018 	mult	t0,t2
bfc05938:	00001012 	mflo	v0
bfc0593c:	03e00008 	jr	ra
bfc05940:	00000000 	nop
	...

bfc05950 <crcu8>:
crcu8():
bfc05950:	30a5ffff 	andi	a1,a1,0xffff
bfc05954:	308400ff 	andi	a0,a0,0xff
bfc05958:	00853026 	xor	a2,a0,a1
bfc0595c:	38a74002 	xori	a3,a1,0x4002
bfc05960:	00071042 	srl	v0,a3,0x1
bfc05964:	30c30001 	andi	v1,a2,0x1
bfc05968:	00042042 	srl	a0,a0,0x1
bfc0596c:	34468000 	ori	a2,v0,0x8000
bfc05970:	14600043 	bnez	v1,bfc05a80 <crcu8+0x130>
bfc05974:	00051042 	srl	v0,a1,0x1
bfc05978:	00402821 	move	a1,v0
bfc0597c:	00855026 	xor	t2,a0,a1
bfc05980:	38ab4002 	xori	t3,a1,0x4002
bfc05984:	000b4842 	srl	t1,t3,0x1
bfc05988:	31480001 	andi	t0,t2,0x1
bfc0598c:	00042042 	srl	a0,a0,0x1
bfc05990:	35268000 	ori	a2,t1,0x8000
bfc05994:	15000043 	bnez	t0,bfc05aa4 <crcu8+0x154>
bfc05998:	00051042 	srl	v0,a1,0x1
bfc0599c:	00402821 	move	a1,v0
bfc059a0:	00857026 	xor	t6,a0,a1
bfc059a4:	38af4002 	xori	t7,a1,0x4002
bfc059a8:	000f6842 	srl	t5,t7,0x1
bfc059ac:	31cc0001 	andi	t4,t6,0x1
bfc059b0:	00042042 	srl	a0,a0,0x1
bfc059b4:	35a68000 	ori	a2,t5,0x8000
bfc059b8:	15800043 	bnez	t4,bfc05ac8 <crcu8+0x178>
bfc059bc:	00051042 	srl	v0,a1,0x1
bfc059c0:	00402821 	move	a1,v0
bfc059c4:	00851826 	xor	v1,a0,a1
bfc059c8:	38a24002 	xori	v0,a1,0x4002
bfc059cc:	0002c842 	srl	t9,v0,0x1
bfc059d0:	30780001 	andi	t8,v1,0x1
bfc059d4:	00042042 	srl	a0,a0,0x1
bfc059d8:	37268000 	ori	a2,t9,0x8000
bfc059dc:	17000043 	bnez	t8,bfc05aec <crcu8+0x19c>
bfc059e0:	00051042 	srl	v0,a1,0x1
bfc059e4:	00402821 	move	a1,v0
bfc059e8:	00853026 	xor	a2,a0,a1
bfc059ec:	38a94002 	xori	t1,a1,0x4002
bfc059f0:	00094042 	srl	t0,t1,0x1
bfc059f4:	30c70001 	andi	a3,a2,0x1
bfc059f8:	00042042 	srl	a0,a0,0x1
bfc059fc:	35068000 	ori	a2,t0,0x8000
bfc05a00:	14e00043 	bnez	a3,bfc05b10 <crcu8+0x1c0>
bfc05a04:	00051042 	srl	v0,a1,0x1
bfc05a08:	00402821 	move	a1,v0
bfc05a0c:	00856026 	xor	t4,a0,a1
bfc05a10:	38ad4002 	xori	t5,a1,0x4002
bfc05a14:	000d5842 	srl	t3,t5,0x1
bfc05a18:	318a0001 	andi	t2,t4,0x1
bfc05a1c:	00042042 	srl	a0,a0,0x1
bfc05a20:	35668000 	ori	a2,t3,0x8000
bfc05a24:	15400043 	bnez	t2,bfc05b34 <crcu8+0x1e4>
bfc05a28:	00051042 	srl	v0,a1,0x1
bfc05a2c:	00402821 	move	a1,v0
bfc05a30:	0085c026 	xor	t8,a0,a1
bfc05a34:	38b94002 	xori	t9,a1,0x4002
bfc05a38:	00197842 	srl	t7,t9,0x1
bfc05a3c:	330e0001 	andi	t6,t8,0x1
bfc05a40:	35e68000 	ori	a2,t7,0x8000
bfc05a44:	15c00043 	bnez	t6,bfc05b54 <crcu8+0x204>
bfc05a48:	00051042 	srl	v0,a1,0x1
bfc05a4c:	00402821 	move	a1,v0
bfc05a50:	38a74002 	xori	a3,a1,0x4002
bfc05a54:	00071042 	srl	v0,a3,0x1
bfc05a58:	00042042 	srl	a0,a0,0x1
bfc05a5c:	30a30001 	andi	v1,a1,0x1
bfc05a60:	34468000 	ori	a2,v0,0x8000
bfc05a64:	14640043 	bne	v1,a0,bfc05b74 <crcu8+0x224>
bfc05a68:	00051042 	srl	v0,a1,0x1
bfc05a6c:	03e00008 	jr	ra
bfc05a70:	3042ffff 	andi	v0,v0,0xffff
	...
bfc05a80:	00c02821 	move	a1,a2
bfc05a84:	00855026 	xor	t2,a0,a1
bfc05a88:	38ab4002 	xori	t3,a1,0x4002
bfc05a8c:	000b4842 	srl	t1,t3,0x1
bfc05a90:	31480001 	andi	t0,t2,0x1
bfc05a94:	00042042 	srl	a0,a0,0x1
bfc05a98:	35268000 	ori	a2,t1,0x8000
bfc05a9c:	1100ffbf 	beqz	t0,bfc0599c <crcu8+0x4c>
bfc05aa0:	00051042 	srl	v0,a1,0x1
bfc05aa4:	00c02821 	move	a1,a2
bfc05aa8:	00857026 	xor	t6,a0,a1
bfc05aac:	38af4002 	xori	t7,a1,0x4002
bfc05ab0:	000f6842 	srl	t5,t7,0x1
bfc05ab4:	31cc0001 	andi	t4,t6,0x1
bfc05ab8:	00042042 	srl	a0,a0,0x1
bfc05abc:	35a68000 	ori	a2,t5,0x8000
bfc05ac0:	1180ffbf 	beqz	t4,bfc059c0 <crcu8+0x70>
bfc05ac4:	00051042 	srl	v0,a1,0x1
bfc05ac8:	00c02821 	move	a1,a2
bfc05acc:	00851826 	xor	v1,a0,a1
bfc05ad0:	38a24002 	xori	v0,a1,0x4002
bfc05ad4:	0002c842 	srl	t9,v0,0x1
bfc05ad8:	30780001 	andi	t8,v1,0x1
bfc05adc:	00042042 	srl	a0,a0,0x1
bfc05ae0:	37268000 	ori	a2,t9,0x8000
bfc05ae4:	1300ffbf 	beqz	t8,bfc059e4 <crcu8+0x94>
bfc05ae8:	00051042 	srl	v0,a1,0x1
bfc05aec:	00c02821 	move	a1,a2
bfc05af0:	00853026 	xor	a2,a0,a1
bfc05af4:	38a94002 	xori	t1,a1,0x4002
bfc05af8:	00094042 	srl	t0,t1,0x1
bfc05afc:	30c70001 	andi	a3,a2,0x1
bfc05b00:	00042042 	srl	a0,a0,0x1
bfc05b04:	35068000 	ori	a2,t0,0x8000
bfc05b08:	10e0ffbf 	beqz	a3,bfc05a08 <crcu8+0xb8>
bfc05b0c:	00051042 	srl	v0,a1,0x1
bfc05b10:	00c02821 	move	a1,a2
bfc05b14:	00856026 	xor	t4,a0,a1
bfc05b18:	38ad4002 	xori	t5,a1,0x4002
bfc05b1c:	000d5842 	srl	t3,t5,0x1
bfc05b20:	318a0001 	andi	t2,t4,0x1
bfc05b24:	00042042 	srl	a0,a0,0x1
bfc05b28:	35668000 	ori	a2,t3,0x8000
bfc05b2c:	1140ffbf 	beqz	t2,bfc05a2c <crcu8+0xdc>
bfc05b30:	00051042 	srl	v0,a1,0x1
bfc05b34:	00c02821 	move	a1,a2
bfc05b38:	0085c026 	xor	t8,a0,a1
bfc05b3c:	38b94002 	xori	t9,a1,0x4002
bfc05b40:	00197842 	srl	t7,t9,0x1
bfc05b44:	330e0001 	andi	t6,t8,0x1
bfc05b48:	35e68000 	ori	a2,t7,0x8000
bfc05b4c:	11c0ffbf 	beqz	t6,bfc05a4c <crcu8+0xfc>
bfc05b50:	00051042 	srl	v0,a1,0x1
bfc05b54:	00c02821 	move	a1,a2
bfc05b58:	38a74002 	xori	a3,a1,0x4002
bfc05b5c:	00071042 	srl	v0,a3,0x1
bfc05b60:	00042042 	srl	a0,a0,0x1
bfc05b64:	30a30001 	andi	v1,a1,0x1
bfc05b68:	34468000 	ori	a2,v0,0x8000
bfc05b6c:	1064ffbf 	beq	v1,a0,bfc05a6c <crcu8+0x11c>
bfc05b70:	00051042 	srl	v0,a1,0x1
bfc05b74:	00c01021 	move	v0,a2
bfc05b78:	03e00008 	jr	ra
bfc05b7c:	3042ffff 	andi	v0,v0,0xffff

bfc05b80 <check_data_types>:
check_data_types():
bfc05b80:	03e00008 	jr	ra
bfc05b84:	00001021 	move	v0,zero
	...

bfc05b90 <crcu16>:
crcu16():
bfc05b90:	3087ffff 	andi	a3,a0,0xffff
bfc05b94:	30a5ffff 	andi	a1,a1,0xffff
bfc05b98:	30e400ff 	andi	a0,a3,0xff
bfc05b9c:	00853026 	xor	a2,a0,a1
bfc05ba0:	38a84002 	xori	t0,a1,0x4002
bfc05ba4:	00081042 	srl	v0,t0,0x1
bfc05ba8:	30c30001 	andi	v1,a2,0x1
bfc05bac:	00042042 	srl	a0,a0,0x1
bfc05bb0:	34468000 	ori	a2,v0,0x8000
bfc05bb4:	1460008a 	bnez	v1,bfc05de0 <crcu16+0x250>
bfc05bb8:	00051042 	srl	v0,a1,0x1
bfc05bbc:	00402821 	move	a1,v0
bfc05bc0:	00855826 	xor	t3,a0,a1
bfc05bc4:	38ac4002 	xori	t4,a1,0x4002
bfc05bc8:	000c5042 	srl	t2,t4,0x1
bfc05bcc:	31690001 	andi	t1,t3,0x1
bfc05bd0:	00042042 	srl	a0,a0,0x1
bfc05bd4:	35468000 	ori	a2,t2,0x8000
bfc05bd8:	1520008a 	bnez	t1,bfc05e04 <crcu16+0x274>
bfc05bdc:	00051042 	srl	v0,a1,0x1
bfc05be0:	00402821 	move	a1,v0
bfc05be4:	00857826 	xor	t7,a0,a1
bfc05be8:	38b84002 	xori	t8,a1,0x4002
bfc05bec:	00187042 	srl	t6,t8,0x1
bfc05bf0:	31ed0001 	andi	t5,t7,0x1
bfc05bf4:	00042042 	srl	a0,a0,0x1
bfc05bf8:	35c68000 	ori	a2,t6,0x8000
bfc05bfc:	15a0008a 	bnez	t5,bfc05e28 <crcu16+0x298>
bfc05c00:	00051042 	srl	v0,a1,0x1
bfc05c04:	00402821 	move	a1,v0
bfc05c08:	00851826 	xor	v1,a0,a1
bfc05c0c:	38a64002 	xori	a2,a1,0x4002
bfc05c10:	00061042 	srl	v0,a2,0x1
bfc05c14:	30790001 	andi	t9,v1,0x1
bfc05c18:	34468000 	ori	a2,v0,0x8000
bfc05c1c:	00042042 	srl	a0,a0,0x1
bfc05c20:	1720008a 	bnez	t9,bfc05e4c <crcu16+0x2bc>
bfc05c24:	00051042 	srl	v0,a1,0x1
bfc05c28:	00402821 	move	a1,v0
bfc05c2c:	00855026 	xor	t2,a0,a1
bfc05c30:	38ab4002 	xori	t3,a1,0x4002
bfc05c34:	000b4842 	srl	t1,t3,0x1
bfc05c38:	31480001 	andi	t0,t2,0x1
bfc05c3c:	00042042 	srl	a0,a0,0x1
bfc05c40:	35268000 	ori	a2,t1,0x8000
bfc05c44:	1500008a 	bnez	t0,bfc05e70 <crcu16+0x2e0>
bfc05c48:	00051042 	srl	v0,a1,0x1
bfc05c4c:	00402821 	move	a1,v0
bfc05c50:	00857026 	xor	t6,a0,a1
bfc05c54:	38af4002 	xori	t7,a1,0x4002
bfc05c58:	000f6842 	srl	t5,t7,0x1
bfc05c5c:	31cc0001 	andi	t4,t6,0x1
bfc05c60:	00042042 	srl	a0,a0,0x1
bfc05c64:	35a68000 	ori	a2,t5,0x8000
bfc05c68:	1580008a 	bnez	t4,bfc05e94 <crcu16+0x304>
bfc05c6c:	00051042 	srl	v0,a1,0x1
bfc05c70:	00402821 	move	a1,v0
bfc05c74:	38a24002 	xori	v0,a1,0x4002
bfc05c78:	00851826 	xor	v1,a0,a1
bfc05c7c:	0002c842 	srl	t9,v0,0x1
bfc05c80:	30780001 	andi	t8,v1,0x1
bfc05c84:	37268000 	ori	a2,t9,0x8000
bfc05c88:	1700008a 	bnez	t8,bfc05eb4 <crcu16+0x324>
bfc05c8c:	00051042 	srl	v0,a1,0x1
bfc05c90:	00402821 	move	a1,v0
bfc05c94:	38a64002 	xori	a2,a1,0x4002
bfc05c98:	00064842 	srl	t1,a2,0x1
bfc05c9c:	00042042 	srl	a0,a0,0x1
bfc05ca0:	30a80001 	andi	t0,a1,0x1
bfc05ca4:	35268000 	ori	a2,t1,0x8000
bfc05ca8:	1504008a 	bne	t0,a0,bfc05ed4 <crcu16+0x344>
bfc05cac:	00051042 	srl	v0,a1,0x1
bfc05cb0:	00402821 	move	a1,v0
bfc05cb4:	00075a02 	srl	t3,a3,0x8
bfc05cb8:	01656026 	xor	t4,t3,a1
bfc05cbc:	38ad4002 	xori	t5,a1,0x4002
bfc05cc0:	000d5042 	srl	t2,t5,0x1
bfc05cc4:	31870001 	andi	a3,t4,0x1
bfc05cc8:	000b2042 	srl	a0,t3,0x1
bfc05ccc:	35468000 	ori	a2,t2,0x8000
bfc05cd0:	14e0008a 	bnez	a3,bfc05efc <crcu16+0x36c>
bfc05cd4:	00051042 	srl	v0,a1,0x1
bfc05cd8:	00402821 	move	a1,v0
bfc05cdc:	0085c026 	xor	t8,a0,a1
bfc05ce0:	38b94002 	xori	t9,a1,0x4002
bfc05ce4:	00197842 	srl	t7,t9,0x1
bfc05ce8:	330e0001 	andi	t6,t8,0x1
bfc05cec:	00042042 	srl	a0,a0,0x1
bfc05cf0:	35e68000 	ori	a2,t7,0x8000
bfc05cf4:	15c0008a 	bnez	t6,bfc05f20 <crcu16+0x390>
bfc05cf8:	00051042 	srl	v0,a1,0x1
bfc05cfc:	00402821 	move	a1,v0
bfc05d00:	00854026 	xor	t0,a0,a1
bfc05d04:	38a94002 	xori	t1,a1,0x4002
bfc05d08:	00091042 	srl	v0,t1,0x1
bfc05d0c:	31030001 	andi	v1,t0,0x1
bfc05d10:	34468000 	ori	a2,v0,0x8000
bfc05d14:	00042042 	srl	a0,a0,0x1
bfc05d18:	1460008a 	bnez	v1,bfc05f44 <crcu16+0x3b4>
bfc05d1c:	00051042 	srl	v0,a1,0x1
bfc05d20:	00402821 	move	a1,v0
bfc05d24:	00853026 	xor	a2,a0,a1
bfc05d28:	38ab4002 	xori	t3,a1,0x4002
bfc05d2c:	000b5042 	srl	t2,t3,0x1
bfc05d30:	30c70001 	andi	a3,a2,0x1
bfc05d34:	00042042 	srl	a0,a0,0x1
bfc05d38:	35468000 	ori	a2,t2,0x8000
bfc05d3c:	14e0008a 	bnez	a3,bfc05f68 <crcu16+0x3d8>
bfc05d40:	00051042 	srl	v0,a1,0x1
bfc05d44:	00402821 	move	a1,v0
bfc05d48:	00857026 	xor	t6,a0,a1
bfc05d4c:	38af4002 	xori	t7,a1,0x4002
bfc05d50:	000f6842 	srl	t5,t7,0x1
bfc05d54:	31cc0001 	andi	t4,t6,0x1
bfc05d58:	00042042 	srl	a0,a0,0x1
bfc05d5c:	35a68000 	ori	a2,t5,0x8000
bfc05d60:	1580008a 	bnez	t4,bfc05f8c <crcu16+0x3fc>
bfc05d64:	00051042 	srl	v0,a1,0x1
bfc05d68:	00402821 	move	a1,v0
bfc05d6c:	00851826 	xor	v1,a0,a1
bfc05d70:	38a24002 	xori	v0,a1,0x4002
bfc05d74:	0002c842 	srl	t9,v0,0x1
bfc05d78:	30780001 	andi	t8,v1,0x1
bfc05d7c:	00042042 	srl	a0,a0,0x1
bfc05d80:	37268000 	ori	a2,t9,0x8000
bfc05d84:	1700008a 	bnez	t8,bfc05fb0 <crcu16+0x420>
bfc05d88:	00051042 	srl	v0,a1,0x1
bfc05d8c:	00402821 	move	a1,v0
bfc05d90:	00853826 	xor	a3,a0,a1
bfc05d94:	38aa4002 	xori	t2,a1,0x4002
bfc05d98:	000a4842 	srl	t1,t2,0x1
bfc05d9c:	30e80001 	andi	t0,a3,0x1
bfc05da0:	35268000 	ori	a2,t1,0x8000
bfc05da4:	1500008a 	bnez	t0,bfc05fd0 <crcu16+0x440>
bfc05da8:	00051042 	srl	v0,a1,0x1
bfc05dac:	00402821 	move	a1,v0
bfc05db0:	38a64002 	xori	a2,a1,0x4002
bfc05db4:	00066042 	srl	t4,a2,0x1
bfc05db8:	00042042 	srl	a0,a0,0x1
bfc05dbc:	30ab0001 	andi	t3,a1,0x1
bfc05dc0:	35868000 	ori	a2,t4,0x8000
bfc05dc4:	1564008a 	bne	t3,a0,bfc05ff0 <crcu16+0x460>
bfc05dc8:	00051042 	srl	v0,a1,0x1
bfc05dcc:	03e00008 	jr	ra
bfc05dd0:	3042ffff 	andi	v0,v0,0xffff
	...
bfc05de0:	00c02821 	move	a1,a2
bfc05de4:	00855826 	xor	t3,a0,a1
bfc05de8:	38ac4002 	xori	t4,a1,0x4002
bfc05dec:	000c5042 	srl	t2,t4,0x1
bfc05df0:	31690001 	andi	t1,t3,0x1
bfc05df4:	00042042 	srl	a0,a0,0x1
bfc05df8:	35468000 	ori	a2,t2,0x8000
bfc05dfc:	1120ff78 	beqz	t1,bfc05be0 <crcu16+0x50>
bfc05e00:	00051042 	srl	v0,a1,0x1
bfc05e04:	00c02821 	move	a1,a2
bfc05e08:	00857826 	xor	t7,a0,a1
bfc05e0c:	38b84002 	xori	t8,a1,0x4002
bfc05e10:	00187042 	srl	t6,t8,0x1
bfc05e14:	31ed0001 	andi	t5,t7,0x1
bfc05e18:	00042042 	srl	a0,a0,0x1
bfc05e1c:	35c68000 	ori	a2,t6,0x8000
bfc05e20:	11a0ff78 	beqz	t5,bfc05c04 <crcu16+0x74>
bfc05e24:	00051042 	srl	v0,a1,0x1
bfc05e28:	00c02821 	move	a1,a2
bfc05e2c:	00851826 	xor	v1,a0,a1
bfc05e30:	38a64002 	xori	a2,a1,0x4002
bfc05e34:	00061042 	srl	v0,a2,0x1
bfc05e38:	30790001 	andi	t9,v1,0x1
bfc05e3c:	34468000 	ori	a2,v0,0x8000
bfc05e40:	00042042 	srl	a0,a0,0x1
bfc05e44:	1320ff78 	beqz	t9,bfc05c28 <crcu16+0x98>
bfc05e48:	00051042 	srl	v0,a1,0x1
bfc05e4c:	00c02821 	move	a1,a2
bfc05e50:	00855026 	xor	t2,a0,a1
bfc05e54:	38ab4002 	xori	t3,a1,0x4002
bfc05e58:	000b4842 	srl	t1,t3,0x1
bfc05e5c:	31480001 	andi	t0,t2,0x1
bfc05e60:	00042042 	srl	a0,a0,0x1
bfc05e64:	35268000 	ori	a2,t1,0x8000
bfc05e68:	1100ff78 	beqz	t0,bfc05c4c <crcu16+0xbc>
bfc05e6c:	00051042 	srl	v0,a1,0x1
bfc05e70:	00c02821 	move	a1,a2
bfc05e74:	00857026 	xor	t6,a0,a1
bfc05e78:	38af4002 	xori	t7,a1,0x4002
bfc05e7c:	000f6842 	srl	t5,t7,0x1
bfc05e80:	31cc0001 	andi	t4,t6,0x1
bfc05e84:	00042042 	srl	a0,a0,0x1
bfc05e88:	35a68000 	ori	a2,t5,0x8000
bfc05e8c:	1180ff78 	beqz	t4,bfc05c70 <crcu16+0xe0>
bfc05e90:	00051042 	srl	v0,a1,0x1
bfc05e94:	00c02821 	move	a1,a2
bfc05e98:	38a24002 	xori	v0,a1,0x4002
bfc05e9c:	00851826 	xor	v1,a0,a1
bfc05ea0:	0002c842 	srl	t9,v0,0x1
bfc05ea4:	30780001 	andi	t8,v1,0x1
bfc05ea8:	37268000 	ori	a2,t9,0x8000
bfc05eac:	1300ff78 	beqz	t8,bfc05c90 <crcu16+0x100>
bfc05eb0:	00051042 	srl	v0,a1,0x1
bfc05eb4:	00c02821 	move	a1,a2
bfc05eb8:	38a64002 	xori	a2,a1,0x4002
bfc05ebc:	00064842 	srl	t1,a2,0x1
bfc05ec0:	00042042 	srl	a0,a0,0x1
bfc05ec4:	30a80001 	andi	t0,a1,0x1
bfc05ec8:	35268000 	ori	a2,t1,0x8000
bfc05ecc:	1104ff78 	beq	t0,a0,bfc05cb0 <crcu16+0x120>
bfc05ed0:	00051042 	srl	v0,a1,0x1
bfc05ed4:	00c02821 	move	a1,a2
bfc05ed8:	00075a02 	srl	t3,a3,0x8
bfc05edc:	01656026 	xor	t4,t3,a1
bfc05ee0:	38ad4002 	xori	t5,a1,0x4002
bfc05ee4:	000d5042 	srl	t2,t5,0x1
bfc05ee8:	31870001 	andi	a3,t4,0x1
bfc05eec:	000b2042 	srl	a0,t3,0x1
bfc05ef0:	35468000 	ori	a2,t2,0x8000
bfc05ef4:	10e0ff78 	beqz	a3,bfc05cd8 <crcu16+0x148>
bfc05ef8:	00051042 	srl	v0,a1,0x1
bfc05efc:	00c02821 	move	a1,a2
bfc05f00:	0085c026 	xor	t8,a0,a1
bfc05f04:	38b94002 	xori	t9,a1,0x4002
bfc05f08:	00197842 	srl	t7,t9,0x1
bfc05f0c:	330e0001 	andi	t6,t8,0x1
bfc05f10:	00042042 	srl	a0,a0,0x1
bfc05f14:	35e68000 	ori	a2,t7,0x8000
bfc05f18:	11c0ff78 	beqz	t6,bfc05cfc <crcu16+0x16c>
bfc05f1c:	00051042 	srl	v0,a1,0x1
bfc05f20:	00c02821 	move	a1,a2
bfc05f24:	00854026 	xor	t0,a0,a1
bfc05f28:	38a94002 	xori	t1,a1,0x4002
bfc05f2c:	00091042 	srl	v0,t1,0x1
bfc05f30:	31030001 	andi	v1,t0,0x1
bfc05f34:	34468000 	ori	a2,v0,0x8000
bfc05f38:	00042042 	srl	a0,a0,0x1
bfc05f3c:	1060ff78 	beqz	v1,bfc05d20 <crcu16+0x190>
bfc05f40:	00051042 	srl	v0,a1,0x1
bfc05f44:	00c02821 	move	a1,a2
bfc05f48:	00853026 	xor	a2,a0,a1
bfc05f4c:	38ab4002 	xori	t3,a1,0x4002
bfc05f50:	000b5042 	srl	t2,t3,0x1
bfc05f54:	30c70001 	andi	a3,a2,0x1
bfc05f58:	00042042 	srl	a0,a0,0x1
bfc05f5c:	35468000 	ori	a2,t2,0x8000
bfc05f60:	10e0ff78 	beqz	a3,bfc05d44 <crcu16+0x1b4>
bfc05f64:	00051042 	srl	v0,a1,0x1
bfc05f68:	00c02821 	move	a1,a2
bfc05f6c:	00857026 	xor	t6,a0,a1
bfc05f70:	38af4002 	xori	t7,a1,0x4002
bfc05f74:	000f6842 	srl	t5,t7,0x1
bfc05f78:	31cc0001 	andi	t4,t6,0x1
bfc05f7c:	00042042 	srl	a0,a0,0x1
bfc05f80:	35a68000 	ori	a2,t5,0x8000
bfc05f84:	1180ff78 	beqz	t4,bfc05d68 <crcu16+0x1d8>
bfc05f88:	00051042 	srl	v0,a1,0x1
bfc05f8c:	00c02821 	move	a1,a2
bfc05f90:	00851826 	xor	v1,a0,a1
bfc05f94:	38a24002 	xori	v0,a1,0x4002
bfc05f98:	0002c842 	srl	t9,v0,0x1
bfc05f9c:	30780001 	andi	t8,v1,0x1
bfc05fa0:	00042042 	srl	a0,a0,0x1
bfc05fa4:	37268000 	ori	a2,t9,0x8000
bfc05fa8:	1300ff78 	beqz	t8,bfc05d8c <crcu16+0x1fc>
bfc05fac:	00051042 	srl	v0,a1,0x1
bfc05fb0:	00c02821 	move	a1,a2
bfc05fb4:	00853826 	xor	a3,a0,a1
bfc05fb8:	38aa4002 	xori	t2,a1,0x4002
bfc05fbc:	000a4842 	srl	t1,t2,0x1
bfc05fc0:	30e80001 	andi	t0,a3,0x1
bfc05fc4:	35268000 	ori	a2,t1,0x8000
bfc05fc8:	1100ff78 	beqz	t0,bfc05dac <crcu16+0x21c>
bfc05fcc:	00051042 	srl	v0,a1,0x1
bfc05fd0:	00c02821 	move	a1,a2
bfc05fd4:	38a64002 	xori	a2,a1,0x4002
bfc05fd8:	00066042 	srl	t4,a2,0x1
bfc05fdc:	00042042 	srl	a0,a0,0x1
bfc05fe0:	30ab0001 	andi	t3,a1,0x1
bfc05fe4:	35868000 	ori	a2,t4,0x8000
bfc05fe8:	1164ff78 	beq	t3,a0,bfc05dcc <crcu16+0x23c>
bfc05fec:	00051042 	srl	v0,a1,0x1
bfc05ff0:	00c01021 	move	v0,a2
bfc05ff4:	03e00008 	jr	ra
bfc05ff8:	3042ffff 	andi	v0,v0,0xffff
bfc05ffc:	00000000 	nop

bfc06000 <crc16>:
crc16():
bfc06000:	3087ffff 	andi	a3,a0,0xffff
bfc06004:	30a5ffff 	andi	a1,a1,0xffff
bfc06008:	30e400ff 	andi	a0,a3,0xff
bfc0600c:	00a43026 	xor	a2,a1,a0
bfc06010:	38a84002 	xori	t0,a1,0x4002
bfc06014:	00081042 	srl	v0,t0,0x1
bfc06018:	30c30001 	andi	v1,a2,0x1
bfc0601c:	00042042 	srl	a0,a0,0x1
bfc06020:	34468000 	ori	a2,v0,0x8000
bfc06024:	1460008a 	bnez	v1,bfc06250 <crc16+0x250>
bfc06028:	00051042 	srl	v0,a1,0x1
bfc0602c:	00402821 	move	a1,v0
bfc06030:	00855826 	xor	t3,a0,a1
bfc06034:	38ac4002 	xori	t4,a1,0x4002
bfc06038:	000c5042 	srl	t2,t4,0x1
bfc0603c:	31690001 	andi	t1,t3,0x1
bfc06040:	00042042 	srl	a0,a0,0x1
bfc06044:	35468000 	ori	a2,t2,0x8000
bfc06048:	1520008a 	bnez	t1,bfc06274 <crc16+0x274>
bfc0604c:	00051042 	srl	v0,a1,0x1
bfc06050:	00402821 	move	a1,v0
bfc06054:	00857826 	xor	t7,a0,a1
bfc06058:	38b84002 	xori	t8,a1,0x4002
bfc0605c:	00187042 	srl	t6,t8,0x1
bfc06060:	31ed0001 	andi	t5,t7,0x1
bfc06064:	00042042 	srl	a0,a0,0x1
bfc06068:	35c68000 	ori	a2,t6,0x8000
bfc0606c:	15a0008a 	bnez	t5,bfc06298 <crc16+0x298>
bfc06070:	00051042 	srl	v0,a1,0x1
bfc06074:	00402821 	move	a1,v0
bfc06078:	00851826 	xor	v1,a0,a1
bfc0607c:	38a64002 	xori	a2,a1,0x4002
bfc06080:	00061042 	srl	v0,a2,0x1
bfc06084:	30790001 	andi	t9,v1,0x1
bfc06088:	34468000 	ori	a2,v0,0x8000
bfc0608c:	00042042 	srl	a0,a0,0x1
bfc06090:	1720008a 	bnez	t9,bfc062bc <crc16+0x2bc>
bfc06094:	00051042 	srl	v0,a1,0x1
bfc06098:	00402821 	move	a1,v0
bfc0609c:	00855026 	xor	t2,a0,a1
bfc060a0:	38ab4002 	xori	t3,a1,0x4002
bfc060a4:	000b4842 	srl	t1,t3,0x1
bfc060a8:	31480001 	andi	t0,t2,0x1
bfc060ac:	00042042 	srl	a0,a0,0x1
bfc060b0:	35268000 	ori	a2,t1,0x8000
bfc060b4:	1500008a 	bnez	t0,bfc062e0 <crc16+0x2e0>
bfc060b8:	00051042 	srl	v0,a1,0x1
bfc060bc:	00402821 	move	a1,v0
bfc060c0:	00857026 	xor	t6,a0,a1
bfc060c4:	38af4002 	xori	t7,a1,0x4002
bfc060c8:	000f6842 	srl	t5,t7,0x1
bfc060cc:	31cc0001 	andi	t4,t6,0x1
bfc060d0:	00042042 	srl	a0,a0,0x1
bfc060d4:	35a68000 	ori	a2,t5,0x8000
bfc060d8:	1580008a 	bnez	t4,bfc06304 <crc16+0x304>
bfc060dc:	00051042 	srl	v0,a1,0x1
bfc060e0:	00402821 	move	a1,v0
bfc060e4:	38a24002 	xori	v0,a1,0x4002
bfc060e8:	00851826 	xor	v1,a0,a1
bfc060ec:	0002c842 	srl	t9,v0,0x1
bfc060f0:	30780001 	andi	t8,v1,0x1
bfc060f4:	37268000 	ori	a2,t9,0x8000
bfc060f8:	1700008a 	bnez	t8,bfc06324 <crc16+0x324>
bfc060fc:	00051042 	srl	v0,a1,0x1
bfc06100:	00402821 	move	a1,v0
bfc06104:	38a64002 	xori	a2,a1,0x4002
bfc06108:	00064842 	srl	t1,a2,0x1
bfc0610c:	00042042 	srl	a0,a0,0x1
bfc06110:	30a80001 	andi	t0,a1,0x1
bfc06114:	35268000 	ori	a2,t1,0x8000
bfc06118:	1504008a 	bne	t0,a0,bfc06344 <crc16+0x344>
bfc0611c:	00051042 	srl	v0,a1,0x1
bfc06120:	00402821 	move	a1,v0
bfc06124:	00075a02 	srl	t3,a3,0x8
bfc06128:	01656026 	xor	t4,t3,a1
bfc0612c:	38ad4002 	xori	t5,a1,0x4002
bfc06130:	000d5042 	srl	t2,t5,0x1
bfc06134:	31870001 	andi	a3,t4,0x1
bfc06138:	000b2042 	srl	a0,t3,0x1
bfc0613c:	35468000 	ori	a2,t2,0x8000
bfc06140:	14e0008a 	bnez	a3,bfc0636c <crc16+0x36c>
bfc06144:	00051042 	srl	v0,a1,0x1
bfc06148:	00402821 	move	a1,v0
bfc0614c:	0085c026 	xor	t8,a0,a1
bfc06150:	38b94002 	xori	t9,a1,0x4002
bfc06154:	00197842 	srl	t7,t9,0x1
bfc06158:	330e0001 	andi	t6,t8,0x1
bfc0615c:	00042042 	srl	a0,a0,0x1
bfc06160:	35e68000 	ori	a2,t7,0x8000
bfc06164:	15c0008a 	bnez	t6,bfc06390 <crc16+0x390>
bfc06168:	00051042 	srl	v0,a1,0x1
bfc0616c:	00402821 	move	a1,v0
bfc06170:	00854026 	xor	t0,a0,a1
bfc06174:	38a94002 	xori	t1,a1,0x4002
bfc06178:	00091042 	srl	v0,t1,0x1
bfc0617c:	31030001 	andi	v1,t0,0x1
bfc06180:	34468000 	ori	a2,v0,0x8000
bfc06184:	00042042 	srl	a0,a0,0x1
bfc06188:	1460008a 	bnez	v1,bfc063b4 <crc16+0x3b4>
bfc0618c:	00051042 	srl	v0,a1,0x1
bfc06190:	00402821 	move	a1,v0
bfc06194:	00853026 	xor	a2,a0,a1
bfc06198:	38ab4002 	xori	t3,a1,0x4002
bfc0619c:	000b5042 	srl	t2,t3,0x1
bfc061a0:	30c70001 	andi	a3,a2,0x1
bfc061a4:	00042042 	srl	a0,a0,0x1
bfc061a8:	35468000 	ori	a2,t2,0x8000
bfc061ac:	14e0008a 	bnez	a3,bfc063d8 <crc16+0x3d8>
bfc061b0:	00051042 	srl	v0,a1,0x1
bfc061b4:	00402821 	move	a1,v0
bfc061b8:	00857026 	xor	t6,a0,a1
bfc061bc:	38af4002 	xori	t7,a1,0x4002
bfc061c0:	000f6842 	srl	t5,t7,0x1
bfc061c4:	31cc0001 	andi	t4,t6,0x1
bfc061c8:	00042042 	srl	a0,a0,0x1
bfc061cc:	35a68000 	ori	a2,t5,0x8000
bfc061d0:	1580008a 	bnez	t4,bfc063fc <crc16+0x3fc>
bfc061d4:	00051042 	srl	v0,a1,0x1
bfc061d8:	00402821 	move	a1,v0
bfc061dc:	00851826 	xor	v1,a0,a1
bfc061e0:	38a24002 	xori	v0,a1,0x4002
bfc061e4:	0002c842 	srl	t9,v0,0x1
bfc061e8:	30780001 	andi	t8,v1,0x1
bfc061ec:	00042042 	srl	a0,a0,0x1
bfc061f0:	37268000 	ori	a2,t9,0x8000
bfc061f4:	1700008a 	bnez	t8,bfc06420 <crc16+0x420>
bfc061f8:	00051042 	srl	v0,a1,0x1
bfc061fc:	00402821 	move	a1,v0
bfc06200:	00853826 	xor	a3,a0,a1
bfc06204:	38aa4002 	xori	t2,a1,0x4002
bfc06208:	000a4842 	srl	t1,t2,0x1
bfc0620c:	30e80001 	andi	t0,a3,0x1
bfc06210:	35268000 	ori	a2,t1,0x8000
bfc06214:	1500008a 	bnez	t0,bfc06440 <crc16+0x440>
bfc06218:	00051042 	srl	v0,a1,0x1
bfc0621c:	00402821 	move	a1,v0
bfc06220:	38a64002 	xori	a2,a1,0x4002
bfc06224:	00066042 	srl	t4,a2,0x1
bfc06228:	00042042 	srl	a0,a0,0x1
bfc0622c:	30ab0001 	andi	t3,a1,0x1
bfc06230:	35868000 	ori	a2,t4,0x8000
bfc06234:	1564008a 	bne	t3,a0,bfc06460 <crc16+0x460>
bfc06238:	00051042 	srl	v0,a1,0x1
bfc0623c:	03e00008 	jr	ra
bfc06240:	3042ffff 	andi	v0,v0,0xffff
	...
bfc06250:	00c02821 	move	a1,a2
bfc06254:	00855826 	xor	t3,a0,a1
bfc06258:	38ac4002 	xori	t4,a1,0x4002
bfc0625c:	000c5042 	srl	t2,t4,0x1
bfc06260:	31690001 	andi	t1,t3,0x1
bfc06264:	00042042 	srl	a0,a0,0x1
bfc06268:	35468000 	ori	a2,t2,0x8000
bfc0626c:	1120ff78 	beqz	t1,bfc06050 <crc16+0x50>
bfc06270:	00051042 	srl	v0,a1,0x1
bfc06274:	00c02821 	move	a1,a2
bfc06278:	00857826 	xor	t7,a0,a1
bfc0627c:	38b84002 	xori	t8,a1,0x4002
bfc06280:	00187042 	srl	t6,t8,0x1
bfc06284:	31ed0001 	andi	t5,t7,0x1
bfc06288:	00042042 	srl	a0,a0,0x1
bfc0628c:	35c68000 	ori	a2,t6,0x8000
bfc06290:	11a0ff78 	beqz	t5,bfc06074 <crc16+0x74>
bfc06294:	00051042 	srl	v0,a1,0x1
bfc06298:	00c02821 	move	a1,a2
bfc0629c:	00851826 	xor	v1,a0,a1
bfc062a0:	38a64002 	xori	a2,a1,0x4002
bfc062a4:	00061042 	srl	v0,a2,0x1
bfc062a8:	30790001 	andi	t9,v1,0x1
bfc062ac:	34468000 	ori	a2,v0,0x8000
bfc062b0:	00042042 	srl	a0,a0,0x1
bfc062b4:	1320ff78 	beqz	t9,bfc06098 <crc16+0x98>
bfc062b8:	00051042 	srl	v0,a1,0x1
bfc062bc:	00c02821 	move	a1,a2
bfc062c0:	00855026 	xor	t2,a0,a1
bfc062c4:	38ab4002 	xori	t3,a1,0x4002
bfc062c8:	000b4842 	srl	t1,t3,0x1
bfc062cc:	31480001 	andi	t0,t2,0x1
bfc062d0:	00042042 	srl	a0,a0,0x1
bfc062d4:	35268000 	ori	a2,t1,0x8000
bfc062d8:	1100ff78 	beqz	t0,bfc060bc <crc16+0xbc>
bfc062dc:	00051042 	srl	v0,a1,0x1
bfc062e0:	00c02821 	move	a1,a2
bfc062e4:	00857026 	xor	t6,a0,a1
bfc062e8:	38af4002 	xori	t7,a1,0x4002
bfc062ec:	000f6842 	srl	t5,t7,0x1
bfc062f0:	31cc0001 	andi	t4,t6,0x1
bfc062f4:	00042042 	srl	a0,a0,0x1
bfc062f8:	35a68000 	ori	a2,t5,0x8000
bfc062fc:	1180ff78 	beqz	t4,bfc060e0 <crc16+0xe0>
bfc06300:	00051042 	srl	v0,a1,0x1
bfc06304:	00c02821 	move	a1,a2
bfc06308:	38a24002 	xori	v0,a1,0x4002
bfc0630c:	00851826 	xor	v1,a0,a1
bfc06310:	0002c842 	srl	t9,v0,0x1
bfc06314:	30780001 	andi	t8,v1,0x1
bfc06318:	37268000 	ori	a2,t9,0x8000
bfc0631c:	1300ff78 	beqz	t8,bfc06100 <crc16+0x100>
bfc06320:	00051042 	srl	v0,a1,0x1
bfc06324:	00c02821 	move	a1,a2
bfc06328:	38a64002 	xori	a2,a1,0x4002
bfc0632c:	00064842 	srl	t1,a2,0x1
bfc06330:	00042042 	srl	a0,a0,0x1
bfc06334:	30a80001 	andi	t0,a1,0x1
bfc06338:	35268000 	ori	a2,t1,0x8000
bfc0633c:	1104ff78 	beq	t0,a0,bfc06120 <crc16+0x120>
bfc06340:	00051042 	srl	v0,a1,0x1
bfc06344:	00c02821 	move	a1,a2
bfc06348:	00075a02 	srl	t3,a3,0x8
bfc0634c:	01656026 	xor	t4,t3,a1
bfc06350:	38ad4002 	xori	t5,a1,0x4002
bfc06354:	000d5042 	srl	t2,t5,0x1
bfc06358:	31870001 	andi	a3,t4,0x1
bfc0635c:	000b2042 	srl	a0,t3,0x1
bfc06360:	35468000 	ori	a2,t2,0x8000
bfc06364:	10e0ff78 	beqz	a3,bfc06148 <crc16+0x148>
bfc06368:	00051042 	srl	v0,a1,0x1
bfc0636c:	00c02821 	move	a1,a2
bfc06370:	0085c026 	xor	t8,a0,a1
bfc06374:	38b94002 	xori	t9,a1,0x4002
bfc06378:	00197842 	srl	t7,t9,0x1
bfc0637c:	330e0001 	andi	t6,t8,0x1
bfc06380:	00042042 	srl	a0,a0,0x1
bfc06384:	35e68000 	ori	a2,t7,0x8000
bfc06388:	11c0ff78 	beqz	t6,bfc0616c <crc16+0x16c>
bfc0638c:	00051042 	srl	v0,a1,0x1
bfc06390:	00c02821 	move	a1,a2
bfc06394:	00854026 	xor	t0,a0,a1
bfc06398:	38a94002 	xori	t1,a1,0x4002
bfc0639c:	00091042 	srl	v0,t1,0x1
bfc063a0:	31030001 	andi	v1,t0,0x1
bfc063a4:	34468000 	ori	a2,v0,0x8000
bfc063a8:	00042042 	srl	a0,a0,0x1
bfc063ac:	1060ff78 	beqz	v1,bfc06190 <crc16+0x190>
bfc063b0:	00051042 	srl	v0,a1,0x1
bfc063b4:	00c02821 	move	a1,a2
bfc063b8:	00853026 	xor	a2,a0,a1
bfc063bc:	38ab4002 	xori	t3,a1,0x4002
bfc063c0:	000b5042 	srl	t2,t3,0x1
bfc063c4:	30c70001 	andi	a3,a2,0x1
bfc063c8:	00042042 	srl	a0,a0,0x1
bfc063cc:	35468000 	ori	a2,t2,0x8000
bfc063d0:	10e0ff78 	beqz	a3,bfc061b4 <crc16+0x1b4>
bfc063d4:	00051042 	srl	v0,a1,0x1
bfc063d8:	00c02821 	move	a1,a2
bfc063dc:	00857026 	xor	t6,a0,a1
bfc063e0:	38af4002 	xori	t7,a1,0x4002
bfc063e4:	000f6842 	srl	t5,t7,0x1
bfc063e8:	31cc0001 	andi	t4,t6,0x1
bfc063ec:	00042042 	srl	a0,a0,0x1
bfc063f0:	35a68000 	ori	a2,t5,0x8000
bfc063f4:	1180ff78 	beqz	t4,bfc061d8 <crc16+0x1d8>
bfc063f8:	00051042 	srl	v0,a1,0x1
bfc063fc:	00c02821 	move	a1,a2
bfc06400:	00851826 	xor	v1,a0,a1
bfc06404:	38a24002 	xori	v0,a1,0x4002
bfc06408:	0002c842 	srl	t9,v0,0x1
bfc0640c:	30780001 	andi	t8,v1,0x1
bfc06410:	00042042 	srl	a0,a0,0x1
bfc06414:	37268000 	ori	a2,t9,0x8000
bfc06418:	1300ff78 	beqz	t8,bfc061fc <crc16+0x1fc>
bfc0641c:	00051042 	srl	v0,a1,0x1
bfc06420:	00c02821 	move	a1,a2
bfc06424:	00853826 	xor	a3,a0,a1
bfc06428:	38aa4002 	xori	t2,a1,0x4002
bfc0642c:	000a4842 	srl	t1,t2,0x1
bfc06430:	30e80001 	andi	t0,a3,0x1
bfc06434:	35268000 	ori	a2,t1,0x8000
bfc06438:	1100ff78 	beqz	t0,bfc0621c <crc16+0x21c>
bfc0643c:	00051042 	srl	v0,a1,0x1
bfc06440:	00c02821 	move	a1,a2
bfc06444:	38a64002 	xori	a2,a1,0x4002
bfc06448:	00066042 	srl	t4,a2,0x1
bfc0644c:	00042042 	srl	a0,a0,0x1
bfc06450:	30ab0001 	andi	t3,a1,0x1
bfc06454:	35868000 	ori	a2,t4,0x8000
bfc06458:	1164ff78 	beq	t3,a0,bfc0623c <crc16+0x23c>
bfc0645c:	00051042 	srl	v0,a1,0x1
bfc06460:	00c01021 	move	v0,a2
bfc06464:	03e00008 	jr	ra
bfc06468:	3042ffff 	andi	v0,v0,0xffff
bfc0646c:	00000000 	nop

bfc06470 <crcu32>:
crcu32():
bfc06470:	3087ffff 	andi	a3,a0,0xffff
bfc06474:	30a5ffff 	andi	a1,a1,0xffff
bfc06478:	00804021 	move	t0,a0
bfc0647c:	30e400ff 	andi	a0,a3,0xff
bfc06480:	00a43026 	xor	a2,a1,a0
bfc06484:	38a94002 	xori	t1,a1,0x4002
bfc06488:	00091042 	srl	v0,t1,0x1
bfc0648c:	30c30001 	andi	v1,a2,0x1
bfc06490:	00042042 	srl	a0,a0,0x1
bfc06494:	34468000 	ori	a2,v0,0x8000
bfc06498:	14600119 	bnez	v1,bfc06900 <crcu32+0x490>
bfc0649c:	00051042 	srl	v0,a1,0x1
bfc064a0:	00402821 	move	a1,v0
bfc064a4:	00856026 	xor	t4,a0,a1
bfc064a8:	38ad4002 	xori	t5,a1,0x4002
bfc064ac:	000d5842 	srl	t3,t5,0x1
bfc064b0:	318a0001 	andi	t2,t4,0x1
bfc064b4:	00042042 	srl	a0,a0,0x1
bfc064b8:	35668000 	ori	a2,t3,0x8000
bfc064bc:	15400119 	bnez	t2,bfc06924 <crcu32+0x4b4>
bfc064c0:	00051042 	srl	v0,a1,0x1
bfc064c4:	00402821 	move	a1,v0
bfc064c8:	0085c026 	xor	t8,a0,a1
bfc064cc:	38b94002 	xori	t9,a1,0x4002
bfc064d0:	00197842 	srl	t7,t9,0x1
bfc064d4:	330e0001 	andi	t6,t8,0x1
bfc064d8:	00042042 	srl	a0,a0,0x1
bfc064dc:	35e68000 	ori	a2,t7,0x8000
bfc064e0:	15c00119 	bnez	t6,bfc06948 <crcu32+0x4d8>
bfc064e4:	00051042 	srl	v0,a1,0x1
bfc064e8:	00402821 	move	a1,v0
bfc064ec:	00853026 	xor	a2,a0,a1
bfc064f0:	38a94002 	xori	t1,a1,0x4002
bfc064f4:	00091042 	srl	v0,t1,0x1
bfc064f8:	30c30001 	andi	v1,a2,0x1
bfc064fc:	00042042 	srl	a0,a0,0x1
bfc06500:	34468000 	ori	a2,v0,0x8000
bfc06504:	14600119 	bnez	v1,bfc0696c <crcu32+0x4fc>
bfc06508:	00051042 	srl	v0,a1,0x1
bfc0650c:	00402821 	move	a1,v0
bfc06510:	00856026 	xor	t4,a0,a1
bfc06514:	38ad4002 	xori	t5,a1,0x4002
bfc06518:	000d5842 	srl	t3,t5,0x1
bfc0651c:	318a0001 	andi	t2,t4,0x1
bfc06520:	00042042 	srl	a0,a0,0x1
bfc06524:	35668000 	ori	a2,t3,0x8000
bfc06528:	15400119 	bnez	t2,bfc06990 <crcu32+0x520>
bfc0652c:	00051042 	srl	v0,a1,0x1
bfc06530:	00402821 	move	a1,v0
bfc06534:	0085c026 	xor	t8,a0,a1
bfc06538:	38b94002 	xori	t9,a1,0x4002
bfc0653c:	00197842 	srl	t7,t9,0x1
bfc06540:	330e0001 	andi	t6,t8,0x1
bfc06544:	00042042 	srl	a0,a0,0x1
bfc06548:	35e68000 	ori	a2,t7,0x8000
bfc0654c:	15c00119 	bnez	t6,bfc069b4 <crcu32+0x544>
bfc06550:	00051042 	srl	v0,a1,0x1
bfc06554:	00402821 	move	a1,v0
bfc06558:	00853026 	xor	a2,a0,a1
bfc0655c:	38a94002 	xori	t1,a1,0x4002
bfc06560:	00091042 	srl	v0,t1,0x1
bfc06564:	30c30001 	andi	v1,a2,0x1
bfc06568:	34468000 	ori	a2,v0,0x8000
bfc0656c:	14600119 	bnez	v1,bfc069d4 <crcu32+0x564>
bfc06570:	00051042 	srl	v0,a1,0x1
bfc06574:	00402821 	move	a1,v0
bfc06578:	38ac4002 	xori	t4,a1,0x4002
bfc0657c:	000c5842 	srl	t3,t4,0x1
bfc06580:	00042042 	srl	a0,a0,0x1
bfc06584:	30aa0001 	andi	t2,a1,0x1
bfc06588:	35668000 	ori	a2,t3,0x8000
bfc0658c:	15440119 	bne	t2,a0,bfc069f4 <crcu32+0x584>
bfc06590:	00051042 	srl	v0,a1,0x1
bfc06594:	00402821 	move	a1,v0
bfc06598:	00077202 	srl	t6,a3,0x8
bfc0659c:	01c57826 	xor	t7,t6,a1
bfc065a0:	38b84002 	xori	t8,a1,0x4002
bfc065a4:	00186842 	srl	t5,t8,0x1
bfc065a8:	31e70001 	andi	a3,t7,0x1
bfc065ac:	000e2042 	srl	a0,t6,0x1
bfc065b0:	35a68000 	ori	a2,t5,0x8000
bfc065b4:	14e00119 	bnez	a3,bfc06a1c <crcu32+0x5ac>
bfc065b8:	00051042 	srl	v0,a1,0x1
bfc065bc:	00402821 	move	a1,v0
bfc065c0:	00851826 	xor	v1,a0,a1
bfc065c4:	38a64002 	xori	a2,a1,0x4002
bfc065c8:	00061042 	srl	v0,a2,0x1
bfc065cc:	30790001 	andi	t9,v1,0x1
bfc065d0:	34468000 	ori	a2,v0,0x8000
bfc065d4:	00042042 	srl	a0,a0,0x1
bfc065d8:	17200119 	bnez	t9,bfc06a40 <crcu32+0x5d0>
bfc065dc:	00051042 	srl	v0,a1,0x1
bfc065e0:	00402821 	move	a1,v0
bfc065e4:	00855826 	xor	t3,a0,a1
bfc065e8:	38ac4002 	xori	t4,a1,0x4002
bfc065ec:	000c5042 	srl	t2,t4,0x1
bfc065f0:	31690001 	andi	t1,t3,0x1
bfc065f4:	00042042 	srl	a0,a0,0x1
bfc065f8:	35468000 	ori	a2,t2,0x8000
bfc065fc:	15200119 	bnez	t1,bfc06a64 <crcu32+0x5f4>
bfc06600:	00051042 	srl	v0,a1,0x1
bfc06604:	00402821 	move	a1,v0
bfc06608:	00857026 	xor	t6,a0,a1
bfc0660c:	38af4002 	xori	t7,a1,0x4002
bfc06610:	000f6842 	srl	t5,t7,0x1
bfc06614:	31c70001 	andi	a3,t6,0x1
bfc06618:	00042042 	srl	a0,a0,0x1
bfc0661c:	35a68000 	ori	a2,t5,0x8000
bfc06620:	14e00119 	bnez	a3,bfc06a88 <crcu32+0x618>
bfc06624:	00051042 	srl	v0,a1,0x1
bfc06628:	00402821 	move	a1,v0
bfc0662c:	00851826 	xor	v1,a0,a1
bfc06630:	38a24002 	xori	v0,a1,0x4002
bfc06634:	0002c842 	srl	t9,v0,0x1
bfc06638:	30780001 	andi	t8,v1,0x1
bfc0663c:	00042042 	srl	a0,a0,0x1
bfc06640:	37268000 	ori	a2,t9,0x8000
bfc06644:	17000119 	bnez	t8,bfc06aac <crcu32+0x63c>
bfc06648:	00051042 	srl	v0,a1,0x1
bfc0664c:	00402821 	move	a1,v0
bfc06650:	00853026 	xor	a2,a0,a1
bfc06654:	38ab4002 	xori	t3,a1,0x4002
bfc06658:	000b5042 	srl	t2,t3,0x1
bfc0665c:	30c90001 	andi	t1,a2,0x1
bfc06660:	00042042 	srl	a0,a0,0x1
bfc06664:	35468000 	ori	a2,t2,0x8000
bfc06668:	15200119 	bnez	t1,bfc06ad0 <crcu32+0x660>
bfc0666c:	00051042 	srl	v0,a1,0x1
bfc06670:	00402821 	move	a1,v0
bfc06674:	00856826 	xor	t5,a0,a1
bfc06678:	38ae4002 	xori	t6,a1,0x4002
bfc0667c:	000e3842 	srl	a3,t6,0x1
bfc06680:	31ac0001 	andi	t4,t5,0x1
bfc06684:	34e68000 	ori	a2,a3,0x8000
bfc06688:	15800119 	bnez	t4,bfc06af0 <crcu32+0x680>
bfc0668c:	00051042 	srl	v0,a1,0x1
bfc06690:	00402821 	move	a1,v0
bfc06694:	38b94002 	xori	t9,a1,0x4002
bfc06698:	0019c042 	srl	t8,t9,0x1
bfc0669c:	00042042 	srl	a0,a0,0x1
bfc066a0:	30af0001 	andi	t7,a1,0x1
bfc066a4:	37068000 	ori	a2,t8,0x8000
bfc066a8:	15e40119 	bne	t7,a0,bfc06b10 <crcu32+0x6a0>
bfc066ac:	00051042 	srl	v0,a1,0x1
bfc066b0:	00083c02 	srl	a3,t0,0x10
bfc066b4:	00402821 	move	a1,v0
bfc066b8:	30e900ff 	andi	t1,a3,0xff
bfc066bc:	01251826 	xor	v1,t1,a1
bfc066c0:	38aa4002 	xori	t2,a1,0x4002
bfc066c4:	000a1042 	srl	v0,t2,0x1
bfc066c8:	30680001 	andi	t0,v1,0x1
bfc066cc:	34468000 	ori	a2,v0,0x8000
bfc066d0:	00092042 	srl	a0,t1,0x1
bfc066d4:	15000119 	bnez	t0,bfc06b3c <crcu32+0x6cc>
bfc066d8:	00051042 	srl	v0,a1,0x1
bfc066dc:	00402821 	move	a1,v0
bfc066e0:	00853026 	xor	a2,a0,a1
bfc066e4:	38ad4002 	xori	t5,a1,0x4002
bfc066e8:	000d6042 	srl	t4,t5,0x1
bfc066ec:	30cb0001 	andi	t3,a2,0x1
bfc066f0:	00042042 	srl	a0,a0,0x1
bfc066f4:	35868000 	ori	a2,t4,0x8000
bfc066f8:	15600119 	bnez	t3,bfc06b60 <crcu32+0x6f0>
bfc066fc:	00051042 	srl	v0,a1,0x1
bfc06700:	00402821 	move	a1,v0
bfc06704:	0085c026 	xor	t8,a0,a1
bfc06708:	38b94002 	xori	t9,a1,0x4002
bfc0670c:	00197842 	srl	t7,t9,0x1
bfc06710:	330e0001 	andi	t6,t8,0x1
bfc06714:	00042042 	srl	a0,a0,0x1
bfc06718:	35e68000 	ori	a2,t7,0x8000
bfc0671c:	15c00119 	bnez	t6,bfc06b84 <crcu32+0x714>
bfc06720:	00051042 	srl	v0,a1,0x1
bfc06724:	00402821 	move	a1,v0
bfc06728:	00854826 	xor	t1,a0,a1
bfc0672c:	38a34002 	xori	v1,a1,0x4002
bfc06730:	00031042 	srl	v0,v1,0x1
bfc06734:	31280001 	andi	t0,t1,0x1
bfc06738:	34468000 	ori	a2,v0,0x8000
bfc0673c:	00042042 	srl	a0,a0,0x1
bfc06740:	15000119 	bnez	t0,bfc06ba8 <crcu32+0x738>
bfc06744:	00051042 	srl	v0,a1,0x1
bfc06748:	00402821 	move	a1,v0
bfc0674c:	00856026 	xor	t4,a0,a1
bfc06750:	38a64002 	xori	a2,a1,0x4002
bfc06754:	00065842 	srl	t3,a2,0x1
bfc06758:	318a0001 	andi	t2,t4,0x1
bfc0675c:	00042042 	srl	a0,a0,0x1
bfc06760:	35668000 	ori	a2,t3,0x8000
bfc06764:	15400119 	bnez	t2,bfc06bcc <crcu32+0x75c>
bfc06768:	00051042 	srl	v0,a1,0x1
bfc0676c:	00402821 	move	a1,v0
bfc06770:	00857826 	xor	t7,a0,a1
bfc06774:	38b84002 	xori	t8,a1,0x4002
bfc06778:	00187042 	srl	t6,t8,0x1
bfc0677c:	31ed0001 	andi	t5,t7,0x1
bfc06780:	00042042 	srl	a0,a0,0x1
bfc06784:	35c68000 	ori	a2,t6,0x8000
bfc06788:	15a00119 	bnez	t5,bfc06bf0 <crcu32+0x780>
bfc0678c:	00051042 	srl	v0,a1,0x1
bfc06790:	00402821 	move	a1,v0
bfc06794:	38a24002 	xori	v0,a1,0x4002
bfc06798:	00854826 	xor	t1,a0,a1
bfc0679c:	00024042 	srl	t0,v0,0x1
bfc067a0:	31390001 	andi	t9,t1,0x1
bfc067a4:	35068000 	ori	a2,t0,0x8000
bfc067a8:	17200119 	bnez	t9,bfc06c10 <crcu32+0x7a0>
bfc067ac:	00051042 	srl	v0,a1,0x1
bfc067b0:	00402821 	move	a1,v0
bfc067b4:	38ab4002 	xori	t3,a1,0x4002
bfc067b8:	000b5042 	srl	t2,t3,0x1
bfc067bc:	00042042 	srl	a0,a0,0x1
bfc067c0:	30a30001 	andi	v1,a1,0x1
bfc067c4:	35468000 	ori	a2,t2,0x8000
bfc067c8:	14640119 	bne	v1,a0,bfc06c30 <crcu32+0x7c0>
bfc067cc:	00051042 	srl	v0,a1,0x1
bfc067d0:	00073202 	srl	a2,a3,0x8
bfc067d4:	00402821 	move	a1,v0
bfc067d8:	00c56826 	xor	t5,a2,a1
bfc067dc:	38ae4002 	xori	t6,a1,0x4002
bfc067e0:	000e6042 	srl	t4,t6,0x1
bfc067e4:	31a70001 	andi	a3,t5,0x1
bfc067e8:	00062042 	srl	a0,a2,0x1
bfc067ec:	00051042 	srl	v0,a1,0x1
bfc067f0:	14e00119 	bnez	a3,bfc06c58 <crcu32+0x7e8>
bfc067f4:	35868000 	ori	a2,t4,0x8000
bfc067f8:	00402821 	move	a1,v0
bfc067fc:	0085c826 	xor	t9,a0,a1
bfc06800:	38a84002 	xori	t0,a1,0x4002
bfc06804:	0008c042 	srl	t8,t0,0x1
bfc06808:	332f0001 	andi	t7,t9,0x1
bfc0680c:	00042042 	srl	a0,a0,0x1
bfc06810:	37068000 	ori	a2,t8,0x8000
bfc06814:	15e00119 	bnez	t7,bfc06c7c <crcu32+0x80c>
bfc06818:	00051042 	srl	v0,a1,0x1
bfc0681c:	00402821 	move	a1,v0
bfc06820:	00851826 	xor	v1,a0,a1
bfc06824:	38aa4002 	xori	t2,a1,0x4002
bfc06828:	000a1042 	srl	v0,t2,0x1
bfc0682c:	30690001 	andi	t1,v1,0x1
bfc06830:	34468000 	ori	a2,v0,0x8000
bfc06834:	00042042 	srl	a0,a0,0x1
bfc06838:	15200119 	bnez	t1,bfc06ca0 <crcu32+0x830>
bfc0683c:	00051042 	srl	v0,a1,0x1
bfc06840:	00402821 	move	a1,v0
bfc06844:	00856026 	xor	t4,a0,a1
bfc06848:	38a64002 	xori	a2,a1,0x4002
bfc0684c:	00063842 	srl	a3,a2,0x1
bfc06850:	318b0001 	andi	t3,t4,0x1
bfc06854:	00042042 	srl	a0,a0,0x1
bfc06858:	34e68000 	ori	a2,a3,0x8000
bfc0685c:	15600119 	bnez	t3,bfc06cc4 <crcu32+0x854>
bfc06860:	00051042 	srl	v0,a1,0x1
bfc06864:	00402821 	move	a1,v0
bfc06868:	00857826 	xor	t7,a0,a1
bfc0686c:	38b84002 	xori	t8,a1,0x4002
bfc06870:	00187042 	srl	t6,t8,0x1
bfc06874:	31ed0001 	andi	t5,t7,0x1
bfc06878:	00042042 	srl	a0,a0,0x1
bfc0687c:	35c68000 	ori	a2,t6,0x8000
bfc06880:	15a00119 	bnez	t5,bfc06ce8 <crcu32+0x878>
bfc06884:	00051042 	srl	v0,a1,0x1
bfc06888:	00402821 	move	a1,v0
bfc0688c:	00854826 	xor	t1,a0,a1
bfc06890:	38a24002 	xori	v0,a1,0x4002
bfc06894:	00024042 	srl	t0,v0,0x1
bfc06898:	31390001 	andi	t9,t1,0x1
bfc0689c:	00042042 	srl	a0,a0,0x1
bfc068a0:	35068000 	ori	a2,t0,0x8000
bfc068a4:	17200119 	bnez	t9,bfc06d0c <crcu32+0x89c>
bfc068a8:	00051042 	srl	v0,a1,0x1
bfc068ac:	00402821 	move	a1,v0
bfc068b0:	00855826 	xor	t3,a0,a1
bfc068b4:	38a74002 	xori	a3,a1,0x4002
bfc068b8:	00075042 	srl	t2,a3,0x1
bfc068bc:	31630001 	andi	v1,t3,0x1
bfc068c0:	35468000 	ori	a2,t2,0x8000
bfc068c4:	14600119 	bnez	v1,bfc06d2c <crcu32+0x8bc>
bfc068c8:	00051042 	srl	v0,a1,0x1
bfc068cc:	00402821 	move	a1,v0
bfc068d0:	38a64002 	xori	a2,a1,0x4002
bfc068d4:	00066842 	srl	t5,a2,0x1
bfc068d8:	00042042 	srl	a0,a0,0x1
bfc068dc:	30ac0001 	andi	t4,a1,0x1
bfc068e0:	35a68000 	ori	a2,t5,0x8000
bfc068e4:	15840119 	bne	t4,a0,bfc06d4c <crcu32+0x8dc>
bfc068e8:	00051042 	srl	v0,a1,0x1
bfc068ec:	03e00008 	jr	ra
bfc068f0:	3042ffff 	andi	v0,v0,0xffff
	...
bfc06900:	00c02821 	move	a1,a2
bfc06904:	00856026 	xor	t4,a0,a1
bfc06908:	38ad4002 	xori	t5,a1,0x4002
bfc0690c:	000d5842 	srl	t3,t5,0x1
bfc06910:	318a0001 	andi	t2,t4,0x1
bfc06914:	00042042 	srl	a0,a0,0x1
bfc06918:	35668000 	ori	a2,t3,0x8000
bfc0691c:	1140fee9 	beqz	t2,bfc064c4 <crcu32+0x54>
bfc06920:	00051042 	srl	v0,a1,0x1
bfc06924:	00c02821 	move	a1,a2
bfc06928:	0085c026 	xor	t8,a0,a1
bfc0692c:	38b94002 	xori	t9,a1,0x4002
bfc06930:	00197842 	srl	t7,t9,0x1
bfc06934:	330e0001 	andi	t6,t8,0x1
bfc06938:	00042042 	srl	a0,a0,0x1
bfc0693c:	35e68000 	ori	a2,t7,0x8000
bfc06940:	11c0fee9 	beqz	t6,bfc064e8 <crcu32+0x78>
bfc06944:	00051042 	srl	v0,a1,0x1
bfc06948:	00c02821 	move	a1,a2
bfc0694c:	00853026 	xor	a2,a0,a1
bfc06950:	38a94002 	xori	t1,a1,0x4002
bfc06954:	00091042 	srl	v0,t1,0x1
bfc06958:	30c30001 	andi	v1,a2,0x1
bfc0695c:	00042042 	srl	a0,a0,0x1
bfc06960:	34468000 	ori	a2,v0,0x8000
bfc06964:	1060fee9 	beqz	v1,bfc0650c <crcu32+0x9c>
bfc06968:	00051042 	srl	v0,a1,0x1
bfc0696c:	00c02821 	move	a1,a2
bfc06970:	00856026 	xor	t4,a0,a1
bfc06974:	38ad4002 	xori	t5,a1,0x4002
bfc06978:	000d5842 	srl	t3,t5,0x1
bfc0697c:	318a0001 	andi	t2,t4,0x1
bfc06980:	00042042 	srl	a0,a0,0x1
bfc06984:	35668000 	ori	a2,t3,0x8000
bfc06988:	1140fee9 	beqz	t2,bfc06530 <crcu32+0xc0>
bfc0698c:	00051042 	srl	v0,a1,0x1
bfc06990:	00c02821 	move	a1,a2
bfc06994:	0085c026 	xor	t8,a0,a1
bfc06998:	38b94002 	xori	t9,a1,0x4002
bfc0699c:	00197842 	srl	t7,t9,0x1
bfc069a0:	330e0001 	andi	t6,t8,0x1
bfc069a4:	00042042 	srl	a0,a0,0x1
bfc069a8:	35e68000 	ori	a2,t7,0x8000
bfc069ac:	11c0fee9 	beqz	t6,bfc06554 <crcu32+0xe4>
bfc069b0:	00051042 	srl	v0,a1,0x1
bfc069b4:	00c02821 	move	a1,a2
bfc069b8:	00853026 	xor	a2,a0,a1
bfc069bc:	38a94002 	xori	t1,a1,0x4002
bfc069c0:	00091042 	srl	v0,t1,0x1
bfc069c4:	30c30001 	andi	v1,a2,0x1
bfc069c8:	34468000 	ori	a2,v0,0x8000
bfc069cc:	1060fee9 	beqz	v1,bfc06574 <crcu32+0x104>
bfc069d0:	00051042 	srl	v0,a1,0x1
bfc069d4:	00c02821 	move	a1,a2
bfc069d8:	38ac4002 	xori	t4,a1,0x4002
bfc069dc:	000c5842 	srl	t3,t4,0x1
bfc069e0:	00042042 	srl	a0,a0,0x1
bfc069e4:	30aa0001 	andi	t2,a1,0x1
bfc069e8:	35668000 	ori	a2,t3,0x8000
bfc069ec:	1144fee9 	beq	t2,a0,bfc06594 <crcu32+0x124>
bfc069f0:	00051042 	srl	v0,a1,0x1
bfc069f4:	00c02821 	move	a1,a2
bfc069f8:	00077202 	srl	t6,a3,0x8
bfc069fc:	01c57826 	xor	t7,t6,a1
bfc06a00:	38b84002 	xori	t8,a1,0x4002
bfc06a04:	00186842 	srl	t5,t8,0x1
bfc06a08:	31e70001 	andi	a3,t7,0x1
bfc06a0c:	000e2042 	srl	a0,t6,0x1
bfc06a10:	35a68000 	ori	a2,t5,0x8000
bfc06a14:	10e0fee9 	beqz	a3,bfc065bc <crcu32+0x14c>
bfc06a18:	00051042 	srl	v0,a1,0x1
bfc06a1c:	00c02821 	move	a1,a2
bfc06a20:	00851826 	xor	v1,a0,a1
bfc06a24:	38a64002 	xori	a2,a1,0x4002
bfc06a28:	00061042 	srl	v0,a2,0x1
bfc06a2c:	30790001 	andi	t9,v1,0x1
bfc06a30:	34468000 	ori	a2,v0,0x8000
bfc06a34:	00042042 	srl	a0,a0,0x1
bfc06a38:	1320fee9 	beqz	t9,bfc065e0 <crcu32+0x170>
bfc06a3c:	00051042 	srl	v0,a1,0x1
bfc06a40:	00c02821 	move	a1,a2
bfc06a44:	00855826 	xor	t3,a0,a1
bfc06a48:	38ac4002 	xori	t4,a1,0x4002
bfc06a4c:	000c5042 	srl	t2,t4,0x1
bfc06a50:	31690001 	andi	t1,t3,0x1
bfc06a54:	00042042 	srl	a0,a0,0x1
bfc06a58:	35468000 	ori	a2,t2,0x8000
bfc06a5c:	1120fee9 	beqz	t1,bfc06604 <crcu32+0x194>
bfc06a60:	00051042 	srl	v0,a1,0x1
bfc06a64:	00c02821 	move	a1,a2
bfc06a68:	00857026 	xor	t6,a0,a1
bfc06a6c:	38af4002 	xori	t7,a1,0x4002
bfc06a70:	000f6842 	srl	t5,t7,0x1
bfc06a74:	31c70001 	andi	a3,t6,0x1
bfc06a78:	00042042 	srl	a0,a0,0x1
bfc06a7c:	35a68000 	ori	a2,t5,0x8000
bfc06a80:	10e0fee9 	beqz	a3,bfc06628 <crcu32+0x1b8>
bfc06a84:	00051042 	srl	v0,a1,0x1
bfc06a88:	00c02821 	move	a1,a2
bfc06a8c:	00851826 	xor	v1,a0,a1
bfc06a90:	38a24002 	xori	v0,a1,0x4002
bfc06a94:	0002c842 	srl	t9,v0,0x1
bfc06a98:	30780001 	andi	t8,v1,0x1
bfc06a9c:	00042042 	srl	a0,a0,0x1
bfc06aa0:	37268000 	ori	a2,t9,0x8000
bfc06aa4:	1300fee9 	beqz	t8,bfc0664c <crcu32+0x1dc>
bfc06aa8:	00051042 	srl	v0,a1,0x1
bfc06aac:	00c02821 	move	a1,a2
bfc06ab0:	00853026 	xor	a2,a0,a1
bfc06ab4:	38ab4002 	xori	t3,a1,0x4002
bfc06ab8:	000b5042 	srl	t2,t3,0x1
bfc06abc:	30c90001 	andi	t1,a2,0x1
bfc06ac0:	00042042 	srl	a0,a0,0x1
bfc06ac4:	35468000 	ori	a2,t2,0x8000
bfc06ac8:	1120fee9 	beqz	t1,bfc06670 <crcu32+0x200>
bfc06acc:	00051042 	srl	v0,a1,0x1
bfc06ad0:	00c02821 	move	a1,a2
bfc06ad4:	00856826 	xor	t5,a0,a1
bfc06ad8:	38ae4002 	xori	t6,a1,0x4002
bfc06adc:	000e3842 	srl	a3,t6,0x1
bfc06ae0:	31ac0001 	andi	t4,t5,0x1
bfc06ae4:	34e68000 	ori	a2,a3,0x8000
bfc06ae8:	1180fee9 	beqz	t4,bfc06690 <crcu32+0x220>
bfc06aec:	00051042 	srl	v0,a1,0x1
bfc06af0:	00c02821 	move	a1,a2
bfc06af4:	38b94002 	xori	t9,a1,0x4002
bfc06af8:	0019c042 	srl	t8,t9,0x1
bfc06afc:	00042042 	srl	a0,a0,0x1
bfc06b00:	30af0001 	andi	t7,a1,0x1
bfc06b04:	37068000 	ori	a2,t8,0x8000
bfc06b08:	11e4fee9 	beq	t7,a0,bfc066b0 <crcu32+0x240>
bfc06b0c:	00051042 	srl	v0,a1,0x1
bfc06b10:	00083c02 	srl	a3,t0,0x10
bfc06b14:	00c02821 	move	a1,a2
bfc06b18:	30e900ff 	andi	t1,a3,0xff
bfc06b1c:	01251826 	xor	v1,t1,a1
bfc06b20:	38aa4002 	xori	t2,a1,0x4002
bfc06b24:	000a1042 	srl	v0,t2,0x1
bfc06b28:	30680001 	andi	t0,v1,0x1
bfc06b2c:	34468000 	ori	a2,v0,0x8000
bfc06b30:	00092042 	srl	a0,t1,0x1
bfc06b34:	1100fee9 	beqz	t0,bfc066dc <crcu32+0x26c>
bfc06b38:	00051042 	srl	v0,a1,0x1
bfc06b3c:	00c02821 	move	a1,a2
bfc06b40:	00853026 	xor	a2,a0,a1
bfc06b44:	38ad4002 	xori	t5,a1,0x4002
bfc06b48:	000d6042 	srl	t4,t5,0x1
bfc06b4c:	30cb0001 	andi	t3,a2,0x1
bfc06b50:	00042042 	srl	a0,a0,0x1
bfc06b54:	35868000 	ori	a2,t4,0x8000
bfc06b58:	1160fee9 	beqz	t3,bfc06700 <crcu32+0x290>
bfc06b5c:	00051042 	srl	v0,a1,0x1
bfc06b60:	00c02821 	move	a1,a2
bfc06b64:	0085c026 	xor	t8,a0,a1
bfc06b68:	38b94002 	xori	t9,a1,0x4002
bfc06b6c:	00197842 	srl	t7,t9,0x1
bfc06b70:	330e0001 	andi	t6,t8,0x1
bfc06b74:	00042042 	srl	a0,a0,0x1
bfc06b78:	35e68000 	ori	a2,t7,0x8000
bfc06b7c:	11c0fee9 	beqz	t6,bfc06724 <crcu32+0x2b4>
bfc06b80:	00051042 	srl	v0,a1,0x1
bfc06b84:	00c02821 	move	a1,a2
bfc06b88:	00854826 	xor	t1,a0,a1
bfc06b8c:	38a34002 	xori	v1,a1,0x4002
bfc06b90:	00031042 	srl	v0,v1,0x1
bfc06b94:	31280001 	andi	t0,t1,0x1
bfc06b98:	34468000 	ori	a2,v0,0x8000
bfc06b9c:	00042042 	srl	a0,a0,0x1
bfc06ba0:	1100fee9 	beqz	t0,bfc06748 <crcu32+0x2d8>
bfc06ba4:	00051042 	srl	v0,a1,0x1
bfc06ba8:	00c02821 	move	a1,a2
bfc06bac:	00856026 	xor	t4,a0,a1
bfc06bb0:	38a64002 	xori	a2,a1,0x4002
bfc06bb4:	00065842 	srl	t3,a2,0x1
bfc06bb8:	318a0001 	andi	t2,t4,0x1
bfc06bbc:	00042042 	srl	a0,a0,0x1
bfc06bc0:	35668000 	ori	a2,t3,0x8000
bfc06bc4:	1140fee9 	beqz	t2,bfc0676c <crcu32+0x2fc>
bfc06bc8:	00051042 	srl	v0,a1,0x1
bfc06bcc:	00c02821 	move	a1,a2
bfc06bd0:	00857826 	xor	t7,a0,a1
bfc06bd4:	38b84002 	xori	t8,a1,0x4002
bfc06bd8:	00187042 	srl	t6,t8,0x1
bfc06bdc:	31ed0001 	andi	t5,t7,0x1
bfc06be0:	00042042 	srl	a0,a0,0x1
bfc06be4:	35c68000 	ori	a2,t6,0x8000
bfc06be8:	11a0fee9 	beqz	t5,bfc06790 <crcu32+0x320>
bfc06bec:	00051042 	srl	v0,a1,0x1
bfc06bf0:	00c02821 	move	a1,a2
bfc06bf4:	38a24002 	xori	v0,a1,0x4002
bfc06bf8:	00854826 	xor	t1,a0,a1
bfc06bfc:	00024042 	srl	t0,v0,0x1
bfc06c00:	31390001 	andi	t9,t1,0x1
bfc06c04:	35068000 	ori	a2,t0,0x8000
bfc06c08:	1320fee9 	beqz	t9,bfc067b0 <crcu32+0x340>
bfc06c0c:	00051042 	srl	v0,a1,0x1
bfc06c10:	00c02821 	move	a1,a2
bfc06c14:	38ab4002 	xori	t3,a1,0x4002
bfc06c18:	000b5042 	srl	t2,t3,0x1
bfc06c1c:	00042042 	srl	a0,a0,0x1
bfc06c20:	30a30001 	andi	v1,a1,0x1
bfc06c24:	35468000 	ori	a2,t2,0x8000
bfc06c28:	1064fee9 	beq	v1,a0,bfc067d0 <crcu32+0x360>
bfc06c2c:	00051042 	srl	v0,a1,0x1
bfc06c30:	00c02821 	move	a1,a2
bfc06c34:	00073202 	srl	a2,a3,0x8
bfc06c38:	00c56826 	xor	t5,a2,a1
bfc06c3c:	38ae4002 	xori	t6,a1,0x4002
bfc06c40:	000e6042 	srl	t4,t6,0x1
bfc06c44:	31a70001 	andi	a3,t5,0x1
bfc06c48:	00062042 	srl	a0,a2,0x1
bfc06c4c:	00051042 	srl	v0,a1,0x1
bfc06c50:	10e0fee9 	beqz	a3,bfc067f8 <crcu32+0x388>
bfc06c54:	35868000 	ori	a2,t4,0x8000
bfc06c58:	00c02821 	move	a1,a2
bfc06c5c:	0085c826 	xor	t9,a0,a1
bfc06c60:	38a84002 	xori	t0,a1,0x4002
bfc06c64:	0008c042 	srl	t8,t0,0x1
bfc06c68:	332f0001 	andi	t7,t9,0x1
bfc06c6c:	00042042 	srl	a0,a0,0x1
bfc06c70:	37068000 	ori	a2,t8,0x8000
bfc06c74:	11e0fee9 	beqz	t7,bfc0681c <crcu32+0x3ac>
bfc06c78:	00051042 	srl	v0,a1,0x1
bfc06c7c:	00c02821 	move	a1,a2
bfc06c80:	00851826 	xor	v1,a0,a1
bfc06c84:	38aa4002 	xori	t2,a1,0x4002
bfc06c88:	000a1042 	srl	v0,t2,0x1
bfc06c8c:	30690001 	andi	t1,v1,0x1
bfc06c90:	34468000 	ori	a2,v0,0x8000
bfc06c94:	00042042 	srl	a0,a0,0x1
bfc06c98:	1120fee9 	beqz	t1,bfc06840 <crcu32+0x3d0>
bfc06c9c:	00051042 	srl	v0,a1,0x1
bfc06ca0:	00c02821 	move	a1,a2
bfc06ca4:	00856026 	xor	t4,a0,a1
bfc06ca8:	38a64002 	xori	a2,a1,0x4002
bfc06cac:	00063842 	srl	a3,a2,0x1
bfc06cb0:	318b0001 	andi	t3,t4,0x1
bfc06cb4:	00042042 	srl	a0,a0,0x1
bfc06cb8:	34e68000 	ori	a2,a3,0x8000
bfc06cbc:	1160fee9 	beqz	t3,bfc06864 <crcu32+0x3f4>
bfc06cc0:	00051042 	srl	v0,a1,0x1
bfc06cc4:	00c02821 	move	a1,a2
bfc06cc8:	00857826 	xor	t7,a0,a1
bfc06ccc:	38b84002 	xori	t8,a1,0x4002
bfc06cd0:	00187042 	srl	t6,t8,0x1
bfc06cd4:	31ed0001 	andi	t5,t7,0x1
bfc06cd8:	00042042 	srl	a0,a0,0x1
bfc06cdc:	35c68000 	ori	a2,t6,0x8000
bfc06ce0:	11a0fee9 	beqz	t5,bfc06888 <crcu32+0x418>
bfc06ce4:	00051042 	srl	v0,a1,0x1
bfc06ce8:	00c02821 	move	a1,a2
bfc06cec:	00854826 	xor	t1,a0,a1
bfc06cf0:	38a24002 	xori	v0,a1,0x4002
bfc06cf4:	00024042 	srl	t0,v0,0x1
bfc06cf8:	31390001 	andi	t9,t1,0x1
bfc06cfc:	00042042 	srl	a0,a0,0x1
bfc06d00:	35068000 	ori	a2,t0,0x8000
bfc06d04:	1320fee9 	beqz	t9,bfc068ac <crcu32+0x43c>
bfc06d08:	00051042 	srl	v0,a1,0x1
bfc06d0c:	00c02821 	move	a1,a2
bfc06d10:	00855826 	xor	t3,a0,a1
bfc06d14:	38a74002 	xori	a3,a1,0x4002
bfc06d18:	00075042 	srl	t2,a3,0x1
bfc06d1c:	31630001 	andi	v1,t3,0x1
bfc06d20:	35468000 	ori	a2,t2,0x8000
bfc06d24:	1060fee9 	beqz	v1,bfc068cc <crcu32+0x45c>
bfc06d28:	00051042 	srl	v0,a1,0x1
bfc06d2c:	00c02821 	move	a1,a2
bfc06d30:	38a64002 	xori	a2,a1,0x4002
bfc06d34:	00066842 	srl	t5,a2,0x1
bfc06d38:	00042042 	srl	a0,a0,0x1
bfc06d3c:	30ac0001 	andi	t4,a1,0x1
bfc06d40:	35a68000 	ori	a2,t5,0x8000
bfc06d44:	1184fee9 	beq	t4,a0,bfc068ec <crcu32+0x47c>
bfc06d48:	00051042 	srl	v0,a1,0x1
bfc06d4c:	00c01021 	move	v0,a2
bfc06d50:	03e00008 	jr	ra
bfc06d54:	3042ffff 	andi	v0,v0,0xffff
	...

bfc06d60 <get_seed_args>:
get_seed_args():
bfc06d60:	0085282a 	slt	a1,a0,a1
bfc06d64:	10a00042 	beqz	a1,bfc06e70 <get_seed_args+0x110>
bfc06d68:	00001021 	move	v0,zero
bfc06d6c:	00043880 	sll	a3,a0,0x2
bfc06d70:	00c71821 	addu	v1,a2,a3
bfc06d74:	8c660000 	lw	a2,0(v1)
bfc06d78:	2402002d 	li	v0,45
bfc06d7c:	80c70000 	lb	a3,0(a2)
bfc06d80:	00000000 	nop
bfc06d84:	10e2003e 	beq	a3,v0,bfc06e80 <get_seed_args+0x120>
bfc06d88:	24040030 	li	a0,48
bfc06d8c:	10e40041 	beq	a3,a0,bfc06e94 <get_seed_args+0x134>
bfc06d90:	240a0001 	li	t2,1
bfc06d94:	24edffd0 	addiu	t5,a3,-48
bfc06d98:	31ac00ff 	andi	t4,t5,0xff
bfc06d9c:	2d8b000a 	sltiu	t3,t4,10
bfc06da0:	1160002b 	beqz	t3,bfc06e50 <get_seed_args+0xf0>
bfc06da4:	00004021 	move	t0,zero
bfc06da8:	000878c0 	sll	t7,t0,0x3
bfc06dac:	00087040 	sll	t6,t0,0x1
bfc06db0:	01cf4021 	addu	t0,t6,t7
bfc06db4:	00e86821 	addu	t5,a3,t0
bfc06db8:	80c70001 	lb	a3,1(a2)
bfc06dbc:	25a8ffd0 	addiu	t0,t5,-48
bfc06dc0:	24e9ffd0 	addiu	t1,a3,-48
bfc06dc4:	000860c0 	sll	t4,t0,0x3
bfc06dc8:	00085840 	sll	t3,t0,0x1
bfc06dcc:	312400ff 	andi	a0,t1,0xff
bfc06dd0:	016c1021 	addu	v0,t3,t4
bfc06dd4:	2c83000a 	sltiu	v1,a0,10
bfc06dd8:	1060001d 	beqz	v1,bfc06e50 <get_seed_args+0xf0>
bfc06ddc:	00e21021 	addu	v0,a3,v0
bfc06de0:	80c70002 	lb	a3,2(a2)
bfc06de4:	2448ffd0 	addiu	t0,v0,-48
bfc06de8:	24e4ffd0 	addiu	a0,a3,-48
bfc06dec:	000810c0 	sll	v0,t0,0x3
bfc06df0:	00084840 	sll	t1,t0,0x1
bfc06df4:	308500ff 	andi	a1,a0,0xff
bfc06df8:	01221821 	addu	v1,t1,v0
bfc06dfc:	2cb9000a 	sltiu	t9,a1,10
bfc06e00:	13200013 	beqz	t9,bfc06e50 <get_seed_args+0xf0>
bfc06e04:	00e31821 	addu	v1,a3,v1
bfc06e08:	80c70003 	lb	a3,3(a2)
bfc06e0c:	24c60004 	addiu	a2,a2,4
bfc06e10:	24efffd0 	addiu	t7,a3,-48
bfc06e14:	31e800ff 	andi	t0,t7,0xff
bfc06e18:	2d0b000a 	sltiu	t3,t0,10
bfc06e1c:	2468ffd0 	addiu	t0,v1,-48
bfc06e20:	000870c0 	sll	t6,t0,0x3
bfc06e24:	00086840 	sll	t5,t0,0x1
bfc06e28:	01ae6021 	addu	t4,t5,t6
bfc06e2c:	11600008 	beqz	t3,bfc06e50 <get_seed_args+0xf0>
bfc06e30:	00ec1821 	addu	v1,a3,t4
bfc06e34:	80c70000 	lb	a3,0(a2)
bfc06e38:	00000000 	nop
bfc06e3c:	24e5ffd0 	addiu	a1,a3,-48
bfc06e40:	30b900ff 	andi	t9,a1,0xff
bfc06e44:	2f38000a 	sltiu	t8,t9,10
bfc06e48:	1700ffd7 	bnez	t8,bfc06da8 <get_seed_args+0x48>
bfc06e4c:	2468ffd0 	addiu	t0,v1,-48
bfc06e50:	2418004b 	li	t8,75
bfc06e54:	10f8002a 	beq	a3,t8,bfc06f00 <get_seed_args+0x1a0>
bfc06e58:	2406004d 	li	a2,77
bfc06e5c:	14e60003 	bne	a3,a2,bfc06e6c <get_seed_args+0x10c>
bfc06e60:	010a0018 	mult	t0,t2
bfc06e64:	00084500 	sll	t0,t0,0x14
bfc06e68:	010a0018 	mult	t0,t2
bfc06e6c:	00001012 	mflo	v0
bfc06e70:	03e00008 	jr	ra
bfc06e74:	00000000 	nop
	...
bfc06e80:	24c60001 	addiu	a2,a2,1
bfc06e84:	80c70000 	lb	a3,0(a2)
bfc06e88:	00000000 	nop
bfc06e8c:	14e4ffc1 	bne	a3,a0,bfc06d94 <get_seed_args+0x34>
bfc06e90:	240affff 	li	t2,-1
bfc06e94:	80c90001 	lb	t1,1(a2)
bfc06e98:	24080078 	li	t0,120
bfc06e9c:	1528ffbe 	bne	t1,t0,bfc06d98 <get_seed_args+0x38>
bfc06ea0:	24edffd0 	addiu	t5,a3,-48
bfc06ea4:	24c40002 	addiu	a0,a2,2
bfc06ea8:	00004021 	move	t0,zero
bfc06eac:	80870000 	lb	a3,0(a0)
bfc06eb0:	00084900 	sll	t1,t0,0x4
bfc06eb4:	30e500ff 	andi	a1,a3,0xff
bfc06eb8:	24b9ffd0 	addiu	t9,a1,-48
bfc06ebc:	24a6ff9f 	addiu	a2,a1,-97
bfc06ec0:	333800ff 	andi	t8,t9,0xff
bfc06ec4:	30cf00ff 	andi	t7,a2,0xff
bfc06ec8:	24e5ffd0 	addiu	a1,a3,-48
bfc06ecc:	2f0e000a 	sltiu	t6,t8,10
bfc06ed0:	28a6000a 	slti	a2,a1,10
bfc06ed4:	24840001 	addiu	a0,a0,1
bfc06ed8:	15c00003 	bnez	t6,bfc06ee8 <get_seed_args+0x188>
bfc06edc:	2de30006 	sltiu	v1,t7,6
bfc06ee0:	1060ffdc 	beqz	v1,bfc06e54 <get_seed_args+0xf4>
bfc06ee4:	2418004b 	li	t8,75
bfc06ee8:	14c00002 	bnez	a2,bfc06ef4 <get_seed_args+0x194>
bfc06eec:	00000000 	nop
bfc06ef0:	24e5ffa9 	addiu	a1,a3,-87
bfc06ef4:	0bf01bab 	j	bfc06eac <get_seed_args+0x14c>
bfc06ef8:	00a94021 	addu	t0,a1,t1
bfc06efc:	00000000 	nop
bfc06f00:	00084280 	sll	t0,t0,0xa
bfc06f04:	010a0018 	mult	t0,t2
bfc06f08:	00001012 	mflo	v0
bfc06f0c:	03e00008 	jr	ra
bfc06f10:	00000000 	nop
	...

bfc06f20 <core_init_state>:
core_init_state():
bfc06f20:	27bdffe0 	addiu	sp,sp,-32
bfc06f24:	00c0c821 	move	t9,a2
bfc06f28:	3c068000 	lui	a2,0x8000
bfc06f2c:	afb40010 	sw	s4,16(sp)
bfc06f30:	00006021 	move	t4,zero
bfc06f34:	24d40780 	addiu	s4,a2,1920
bfc06f38:	00003021 	move	a2,zero
bfc06f3c:	afb20008 	sw	s2,8(sp)
bfc06f40:	00ccc021 	addu	t8,a2,t4
bfc06f44:	00809021 	move	s2,a0
bfc06f48:	afb00000 	sw	s0,0(sp)
bfc06f4c:	270f0001 	addiu	t7,t8,1
bfc06f50:	2650ffff 	addiu	s0,s2,-1
bfc06f54:	00052c00 	sll	a1,a1,0x10
bfc06f58:	3c078000 	lui	a3,0x8000
bfc06f5c:	3c048000 	lui	a0,0x8000
bfc06f60:	3c038000 	lui	v1,0x8000
bfc06f64:	3c028000 	lui	v0,0x8000
bfc06f68:	01f0502b 	sltu	t2,t7,s0
bfc06f6c:	afb7001c 	sw	s7,28(sp)
bfc06f70:	afb60018 	sw	s6,24(sp)
bfc06f74:	afb50014 	sw	s5,20(sp)
bfc06f78:	afb3000c 	sw	s3,12(sp)
bfc06f7c:	afb10004 	sw	s1,4(sp)
bfc06f80:	00052c03 	sra	a1,a1,0x10
bfc06f84:	24f106d0 	addiu	s1,a3,1744
bfc06f88:	24950770 	addiu	s5,a0,1904
bfc06f8c:	24760760 	addiu	s6,v1,1888
bfc06f90:	24570750 	addiu	s7,v0,1872
bfc06f94:	00005821 	move	t3,zero
bfc06f98:	1140001c 	beqz	t2,bfc0700c <core_init_state+0xec>
bfc06f9c:	2413002c 	li	s3,44
bfc06fa0:	1580007b 	bnez	t4,bfc07190 <core_init_state+0x270>
bfc06fa4:	2d880004 	sltiu	t0,t4,4
bfc06fa8:	00c07821 	move	t7,a2
bfc06fac:	24aa0001 	addiu	t2,a1,1
bfc06fb0:	000a2c00 	sll	a1,t2,0x10
bfc06fb4:	00052c03 	sra	a1,a1,0x10
bfc06fb8:	30a80007 	andi	t0,a1,0x7
bfc06fbc:	00085880 	sll	t3,t0,0x2
bfc06fc0:	022b3821 	addu	a3,s1,t3
bfc06fc4:	8cf80000 	lw	t8,0(a3)
bfc06fc8:	00000000 	nop
bfc06fcc:	03000008 	jr	t8
bfc06fd0:	00000000 	nop
	...
bfc06fe0:	00054042 	srl	t0,a1,0x1
bfc06fe4:	310b000c 	andi	t3,t0,0xc
bfc06fe8:	01743821 	addu	a3,t3,s4
bfc06fec:	8ceb0000 	lw	t3,0(a3)
bfc06ff0:	240c0008 	li	t4,8
bfc06ff4:	01e03021 	move	a2,t7
bfc06ff8:	00ccc021 	addu	t8,a2,t4
bfc06ffc:	270f0001 	addiu	t7,t8,1
bfc07000:	01f0502b 	sltu	t2,t7,s0
bfc07004:	1540ffe6 	bnez	t2,bfc06fa0 <core_init_state+0x80>
bfc07008:	00000000 	nop
bfc0700c:	00d2782b 	sltu	t7,a2,s2
bfc07010:	11e0003a 	beqz	t7,bfc070fc <core_init_state+0x1dc>
bfc07014:	00069827 	nor	s3,zero,a2
bfc07018:	24c50001 	addiu	a1,a2,1
bfc0701c:	02728821 	addu	s1,s3,s2
bfc07020:	03263021 	addu	a2,t9,a2
bfc07024:	00b2802b 	sltu	s0,a1,s2
bfc07028:	32270007 	andi	a3,s1,0x7
bfc0702c:	a0c00000 	sb	zero,0(a2)
bfc07030:	12000032 	beqz	s0,bfc070fc <core_init_state+0x1dc>
bfc07034:	24c40001 	addiu	a0,a2,1
bfc07038:	10e00024 	beqz	a3,bfc070cc <core_init_state+0x1ac>
bfc0703c:	24150001 	li	s5,1
bfc07040:	10f5001d 	beq	a3,s5,bfc070b8 <core_init_state+0x198>
bfc07044:	24160002 	li	s6,2
bfc07048:	10f60018 	beq	a3,s6,bfc070ac <core_init_state+0x18c>
bfc0704c:	24170003 	li	s7,3
bfc07050:	10f70013 	beq	a3,s7,bfc070a0 <core_init_state+0x180>
bfc07054:	24190004 	li	t9,4
bfc07058:	10f9000e 	beq	a3,t9,bfc07094 <core_init_state+0x174>
bfc0705c:	24020005 	li	v0,5
bfc07060:	10e20009 	beq	a3,v0,bfc07088 <core_init_state+0x168>
bfc07064:	240e0006 	li	t6,6
bfc07068:	10ee0004 	beq	a3,t6,bfc0707c <core_init_state+0x15c>
bfc0706c:	00000000 	nop
bfc07070:	a0c00001 	sb	zero,1(a2)
bfc07074:	24a50001 	addiu	a1,a1,1
bfc07078:	24840001 	addiu	a0,a0,1
bfc0707c:	a0800000 	sb	zero,0(a0)
bfc07080:	24a50001 	addiu	a1,a1,1
bfc07084:	24840001 	addiu	a0,a0,1
bfc07088:	a0800000 	sb	zero,0(a0)
bfc0708c:	24a50001 	addiu	a1,a1,1
bfc07090:	24840001 	addiu	a0,a0,1
bfc07094:	a0800000 	sb	zero,0(a0)
bfc07098:	24a50001 	addiu	a1,a1,1
bfc0709c:	24840001 	addiu	a0,a0,1
bfc070a0:	a0800000 	sb	zero,0(a0)
bfc070a4:	24a50001 	addiu	a1,a1,1
bfc070a8:	24840001 	addiu	a0,a0,1
bfc070ac:	a0800000 	sb	zero,0(a0)
bfc070b0:	24a50001 	addiu	a1,a1,1
bfc070b4:	24840001 	addiu	a0,a0,1
bfc070b8:	24a50001 	addiu	a1,a1,1
bfc070bc:	00b2302b 	sltu	a2,a1,s2
bfc070c0:	a0800000 	sb	zero,0(a0)
bfc070c4:	10c0000d 	beqz	a2,bfc070fc <core_init_state+0x1dc>
bfc070c8:	24840001 	addiu	a0,a0,1
bfc070cc:	24a50008 	addiu	a1,a1,8
bfc070d0:	00b2a02b 	sltu	s4,a1,s2
bfc070d4:	a0800000 	sb	zero,0(a0)
bfc070d8:	a0800001 	sb	zero,1(a0)
bfc070dc:	a0800002 	sb	zero,2(a0)
bfc070e0:	a0800003 	sb	zero,3(a0)
bfc070e4:	a0800004 	sb	zero,4(a0)
bfc070e8:	a0800005 	sb	zero,5(a0)
bfc070ec:	a0800006 	sb	zero,6(a0)
bfc070f0:	a0800007 	sb	zero,7(a0)
bfc070f4:	1680fff5 	bnez	s4,bfc070cc <core_init_state+0x1ac>
bfc070f8:	24840008 	addiu	a0,a0,8
bfc070fc:	8fb7001c 	lw	s7,28(sp)
bfc07100:	8fb60018 	lw	s6,24(sp)
bfc07104:	8fb50014 	lw	s5,20(sp)
bfc07108:	8fb40010 	lw	s4,16(sp)
bfc0710c:	8fb3000c 	lw	s3,12(sp)
bfc07110:	8fb20008 	lw	s2,8(sp)
bfc07114:	8fb10004 	lw	s1,4(sp)
bfc07118:	8fb00000 	lw	s0,0(sp)
bfc0711c:	03e00008 	jr	ra
bfc07120:	27bd0020 	addiu	sp,sp,32
	...
bfc07130:	0005c042 	srl	t8,a1,0x1
bfc07134:	330c000c 	andi	t4,t8,0xc
bfc07138:	01952021 	addu	a0,t4,s5
bfc0713c:	8c8b0000 	lw	t3,0(a0)
bfc07140:	240c0008 	li	t4,8
bfc07144:	0bf01bfe 	j	bfc06ff8 <core_init_state+0xd8>
bfc07148:	01e03021 	move	a2,t7
bfc0714c:	00000000 	nop
bfc07150:	00051842 	srl	v1,a1,0x1
bfc07154:	306d000c 	andi	t5,v1,0xc
bfc07158:	01b64821 	addu	t1,t5,s6
bfc0715c:	8d2b0000 	lw	t3,0(t1)
bfc07160:	240c0008 	li	t4,8
bfc07164:	0bf01bfe 	j	bfc06ff8 <core_init_state+0xd8>
bfc07168:	01e03021 	move	a2,t7
bfc0716c:	00000000 	nop
bfc07170:	00057042 	srl	t6,a1,0x1
bfc07174:	31c6000c 	andi	a2,t6,0xc
bfc07178:	00d71021 	addu	v0,a2,s7
bfc0717c:	8c4b0000 	lw	t3,0(v0)
bfc07180:	240c0004 	li	t4,4
bfc07184:	0bf01bfe 	j	bfc06ff8 <core_init_state+0xd8>
bfc07188:	01e03021 	move	a2,t7
bfc0718c:	00000000 	nop
bfc07190:	1100005b 	beqz	t0,bfc07300 <core_init_state+0x3e0>
bfc07194:	03265021 	addu	t2,t9,a2
bfc07198:	916d0000 	lbu	t5,0(t3)
bfc0719c:	24070001 	li	a3,1
bfc071a0:	2588ffff 	addiu	t0,t4,-1
bfc071a4:	00ec482b 	sltu	t1,a3,t4
bfc071a8:	31030007 	andi	v1,t0,0x7
bfc071ac:	a14d0000 	sb	t5,0(t2)
bfc071b0:	1120004e 	beqz	t1,bfc072ec <core_init_state+0x3cc>
bfc071b4:	25480001 	addiu	t0,t2,1
bfc071b8:	10600032 	beqz	v1,bfc07284 <core_init_state+0x364>
bfc071bc:	01672021 	addu	a0,t3,a3
bfc071c0:	10670029 	beq	v1,a3,bfc07268 <core_init_state+0x348>
bfc071c4:	24090002 	li	t1,2
bfc071c8:	10690021 	beq	v1,t1,bfc07250 <core_init_state+0x330>
bfc071cc:	240d0003 	li	t5,3
bfc071d0:	106d001a 	beq	v1,t5,bfc0723c <core_init_state+0x31c>
bfc071d4:	24040004 	li	a0,4
bfc071d8:	10640013 	beq	v1,a0,bfc07228 <core_init_state+0x308>
bfc071dc:	24020005 	li	v0,5
bfc071e0:	1062000c 	beq	v1,v0,bfc07214 <core_init_state+0x2f4>
bfc071e4:	240e0006 	li	t6,6
bfc071e8:	106e0006 	beq	v1,t6,bfc07204 <core_init_state+0x2e4>
bfc071ec:	01673021 	addu	a2,t3,a3
bfc071f0:	91630001 	lbu	v1,1(t3)
bfc071f4:	25480002 	addiu	t0,t2,2
bfc071f8:	a1430001 	sb	v1,1(t2)
bfc071fc:	24070002 	li	a3,2
bfc07200:	01673021 	addu	a2,t3,a3
bfc07204:	90ca0000 	lbu	t2,0(a2)
bfc07208:	24e70001 	addiu	a3,a3,1
bfc0720c:	a10a0000 	sb	t2,0(t0)
bfc07210:	25080001 	addiu	t0,t0,1
bfc07214:	01676821 	addu	t5,t3,a3
bfc07218:	91a90000 	lbu	t1,0(t5)
bfc0721c:	24e70001 	addiu	a3,a3,1
bfc07220:	a1090000 	sb	t1,0(t0)
bfc07224:	25080001 	addiu	t0,t0,1
bfc07228:	01671021 	addu	v0,t3,a3
bfc0722c:	90440000 	lbu	a0,0(v0)
bfc07230:	24e70001 	addiu	a3,a3,1
bfc07234:	a1040000 	sb	a0,0(t0)
bfc07238:	25080001 	addiu	t0,t0,1
bfc0723c:	01671821 	addu	v1,t3,a3
bfc07240:	906e0000 	lbu	t6,0(v1)
bfc07244:	24e70001 	addiu	a3,a3,1
bfc07248:	a10e0000 	sb	t6,0(t0)
bfc0724c:	25080001 	addiu	t0,t0,1
bfc07250:	01673021 	addu	a2,t3,a3
bfc07254:	90ca0000 	lbu	t2,0(a2)
bfc07258:	24e70001 	addiu	a3,a3,1
bfc0725c:	a10a0000 	sb	t2,0(t0)
bfc07260:	25080001 	addiu	t0,t0,1
bfc07264:	01672021 	addu	a0,t3,a3
bfc07268:	908d0000 	lbu	t5,0(a0)
bfc0726c:	24e70001 	addiu	a3,a3,1
bfc07270:	00ec482b 	sltu	t1,a3,t4
bfc07274:	a10d0000 	sb	t5,0(t0)
bfc07278:	1120001c 	beqz	t1,bfc072ec <core_init_state+0x3cc>
bfc0727c:	25080001 	addiu	t0,t0,1
bfc07280:	01672021 	addu	a0,t3,a3
bfc07284:	90830000 	lbu	v1,0(a0)
bfc07288:	24e70008 	addiu	a3,a3,8
bfc0728c:	a1030000 	sb	v1,0(t0)
bfc07290:	90890001 	lbu	t1,1(a0)
bfc07294:	00000000 	nop
bfc07298:	a1090001 	sb	t1,1(t0)
bfc0729c:	90860002 	lbu	a2,2(a0)
bfc072a0:	00000000 	nop
bfc072a4:	a1060002 	sb	a2,2(t0)
bfc072a8:	908a0003 	lbu	t2,3(a0)
bfc072ac:	00000000 	nop
bfc072b0:	a10a0003 	sb	t2,3(t0)
bfc072b4:	908d0004 	lbu	t5,4(a0)
bfc072b8:	00000000 	nop
bfc072bc:	a10d0004 	sb	t5,4(t0)
bfc072c0:	90890005 	lbu	t1,5(a0)
bfc072c4:	00000000 	nop
bfc072c8:	a1090005 	sb	t1,5(t0)
bfc072cc:	90860006 	lbu	a2,6(a0)
bfc072d0:	00000000 	nop
bfc072d4:	a1060006 	sb	a2,6(t0)
bfc072d8:	90820007 	lbu	v0,7(a0)
bfc072dc:	00ec202b 	sltu	a0,a3,t4
bfc072e0:	a1020007 	sb	v0,7(t0)
bfc072e4:	1480ffe6 	bnez	a0,bfc07280 <core_init_state+0x360>
bfc072e8:	25080008 	addiu	t0,t0,8
bfc072ec:	03386021 	addu	t4,t9,t8
bfc072f0:	0bf01beb 	j	bfc06fac <core_init_state+0x8c>
bfc072f4:	a1930000 	sb	s3,0(t4)
	...
bfc07300:	014b6825 	or	t5,t2,t3
bfc07304:	31a90003 	andi	t1,t5,0x3
bfc07308:	1520ffa3 	bnez	t1,bfc07198 <core_init_state+0x278>
bfc0730c:	25620004 	addiu	v0,t3,4
bfc07310:	004a702b 	sltu	t6,v0,t2
bfc07314:	15c00005 	bnez	t6,bfc0732c <core_init_state+0x40c>
bfc07318:	000c7082 	srl	t6,t4,0x2
bfc0731c:	25440004 	addiu	a0,t2,4
bfc07320:	008b182b 	sltu	v1,a0,t3
bfc07324:	1060ff9c 	beqz	v1,bfc07198 <core_init_state+0x278>
bfc07328:	00000000 	nop
bfc0732c:	000e6880 	sll	t5,t6,0x2
bfc07330:	11a00058 	beqz	t5,bfc07494 <core_init_state+0x574>
bfc07334:	24090001 	li	t1,1
bfc07338:	8d680000 	lw	t0,0(t3)
bfc0733c:	25c7ffff 	addiu	a3,t6,-1
bfc07340:	012e202b 	sltu	a0,t1,t6
bfc07344:	ad480000 	sw	t0,0(t2)
bfc07348:	30e30007 	andi	v1,a3,0x7
bfc0734c:	25480004 	addiu	t0,t2,4
bfc07350:	1080004e 	beqz	a0,bfc0748c <core_init_state+0x56c>
bfc07354:	25670004 	addiu	a3,t3,4
bfc07358:	10600032 	beqz	v1,bfc07424 <core_init_state+0x504>
bfc0735c:	00000000 	nop
bfc07360:	10690029 	beq	v1,t1,bfc07408 <core_init_state+0x4e8>
bfc07364:	24040002 	li	a0,2
bfc07368:	10640022 	beq	v1,a0,bfc073f4 <core_init_state+0x4d4>
bfc0736c:	24020003 	li	v0,3
bfc07370:	1062001b 	beq	v1,v0,bfc073e0 <core_init_state+0x4c0>
bfc07374:	24040004 	li	a0,4
bfc07378:	10640014 	beq	v1,a0,bfc073cc <core_init_state+0x4ac>
bfc0737c:	24020005 	li	v0,5
bfc07380:	1062000d 	beq	v1,v0,bfc073b8 <core_init_state+0x498>
bfc07384:	24040006 	li	a0,6
bfc07388:	10640006 	beq	v1,a0,bfc073a4 <core_init_state+0x484>
bfc0738c:	00000000 	nop
bfc07390:	8ce90000 	lw	t1,0(a3)
bfc07394:	25480008 	addiu	t0,t2,8
bfc07398:	ad490004 	sw	t1,4(t2)
bfc0739c:	25670008 	addiu	a3,t3,8
bfc073a0:	24090002 	li	t1,2
bfc073a4:	8cea0000 	lw	t2,0(a3)
bfc073a8:	25290001 	addiu	t1,t1,1
bfc073ac:	ad0a0000 	sw	t2,0(t0)
bfc073b0:	24e70004 	addiu	a3,a3,4
bfc073b4:	25080004 	addiu	t0,t0,4
bfc073b8:	8ce30000 	lw	v1,0(a3)
bfc073bc:	25290001 	addiu	t1,t1,1
bfc073c0:	ad030000 	sw	v1,0(t0)
bfc073c4:	24e70004 	addiu	a3,a3,4
bfc073c8:	25080004 	addiu	t0,t0,4
bfc073cc:	8ce20000 	lw	v0,0(a3)
bfc073d0:	25290001 	addiu	t1,t1,1
bfc073d4:	ad020000 	sw	v0,0(t0)
bfc073d8:	24e70004 	addiu	a3,a3,4
bfc073dc:	25080004 	addiu	t0,t0,4
bfc073e0:	8ce40000 	lw	a0,0(a3)
bfc073e4:	25290001 	addiu	t1,t1,1
bfc073e8:	ad040000 	sw	a0,0(t0)
bfc073ec:	24e70004 	addiu	a3,a3,4
bfc073f0:	25080004 	addiu	t0,t0,4
bfc073f4:	8cea0000 	lw	t2,0(a3)
bfc073f8:	25290001 	addiu	t1,t1,1
bfc073fc:	ad0a0000 	sw	t2,0(t0)
bfc07400:	24e70004 	addiu	a3,a3,4
bfc07404:	25080004 	addiu	t0,t0,4
bfc07408:	8ce20000 	lw	v0,0(a3)
bfc0740c:	25290001 	addiu	t1,t1,1
bfc07410:	012e182b 	sltu	v1,t1,t6
bfc07414:	ad020000 	sw	v0,0(t0)
bfc07418:	24e70004 	addiu	a3,a3,4
bfc0741c:	1060001b 	beqz	v1,bfc0748c <core_init_state+0x56c>
bfc07420:	25080004 	addiu	t0,t0,4
bfc07424:	8cea0000 	lw	t2,0(a3)
bfc07428:	25290008 	addiu	t1,t1,8
bfc0742c:	ad0a0000 	sw	t2,0(t0)
bfc07430:	8ce20004 	lw	v0,4(a3)
bfc07434:	012e502b 	sltu	t2,t1,t6
bfc07438:	ad020004 	sw	v0,4(t0)
bfc0743c:	8ce40008 	lw	a0,8(a3)
bfc07440:	00000000 	nop
bfc07444:	ad040008 	sw	a0,8(t0)
bfc07448:	8ce3000c 	lw	v1,12(a3)
bfc0744c:	00000000 	nop
bfc07450:	ad03000c 	sw	v1,12(t0)
bfc07454:	8ce20010 	lw	v0,16(a3)
bfc07458:	00000000 	nop
bfc0745c:	ad020010 	sw	v0,16(t0)
bfc07460:	8ce40014 	lw	a0,20(a3)
bfc07464:	00000000 	nop
bfc07468:	ad040014 	sw	a0,20(t0)
bfc0746c:	8ce30018 	lw	v1,24(a3)
bfc07470:	00000000 	nop
bfc07474:	ad030018 	sw	v1,24(t0)
bfc07478:	8ce2001c 	lw	v0,28(a3)
bfc0747c:	24e70020 	addiu	a3,a3,32
bfc07480:	ad02001c 	sw	v0,28(t0)
bfc07484:	1540ffe7 	bnez	t2,bfc07424 <core_init_state+0x504>
bfc07488:	25080020 	addiu	t0,t0,32
bfc0748c:	118dff97 	beq	t4,t5,bfc072ec <core_init_state+0x3cc>
bfc07490:	00000000 	nop
bfc07494:	016d5821 	addu	t3,t3,t5
bfc07498:	01a61821 	addu	v1,t5,a2
bfc0749c:	000d4027 	nor	t0,zero,t5
bfc074a0:	91670000 	lbu	a3,0(t3)
bfc074a4:	25a90001 	addiu	t1,t5,1
bfc074a8:	03235021 	addu	t2,t9,v1
bfc074ac:	010c7021 	addu	t6,t0,t4
bfc074b0:	012c302b 	sltu	a2,t1,t4
bfc074b4:	a1470000 	sb	a3,0(t2)
bfc074b8:	31c40007 	andi	a0,t6,0x7
bfc074bc:	25680001 	addiu	t0,t3,1
bfc074c0:	10c0ff8a 	beqz	a2,bfc072ec <core_init_state+0x3cc>
bfc074c4:	25470001 	addiu	a3,t2,1
bfc074c8:	10800032 	beqz	a0,bfc07594 <core_init_state+0x674>
bfc074cc:	24020001 	li	v0,1
bfc074d0:	10820029 	beq	a0,v0,bfc07578 <core_init_state+0x658>
bfc074d4:	240e0002 	li	t6,2
bfc074d8:	108e0022 	beq	a0,t6,bfc07564 <core_init_state+0x644>
bfc074dc:	24030003 	li	v1,3
bfc074e0:	1083001b 	beq	a0,v1,bfc07550 <core_init_state+0x630>
bfc074e4:	24060004 	li	a2,4
bfc074e8:	10860014 	beq	a0,a2,bfc0753c <core_init_state+0x61c>
bfc074ec:	24020005 	li	v0,5
bfc074f0:	1082000d 	beq	a0,v0,bfc07528 <core_init_state+0x608>
bfc074f4:	240e0006 	li	t6,6
bfc074f8:	108e0006 	beq	a0,t6,bfc07514 <core_init_state+0x5f4>
bfc074fc:	00000000 	nop
bfc07500:	91670001 	lbu	a3,1(t3)
bfc07504:	25a90002 	addiu	t1,t5,2
bfc07508:	a1470001 	sb	a3,1(t2)
bfc0750c:	25680002 	addiu	t0,t3,2
bfc07510:	25470002 	addiu	a3,t2,2
bfc07514:	910b0000 	lbu	t3,0(t0)
bfc07518:	25290001 	addiu	t1,t1,1
bfc0751c:	a0eb0000 	sb	t3,0(a3)
bfc07520:	25080001 	addiu	t0,t0,1
bfc07524:	24e70001 	addiu	a3,a3,1
bfc07528:	910a0000 	lbu	t2,0(t0)
bfc0752c:	25290001 	addiu	t1,t1,1
bfc07530:	a0ea0000 	sb	t2,0(a3)
bfc07534:	25080001 	addiu	t0,t0,1
bfc07538:	24e70001 	addiu	a3,a3,1
bfc0753c:	910d0000 	lbu	t5,0(t0)
bfc07540:	25290001 	addiu	t1,t1,1
bfc07544:	a0ed0000 	sb	t5,0(a3)
bfc07548:	25080001 	addiu	t0,t0,1
bfc0754c:	24e70001 	addiu	a3,a3,1
bfc07550:	91040000 	lbu	a0,0(t0)
bfc07554:	25290001 	addiu	t1,t1,1
bfc07558:	a0e40000 	sb	a0,0(a3)
bfc0755c:	25080001 	addiu	t0,t0,1
bfc07560:	24e70001 	addiu	a3,a3,1
bfc07564:	91030000 	lbu	v1,0(t0)
bfc07568:	25290001 	addiu	t1,t1,1
bfc0756c:	a0e30000 	sb	v1,0(a3)
bfc07570:	25080001 	addiu	t0,t0,1
bfc07574:	24e70001 	addiu	a3,a3,1
bfc07578:	91020000 	lbu	v0,0(t0)
bfc0757c:	25290001 	addiu	t1,t1,1
bfc07580:	012c302b 	sltu	a2,t1,t4
bfc07584:	a0e20000 	sb	v0,0(a3)
bfc07588:	25080001 	addiu	t0,t0,1
bfc0758c:	10c0ff57 	beqz	a2,bfc072ec <core_init_state+0x3cc>
bfc07590:	24e70001 	addiu	a3,a3,1
bfc07594:	910b0000 	lbu	t3,0(t0)
bfc07598:	25290008 	addiu	t1,t1,8
bfc0759c:	a0eb0000 	sb	t3,0(a3)
bfc075a0:	91030001 	lbu	v1,1(t0)
bfc075a4:	012c582b 	sltu	t3,t1,t4
bfc075a8:	a0e30001 	sb	v1,1(a3)
bfc075ac:	910e0002 	lbu	t6,2(t0)
bfc075b0:	00000000 	nop
bfc075b4:	a0ee0002 	sb	t6,2(a3)
bfc075b8:	91060003 	lbu	a2,3(t0)
bfc075bc:	00000000 	nop
bfc075c0:	a0e60003 	sb	a2,3(a3)
bfc075c4:	910a0004 	lbu	t2,4(t0)
bfc075c8:	00000000 	nop
bfc075cc:	a0ea0004 	sb	t2,4(a3)
bfc075d0:	91020005 	lbu	v0,5(t0)
bfc075d4:	00000000 	nop
bfc075d8:	a0e20005 	sb	v0,5(a3)
bfc075dc:	91040006 	lbu	a0,6(t0)
bfc075e0:	00000000 	nop
bfc075e4:	a0e40006 	sb	a0,6(a3)
bfc075e8:	910d0007 	lbu	t5,7(t0)
bfc075ec:	25080008 	addiu	t0,t0,8
bfc075f0:	a0ed0007 	sb	t5,7(a3)
bfc075f4:	1560ffe7 	bnez	t3,bfc07594 <core_init_state+0x674>
bfc075f8:	24e70008 	addiu	a3,a3,8
bfc075fc:	03386021 	addu	t4,t9,t8
bfc07600:	0bf01beb 	j	bfc06fac <core_init_state+0x8c>
bfc07604:	a1930000 	sb	s3,0(t4)
	...

bfc07610 <core_state_transition>:
core_state_transition():
bfc07610:	27bdffe8 	addiu	sp,sp,-24
bfc07614:	8c880000 	lw	t0,0(a0)
bfc07618:	afb10008 	sw	s1,8(sp)
bfc0761c:	afb40014 	sw	s4,20(sp)
bfc07620:	afb30010 	sw	s3,16(sp)
bfc07624:	afb2000c 	sw	s2,12(sp)
bfc07628:	afb00004 	sw	s0,4(sp)
bfc0762c:	91060000 	lbu	a2,0(t0)
bfc07630:	00000000 	nop
bfc07634:	10c000bd 	beqz	a2,bfc0792c <core_state_transition+0x31c>
bfc07638:	00808821 	move	s1,a0
bfc0763c:	2402002c 	li	v0,44
bfc07640:	10c200bc 	beq	a2,v0,bfc07934 <core_state_transition+0x324>
bfc07644:	3c038000 	lui	v1,0x8000
bfc07648:	246406f0 	addiu	a0,v1,1776
bfc0764c:	00003821 	move	a3,zero
bfc07650:	24b80004 	addiu	t8,a1,4
bfc07654:	240f0001 	li	t7,1
bfc07658:	24ab0018 	addiu	t3,a1,24
bfc0765c:	2410002b 	li	s0,43
bfc07660:	24aa000c 	addiu	t2,a1,12
bfc07664:	2412002d 	li	s2,45
bfc07668:	24130045 	li	s3,69
bfc0766c:	24ac0014 	addiu	t4,a1,20
bfc07670:	24140065 	li	s4,101
bfc07674:	2419002e 	li	t9,46
bfc07678:	24ae0010 	addiu	t6,a1,16
bfc0767c:	24a90008 	addiu	t1,a1,8
bfc07680:	240d002c 	li	t5,44
bfc07684:	00071880 	sll	v1,a3,0x2
bfc07688:	00831021 	addu	v0,a0,v1
bfc0768c:	8c430000 	lw	v1,0(v0)
bfc07690:	00000000 	nop
bfc07694:	00600008 	jr	v1
bfc07698:	00000000 	nop
bfc0769c:	00000000 	nop
bfc076a0:	24c3ffd0 	addiu	v1,a2,-48
bfc076a4:	306200ff 	andi	v0,v1,0xff
bfc076a8:	2c47000a 	sltiu	a3,v0,10
bfc076ac:	10e00084 	beqz	a3,bfc078c0 <core_state_transition+0x2b0>
bfc076b0:	24070004 	li	a3,4
bfc076b4:	8ca60000 	lw	a2,0(a1)
bfc076b8:	00000000 	nop
bfc076bc:	24c30001 	addiu	v1,a2,1
bfc076c0:	aca30000 	sw	v1,0(a1)
bfc076c4:	25080001 	addiu	t0,t0,1
bfc076c8:	91060000 	lbu	a2,0(t0)
bfc076cc:	00000000 	nop
bfc076d0:	10c00006 	beqz	a2,bfc076ec <core_state_transition+0xdc>
bfc076d4:	00000000 	nop
bfc076d8:	10ef0004 	beq	a3,t7,bfc076ec <core_state_transition+0xdc>
bfc076dc:	00000000 	nop
bfc076e0:	14cdffe9 	bne	a2,t5,bfc07688 <core_state_transition+0x78>
bfc076e4:	00071880 	sll	v1,a3,0x2
bfc076e8:	25080001 	addiu	t0,t0,1
bfc076ec:	ae280000 	sw	t0,0(s1)
bfc076f0:	00e01021 	move	v0,a3
bfc076f4:	8fb40014 	lw	s4,20(sp)
bfc076f8:	8fb30010 	lw	s3,16(sp)
bfc076fc:	8fb2000c 	lw	s2,12(sp)
bfc07700:	8fb10008 	lw	s1,8(sp)
bfc07704:	8fb00004 	lw	s0,4(sp)
bfc07708:	03e00008 	jr	ra
bfc0770c:	27bd0018 	addiu	sp,sp,24
bfc07710:	24c3ffd0 	addiu	v1,a2,-48
bfc07714:	306200ff 	andi	v0,v1,0xff
bfc07718:	2c46000a 	sltiu	a2,v0,10
bfc0771c:	14c0ffe9 	bnez	a2,bfc076c4 <core_state_transition+0xb4>
bfc07720:	00000000 	nop
bfc07724:	8f020000 	lw	v0,0(t8)
bfc07728:	24070001 	li	a3,1
bfc0772c:	24460001 	addiu	a2,v0,1
bfc07730:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07734:	af060000 	sw	a2,0(t8)
	...
bfc07740:	24c2ffd0 	addiu	v0,a2,-48
bfc07744:	304600ff 	andi	a2,v0,0xff
bfc07748:	2cc7000a 	sltiu	a3,a2,10
bfc0774c:	10e0004c 	beqz	a3,bfc07880 <core_state_transition+0x270>
bfc07750:	00000000 	nop
bfc07754:	8d660000 	lw	a2,0(t3)
bfc07758:	24070007 	li	a3,7
bfc0775c:	24c30001 	addiu	v1,a2,1
bfc07760:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07764:	ad630000 	sw	v1,0(t3)
	...
bfc07770:	10d30033 	beq	a2,s3,bfc07840 <core_state_transition+0x230>
bfc07774:	00000000 	nop
bfc07778:	10d40031 	beq	a2,s4,bfc07840 <core_state_transition+0x230>
bfc0777c:	24c3ffd0 	addiu	v1,a2,-48
bfc07780:	306200ff 	andi	v0,v1,0xff
bfc07784:	2c46000a 	sltiu	a2,v0,10
bfc07788:	14c0ffce 	bnez	a2,bfc076c4 <core_state_transition+0xb4>
bfc0778c:	00000000 	nop
bfc07790:	8d820000 	lw	v0,0(t4)
bfc07794:	24070001 	li	a3,1
bfc07798:	24460001 	addiu	a2,v0,1
bfc0779c:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc077a0:	ad860000 	sw	a2,0(t4)
	...
bfc077b0:	10d90057 	beq	a2,t9,bfc07910 <core_state_transition+0x300>
bfc077b4:	24c2ffd0 	addiu	v0,a2,-48
bfc077b8:	304600ff 	andi	a2,v0,0xff
bfc077bc:	2cc3000a 	sltiu	v1,a2,10
bfc077c0:	1460ffc0 	bnez	v1,bfc076c4 <core_state_transition+0xb4>
bfc077c4:	00000000 	nop
bfc077c8:	8dc60000 	lw	a2,0(t6)
bfc077cc:	24070001 	li	a3,1
bfc077d0:	24c30001 	addiu	v1,a2,1
bfc077d4:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc077d8:	adc30000 	sw	v1,0(t6)
bfc077dc:	00000000 	nop
bfc077e0:	24c3ffd0 	addiu	v1,a2,-48
bfc077e4:	306200ff 	andi	v0,v1,0xff
bfc077e8:	2c47000a 	sltiu	a3,v0,10
bfc077ec:	10e0002c 	beqz	a3,bfc078a0 <core_state_transition+0x290>
bfc077f0:	24070004 	li	a3,4
bfc077f4:	8d220000 	lw	v0,0(t1)
bfc077f8:	00000000 	nop
bfc077fc:	24460001 	addiu	a2,v0,1
bfc07800:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07804:	ad260000 	sw	a2,0(t1)
	...
bfc07810:	10d00013 	beq	a2,s0,bfc07860 <core_state_transition+0x250>
bfc07814:	00000000 	nop
bfc07818:	10d20011 	beq	a2,s2,bfc07860 <core_state_transition+0x250>
bfc0781c:	00000000 	nop
bfc07820:	8d430000 	lw	v1,0(t2)
bfc07824:	24070001 	li	a3,1
bfc07828:	24620001 	addiu	v0,v1,1
bfc0782c:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07830:	ad420000 	sw	v0,0(t2)
	...
bfc07840:	8d830000 	lw	v1,0(t4)
bfc07844:	24070003 	li	a3,3
bfc07848:	24620001 	addiu	v0,v1,1
bfc0784c:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07850:	ad820000 	sw	v0,0(t4)
	...
bfc07860:	8d460000 	lw	a2,0(t2)
bfc07864:	24070006 	li	a3,6
bfc07868:	24c30001 	addiu	v1,a2,1
bfc0786c:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07870:	ad430000 	sw	v1,0(t2)
	...
bfc07880:	8d630000 	lw	v1,0(t3)
bfc07884:	24070001 	li	a3,1
bfc07888:	24620001 	addiu	v0,v1,1
bfc0788c:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07890:	ad620000 	sw	v0,0(t3)
	...
bfc078a0:	10d90013 	beq	a2,t9,bfc078f0 <core_state_transition+0x2e0>
bfc078a4:	00000000 	nop
bfc078a8:	8d230000 	lw	v1,0(t1)
bfc078ac:	24070001 	li	a3,1
bfc078b0:	24620001 	addiu	v0,v1,1
bfc078b4:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc078b8:	ad220000 	sw	v0,0(t1)
bfc078bc:	00000000 	nop
bfc078c0:	10d0ff7c 	beq	a2,s0,bfc076b4 <core_state_transition+0xa4>
bfc078c4:	24070002 	li	a3,2
bfc078c8:	10d2ff7a 	beq	a2,s2,bfc076b4 <core_state_transition+0xa4>
bfc078cc:	00000000 	nop
bfc078d0:	10d90014 	beq	a2,t9,bfc07924 <core_state_transition+0x314>
bfc078d4:	00000000 	nop
bfc078d8:	8f020000 	lw	v0,0(t8)
bfc078dc:	24070001 	li	a3,1
bfc078e0:	24460001 	addiu	a2,v0,1
bfc078e4:	0bf01dad 	j	bfc076b4 <core_state_transition+0xa4>
bfc078e8:	af060000 	sw	a2,0(t8)
bfc078ec:	00000000 	nop
bfc078f0:	8d260000 	lw	a2,0(t1)
bfc078f4:	24070005 	li	a3,5
bfc078f8:	24c30001 	addiu	v1,a2,1
bfc078fc:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07900:	ad230000 	sw	v1,0(t1)
	...
bfc07910:	8dc20000 	lw	v0,0(t6)
bfc07914:	24070005 	li	a3,5
bfc07918:	24460001 	addiu	a2,v0,1
bfc0791c:	0bf01db1 	j	bfc076c4 <core_state_transition+0xb4>
bfc07920:	adc60000 	sw	a2,0(t6)
bfc07924:	0bf01dad 	j	bfc076b4 <core_state_transition+0xa4>
bfc07928:	24070005 	li	a3,5
bfc0792c:	0bf01dbb 	j	bfc076ec <core_state_transition+0xdc>
bfc07930:	00003821 	move	a3,zero
bfc07934:	00003821 	move	a3,zero
bfc07938:	0bf01dbb 	j	bfc076ec <core_state_transition+0xdc>
bfc0793c:	25080001 	addiu	t0,t0,1

bfc07940 <core_bench_state>:
core_bench_state():
bfc07940:	27bdff98 	addiu	sp,sp,-104
bfc07944:	afb40060 	sw	s4,96(sp)
bfc07948:	afb3005c 	sw	s3,92(sp)
bfc0794c:	afb20058 	sw	s2,88(sp)
bfc07950:	afb00050 	sw	s0,80(sp)
bfc07954:	afbf0064 	sw	ra,100(sp)
bfc07958:	afb10054 	sw	s1,84(sp)
bfc0795c:	90ab0000 	lbu	t3,0(a1)
bfc07960:	00068400 	sll	s0,a2,0x10
bfc07964:	00079400 	sll	s2,a3,0x10
bfc07968:	00809821 	move	s3,a0
bfc0796c:	00108403 	sra	s0,s0,0x10
bfc07970:	afa00030 	sw	zero,48(sp)
bfc07974:	afa00010 	sw	zero,16(sp)
bfc07978:	afa00034 	sw	zero,52(sp)
bfc0797c:	afa00014 	sw	zero,20(sp)
bfc07980:	afa00038 	sw	zero,56(sp)
bfc07984:	afa00018 	sw	zero,24(sp)
bfc07988:	afa0003c 	sw	zero,60(sp)
bfc0798c:	afa0001c 	sw	zero,28(sp)
bfc07990:	afa00040 	sw	zero,64(sp)
bfc07994:	afa00020 	sw	zero,32(sp)
bfc07998:	afa00044 	sw	zero,68(sp)
bfc0799c:	afa00024 	sw	zero,36(sp)
bfc079a0:	afa00048 	sw	zero,72(sp)
bfc079a4:	afa00028 	sw	zero,40(sp)
bfc079a8:	afa0004c 	sw	zero,76(sp)
bfc079ac:	afa0002c 	sw	zero,44(sp)
bfc079b0:	87ad0078 	lh	t5,120(sp)
bfc079b4:	97b4007c 	lhu	s4,124(sp)
bfc079b8:	11600054 	beqz	t3,bfc07b0c <core_bench_state+0x1cc>
bfc079bc:	00129403 	sra	s2,s2,0x10
bfc079c0:	3c028000 	lui	v0,0x8000
bfc079c4:	01604821 	move	t1,t3
bfc079c8:	240e002c 	li	t6,44
bfc079cc:	24590710 	addiu	t9,v0,1808
bfc079d0:	00a06021 	move	t4,a1
bfc079d4:	27b10010 	addiu	s1,sp,16
bfc079d8:	240f0001 	li	t7,1
bfc079dc:	241f002b 	li	ra,43
bfc079e0:	2404002d 	li	a0,45
bfc079e4:	24060045 	li	a2,69
bfc079e8:	112e0028 	beq	t1,t6,bfc07a8c <core_bench_state+0x14c>
bfc079ec:	24070065 	li	a3,101
bfc079f0:	00005021 	move	t2,zero
bfc079f4:	2418002e 	li	t8,46
bfc079f8:	000a4080 	sll	t0,t2,0x2
bfc079fc:	03281021 	addu	v0,t9,t0
bfc07a00:	8c430000 	lw	v1,0(v0)
bfc07a04:	00000000 	nop
bfc07a08:	00600008 	jr	v1
bfc07a0c:	00000000 	nop
bfc07a10:	1126008f 	beq	t1,a2,bfc07c50 <core_bench_state+0x310>
bfc07a14:	00000000 	nop
bfc07a18:	1127008d 	beq	t1,a3,bfc07c50 <core_bench_state+0x310>
bfc07a1c:	2522ffd0 	addiu	v0,t1,-48
bfc07a20:	304900ff 	andi	t1,v0,0xff
bfc07a24:	2d23000a 	sltiu	v1,t1,10
bfc07a28:	14600005 	bnez	v1,bfc07a40 <core_bench_state+0x100>
bfc07a2c:	00000000 	nop
bfc07a30:	8fa30044 	lw	v1,68(sp)
bfc07a34:	240a0001 	li	t2,1
bfc07a38:	24680001 	addiu	t0,v1,1
bfc07a3c:	afa80044 	sw	t0,68(sp)
bfc07a40:	258c0001 	addiu	t4,t4,1
bfc07a44:	91880000 	lbu	t0,0(t4)
bfc07a48:	00000000 	nop
bfc07a4c:	11000029 	beqz	t0,bfc07af4 <core_bench_state+0x1b4>
bfc07a50:	01004821 	move	t1,t0
bfc07a54:	114f00b2 	beq	t2,t7,bfc07d20 <core_bench_state+0x3e0>
bfc07a58:	00000000 	nop
bfc07a5c:	152effe7 	bne	t1,t6,bfc079fc <core_bench_state+0xbc>
bfc07a60:	000a4080 	sll	t0,t2,0x2
bfc07a64:	02281821 	addu	v1,s1,t0
bfc07a68:	8c6a0000 	lw	t2,0(v1)
bfc07a6c:	258c0001 	addiu	t4,t4,1
bfc07a70:	91880000 	lbu	t0,0(t4)
bfc07a74:	25490001 	addiu	t1,t2,1
bfc07a78:	11000024 	beqz	t0,bfc07b0c <core_bench_state+0x1cc>
bfc07a7c:	ac690000 	sw	t1,0(v1)
bfc07a80:	01004821 	move	t1,t0
bfc07a84:	152effdb 	bne	t1,t6,bfc079f4 <core_bench_state+0xb4>
bfc07a88:	00005021 	move	t2,zero
bfc07a8c:	00005021 	move	t2,zero
bfc07a90:	000a4080 	sll	t0,t2,0x2
bfc07a94:	02281821 	addu	v1,s1,t0
bfc07a98:	8c6a0000 	lw	t2,0(v1)
bfc07a9c:	258c0001 	addiu	t4,t4,1
bfc07aa0:	91880000 	lbu	t0,0(t4)
bfc07aa4:	25490001 	addiu	t1,t2,1
bfc07aa8:	1500fff5 	bnez	t0,bfc07a80 <core_bench_state+0x140>
bfc07aac:	ac690000 	sw	t1,0(v1)
bfc07ab0:	0bf01ec4 	j	bfc07b10 <core_bench_state+0x1d0>
bfc07ab4:	00b32021 	addu	a0,a1,s3
	...
bfc07ac0:	2522ffd0 	addiu	v0,t1,-48
bfc07ac4:	304300ff 	andi	v1,v0,0xff
bfc07ac8:	2c68000a 	sltiu	t0,v1,10
bfc07acc:	1500ffdc 	bnez	t0,bfc07a40 <core_bench_state+0x100>
bfc07ad0:	00000000 	nop
bfc07ad4:	8fa80034 	lw	t0,52(sp)
bfc07ad8:	258c0001 	addiu	t4,t4,1
bfc07adc:	25090001 	addiu	t1,t0,1
bfc07ae0:	afa90034 	sw	t1,52(sp)
bfc07ae4:	91880000 	lbu	t0,0(t4)
bfc07ae8:	240a0001 	li	t2,1
bfc07aec:	1500ffd9 	bnez	t0,bfc07a54 <core_bench_state+0x114>
bfc07af0:	01004821 	move	t1,t0
bfc07af4:	000a6080 	sll	t4,t2,0x2
bfc07af8:	022cc821 	addu	t9,s1,t4
bfc07afc:	8f3f0000 	lw	ra,0(t9)
bfc07b00:	00000000 	nop
bfc07b04:	27e40001 	addiu	a0,ra,1
bfc07b08:	af240000 	sw	a0,0(t9)
bfc07b0c:	00b32021 	addu	a0,a1,s3
bfc07b10:	00a4382b 	sltu	a3,a1,a0
bfc07b14:	10e00091 	beqz	a3,bfc07d5c <core_bench_state+0x41c>
bfc07b18:	00ad1821 	addu	v1,a1,t5
bfc07b1c:	00a04021 	move	t0,a1
bfc07b20:	240a002c 	li	t2,44
bfc07b24:	000d4823 	negu	t1,t5
bfc07b28:	116a0002 	beq	t3,t2,bfc07b34 <core_bench_state+0x1f4>
bfc07b2c:	01703026 	xor	a2,t3,s0
bfc07b30:	a1060000 	sb	a2,0(t0)
bfc07b34:	006d1821 	addu	v1,v1,t5
bfc07b38:	006d6023 	subu	t4,v1,t5
bfc07b3c:	0184582b 	sltu	t3,t4,a0
bfc07b40:	11600084 	beqz	t3,bfc07d54 <core_bench_state+0x414>
bfc07b44:	010d4021 	addu	t0,t0,t5
bfc07b48:	00697021 	addu	t6,v1,t1
bfc07b4c:	91cb0000 	lbu	t3,0(t6)
bfc07b50:	0bf01eca 	j	bfc07b28 <core_bench_state+0x1e8>
bfc07b54:	00000000 	nop
	...
bfc07b60:	11380067 	beq	t1,t8,bfc07d00 <core_bench_state+0x3c0>
bfc07b64:	2528ffd0 	addiu	t0,t1,-48
bfc07b68:	310200ff 	andi	v0,t0,0xff
bfc07b6c:	2c49000a 	sltiu	t1,v0,10
bfc07b70:	1520ffb3 	bnez	t1,bfc07a40 <core_bench_state+0x100>
bfc07b74:	00000000 	nop
bfc07b78:	8fa90040 	lw	t1,64(sp)
bfc07b7c:	240a0001 	li	t2,1
bfc07b80:	25230001 	addiu	v1,t1,1
bfc07b84:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07b88:	afa30040 	sw	v1,64(sp)
bfc07b8c:	00000000 	nop
bfc07b90:	113f0037 	beq	t1,ra,bfc07c70 <core_bench_state+0x330>
bfc07b94:	00000000 	nop
bfc07b98:	11240035 	beq	t1,a0,bfc07c70 <core_bench_state+0x330>
bfc07b9c:	00000000 	nop
bfc07ba0:	8fa3003c 	lw	v1,60(sp)
bfc07ba4:	240a0001 	li	t2,1
bfc07ba8:	24680001 	addiu	t0,v1,1
bfc07bac:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07bb0:	afa8003c 	sw	t0,60(sp)
	...
bfc07bc0:	2522ffd0 	addiu	v0,t1,-48
bfc07bc4:	304900ff 	andi	t1,v0,0xff
bfc07bc8:	2d2a000a 	sltiu	t2,t1,10
bfc07bcc:	11400038 	beqz	t2,bfc07cb0 <core_bench_state+0x370>
bfc07bd0:	00000000 	nop
bfc07bd4:	8fa30048 	lw	v1,72(sp)
bfc07bd8:	240a0007 	li	t2,7
bfc07bdc:	24680001 	addiu	t0,v1,1
bfc07be0:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07be4:	afa80048 	sw	t0,72(sp)
	...
bfc07bf0:	2522ffd0 	addiu	v0,t1,-48
bfc07bf4:	304300ff 	andi	v1,v0,0xff
bfc07bf8:	2c6a000a 	sltiu	t2,v1,10
bfc07bfc:	11400034 	beqz	t2,bfc07cd0 <core_bench_state+0x390>
bfc07c00:	240a0004 	li	t2,4
bfc07c04:	8fa20030 	lw	v0,48(sp)
bfc07c08:	00000000 	nop
bfc07c0c:	24430001 	addiu	v1,v0,1
bfc07c10:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07c14:	afa30030 	sw	v1,48(sp)
	...
bfc07c20:	2523ffd0 	addiu	v1,t1,-48
bfc07c24:	306800ff 	andi	t0,v1,0xff
bfc07c28:	2d0a000a 	sltiu	t2,t0,10
bfc07c2c:	11400018 	beqz	t2,bfc07c90 <core_bench_state+0x350>
bfc07c30:	240a0004 	li	t2,4
bfc07c34:	8fa20038 	lw	v0,56(sp)
bfc07c38:	00000000 	nop
bfc07c3c:	24490001 	addiu	t1,v0,1
bfc07c40:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07c44:	afa90038 	sw	t1,56(sp)
	...
bfc07c50:	8fa80044 	lw	t0,68(sp)
bfc07c54:	240a0003 	li	t2,3
bfc07c58:	25020001 	addiu	v0,t0,1
bfc07c5c:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07c60:	afa20044 	sw	v0,68(sp)
	...
bfc07c70:	8fa2003c 	lw	v0,60(sp)
bfc07c74:	240a0006 	li	t2,6
bfc07c78:	24490001 	addiu	t1,v0,1
bfc07c7c:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07c80:	afa9003c 	sw	t1,60(sp)
	...
bfc07c90:	1138002b 	beq	t1,t8,bfc07d40 <core_bench_state+0x400>
bfc07c94:	00000000 	nop
bfc07c98:	8fa20038 	lw	v0,56(sp)
bfc07c9c:	240a0001 	li	t2,1
bfc07ca0:	24490001 	addiu	t1,v0,1
bfc07ca4:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07ca8:	afa90038 	sw	t1,56(sp)
bfc07cac:	00000000 	nop
bfc07cb0:	8fa20048 	lw	v0,72(sp)
bfc07cb4:	240a0001 	li	t2,1
bfc07cb8:	24490001 	addiu	t1,v0,1
bfc07cbc:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07cc0:	afa90048 	sw	t1,72(sp)
	...
bfc07cd0:	113fffcc 	beq	t1,ra,bfc07c04 <core_bench_state+0x2c4>
bfc07cd4:	240a0002 	li	t2,2
bfc07cd8:	1124ffca 	beq	t1,a0,bfc07c04 <core_bench_state+0x2c4>
bfc07cdc:	00000000 	nop
bfc07ce0:	11380136 	beq	t1,t8,bfc081bc <core_bench_state+0x87c>
bfc07ce4:	00000000 	nop
bfc07ce8:	8fa80034 	lw	t0,52(sp)
bfc07cec:	240a0001 	li	t2,1
bfc07cf0:	25090001 	addiu	t1,t0,1
bfc07cf4:	0bf01f01 	j	bfc07c04 <core_bench_state+0x2c4>
bfc07cf8:	afa90034 	sw	t1,52(sp)
bfc07cfc:	00000000 	nop
bfc07d00:	8fa30040 	lw	v1,64(sp)
bfc07d04:	240a0005 	li	t2,5
bfc07d08:	24680001 	addiu	t0,v1,1
bfc07d0c:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07d10:	afa80040 	sw	t0,64(sp)
	...
bfc07d20:	8fa90014 	lw	t1,20(sp)
bfc07d24:	00000000 	nop
bfc07d28:	252a0001 	addiu	t2,t1,1
bfc07d2c:	afaa0014 	sw	t2,20(sp)
bfc07d30:	0bf01ea1 	j	bfc07a84 <core_bench_state+0x144>
bfc07d34:	01004821 	move	t1,t0
	...
bfc07d40:	8fa30038 	lw	v1,56(sp)
bfc07d44:	240a0005 	li	t2,5
bfc07d48:	24680001 	addiu	t0,v1,1
bfc07d4c:	0bf01e90 	j	bfc07a40 <core_bench_state+0x100>
bfc07d50:	afa80038 	sw	t0,56(sp)
bfc07d54:	90ab0000 	lbu	t3,0(a1)
bfc07d58:	00000000 	nop
bfc07d5c:	11600053 	beqz	t3,bfc07eac <core_bench_state+0x56c>
bfc07d60:	3c118000 	lui	s1,0x8000
bfc07d64:	240a002c 	li	t2,44
bfc07d68:	262f0730 	addiu	t7,s1,1840
bfc07d6c:	00a04821 	move	t1,a1
bfc07d70:	27b10010 	addiu	s1,sp,16
bfc07d74:	240c0001 	li	t4,1
bfc07d78:	2418002b 	li	t8,43
bfc07d7c:	2419002d 	li	t9,45
bfc07d80:	241f0045 	li	ra,69
bfc07d84:	116a002a 	beq	t3,t2,bfc07e30 <core_bench_state+0x4f0>
bfc07d88:	24100065 	li	s0,101
bfc07d8c:	00004021 	move	t0,zero
bfc07d90:	240e002e 	li	t6,46
bfc07d94:	00081080 	sll	v0,t0,0x2
bfc07d98:	01e21821 	addu	v1,t7,v0
bfc07d9c:	8c730000 	lw	s3,0(v1)
bfc07da0:	00000000 	nop
bfc07da4:	02600008 	jr	s3
bfc07da8:	00000000 	nop
bfc07dac:	00000000 	nop
bfc07db0:	117f00bf 	beq	t3,ra,bfc080b0 <core_bench_state+0x770>
bfc07db4:	00000000 	nop
bfc07db8:	117000bd 	beq	t3,s0,bfc080b0 <core_bench_state+0x770>
bfc07dbc:	2566ffd0 	addiu	a2,t3,-48
bfc07dc0:	30cb00ff 	andi	t3,a2,0xff
bfc07dc4:	2d62000a 	sltiu	v0,t3,10
bfc07dc8:	14400005 	bnez	v0,bfc07de0 <core_bench_state+0x4a0>
bfc07dcc:	00000000 	nop
bfc07dd0:	8fa30044 	lw	v1,68(sp)
bfc07dd4:	24080001 	li	t0,1
bfc07dd8:	24730001 	addiu	s3,v1,1
bfc07ddc:	afb30044 	sw	s3,68(sp)
bfc07de0:	25290001 	addiu	t1,t1,1
bfc07de4:	91260000 	lbu	a2,0(t1)
bfc07de8:	00000000 	nop
bfc07dec:	10c00029 	beqz	a2,bfc07e94 <core_bench_state+0x554>
bfc07df0:	00c05821 	move	t3,a2
bfc07df4:	110c00e2 	beq	t0,t4,bfc08180 <core_bench_state+0x840>
bfc07df8:	00000000 	nop
bfc07dfc:	156affe6 	bne	t3,t2,bfc07d98 <core_bench_state+0x458>
bfc07e00:	00081080 	sll	v0,t0,0x2
bfc07e04:	00083080 	sll	a2,t0,0x2
bfc07e08:	02261821 	addu	v1,s1,a2
bfc07e0c:	8c620000 	lw	v0,0(v1)
bfc07e10:	25290001 	addiu	t1,t1,1
bfc07e14:	91260000 	lbu	a2,0(t1)
bfc07e18:	24530001 	addiu	s3,v0,1
bfc07e1c:	10c00023 	beqz	a2,bfc07eac <core_bench_state+0x56c>
bfc07e20:	ac730000 	sw	s3,0(v1)
bfc07e24:	00c05821 	move	t3,a2
bfc07e28:	156affd9 	bne	t3,t2,bfc07d90 <core_bench_state+0x450>
bfc07e2c:	00004021 	move	t0,zero
bfc07e30:	00004021 	move	t0,zero
bfc07e34:	00083080 	sll	a2,t0,0x2
bfc07e38:	02261821 	addu	v1,s1,a2
bfc07e3c:	8c620000 	lw	v0,0(v1)
bfc07e40:	25290001 	addiu	t1,t1,1
bfc07e44:	91260000 	lbu	a2,0(t1)
bfc07e48:	24530001 	addiu	s3,v0,1
bfc07e4c:	14c0fff5 	bnez	a2,bfc07e24 <core_bench_state+0x4e4>
bfc07e50:	ac730000 	sw	s3,0(v1)
bfc07e54:	0bf01fab 	j	bfc07eac <core_bench_state+0x56c>
bfc07e58:	00000000 	nop
bfc07e5c:	00000000 	nop
bfc07e60:	2566ffd0 	addiu	a2,t3,-48
bfc07e64:	30cb00ff 	andi	t3,a2,0xff
bfc07e68:	2d62000a 	sltiu	v0,t3,10
bfc07e6c:	1440ffdc 	bnez	v0,bfc07de0 <core_bench_state+0x4a0>
bfc07e70:	00000000 	nop
bfc07e74:	8fa30034 	lw	v1,52(sp)
bfc07e78:	25290001 	addiu	t1,t1,1
bfc07e7c:	24730001 	addiu	s3,v1,1
bfc07e80:	afb30034 	sw	s3,52(sp)
bfc07e84:	91260000 	lbu	a2,0(t1)
bfc07e88:	24080001 	li	t0,1
bfc07e8c:	14c0ffd9 	bnez	a2,bfc07df4 <core_bench_state+0x4b4>
bfc07e90:	00c05821 	move	t3,a2
bfc07e94:	00081080 	sll	v0,t0,0x2
bfc07e98:	02225821 	addu	t3,s1,v0
bfc07e9c:	8d710000 	lw	s1,0(t3)
bfc07ea0:	00000000 	nop
bfc07ea4:	26300001 	addiu	s0,s1,1
bfc07ea8:	ad700000 	sw	s0,0(t3)
bfc07eac:	10e0000d 	beqz	a3,bfc07ee4 <core_bench_state+0x5a4>
bfc07eb0:	00a01821 	move	v1,a1
bfc07eb4:	2406002c 	li	a2,44
bfc07eb8:	00ad2821 	addu	a1,a1,t5
bfc07ebc:	90620000 	lbu	v0,0(v1)
bfc07ec0:	00000000 	nop
bfc07ec4:	10460002 	beq	v0,a2,bfc07ed0 <core_bench_state+0x590>
bfc07ec8:	00523826 	xor	a3,v0,s2
bfc07ecc:	a0670000 	sb	a3,0(v1)
bfc07ed0:	00ad2821 	addu	a1,a1,t5
bfc07ed4:	00adc023 	subu	t8,a1,t5
bfc07ed8:	0304782b 	sltu	t7,t8,a0
bfc07edc:	15e0fff7 	bnez	t7,bfc07ebc <core_bench_state+0x57c>
bfc07ee0:	006d1821 	addu	v1,v1,t5
bfc07ee4:	8fa40010 	lw	a0,16(sp)
bfc07ee8:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07eec:	02802821 	move	a1,s4
bfc07ef0:	8fa40030 	lw	a0,48(sp)
bfc07ef4:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07ef8:	00402821 	move	a1,v0
bfc07efc:	8fa40014 	lw	a0,20(sp)
bfc07f00:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f04:	00402821 	move	a1,v0
bfc07f08:	8fa40034 	lw	a0,52(sp)
bfc07f0c:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f10:	00402821 	move	a1,v0
bfc07f14:	8fa40018 	lw	a0,24(sp)
bfc07f18:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f1c:	00402821 	move	a1,v0
bfc07f20:	8fa40038 	lw	a0,56(sp)
bfc07f24:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f28:	00402821 	move	a1,v0
bfc07f2c:	8fa4001c 	lw	a0,28(sp)
bfc07f30:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f34:	00402821 	move	a1,v0
bfc07f38:	8fa4003c 	lw	a0,60(sp)
bfc07f3c:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f40:	00402821 	move	a1,v0
bfc07f44:	8fa40020 	lw	a0,32(sp)
bfc07f48:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f4c:	00402821 	move	a1,v0
bfc07f50:	8fa40040 	lw	a0,64(sp)
bfc07f54:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f58:	00402821 	move	a1,v0
bfc07f5c:	8fa40024 	lw	a0,36(sp)
bfc07f60:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f64:	00402821 	move	a1,v0
bfc07f68:	8fa40044 	lw	a0,68(sp)
bfc07f6c:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f70:	00402821 	move	a1,v0
bfc07f74:	8fa40028 	lw	a0,40(sp)
bfc07f78:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f7c:	00402821 	move	a1,v0
bfc07f80:	8fa40048 	lw	a0,72(sp)
bfc07f84:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f88:	00402821 	move	a1,v0
bfc07f8c:	8fa4002c 	lw	a0,44(sp)
bfc07f90:	0ff0191c 	jal	bfc06470 <crcu32>
bfc07f94:	00402821 	move	a1,v0
bfc07f98:	8fa4004c 	lw	a0,76(sp)
bfc07f9c:	8fbf0064 	lw	ra,100(sp)
bfc07fa0:	8fb40060 	lw	s4,96(sp)
bfc07fa4:	8fb3005c 	lw	s3,92(sp)
bfc07fa8:	8fb20058 	lw	s2,88(sp)
bfc07fac:	8fb10054 	lw	s1,84(sp)
bfc07fb0:	8fb00050 	lw	s0,80(sp)
bfc07fb4:	00402821 	move	a1,v0
bfc07fb8:	0bf0191c 	j	bfc06470 <crcu32>
bfc07fbc:	27bd0068 	addiu	sp,sp,104
bfc07fc0:	2562ffd0 	addiu	v0,t3,-48
bfc07fc4:	304300ff 	andi	v1,v0,0xff
bfc07fc8:	2c68000a 	sltiu	t0,v1,10
bfc07fcc:	11000048 	beqz	t0,bfc080f0 <core_bench_state+0x7b0>
bfc07fd0:	00000000 	nop
bfc07fd4:	8fa60048 	lw	a2,72(sp)
bfc07fd8:	24080007 	li	t0,7
bfc07fdc:	24cb0001 	addiu	t3,a2,1
bfc07fe0:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc07fe4:	afab0048 	sw	t3,72(sp)
	...
bfc07ff0:	2573ffd0 	addiu	s3,t3,-48
bfc07ff4:	326600ff 	andi	a2,s3,0xff
bfc07ff8:	2cc8000a 	sltiu	t0,a2,10
bfc07ffc:	11000044 	beqz	t0,bfc08110 <core_bench_state+0x7d0>
bfc08000:	24080004 	li	t0,4
bfc08004:	8fa60030 	lw	a2,48(sp)
bfc08008:	00000000 	nop
bfc0800c:	24c20001 	addiu	v0,a2,1
bfc08010:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc08014:	afa20030 	sw	v0,48(sp)
	...
bfc08020:	1178002b 	beq	t3,t8,bfc080d0 <core_bench_state+0x790>
bfc08024:	00000000 	nop
bfc08028:	11790029 	beq	t3,t9,bfc080d0 <core_bench_state+0x790>
bfc0802c:	00000000 	nop
bfc08030:	8fb3003c 	lw	s3,60(sp)
bfc08034:	24080001 	li	t0,1
bfc08038:	26660001 	addiu	a2,s3,1
bfc0803c:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc08040:	afa6003c 	sw	a2,60(sp)
	...
bfc08050:	116e0043 	beq	t3,t6,bfc08160 <core_bench_state+0x820>
bfc08054:	2562ffd0 	addiu	v0,t3,-48
bfc08058:	304300ff 	andi	v1,v0,0xff
bfc0805c:	2c73000a 	sltiu	s3,v1,10
bfc08060:	1660ff5f 	bnez	s3,bfc07de0 <core_bench_state+0x4a0>
bfc08064:	00000000 	nop
bfc08068:	8fa60040 	lw	a2,64(sp)
bfc0806c:	24080001 	li	t0,1
bfc08070:	24cb0001 	addiu	t3,a2,1
bfc08074:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc08078:	afab0040 	sw	t3,64(sp)
bfc0807c:	00000000 	nop
bfc08080:	2563ffd0 	addiu	v1,t3,-48
bfc08084:	307300ff 	andi	s3,v1,0xff
bfc08088:	2e68000a 	sltiu	t0,s3,10
bfc0808c:	1100002c 	beqz	t0,bfc08140 <core_bench_state+0x800>
bfc08090:	24080004 	li	t0,4
bfc08094:	8fa20038 	lw	v0,56(sp)
bfc08098:	00000000 	nop
bfc0809c:	244b0001 	addiu	t3,v0,1
bfc080a0:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc080a4:	afab0038 	sw	t3,56(sp)
	...
bfc080b0:	8fa30044 	lw	v1,68(sp)
bfc080b4:	24080003 	li	t0,3
bfc080b8:	24730001 	addiu	s3,v1,1
bfc080bc:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc080c0:	afb30044 	sw	s3,68(sp)
	...
bfc080d0:	8fab003c 	lw	t3,60(sp)
bfc080d4:	24080006 	li	t0,6
bfc080d8:	25620001 	addiu	v0,t3,1
bfc080dc:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc080e0:	afa2003c 	sw	v0,60(sp)
	...
bfc080f0:	8fa30048 	lw	v1,72(sp)
bfc080f4:	24080001 	li	t0,1
bfc080f8:	24730001 	addiu	s3,v1,1
bfc080fc:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc08100:	afb30048 	sw	s3,72(sp)
	...
bfc08110:	1178ffbc 	beq	t3,t8,bfc08004 <core_bench_state+0x6c4>
bfc08114:	24080002 	li	t0,2
bfc08118:	1179ffba 	beq	t3,t9,bfc08004 <core_bench_state+0x6c4>
bfc0811c:	00000000 	nop
bfc08120:	116e0024 	beq	t3,t6,bfc081b4 <core_bench_state+0x874>
bfc08124:	00000000 	nop
bfc08128:	8fa30034 	lw	v1,52(sp)
bfc0812c:	24080001 	li	t0,1
bfc08130:	246b0001 	addiu	t3,v1,1
bfc08134:	0bf02001 	j	bfc08004 <core_bench_state+0x6c4>
bfc08138:	afab0034 	sw	t3,52(sp)
bfc0813c:	00000000 	nop
bfc08140:	116e0017 	beq	t3,t6,bfc081a0 <core_bench_state+0x860>
bfc08144:	00000000 	nop
bfc08148:	8fab0038 	lw	t3,56(sp)
bfc0814c:	24080001 	li	t0,1
bfc08150:	25630001 	addiu	v1,t3,1
bfc08154:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc08158:	afa30038 	sw	v1,56(sp)
bfc0815c:	00000000 	nop
bfc08160:	8fa60040 	lw	a2,64(sp)
bfc08164:	24080005 	li	t0,5
bfc08168:	24c20001 	addiu	v0,a2,1
bfc0816c:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc08170:	afa20040 	sw	v0,64(sp)
	...
bfc08180:	8fa80014 	lw	t0,20(sp)
bfc08184:	00c05821 	move	t3,a2
bfc08188:	250e0001 	addiu	t6,t0,1
bfc0818c:	0bf01f8a 	j	bfc07e28 <core_bench_state+0x4e8>
bfc08190:	afae0014 	sw	t6,20(sp)
	...
bfc081a0:	8fb30038 	lw	s3,56(sp)
bfc081a4:	24080005 	li	t0,5
bfc081a8:	26660001 	addiu	a2,s3,1
bfc081ac:	0bf01f78 	j	bfc07de0 <core_bench_state+0x4a0>
bfc081b0:	afa60038 	sw	a2,56(sp)
bfc081b4:	0bf02001 	j	bfc08004 <core_bench_state+0x6c4>
bfc081b8:	24080005 	li	t0,5
bfc081bc:	0bf01f01 	j	bfc07c04 <core_bench_state+0x2c4>
bfc081c0:	240a0005 	li	t2,5
	...

bfc081d0 <cmp_idx>:
cmp_idx():
bfc081d0:	10c00007 	beqz	a2,bfc081f0 <cmp_idx+0x20>
bfc081d4:	00803821 	move	a3,a0
bfc081d8:	84ef0002 	lh	t7,2(a3)
bfc081dc:	84a70002 	lh	a3,2(a1)
bfc081e0:	03e00008 	jr	ra
bfc081e4:	01e71023 	subu	v0,t7,a3
	...
bfc081f0:	848d0000 	lh	t5,0(a0)
bfc081f4:	2409ff00 	li	t1,-256
bfc081f8:	31aeffff 	andi	t6,t5,0xffff
bfc081fc:	000e5a02 	srl	t3,t6,0x8
bfc08200:	01a96024 	and	t4,t5,t1
bfc08204:	016c5025 	or	t2,t3,t4
bfc08208:	a48a0000 	sh	t2,0(a0)
bfc0820c:	84a80000 	lh	t0,0(a1)
bfc08210:	84ef0002 	lh	t7,2(a3)
bfc08214:	3106ffff 	andi	a2,t0,0xffff
bfc08218:	01091824 	and	v1,t0,t1
bfc0821c:	00062202 	srl	a0,a2,0x8
bfc08220:	84a70002 	lh	a3,2(a1)
bfc08224:	00831025 	or	v0,a0,v1
bfc08228:	a4a20000 	sh	v0,0(a1)
bfc0822c:	03e00008 	jr	ra
bfc08230:	01e71023 	subu	v0,t7,a3
	...

bfc08240 <copy_info>:
copy_info():
bfc08240:	94a20002 	lhu	v0,2(a1)
bfc08244:	94a30000 	lhu	v1,0(a1)
bfc08248:	a4820002 	sh	v0,2(a0)
bfc0824c:	03e00008 	jr	ra
bfc08250:	a4830000 	sh	v1,0(a0)
	...

bfc08260 <core_list_insert_new>:
core_list_insert_new():
bfc08260:	8cc80000 	lw	t0,0(a2)
bfc08264:	8fa30010 	lw	v1,16(sp)
bfc08268:	25090008 	addiu	t1,t0,8
bfc0826c:	0123102b 	sltu	v0,t1,v1
bfc08270:	00805021 	move	t2,a0
bfc08274:	14400006 	bnez	v0,bfc08290 <core_list_insert_new+0x30>
bfc08278:	00a01821 	move	v1,a1
bfc0827c:	00004021 	move	t0,zero
bfc08280:	03e00008 	jr	ra
bfc08284:	01001021 	move	v0,t0
	...
bfc08290:	8ce40000 	lw	a0,0(a3)
bfc08294:	8fa50014 	lw	a1,20(sp)
bfc08298:	248c0004 	addiu	t4,a0,4
bfc0829c:	0185582b 	sltu	t3,t4,a1
bfc082a0:	1160fff6 	beqz	t3,bfc0827c <core_list_insert_new+0x1c>
bfc082a4:	00000000 	nop
bfc082a8:	ad040004 	sw	a0,4(t0)
bfc082ac:	8cee0000 	lw	t6,0(a3)
bfc082b0:	acc90000 	sw	t1,0(a2)
bfc082b4:	25cd0004 	addiu	t5,t6,4
bfc082b8:	aced0000 	sw	t5,0(a3)
bfc082bc:	8d490000 	lw	t1,0(t2)
bfc082c0:	8d060004 	lw	a2,4(t0)
bfc082c4:	94640002 	lhu	a0,2(v1)
bfc082c8:	94670000 	lhu	a3,0(v1)
bfc082cc:	ad090000 	sw	t1,0(t0)
bfc082d0:	a4c40002 	sh	a0,2(a2)
bfc082d4:	a4c70000 	sh	a3,0(a2)
bfc082d8:	0bf020a0 	j	bfc08280 <core_list_insert_new+0x20>
bfc082dc:	ad480000 	sw	t0,0(t2)

bfc082e0 <core_list_remove>:
core_list_remove():
bfc082e0:	8c820000 	lw	v0,0(a0)
bfc082e4:	8c860004 	lw	a2,4(a0)
bfc082e8:	8c430004 	lw	v1,4(v0)
bfc082ec:	8c450000 	lw	a1,0(v0)
bfc082f0:	ac830004 	sw	v1,4(a0)
bfc082f4:	ac850000 	sw	a1,0(a0)
bfc082f8:	ac460004 	sw	a2,4(v0)
bfc082fc:	03e00008 	jr	ra
bfc08300:	ac400000 	sw	zero,0(v0)
	...

bfc08310 <core_list_undo_remove>:
core_list_undo_remove():
bfc08310:	00801021 	move	v0,a0
bfc08314:	8c860004 	lw	a2,4(a0)
bfc08318:	8ca30004 	lw	v1,4(a1)
bfc0831c:	8ca40000 	lw	a0,0(a1)
bfc08320:	ac430004 	sw	v1,4(v0)
bfc08324:	ac440000 	sw	a0,0(v0)
bfc08328:	aca60004 	sw	a2,4(a1)
bfc0832c:	03e00008 	jr	ra
bfc08330:	aca20000 	sw	v0,0(a1)
	...

bfc08340 <core_list_find>:
core_list_find():
bfc08340:	84a60002 	lh	a2,2(a1)
bfc08344:	00000000 	nop
bfc08348:	04c00011 	bltz	a2,bfc08390 <core_list_find+0x50>
bfc0834c:	00000000 	nop
bfc08350:	1080000b 	beqz	a0,bfc08380 <core_list_find+0x40>
bfc08354:	00000000 	nop
bfc08358:	8c870004 	lw	a3,4(a0)
bfc0835c:	00000000 	nop
bfc08360:	84e50002 	lh	a1,2(a3)
bfc08364:	00000000 	nop
bfc08368:	10a60005 	beq	a1,a2,bfc08380 <core_list_find+0x40>
bfc0836c:	00000000 	nop
bfc08370:	8c840000 	lw	a0,0(a0)
bfc08374:	00000000 	nop
bfc08378:	1480fff7 	bnez	a0,bfc08358 <core_list_find+0x18>
bfc0837c:	00000000 	nop
bfc08380:	03e00008 	jr	ra
bfc08384:	00801021 	move	v0,a0
	...
bfc08390:	1080fffb 	beqz	a0,bfc08380 <core_list_find+0x40>
bfc08394:	00000000 	nop
bfc08398:	8c830004 	lw	v1,4(a0)
bfc0839c:	84a50000 	lh	a1,0(a1)
bfc083a0:	90620000 	lbu	v0,0(v1)
bfc083a4:	00000000 	nop
bfc083a8:	1445000b 	bne	v0,a1,bfc083d8 <core_list_find+0x98>
bfc083ac:	00000000 	nop
bfc083b0:	0bf020e0 	j	bfc08380 <core_list_find+0x40>
bfc083b4:	00000000 	nop
	...
bfc083c0:	8c880004 	lw	t0,4(a0)
bfc083c4:	00000000 	nop
bfc083c8:	91060000 	lbu	a2,0(t0)
bfc083cc:	00000000 	nop
bfc083d0:	10c5ffeb 	beq	a2,a1,bfc08380 <core_list_find+0x40>
bfc083d4:	00000000 	nop
bfc083d8:	8c840000 	lw	a0,0(a0)
bfc083dc:	00000000 	nop
bfc083e0:	1480fff7 	bnez	a0,bfc083c0 <core_list_find+0x80>
bfc083e4:	00801021 	move	v0,a0
bfc083e8:	03e00008 	jr	ra
bfc083ec:	00000000 	nop

bfc083f0 <core_list_reverse>:
core_list_reverse():
bfc083f0:	10800027 	beqz	a0,bfc08490 <core_list_reverse+0xa0>
bfc083f4:	00801021 	move	v0,a0
bfc083f8:	8c430000 	lw	v1,0(v0)
bfc083fc:	00002021 	move	a0,zero
bfc08400:	10600023 	beqz	v1,bfc08490 <core_list_reverse+0xa0>
bfc08404:	ac440000 	sw	a0,0(v0)
bfc08408:	8c640000 	lw	a0,0(v1)
bfc0840c:	ac620000 	sw	v0,0(v1)
bfc08410:	1080001f 	beqz	a0,bfc08490 <core_list_reverse+0xa0>
bfc08414:	00601021 	move	v0,v1
bfc08418:	8c850000 	lw	a1,0(a0)
bfc0841c:	00801021 	move	v0,a0
bfc08420:	10a0001b 	beqz	a1,bfc08490 <core_list_reverse+0xa0>
bfc08424:	ac830000 	sw	v1,0(a0)
bfc08428:	8ca30000 	lw	v1,0(a1)
bfc0842c:	00a01021 	move	v0,a1
bfc08430:	10600017 	beqz	v1,bfc08490 <core_list_reverse+0xa0>
bfc08434:	aca40000 	sw	a0,0(a1)
bfc08438:	8c640000 	lw	a0,0(v1)
bfc0843c:	00601021 	move	v0,v1
bfc08440:	10800013 	beqz	a0,bfc08490 <core_list_reverse+0xa0>
bfc08444:	ac650000 	sw	a1,0(v1)
bfc08448:	8c850000 	lw	a1,0(a0)
bfc0844c:	00801021 	move	v0,a0
bfc08450:	10a0000f 	beqz	a1,bfc08490 <core_list_reverse+0xa0>
bfc08454:	ac830000 	sw	v1,0(a0)
bfc08458:	8ca30000 	lw	v1,0(a1)
bfc0845c:	00a01021 	move	v0,a1
bfc08460:	1060000b 	beqz	v1,bfc08490 <core_list_reverse+0xa0>
bfc08464:	aca40000 	sw	a0,0(a1)
bfc08468:	00601021 	move	v0,v1
bfc0846c:	8c630000 	lw	v1,0(v1)
bfc08470:	00402021 	move	a0,v0
bfc08474:	10600006 	beqz	v1,bfc08490 <core_list_reverse+0xa0>
bfc08478:	ac450000 	sw	a1,0(v0)
bfc0847c:	00601021 	move	v0,v1
bfc08480:	8c430000 	lw	v1,0(v0)
bfc08484:	00000000 	nop
bfc08488:	1460ffdf 	bnez	v1,bfc08408 <core_list_reverse+0x18>
bfc0848c:	ac440000 	sw	a0,0(v0)
bfc08490:	03e00008 	jr	ra
bfc08494:	00000000 	nop
	...

bfc084a0 <core_list_mergesort>:
core_list_mergesort():
bfc084a0:	27bdffc8 	addiu	sp,sp,-56
bfc084a4:	afb60028 	sw	s6,40(sp)
bfc084a8:	0080b021 	move	s6,a0
bfc084ac:	afbe0030 	sw	s8,48(sp)
bfc084b0:	afb50024 	sw	s5,36(sp)
bfc084b4:	afbf0034 	sw	ra,52(sp)
bfc084b8:	afb7002c 	sw	s7,44(sp)
bfc084bc:	afb40020 	sw	s4,32(sp)
bfc084c0:	afb3001c 	sw	s3,28(sp)
bfc084c4:	afb20018 	sw	s2,24(sp)
bfc084c8:	afb10014 	sw	s1,20(sp)
bfc084cc:	afb00010 	sw	s0,16(sp)
bfc084d0:	00a0f021 	move	s8,a1
bfc084d4:	afa60040 	sw	a2,64(sp)
bfc084d8:	12c00090 	beqz	s6,bfc0871c <core_list_mergesort+0x27c>
bfc084dc:	24150001 	li	s5,1
bfc084e0:	02c09821 	move	s3,s6
bfc084e4:	0000a021 	move	s4,zero
bfc084e8:	0000b021 	move	s6,zero
bfc084ec:	0000b821 	move	s7,zero
bfc084f0:	8e700000 	lw	s0,0(s3)
bfc084f4:	26a2ffff 	addiu	v0,s5,-1
bfc084f8:	26f70001 	addiu	s7,s7,1
bfc084fc:	30430007 	andi	v1,v0,0x7
bfc08500:	12000053 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08504:	24110001 	li	s1,1
bfc08508:	0235202a 	slt	a0,s1,s5
bfc0850c:	10800050 	beqz	a0,bfc08650 <core_list_mergesort+0x1b0>
bfc08510:	00000000 	nop
bfc08514:	1060002c 	beqz	v1,bfc085c8 <core_list_mergesort+0x128>
bfc08518:	00000000 	nop
bfc0851c:	10710023 	beq	v1,s1,bfc085ac <core_list_mergesort+0x10c>
bfc08520:	24050002 	li	a1,2
bfc08524:	1065001d 	beq	v1,a1,bfc0859c <core_list_mergesort+0xfc>
bfc08528:	24060003 	li	a2,3
bfc0852c:	10660017 	beq	v1,a2,bfc0858c <core_list_mergesort+0xec>
bfc08530:	24070004 	li	a3,4
bfc08534:	10670011 	beq	v1,a3,bfc0857c <core_list_mergesort+0xdc>
bfc08538:	24080005 	li	t0,5
bfc0853c:	1068000b 	beq	v1,t0,bfc0856c <core_list_mergesort+0xcc>
bfc08540:	24090006 	li	t1,6
bfc08544:	10690005 	beq	v1,t1,bfc0855c <core_list_mergesort+0xbc>
bfc08548:	00000000 	nop
bfc0854c:	8e100000 	lw	s0,0(s0)
bfc08550:	00000000 	nop
bfc08554:	1200003e 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08558:	24110002 	li	s1,2
bfc0855c:	8e100000 	lw	s0,0(s0)
bfc08560:	00000000 	nop
bfc08564:	1200003a 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08568:	26310001 	addiu	s1,s1,1
bfc0856c:	8e100000 	lw	s0,0(s0)
bfc08570:	00000000 	nop
bfc08574:	12000036 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08578:	26310001 	addiu	s1,s1,1
bfc0857c:	8e100000 	lw	s0,0(s0)
bfc08580:	00000000 	nop
bfc08584:	12000032 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08588:	26310001 	addiu	s1,s1,1
bfc0858c:	8e100000 	lw	s0,0(s0)
bfc08590:	00000000 	nop
bfc08594:	1200002e 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08598:	26310001 	addiu	s1,s1,1
bfc0859c:	8e100000 	lw	s0,0(s0)
bfc085a0:	00000000 	nop
bfc085a4:	1200002a 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc085a8:	26310001 	addiu	s1,s1,1
bfc085ac:	8e100000 	lw	s0,0(s0)
bfc085b0:	00000000 	nop
bfc085b4:	12000026 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc085b8:	26310001 	addiu	s1,s1,1
bfc085bc:	0235502a 	slt	t2,s1,s5
bfc085c0:	11400023 	beqz	t2,bfc08650 <core_list_mergesort+0x1b0>
bfc085c4:	00000000 	nop
bfc085c8:	8e100000 	lw	s0,0(s0)
bfc085cc:	26310001 	addiu	s1,s1,1
bfc085d0:	1200001f 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc085d4:	02201021 	move	v0,s1
bfc085d8:	8e100000 	lw	s0,0(s0)
bfc085dc:	00000000 	nop
bfc085e0:	1200001b 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc085e4:	26310001 	addiu	s1,s1,1
bfc085e8:	8e100000 	lw	s0,0(s0)
bfc085ec:	00000000 	nop
bfc085f0:	12000017 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc085f4:	24510002 	addiu	s1,v0,2
bfc085f8:	8e100000 	lw	s0,0(s0)
bfc085fc:	00000000 	nop
bfc08600:	12000013 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08604:	24510003 	addiu	s1,v0,3
bfc08608:	8e100000 	lw	s0,0(s0)
bfc0860c:	00000000 	nop
bfc08610:	1200000f 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08614:	24510004 	addiu	s1,v0,4
bfc08618:	8e100000 	lw	s0,0(s0)
bfc0861c:	00000000 	nop
bfc08620:	1200000b 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08624:	24510005 	addiu	s1,v0,5
bfc08628:	8e100000 	lw	s0,0(s0)
bfc0862c:	00000000 	nop
bfc08630:	12000007 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08634:	24510006 	addiu	s1,v0,6
bfc08638:	8e100000 	lw	s0,0(s0)
bfc0863c:	24510007 	addiu	s1,v0,7
bfc08640:	12000003 	beqz	s0,bfc08650 <core_list_mergesort+0x1b0>
bfc08644:	0235102a 	slt	v0,s1,s5
bfc08648:	1440ffdf 	bnez	v0,bfc085c8 <core_list_mergesort+0x128>
bfc0864c:	00000000 	nop
bfc08650:	12200017 	beqz	s1,bfc086b0 <core_list_mergesort+0x210>
bfc08654:	02a09021 	move	s2,s5
bfc08658:	12400021 	beqz	s2,bfc086e0 <core_list_mergesort+0x240>
bfc0865c:	00000000 	nop
bfc08660:	1200001f 	beqz	s0,bfc086e0 <core_list_mergesort+0x240>
bfc08664:	00000000 	nop
bfc08668:	8e640004 	lw	a0,4(s3)
bfc0866c:	8e050004 	lw	a1,4(s0)
bfc08670:	8fa60040 	lw	a2,64(sp)
bfc08674:	03c0f809 	jalr	s8
bfc08678:	00000000 	nop
bfc0867c:	18400018 	blez	v0,bfc086e0 <core_list_mergesort+0x240>
bfc08680:	00000000 	nop
bfc08684:	8e040000 	lw	a0,0(s0)
bfc08688:	2652ffff 	addiu	s2,s2,-1
bfc0868c:	02601821 	move	v1,s3
bfc08690:	02001021 	move	v0,s0
bfc08694:	1280000e 	beqz	s4,bfc086d0 <core_list_mergesort+0x230>
bfc08698:	00000000 	nop
bfc0869c:	ae820000 	sw	v0,0(s4)
bfc086a0:	0040a021 	move	s4,v0
bfc086a4:	00609821 	move	s3,v1
bfc086a8:	1620ffeb 	bnez	s1,bfc08658 <core_list_mergesort+0x1b8>
bfc086ac:	00808021 	move	s0,a0
bfc086b0:	12400013 	beqz	s2,bfc08700 <core_list_mergesort+0x260>
bfc086b4:	00000000 	nop
bfc086b8:	12000013 	beqz	s0,bfc08708 <core_list_mergesort+0x268>
bfc086bc:	2652ffff 	addiu	s2,s2,-1
bfc086c0:	02601821 	move	v1,s3
bfc086c4:	8e040000 	lw	a0,0(s0)
bfc086c8:	1680fff4 	bnez	s4,bfc0869c <core_list_mergesort+0x1fc>
bfc086cc:	02001021 	move	v0,s0
bfc086d0:	0bf021a8 	j	bfc086a0 <core_list_mergesort+0x200>
bfc086d4:	0040b021 	move	s6,v0
	...
bfc086e0:	2631ffff 	addiu	s1,s1,-1
bfc086e4:	02002021 	move	a0,s0
bfc086e8:	8e630000 	lw	v1,0(s3)
bfc086ec:	0bf021a5 	j	bfc08694 <core_list_mergesort+0x1f4>
bfc086f0:	02601021 	move	v0,s3
	...
bfc08700:	1600ff7b 	bnez	s0,bfc084f0 <core_list_mergesort+0x50>
bfc08704:	02009821 	move	s3,s0
bfc08708:	24030001 	li	v1,1
bfc0870c:	12e30004 	beq	s7,v1,bfc08720 <core_list_mergesort+0x280>
bfc08710:	ae800000 	sw	zero,0(s4)
bfc08714:	16c0ff72 	bnez	s6,bfc084e0 <core_list_mergesort+0x40>
bfc08718:	0015a840 	sll	s5,s5,0x1
bfc0871c:	aec00000 	sw	zero,0(s6)
bfc08720:	8fbf0034 	lw	ra,52(sp)
bfc08724:	02c01021 	move	v0,s6
bfc08728:	8fbe0030 	lw	s8,48(sp)
bfc0872c:	8fb7002c 	lw	s7,44(sp)
bfc08730:	8fb60028 	lw	s6,40(sp)
bfc08734:	8fb50024 	lw	s5,36(sp)
bfc08738:	8fb40020 	lw	s4,32(sp)
bfc0873c:	8fb3001c 	lw	s3,28(sp)
bfc08740:	8fb20018 	lw	s2,24(sp)
bfc08744:	8fb10014 	lw	s1,20(sp)
bfc08748:	8fb00010 	lw	s0,16(sp)
bfc0874c:	03e00008 	jr	ra
bfc08750:	27bd0038 	addiu	sp,sp,56
	...

bfc08760 <calc_func>:
calc_func():
bfc08760:	27bdffd0 	addiu	sp,sp,-48
bfc08764:	afb10020 	sw	s1,32(sp)
bfc08768:	84910000 	lh	s1,0(a0)
bfc0876c:	afb30028 	sw	s3,40(sp)
bfc08770:	32220080 	andi	v0,s1,0x80
bfc08774:	afb20024 	sw	s2,36(sp)
bfc08778:	afbf002c 	sw	ra,44(sp)
bfc0877c:	afb0001c 	sw	s0,28(sp)
bfc08780:	00809821 	move	s3,a0
bfc08784:	14400036 	bnez	v0,bfc08860 <calc_func+0x100>
bfc08788:	00a09021 	move	s2,a1
bfc0878c:	001120c3 	sra	a0,s1,0x3
bfc08790:	3086000f 	andi	a2,a0,0xf
bfc08794:	00061900 	sll	v1,a2,0x4
bfc08798:	32240007 	andi	a0,s1,0x7
bfc0879c:	14800028 	bnez	a0,bfc08840 <calc_func+0xe0>
bfc087a0:	00662825 	or	a1,v1,a2
bfc087a4:	28a80022 	slti	t0,a1,34
bfc087a8:	11000002 	beqz	t0,bfc087b4 <calc_func+0x54>
bfc087ac:	00a01821 	move	v1,a1
bfc087b0:	24030022 	li	v1,34
bfc087b4:	8e450014 	lw	a1,20(s2)
bfc087b8:	8e440018 	lw	a0,24(s2)
bfc087bc:	86460000 	lh	a2,0(s2)
bfc087c0:	86470002 	lh	a3,2(s2)
bfc087c4:	96490038 	lhu	t1,56(s2)
bfc087c8:	afa30010 	sw	v1,16(sp)
bfc087cc:	0ff01e50 	jal	bfc07940 <core_bench_state>
bfc087d0:	afa90014 	sw	t1,20(sp)
bfc087d4:	9645003e 	lhu	a1,62(s2)
bfc087d8:	00028400 	sll	s0,v0,0x10
bfc087dc:	14a00002 	bnez	a1,bfc087e8 <calc_func+0x88>
bfc087e0:	00108403 	sra	s0,s0,0x10
bfc087e4:	a642003e 	sh	v0,62(s2)
bfc087e8:	3210ffff 	andi	s0,s0,0xffff
bfc087ec:	96450038 	lhu	a1,56(s2)
bfc087f0:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc087f4:	02002021 	move	a0,s0
bfc087f8:	240fff00 	li	t7,-256
bfc087fc:	022f7024 	and	t6,s1,t7
bfc08800:	3210007f 	andi	s0,s0,0x7f
bfc08804:	35cd0080 	ori	t5,t6,0x80
bfc08808:	8fbf002c 	lw	ra,44(sp)
bfc0880c:	020d6025 	or	t4,s0,t5
bfc08810:	a6420038 	sh	v0,56(s2)
bfc08814:	8fb10020 	lw	s1,32(sp)
bfc08818:	02001021 	move	v0,s0
bfc0881c:	a66c0000 	sh	t4,0(s3)
bfc08820:	8fb20024 	lw	s2,36(sp)
bfc08824:	8fb30028 	lw	s3,40(sp)
bfc08828:	8fb0001c 	lw	s0,28(sp)
bfc0882c:	03e00008 	jr	ra
bfc08830:	27bd0030 	addiu	sp,sp,48
	...
bfc08840:	24070001 	li	a3,1
bfc08844:	10870012 	beq	a0,a3,bfc08890 <calc_func+0x130>
bfc08848:	02208021 	move	s0,s1
bfc0884c:	0bf021fb 	j	bfc087ec <calc_func+0x8c>
bfc08850:	3210ffff 	andi	s0,s0,0xffff
	...
bfc08860:	8fbf002c 	lw	ra,44(sp)
bfc08864:	3230007f 	andi	s0,s1,0x7f
bfc08868:	02001021 	move	v0,s0
bfc0886c:	8fb30028 	lw	s3,40(sp)
bfc08870:	8fb20024 	lw	s2,36(sp)
bfc08874:	8fb10020 	lw	s1,32(sp)
bfc08878:	8fb0001c 	lw	s0,28(sp)
bfc0887c:	03e00008 	jr	ra
bfc08880:	27bd0030 	addiu	sp,sp,48
	...
bfc08890:	96460038 	lhu	a2,56(s2)
bfc08894:	0ff0101c 	jal	bfc04070 <core_bench_matrix>
bfc08898:	26440028 	addiu	a0,s2,40
bfc0889c:	964a003c 	lhu	t2,60(s2)
bfc088a0:	00025c00 	sll	t3,v0,0x10
bfc088a4:	1540ffd0 	bnez	t2,bfc087e8 <calc_func+0x88>
bfc088a8:	000b8403 	sra	s0,t3,0x10
bfc088ac:	0bf021fa 	j	bfc087e8 <calc_func+0x88>
bfc088b0:	a642003c 	sh	v0,60(s2)
	...

bfc088c0 <core_list_init>:
core_list_init():
bfc088c0:	24090014 	li	t1,20
bfc088c4:	15200002 	bnez	t1,bfc088d0 <core_list_init+0x10>
bfc088c8:	0089001b 	divu	zero,a0,t1
bfc088cc:	0007000d 	break	0x7
bfc088d0:	27bdffc8 	addiu	sp,sp,-56
bfc088d4:	afb10014 	sw	s1,20(sp)
bfc088d8:	24a90010 	addiu	t1,a1,16
bfc088dc:	00063400 	sll	a2,a2,0x10
bfc088e0:	24028080 	li	v0,-32640
bfc088e4:	afb00010 	sw	s0,16(sp)
bfc088e8:	afbf0034 	sw	ra,52(sp)
bfc088ec:	afbe0030 	sw	s8,48(sp)
bfc088f0:	afb7002c 	sw	s7,44(sp)
bfc088f4:	afb60028 	sw	s6,40(sp)
bfc088f8:	afb50024 	sw	s5,36(sp)
bfc088fc:	afb40020 	sw	s4,32(sp)
bfc08900:	afb3001c 	sw	s3,28(sp)
bfc08904:	afb20018 	sw	s2,24(sp)
bfc08908:	00063403 	sra	a2,a2,0x10
bfc0890c:	aca00000 	sw	zero,0(a1)
bfc08910:	24ab0008 	addiu	t3,a1,8
bfc08914:	00004012 	mflo	t0
bfc08918:	2511fffe 	addiu	s1,t0,-2
bfc0891c:	001138c0 	sll	a3,s1,0x3
bfc08920:	00a76821 	addu	t5,a1,a3
bfc08924:	00111880 	sll	v1,s1,0x2
bfc08928:	012d202b 	sltu	a0,t1,t5
bfc0892c:	a5a20000 	sh	v0,0(t5)
bfc08930:	01a38021 	addu	s0,t5,v1
bfc08934:	acad0004 	sw	t5,4(a1)
bfc08938:	a5a00002 	sh	zero,2(t5)
bfc0893c:	10800188 	beqz	a0,bfc08f60 <core_list_init+0x6a0>
bfc08940:	25aa0004 	addiu	t2,t5,4
bfc08944:	25a70008 	addiu	a3,t5,8
bfc08948:	00f0602b 	sltu	t4,a3,s0
bfc0894c:	11800184 	beqz	t4,bfc08f60 <core_list_init+0x6a0>
bfc08950:	240f7fff 	li	t7,32767
bfc08954:	240effff 	li	t6,-1
bfc08958:	ad600000 	sw	zero,0(t3)
bfc0895c:	01604021 	move	t0,t3
bfc08960:	a54f0002 	sh	t7,2(t2)
bfc08964:	a5ae0004 	sh	t6,4(t5)
bfc08968:	ad6a0004 	sw	t2,4(t3)
bfc0896c:	acab0000 	sw	t3,0(a1)
bfc08970:	122000c4 	beqz	s1,bfc08c84 <core_list_init+0x3c4>
bfc08974:	262affff 	addiu	t2,s1,-1
bfc08978:	31440003 	andi	a0,t2,0x3
bfc0897c:	30cfffff 	andi	t7,a2,0xffff
bfc08980:	00006021 	move	t4,zero
bfc08984:	10800077 	beqz	a0,bfc08b64 <core_list_init+0x2a4>
bfc08988:	24127fff 	li	s2,32767
bfc0898c:	252b0008 	addiu	t3,t1,8
bfc08990:	016da02b 	sltu	s4,t3,t5
bfc08994:	1680007a 	bnez	s4,bfc08b80 <core_list_init+0x2c0>
bfc08998:	24ea0004 	addiu	t2,a3,4
bfc0899c:	01205821 	move	t3,t1
bfc089a0:	00e05021 	move	t2,a3
bfc089a4:	240c0001 	li	t4,1
bfc089a8:	01604821 	move	t1,t3
bfc089ac:	108c006d 	beq	a0,t4,bfc08b64 <core_list_init+0x2a4>
bfc089b0:	01403821 	move	a3,t2
bfc089b4:	241e0002 	li	s8,2
bfc089b8:	109e000a 	beq	a0,s8,bfc089e4 <core_list_init+0x124>
bfc089bc:	00000000 	nop
bfc089c0:	25670008 	addiu	a3,t3,8
bfc089c4:	00edf82b 	sltu	ra,a3,t5
bfc089c8:	17e0007d 	bnez	ra,bfc08bc0 <core_list_init+0x300>
bfc089cc:	254e0004 	addiu	t6,t2,4
bfc089d0:	01603821 	move	a3,t3
bfc089d4:	01407021 	move	t6,t2
bfc089d8:	00e04821 	move	t1,a3
bfc089dc:	258c0001 	addiu	t4,t4,1
bfc089e0:	01c03821 	move	a3,t6
bfc089e4:	252a0008 	addiu	t2,t1,8
bfc089e8:	014d582b 	sltu	t3,t2,t5
bfc089ec:	15600088 	bnez	t3,bfc08c10 <core_list_init+0x350>
bfc089f0:	24eb0004 	addiu	t3,a3,4
bfc089f4:	01205021 	move	t2,t1
bfc089f8:	00e05821 	move	t3,a3
bfc089fc:	258c0001 	addiu	t4,t4,1
bfc08a00:	01404821 	move	t1,t2
bfc08a04:	0bf022d9 	j	bfc08b64 <core_list_init+0x2a4>
bfc08a08:	01603821 	move	a3,t3
bfc08a0c:	24ea0004 	addiu	t2,a3,4
bfc08a10:	0150a02b 	sltu	s4,t2,s0
bfc08a14:	12800057 	beqz	s4,bfc08b74 <core_list_init+0x2b4>
bfc08a18:	319effff 	andi	s8,t4,0xffff
bfc08a1c:	03cf2026 	xor	a0,s8,t7
bfc08a20:	309f000f 	andi	ra,a0,0xf
bfc08a24:	001fc0c0 	sll	t8,ra,0x3
bfc08a28:	33d90007 	andi	t9,s8,0x7
bfc08a2c:	0319b825 	or	s7,t8,t9
bfc08a30:	0017b200 	sll	s6,s7,0x8
bfc08a34:	02d7a825 	or	s5,s6,s7
bfc08a38:	ad280000 	sw	t0,0(t1)
bfc08a3c:	a4f50000 	sh	s5,0(a3)
bfc08a40:	01204021 	move	t0,t1
bfc08a44:	a4f20002 	sh	s2,2(a3)
bfc08a48:	aca90000 	sw	t1,0(a1)
bfc08a4c:	ad270004 	sw	a3,4(t1)
bfc08a50:	258e0001 	addiu	t6,t4,1
bfc08a54:	01d1182b 	sltu	v1,t6,s1
bfc08a58:	1060008a 	beqz	v1,bfc08c84 <core_list_init+0x3c4>
bfc08a5c:	256c0008 	addiu	t4,t3,8
bfc08a60:	018d102b 	sltu	v0,t4,t5
bfc08a64:	10400084 	beqz	v0,bfc08c78 <core_list_init+0x3b8>
bfc08a68:	00000000 	nop
bfc08a6c:	25470004 	addiu	a3,t2,4
bfc08a70:	00f0482b 	sltu	t1,a3,s0
bfc08a74:	11200080 	beqz	t1,bfc08c78 <core_list_init+0x3b8>
bfc08a78:	31d9ffff 	andi	t9,t6,0xffff
bfc08a7c:	032ff826 	xor	ra,t9,t7
bfc08a80:	33fe000f 	andi	s8,ra,0xf
bfc08a84:	001eb8c0 	sll	s7,s8,0x3
bfc08a88:	33380007 	andi	t8,t9,0x7
bfc08a8c:	02f8b025 	or	s6,s7,t8
bfc08a90:	0016aa00 	sll	s5,s6,0x8
bfc08a94:	02b6a025 	or	s4,s5,s6
bfc08a98:	ad680000 	sw	t0,0(t3)
bfc08a9c:	a5540000 	sh	s4,0(t2)
bfc08aa0:	01604021 	move	t0,t3
bfc08aa4:	a5520002 	sh	s2,2(t2)
bfc08aa8:	acab0000 	sw	t3,0(a1)
bfc08aac:	ad6a0004 	sw	t2,4(t3)
bfc08ab0:	258a0008 	addiu	t2,t4,8
bfc08ab4:	014d582b 	sltu	t3,t2,t5
bfc08ab8:	1160006c 	beqz	t3,bfc08c6c <core_list_init+0x3ac>
bfc08abc:	25c30001 	addiu	v1,t6,1
bfc08ac0:	24e90004 	addiu	t1,a3,4
bfc08ac4:	0130202b 	sltu	a0,t1,s0
bfc08ac8:	10800068 	beqz	a0,bfc08c6c <core_list_init+0x3ac>
bfc08acc:	3076ffff 	andi	s6,v1,0xffff
bfc08ad0:	02cfc026 	xor	t8,s6,t7
bfc08ad4:	3317000f 	andi	s7,t8,0xf
bfc08ad8:	0017a0c0 	sll	s4,s7,0x3
bfc08adc:	32d50007 	andi	s5,s6,0x7
bfc08ae0:	02951825 	or	v1,s4,s5
bfc08ae4:	00039a00 	sll	s3,v1,0x8
bfc08ae8:	02631025 	or	v0,s3,v1
bfc08aec:	ad880000 	sw	t0,0(t4)
bfc08af0:	a4e20000 	sh	v0,0(a3)
bfc08af4:	01804021 	move	t0,t4
bfc08af8:	a4f20002 	sh	s2,2(a3)
bfc08afc:	acac0000 	sw	t4,0(a1)
bfc08b00:	ad870004 	sw	a3,4(t4)
bfc08b04:	25470008 	addiu	a3,t2,8
bfc08b08:	00ed602b 	sltu	t4,a3,t5
bfc08b0c:	11800054 	beqz	t4,bfc08c60 <core_list_init+0x3a0>
bfc08b10:	25c30002 	addiu	v1,t6,2
bfc08b14:	252b0004 	addiu	t3,t1,4
bfc08b18:	0170c82b 	sltu	t9,t3,s0
bfc08b1c:	13200050 	beqz	t9,bfc08c60 <core_list_init+0x3a0>
bfc08b20:	3074ffff 	andi	s4,v1,0xffff
bfc08b24:	028fa826 	xor	s5,s4,t7
bfc08b28:	32a3000f 	andi	v1,s5,0xf
bfc08b2c:	000398c0 	sll	s3,v1,0x3
bfc08b30:	32820007 	andi	v0,s4,0x7
bfc08b34:	02622025 	or	a0,s3,v0
bfc08b38:	0004fa00 	sll	ra,a0,0x8
bfc08b3c:	03e4f025 	or	s8,ra,a0
bfc08b40:	ad480000 	sw	t0,0(t2)
bfc08b44:	a53e0000 	sh	s8,0(t1)
bfc08b48:	01404021 	move	t0,t2
bfc08b4c:	a5320002 	sh	s2,2(t1)
bfc08b50:	acaa0000 	sw	t2,0(a1)
bfc08b54:	ad490004 	sw	t1,4(t2)
bfc08b58:	00e04821 	move	t1,a3
bfc08b5c:	25cc0003 	addiu	t4,t6,3
bfc08b60:	01603821 	move	a3,t3
bfc08b64:	252b0008 	addiu	t3,t1,8
bfc08b68:	016d982b 	sltu	s3,t3,t5
bfc08b6c:	1660ffa7 	bnez	s3,bfc08a0c <core_list_init+0x14c>
bfc08b70:	00000000 	nop
bfc08b74:	01205821 	move	t3,t1
bfc08b78:	0bf02294 	j	bfc08a50 <core_list_init+0x190>
bfc08b7c:	00e05021 	move	t2,a3
bfc08b80:	0150a82b 	sltu	s5,t2,s0
bfc08b84:	12a0ff85 	beqz	s5,bfc0899c <core_list_init+0xdc>
bfc08b88:	31f9000f 	andi	t9,t7,0xf
bfc08b8c:	0019c0c0 	sll	t8,t9,0x3
bfc08b90:	0018ba00 	sll	s7,t8,0x8
bfc08b94:	02f8b025 	or	s6,s7,t8
bfc08b98:	ad280000 	sw	t0,0(t1)
bfc08b9c:	a4f60000 	sh	s6,0(a3)
bfc08ba0:	01204021 	move	t0,t1
bfc08ba4:	a4f20002 	sh	s2,2(a3)
bfc08ba8:	aca90000 	sw	t1,0(a1)
bfc08bac:	0bf02269 	j	bfc089a4 <core_list_init+0xe4>
bfc08bb0:	ad270004 	sw	a3,4(t1)
	...
bfc08bc0:	01d0202b 	sltu	a0,t6,s0
bfc08bc4:	1080ff82 	beqz	a0,bfc089d0 <core_list_init+0x110>
bfc08bc8:	3195ffff 	andi	s5,t4,0xffff
bfc08bcc:	02afb826 	xor	s7,s5,t7
bfc08bd0:	32f6000f 	andi	s6,s7,0xf
bfc08bd4:	001698c0 	sll	s3,s6,0x3
bfc08bd8:	32b40007 	andi	s4,s5,0x7
bfc08bdc:	02741825 	or	v1,s3,s4
bfc08be0:	00034a00 	sll	t1,v1,0x8
bfc08be4:	01231025 	or	v0,t1,v1
bfc08be8:	ad680000 	sw	t0,0(t3)
bfc08bec:	a5420000 	sh	v0,0(t2)
bfc08bf0:	01604021 	move	t0,t3
bfc08bf4:	a5520002 	sh	s2,2(t2)
bfc08bf8:	acab0000 	sw	t3,0(a1)
bfc08bfc:	0bf02276 	j	bfc089d8 <core_list_init+0x118>
bfc08c00:	ad6a0004 	sw	t2,4(t3)
	...
bfc08c10:	0170702b 	sltu	t6,t3,s0
bfc08c14:	11c0ff77 	beqz	t6,bfc089f4 <core_list_init+0x134>
bfc08c18:	3182ffff 	andi	v0,t4,0xffff
bfc08c1c:	004f9826 	xor	s3,v0,t7
bfc08c20:	3263000f 	andi	v1,s3,0xf
bfc08c24:	0003f8c0 	sll	ra,v1,0x3
bfc08c28:	30440007 	andi	a0,v0,0x7
bfc08c2c:	03e4f025 	or	s8,ra,a0
bfc08c30:	001eca00 	sll	t9,s8,0x8
bfc08c34:	033ec025 	or	t8,t9,s8
bfc08c38:	ad280000 	sw	t0,0(t1)
bfc08c3c:	a4f80000 	sh	t8,0(a3)
bfc08c40:	01204021 	move	t0,t1
bfc08c44:	a4f20002 	sh	s2,2(a3)
bfc08c48:	aca90000 	sw	t1,0(a1)
bfc08c4c:	0bf0227f 	j	bfc089fc <core_list_init+0x13c>
bfc08c50:	ad270004 	sw	a3,4(t1)
	...
bfc08c60:	01403821 	move	a3,t2
bfc08c64:	0bf022d6 	j	bfc08b58 <core_list_init+0x298>
bfc08c68:	01205821 	move	t3,t1
bfc08c6c:	01805021 	move	t2,t4
bfc08c70:	0bf022c1 	j	bfc08b04 <core_list_init+0x244>
bfc08c74:	00e04821 	move	t1,a3
bfc08c78:	01606021 	move	t4,t3
bfc08c7c:	0bf022ac 	j	bfc08ab0 <core_list_init+0x1f0>
bfc08c80:	01403821 	move	a3,t2
bfc08c84:	240b0005 	li	t3,5
bfc08c88:	15600002 	bnez	t3,bfc08c94 <core_list_init+0x3d4>
bfc08c8c:	022b001b 	divu	zero,s1,t3
bfc08c90:	0007000d 	break	0x7
bfc08c94:	24090002 	li	t1,2
bfc08c98:	00002012 	mflo	a0
bfc08c9c:	0bf0232f 	j	bfc08cbc <core_list_init+0x3fc>
bfc08ca0:	24070001 	li	a3,1
bfc08ca4:	8d0d0004 	lw	t5,4(t0)
bfc08ca8:	00000000 	nop
bfc08cac:	a5a70002 	sh	a3,2(t5)
bfc08cb0:	25290001 	addiu	t1,t1,1
bfc08cb4:	24e70001 	addiu	a3,a3,1
bfc08cb8:	00604021 	move	t0,v1
bfc08cbc:	312e0007 	andi	t6,t1,0x7
bfc08cc0:	000e9200 	sll	s2,t6,0x8
bfc08cc4:	00c76026 	xor	t4,a2,a3
bfc08cc8:	8d030000 	lw	v1,0(t0)
bfc08ccc:	024c8825 	or	s1,s2,t4
bfc08cd0:	322a3fff 	andi	t2,s1,0x3fff
bfc08cd4:	10600006 	beqz	v1,bfc08cf0 <core_list_init+0x430>
bfc08cd8:	00e4102b 	sltu	v0,a3,a0
bfc08cdc:	1440fff1 	bnez	v0,bfc08ca4 <core_list_init+0x3e4>
bfc08ce0:	00000000 	nop
bfc08ce4:	8d100004 	lw	s0,4(t0)
bfc08ce8:	0bf0232c 	j	bfc08cb0 <core_list_init+0x3f0>
bfc08cec:	a60a0002 	sh	t2,2(s0)
bfc08cf0:	24150001 	li	s5,1
bfc08cf4:	10a0008b 	beqz	a1,bfc08f24 <core_list_init+0x664>
bfc08cf8:	241e0001 	li	s8,1
bfc08cfc:	00a08821 	move	s1,a1
bfc08d00:	0000b821 	move	s7,zero
bfc08d04:	0000a021 	move	s4,zero
bfc08d08:	0000b021 	move	s6,zero
bfc08d0c:	8e300000 	lw	s0,0(s1)
bfc08d10:	26a5ffff 	addiu	a1,s5,-1
bfc08d14:	26f70001 	addiu	s7,s7,1
bfc08d18:	30a30007 	andi	v1,a1,0x7
bfc08d1c:	12000053 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08d20:	24120001 	li	s2,1
bfc08d24:	0255382a 	slt	a3,s2,s5
bfc08d28:	10e00050 	beqz	a3,bfc08e6c <core_list_init+0x5ac>
bfc08d2c:	00000000 	nop
bfc08d30:	1060002c 	beqz	v1,bfc08de4 <core_list_init+0x524>
bfc08d34:	00000000 	nop
bfc08d38:	10720023 	beq	v1,s2,bfc08dc8 <core_list_init+0x508>
bfc08d3c:	24080002 	li	t0,2
bfc08d40:	1068001d 	beq	v1,t0,bfc08db8 <core_list_init+0x4f8>
bfc08d44:	24060003 	li	a2,3
bfc08d48:	10660017 	beq	v1,a2,bfc08da8 <core_list_init+0x4e8>
bfc08d4c:	24090004 	li	t1,4
bfc08d50:	10690011 	beq	v1,t1,bfc08d98 <core_list_init+0x4d8>
bfc08d54:	240f0005 	li	t7,5
bfc08d58:	106f000b 	beq	v1,t7,bfc08d88 <core_list_init+0x4c8>
bfc08d5c:	240a0006 	li	t2,6
bfc08d60:	106a0005 	beq	v1,t2,bfc08d78 <core_list_init+0x4b8>
bfc08d64:	00000000 	nop
bfc08d68:	8e100000 	lw	s0,0(s0)
bfc08d6c:	00000000 	nop
bfc08d70:	1200003e 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08d74:	24120002 	li	s2,2
bfc08d78:	8e100000 	lw	s0,0(s0)
bfc08d7c:	00000000 	nop
bfc08d80:	1200003a 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08d84:	26520001 	addiu	s2,s2,1
bfc08d88:	8e100000 	lw	s0,0(s0)
bfc08d8c:	00000000 	nop
bfc08d90:	12000036 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08d94:	26520001 	addiu	s2,s2,1
bfc08d98:	8e100000 	lw	s0,0(s0)
bfc08d9c:	00000000 	nop
bfc08da0:	12000032 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08da4:	26520001 	addiu	s2,s2,1
bfc08da8:	8e100000 	lw	s0,0(s0)
bfc08dac:	00000000 	nop
bfc08db0:	1200002e 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08db4:	26520001 	addiu	s2,s2,1
bfc08db8:	8e100000 	lw	s0,0(s0)
bfc08dbc:	00000000 	nop
bfc08dc0:	1200002a 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08dc4:	26520001 	addiu	s2,s2,1
bfc08dc8:	8e100000 	lw	s0,0(s0)
bfc08dcc:	00000000 	nop
bfc08dd0:	12000026 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08dd4:	26520001 	addiu	s2,s2,1
bfc08dd8:	0255982a 	slt	s3,s2,s5
bfc08ddc:	12600023 	beqz	s3,bfc08e6c <core_list_init+0x5ac>
bfc08de0:	00000000 	nop
bfc08de4:	8e100000 	lw	s0,0(s0)
bfc08de8:	26520001 	addiu	s2,s2,1
bfc08dec:	1200001f 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08df0:	02401021 	move	v0,s2
bfc08df4:	8e100000 	lw	s0,0(s0)
bfc08df8:	00000000 	nop
bfc08dfc:	1200001b 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08e00:	26520001 	addiu	s2,s2,1
bfc08e04:	8e100000 	lw	s0,0(s0)
bfc08e08:	00000000 	nop
bfc08e0c:	12000017 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08e10:	24520002 	addiu	s2,v0,2
bfc08e14:	8e100000 	lw	s0,0(s0)
bfc08e18:	00000000 	nop
bfc08e1c:	12000013 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08e20:	24520003 	addiu	s2,v0,3
bfc08e24:	8e100000 	lw	s0,0(s0)
bfc08e28:	00000000 	nop
bfc08e2c:	1200000f 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08e30:	24520004 	addiu	s2,v0,4
bfc08e34:	8e100000 	lw	s0,0(s0)
bfc08e38:	00000000 	nop
bfc08e3c:	1200000b 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08e40:	24520005 	addiu	s2,v0,5
bfc08e44:	8e100000 	lw	s0,0(s0)
bfc08e48:	00000000 	nop
bfc08e4c:	12000007 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08e50:	24520006 	addiu	s2,v0,6
bfc08e54:	8e100000 	lw	s0,0(s0)
bfc08e58:	24520007 	addiu	s2,v0,7
bfc08e5c:	12000003 	beqz	s0,bfc08e6c <core_list_init+0x5ac>
bfc08e60:	0255102a 	slt	v0,s2,s5
bfc08e64:	1440ffdf 	bnez	v0,bfc08de4 <core_list_init+0x524>
bfc08e68:	00000000 	nop
bfc08e6c:	12400016 	beqz	s2,bfc08ec8 <core_list_init+0x608>
bfc08e70:	02a09821 	move	s3,s5
bfc08e74:	1260001e 	beqz	s3,bfc08ef0 <core_list_init+0x630>
bfc08e78:	00000000 	nop
bfc08e7c:	1200001c 	beqz	s0,bfc08ef0 <core_list_init+0x630>
bfc08e80:	00000000 	nop
bfc08e84:	8e240004 	lw	a0,4(s1)
bfc08e88:	8e050004 	lw	a1,4(s0)
bfc08e8c:	0ff02074 	jal	bfc081d0 <cmp_idx>
bfc08e90:	00003021 	move	a2,zero
bfc08e94:	18400016 	blez	v0,bfc08ef0 <core_list_init+0x630>
bfc08e98:	00000000 	nop
bfc08e9c:	8e020000 	lw	v0,0(s0)
bfc08ea0:	02201821 	move	v1,s1
bfc08ea4:	2673ffff 	addiu	s3,s3,-1
bfc08ea8:	02008821 	move	s1,s0
bfc08eac:	1280000e 	beqz	s4,bfc08ee8 <core_list_init+0x628>
bfc08eb0:	00000000 	nop
bfc08eb4:	ae910000 	sw	s1,0(s4)
bfc08eb8:	0220a021 	move	s4,s1
bfc08ebc:	00408021 	move	s0,v0
bfc08ec0:	1640ffec 	bnez	s2,bfc08e74 <core_list_init+0x5b4>
bfc08ec4:	00608821 	move	s1,v1
bfc08ec8:	1260000d 	beqz	s3,bfc08f00 <core_list_init+0x640>
bfc08ecc:	00000000 	nop
bfc08ed0:	1200000f 	beqz	s0,bfc08f10 <core_list_init+0x650>
bfc08ed4:	02201821 	move	v1,s1
bfc08ed8:	2673ffff 	addiu	s3,s3,-1
bfc08edc:	8e020000 	lw	v0,0(s0)
bfc08ee0:	1680fff4 	bnez	s4,bfc08eb4 <core_list_init+0x5f4>
bfc08ee4:	02008821 	move	s1,s0
bfc08ee8:	0bf023ae 	j	bfc08eb8 <core_list_init+0x5f8>
bfc08eec:	0220b021 	move	s6,s1
bfc08ef0:	2652ffff 	addiu	s2,s2,-1
bfc08ef4:	8e230000 	lw	v1,0(s1)
bfc08ef8:	0bf023ab 	j	bfc08eac <core_list_init+0x5ec>
bfc08efc:	02001021 	move	v0,s0
bfc08f00:	1600ff82 	bnez	s0,bfc08d0c <core_list_init+0x44c>
bfc08f04:	02008821 	move	s1,s0
	...
bfc08f10:	12fe0006 	beq	s7,s8,bfc08f2c <core_list_init+0x66c>
bfc08f14:	ae800000 	sw	zero,0(s4)
bfc08f18:	02c02821 	move	a1,s6
bfc08f1c:	14a0ff77 	bnez	a1,bfc08cfc <core_list_init+0x43c>
bfc08f20:	0015a840 	sll	s5,s5,0x1
bfc08f24:	aca00000 	sw	zero,0(a1)
bfc08f28:	0000b021 	move	s6,zero
bfc08f2c:	8fbf0034 	lw	ra,52(sp)
bfc08f30:	02c01021 	move	v0,s6
bfc08f34:	8fbe0030 	lw	s8,48(sp)
bfc08f38:	8fb7002c 	lw	s7,44(sp)
bfc08f3c:	8fb60028 	lw	s6,40(sp)
bfc08f40:	8fb50024 	lw	s5,36(sp)
bfc08f44:	8fb40020 	lw	s4,32(sp)
bfc08f48:	8fb3001c 	lw	s3,28(sp)
bfc08f4c:	8fb20018 	lw	s2,24(sp)
bfc08f50:	8fb10014 	lw	s1,20(sp)
bfc08f54:	8fb00010 	lw	s0,16(sp)
bfc08f58:	03e00008 	jr	ra
bfc08f5c:	27bd0038 	addiu	sp,sp,56
bfc08f60:	8ca80000 	lw	t0,0(a1)
bfc08f64:	01604821 	move	t1,t3
bfc08f68:	0bf0225c 	j	bfc08970 <core_list_init+0xb0>
bfc08f6c:	01403821 	move	a3,t2

bfc08f70 <cmp_complex>:
cmp_complex():
bfc08f70:	27bdffc8 	addiu	sp,sp,-56
bfc08f74:	afb10020 	sw	s1,32(sp)
bfc08f78:	84910000 	lh	s1,0(a0)
bfc08f7c:	afb50030 	sw	s5,48(sp)
bfc08f80:	32220080 	andi	v0,s1,0x80
bfc08f84:	afb4002c 	sw	s4,44(sp)
bfc08f88:	afb20024 	sw	s2,36(sp)
bfc08f8c:	afbf0034 	sw	ra,52(sp)
bfc08f90:	afb30028 	sw	s3,40(sp)
bfc08f94:	afb0001c 	sw	s0,28(sp)
bfc08f98:	0080a021 	move	s4,a0
bfc08f9c:	00a0a821 	move	s5,a1
bfc08fa0:	1440003b 	bnez	v0,bfc09090 <cmp_complex+0x120>
bfc08fa4:	00c09021 	move	s2,a2
bfc08fa8:	001120c3 	sra	a0,s1,0x3
bfc08fac:	3086000f 	andi	a2,a0,0xf
bfc08fb0:	00061900 	sll	v1,a2,0x4
bfc08fb4:	32240007 	andi	a0,s1,0x7
bfc08fb8:	1480002d 	bnez	a0,bfc09070 <cmp_complex+0x100>
bfc08fbc:	00662825 	or	a1,v1,a2
bfc08fc0:	28a80022 	slti	t0,a1,34
bfc08fc4:	11000002 	beqz	t0,bfc08fd0 <cmp_complex+0x60>
bfc08fc8:	00a01821 	move	v1,a1
bfc08fcc:	24030022 	li	v1,34
bfc08fd0:	8e450014 	lw	a1,20(s2)
bfc08fd4:	8e440018 	lw	a0,24(s2)
bfc08fd8:	86460000 	lh	a2,0(s2)
bfc08fdc:	86470002 	lh	a3,2(s2)
bfc08fe0:	96490038 	lhu	t1,56(s2)
bfc08fe4:	afa30010 	sw	v1,16(sp)
bfc08fe8:	0ff01e50 	jal	bfc07940 <core_bench_state>
bfc08fec:	afa90014 	sw	t1,20(sp)
bfc08ff0:	9645003e 	lhu	a1,62(s2)
bfc08ff4:	00028400 	sll	s0,v0,0x10
bfc08ff8:	14a00002 	bnez	a1,bfc09004 <cmp_complex+0x94>
bfc08ffc:	00108403 	sra	s0,s0,0x10
bfc09000:	a642003e 	sh	v0,62(s2)
bfc09004:	3210ffff 	andi	s0,s0,0xffff
bfc09008:	96450038 	lhu	a1,56(s2)
bfc0900c:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc09010:	02002021 	move	a0,s0
bfc09014:	240fff00 	li	t7,-256
bfc09018:	022f7024 	and	t6,s1,t7
bfc0901c:	3213007f 	andi	s3,s0,0x7f
bfc09020:	35cd0080 	ori	t5,t6,0x80
bfc09024:	026d6025 	or	t4,s3,t5
bfc09028:	a6420038 	sh	v0,56(s2)
bfc0902c:	a68c0000 	sh	t4,0(s4)
bfc09030:	86b10000 	lh	s1,0(s5)
bfc09034:	00000000 	nop
bfc09038:	32340080 	andi	s4,s1,0x80
bfc0903c:	1280001a 	beqz	s4,bfc090a8 <cmp_complex+0x138>
bfc09040:	0011f8c3 	sra	ra,s1,0x3
bfc09044:	3230007f 	andi	s0,s1,0x7f
bfc09048:	8fbf0034 	lw	ra,52(sp)
bfc0904c:	02701023 	subu	v0,s3,s0
bfc09050:	8fb50030 	lw	s5,48(sp)
bfc09054:	8fb4002c 	lw	s4,44(sp)
bfc09058:	8fb30028 	lw	s3,40(sp)
bfc0905c:	8fb20024 	lw	s2,36(sp)
bfc09060:	8fb10020 	lw	s1,32(sp)
bfc09064:	8fb0001c 	lw	s0,28(sp)
bfc09068:	03e00008 	jr	ra
bfc0906c:	27bd0038 	addiu	sp,sp,56
bfc09070:	24070001 	li	a3,1
bfc09074:	10870042 	beq	a0,a3,bfc09180 <cmp_complex+0x210>
bfc09078:	02208021 	move	s0,s1
bfc0907c:	0bf02402 	j	bfc09008 <cmp_complex+0x98>
bfc09080:	3210ffff 	andi	s0,s0,0xffff
	...
bfc09090:	3233007f 	andi	s3,s1,0x7f
bfc09094:	86b10000 	lh	s1,0(s5)
bfc09098:	00000000 	nop
bfc0909c:	32340080 	andi	s4,s1,0x80
bfc090a0:	1680ffe8 	bnez	s4,bfc09044 <cmp_complex+0xd4>
bfc090a4:	0011f8c3 	sra	ra,s1,0x3
bfc090a8:	33f8000f 	andi	t8,ra,0xf
bfc090ac:	0018c900 	sll	t9,t8,0x4
bfc090b0:	32240007 	andi	a0,s1,0x7
bfc090b4:	14800016 	bnez	a0,bfc09110 <cmp_complex+0x1a0>
bfc090b8:	03382825 	or	a1,t9,t8
bfc090bc:	28a60022 	slti	a2,a1,34
bfc090c0:	14c00002 	bnez	a2,bfc090cc <cmp_complex+0x15c>
bfc090c4:	24030022 	li	v1,34
bfc090c8:	00a01821 	move	v1,a1
bfc090cc:	8e440018 	lw	a0,24(s2)
bfc090d0:	86470002 	lh	a3,2(s2)
bfc090d4:	8e450014 	lw	a1,20(s2)
bfc090d8:	86460000 	lh	a2,0(s2)
bfc090dc:	96480038 	lhu	t0,56(s2)
bfc090e0:	afa30010 	sw	v1,16(sp)
bfc090e4:	0ff01e50 	jal	bfc07940 <core_bench_state>
bfc090e8:	afa80014 	sw	t0,20(sp)
bfc090ec:	9644003e 	lhu	a0,62(s2)
bfc090f0:	00023c00 	sll	a3,v0,0x10
bfc090f4:	14800009 	bnez	a0,bfc0911c <cmp_complex+0x1ac>
bfc090f8:	00078403 	sra	s0,a3,0x10
bfc090fc:	0bf02447 	j	bfc0911c <cmp_complex+0x1ac>
bfc09100:	a642003e 	sh	v0,62(s2)
	...
bfc09110:	24020001 	li	v0,1
bfc09114:	1082000e 	beq	a0,v0,bfc09150 <cmp_complex+0x1e0>
bfc09118:	02208021 	move	s0,s1
bfc0911c:	3210ffff 	andi	s0,s0,0xffff
bfc09120:	96450038 	lhu	a1,56(s2)
bfc09124:	0ff016e4 	jal	bfc05b90 <crcu16>
bfc09128:	02002021 	move	a0,s0
bfc0912c:	240bff00 	li	t3,-256
bfc09130:	022b5024 	and	t2,s1,t3
bfc09134:	3210007f 	andi	s0,s0,0x7f
bfc09138:	35430080 	ori	v1,t2,0x80
bfc0913c:	02038825 	or	s1,s0,v1
bfc09140:	a6420038 	sh	v0,56(s2)
bfc09144:	0bf02412 	j	bfc09048 <cmp_complex+0xd8>
bfc09148:	a6b10000 	sh	s1,0(s5)
bfc0914c:	00000000 	nop
bfc09150:	96460038 	lhu	a2,56(s2)
bfc09154:	0ff0101c 	jal	bfc04070 <core_bench_matrix>
bfc09158:	26440028 	addiu	a0,s2,40
bfc0915c:	9645003c 	lhu	a1,60(s2)
bfc09160:	00024c00 	sll	t1,v0,0x10
bfc09164:	14a0ffed 	bnez	a1,bfc0911c <cmp_complex+0x1ac>
bfc09168:	00098403 	sra	s0,t1,0x10
bfc0916c:	0bf02447 	j	bfc0911c <cmp_complex+0x1ac>
bfc09170:	a642003c 	sh	v0,60(s2)
	...
bfc09180:	96460038 	lhu	a2,56(s2)
bfc09184:	0ff0101c 	jal	bfc04070 <core_bench_matrix>
bfc09188:	26440028 	addiu	a0,s2,40
bfc0918c:	964a003c 	lhu	t2,60(s2)
bfc09190:	00025c00 	sll	t3,v0,0x10
bfc09194:	1540ff9b 	bnez	t2,bfc09004 <cmp_complex+0x94>
bfc09198:	000b8403 	sra	s0,t3,0x10
bfc0919c:	0bf02401 	j	bfc09004 <cmp_complex+0x94>
bfc091a0:	a642003c 	sh	v0,60(s2)
	...

bfc091b0 <core_bench_list>:
core_bench_list():
bfc091b0:	848a0004 	lh	t2,4(a0)
bfc091b4:	27bdffc0 	addiu	sp,sp,-64
bfc091b8:	00052c00 	sll	a1,a1,0x10
bfc091bc:	afb5002c 	sw	s5,44(sp)
bfc091c0:	afbf003c 	sw	ra,60(sp)
bfc091c4:	afbe0038 	sw	s8,56(sp)
bfc091c8:	afb70034 	sw	s7,52(sp)
bfc091cc:	afb60030 	sw	s6,48(sp)
bfc091d0:	afb40028 	sw	s4,40(sp)
bfc091d4:	afb30024 	sw	s3,36(sp)
bfc091d8:	afb20020 	sw	s2,32(sp)
bfc091dc:	afb1001c 	sw	s1,28(sp)
bfc091e0:	afb00018 	sw	s0,24(sp)
bfc091e4:	afa40040 	sw	a0,64(sp)
bfc091e8:	8c950024 	lw	s5,36(a0)
bfc091ec:	1940028f 	blez	t2,bfc09c2c <core_bench_list+0xa7c>
bfc091f0:	00052c03 	sra	a1,a1,0x10
bfc091f4:	afa50010 	sw	a1,16(sp)
bfc091f8:	00004821 	move	t1,zero
bfc091fc:	00004021 	move	t0,zero
bfc09200:	00005821 	move	t3,zero
bfc09204:	00003821 	move	a3,zero
bfc09208:	8fa30010 	lw	v1,16(sp)
bfc0920c:	30e200ff 	andi	v0,a3,0xff
bfc09210:	04600160 	bltz	v1,bfc09794 <core_bench_list+0x5e4>
bfc09214:	afa20014 	sw	v0,20(sp)
bfc09218:	12a00174 	beqz	s5,bfc097ec <core_bench_list+0x63c>
bfc0921c:	00000000 	nop
bfc09220:	8eaf0004 	lw	t7,4(s5)
bfc09224:	8fad0010 	lw	t5,16(sp)
bfc09228:	85ee0002 	lh	t6,2(t7)
bfc0922c:	00000000 	nop
bfc09230:	11cd000d 	beq	t6,t5,bfc09268 <core_bench_list+0xb8>
bfc09234:	02a03021 	move	a2,s5
bfc09238:	0bf02496 	j	bfc09258 <core_bench_list+0xa8>
bfc0923c:	02a02021 	move	a0,s5
bfc09240:	8c920004 	lw	s2,4(a0)
bfc09244:	8fb00010 	lw	s0,16(sp)
bfc09248:	86510002 	lh	s1,2(s2)
bfc0924c:	00000000 	nop
bfc09250:	12300005 	beq	s1,s0,bfc09268 <core_bench_list+0xb8>
bfc09254:	00803021 	move	a2,a0
bfc09258:	8c840000 	lw	a0,0(a0)
bfc0925c:	00000000 	nop
bfc09260:	1480fff7 	bnez	a0,bfc09240 <core_bench_list+0x90>
bfc09264:	00003021 	move	a2,zero
bfc09268:	8ea20000 	lw	v0,0(s5)
bfc0926c:	00001821 	move	v1,zero
bfc09270:	10400023 	beqz	v0,bfc09300 <core_bench_list+0x150>
bfc09274:	aea30000 	sw	v1,0(s5)
bfc09278:	8c430000 	lw	v1,0(v0)
bfc0927c:	ac550000 	sw	s5,0(v0)
bfc09280:	1060001f 	beqz	v1,bfc09300 <core_bench_list+0x150>
bfc09284:	0040a821 	move	s5,v0
bfc09288:	8c640000 	lw	a0,0(v1)
bfc0928c:	0060a821 	move	s5,v1
bfc09290:	1080001b 	beqz	a0,bfc09300 <core_bench_list+0x150>
bfc09294:	ac620000 	sw	v0,0(v1)
bfc09298:	8c820000 	lw	v0,0(a0)
bfc0929c:	0080a821 	move	s5,a0
bfc092a0:	10400017 	beqz	v0,bfc09300 <core_bench_list+0x150>
bfc092a4:	ac830000 	sw	v1,0(a0)
bfc092a8:	8c430000 	lw	v1,0(v0)
bfc092ac:	0040a821 	move	s5,v0
bfc092b0:	10600013 	beqz	v1,bfc09300 <core_bench_list+0x150>
bfc092b4:	ac440000 	sw	a0,0(v0)
bfc092b8:	8c640000 	lw	a0,0(v1)
bfc092bc:	0060a821 	move	s5,v1
bfc092c0:	1080000f 	beqz	a0,bfc09300 <core_bench_list+0x150>
bfc092c4:	ac620000 	sw	v0,0(v1)
bfc092c8:	8c820000 	lw	v0,0(a0)
bfc092cc:	0080a821 	move	s5,a0
bfc092d0:	1040000b 	beqz	v0,bfc09300 <core_bench_list+0x150>
bfc092d4:	ac830000 	sw	v1,0(a0)
bfc092d8:	0040a821 	move	s5,v0
bfc092dc:	8c420000 	lw	v0,0(v0)
bfc092e0:	02a01821 	move	v1,s5
bfc092e4:	10400006 	beqz	v0,bfc09300 <core_bench_list+0x150>
bfc092e8:	aea40000 	sw	a0,0(s5)
bfc092ec:	0040a821 	move	s5,v0
bfc092f0:	8ea20000 	lw	v0,0(s5)
bfc092f4:	00000000 	nop
bfc092f8:	1440ffdf 	bnez	v0,bfc09278 <core_bench_list+0xc8>
bfc092fc:	aea30000 	sw	v1,0(s5)
bfc09300:	10c0013c 	beqz	a2,bfc097f4 <core_bench_list+0x644>
bfc09304:	02a01021 	move	v0,s5
bfc09308:	8ccd0004 	lw	t5,4(a2)
bfc0930c:	250c0001 	addiu	t4,t0,1
bfc09310:	85a40000 	lh	a0,0(t5)
bfc09314:	00000000 	nop
bfc09318:	30820001 	andi	v0,a0,0x1
bfc0931c:	10400005 	beqz	v0,bfc09334 <core_bench_list+0x184>
bfc09320:	3188ffff 	andi	t0,t4,0xffff
bfc09324:	00047a43 	sra	t7,a0,0x9
bfc09328:	31ee0001 	andi	t6,t7,0x1
bfc0932c:	012e2021 	addu	a0,t1,t6
bfc09330:	3089ffff 	andi	t1,a0,0xffff
bfc09334:	8cc40000 	lw	a0,0(a2)
bfc09338:	00000000 	nop
bfc0933c:	10800008 	beqz	a0,bfc09360 <core_bench_list+0x1b0>
bfc09340:	00000000 	nop
bfc09344:	8c900000 	lw	s0,0(a0)
bfc09348:	00000000 	nop
bfc0934c:	acd00000 	sw	s0,0(a2)
bfc09350:	8ea60000 	lw	a2,0(s5)
bfc09354:	00000000 	nop
bfc09358:	ac860000 	sw	a2,0(a0)
bfc0935c:	aea40000 	sw	a0,0(s5)
bfc09360:	8fa30010 	lw	v1,16(sp)
bfc09364:	00000000 	nop
bfc09368:	04600004 	bltz	v1,bfc0937c <core_bench_list+0x1cc>
bfc0936c:	24730001 	addiu	s3,v1,1
bfc09370:	00139400 	sll	s2,s3,0x10
bfc09374:	00128c03 	sra	s1,s2,0x10
bfc09378:	afb10010 	sw	s1,16(sp)
bfc0937c:	24f60001 	addiu	s6,a3,1
bfc09380:	00163c00 	sll	a3,s6,0x10
bfc09384:	00073c03 	sra	a3,a3,0x10
bfc09388:	00eaa02a 	slt	s4,a3,t2
bfc0938c:	1680ff9e 	bnez	s4,bfc09208 <core_bench_list+0x58>
bfc09390:	00000000 	nop
bfc09394:	012b5023 	subu	t2,t1,t3
bfc09398:	00084880 	sll	t1,t0,0x2
bfc0939c:	01494021 	addu	t0,t2,t1
bfc093a0:	311effff 	andi	s8,t0,0xffff
bfc093a4:	18a00090 	blez	a1,bfc095e8 <core_bench_list+0x438>
bfc093a8:	00000000 	nop
bfc093ac:	12a0008d 	beqz	s5,bfc095e4 <core_bench_list+0x434>
bfc093b0:	24160001 	li	s6,1
bfc093b4:	0000b821 	move	s7,zero
bfc093b8:	0000a021 	move	s4,zero
bfc093bc:	00002021 	move	a0,zero
bfc093c0:	8eb10000 	lw	s1,0(s5)
bfc093c4:	26cbffff 	addiu	t3,s6,-1
bfc093c8:	26f70001 	addiu	s7,s7,1
bfc093cc:	31630007 	andi	v1,t3,0x7
bfc093d0:	12200053 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc093d4:	24130001 	li	s3,1
bfc093d8:	0276502a 	slt	t2,s3,s6
bfc093dc:	11400051 	beqz	t2,bfc09524 <core_bench_list+0x374>
bfc093e0:	02a08021 	move	s0,s5
bfc093e4:	1060002c 	beqz	v1,bfc09498 <core_bench_list+0x2e8>
bfc093e8:	00000000 	nop
bfc093ec:	10730023 	beq	v1,s3,bfc0947c <core_bench_list+0x2cc>
bfc093f0:	24060002 	li	a2,2
bfc093f4:	1066001d 	beq	v1,a2,bfc0946c <core_bench_list+0x2bc>
bfc093f8:	24090003 	li	t1,3
bfc093fc:	10690017 	beq	v1,t1,bfc0945c <core_bench_list+0x2ac>
bfc09400:	240b0004 	li	t3,4
bfc09404:	106b0011 	beq	v1,t3,bfc0944c <core_bench_list+0x29c>
bfc09408:	24180005 	li	t8,5
bfc0940c:	1078000b 	beq	v1,t8,bfc0943c <core_bench_list+0x28c>
bfc09410:	24190006 	li	t9,6
bfc09414:	10790005 	beq	v1,t9,bfc0942c <core_bench_list+0x27c>
bfc09418:	00000000 	nop
bfc0941c:	8e310000 	lw	s1,0(s1)
bfc09420:	00000000 	nop
bfc09424:	1220003f 	beqz	s1,bfc09524 <core_bench_list+0x374>
bfc09428:	24130002 	li	s3,2
bfc0942c:	8e310000 	lw	s1,0(s1)
bfc09430:	00000000 	nop
bfc09434:	1220003a 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc09438:	26730001 	addiu	s3,s3,1
bfc0943c:	8e310000 	lw	s1,0(s1)
bfc09440:	00000000 	nop
bfc09444:	12200036 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc09448:	26730001 	addiu	s3,s3,1
bfc0944c:	8e310000 	lw	s1,0(s1)
bfc09450:	00000000 	nop
bfc09454:	12200032 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc09458:	26730001 	addiu	s3,s3,1
bfc0945c:	8e310000 	lw	s1,0(s1)
bfc09460:	00000000 	nop
bfc09464:	1220002e 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc09468:	26730001 	addiu	s3,s3,1
bfc0946c:	8e310000 	lw	s1,0(s1)
bfc09470:	00000000 	nop
bfc09474:	1220002a 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc09478:	26730001 	addiu	s3,s3,1
bfc0947c:	8e310000 	lw	s1,0(s1)
bfc09480:	00000000 	nop
bfc09484:	12200026 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc09488:	26730001 	addiu	s3,s3,1
bfc0948c:	0276f82a 	slt	ra,s3,s6
bfc09490:	13e00024 	beqz	ra,bfc09524 <core_bench_list+0x374>
bfc09494:	02a08021 	move	s0,s5
bfc09498:	8e310000 	lw	s1,0(s1)
bfc0949c:	26730001 	addiu	s3,s3,1
bfc094a0:	1220001f 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc094a4:	02601021 	move	v0,s3
bfc094a8:	8e310000 	lw	s1,0(s1)
bfc094ac:	00000000 	nop
bfc094b0:	1220001b 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc094b4:	26730001 	addiu	s3,s3,1
bfc094b8:	8e310000 	lw	s1,0(s1)
bfc094bc:	00000000 	nop
bfc094c0:	12200017 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc094c4:	24530002 	addiu	s3,v0,2
bfc094c8:	8e310000 	lw	s1,0(s1)
bfc094cc:	00000000 	nop
bfc094d0:	12200013 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc094d4:	24530003 	addiu	s3,v0,3
bfc094d8:	8e310000 	lw	s1,0(s1)
bfc094dc:	00000000 	nop
bfc094e0:	1220000f 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc094e4:	24530004 	addiu	s3,v0,4
bfc094e8:	8e310000 	lw	s1,0(s1)
bfc094ec:	00000000 	nop
bfc094f0:	1220000b 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc094f4:	24530005 	addiu	s3,v0,5
bfc094f8:	8e310000 	lw	s1,0(s1)
bfc094fc:	00000000 	nop
bfc09500:	12200007 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc09504:	24530006 	addiu	s3,v0,6
bfc09508:	8e310000 	lw	s1,0(s1)
bfc0950c:	24530007 	addiu	s3,v0,7
bfc09510:	12200003 	beqz	s1,bfc09520 <core_bench_list+0x370>
bfc09514:	0276102a 	slt	v0,s3,s6
bfc09518:	1440ffdf 	bnez	v0,bfc09498 <core_bench_list+0x2e8>
bfc0951c:	00000000 	nop
bfc09520:	02a08021 	move	s0,s5
bfc09524:	02c09021 	move	s2,s6
bfc09528:	12600017 	beqz	s3,bfc09588 <core_bench_list+0x3d8>
bfc0952c:	0080a821 	move	s5,a0
bfc09530:	1240001f 	beqz	s2,bfc095b0 <core_bench_list+0x400>
bfc09534:	00000000 	nop
bfc09538:	1220001d 	beqz	s1,bfc095b0 <core_bench_list+0x400>
bfc0953c:	00000000 	nop
bfc09540:	8e040004 	lw	a0,4(s0)
bfc09544:	8e250004 	lw	a1,4(s1)
bfc09548:	8fa60040 	lw	a2,64(sp)
bfc0954c:	0ff023dc 	jal	bfc08f70 <cmp_complex>
bfc09550:	00000000 	nop
bfc09554:	18400016 	blez	v0,bfc095b0 <core_bench_list+0x400>
bfc09558:	00000000 	nop
bfc0955c:	8e220000 	lw	v0,0(s1)
bfc09560:	02001821 	move	v1,s0
bfc09564:	2652ffff 	addiu	s2,s2,-1
bfc09568:	02208021 	move	s0,s1
bfc0956c:	1280000e 	beqz	s4,bfc095a8 <core_bench_list+0x3f8>
bfc09570:	00000000 	nop
bfc09574:	ae900000 	sw	s0,0(s4)
bfc09578:	0200a021 	move	s4,s0
bfc0957c:	00408821 	move	s1,v0
bfc09580:	1660ffeb 	bnez	s3,bfc09530 <core_bench_list+0x380>
bfc09584:	00608021 	move	s0,v1
bfc09588:	1240000d 	beqz	s2,bfc095c0 <core_bench_list+0x410>
bfc0958c:	00000000 	nop
bfc09590:	1220000f 	beqz	s1,bfc095d0 <core_bench_list+0x420>
bfc09594:	02001821 	move	v1,s0
bfc09598:	2652ffff 	addiu	s2,s2,-1
bfc0959c:	8e220000 	lw	v0,0(s1)
bfc095a0:	1680fff4 	bnez	s4,bfc09574 <core_bench_list+0x3c4>
bfc095a4:	02208021 	move	s0,s1
bfc095a8:	0bf0255e 	j	bfc09578 <core_bench_list+0x3c8>
bfc095ac:	0200a821 	move	s5,s0
bfc095b0:	2673ffff 	addiu	s3,s3,-1
bfc095b4:	8e030000 	lw	v1,0(s0)
bfc095b8:	0bf0255b 	j	bfc0956c <core_bench_list+0x3bc>
bfc095bc:	02201021 	move	v0,s1
bfc095c0:	12200003 	beqz	s1,bfc095d0 <core_bench_list+0x420>
bfc095c4:	02a02021 	move	a0,s5
bfc095c8:	0bf024f0 	j	bfc093c0 <core_bench_list+0x210>
bfc095cc:	0220a821 	move	s5,s1
bfc095d0:	24050001 	li	a1,1
bfc095d4:	12e50004 	beq	s7,a1,bfc095e8 <core_bench_list+0x438>
bfc095d8:	ae800000 	sw	zero,0(s4)
bfc095dc:	16a0ff75 	bnez	s5,bfc093b4 <core_bench_list+0x204>
bfc095e0:	0016b040 	sll	s6,s6,0x1
bfc095e4:	aea00000 	sw	zero,0(s5)
bfc095e8:	8eb80000 	lw	t8,0(s5)
bfc095ec:	8fb70010 	lw	s7,16(sp)
bfc095f0:	8f110000 	lw	s1,0(t8)
bfc095f4:	8f030004 	lw	v1,4(t8)
bfc095f8:	8e390004 	lw	t9,4(s1)
bfc095fc:	8e3f0000 	lw	ra,0(s1)
bfc09600:	af190004 	sw	t9,4(t8)
bfc09604:	af1f0000 	sw	ra,0(t8)
bfc09608:	00603021 	move	a2,v1
bfc0960c:	ae200000 	sw	zero,0(s1)
bfc09610:	06e00172 	bltz	s7,bfc09bdc <core_bench_list+0xa2c>
bfc09614:	ae230004 	sw	v1,4(s1)
bfc09618:	8ea50004 	lw	a1,4(s5)
bfc0961c:	8fa40010 	lw	a0,16(sp)
bfc09620:	84ad0002 	lh	t5,2(a1)
bfc09624:	00000000 	nop
bfc09628:	11a4000f 	beq	t5,a0,bfc09668 <core_bench_list+0x4b8>
bfc0962c:	02a08021 	move	s0,s5
bfc09630:	0bf02594 	j	bfc09650 <core_bench_list+0x4a0>
bfc09634:	02a02021 	move	a0,s5
bfc09638:	8c900004 	lw	s0,4(a0)
bfc0963c:	8fae0010 	lw	t6,16(sp)
bfc09640:	860f0002 	lh	t7,2(s0)
bfc09644:	00000000 	nop
bfc09648:	11ee0007 	beq	t7,t6,bfc09668 <core_bench_list+0x4b8>
bfc0964c:	00808021 	move	s0,a0
bfc09650:	8c840000 	lw	a0,0(a0)
bfc09654:	00000000 	nop
bfc09658:	1480fff7 	bnez	a0,bfc09638 <core_bench_list+0x488>
bfc0965c:	00000000 	nop
bfc09660:	8eb00000 	lw	s0,0(s5)
bfc09664:	00000000 	nop
bfc09668:	1200006d 	beqz	s0,bfc09820 <core_bench_list+0x670>
bfc0966c:	00000000 	nop
bfc09670:	84a40000 	lh	a0,0(a1)
bfc09674:	0ff01800 	jal	bfc06000 <crc16>
bfc09678:	03c02821 	move	a1,s8
bfc0967c:	8e100000 	lw	s0,0(s0)
bfc09680:	0040f021 	move	s8,v0
bfc09684:	12000065 	beqz	s0,bfc0981c <core_bench_list+0x66c>
bfc09688:	00402821 	move	a1,v0
bfc0968c:	8ebe0004 	lw	s8,4(s5)
bfc09690:	00000000 	nop
bfc09694:	87c40000 	lh	a0,0(s8)
bfc09698:	0ff01800 	jal	bfc06000 <crc16>
bfc0969c:	00000000 	nop
bfc096a0:	8e100000 	lw	s0,0(s0)
bfc096a4:	0040f021 	move	s8,v0
bfc096a8:	1200005c 	beqz	s0,bfc0981c <core_bench_list+0x66c>
bfc096ac:	00402821 	move	a1,v0
bfc096b0:	8eb20004 	lw	s2,4(s5)
bfc096b4:	00000000 	nop
bfc096b8:	86440000 	lh	a0,0(s2)
bfc096bc:	0ff01800 	jal	bfc06000 <crc16>
bfc096c0:	00000000 	nop
bfc096c4:	8e100000 	lw	s0,0(s0)
bfc096c8:	0040f021 	move	s8,v0
bfc096cc:	12000053 	beqz	s0,bfc0981c <core_bench_list+0x66c>
bfc096d0:	00402821 	move	a1,v0
bfc096d4:	8eb30004 	lw	s3,4(s5)
bfc096d8:	00000000 	nop
bfc096dc:	86640000 	lh	a0,0(s3)
bfc096e0:	0ff01800 	jal	bfc06000 <crc16>
bfc096e4:	00000000 	nop
bfc096e8:	8e100000 	lw	s0,0(s0)
bfc096ec:	0040f021 	move	s8,v0
bfc096f0:	1200004a 	beqz	s0,bfc0981c <core_bench_list+0x66c>
bfc096f4:	00402821 	move	a1,v0
bfc096f8:	8eb40004 	lw	s4,4(s5)
bfc096fc:	00000000 	nop
bfc09700:	86840000 	lh	a0,0(s4)
bfc09704:	0ff01800 	jal	bfc06000 <crc16>
bfc09708:	00000000 	nop
bfc0970c:	8e100000 	lw	s0,0(s0)
bfc09710:	0040f021 	move	s8,v0
bfc09714:	12000041 	beqz	s0,bfc0981c <core_bench_list+0x66c>
bfc09718:	00402821 	move	a1,v0
bfc0971c:	8ebe0004 	lw	s8,4(s5)
bfc09720:	00000000 	nop
bfc09724:	87c40000 	lh	a0,0(s8)
bfc09728:	0ff01800 	jal	bfc06000 <crc16>
bfc0972c:	00000000 	nop
bfc09730:	8e100000 	lw	s0,0(s0)
bfc09734:	0040f021 	move	s8,v0
bfc09738:	12000038 	beqz	s0,bfc0981c <core_bench_list+0x66c>
bfc0973c:	00402821 	move	a1,v0
bfc09740:	8ea70004 	lw	a3,4(s5)
bfc09744:	00000000 	nop
bfc09748:	84e40000 	lh	a0,0(a3)
bfc0974c:	0ff01800 	jal	bfc06000 <crc16>
bfc09750:	00000000 	nop
bfc09754:	8e100000 	lw	s0,0(s0)
bfc09758:	0040f021 	move	s8,v0
bfc0975c:	1200002f 	beqz	s0,bfc0981c <core_bench_list+0x66c>
bfc09760:	00402821 	move	a1,v0
bfc09764:	8ea80004 	lw	t0,4(s5)
bfc09768:	00000000 	nop
bfc0976c:	85040000 	lh	a0,0(t0)
bfc09770:	0ff01800 	jal	bfc06000 <crc16>
bfc09774:	00000000 	nop
bfc09778:	8e100000 	lw	s0,0(s0)
bfc0977c:	00000000 	nop
bfc09780:	12000026 	beqz	s0,bfc0981c <core_bench_list+0x66c>
bfc09784:	0040f021 	move	s8,v0
bfc09788:	8ea50004 	lw	a1,4(s5)
bfc0978c:	0bf0259c 	j	bfc09670 <core_bench_list+0x4c0>
bfc09790:	00000000 	nop
bfc09794:	12a00016 	beqz	s5,bfc097f0 <core_bench_list+0x640>
bfc09798:	00001021 	move	v0,zero
bfc0979c:	8eac0004 	lw	t4,4(s5)
bfc097a0:	8fa40014 	lw	a0,20(sp)
bfc097a4:	91860000 	lbu	a2,0(t4)
bfc097a8:	00000000 	nop
bfc097ac:	10c4feae 	beq	a2,a0,bfc09268 <core_bench_list+0xb8>
bfc097b0:	02a03021 	move	a2,s5
bfc097b4:	0bf025f5 	j	bfc097d4 <core_bench_list+0x624>
bfc097b8:	02a02021 	move	a0,s5
bfc097bc:	8c960004 	lw	s6,4(a0)
bfc097c0:	8fb30014 	lw	s3,20(sp)
bfc097c4:	92d40000 	lbu	s4,0(s6)
bfc097c8:	00000000 	nop
bfc097cc:	1293fea6 	beq	s4,s3,bfc09268 <core_bench_list+0xb8>
bfc097d0:	00803021 	move	a2,a0
bfc097d4:	8c840000 	lw	a0,0(a0)
bfc097d8:	00000000 	nop
bfc097dc:	1480fff7 	bnez	a0,bfc097bc <core_bench_list+0x60c>
bfc097e0:	00003021 	move	a2,zero
bfc097e4:	0bf0249a 	j	bfc09268 <core_bench_list+0xb8>
bfc097e8:	00000000 	nop
bfc097ec:	00001021 	move	v0,zero
bfc097f0:	0000a821 	move	s5,zero
bfc097f4:	8c430000 	lw	v1,0(v0)
bfc097f8:	257f0001 	addiu	ra,t3,1
bfc097fc:	8c7e0004 	lw	s8,4(v1)
bfc09800:	33ebffff 	andi	t3,ra,0xffff
bfc09804:	83d90001 	lb	t9,1(s8)
bfc09808:	00000000 	nop
bfc0980c:	33380001 	andi	t8,t9,0x1
bfc09810:	0138b821 	addu	s7,t1,t8
bfc09814:	0bf024d8 	j	bfc09360 <core_bench_list+0x1b0>
bfc09818:	32e9ffff 	andi	t1,s7,0xffff
bfc0981c:	8e260004 	lw	a2,4(s1)
bfc09820:	8ea70000 	lw	a3,0(s5)
bfc09824:	24160001 	li	s6,1
bfc09828:	8cea0004 	lw	t2,4(a3)
bfc0982c:	8ce80000 	lw	t0,0(a3)
bfc09830:	ae2a0004 	sw	t2,4(s1)
bfc09834:	ae280000 	sw	t0,0(s1)
bfc09838:	ace60004 	sw	a2,4(a3)
bfc0983c:	12a0008d 	beqz	s5,bfc09a74 <core_bench_list+0x8c4>
bfc09840:	acf10000 	sw	s1,0(a3)
bfc09844:	0000b821 	move	s7,zero
bfc09848:	0000a021 	move	s4,zero
bfc0984c:	00002021 	move	a0,zero
bfc09850:	8eb10000 	lw	s1,0(s5)
bfc09854:	26c6ffff 	addiu	a2,s6,-1
bfc09858:	26f70001 	addiu	s7,s7,1
bfc0985c:	30c30007 	andi	v1,a2,0x7
bfc09860:	12200053 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09864:	24130001 	li	s3,1
bfc09868:	0276282a 	slt	a1,s3,s6
bfc0986c:	10a00051 	beqz	a1,bfc099b4 <core_bench_list+0x804>
bfc09870:	02a08021 	move	s0,s5
bfc09874:	1060002c 	beqz	v1,bfc09928 <core_bench_list+0x778>
bfc09878:	00000000 	nop
bfc0987c:	10730023 	beq	v1,s3,bfc0990c <core_bench_list+0x75c>
bfc09880:	24020002 	li	v0,2
bfc09884:	1062001d 	beq	v1,v0,bfc098fc <core_bench_list+0x74c>
bfc09888:	240c0003 	li	t4,3
bfc0988c:	106c0017 	beq	v1,t4,bfc098ec <core_bench_list+0x73c>
bfc09890:	240d0004 	li	t5,4
bfc09894:	106d0011 	beq	v1,t5,bfc098dc <core_bench_list+0x72c>
bfc09898:	240e0005 	li	t6,5
bfc0989c:	106e000b 	beq	v1,t6,bfc098cc <core_bench_list+0x71c>
bfc098a0:	240f0006 	li	t7,6
bfc098a4:	106f0005 	beq	v1,t7,bfc098bc <core_bench_list+0x70c>
bfc098a8:	00000000 	nop
bfc098ac:	8e310000 	lw	s1,0(s1)
bfc098b0:	00000000 	nop
bfc098b4:	1220003f 	beqz	s1,bfc099b4 <core_bench_list+0x804>
bfc098b8:	24130002 	li	s3,2
bfc098bc:	8e310000 	lw	s1,0(s1)
bfc098c0:	00000000 	nop
bfc098c4:	1220003a 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc098c8:	26730001 	addiu	s3,s3,1
bfc098cc:	8e310000 	lw	s1,0(s1)
bfc098d0:	00000000 	nop
bfc098d4:	12200036 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc098d8:	26730001 	addiu	s3,s3,1
bfc098dc:	8e310000 	lw	s1,0(s1)
bfc098e0:	00000000 	nop
bfc098e4:	12200032 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc098e8:	26730001 	addiu	s3,s3,1
bfc098ec:	8e310000 	lw	s1,0(s1)
bfc098f0:	00000000 	nop
bfc098f4:	1220002e 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc098f8:	26730001 	addiu	s3,s3,1
bfc098fc:	8e310000 	lw	s1,0(s1)
bfc09900:	00000000 	nop
bfc09904:	1220002a 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09908:	26730001 	addiu	s3,s3,1
bfc0990c:	8e310000 	lw	s1,0(s1)
bfc09910:	00000000 	nop
bfc09914:	12200026 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09918:	26730001 	addiu	s3,s3,1
bfc0991c:	0276802a 	slt	s0,s3,s6
bfc09920:	12000024 	beqz	s0,bfc099b4 <core_bench_list+0x804>
bfc09924:	02a08021 	move	s0,s5
bfc09928:	8e310000 	lw	s1,0(s1)
bfc0992c:	26730001 	addiu	s3,s3,1
bfc09930:	1220001f 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09934:	02601021 	move	v0,s3
bfc09938:	8e310000 	lw	s1,0(s1)
bfc0993c:	00000000 	nop
bfc09940:	1220001b 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09944:	26730001 	addiu	s3,s3,1
bfc09948:	8e310000 	lw	s1,0(s1)
bfc0994c:	00000000 	nop
bfc09950:	12200017 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09954:	24530002 	addiu	s3,v0,2
bfc09958:	8e310000 	lw	s1,0(s1)
bfc0995c:	00000000 	nop
bfc09960:	12200013 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09964:	24530003 	addiu	s3,v0,3
bfc09968:	8e310000 	lw	s1,0(s1)
bfc0996c:	00000000 	nop
bfc09970:	1220000f 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09974:	24530004 	addiu	s3,v0,4
bfc09978:	8e310000 	lw	s1,0(s1)
bfc0997c:	00000000 	nop
bfc09980:	1220000b 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09984:	24530005 	addiu	s3,v0,5
bfc09988:	8e310000 	lw	s1,0(s1)
bfc0998c:	00000000 	nop
bfc09990:	12200007 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc09994:	24530006 	addiu	s3,v0,6
bfc09998:	8e310000 	lw	s1,0(s1)
bfc0999c:	24530007 	addiu	s3,v0,7
bfc099a0:	12200003 	beqz	s1,bfc099b0 <core_bench_list+0x800>
bfc099a4:	0276102a 	slt	v0,s3,s6
bfc099a8:	1440ffdf 	bnez	v0,bfc09928 <core_bench_list+0x778>
bfc099ac:	00000000 	nop
bfc099b0:	02a08021 	move	s0,s5
bfc099b4:	02c09021 	move	s2,s6
bfc099b8:	12600016 	beqz	s3,bfc09a14 <core_bench_list+0x864>
bfc099bc:	0080a821 	move	s5,a0
bfc099c0:	1240001f 	beqz	s2,bfc09a40 <core_bench_list+0x890>
bfc099c4:	00000000 	nop
bfc099c8:	1220001d 	beqz	s1,bfc09a40 <core_bench_list+0x890>
bfc099cc:	00000000 	nop
bfc099d0:	8e040004 	lw	a0,4(s0)
bfc099d4:	8e250004 	lw	a1,4(s1)
bfc099d8:	0ff02074 	jal	bfc081d0 <cmp_idx>
bfc099dc:	00003021 	move	a2,zero
bfc099e0:	18400017 	blez	v0,bfc09a40 <core_bench_list+0x890>
bfc099e4:	00000000 	nop
bfc099e8:	8e220000 	lw	v0,0(s1)
bfc099ec:	02001821 	move	v1,s0
bfc099f0:	2652ffff 	addiu	s2,s2,-1
bfc099f4:	02208021 	move	s0,s1
bfc099f8:	1280000e 	beqz	s4,bfc09a34 <core_bench_list+0x884>
bfc099fc:	00000000 	nop
bfc09a00:	ae900000 	sw	s0,0(s4)
bfc09a04:	0200a021 	move	s4,s0
bfc09a08:	00408821 	move	s1,v0
bfc09a0c:	1660ffec 	bnez	s3,bfc099c0 <core_bench_list+0x810>
bfc09a10:	00608021 	move	s0,v1
bfc09a14:	1240000e 	beqz	s2,bfc09a50 <core_bench_list+0x8a0>
bfc09a18:	00000000 	nop
bfc09a1c:	12200010 	beqz	s1,bfc09a60 <core_bench_list+0x8b0>
bfc09a20:	02001821 	move	v1,s0
bfc09a24:	2652ffff 	addiu	s2,s2,-1
bfc09a28:	8e220000 	lw	v0,0(s1)
bfc09a2c:	1680fff4 	bnez	s4,bfc09a00 <core_bench_list+0x850>
bfc09a30:	02208021 	move	s0,s1
bfc09a34:	0bf02681 	j	bfc09a04 <core_bench_list+0x854>
bfc09a38:	0200a821 	move	s5,s0
bfc09a3c:	00000000 	nop
bfc09a40:	2673ffff 	addiu	s3,s3,-1
bfc09a44:	8e030000 	lw	v1,0(s0)
bfc09a48:	0bf0267e 	j	bfc099f8 <core_bench_list+0x848>
bfc09a4c:	02201021 	move	v0,s1
bfc09a50:	12200003 	beqz	s1,bfc09a60 <core_bench_list+0x8b0>
bfc09a54:	02a02021 	move	a0,s5
bfc09a58:	0bf02614 	j	bfc09850 <core_bench_list+0x6a0>
bfc09a5c:	0220a821 	move	s5,s1
bfc09a60:	24110001 	li	s1,1
bfc09a64:	12f10004 	beq	s7,s1,bfc09a78 <core_bench_list+0x8c8>
bfc09a68:	ae800000 	sw	zero,0(s4)
bfc09a6c:	16a0ff75 	bnez	s5,bfc09844 <core_bench_list+0x694>
bfc09a70:	0016b040 	sll	s6,s6,0x1
bfc09a74:	aea00000 	sw	zero,0(s5)
bfc09a78:	8eb00000 	lw	s0,0(s5)
bfc09a7c:	00000000 	nop
bfc09a80:	12000049 	beqz	s0,bfc09ba8 <core_bench_list+0x9f8>
bfc09a84:	00000000 	nop
bfc09a88:	8eb60004 	lw	s6,4(s5)
bfc09a8c:	00000000 	nop
bfc09a90:	86c40000 	lh	a0,0(s6)
bfc09a94:	0ff01800 	jal	bfc06000 <crc16>
bfc09a98:	03c02821 	move	a1,s8
bfc09a9c:	8e100000 	lw	s0,0(s0)
bfc09aa0:	0040f021 	move	s8,v0
bfc09aa4:	12000040 	beqz	s0,bfc09ba8 <core_bench_list+0x9f8>
bfc09aa8:	00402821 	move	a1,v0
bfc09aac:	8ea90004 	lw	t1,4(s5)
bfc09ab0:	00000000 	nop
bfc09ab4:	85240000 	lh	a0,0(t1)
bfc09ab8:	0ff01800 	jal	bfc06000 <crc16>
bfc09abc:	00000000 	nop
bfc09ac0:	8e100000 	lw	s0,0(s0)
bfc09ac4:	0040f021 	move	s8,v0
bfc09ac8:	12000037 	beqz	s0,bfc09ba8 <core_bench_list+0x9f8>
bfc09acc:	00402821 	move	a1,v0
bfc09ad0:	8eab0004 	lw	t3,4(s5)
bfc09ad4:	00000000 	nop
bfc09ad8:	85640000 	lh	a0,0(t3)
bfc09adc:	0ff01800 	jal	bfc06000 <crc16>
bfc09ae0:	00000000 	nop
bfc09ae4:	8e100000 	lw	s0,0(s0)
bfc09ae8:	0040f021 	move	s8,v0
bfc09aec:	1200002e 	beqz	s0,bfc09ba8 <core_bench_list+0x9f8>
bfc09af0:	00402821 	move	a1,v0
bfc09af4:	8eb70004 	lw	s7,4(s5)
bfc09af8:	00000000 	nop
bfc09afc:	86e40000 	lh	a0,0(s7)
bfc09b00:	0ff01800 	jal	bfc06000 <crc16>
bfc09b04:	00000000 	nop
bfc09b08:	8e100000 	lw	s0,0(s0)
bfc09b0c:	0040f021 	move	s8,v0
bfc09b10:	12000025 	beqz	s0,bfc09ba8 <core_bench_list+0x9f8>
bfc09b14:	00402821 	move	a1,v0
bfc09b18:	8eb80004 	lw	t8,4(s5)
bfc09b1c:	00000000 	nop
bfc09b20:	87040000 	lh	a0,0(t8)
bfc09b24:	0ff01800 	jal	bfc06000 <crc16>
bfc09b28:	00000000 	nop
bfc09b2c:	8e100000 	lw	s0,0(s0)
bfc09b30:	0040f021 	move	s8,v0
bfc09b34:	1200001c 	beqz	s0,bfc09ba8 <core_bench_list+0x9f8>
bfc09b38:	00402821 	move	a1,v0
bfc09b3c:	8eb90004 	lw	t9,4(s5)
bfc09b40:	00000000 	nop
bfc09b44:	87240000 	lh	a0,0(t9)
bfc09b48:	0ff01800 	jal	bfc06000 <crc16>
bfc09b4c:	00000000 	nop
bfc09b50:	8e100000 	lw	s0,0(s0)
bfc09b54:	0040f021 	move	s8,v0
bfc09b58:	12000013 	beqz	s0,bfc09ba8 <core_bench_list+0x9f8>
bfc09b5c:	00402821 	move	a1,v0
bfc09b60:	8ebf0004 	lw	ra,4(s5)
bfc09b64:	00000000 	nop
bfc09b68:	87e40000 	lh	a0,0(ra)
bfc09b6c:	0ff01800 	jal	bfc06000 <crc16>
bfc09b70:	00000000 	nop
bfc09b74:	8e100000 	lw	s0,0(s0)
bfc09b78:	0040f021 	move	s8,v0
bfc09b7c:	1200000a 	beqz	s0,bfc09ba8 <core_bench_list+0x9f8>
bfc09b80:	00402821 	move	a1,v0
bfc09b84:	8ea30004 	lw	v1,4(s5)
bfc09b88:	00000000 	nop
bfc09b8c:	84640000 	lh	a0,0(v1)
bfc09b90:	0ff01800 	jal	bfc06000 <crc16>
bfc09b94:	00000000 	nop
bfc09b98:	8e100000 	lw	s0,0(s0)
bfc09b9c:	00000000 	nop
bfc09ba0:	1600ffb9 	bnez	s0,bfc09a88 <core_bench_list+0x8d8>
bfc09ba4:	0040f021 	move	s8,v0
bfc09ba8:	8fbf003c 	lw	ra,60(sp)
bfc09bac:	03c01021 	move	v0,s8
bfc09bb0:	8fbe0038 	lw	s8,56(sp)
bfc09bb4:	8fb70034 	lw	s7,52(sp)
bfc09bb8:	8fb60030 	lw	s6,48(sp)
bfc09bbc:	8fb5002c 	lw	s5,44(sp)
bfc09bc0:	8fb40028 	lw	s4,40(sp)
bfc09bc4:	8fb30024 	lw	s3,36(sp)
bfc09bc8:	8fb20020 	lw	s2,32(sp)
bfc09bcc:	8fb1001c 	lw	s1,28(sp)
bfc09bd0:	8fb00018 	lw	s0,24(sp)
bfc09bd4:	03e00008 	jr	ra
bfc09bd8:	27bd0040 	addiu	sp,sp,64
bfc09bdc:	8ea50004 	lw	a1,4(s5)
bfc09be0:	8fac0014 	lw	t4,20(sp)
bfc09be4:	90a20000 	lbu	v0,0(a1)
bfc09be8:	00000000 	nop
bfc09bec:	104cfe9e 	beq	v0,t4,bfc09668 <core_bench_list+0x4b8>
bfc09bf0:	02a08021 	move	s0,s5
bfc09bf4:	0bf02705 	j	bfc09c14 <core_bench_list+0xa64>
bfc09bf8:	02a02021 	move	a0,s5
bfc09bfc:	8c940004 	lw	s4,4(a0)
bfc09c00:	8fb20014 	lw	s2,20(sp)
bfc09c04:	92930000 	lbu	s3,0(s4)
bfc09c08:	00000000 	nop
bfc09c0c:	1253fe96 	beq	s2,s3,bfc09668 <core_bench_list+0x4b8>
bfc09c10:	00808021 	move	s0,a0
bfc09c14:	8c840000 	lw	a0,0(a0)
bfc09c18:	00000000 	nop
bfc09c1c:	1480fff7 	bnez	a0,bfc09bfc <core_bench_list+0xa4c>
bfc09c20:	00000000 	nop
bfc09c24:	0bf02598 	j	bfc09660 <core_bench_list+0x4b0>
bfc09c28:	00000000 	nop
bfc09c2c:	afa50010 	sw	a1,16(sp)
bfc09c30:	0bf024e9 	j	bfc093a4 <core_bench_list+0x1f4>
bfc09c34:	0000f021 	move	s8,zero
	...

bfc09c40 <portable_malloc>:
portable_malloc():
bfc09c40:	03e00008 	jr	ra
bfc09c44:	00001021 	move	v0,zero
	...

bfc09c50 <portable_free>:
portable_free():
bfc09c50:	03e00008 	jr	ra
bfc09c54:	00000000 	nop
	...

bfc09c60 <get_time>:
get_time():
bfc09c60:	3c0c8000 	lui	t4,0x8000
bfc09c64:	3c0b8000 	lui	t3,0x8000
bfc09c68:	25820a10 	addiu	v0,t4,2576
bfc09c6c:	25650a00 	addiu	a1,t3,2560
bfc09c70:	8c580004 	lw	t8,4(v0)
bfc09c74:	8cb90004 	lw	t9,4(a1)
bfc09c78:	3c0f000f 	lui	t7,0xf
bfc09c7c:	03197023 	subu	t6,t8,t9
bfc09c80:	35ed4240 	ori	t5,t7,0x4240
bfc09c84:	15a00002 	bnez	t5,bfc09c90 <get_time+0x30>
bfc09c88:	01cd001b 	divu	zero,t6,t5
bfc09c8c:	0007000d 	break	0x7
bfc09c90:	8d890a10 	lw	t1,2576(t4)
bfc09c94:	8d6a0a00 	lw	t2,2560(t3)
bfc09c98:	00000000 	nop
bfc09c9c:	012a1823 	subu	v1,t1,t2
bfc09ca0:	00034080 	sll	t0,v1,0x2
bfc09ca4:	000339c0 	sll	a3,v1,0x7
bfc09ca8:	00e83023 	subu	a2,a3,t0
bfc09cac:	00c32021 	addu	a0,a2,v1
bfc09cb0:	000410c0 	sll	v0,a0,0x3
bfc09cb4:	00002812 	mflo	a1
bfc09cb8:	03e00008 	jr	ra
bfc09cbc:	00a21021 	addu	v0,a1,v0

bfc09cc0 <time_in_secs>:
time_in_secs():
bfc09cc0:	240203e8 	li	v0,1000
bfc09cc4:	14400002 	bnez	v0,bfc09cd0 <time_in_secs+0x10>
bfc09cc8:	0082001b 	divu	zero,a0,v0
bfc09ccc:	0007000d 	break	0x7
bfc09cd0:	00001012 	mflo	v0
bfc09cd4:	03e00008 	jr	ra
bfc09cd8:	00000000 	nop
bfc09cdc:	00000000 	nop

bfc09ce0 <portable_init>:
portable_init():
bfc09ce0:	24020001 	li	v0,1
bfc09ce4:	03e00008 	jr	ra
bfc09ce8:	a0820000 	sb	v0,0(a0)
bfc09cec:	00000000 	nop

bfc09cf0 <portable_fini>:
portable_fini():
bfc09cf0:	03e00008 	jr	ra
bfc09cf4:	a0800000 	sb	zero,0(a0)
	...

bfc09d00 <stop_time>:
stop_time():
bfc09d00:	3c058000 	lui	a1,0x8000
bfc09d04:	24a50a10 	addiu	a1,a1,2576
bfc09d08:	0bf0286f 	j	bfc0a1bc <clock_gettime>
bfc09d0c:	00002021 	move	a0,zero

bfc09d10 <start_time>:
start_time():
bfc09d10:	3c058000 	lui	a1,0x8000
bfc09d14:	24a50a00 	addiu	a1,a1,2560
bfc09d18:	0bf0286f 	j	bfc0a1bc <clock_gettime>
bfc09d1c:	00002021 	move	a0,zero

bfc09d20 <printf>:
printf():
/mnt/perf_lab2/lib/printf.c:2
bfc09d20:	27bdffc8 	addiu	sp,sp,-56
bfc09d24:	afb30024 	sw	s3,36(sp)
bfc09d28:	afbf0034 	sw	ra,52(sp)
bfc09d2c:	afb60030 	sw	s6,48(sp)
bfc09d30:	afb5002c 	sw	s5,44(sp)
bfc09d34:	afb40028 	sw	s4,40(sp)
bfc09d38:	afb20020 	sw	s2,32(sp)
bfc09d3c:	afb1001c 	sw	s1,28(sp)
bfc09d40:	afb00018 	sw	s0,24(sp)
/mnt/perf_lab2/lib/printf.c:10
bfc09d44:	80900000 	lb	s0,0(a0)
/mnt/perf_lab2/lib/printf.c:2
bfc09d48:	00809821 	move	s3,a0
/mnt/perf_lab2/lib/printf.c:8
bfc09d4c:	27a4003c 	addiu	a0,sp,60
/mnt/perf_lab2/lib/printf.c:2
bfc09d50:	afa5003c 	sw	a1,60(sp)
bfc09d54:	afa60040 	sw	a2,64(sp)
bfc09d58:	afa70044 	sw	a3,68(sp)
/mnt/perf_lab2/lib/printf.c:10
bfc09d5c:	12000013 	beqz	s0,bfc09dac <printf+0x8c>
bfc09d60:	afa40010 	sw	a0,16(sp)
/mnt/perf_lab2/lib/printf.c:17
bfc09d64:	3c028000 	lui	v0,0x8000
/mnt/perf_lab2/lib/printf.c:9
bfc09d68:	00809021 	move	s2,a0
/mnt/perf_lab2/lib/printf.c:17
bfc09d6c:	24560840 	addiu	s6,v0,2112
/mnt/perf_lab2/lib/printf.c:9
bfc09d70:	00008821 	move	s1,zero
/mnt/perf_lab2/lib/printf.c:13
bfc09d74:	24140025 	li	s4,37
/mnt/perf_lab2/lib/printf.c:79
bfc09d78:	2415000a 	li	s5,10
/mnt/perf_lab2/lib/printf.c:13
bfc09d7c:	12140016 	beq	s0,s4,bfc09dd8 <printf+0xb8>
bfc09d80:	02711021 	addu	v0,s3,s1
/mnt/perf_lab2/lib/printf.c:79
bfc09d84:	1215002f 	beq	s0,s5,bfc09e44 <printf+0x124>
bfc09d88:	00000000 	nop
/mnt/perf_lab2/lib/printf.c:80
bfc09d8c:	0ff027e1 	jal	bfc09f84 <putchar>
bfc09d90:	02002021 	move	a0,s0
/mnt/perf_lab2/lib/printf.c:10
bfc09d94:	26310001 	addiu	s1,s1,1
bfc09d98:	02711021 	addu	v0,s3,s1
bfc09d9c:	80500000 	lb	s0,0(v0)
bfc09da0:	00000000 	nop
bfc09da4:	1600fff5 	bnez	s0,bfc09d7c <printf+0x5c>
bfc09da8:	00000000 	nop
/mnt/perf_lab2/lib/printf.c:84
bfc09dac:	8fbf0034 	lw	ra,52(sp)
bfc09db0:	00001021 	move	v0,zero
bfc09db4:	8fb60030 	lw	s6,48(sp)
bfc09db8:	8fb5002c 	lw	s5,44(sp)
bfc09dbc:	8fb40028 	lw	s4,40(sp)
bfc09dc0:	8fb30024 	lw	s3,36(sp)
bfc09dc4:	8fb20020 	lw	s2,32(sp)
bfc09dc8:	8fb1001c 	lw	s1,28(sp)
bfc09dcc:	8fb00018 	lw	s0,24(sp)
bfc09dd0:	03e00008 	jr	ra
bfc09dd4:	27bd0038 	addiu	sp,sp,56
/mnt/perf_lab2/lib/printf.c:13
bfc09dd8:	80440001 	lb	a0,1(v0)
bfc09ddc:	24050001 	li	a1,1
/mnt/perf_lab2/lib/printf.c:17
bfc09de0:	2482ffdb 	addiu	v0,a0,-37
bfc09de4:	304200ff 	andi	v0,v0,0xff
bfc09de8:	2c430054 	sltiu	v1,v0,84
bfc09dec:	14600005 	bnez	v1,bfc09e04 <printf+0xe4>
bfc09df0:	00021080 	sll	v0,v0,0x2
/mnt/perf_lab2/lib/printf.c:73
bfc09df4:	0ff027e1 	jal	bfc09f84 <putchar>
bfc09df8:	24040025 	li	a0,37
/mnt/perf_lab2/lib/printf.c:10
bfc09dfc:	0bf02766 	j	bfc09d98 <printf+0x78>
bfc09e00:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:17
bfc09e04:	02c21021 	addu	v0,s6,v0
bfc09e08:	8c430000 	lw	v1,0(v0)
bfc09e0c:	00000000 	nop
bfc09e10:	00600008 	jr	v1
bfc09e14:	00000000 	nop
/mnt/perf_lab2/lib/printf.c:65
bfc09e18:	26310001 	addiu	s1,s1,1
bfc09e1c:	02711021 	addu	v0,s3,s1
bfc09e20:	80440001 	lb	a0,1(v0)
bfc09e24:	00000000 	nop
/mnt/perf_lab2/lib/printf.c:67
bfc09e28:	2482ffcf 	addiu	v0,a0,-49
bfc09e2c:	304200ff 	andi	v0,v0,0xff
bfc09e30:	2c420009 	sltiu	v0,v0,9
bfc09e34:	1440003f 	bnez	v0,bfc09f34 <printf+0x214>
bfc09e38:	00002821 	move	a1,zero
/mnt/perf_lab2/lib/printf.c:17
bfc09e3c:	0bf02779 	j	bfc09de4 <printf+0xc4>
bfc09e40:	2482ffdb 	addiu	v0,a0,-37
/mnt/perf_lab2/lib/printf.c:79
bfc09e44:	0ff027e1 	jal	bfc09f84 <putchar>
bfc09e48:	2404000d 	li	a0,13
bfc09e4c:	0bf02763 	j	bfc09d8c <printf+0x6c>
bfc09e50:	00000000 	nop
/mnt/perf_lab2/lib/printf.c:30
bfc09e54:	8e440000 	lw	a0,0(s2)
bfc09e58:	2406000a 	li	a2,10
bfc09e5c:	0ff0281c 	jal	bfc0a070 <printbase>
bfc09e60:	00003821 	move	a3,zero
/mnt/perf_lab2/lib/printf.c:31
bfc09e64:	26520004 	addiu	s2,s2,4
/mnt/perf_lab2/lib/printf.c:32
bfc09e68:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09e6c:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:20
bfc09e70:	8e440000 	lw	a0,0(s2)
bfc09e74:	0ff027ec 	jal	bfc09fb0 <putstring>
bfc09e78:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:21
bfc09e7c:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09e80:	26520004 	addiu	s2,s2,4
/mnt/perf_lab2/lib/printf.c:56
bfc09e84:	8e440000 	lw	a0,0(s2)
bfc09e88:	24060010 	li	a2,16
bfc09e8c:	0ff0281c 	jal	bfc0a070 <printbase>
bfc09e90:	00003821 	move	a3,zero
/mnt/perf_lab2/lib/printf.c:57
bfc09e94:	26520004 	addiu	s2,s2,4
/mnt/perf_lab2/lib/printf.c:58
bfc09e98:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09e9c:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:45
bfc09ea0:	8e440000 	lw	a0,0(s2)
bfc09ea4:	24060008 	li	a2,8
bfc09ea8:	0ff0281c 	jal	bfc0a070 <printbase>
bfc09eac:	00003821 	move	a3,zero
/mnt/perf_lab2/lib/printf.c:46
bfc09eb0:	26520004 	addiu	s2,s2,4
/mnt/perf_lab2/lib/printf.c:47
bfc09eb4:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09eb8:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:40
bfc09ebc:	8e440000 	lw	a0,0(s2)
bfc09ec0:	2406000a 	li	a2,10
bfc09ec4:	0ff0281c 	jal	bfc0a070 <printbase>
bfc09ec8:	00003821 	move	a3,zero
/mnt/perf_lab2/lib/printf.c:41
bfc09ecc:	26520004 	addiu	s2,s2,4
/mnt/perf_lab2/lib/printf.c:42
bfc09ed0:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09ed4:	26310002 	addiu	s1,s1,2
/mnt/perf_lab2/lib/printf.c:35
bfc09ed8:	8e440000 	lw	a0,0(s2)
bfc09edc:	2406000a 	li	a2,10
bfc09ee0:	0ff0281c 	jal	bfc0a070 <printbase>
bfc09ee4:	24070001 	li	a3,1
/mnt/perf_lab2/lib/printf.c:36
bfc09ee8:	26520004 	addiu	s2,s2,4
/mnt/perf_lab2/lib/printf.c:37
bfc09eec:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09ef0:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:25
bfc09ef4:	8e440000 	lw	a0,0(s2)
bfc09ef8:	0ff027e1 	jal	bfc09f84 <putchar>
bfc09efc:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:26
bfc09f00:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09f04:	26520004 	addiu	s2,s2,4
/mnt/perf_lab2/lib/printf.c:50
bfc09f08:	8e440000 	lw	a0,0(s2)
bfc09f0c:	24060002 	li	a2,2
bfc09f10:	0ff0281c 	jal	bfc0a070 <printbase>
bfc09f14:	00003821 	move	a3,zero
/mnt/perf_lab2/lib/printf.c:51
bfc09f18:	26520004 	addiu	s2,s2,4
/mnt/perf_lab2/lib/printf.c:52
bfc09f1c:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09f20:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:61
bfc09f24:	0ff027e1 	jal	bfc09f84 <putchar>
bfc09f28:	24040025 	li	a0,37
/mnt/perf_lab2/lib/printf.c:62
bfc09f2c:	0bf02765 	j	bfc09d94 <printf+0x74>
bfc09f30:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printf.c:67
bfc09f34:	02713021 	addu	a2,s3,s1
/mnt/perf_lab2/lib/printf.c:68
bfc09f38:	000510c0 	sll	v0,a1,0x3
bfc09f3c:	00051840 	sll	v1,a1,0x1
bfc09f40:	00621821 	addu	v1,v1,v0
bfc09f44:	00641821 	addu	v1,v1,a0
/mnt/perf_lab2/lib/printf.c:67
bfc09f48:	80c40002 	lb	a0,2(a2)
/mnt/perf_lab2/lib/printf.c:68
bfc09f4c:	2465ffd0 	addiu	a1,v1,-48
/mnt/perf_lab2/lib/printf.c:67
bfc09f50:	2482ffcf 	addiu	v0,a0,-49
bfc09f54:	304200ff 	andi	v0,v0,0xff
bfc09f58:	2c420009 	sltiu	v0,v0,9
bfc09f5c:	26310001 	addiu	s1,s1,1
bfc09f60:	1040ff9f 	beqz	v0,bfc09de0 <printf+0xc0>
bfc09f64:	24c60001 	addiu	a2,a2,1
/mnt/perf_lab2/lib/printf.c:68
bfc09f68:	0bf027cf 	j	bfc09f3c <printf+0x21c>
bfc09f6c:	000510c0 	sll	v0,a1,0x3

bfc09f70 <tgt_putchar>:
tgt_putchar():
/mnt/perf_lab2/lib/putchar.c:9
bfc09f70:	3c19bfb0 	lui	t9,0xbfb0
bfc09f74:	03e00008 	jr	ra
bfc09f78:	a324fff0 	sb	a0,-16(t9)
/mnt/perf_lab2/lib/putchar.c:18
bfc09f7c:	03e00008 	jr	ra
bfc09f80:	00000000 	nop

bfc09f84 <putchar>:
putchar():
/mnt/perf_lab2/lib/putchar.c:2
bfc09f84:	27bdffe8 	addiu	sp,sp,-24
bfc09f88:	afbf0014 	sw	ra,20(sp)
/mnt/perf_lab2/lib/putchar.c:3
bfc09f8c:	0ff027dc 	jal	bfc09f70 <tgt_putchar>
bfc09f90:	00000000 	nop
/mnt/perf_lab2/lib/putchar.c:5
bfc09f94:	8fbf0014 	lw	ra,20(sp)
bfc09f98:	00001021 	move	v0,zero
bfc09f9c:	03e00008 	jr	ra
bfc09fa0:	27bd0018 	addiu	sp,sp,24
	...

bfc09fb0 <putstring>:
putstring():
/mnt/perf_lab2/lib/puts.c:2
bfc09fb0:	27bdffe0 	addiu	sp,sp,-32
bfc09fb4:	afb10014 	sw	s1,20(sp)
bfc09fb8:	afbf001c 	sw	ra,28(sp)
bfc09fbc:	afb20018 	sw	s2,24(sp)
bfc09fc0:	afb00010 	sw	s0,16(sp)
/mnt/perf_lab2/lib/puts.c:4
bfc09fc4:	80900000 	lb	s0,0(a0)
bfc09fc8:	00000000 	nop
bfc09fcc:	12000013 	beqz	s0,bfc0a01c <putstring+0x6c>
bfc09fd0:	00808821 	move	s1,a0
/mnt/perf_lab2/lib/puts.c:6
bfc09fd4:	0bf027fd 	j	bfc09ff4 <putstring+0x44>
bfc09fd8:	2412000a 	li	s2,10
/mnt/perf_lab2/lib/puts.c:7
bfc09fdc:	0ff027e1 	jal	bfc09f84 <putchar>
bfc09fe0:	02002021 	move	a0,s0
/mnt/perf_lab2/lib/puts.c:4
bfc09fe4:	82300000 	lb	s0,0(s1)
bfc09fe8:	00000000 	nop
bfc09fec:	1200000b 	beqz	s0,bfc0a01c <putstring+0x6c>
bfc09ff0:	00000000 	nop
/mnt/perf_lab2/lib/puts.c:6
bfc09ff4:	1612fff9 	bne	s0,s2,bfc09fdc <putstring+0x2c>
bfc09ff8:	26310001 	addiu	s1,s1,1
bfc09ffc:	0ff027e1 	jal	bfc09f84 <putchar>
bfc0a000:	2404000d 	li	a0,13
/mnt/perf_lab2/lib/puts.c:7
bfc0a004:	0ff027e1 	jal	bfc09f84 <putchar>
bfc0a008:	02002021 	move	a0,s0
/mnt/perf_lab2/lib/puts.c:4
bfc0a00c:	82300000 	lb	s0,0(s1)
bfc0a010:	00000000 	nop
bfc0a014:	1600fff7 	bnez	s0,bfc09ff4 <putstring+0x44>
bfc0a018:	00000000 	nop
/mnt/perf_lab2/lib/puts.c:11
bfc0a01c:	8fbf001c 	lw	ra,28(sp)
bfc0a020:	00001021 	move	v0,zero
bfc0a024:	8fb20018 	lw	s2,24(sp)
bfc0a028:	8fb10014 	lw	s1,20(sp)
bfc0a02c:	8fb00010 	lw	s0,16(sp)
bfc0a030:	03e00008 	jr	ra
bfc0a034:	27bd0020 	addiu	sp,sp,32

bfc0a038 <puts>:
puts():
/mnt/perf_lab2/lib/puts.c:15
bfc0a038:	27bdffe8 	addiu	sp,sp,-24
bfc0a03c:	afbf0014 	sw	ra,20(sp)
/mnt/perf_lab2/lib/puts.c:16
bfc0a040:	0ff027ec 	jal	bfc09fb0 <putstring>
bfc0a044:	00000000 	nop
/mnt/perf_lab2/lib/puts.c:17
bfc0a048:	0ff027e1 	jal	bfc09f84 <putchar>
bfc0a04c:	2404000d 	li	a0,13
/mnt/perf_lab2/lib/puts.c:18
bfc0a050:	0ff027e1 	jal	bfc09f84 <putchar>
bfc0a054:	2404000a 	li	a0,10
/mnt/perf_lab2/lib/puts.c:20
bfc0a058:	8fbf0014 	lw	ra,20(sp)
bfc0a05c:	00001021 	move	v0,zero
bfc0a060:	03e00008 	jr	ra
bfc0a064:	27bd0018 	addiu	sp,sp,24
	...

bfc0a070 <printbase>:
printbase():
/mnt/perf_lab2/lib/printbase.c:2
bfc0a070:	27bdff98 	addiu	sp,sp,-104
bfc0a074:	afb30060 	sw	s3,96(sp)
bfc0a078:	afb2005c 	sw	s2,92(sp)
bfc0a07c:	afbf0064 	sw	ra,100(sp)
bfc0a080:	afb10058 	sw	s1,88(sp)
bfc0a084:	afb00054 	sw	s0,84(sp)
bfc0a088:	00801821 	move	v1,a0
bfc0a08c:	00a09821 	move	s3,a1
/mnt/perf_lab2/lib/printbase.c:7
bfc0a090:	10e00003 	beqz	a3,bfc0a0a0 <printbase+0x30>
bfc0a094:	00c09021 	move	s2,a2
bfc0a098:	0480002f 	bltz	a0,bfc0a158 <printbase+0xe8>
bfc0a09c:	2404002d 	li	a0,45
/mnt/perf_lab2/lib/printbase.c:12
bfc0a0a0:	00608021 	move	s0,v1
/mnt/perf_lab2/lib/printbase.c:14
bfc0a0a4:	1200000c 	beqz	s0,bfc0a0d8 <printbase+0x68>
bfc0a0a8:	00008821 	move	s1,zero
bfc0a0ac:	27a50010 	addiu	a1,sp,16
/mnt/perf_lab2/lib/printbase.c:16
bfc0a0b0:	16400002 	bnez	s2,bfc0a0bc <printbase+0x4c>
bfc0a0b4:	0212001b 	divu	zero,s0,s2
bfc0a0b8:	0007000d 	break	0x7
bfc0a0bc:	00b12021 	addu	a0,a1,s1
/mnt/perf_lab2/lib/printbase.c:14
bfc0a0c0:	26310001 	addiu	s1,s1,1
/mnt/perf_lab2/lib/printbase.c:16
bfc0a0c4:	00001010 	mfhi	v0
bfc0a0c8:	a0820000 	sb	v0,0(a0)
bfc0a0cc:	00001812 	mflo	v1
/mnt/perf_lab2/lib/printbase.c:14
bfc0a0d0:	1460fff7 	bnez	v1,bfc0a0b0 <printbase+0x40>
bfc0a0d4:	00608021 	move	s0,v1
/mnt/perf_lab2/lib/printbase.c:22
bfc0a0d8:	0233102a 	slt	v0,s1,s3
bfc0a0dc:	10400002 	beqz	v0,bfc0a0e8 <printbase+0x78>
bfc0a0e0:	02201821 	move	v1,s1
bfc0a0e4:	02601821 	move	v1,s3
bfc0a0e8:	1060000c 	beqz	v1,bfc0a11c <printbase+0xac>
bfc0a0ec:	2470ffff 	addiu	s0,v1,-1
/mnt/perf_lab2/lib/printbase.c:2
bfc0a0f0:	27a20010 	addiu	v0,sp,16
bfc0a0f4:	00509021 	addu	s2,v0,s0
/mnt/perf_lab2/lib/printbase.c:24
bfc0a0f8:	26020001 	addiu	v0,s0,1
bfc0a0fc:	0222102a 	slt	v0,s1,v0
bfc0a100:	1040000e 	beqz	v0,bfc0a13c <printbase+0xcc>
bfc0a104:	24040030 	li	a0,48
/mnt/perf_lab2/lib/printbase.c:25
bfc0a108:	02009821 	move	s3,s0
bfc0a10c:	0ff027e1 	jal	bfc09f84 <putchar>
bfc0a110:	2610ffff 	addiu	s0,s0,-1
/mnt/perf_lab2/lib/printbase.c:22
bfc0a114:	1660fff8 	bnez	s3,bfc0a0f8 <printbase+0x88>
bfc0a118:	2652ffff 	addiu	s2,s2,-1
/mnt/perf_lab2/lib/printbase.c:28
bfc0a11c:	8fbf0064 	lw	ra,100(sp)
bfc0a120:	00001021 	move	v0,zero
bfc0a124:	8fb30060 	lw	s3,96(sp)
bfc0a128:	8fb2005c 	lw	s2,92(sp)
bfc0a12c:	8fb10058 	lw	s1,88(sp)
bfc0a130:	8fb00054 	lw	s0,84(sp)
bfc0a134:	03e00008 	jr	ra
bfc0a138:	27bd0068 	addiu	sp,sp,104
/mnt/perf_lab2/lib/printbase.c:24
bfc0a13c:	82440000 	lb	a0,0(s2)
bfc0a140:	00000000 	nop
/mnt/perf_lab2/lib/printbase.c:25
bfc0a144:	2882000a 	slti	v0,a0,10
bfc0a148:	14400007 	bnez	v0,bfc0a168 <printbase+0xf8>
bfc0a14c:	02009821 	move	s3,s0
bfc0a150:	0bf02843 	j	bfc0a10c <printbase+0x9c>
bfc0a154:	24840057 	addiu	a0,a0,87
/mnt/perf_lab2/lib/printbase.c:10
bfc0a158:	0ff027e1 	jal	bfc09f84 <putchar>
bfc0a15c:	00038023 	negu	s0,v1
bfc0a160:	0bf02829 	j	bfc0a0a4 <printbase+0x34>
bfc0a164:	00000000 	nop
/mnt/perf_lab2/lib/printbase.c:25
bfc0a168:	0bf02842 	j	bfc0a108 <printbase+0x98>
bfc0a16c:	24840030 	addiu	a0,a0,48

bfc0a170 <_get_count>:
_get_count():
/mnt/perf_lab2/lib/time.c:14
bfc0a170:	3c19bfb0 	lui	t9,0xbfb0
bfc0a174:	8f22e000 	lw	v0,-8192(t9)
bfc0a178:	03e00008 	jr	ra
bfc0a17c:	00000000 	nop

bfc0a180 <get_count>:
get_count():
/mnt/perf_lab2/lib/time.c:19
bfc0a180:	3c19bfb0 	lui	t9,0xbfb0
bfc0a184:	8f22e000 	lw	v0,-8192(t9)
bfc0a188:	03e00008 	jr	ra
bfc0a18c:	00000000 	nop

bfc0a190 <get_clock>:
get_clock():
/mnt/perf_lab2/lib/time.c:38
bfc0a190:	3c19bfb0 	lui	t9,0xbfb0
bfc0a194:	8f22e000 	lw	v0,-8192(t9)
bfc0a198:	03e00008 	jr	ra
bfc0a19c:	00000000 	nop

bfc0a1a0 <get_ns>:
_get_count():
/mnt/perf_lab2/lib/time.c:6
bfc0a1a0:	3c19bfb0 	lui	t9,0xbfb0
bfc0a1a4:	8f22e000 	lw	v0,-8192(t9)
bfc0a1a8:	00000000 	nop
bfc0a1ac:	000218c0 	sll	v1,v0,0x3
bfc0a1b0:	00021040 	sll	v0,v0,0x1
get_ns():
/mnt/perf_lab2/lib/time.c:46
bfc0a1b4:	03e00008 	jr	ra
bfc0a1b8:	00431021 	addu	v0,v0,v1

bfc0a1bc <clock_gettime>:
clock_gettime():
/mnt/perf_lab2/lib/time.c:22
bfc0a1bc:	27bdffe8 	addiu	sp,sp,-24
bfc0a1c0:	afbf0014 	sw	ra,20(sp)
bfc0a1c4:	00a05021 	move	t2,a1
_get_count():
/mnt/perf_lab2/lib/time.c:6
bfc0a1c8:	3c19bfb0 	lui	t9,0xbfb0
bfc0a1cc:	8f26e000 	lw	a2,-8192(t9)
clock_gettime():
/mnt/perf_lab2/lib/time.c:27
bfc0a1d0:	3c030001 	lui	v1,0x1
bfc0a1d4:	346386a0 	ori	v1,v1,0x86a0
bfc0a1d8:	14600002 	bnez	v1,bfc0a1e4 <clock_gettime+0x28>
bfc0a1dc:	00c3001b 	divu	zero,a2,v1
bfc0a1e0:	0007000d 	break	0x7
/mnt/perf_lab2/lib/time.c:26
bfc0a1e4:	24080064 	li	t0,100
/mnt/perf_lab2/lib/time.c:28
bfc0a1e8:	3c054876 	lui	a1,0x4876
bfc0a1ec:	34a5e800 	ori	a1,a1,0xe800
/mnt/perf_lab2/lib/time.c:25
bfc0a1f0:	000610c0 	sll	v0,a2,0x3
bfc0a1f4:	00063840 	sll	a3,a2,0x1
bfc0a1f8:	00e23821 	addu	a3,a3,v0
bfc0a1fc:	240203e8 	li	v0,1000
/mnt/perf_lab2/lib/time.c:29
bfc0a200:	3c048000 	lui	a0,0x8000
bfc0a204:	24840990 	addiu	a0,a0,2448
/mnt/perf_lab2/lib/time.c:27
bfc0a208:	00001812 	mflo	v1
bfc0a20c:	00000000 	nop
/mnt/perf_lab2/lib/time.c:26
bfc0a210:	15000002 	bnez	t0,bfc0a21c <clock_gettime+0x60>
bfc0a214:	00c8001b 	divu	zero,a2,t0
bfc0a218:	0007000d 	break	0x7
bfc0a21c:	00004012 	mflo	t0
bfc0a220:	00000000 	nop
/mnt/perf_lab2/lib/time.c:28
bfc0a224:	14a00002 	bnez	a1,bfc0a230 <clock_gettime+0x74>
bfc0a228:	00c5001b 	divu	zero,a2,a1
bfc0a22c:	0007000d 	break	0x7
bfc0a230:	00003012 	mflo	a2
bfc0a234:	ad460000 	sw	a2,0(t2)
/mnt/perf_lab2/lib/time.c:27
bfc0a238:	14400002 	bnez	v0,bfc0a244 <clock_gettime+0x88>
bfc0a23c:	0062001b 	divu	zero,v1,v0
bfc0a240:	0007000d 	break	0x7
bfc0a244:	00004810 	mfhi	t1
bfc0a248:	ad49000c 	sw	t1,12(t2)
/mnt/perf_lab2/lib/time.c:25
bfc0a24c:	14400002 	bnez	v0,bfc0a258 <clock_gettime+0x9c>
bfc0a250:	00e2001b 	divu	zero,a3,v0
bfc0a254:	0007000d 	break	0x7
bfc0a258:	00002810 	mfhi	a1
bfc0a25c:	ad450004 	sw	a1,4(t2)
/mnt/perf_lab2/lib/time.c:26
bfc0a260:	14400002 	bnez	v0,bfc0a26c <clock_gettime+0xb0>
bfc0a264:	0102001b 	divu	zero,t0,v0
bfc0a268:	0007000d 	break	0x7
bfc0a26c:	00001810 	mfhi	v1
/mnt/perf_lab2/lib/time.c:29
bfc0a270:	0ff02748 	jal	bfc09d20 <printf>
bfc0a274:	ad430008 	sw	v1,8(t2)
/mnt/perf_lab2/lib/time.c:31
bfc0a278:	8fbf0014 	lw	ra,20(sp)
bfc0a27c:	00001021 	move	v0,zero
bfc0a280:	03e00008 	jr	ra
bfc0a284:	27bd0018 	addiu	sp,sp,24
	...

Disassembly of section .data:

80000000 <list_known_crc-0x6a0>:
80000000:	65726f63 	0x65726f63
80000004:	6b72616d 	0x6b72616d
80000008:	73657420 	0x73657420
8000000c:	65622074 	0x65622074
80000010:	2e6e6967 	sltiu	t6,s3,26983
80000014:	00000000 	nop
80000018:	65726f63 	0x65726f63
8000001c:	6b72616d 	0x6b72616d
80000020:	53415020 	0x53415020
80000024:	00002153 	0x2153
80000028:	65726f63 	0x65726f63
8000002c:	6b72616d 	0x6b72616d
80000030:	52524520 	0x52524520
80000034:	2121524f 	addi	at,t1,21071
80000038:	00000021 	move	zero,zero
8000003c:	20677261 	addi	a3,v1,29281
80000040:	6c25203a 	0x6c25203a
80000044:	25202c64 	addiu	zero,t1,11364
80000048:	202c646c 	addi	t4,at,25708
8000004c:	2c646c25 	sltiu	a0,v1,27685
80000050:	646c2520 	0x646c2520
80000054:	6c25202c 	0x6c25202c
80000058:	25202c64 	addiu	zero,t1,11364
8000005c:	202c646c 	addi	t4,at,25708
80000060:	20646c25 	addi	a0,v1,27685
80000064:	0000000a 	0xa
80000068:	74736574 	jalx	81cd95d0 <_gp+0x1cd0c00>
8000006c:	61747320 	0x61747320
80000070:	00007472 	0x7472
80000074:	5f746567 	0x5f746567
80000078:	6520736e 	0x6520736e
8000007c:	726f7272 	0x726f7272
80000080:	00002021 	move	a0,zero
80000084:	706d6f63 	0x706d6f63
80000088:	74617475 	jalx	8185d1d4 <_gp+0x1854804>
8000008c:	206e6f69 	addi	t6,v1,28521
80000090:	656e6f64 	0x656e6f64
80000094:	00000020 	add	zero,zero,zero
80000098:	70206b36 	0x70206b36
8000009c:	6f667265 	0x6f667265
800000a0:	6e616d72 	0x6e616d72
800000a4:	72206563 	0x72206563
800000a8:	70206e75 	0x70206e75
800000ac:	6d617261 	0x6d617261
800000b0:	72657465 	0x72657465
800000b4:	6f662073 	0x6f662073
800000b8:	6f632072 	0x6f632072
800000bc:	616d6572 	0x616d6572
800000c0:	002e6b72 	0x2e6b72
800000c4:	76206b36 	jalx	8881acd8 <_gp+0x8812308>
800000c8:	64696c61 	0x64696c61
800000cc:	6f697461 	0x6f697461
800000d0:	7572206e 	jalx	85c881b8 <_gp+0x5c7f7e8>
800000d4:	6170206e 	0x6170206e
800000d8:	656d6172 	0x656d6172
800000dc:	73726574 	0x73726574
800000e0:	726f6620 	0x726f6620
800000e4:	726f6320 	0x726f6320
800000e8:	72616d65 	0x72616d65
800000ec:	00002e6b 	0x2e6b
800000f0:	666f7250 	0x666f7250
800000f4:	20656c69 	addi	a1,v1,27753
800000f8:	656e6567 	0x656e6567
800000fc:	69746172 	0x69746172
80000100:	72206e6f 	0x72206e6f
80000104:	70206e75 	0x70206e75
80000108:	6d617261 	0x6d617261
8000010c:	72657465 	0x72657465
80000110:	6f662073 	0x6f662073
80000114:	6f632072 	0x6f632072
80000118:	616d6572 	0x616d6572
8000011c:	002e6b72 	0x2e6b72
80000120:	70204b32 	0x70204b32
80000124:	6f667265 	0x6f667265
80000128:	6e616d72 	0x6e616d72
8000012c:	72206563 	0x72206563
80000130:	70206e75 	0x70206e75
80000134:	6d617261 	0x6d617261
80000138:	72657465 	0x72657465
8000013c:	6f662073 	0x6f662073
80000140:	6f632072 	0x6f632072
80000144:	616d6572 	0x616d6572
80000148:	002e6b72 	0x2e6b72
8000014c:	76204b32 	jalx	88812cc8 <_gp+0x880a2f8>
80000150:	64696c61 	0x64696c61
80000154:	6f697461 	0x6f697461
80000158:	7572206e 	jalx	85c881b8 <_gp+0x5c7f7e8>
8000015c:	6170206e 	0x6170206e
80000160:	656d6172 	0x656d6172
80000164:	73726574 	0x73726574
80000168:	726f6620 	0x726f6620
8000016c:	726f6320 	0x726f6320
80000170:	72616d65 	0x72616d65
80000174:	00002e6b 	0x2e6b
80000178:	5d75255b 	0x5d75255b
8000017c:	4f525245 	c3	0x1525245
80000180:	6c202152 	0x6c202152
80000184:	20747369 	addi	s4,v1,29545
80000188:	20637263 	addi	v1,v1,29283
8000018c:	30257830 	andi	a1,at,0x7830
80000190:	2d207834 	sltiu	zero,t1,30772
80000194:	6f687320 	0x6f687320
80000198:	20646c75 	addi	a0,v1,27765
8000019c:	30206562 	andi	zero,at,0x6562
800001a0:	34302578 	ori	s0,at,0x2578
800001a4:	00000a78 	0xa78
800001a8:	5d75255b 	0x5d75255b
800001ac:	4f525245 	c3	0x1525245
800001b0:	6d202152 	0x6d202152
800001b4:	69727461 	0x69727461
800001b8:	72632078 	0x72632078
800001bc:	78302063 	0x78302063
800001c0:	78343025 	0x78343025
800001c4:	73202d20 	0x73202d20
800001c8:	6c756f68 	0x6c756f68
800001cc:	65622064 	0x65622064
800001d0:	25783020 	addiu	t8,t3,12320
800001d4:	0a783430 	j	89e0d0c0 <_gp+0x9e046f0>
800001d8:	00000000 	nop
800001dc:	5d75255b 	0x5d75255b
800001e0:	4f525245 	c3	0x1525245
800001e4:	73202152 	0x73202152
800001e8:	65746174 	0x65746174
800001ec:	63726320 	0x63726320
800001f0:	25783020 	addiu	t8,t3,12320
800001f4:	20783430 	addi	t8,v1,13360
800001f8:	6873202d 	0x6873202d
800001fc:	646c756f 	0x646c756f
80000200:	20656220 	addi	a1,v1,25120
80000204:	30257830 	andi	a1,at,0x7830
80000208:	000a7834 	0xa7834
8000020c:	65726f43 	0x65726f43
80000210:	6b72614d 	0x6b72614d
80000214:	7a695320 	0x7a695320
80000218:	20202065 	addi	zero,at,8293
8000021c:	25203a20 	addiu	zero,t1,14880
80000220:	000a756c 	0xa756c
80000224:	61746f54 	0x61746f54
80000228:	736e206c 	0x736e206c
8000022c:	25203a20 	addiu	zero,t1,14880
80000230:	000a756c 	0xa756c
80000234:	72657449 	0x72657449
80000238:	6f697461 	0x6f697461
8000023c:	312f736e 	andi	t7,t1,0x736e
80000240:	53303030 	0x53303030
80000244:	3a206365 	xori	zero,s1,0x6365
80000248:	756c2520 	jalx	85b09480 <_gp+0x5b00ab0>
8000024c:	0000000a 	0xa
80000250:	20656854 	addi	a1,v1,26708
80000254:	20555043 	addi	s5,v0,20547
80000258:	71657246 	0x71657246
8000025c:	756f7920 	jalx	85bde480 <_gp+0x5bd5ab0>
80000260:	74657320 	jalx	8195cc80 <_gp+0x19542b0>
80000264:	20736920 	addi	s3,v1,26912
80000268:	4d756c25 	0x4d756c25
8000026c:	000a7a48 	0xa7a48
80000270:	43206f53 	c0	0x1206f53
80000274:	4d45524f 	0x4d45524f
80000278:	2f4b5241 	sltiu	t3,k0,21057
8000027c:	205a484d 	addi	k0,v0,18509
80000280:	6c25203a 	0x6c25203a
80000284:	30312f75 	andi	s1,at,0x2f75
80000288:	000a3030 	0xa3030
8000028c:	45524f43 	0x45524f43
80000290:	4b52414d 	c2	0x152414d
80000294:	5a484d2f 	0x5a484d2f
80000298:	28203d20 	slti	zero,at,15648
8000029c:	30303031 	andi	s0,at,0x3031
800002a0:	2e303030 	sltiu	s0,s1,12336
800002a4:	50432f30 	0x50432f30
800002a8:	4f435f55 	c3	0x1435f55
800002ac:	5f544e55 	0x5f544e55
800002b0:	5f524550 	0x5f524550
800002b4:	2a295355 	slti	t1,s1,21333
800002b8:	4345534e 	c0	0x145534e
800002bc:	5245505f 	0x5245505f
800002c0:	4553555f 	0x4553555f
800002c4:	65722a43 	0x65722a43
800002c8:	746c7573 	jalx	81b1d5cc <_gp+0x1b14bfc>
800002cc:	5d305b73 	0x5d305b73
800002d0:	6574692e 	0x6574692e
800002d4:	69746172 	0x69746172
800002d8:	2f736e6f 	sltiu	s3,k1,28271
800002dc:	61746f74 	0x61746f74
800002e0:	736e5f6c 	0x736e5f6c
800002e4:	00000000 	nop
800002e8:	65207449 	0x65207449
800002ec:	6c617571 	0x6c617571
800002f0:	6f742073 	0x6f742073
800002f4:	30303120 	andi	s0,at,0x3120
800002f8:	7a484d30 	0x7a484d30
800002fc:	5550432f 	0x5550432f
80000300:	6572465f 	0x6572465f
80000304:	484d2871 	0x484d2871
80000308:	2a20297a 	slti	zero,s1,10618
8000030c:	30303120 	andi	s0,at,0x3120
80000310:	30312a30 	andi	s1,at,0x2a30
80000314:	692a3030 	0x692a3030
80000318:	61726574 	0x61726574
8000031c:	6e6f6974 	0x6e6f6974
80000320:	746f742f 	jalx	81bdd0bc <_gp+0x1bd46ec>
80000324:	6e5f6c61 	0x6e5f6c61
80000328:	00000073 	0x73
8000032c:	61207449 	0x61207449
80000330:	206f736c 	addi	t7,v1,29548
80000334:	61757165 	0x61757165
80000338:	7420736c 	jalx	8081cdb0 <_gp+0x8143e0>
8000033c:	4928206f 	0x4928206f
80000340:	61726574 	0x61726574
80000344:	6e6f6974 	0x6e6f6974
80000348:	30312f73 	andi	s1,at,0x2f73
8000034c:	65533030 	0x65533030
80000350:	432f2963 	c0	0x12f2963
80000354:	465f5550 	c1	0x5f5550
80000358:	28716572 	slti	s1,v1,25970
8000035c:	297a484d 	slti	k0,t3,18509
80000360:	3030312f 	andi	s0,at,0x312f
80000364:	00000030 	0x30
80000368:	74206e49 	jalx	8081b924 <_gp+0x812f54>
8000036c:	20736968 	addi	s3,v1,26984
80000370:	2c6e7572 	sltiu	t6,v1,30066
80000374:	65746920 	0x65746920
80000378:	65746172 	0x65746172
8000037c:	756c253d 	jalx	85b094f4 <_gp+0x5b00b24>
80000380:	6f74202c 	0x6f74202c
80000384:	5f6c6174 	0x5f6c6174
80000388:	253d736e 	addiu	sp,t1,29550
8000038c:	0a0a756c 	j	8829d5b0 <_gp+0x8294be0>
80000390:	00000000 	nop
80000394:	61746f54 	0x61746f54
80000398:	6974206c 	0x6974206c
8000039c:	20736b63 	addi	s3,v1,27491
800003a0:	20202020 	addi	zero,at,8224
800003a4:	25203a20 	addiu	zero,t1,14880
800003a8:	000a756c 	0xa756c
800003ac:	6e697270 	0x6e697270
800003b0:	74206674 	jalx	808199d0 <_gp+0x811000>
800003b4:	6c61746f 	0x6c61746f
800003b8:	20736e5f 	addi	s3,v1,28255
800003bc:	6f727265 	0x6f727265
800003c0:	00202172 	0x202172
800003c4:	72657449 	0x72657449
800003c8:	6f697461 	0x6f697461
800003cc:	2020736e 	addi	zero,at,29550
800003d0:	20202020 	addi	zero,at,8224
800003d4:	25203a20 	addiu	zero,t1,14880
800003d8:	000a756c 	0xa756c
800003dc:	706d6f43 	0x706d6f43
800003e0:	72656c69 	0x72656c69
800003e4:	72657620 	0x72657620
800003e8:	6e6f6973 	0x6e6f6973
800003ec:	25203a20 	addiu	zero,t1,14880
800003f0:	00000a73 	0xa73
800003f4:	34434347 	ori	v1,v0,0x4347
800003f8:	302e332e 	andi	t6,at,0x332e
800003fc:	00000000 	nop
80000400:	706d6f43 	0x706d6f43
80000404:	72656c69 	0x72656c69
80000408:	616c6620 	0x616c6620
8000040c:	20207367 	addi	zero,at,29543
80000410:	25203a20 	addiu	zero,t1,14880
80000414:	00000a73 	0xa73
80000418:	334f2d20 	andi	t7,k0,0x2d20
8000041c:	6e6d2d20 	0x6e6d2d20
80000420:	62612d6f 	0x62612d6f
80000424:	6c616369 	0x6c616369
80000428:	2d20736c 	sltiu	zero,t1,29548
8000042c:	726e7566 	0x726e7566
80000430:	2d6c6c6f 	sltiu	t4,t3,27759
80000434:	2d6c6c61 	sltiu	t4,t3,27745
80000438:	706f6f6c 	0x706f6f6c
8000043c:	662d2073 	0x662d2073
80000440:	67696c61 	0x67696c61
80000444:	756a2d6e 	jalx	85a8b5b8 <_gp+0x5a82be8>
80000448:	3d73706d 	0x3d73706d
8000044c:	2d203631 	sltiu	zero,t1,13873
80000450:	696c6166 	0x696c6166
80000454:	662d6e67 	0x662d6e67
80000458:	74636e75 	jalx	818db9d4 <_gp+0x18d3004>
8000045c:	736e6f69 	0x736e6f69
80000460:	2036313d 	addi	s6,at,12605
80000464:	6367662d 	0x6367662d
80000468:	732d6573 	0x732d6573
8000046c:	662d206d 	0x662d206d
80000470:	65736367 	0x65736367
80000474:	73616c2d 	0x73616c2d
80000478:	69662d20 	0x69662d20
8000047c:	6e696c6e 	0x6e696c6e
80000480:	75662d65 	jalx	8598b594 <_gp+0x5982bc4>
80000484:	6974636e 	0x6974636e
80000488:	20736e6f 	addi	s3,v1,28271
8000048c:	6e69662d 	0x6e69662d
80000490:	656e696c 	0x656e696c
80000494:	6d696c2d 	0x6d696c2d
80000498:	313d7469 	andi	sp,t1,0x7469
8000049c:	20303030 	addi	s0,at,12336
800004a0:	6f736d2d 	0x6f736d2d
800004a4:	662d7466 	0x662d7466
800004a8:	74616f6c 	jalx	8185bdb0 <_gp+0x18533e0>
800004ac:	4c452d20 	0x4c452d20
800004b0:	616d2d20 	0x616d2d20
800004b4:	3d686372 	0x3d686372
800004b8:	7370696d 	0x7370696d
800004bc:	6d2d2031 	0x6d2d2031
800004c0:	31737069 	andi	s3,t3,0x7069
800004c4:	00000000 	nop
800004c8:	6f6d654d 	0x6f6d654d
800004cc:	6c207972 	0x6c207972
800004d0:	7461636f 	jalx	81858dbc <_gp+0x18503ec>
800004d4:	206e6f69 	addi	t6,v1,28521
800004d8:	25203a20 	addiu	zero,t1,14880
800004dc:	00000a73 	0xa73
800004e0:	61656c50 	0x61656c50
800004e4:	70206573 	0x70206573
800004e8:	64207475 	0x64207475
800004ec:	20617461 	addi	at,v1,29793
800004f0:	6f6d656d 	0x6f6d656d
800004f4:	6c207972 	0x6c207972
800004f8:	7461636f 	jalx	81858dbc <_gp+0x18503ec>
800004fc:	206e6f69 	addi	t6,v1,28521
80000500:	65726568 	0x65726568
80000504:	0909090a 	j	84242428 <_gp+0x4239a58>
80000508:	672e6528 	0x672e6528
8000050c:	6f63202e 	0x6f63202e
80000510:	69206564 	0x69206564
80000514:	6c66206e 	0x6c66206e
80000518:	2c687361 	sltiu	t0,v1,29537
8000051c:	74616420 	jalx	81859080 <_gp+0x18506b0>
80000520:	6e6f2061 	0x6e6f2061
80000524:	61656820 	0x61656820
80000528:	74652070 	jalx	819481c0 <_gp+0x193f7f0>
8000052c:	00002963 	0x2963
80000530:	64656573 	0x64656573
80000534:	20637263 	addi	v1,v1,29283
80000538:	20202020 	addi	zero,at,8224
8000053c:	20202020 	addi	zero,at,8224
80000540:	30203a20 	andi	zero,at,0x3a20
80000544:	34302578 	ori	s0,at,0x2578
80000548:	00000a78 	0xa78
8000054c:	5d64255b 	0x5d64255b
80000550:	6c637263 	0x6c637263
80000554:	20747369 	addi	s4,v1,29545
80000558:	20202020 	addi	zero,at,8224
8000055c:	203a2020 	addi	k0,at,8224
80000560:	30257830 	andi	a1,at,0x7830
80000564:	000a7834 	0xa7834
80000568:	5d64255b 	0x5d64255b
8000056c:	6d637263 	0x6d637263
80000570:	69727461 	0x69727461
80000574:	20202078 	addi	zero,at,8312
80000578:	203a2020 	addi	k0,at,8224
8000057c:	30257830 	andi	a1,at,0x7830
80000580:	000a7834 	0xa7834
80000584:	5d64255b 	0x5d64255b
80000588:	73637263 	0x73637263
8000058c:	65746174 	0x65746174
80000590:	20202020 	addi	zero,at,8224
80000594:	203a2020 	addi	k0,at,8224
80000598:	30257830 	andi	a1,at,0x7830
8000059c:	000a7834 	0xa7834
800005a0:	5d64255b 	0x5d64255b
800005a4:	66637263 	0x66637263
800005a8:	6c616e69 	0x6c616e69
800005ac:	20202020 	addi	zero,at,8224
800005b0:	203a2020 	addi	k0,at,8224
800005b4:	30257830 	andi	a1,at,0x7830
800005b8:	000a7834 	0xa7834
800005bc:	72726f43 	0x72726f43
800005c0:	20746365 	addi	s4,v1,25445
800005c4:	7265706f 	0x7265706f
800005c8:	6f697461 	0x6f697461
800005cc:	6176206e 	0x6176206e
800005d0:	6164696c 	0x6164696c
800005d4:	2e646574 	sltiu	a0,s3,25972
800005d8:	65655320 	0x65655320
800005dc:	61657220 	0x61657220
800005e0:	2e656d64 	sltiu	a1,s3,28004
800005e4:	20747874 	addi	s4,v1,30836
800005e8:	20726f66 	addi	s2,v1,28518
800005ec:	206e7572 	addi	t6,v1,30066
800005f0:	20646e61 	addi	a0,v1,28257
800005f4:	6f706572 	0x6f706572
800005f8:	6e697472 	0x6e697472
800005fc:	75722067 	jalx	85c8819c <_gp+0x5c7f7cc>
80000600:	2e73656c 	sltiu	s3,s3,25964
80000604:	00000000 	nop
80000608:	6f727245 	0x6f727245
8000060c:	64207372 	0x64207372
80000610:	63657465 	0x63657465
80000614:	00646574 	0x646574
80000618:	6e6e6143 	0x6e6e6143
8000061c:	7620746f 	jalx	8881d1bc <_gp+0x88147ec>
80000620:	64696c61 	0x64696c61
80000624:	20657461 	addi	a1,v1,29793
80000628:	7265706f 	0x7265706f
8000062c:	6f697461 	0x6f697461
80000630:	6f66206e 	0x6f66206e
80000634:	68742072 	0x68742072
80000638:	20657365 	addi	a1,v1,29541
8000063c:	64656573 	0x64656573
80000640:	6c617620 	0x6c617620
80000644:	2c736575 	sltiu	s3,v1,25973
80000648:	656c7020 	0x656c7020
8000064c:	20657361 	addi	a1,v1,29537
80000650:	706d6f63 	0x706d6f63
80000654:	20657261 	addi	a1,v1,29281
80000658:	68746977 	0x68746977
8000065c:	73657220 	0x73657220
80000660:	73746c75 	0x73746c75
80000664:	206e6f20 	addi	t6,v1,28448
80000668:	6e6b2061 	0x6e6b2061
8000066c:	206e776f 	addi	t6,v1,30575
80000670:	74616c70 	jalx	8185b1c0 <_gp+0x18527f0>
80000674:	6d726f66 	0x6d726f66
80000678:	0000002e 	0x2e
8000067c:	74617453 	jalx	8185d14c <_gp+0x185477c>
80000680:	00006369 	0x6369
80000684:	70616548 	0x70616548
80000688:	00000000 	nop
8000068c:	63617453 	0x63617453
80000690:	0000006b 	0x6b
	...

800006a0 <list_known_crc>:
800006a0:	3340d4b0 	andi	zero,k0,0xd4b0
800006a4:	e7146a79 	swc1	$f20,27257(t8)
800006a8:	0000e3c1 	0xe3c1

800006ac <matrix_known_crc>:
800006ac:	1199be52 	beq	t4,t9,7ffefff8 <data_size+0x7ffef614>
800006b0:	1fd75608 	0x1fd75608
800006b4:	00000747 	0x747

800006b8 <state_known_crc>:
800006b8:	39bf5e47 	xori	ra,t5,0x5e47
800006bc:	8e3ae5a4 	lw	k0,-6748(s1)
800006c0:	00008d84 	0x8d84
	...
800006d0:	bfc07170 	0xbfc07170
800006d4:	bfc07170 	0xbfc07170
800006d8:	bfc07170 	0xbfc07170
800006dc:	bfc07150 	0xbfc07150
800006e0:	bfc07150 	0xbfc07150
800006e4:	bfc07130 	0xbfc07130
800006e8:	bfc07130 	0xbfc07130
800006ec:	bfc06fe0 	0xbfc06fe0
800006f0:	bfc076a0 	0xbfc076a0
800006f4:	bfc076c4 	0xbfc076c4
800006f8:	bfc077e0 	0xbfc077e0
800006fc:	bfc07810 	0xbfc07810
80000700:	bfc077b0 	0xbfc077b0
80000704:	bfc07770 	0xbfc07770
80000708:	bfc07740 	0xbfc07740
8000070c:	bfc07710 	0xbfc07710
80000710:	bfc07bf0 	0xbfc07bf0
80000714:	bfc07a40 	0xbfc07a40
80000718:	bfc07c20 	0xbfc07c20
8000071c:	bfc07b90 	0xbfc07b90
80000720:	bfc07b60 	0xbfc07b60
80000724:	bfc07a10 	0xbfc07a10
80000728:	bfc07bc0 	0xbfc07bc0
8000072c:	bfc07ac0 	0xbfc07ac0
80000730:	bfc07ff0 	0xbfc07ff0
80000734:	bfc07de0 	0xbfc07de0
80000738:	bfc08080 	0xbfc08080
8000073c:	bfc08020 	0xbfc08020
80000740:	bfc08050 	0xbfc08050
80000744:	bfc07db0 	0xbfc07db0
80000748:	bfc07fc0 	0xbfc07fc0
8000074c:	bfc07e60 	0xbfc07e60

80000750 <intpat>:
80000750:	80000790 	lb	zero,1936(zero)
80000754:	80000798 	lb	zero,1944(zero)
80000758:	800007a0 	lb	zero,1952(zero)
8000075c:	800007a8 	lb	zero,1960(zero)

80000760 <floatpat>:
80000760:	800007b0 	lb	zero,1968(zero)
80000764:	800007bc 	lb	zero,1980(zero)
80000768:	800007c8 	lb	zero,1992(zero)
8000076c:	800007d4 	lb	zero,2004(zero)

80000770 <scipat>:
80000770:	800007e0 	lb	zero,2016(zero)
80000774:	800007ec 	lb	zero,2028(zero)
80000778:	800007f8 	lb	zero,2040(zero)
8000077c:	80000804 	lb	zero,2052(zero)

80000780 <errpat>:
80000780:	80000810 	lb	zero,2064(zero)
80000784:	8000081c 	lb	zero,2076(zero)
80000788:	80000828 	lb	zero,2088(zero)
8000078c:	80000834 	lb	zero,2100(zero)
80000790:	32313035 	andi	s1,s1,0x3035
80000794:	00000000 	nop
80000798:	34333231 	ori	s3,at,0x3231
8000079c:	00000000 	nop
800007a0:	3437382d 	ori	s7,at,0x382d
800007a4:	00000000 	nop
800007a8:	3232312b 	andi	s2,s1,0x312b
800007ac:	00000000 	nop
800007b0:	352e3533 	ori	t6,t1,0x3533
800007b4:	30303434 	andi	s0,at,0x3434
800007b8:	00000000 	nop
800007bc:	3332312e 	andi	s2,t9,0x312e
800007c0:	30303534 	andi	s0,at,0x3534
800007c4:	00000000 	nop
800007c8:	3031312d 	andi	s1,at,0x312d
800007cc:	3030372e 	andi	s0,at,0x372e
800007d0:	00000000 	nop
800007d4:	362e302b 	ori	t6,s1,0x302b
800007d8:	30303434 	andi	s0,at,0x3434
800007dc:	00000000 	nop
800007e0:	30352e35 	andi	s5,at,0x2e35
800007e4:	332b6530 	andi	t3,t9,0x6530
800007e8:	00000000 	nop
800007ec:	32312e2d 	andi	s1,s1,0x2e2d
800007f0:	322d6533 	andi	t5,s1,0x6533
800007f4:	00000000 	nop
800007f8:	6537382d 	0x6537382d
800007fc:	3233382b 	andi	s3,s1,0x382b
80000800:	00000000 	nop
80000804:	362e302b 	ori	t6,s1,0x302b
80000808:	32312d65 	andi	s1,s1,0x2d65
8000080c:	00000000 	nop
80000810:	332e3054 	andi	t6,t9,0x3054
80000814:	46312d65 	c1	0x312d65
80000818:	00000000 	nop
8000081c:	542e542d 	0x542e542d
80000820:	71542b2b 	0x71542b2b
80000824:	00000000 	nop
80000828:	2e335431 	sltiu	s3,s1,21553
8000082c:	7a346534 	0x7a346534
80000830:	00000000 	nop
80000834:	302e3433 	andi	t6,at,0x3433
80000838:	5e542d65 	0x5e542d65
8000083c:	00000000 	nop
80000840:	bfc09f24 	0xbfc09f24
80000844:	bfc09df4 	0xbfc09df4
80000848:	bfc09df4 	0xbfc09df4
8000084c:	bfc09df4 	0xbfc09df4
80000850:	bfc09df4 	0xbfc09df4
80000854:	bfc09df4 	0xbfc09df4
80000858:	bfc09df4 	0xbfc09df4
8000085c:	bfc09df4 	0xbfc09df4
80000860:	bfc09df4 	0xbfc09df4
80000864:	bfc09df4 	0xbfc09df4
80000868:	bfc09df4 	0xbfc09df4
8000086c:	bfc09e18 	0xbfc09e18
80000870:	bfc09e28 	0xbfc09e28
80000874:	bfc09e28 	0xbfc09e28
80000878:	bfc09e28 	0xbfc09e28
8000087c:	bfc09e28 	0xbfc09e28
80000880:	bfc09e28 	0xbfc09e28
80000884:	bfc09e28 	0xbfc09e28
80000888:	bfc09e28 	0xbfc09e28
8000088c:	bfc09e28 	0xbfc09e28
80000890:	bfc09e28 	0xbfc09e28
80000894:	bfc09df4 	0xbfc09df4
80000898:	bfc09df4 	0xbfc09df4
8000089c:	bfc09df4 	0xbfc09df4
800008a0:	bfc09df4 	0xbfc09df4
800008a4:	bfc09df4 	0xbfc09df4
800008a8:	bfc09df4 	0xbfc09df4
800008ac:	bfc09df4 	0xbfc09df4
800008b0:	bfc09df4 	0xbfc09df4
800008b4:	bfc09df4 	0xbfc09df4
800008b8:	bfc09df4 	0xbfc09df4
800008bc:	bfc09df4 	0xbfc09df4
800008c0:	bfc09df4 	0xbfc09df4
800008c4:	bfc09df4 	0xbfc09df4
800008c8:	bfc09df4 	0xbfc09df4
800008cc:	bfc09df4 	0xbfc09df4
800008d0:	bfc09df4 	0xbfc09df4
800008d4:	bfc09df4 	0xbfc09df4
800008d8:	bfc09df4 	0xbfc09df4
800008dc:	bfc09df4 	0xbfc09df4
800008e0:	bfc09df4 	0xbfc09df4
800008e4:	bfc09df4 	0xbfc09df4
800008e8:	bfc09df4 	0xbfc09df4
800008ec:	bfc09df4 	0xbfc09df4
800008f0:	bfc09df4 	0xbfc09df4
800008f4:	bfc09df4 	0xbfc09df4
800008f8:	bfc09df4 	0xbfc09df4
800008fc:	bfc09df4 	0xbfc09df4
80000900:	bfc09df4 	0xbfc09df4
80000904:	bfc09df4 	0xbfc09df4
80000908:	bfc09df4 	0xbfc09df4
8000090c:	bfc09df4 	0xbfc09df4
80000910:	bfc09df4 	0xbfc09df4
80000914:	bfc09df4 	0xbfc09df4
80000918:	bfc09df4 	0xbfc09df4
8000091c:	bfc09df4 	0xbfc09df4
80000920:	bfc09df4 	0xbfc09df4
80000924:	bfc09df4 	0xbfc09df4
80000928:	bfc09df4 	0xbfc09df4
8000092c:	bfc09df4 	0xbfc09df4
80000930:	bfc09df4 	0xbfc09df4
80000934:	bfc09f08 	0xbfc09f08
80000938:	bfc09ef4 	0xbfc09ef4
8000093c:	bfc09ed8 	0xbfc09ed8
80000940:	bfc09df4 	0xbfc09df4
80000944:	bfc09df4 	0xbfc09df4
80000948:	bfc09df4 	0xbfc09df4
8000094c:	bfc09df4 	0xbfc09df4
80000950:	bfc09df4 	0xbfc09df4
80000954:	bfc09df4 	0xbfc09df4
80000958:	bfc09df4 	0xbfc09df4
8000095c:	bfc09ebc 	0xbfc09ebc
80000960:	bfc09df4 	0xbfc09df4
80000964:	bfc09df4 	0xbfc09df4
80000968:	bfc09ea0 	0xbfc09ea0
8000096c:	bfc09e84 	0xbfc09e84
80000970:	bfc09df4 	0xbfc09df4
80000974:	bfc09df4 	0xbfc09df4
80000978:	bfc09e70 	0xbfc09e70
8000097c:	bfc09df4 	0xbfc09df4
80000980:	bfc09e54 	0xbfc09e54
80000984:	bfc09df4 	0xbfc09df4
80000988:	bfc09df4 	0xbfc09df4
8000098c:	bfc09e84 	0xbfc09e84
80000990:	636f6c63 	0x636f6c63
80000994:	736e206b 	0x736e206b
80000998:	2c64253d 	sltiu	a0,v1,9533
8000099c:	3d636573 	0x3d636573
800009a0:	000a6425 	0xa6425
800009a4:	b0007f00 	0xb0007f00
	...

800009bc <_fdata>:
_fdata():
800009bc:	00000000 	nop

800009c0 <mem_name>:
800009c0:	8000067c 	lb	zero,1660(zero)
800009c4:	80000684 	lb	zero,1668(zero)
800009c8:	8000068c 	lb	zero,1676(zero)
800009cc:	00000000 	nop

800009d0 <__CTOR_LIST__>:
	...

800009d8 <__CTOR_END__>:
	...

800009e0 <__DTOR_END__>:
__DTOR_END__():
800009e0:	00000001 	0x1

Disassembly of section .sbss:

800009e4 <stop_ns>:
800009e4:	00000000 	nop

800009e8 <total_ns>:
800009e8:	00000000 	nop

800009ec <int_tmp>:
800009ec:	00000000 	nop

800009f0 <start_ns>:
800009f0:	00000000 	nop

Disassembly of section .bss:

80000a00 <start_time_val>:
	...

80000a10 <stop_time_val>:
	...

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	0x1c
   4:	00000002 	srl	zero,zero,0x0
   8:	00040000 	sll	zero,a0,0x0
   c:	00000000 	nop
  10:	bfc00000 	0xbfc00000
  14:	0000038c 	syscall	0xe
	...
  20:	0000001c 	0x1c
  24:	00400002 	0x400002
  28:	00040000 	sll	zero,a0,0x0
  2c:	00000000 	nop
  30:	bfc09d20 	0xbfc09d20
  34:	00000250 	0x250
	...
  40:	0000001c 	0x1c
  44:	010d0002 	0x10d0002
  48:	00040000 	sll	zero,a0,0x0
  4c:	00000000 	nop
  50:	bfc09f70 	0xbfc09f70
  54:	00000034 	0x34
	...
  60:	0000001c 	0x1c
  64:	01990002 	0x1990002
  68:	00040000 	sll	zero,a0,0x0
  6c:	00000000 	nop
  70:	bfc09fb0 	0xbfc09fb0
  74:	000000b8 	0xb8
	...
  80:	0000001c 	0x1c
  84:	02480002 	0x2480002
  88:	00040000 	sll	zero,a0,0x0
  8c:	00000000 	nop
  90:	bfc0a070 	0xbfc0a070
  94:	00000100 	sll	zero,zero,0x4
	...
  a0:	0000001c 	0x1c
  a4:	03430002 	0x3430002
  a8:	00040000 	sll	zero,a0,0x0
  ac:	00000000 	nop
  b0:	bfc0a170 	0xbfc0a170
  b4:	00000118 	0x118
	...

Disassembly of section .debug_pubnames:

00000000 <.debug_pubnames>:
   0:	00000019 	multu	zero,zero
   4:	00400002 	0x400002
   8:	00cd0000 	0xcd0000
   c:	00350000 	0x350000
  10:	72700000 	0x72700000
  14:	66746e69 	0x66746e69
  18:	00000000 	nop
  1c:	00002a00 	sll	a1,zero,0x8
  20:	0d000200 	jal	4000800 <data_size+0x3fffe1c>
  24:	8c000001 	lw	zero,1(zero)
  28:	33000000 	andi	zero,t8,0x0
  2c:	74000000 	jalx	0 <data_size-0x9e4>
  30:	705f7467 	0x705f7467
  34:	68637475 	0x68637475
  38:	60007261 	0x60007261
  3c:	70000000 	0x70000000
  40:	68637475 	0x68637475
  44:	00007261 	0x7261
  48:	25000000 	addiu	zero,t0,0
  4c:	02000000 	0x2000000
  50:	00019900 	sll	s3,at,0x4
  54:	0000af00 	sll	s5,zero,0x1c
  58:	00003300 	sll	a2,zero,0xc
  5c:	74757000 	jalx	1d5c000 <data_size+0x1d5b61c>
  60:	69727473 	0x69727473
  64:	8300676e 	lb	zero,26478(t8)
  68:	70000000 	0x70000000
  6c:	00737475 	0x737475
  70:	00000000 	nop
  74:	0000001c 	0x1c
  78:	02480002 	0x2480002
  7c:	00fb0000 	0xfb0000
  80:	00330000 	0x330000
  84:	72700000 	0x72700000
  88:	62746e69 	0x62746e69
  8c:	00657361 	0x657361
  90:	00000000 	nop
  94:	00000056 	0x56
  98:	03430002 	0x3430002
  9c:	01c50000 	0x1c50000
  a0:	00a70000 	0xa70000
  a4:	675f0000 	0x675f0000
  a8:	635f7465 	0x635f7465
  ac:	746e756f 	jalx	1b9d5bc <data_size+0x1b9cbd8>
  b0:	0000c400 	sll	t8,zero,0x10
  b4:	74656700 	jalx	1959c00 <data_size+0x195921c>
  b8:	756f635f 	jalx	5bd8d7c <data_size+0x5bd8398>
  bc:	de00746e 	0xde00746e
  c0:	67000000 	0x67000000
  c4:	635f7465 	0x635f7465
  c8:	6b636f6c 	0x6b636f6c
  cc:	00010600 	sll	zero,at,0x18
  d0:	74656700 	jalx	1959c00 <data_size+0x195921c>
  d4:	00736e5f 	0x736e5f
  d8:	00000152 	0x152
  dc:	636f6c63 	0x636f6c63
  e0:	65675f6b 	0x65675f6b
  e4:	6d697474 	0x6d697474
  e8:	00000065 	0x65
	...

Disassembly of section .pdr:

00000000 <.pdr>:
   0:	bfc00390 	0xbfc00390
   4:	80030000 	lb	v1,0(zero)
   8:	fffffffc 	0xfffffffc
	...
  14:	00000030 	0x30
  18:	0000001d 	0x1d
  1c:	0000001f 	0x1f
  20:	bfc00470 	0xbfc00470
  24:	800f0000 	lb	t7,0(zero)
  28:	fffffffc 	0xfffffffc
	...
  34:	00000028 	0x28
  38:	0000001d 	0x1d
  3c:	0000001f 	0x1f
  40:	bfc00600 	0xbfc00600
  44:	c0ff0000 	lwc0	$31,0(a3)
  48:	fffffffc 	0xfffffffc
	...
  54:	00000868 	0x868
  58:	0000001d 	0x1d
  5c:	0000001f 	0x1f
  60:	bfc015c0 	0xbfc015c0
  64:	003f0000 	0x3f0000
  68:	fffffffc 	0xfffffffc
	...
  74:	00000018 	mult	zero,zero
  78:	0000001d 	0x1d
  7c:	0000001f 	0x1f
  80:	bfc019b0 	0xbfc019b0
	...
  98:	0000001d 	0x1d
  9c:	0000001f 	0x1f
  a0:	bfc01cf0 	0xbfc01cf0
  a4:	00070000 	sll	zero,a3,0x0
  a8:	fffffffc 	0xfffffffc
	...
  b4:	00000010 	mfhi	zero
  b8:	0000001d 	0x1d
  bc:	0000001f 	0x1f
  c0:	bfc01f30 	0xbfc01f30
	...
  d8:	0000001d 	0x1d
  dc:	0000001f 	0x1f
  e0:	bfc020d0 	0xbfc020d0
  e4:	40ff0000 	0x40ff0000
  e8:	fffffffc 	0xfffffffc
	...
  f4:	00000028 	0x28
  f8:	0000001d 	0x1d
  fc:	0000001f 	0x1f
 100:	bfc02380 	0xbfc02380
 104:	40ff0000 	0x40ff0000
 108:	fffffffc 	0xfffffffc
	...
 114:	00000038 	0x38
 118:	0000001d 	0x1d
 11c:	0000001f 	0x1f
 120:	bfc02680 	0xbfc02680
 124:	40ff0000 	0x40ff0000
 128:	fffffffc 	0xfffffffc
	...
 134:	00000028 	0x28
 138:	0000001d 	0x1d
 13c:	0000001f 	0x1f
 140:	bfc02920 	0xbfc02920
 144:	c0ff0000 	lwc0	$31,0(a3)
 148:	fffffffc 	0xfffffffc
	...
 154:	00000060 	0x60
 158:	0000001d 	0x1d
 15c:	0000001f 	0x1f
 160:	bfc04070 	0xbfc04070
 164:	c0ff0000 	lwc0	$31,0(a3)
 168:	fffffffc 	0xfffffffc
	...
 174:	00000068 	0x68
 178:	0000001d 	0x1d
 17c:	0000001f 	0x1f
 180:	bfc057b0 	0xbfc057b0
	...
 198:	0000001d 	0x1d
 19c:	0000001f 	0x1f
 1a0:	bfc05950 	0xbfc05950
	...
 1b8:	0000001d 	0x1d
 1bc:	0000001f 	0x1f
 1c0:	bfc05b80 	0xbfc05b80
	...
 1d8:	0000001d 	0x1d
 1dc:	0000001f 	0x1f
 1e0:	bfc05b90 	0xbfc05b90
	...
 1f8:	0000001d 	0x1d
 1fc:	0000001f 	0x1f
 200:	bfc06000 	0xbfc06000
	...
 218:	0000001d 	0x1d
 21c:	0000001f 	0x1f
 220:	bfc06470 	0xbfc06470
	...
 238:	0000001d 	0x1d
 23c:	0000001f 	0x1f
 240:	bfc06d60 	0xbfc06d60
	...
 258:	0000001d 	0x1d
 25c:	0000001f 	0x1f
 260:	bfc06f20 	0xbfc06f20
 264:	00ff0000 	0xff0000
 268:	fffffffc 	0xfffffffc
	...
 274:	00000020 	add	zero,zero,zero
 278:	0000001d 	0x1d
 27c:	0000001f 	0x1f
 280:	bfc07610 	0xbfc07610
 284:	001f0000 	sll	zero,ra,0x0
 288:	fffffffc 	0xfffffffc
	...
 294:	00000018 	mult	zero,zero
 298:	0000001d 	0x1d
 29c:	0000001f 	0x1f
 2a0:	bfc07940 	0xbfc07940
 2a4:	801f0000 	lb	ra,0(zero)
 2a8:	fffffffc 	0xfffffffc
	...
 2b4:	00000068 	0x68
 2b8:	0000001d 	0x1d
 2bc:	0000001f 	0x1f
 2c0:	bfc081d0 	0xbfc081d0
	...
 2d8:	0000001d 	0x1d
 2dc:	0000001f 	0x1f
 2e0:	bfc08240 	0xbfc08240
	...
 2f8:	0000001d 	0x1d
 2fc:	0000001f 	0x1f
 300:	bfc08260 	0xbfc08260
	...
 318:	0000001d 	0x1d
 31c:	0000001f 	0x1f
 320:	bfc082e0 	0xbfc082e0
	...
 338:	0000001d 	0x1d
 33c:	0000001f 	0x1f
 340:	bfc08310 	0xbfc08310
	...
 358:	0000001d 	0x1d
 35c:	0000001f 	0x1f
 360:	bfc08340 	0xbfc08340
	...
 378:	0000001d 	0x1d
 37c:	0000001f 	0x1f
 380:	bfc083f0 	0xbfc083f0
	...
 398:	0000001d 	0x1d
 39c:	0000001f 	0x1f
 3a0:	bfc084a0 	0xbfc084a0
 3a4:	c0ff0000 	lwc0	$31,0(a3)
 3a8:	fffffffc 	0xfffffffc
	...
 3b4:	00000038 	0x38
 3b8:	0000001d 	0x1d
 3bc:	0000001f 	0x1f
 3c0:	bfc08760 	0xbfc08760
 3c4:	800f0000 	lb	t7,0(zero)
 3c8:	fffffffc 	0xfffffffc
	...
 3d4:	00000030 	0x30
 3d8:	0000001d 	0x1d
 3dc:	0000001f 	0x1f
 3e0:	bfc088c0 	0xbfc088c0
 3e4:	c0ff0000 	lwc0	$31,0(a3)
 3e8:	fffffffc 	0xfffffffc
	...
 3f4:	00000038 	0x38
 3f8:	0000001d 	0x1d
 3fc:	0000001f 	0x1f
 400:	bfc08f70 	0xbfc08f70
 404:	803f0000 	lb	ra,0(at)
 408:	fffffffc 	0xfffffffc
	...
 414:	00000038 	0x38
 418:	0000001d 	0x1d
 41c:	0000001f 	0x1f
 420:	bfc091b0 	0xbfc091b0
 424:	c0ff0000 	lwc0	$31,0(a3)
 428:	fffffffc 	0xfffffffc
	...
 434:	00000040 	sll	zero,zero,0x1
 438:	0000001d 	0x1d
 43c:	0000001f 	0x1f
 440:	bfc09c40 	0xbfc09c40
	...
 458:	0000001d 	0x1d
 45c:	0000001f 	0x1f
 460:	bfc09c50 	0xbfc09c50
	...
 478:	0000001d 	0x1d
 47c:	0000001f 	0x1f
 480:	bfc09c60 	0xbfc09c60
	...
 498:	0000001d 	0x1d
 49c:	0000001f 	0x1f
 4a0:	bfc09cc0 	0xbfc09cc0
	...
 4b8:	0000001d 	0x1d
 4bc:	0000001f 	0x1f
 4c0:	bfc09ce0 	0xbfc09ce0
	...
 4d8:	0000001d 	0x1d
 4dc:	0000001f 	0x1f
 4e0:	bfc09cf0 	0xbfc09cf0
	...
 4f8:	0000001d 	0x1d
 4fc:	0000001f 	0x1f
 500:	bfc09d00 	0xbfc09d00
	...
 518:	0000001d 	0x1d
 51c:	0000001f 	0x1f
 520:	bfc09d10 	0xbfc09d10
	...
 538:	0000001d 	0x1d
 53c:	0000001f 	0x1f
 540:	bfc09d20 	0xbfc09d20
 544:	807f0000 	lb	ra,0(v1)
 548:	fffffffc 	0xfffffffc
	...
 554:	00000038 	0x38
 558:	0000001d 	0x1d
 55c:	0000001f 	0x1f
 560:	bfc09f70 	0xbfc09f70
	...
 578:	0000001d 	0x1d
 57c:	0000001f 	0x1f
 580:	bfc09f84 	0xbfc09f84
 584:	80000000 	lb	zero,0(zero)
 588:	fffffffc 	0xfffffffc
	...
 594:	00000018 	mult	zero,zero
 598:	0000001d 	0x1d
 59c:	0000001f 	0x1f
 5a0:	bfc09fb0 	0xbfc09fb0
 5a4:	80070000 	lb	a3,0(zero)
 5a8:	fffffffc 	0xfffffffc
	...
 5b4:	00000020 	add	zero,zero,zero
 5b8:	0000001d 	0x1d
 5bc:	0000001f 	0x1f
 5c0:	bfc0a038 	0xbfc0a038
 5c4:	80000000 	lb	zero,0(zero)
 5c8:	fffffffc 	0xfffffffc
	...
 5d4:	00000018 	mult	zero,zero
 5d8:	0000001d 	0x1d
 5dc:	0000001f 	0x1f
 5e0:	bfc0a070 	0xbfc0a070
 5e4:	800f0000 	lb	t7,0(zero)
 5e8:	fffffffc 	0xfffffffc
	...
 5f4:	00000068 	0x68
 5f8:	0000001d 	0x1d
 5fc:	0000001f 	0x1f
 600:	bfc0a170 	0xbfc0a170
	...
 618:	0000001d 	0x1d
 61c:	0000001f 	0x1f
 620:	bfc0a180 	0xbfc0a180
	...
 638:	0000001d 	0x1d
 63c:	0000001f 	0x1f
 640:	bfc0a190 	0xbfc0a190
	...
 658:	0000001d 	0x1d
 65c:	0000001f 	0x1f
 660:	bfc0a1a0 	0xbfc0a1a0
	...
 678:	0000001d 	0x1d
 67c:	0000001f 	0x1f
 680:	bfc0a1bc 	0xbfc0a1bc
 684:	80000000 	lb	zero,0(zero)
 688:	fffffffc 	0xfffffffc
	...
 694:	00000018 	mult	zero,zero
 698:	0000001d 	0x1d
 69c:	0000001f 	0x1f

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	00000054 	0x54
   4:	001e0002 	srl	zero,s8,0x0
   8:	01010000 	0x1010000
   c:	000d0efb 	0xd0efb
  10:	01010101 	0x1010101
  14:	01000000 	0x1000000
  18:	00010000 	sll	zero,at,0x0
  1c:	72617473 	0x72617473
  20:	00532e74 	0x532e74
  24:	00000000 	nop
  28:	00020500 	sll	zero,v0,0x14
  2c:	03bfc000 	0x3bfc000
  30:	4b830133 	c2	0x1830133
  34:	4b84834b 	c2	0x184834b
  38:	c0024b4c 	lwc0	$2,19276(zero)
  3c:	4b4b1501 	c2	0x14b1501
  40:	4b4d4b4b 	c2	0x14d4b4b
  44:	4b4b834b 	c2	0x14b834b
  48:	4b4b4b4c 	c2	0x14b4b4c
  4c:	04d4024b 	0x4d4024b
  50:	024b4b19 	0x24b4b19
  54:	01010004 	sllv	zero,at,t0
  58:	000000a8 	0xa8
  5c:	001f0002 	srl	zero,ra,0x0
  60:	01010000 	0x1010000
  64:	000d0efb 	0xd0efb
  68:	01010101 	0x1010101
  6c:	01000000 	0x1000000
  70:	00010000 	sll	zero,at,0x0
  74:	6e697270 	0x6e697270
  78:	632e6674 	0x632e6674
  7c:	00000000 	nop
  80:	02050000 	0x2050000
  84:	bfc09d20 	0xbfc09d20
  88:	1a240213 	0x1a240213
  8c:	504a7803 	0x504a7803
  90:	c24a7a03 	lwc0	$10,31235(s2)
  94:	4a780389 	c2	0x780389
  98:	4a780352 	c2	0x780352
  9c:	00c2034e 	0xc2034e
  a0:	7fbe034a 	0x7fbe034a
  a4:	00c2034a 	0xc2034a
  a8:	ba038382 	swr	v1,-31870(s0)
  ac:	ca03827f 	lwc2	$3,-32129(s0)
  b0:	03740800 	0x3740800
  b4:	2c027fb9 	sltiu	v0,zero,32697
  b8:	38038601 	xori	v1,zero,0x8601
  bc:	41033c08 	0x41033c08
  c0:	30038982 	andi	v1,zero,0x8982
  c4:	03f43c08 	0x3f43c08
  c8:	033c084e 	0x33c084e
  cc:	4f03823e 	c3	0x103823e
  d0:	034bf3f2 	0x34bf3f2
  d4:	03bb8274 	0x3bb8274
  d8:	4bf38223 	c2	0x1f38223
  dc:	f3827303 	0xf3827303
  e0:	8279034b 	lb	t9,843(s3)
  e4:	79034bf3 	0x79034bf3
  e8:	034bf382 	0x34bf382
  ec:	03bb8274 	0x3bb8274
  f0:	4bf38218 	c2	0x1f38218
  f4:	83820903 	lb	v0,2307(gp)
  f8:	4bf14b87 	c2	0x1f14b87
  fc:	02750849 	0x2750849
 100:	01010008 	0x1010008
 104:	0000003c 	0x3c
 108:	00200002 	0x200002
 10c:	01010000 	0x1010000
 110:	000d0efb 	0xd0efb
 114:	01010101 	0x1010101
 118:	01000000 	0x1000000
 11c:	00010000 	sll	zero,at,0x0
 120:	63747570 	0x63747570
 124:	2e726168 	sltiu	s2,s3,24936
 128:	00000063 	0x63
 12c:	05000000 	bltz	t0,130 <data_size-0x8b4>
 130:	c09f7002 	lwc0	$31,28674(a0)
 134:	031319bf 	0x31319bf
 138:	7003ba09 	0x7003ba09
 13c:	02848382 	0x2848382
 140:	01010010 	0x1010010
 144:	0000003f 	0x3f
 148:	001d0002 	srl	zero,sp,0x0
 14c:	01010000 	0x1010000
 150:	000d0efb 	0xd0efb
 154:	01010101 	0x1010101
 158:	01000000 	0x1000000
 15c:	00010000 	sll	zero,at,0x0
 160:	73747570 	0x73747570
 164:	0000632e 	0x632e
 168:	00000000 	nop
 16c:	9fb00205 	0x9fb00205
 170:	0813bfc0 	j	4eff00 <data_size+0x4ef51c>
 174:	7f83f43e 	0x7f83f43e
 178:	f97ff3f4 	0xf97ff3f4
 17c:	8383b008 	lb	v1,-20472(gp)
 180:	10028483 	beq	zero,v0,fffe1390 <_etext+0x403d7100>
 184:	53010100 	0x53010100
 188:	02000000 	0x2000000
 18c:	00002200 	sll	a0,zero,0x8
 190:	fb010100 	0xfb010100
 194:	01000d0e 	0x1000d0e
 198:	00010101 	0x10101
 19c:	00010000 	sll	zero,at,0x0
 1a0:	70000100 	0x70000100
 1a4:	746e6972 	jalx	1b9a5c8 <data_size+0x1b99be4>
 1a8:	65736162 	0x65736162
 1ac:	0000632e 	0x632e
 1b0:	00000000 	nop
 1b4:	a0700205 	sb	s0,517(v1)
 1b8:	0813bfc0 	j	4eff00 <data_size+0x4ef51c>
 1bc:	4cf78774 	0x4cf78774
 1c0:	b84cf0bc 	swr	t4,-3908(v0)
 1c4:	086c038a 	j	1b00e28 <data_size+0x1b00444>
 1c8:	82160374 	lb	s6,884(s0)
 1cc:	0888b7f3 	j	222dfcc <data_size+0x222d5e8>
 1d0:	710383e0 	0x710383e0
 1d4:	0f033c08 	jal	c0cf020 <data_size+0xc0ce63c>
 1d8:	000802f2 	0x802f2
 1dc:	00710101 	0x710101
 1e0:	00020000 	sll	zero,v0,0x0
 1e4:	00000032 	0x32
 1e8:	0efb0101 	jal	bec0404 <data_size+0xbebfa20>
 1ec:	0101000d 	break	0x101
 1f0:	00000101 	0x101
 1f4:	00000100 	sll	zero,zero,0x4
 1f8:	2f2e2e01 	sltiu	t6,t9,11777
 1fc:	6c636e69 	0x6c636e69
 200:	00656475 	0x656475
 204:	6d697400 	0x6d697400
 208:	00632e65 	0x632e65
 20c:	74000000 	jalx	0 <data_size-0x9e4>
 210:	2e656d69 	sltiu	a1,s3,28009
 214:	00010068 	0x10068
 218:	05000000 	bltz	t0,21c <data_size-0x7c8>
 21c:	c0a17002 	lwc0	$1,28674(a1)
 220:	0a0315bf 	j	80c56fc <data_size+0x80c4d18>
 224:	0314f501 	0x314f501
 228:	f516f20f 	0xf516f20f
 22c:	03015d03 	0x3015d03
 230:	033c0828 	0x33c0828
 234:	03828268 	0x3828268
 238:	15034a70 	bne	t0,v1,12bfc <data_size+0x12218>
 23c:	4c3b0882 	0x4c3b0882
 240:	8180f67f 	lb	zero,-2433(t4)
 244:	3b083e08 	xori	t0,t8,0x3e08
 248:	3d083a08 	0x3d083a08
 24c:	100284f5 	beq	zero,v0,fffe1624 <_etext+0x403d7394>
 250:	Address 0x0000000000000250 is out of bounds.


Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	0000003c 	0x3c
   4:	00000002 	srl	zero,zero,0x0
   8:	01040000 	0x1040000
   c:	00000000 	nop
  10:	bfc00000 	0xbfc00000
  14:	bfc0038c 	0xbfc0038c
  18:	72617473 	0x72617473
  1c:	00532e74 	0x532e74
  20:	746e6d2f 	jalx	1b9b4bc <data_size+0x1b9aad8>
  24:	7265702f 	0x7265702f
  28:	616c5f66 	0x616c5f66
  2c:	47003262 	c1	0x1003262
  30:	4120554e 	0x4120554e
  34:	2e322053 	sltiu	s2,s1,8275
  38:	352e3831 	ori	t6,t1,0x3831
  3c:	80010030 	lb	at,48(zero)
  40:	000000c9 	0xc9
  44:	00140002 	srl	zero,s4,0x0
  48:	01040000 	0x1040000
  4c:	00000018 	mult	zero,zero
  50:	00002701 	0x2701
  54:	00003000 	sll	a2,zero,0x0
  58:	c09d2000 	lwc0	$29,8192(a0)
  5c:	c09f70bf 	lwc0	$31,28863(a0)
  60:	000058bf 	0x58bf
  64:	03040200 	0x3040200
  68:	000b0704 	0xb0704
  6c:	04030000 	0x4030000
  70:	00000607 	0x607
  74:	43010400 	c0	0x1010400
  78:	01000000 	0x1000000
  7c:	00ad0102 	0xad0102
  80:	9d200000 	0x9d200000
  84:	9f70bfc0 	0x9f70bfc0
  88:	0010bfc0 	sll	s7,s0,0x1f
  8c:	00000000 	nop
  90:	00ad0000 	0xad0000
  94:	66050000 	0x66050000
  98:	0100746d 	0x100746d
  9c:	0000b401 	0xb401
  a0:	00001f00 	sll	v1,zero,0x1c
  a4:	69070600 	0x69070600
  a8:	ad030100 	sw	v1,256(t0)
  ac:	48000000 	mfc2	zero,$0
  b0:	08000000 	j	0 <data_size-0x9e4>
  b4:	04010063 	b	244 <data_size-0x7a0>
  b8:	000000bf 	0xbf
  bc:	67726107 	0x67726107
  c0:	c6050100 	lwc1	$f5,256(s0)
  c4:	66000000 	0x66000000
  c8:	09000000 	j	4000000 <data_size+0x3fff61c>
  cc:	01007061 	0x1007061
  d0:	00002506 	0x2506
  d4:	108d0200 	beq	a0,t5,8d8 <data_size-0x10c>
  d8:	01007707 	0x1007707
  dc:	0000ad07 	0xad07
  e0:	00008400 	sll	s0,zero,0x10
  e4:	00000a00 	sll	at,zero,0x8
  e8:	45010000 	bc1t	ec <data_size-0x8f8>
  ec:	05040b00 	0x5040b00
  f0:	00746e69 	0x746e69
  f4:	00ba040c 	syscall	0x2e810
  f8:	bf0d0000 	0xbf0d0000
  fc:	03000000 	0x3000000
 100:	00510601 	0x510601
 104:	040c0000 	0x40c0000
 108:	00000025 	move	zero,zero
 10c:	00008800 	sll	s1,zero,0x0
 110:	bb000200 	swr	zero,512(t8)
 114:	04000000 	bltz	zero,118 <data_size-0x8cc>
 118:	00001801 	0x1801
 11c:	00560100 	0x560100
 120:	00300000 	0x300000
 124:	9f700000 	0x9f700000
 128:	9fa4bfc0 	0x9fa4bfc0
 12c:	0104bfc0 	0x104bfc0
 130:	04020000 	0x4020000
 134:	00000b07 	0xb07
 138:	07040200 	0x7040200
 13c:	00000006 	srlv	zero,zero,zero
 140:	004a0103 	0x4a0103
 144:	08010000 	j	40000 <data_size+0x3f61c>
 148:	bfc09f70 	0xbfc09f70
 14c:	bfc09f84 	0xbfc09f84
 150:	00000044 	0x44
 154:	00596d01 	0x596d01
 158:	63040000 	0x63040000
 15c:	59080100 	0x59080100
 160:	01000000 	0x1000000
 164:	04050054 	0x4050054
 168:	746e6905 	jalx	1b9a414 <data_size+0x1b99a30>
 16c:	4e010600 	c3	0x10600
 170:	01000000 	0x1000000
 174:	00590102 	0x590102
 178:	9f840000 	0x9f840000
 17c:	9fa4bfc0 	0x9fa4bfc0
 180:	0054bfc0 	0x54bfc0
 184:	01100000 	0x1100000
 188:	63070000 	0x63070000
 18c:	59010100 	0x59010100
 190:	2f000000 	sltiu	zero,t8,0
 194:	00000001 	0x1
 198:	0000ab00 	sll	s5,zero,0xc
 19c:	35000200 	ori	zero,t0,0x200
 1a0:	04000001 	bltz	zero,1a8 <data_size-0x83c>
 1a4:	00001801 	0x1801
 1a8:	00600100 	0x600100
 1ac:	00300000 	0x300000
 1b0:	9fb00000 	0x9fb00000
 1b4:	a068bfc0 	sb	t0,-16448(v1)
 1b8:	0144bfc0 	0x144bfc0
 1bc:	04020000 	0x4020000
 1c0:	00000b07 	0xb07
 1c4:	07040200 	0x7040200
 1c8:	00000006 	srlv	zero,zero,zero
 1cc:	006c0103 	0x6c0103
 1d0:	02010000 	0x2010000
 1d4:	00006f01 	0x6f01
 1d8:	c09fb000 	lwc0	$31,-20480(a0)
 1dc:	c0a038bf 	lwc0	$0,14527(a1)
 1e0:	00007cbf 	0x7cbf
 1e4:	00014200 	sll	t0,at,0x8
 1e8:	00006f00 	sll	t5,zero,0x1c
 1ec:	00730400 	0x730400
 1f0:	00760101 	0x760101
 1f4:	01610000 	0x1610000
 1f8:	63050000 	0x63050000
 1fc:	7c030100 	0x7c030100
 200:	8a000000 	lwl	zero,0(s0)
 204:	00000001 	0x1
 208:	69050406 	0x69050406
 20c:	0700746e 	bltz	t8,1d3c8 <data_size+0x1c9e4>
 210:	00007c04 	0x7c04
 214:	06010200 	bgez	s0,a18 <data_size+0x34>
 218:	00000051 	0x51
 21c:	00670108 	0x670108
 220:	0f010000 	jal	c040000 <data_size+0xc03f61c>
 224:	00006f01 	0x6f01
 228:	c0a03800 	lwc0	$0,14336(a1)
 22c:	c0a068bf 	lwc0	$0,26815(a1)
 230:	000098bf 	0x98bf
 234:	00019d00 	sll	s3,at,0x14
 238:	00730400 	0x730400
 23c:	00760e01 	0x760e01
 240:	01bc0000 	0x1bc0000
 244:	00000000 	nop
 248:	000000f7 	0xf7
 24c:	01bc0002 	0x1bc0002
 250:	01040000 	0x1040000
 254:	00000018 	mult	zero,zero
 258:	00007601 	0x7601
 25c:	00003000 	sll	a2,zero,0x0
 260:	c0a07000 	lwc0	$0,28672(a1)
 264:	c0a170bf 	lwc0	$1,28863(a1)
 268:	000187bf 	0x187bf
 26c:	07040200 	0x7040200
 270:	0000000b 	0xb
 274:	06070402 	0x6070402
 278:	03000000 	0x3000000
 27c:	00009601 	0x9601
 280:	01020100 	0x1020100
 284:	000000d2 	0xd2
 288:	bfc0a070 	0xbfc0a070
 28c:	bfc0a170 	0xbfc0a170
 290:	000000c0 	sll	zero,zero,0x3
 294:	000001cf 	0x1cf
 298:	000000d2 	0xd2
 29c:	01007604 	0x1007604
 2a0:	0000d901 	0xd901
 2a4:	0001ef00 	sll	sp,at,0x1c
 2a8:	00770400 	0x770400
 2ac:	00d20101 	0xd20101
 2b0:	024f0000 	0x24f0000
 2b4:	9b050000 	lwr	a1,0(t8)
 2b8:	01000000 	0x1000000
 2bc:	0000d201 	0xd201
 2c0:	0002ba00 	sll	s7,v0,0x8
 2c4:	00910500 	0x910500
 2c8:	01010000 	0x1010000
 2cc:	000000d2 	0xd2
 2d0:	0000030f 	0x30f
 2d4:	01006906 	0x1006906
 2d8:	0000d203 	sra	k0,zero,0x8
 2dc:	00033800 	sll	a3,v1,0x0
 2e0:	006a0600 	0x6a0600
 2e4:	00d20301 	0xd20301
 2e8:	03610000 	0x3610000
 2ec:	63060000 	0x63060000
 2f0:	d2040100 	0xd2040100
 2f4:	8a000000 	lwl	zero,0(s0)
 2f8:	07000003 	bltz	t8,308 <data_size-0x6dc>
 2fc:	00667562 	0x667562
 300:	00e00501 	0xe00501
 304:	91030000 	lbu	v1,0(t0)
 308:	82087fa8 	lb	t0,32680(s0)
 30c:	01000000 	0x1000000
 310:	00002c06 	0x2c06
 314:	0003a800 	sll	s5,v1,0x0
 318:	04090000 	0x4090000
 31c:	746e6905 	jalx	1b9a414 <data_size+0x1b99a30>
 320:	05040200 	0x5040200
 324:	00000088 	0x88
 328:	0000f30a 	0xf30a
 32c:	0000f000 	sll	s8,zero,0x0
 330:	00f00b00 	0xf00b00
 334:	003f0000 	0x3f0000
 338:	0207040c 	syscall	0x81c10
 33c:	00510601 	0x510601
 340:	c1000000 	lwc0	$0,0(t0)
 344:	02000001 	0x2000001
 348:	00026800 	sll	t5,v0,0x0
 34c:	18010400 	0x18010400
 350:	01000000 	0x1000000
 354:	000000cc 	syscall	0x3
 358:	00000030 	0x30
 35c:	bfc0a170 	0xbfc0a170
 360:	bfc0a288 	0xbfc0a288
 364:	000001de 	0x1de
 368:	0b070402 	j	c1c1008 <data_size+0xc1c0624>
 36c:	02000000 	0x2000000
 370:	00060704 	0x60704
 374:	b4030000 	0xb4030000
 378:	02000000 	0x2000000
 37c:	00002c03 	sra	a1,zero,0x10
 380:	05040400 	0x5040400
 384:	00746e69 	0x746e69
 388:	0000ab05 	0xab05
 38c:	1f021000 	0x1f021000
 390:	0000008a 	0x8a
 394:	0000ee06 	0xee06
 398:	33200200 	andi	zero,t9,0x200
 39c:	02000000 	0x2000000
 3a0:	f5060010 	0xf5060010
 3a4:	02000000 	0x2000000
 3a8:	00003321 	0x3321
 3ac:	04100200 	bltzal	zero,bb0 <data_size+0x1cc>
 3b0:	0000e606 	0xe606
 3b4:	33220200 	andi	v0,t9,0x200
 3b8:	02000000 	0x2000000
 3bc:	bd060810 	0xbd060810
 3c0:	02000000 	0x2000000
 3c4:	00003323 	0x3323
 3c8:	0c100200 	jal	400800 <data_size+0x3ffe1c>
 3cc:	a0010700 	sb	at,1792(zero)
 3d0:	01000000 	0x1000000
 3d4:	00002c04 	0x2c04
 3d8:	00a70000 	0xa70000
 3dc:	d3080000 	0xd3080000
 3e0:	01000000 	0x1000000
 3e4:	00002c05 	0x2c05
 3e8:	8a090000 	lwl	t1,0(s0)
 3ec:	70000000 	0x70000000
 3f0:	80bfc0a1 	lb	ra,-16223(a1)
 3f4:	f0bfc0a1 	0xf0bfc0a1
 3f8:	01000000 	0x1000000
 3fc:	0000c46d 	0xc46d
 400:	009b0a00 	0x9b0a00
 404:	0b000000 	j	c000000 <data_size+0xbfff61c>
 408:	0000a101 	0xa101
 40c:	2c110100 	sltiu	s1,zero,256
 410:	80000000 	lb	zero,0(zero)
 414:	90bfc0a1 	lbu	ra,-16223(a1)
 418:	00bfc0a1 	0xbfc0a1
 41c:	01000001 	0x1000001
 420:	dc010c6d 	0xdc010c6d
 424:	01000000 	0x1000000
 428:	00002c22 	0x2c22
 42c:	c0a19000 	lwc0	$1,-28672(a1)
 430:	c0a1a0bf 	lwc0	$1,-24385(a1)
 434:	000110bf 	0x110bf
 438:	066d0100 	0x66d0100
 43c:	0d000001 	jal	4000004 <data_size+0x3fff620>
 440:	2301006e 	addi	at,t8,110
 444:	0000002c 	0x2c
 448:	c5010e00 	lwc1	$f1,3584(t0)
 44c:	01000000 	0x1000000
 450:	002c0129 	0x2c0129
 454:	a1a00000 	sb	zero,0(t5)
 458:	a1bcbfc0 	sb	gp,-16448(t5)
 45c:	0120bfc0 	0x120bfc0
 460:	6d010000 	0x6d010000
 464:	00000152 	0x152
 468:	01006e0f 	0x1006e0f
 46c:	00002c2a 	0x2c2a
 470:	0003d100 	sll	k0,v1,0x4
 474:	008a1000 	0x8a1000
 478:	a1a00000 	sb	zero,0(t5)
 47c:	a1b4bfc0 	sb	s4,-16448(t5)
 480:	2b01bfc0 	slti	at,t8,-16448
 484:	c0a1a011 	lwc0	$1,-24559(a1)
 488:	c0a1b4bf 	lwc0	$1,-19265(a1)
 48c:	009b0abf 	0x9b0abf
 490:	00000000 	nop
 494:	fd011200 	0xfd011200
 498:	01000000 	0x1000000
 49c:	002c0116 	0x2c0116
 4a0:	a1bc0000 	sb	gp,0(t5)
 4a4:	a288bfc0 	sb	t0,-16448(s4)
 4a8:	0130bfc0 	0x130bfc0
 4ac:	03e40000 	0x3e40000
 4b0:	01be0000 	0x1be0000
 4b4:	73130000 	0x73130000
 4b8:	01006c65 	0x1006c65
 4bc:	00003e15 	0x3e15
 4c0:	00040300 	sll	zero,a0,0xc
 4c4:	6d741300 	0x6d741300
 4c8:	15010070 	bne	t0,at,68c <data_size-0x358>
 4cc:	000001be 	0x1be
 4d0:	00000416 	0x416
 4d4:	01006e0f 	0x1006e0f
 4d8:	00002c17 	0x2c17
 4dc:	00043400 	sll	a2,a0,0x10
 4e0:	008a1000 	0x8a1000
 4e4:	a1c80000 	sb	t0,0(t6)
 4e8:	a1d0bfc0 	sb	s0,-16448(t6)
 4ec:	1801bfc0 	0x1801bfc0
 4f0:	c0a1c811 	lwc0	$1,-14319(a1)
 4f4:	c0a1d0bf 	lwc0	$1,-12097(a1)
 4f8:	009b0abf 	0x9b0abf
 4fc:	00000000 	nop
 500:	45041400 	0x45041400
 504:	00000000 	nop

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	b	4408 <data_size+0x3a24>
   4:	12011106 	beq	s0,at,4420 <data_size+0x3a3c>
   8:	1b080301 	0x1b080301
   c:	13082508 	beq	t8,t0,9430 <data_size+0x8a4c>
  10:	00000005 	0x5
  14:	25011101 	addiu	at,t0,4353
  18:	030b130e 	0x30b130e
  1c:	110e1b0e 	beq	t0,t6,6c58 <data_size+0x6274>
  20:	10011201 	beq	zero,at,4828 <data_size+0x3e44>
  24:	02000006 	srlv	zero,zero,s0
  28:	0b0b000f 	j	c2c003c <data_size+0xc2bf658>
  2c:	24030000 	li	v1,0
  30:	3e0b0b00 	0x3e0b0b00
  34:	000e030b 	0xe030b
  38:	012e0400 	0x12e0400
  3c:	0e030c3f 	jal	80c30fc <data_size+0x80c2718>
  40:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
  44:	13490c27 	beq	k0,t1,30e4 <data_size+0x2700>
  48:	01120111 	0x1120111
  4c:	40064081 	0x40064081
  50:	00130106 	0x130106
  54:	00050500 	sll	zero,a1,0x14
  58:	0b3a0803 	j	ce8200c <data_size+0xce81628>
  5c:	13490b3b 	beq	k0,t1,2d4c <data_size+0x2368>
  60:	00000602 	srl	zero,zero,0x18
  64:	00001806 	srlv	v1,zero,zero
  68:	00340700 	0x340700
  6c:	0b3a0803 	j	ce8200c <data_size+0xce81628>
  70:	13490b3b 	beq	k0,t1,2d60 <data_size+0x237c>
  74:	00000602 	srl	zero,zero,0x18
  78:	03003408 	0x3003408
  7c:	3b0b3a08 	xori	t3,t8,0x3a08
  80:	0013490b 	0x13490b
  84:	00340900 	0x340900
  88:	0b3a0803 	j	ce8200c <data_size+0xce81628>
  8c:	13490b3b 	beq	k0,t1,2d7c <data_size+0x2398>
  90:	00000a02 	srl	at,zero,0x8
  94:	03000a0a 	0x3000a0a
  98:	3b0b3a0e 	xori	t3,t8,0x3a0e
  9c:	0b00000b 	j	c00002c <data_size+0xbfff648>
  a0:	0b0b0024 	j	c2c0090 <data_size+0xc2bf6ac>
  a4:	08030b3e 	j	c2cf8 <data_size+0xc2314>
  a8:	0f0c0000 	jal	c300000 <data_size+0xc2ff61c>
  ac:	490b0b00 	0x490b0b00
  b0:	0d000013 	jal	400004c <data_size+0x3fff668>
  b4:	13490026 	beq	k0,t1,150 <data_size-0x894>
  b8:	01000000 	0x1000000
  bc:	0e250111 	jal	8940444 <data_size+0x893fa60>
  c0:	0e030b13 	jal	80c2c4c <data_size+0x80c2268>
  c4:	01110e1b 	0x1110e1b
  c8:	06100112 	bltzal	s0,514 <data_size-0x4d0>
  cc:	24020000 	li	v0,0
  d0:	3e0b0b00 	0x3e0b0b00
  d4:	000e030b 	0xe030b
  d8:	012e0300 	0x12e0300
  dc:	0e030c3f 	jal	80c30fc <data_size+0x80c2718>
  e0:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
  e4:	01120111 	0x1120111
  e8:	40064081 	0x40064081
  ec:	0013010a 	0x13010a
  f0:	00050400 	sll	zero,a1,0x10
  f4:	0b3a0803 	j	ce8200c <data_size+0xce81628>
  f8:	13490b3b 	beq	k0,t1,2de8 <data_size+0x2404>
  fc:	00000a02 	srl	at,zero,0x8
 100:	0b002405 	j	c009014 <data_size+0xc008630>
 104:	030b3e0b 	0x30b3e0b
 108:	06000008 	bltz	s0,12c <data_size-0x8b8>
 10c:	0c3f012e 	jal	fc04b8 <data_size+0xfbfad4>
 110:	0b3a0e03 	j	ce8380c <data_size+0xce82e28>
 114:	0c270b3b 	jal	9c2cec <data_size+0x9c2308>
 118:	01111349 	0x1111349
 11c:	40810112 	0x40810112
 120:	00064006 	srlv	t0,a2,zero
 124:	00050700 	sll	zero,a1,0x1c
 128:	0b3a0803 	j	ce8200c <data_size+0xce81628>
 12c:	13490b3b 	beq	k0,t1,2e1c <data_size+0x2438>
 130:	00000602 	srl	zero,zero,0x18
 134:	01110100 	0x1110100
 138:	0b130e25 	j	c4c3894 <data_size+0xc4c2eb0>
 13c:	0e1b0e03 	jal	86c380c <data_size+0x86c2e28>
 140:	01120111 	0x1120111
 144:	00000610 	0x610
 148:	0b002402 	j	c009008 <data_size+0xc008624>
 14c:	030b3e0b 	0x30b3e0b
 150:	0300000e 	0x300000e
 154:	0c3f012e 	jal	fc04b8 <data_size+0xfbfad4>
 158:	0b3a0e03 	j	ce8380c <data_size+0xce82e28>
 15c:	0c270b3b 	jal	9c2cec <data_size+0x9c2308>
 160:	01111349 	0x1111349
 164:	40810112 	0x40810112
 168:	01064006 	srlv	t0,a2,t0
 16c:	04000013 	bltz	zero,1bc <data_size-0x828>
 170:	08030005 	j	c0014 <data_size+0xbf630>
 174:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
 178:	06021349 	0x6021349
 17c:	34050000 	li	a1,0x0
 180:	3a080300 	xori	t0,s0,0x300
 184:	490b3b0b 	0x490b3b0b
 188:	00060213 	0x60213
 18c:	00240600 	0x240600
 190:	0b3e0b0b 	j	cf82c2c <data_size+0xcf82248>
 194:	00000803 	sra	at,zero,0x0
 198:	0b000f07 	j	c003c1c <data_size+0xc003238>
 19c:	0013490b 	0x13490b
 1a0:	012e0800 	0x12e0800
 1a4:	0e030c3f 	jal	80c30fc <data_size+0x80c2718>
 1a8:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
 1ac:	13490c27 	beq	k0,t1,324c <data_size+0x2868>
 1b0:	01120111 	0x1120111
 1b4:	40064081 	0x40064081
 1b8:	00000006 	srlv	zero,zero,zero
 1bc:	25011101 	addiu	at,t0,4353
 1c0:	030b130e 	0x30b130e
 1c4:	110e1b0e 	beq	t0,t6,6e00 <data_size+0x641c>
 1c8:	10011201 	beq	zero,at,49d0 <data_size+0x3fec>
 1cc:	02000006 	srlv	zero,zero,s0
 1d0:	0b0b0024 	j	c2c0090 <data_size+0xc2bf6ac>
 1d4:	0e030b3e 	jal	80c2cf8 <data_size+0x80c2314>
 1d8:	2e030000 	sltiu	v1,s0,0
 1dc:	030c3f01 	0x30c3f01
 1e0:	3b0b3a0e 	xori	t3,t8,0x3a0e
 1e4:	490c270b 	0x490c270b
 1e8:	12011113 	beq	s0,at,4638 <data_size+0x3c54>
 1ec:	06408101 	bltz	s2,fffe05f4 <_etext+0x403d6364>
 1f0:	13010640 	beq	t8,at,1af4 <data_size+0x1110>
 1f4:	05040000 	0x5040000
 1f8:	3a080300 	xori	t0,s0,0x300
 1fc:	490b3b0b 	0x490b3b0b
 200:	00060213 	0x60213
 204:	00050500 	sll	zero,a1,0x14
 208:	0b3a0e03 	j	ce8380c <data_size+0xce82e28>
 20c:	13490b3b 	beq	k0,t1,2efc <data_size+0x2518>
 210:	00000602 	srl	zero,zero,0x18
 214:	03003406 	0x3003406
 218:	3b0b3a08 	xori	t3,t8,0x3a08
 21c:	0213490b 	0x213490b
 220:	07000006 	bltz	t8,23c <data_size-0x7a8>
 224:	08030034 	j	c00d0 <data_size+0xbf6ec>
 228:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
 22c:	0a021349 	j	8084d24 <data_size+0x8084340>
 230:	34080000 	li	t0,0x0
 234:	3a0e0300 	xori	t6,s0,0x300
 238:	490b3b0b 	0x490b3b0b
 23c:	00060213 	0x60213
 240:	00240900 	0x240900
 244:	0b3e0b0b 	j	cf82c2c <data_size+0xcf82248>
 248:	00000803 	sra	at,zero,0x0
 24c:	4901010a 	bc2t	678 <data_size-0x36c>
 250:	00130113 	0x130113
 254:	00210b00 	0x210b00
 258:	0b2f1349 	j	cbc4d24 <data_size+0xcbc4340>
 25c:	240c0000 	li	t4,0
 260:	3e0b0b00 	0x3e0b0b00
 264:	0000000b 	0xb
 268:	25011101 	addiu	at,t0,4353
 26c:	030b130e 	0x30b130e
 270:	110e1b0e 	beq	t0,t6,6eac <data_size+0x64c8>
 274:	10011201 	beq	zero,at,4a7c <data_size+0x4098>
 278:	02000006 	srlv	zero,zero,s0
 27c:	0b0b0024 	j	c2c0090 <data_size+0xc2bf6ac>
 280:	0e030b3e 	jal	80c2cf8 <data_size+0x80c2314>
 284:	16030000 	bne	s0,v1,288 <data_size-0x75c>
 288:	3a0e0300 	xori	t6,s0,0x300
 28c:	490b3b0b 	0x490b3b0b
 290:	04000013 	bltz	zero,2e0 <data_size-0x704>
 294:	0b0b0024 	j	c2c0090 <data_size+0xc2bf6ac>
 298:	08030b3e 	j	c2cf8 <data_size+0xc2314>
 29c:	13050000 	beq	t8,a1,2a0 <data_size-0x744>
 2a0:	0b0e0301 	j	c380c04 <data_size+0xc380220>
 2a4:	3b0b3a0b 	xori	t3,t8,0x3a0b
 2a8:	0013010b 	0x13010b
 2ac:	000d0600 	sll	zero,t5,0x18
 2b0:	0b3a0e03 	j	ce8380c <data_size+0xce82e28>
 2b4:	13490b3b 	beq	k0,t1,2fa4 <data_size+0x25c0>
 2b8:	00000a38 	0xa38
 2bc:	3f012e07 	0x3f012e07
 2c0:	3a0e030c 	xori	t6,s0,0x30c
 2c4:	490b3b0b 	0x490b3b0b
 2c8:	010b2013 	0x10b2013
 2cc:	08000013 	j	4c <data_size-0x998>
 2d0:	0e030034 	jal	80c00d0 <data_size+0x80bf6ec>
 2d4:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
 2d8:	00001349 	0x1349
 2dc:	31012e09 	andi	at,t0,0x2e09
 2e0:	12011113 	beq	s0,at,4730 <data_size+0x3d4c>
 2e4:	06408101 	bltz	s2,fffe06ec <_etext+0x403d645c>
 2e8:	13010a40 	beq	t8,at,2bec <data_size+0x2208>
 2ec:	340a0000 	li	t2,0x0
 2f0:	00133100 	sll	a2,s3,0x4
 2f4:	002e0b00 	0x2e0b00
 2f8:	0e030c3f 	jal	80c30fc <data_size+0x80c2718>
 2fc:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
 300:	01111349 	0x1111349
 304:	40810112 	0x40810112
 308:	000a4006 	srlv	t0,t2,zero
 30c:	012e0c00 	0x12e0c00
 310:	0e030c3f 	jal	80c30fc <data_size+0x80c2718>
 314:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
 318:	01111349 	0x1111349
 31c:	40810112 	0x40810112
 320:	010a4006 	srlv	t0,t2,t0
 324:	0d000013 	jal	400004c <data_size+0x3fff668>
 328:	08030034 	j	c00d0 <data_size+0xbf6ec>
 32c:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
 330:	00001349 	0x1349
 334:	3f012e0e 	0x3f012e0e
 338:	3a0e030c 	xori	t6,s0,0x30c
 33c:	270b3b0b 	addiu	t3,t8,15115
 340:	1113490c 	beq	t0,s3,12774 <data_size+0x11d90>
 344:	81011201 	lb	at,4609(t0)
 348:	0a400640 	j	9001900 <data_size+0x9000f1c>
 34c:	00001301 	0x1301
 350:	0300340f 	0x300340f
 354:	3b0b3a08 	xori	t3,t8,0x3a08
 358:	0213490b 	0x213490b
 35c:	10000006 	b	378 <data_size-0x66c>
 360:	1331011d 	beq	t9,s1,7d8 <data_size-0x20c>
 364:	01120111 	0x1120111
 368:	0b590b58 	j	d642d60 <data_size+0xd64237c>
 36c:	0b110000 	j	c440000 <data_size+0xc43f61c>
 370:	12011101 	beq	s0,at,4778 <data_size+0x3d94>
 374:	12000001 	beqz	s0,37c <data_size-0x668>
 378:	0c3f012e 	jal	fc04b8 <data_size+0xfbfad4>
 37c:	0b3a0e03 	j	ce8380c <data_size+0xce82e28>
 380:	0c270b3b 	jal	9c2cec <data_size+0x9c2308>
 384:	01111349 	0x1111349
 388:	40810112 	0x40810112
 38c:	01064006 	srlv	t0,a2,t0
 390:	13000013 	beqz	t8,3e0 <data_size-0x604>
 394:	08030005 	j	c0014 <data_size+0xbf630>
 398:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2304>
 39c:	06021349 	0x6021349
 3a0:	0f140000 	jal	c500000 <data_size+0xc4ff61c>
 3a4:	490b0b00 	0x490b0b00
 3a8:	00000013 	mtlo	zero

Disassembly of section .comment:

00000000 <.comment>:
   0:	43434700 	c0	0x1434700
   4:	4728203a 	c1	0x128203a
   8:	2029554e 	addi	t1,at,21838
   c:	2e332e34 	sltiu	s3,s1,11828
  10:	47000030 	c1	0x1000030
  14:	203a4343 	addi	k0,at,17219
  18:	554e4728 	0x554e4728
  1c:	2e342029 	sltiu	s4,s1,8233
  20:	00302e33 	0x302e33
  24:	43434700 	c0	0x1434700
  28:	4728203a 	c1	0x128203a
  2c:	2029554e 	addi	t1,at,21838
  30:	2e332e34 	sltiu	s3,s1,11828
  34:	47000030 	c1	0x1000030
  38:	203a4343 	addi	k0,at,17219
  3c:	554e4728 	0x554e4728
  40:	2e342029 	sltiu	s4,s1,8233
  44:	00302e33 	0x302e33
  48:	43434700 	c0	0x1434700
  4c:	4728203a 	c1	0x128203a
  50:	2029554e 	addi	t1,at,21838
  54:	2e332e34 	sltiu	s3,s1,11828
  58:	47000030 	c1	0x1000030
  5c:	203a4343 	addi	k0,at,17219
  60:	554e4728 	0x554e4728
  64:	2e342029 	sltiu	s4,s1,8233
  68:	00302e33 	0x302e33
  6c:	43434700 	c0	0x1434700
  70:	4728203a 	c1	0x128203a
  74:	2029554e 	addi	t1,at,21838
  78:	2e332e34 	sltiu	s3,s1,11828
  7c:	47000030 	c1	0x1000030
  80:	203a4343 	addi	k0,at,17219
  84:	554e4728 	0x554e4728
  88:	2e342029 	sltiu	s4,s1,8233
  8c:	00302e33 	0x302e33
  90:	43434700 	c0	0x1434700
  94:	4728203a 	c1	0x128203a
  98:	2029554e 	addi	t1,at,21838
  9c:	2e332e34 	sltiu	s3,s1,11828
  a0:	47000030 	c1	0x1000030
  a4:	203a4343 	addi	k0,at,17219
  a8:	554e4728 	0x554e4728
  ac:	2e342029 	sltiu	s4,s1,8233
  b0:	00302e33 	0x302e33
  b4:	43434700 	c0	0x1434700
  b8:	4728203a 	c1	0x128203a
  bc:	2029554e 	addi	t1,at,21838
  c0:	2e332e34 	sltiu	s3,s1,11828
  c4:	47000030 	c1	0x1000030
  c8:	203a4343 	addi	k0,at,17219
  cc:	554e4728 	0x554e4728
  d0:	2e342029 	sltiu	s4,s1,8233
  d4:	00302e33 	0x302e33

Disassembly of section .gnu.attributes:

00000000 <.gnu.attributes>:
   0:	00000f41 	0xf41
   4:	756e6700 	jalx	5b99c00 <data_size+0x5b9921c>
   8:	00070100 	sll	zero,a3,0x4
   c:	03040000 	0x3040000

Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	syscall
   4:	ffffffff 	0xffffffff
   8:	7c010001 	0x7c010001
   c:	001d0c1f 	0x1d0c1f
  10:	00000020 	add	zero,zero,zero
  14:	00000000 	nop
  18:	bfc09d20 	0xbfc09d20
  1c:	00000250 	0x250
  20:	60380e44 	0x60380e44
  24:	07910890 	bgezal	gp,2268 <data_size+0x1884>
  28:	04940692 	0x4940692
  2c:	02960395 	0x2960395
  30:	0593019f 	0x593019f
  34:	0000000c 	syscall
  38:	ffffffff 	0xffffffff
  3c:	7c010001 	0x7c010001
  40:	001d0c1f 	0x1d0c1f
  44:	0000000c 	syscall
  48:	00000034 	0x34
  4c:	bfc09f70 	0xbfc09f70
  50:	00000014 	0x14
  54:	00000014 	0x14
  58:	00000034 	0x34
  5c:	bfc09f84 	0xbfc09f84
  60:	00000020 	add	zero,zero,zero
  64:	44180e44 	0x44180e44
  68:	0000019f 	0x19f
  6c:	0000000c 	syscall
  70:	ffffffff 	0xffffffff
  74:	7c010001 	0x7c010001
  78:	001d0c1f 	0x1d0c1f
  7c:	00000018 	mult	zero,zero
  80:	0000006c 	0x6c
  84:	bfc09fb0 	0xbfc09fb0
  88:	00000088 	0x88
  8c:	50200e44 	0x50200e44
  90:	02920490 	0x2920490
  94:	0391019f 	0x391019f
  98:	00000014 	0x14
  9c:	0000006c 	0x6c
  a0:	bfc0a038 	0xbfc0a038
  a4:	00000030 	0x30
  a8:	44180e44 	0x44180e44
  ac:	0000019f 	0x19f
  b0:	0000000c 	syscall
  b4:	ffffffff 	0xffffffff
  b8:	7c010001 	0x7c010001
  bc:	001d0c1f 	0x1d0c1f
  c0:	0000001c 	0x1c
  c4:	000000b0 	0xb0
  c8:	bfc0a070 	0xbfc0a070
  cc:	00000100 	sll	zero,zero,0x4
  d0:	54680e44 	0x54680e44
  d4:	04910590 	bgezal	a0,1718 <data_size+0xd34>
  d8:	0392019f 	0x392019f
  dc:	00000293 	0x293
  e0:	0000000c 	syscall
  e4:	ffffffff 	0xffffffff
  e8:	7c010001 	0x7c010001
  ec:	001d0c1f 	0x1d0c1f
  f0:	0000000c 	syscall
  f4:	000000e0 	0xe0
  f8:	bfc0a170 	0xbfc0a170
  fc:	00000010 	mfhi	zero
 100:	0000000c 	syscall
 104:	000000e0 	0xe0
 108:	bfc0a180 	0xbfc0a180
 10c:	00000010 	mfhi	zero
 110:	0000000c 	syscall
 114:	000000e0 	0xe0
 118:	bfc0a190 	0xbfc0a190
 11c:	00000010 	mfhi	zero
 120:	0000000c 	syscall
 124:	000000e0 	0xe0
 128:	bfc0a1a0 	0xbfc0a1a0
 12c:	0000001c 	0x1c
 130:	00000014 	0x14
 134:	000000e0 	0xe0
 138:	bfc0a1bc 	0xbfc0a1bc
 13c:	000000cc 	syscall	0x3
 140:	44180e44 	0x44180e44
 144:	0000019f 	0x19f

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
   0:	00000000 	nop
   4:	00000004 	sllv	zero,zero,zero
   8:	046d0001 	0x46d0001
   c:	50000000 	0x50000000
  10:	02000002 	0x2000002
  14:	00388d00 	0x388d00
	...
  20:	30000000 	andi	zero,zero,0x0
  24:	01000000 	0x1000000
  28:	00305400 	0x305400
  2c:	00a40000 	0xa40000
  30:	00010000 	sll	zero,at,0x0
  34:	0000b863 	0xb863
  38:	00025000 	sll	t2,v0,0x0
  3c:	63000100 	0x63000100
	...
  48:	00000054 	0x54
  4c:	000000ac 	0xac
  50:	b8610001 	swr	at,1(v1)
  54:	50000000 	0x50000000
  58:	01000002 	0x1000002
  5c:	00006100 	sll	t4,zero,0x4
  60:	00000000 	nop
  64:	004c0000 	0x4c0000
  68:	00a80000 	0xa80000
  6c:	00010000 	sll	zero,at,0x0
  70:	0000b862 	0xb862
  74:	00025000 	sll	t2,v0,0x0
  78:	62000100 	0x62000100
	...
  84:	000000c0 	sll	zero,zero,0x3
  88:	000000dc 	0xdc
  8c:	e4550001 	swc1	$f21,1(v0)
  90:	24000000 	li	zero,0
  94:	01000001 	0x1000001
  98:	01345500 	0x1345500
  9c:	01440000 	0x1440000
  a0:	00010000 	sll	zero,at,0x0
  a4:	00015055 	0x15055
  a8:	00015c00 	sll	t3,at,0x10
  ac:	55000100 	0x55000100
  b0:	00000164 	0x164
  b4:	00000174 	0x174
  b8:	80550001 	lb	s5,1(v0)
  bc:	90000001 	lbu	zero,1(zero)
  c0:	01000001 	0x1000001
  c4:	019c5500 	0x19c5500
  c8:	01ac0000 	0x1ac0000
  cc:	00010000 	sll	zero,at,0x0
  d0:	0001b855 	0x1b855
  d4:	0001c800 	sll	t9,at,0x0
  d8:	55000100 	0x55000100
  dc:	000001d4 	0x1d4
  e0:	000001e0 	0x1e0
  e4:	e8550001 	swc2	$21,1(v0)
  e8:	f8000001 	0xf8000001
  ec:	01000001 	0x1000001
  f0:	02045500 	0x2045500
  f4:	020c0000 	0x20c0000
  f8:	00010000 	sll	zero,at,0x0
  fc:	00021455 	0x21455
 100:	00025000 	sll	t2,v0,0x0
 104:	55000100 	0x55000100
	...
 110:	00000014 	0x14
 114:	00000018 	mult	zero,zero
 118:	186d0001 	0x186d0001
 11c:	34000000 	li	zero,0x0
 120:	02000000 	0x2000000
 124:	00188d00 	sll	s1,t8,0x14
 128:	00000000 	nop
 12c:	14000000 	bnez	zero,130 <data_size-0x8b4>
 130:	24000000 	li	zero,0
 134:	01000000 	0x1000000
 138:	00005400 	sll	t2,zero,0x10
	...
 144:	00040000 	sll	zero,a0,0x0
 148:	00010000 	sll	zero,at,0x0
 14c:	0000046d 	0x46d
 150:	00008800 	sll	s1,zero,0x0
 154:	8d000200 	lw	zero,512(t0)
 158:	00000020 	add	zero,zero,zero
	...
 164:	00002400 	sll	a0,zero,0x10
 168:	54000100 	0x54000100
 16c:	00000024 	and	zero,zero,zero
 170:	0000007c 	0x7c
 174:	7c610001 	0x7c610001
 178:	88000000 	lwl	zero,0(zero)
 17c:	01000000 	0x1000000
 180:	00005400 	sll	t2,zero,0x10
 184:	00000000 	nop
 188:	001c0000 	sll	zero,gp,0x0
 18c:	00800000 	0x800000
 190:	00010000 	sll	zero,at,0x0
 194:	00000060 	0x60
 198:	00000000 	nop
 19c:	00008800 	sll	s1,zero,0x0
 1a0:	00008c00 	sll	s1,zero,0x10
 1a4:	6d000100 	0x6d000100
 1a8:	0000008c 	syscall	0x2
 1ac:	000000b8 	0xb8
 1b0:	188d0002 	0x188d0002
	...
 1bc:	00000088 	0x88
 1c0:	00000098 	0x98
 1c4:	00540001 	0x540001
	...
 1d0:	04000000 	bltz	zero,1d4 <data_size-0x810>
 1d4:	01000000 	0x1000000
 1d8:	00046d00 	sll	t5,a0,0x14
 1dc:	01000000 	0x1000000
 1e0:	00030000 	sll	zero,v1,0x0
 1e4:	0000e88d 	break	0x0,0x3a2
	...
 1f0:	28000000 	slti	zero,zero,0
 1f4:	01000000 	0x1000000
 1f8:	00285400 	0x285400
 1fc:	00600000 	0x600000
 200:	00010000 	sll	zero,at,0x0
 204:	00006853 	0x6853
 208:	00006c00 	sll	t5,zero,0x10
 20c:	53000100 	0x53000100
 210:	0000006c 	0x6c
 214:	00000098 	0x98
 218:	ac540001 	sw	s4,1(v0)
 21c:	d4000000 	0xd4000000
 220:	01000000 	0x1000000
 224:	00e85400 	0xe85400
 228:	00e80000 	0xe80000
 22c:	00010000 	sll	zero,at,0x0
 230:	0000e854 	0xe854
 234:	0000f000 	sll	s8,zero,0x0
 238:	53000100 	0x53000100
 23c:	000000f8 	0xf8
 240:	000000f8 	0xf8
 244:	00530001 	0x530001
	...
 250:	28000000 	slti	zero,zero,0
 254:	01000000 	0x1000000
 258:	00285500 	0x285500
 25c:	00980000 	0x980000
 260:	00010000 	sll	zero,at,0x0
 264:	00009863 	0x9863
 268:	0000a400 	sll	s4,zero,0x10
 26c:	55000100 	0x55000100
 270:	000000ac 	0xac
 274:	000000b8 	0xb8
 278:	b8630001 	swr	v1,1(v1)
 27c:	cc000000 	lwc3	$0,0(zero)
 280:	01000000 	0x1000000
 284:	00cc5500 	0xcc5500
 288:	00d40000 	0xd40000
 28c:	00010000 	sll	zero,at,0x0
 290:	0000d463 	0xd463
 294:	0000e800 	sll	sp,zero,0x0
 298:	55000100 	0x55000100
 29c:	000000e8 	0xe8
 2a0:	000000f8 	0xf8
 2a4:	f8630001 	0xf8630001
 2a8:	00000000 	nop
 2ac:	01000001 	0x1000001
 2b0:	00005500 	sll	t2,zero,0x14
	...
 2bc:	00280000 	0x280000
 2c0:	00010000 	sll	zero,at,0x0
 2c4:	00002856 	0x2856
 2c8:	00008800 	sll	s1,zero,0x0
 2cc:	62000100 	0x62000100
 2d0:	00000088 	0x88
 2d4:	000000a4 	0xa4
 2d8:	ac560001 	sw	s6,1(v0)
 2dc:	bc000000 	0xbc000000
 2e0:	01000000 	0x1000000
 2e4:	00bc6200 	0xbc6200
 2e8:	00e80000 	0xe80000
 2ec:	00010000 	sll	zero,at,0x0
 2f0:	0000e856 	0xe856
 2f4:	0000f800 	sll	ra,zero,0x0
 2f8:	62000100 	0x62000100
 2fc:	000000f8 	0xf8
 300:	00000100 	sll	zero,zero,0x4
 304:	00560001 	0x560001
	...
 310:	a4000000 	sh	zero,0(zero)
 314:	01000000 	0x1000000
 318:	00ac5700 	0xac5700
 31c:	00f00000 	0xf00000
 320:	00010000 	sll	zero,at,0x0
 324:	0000f857 	0xf857
 328:	00010000 	sll	zero,at,0x0
 32c:	57000100 	0x57000100
	...
 338:	0000003c 	0x3c
 33c:	000000c0 	sll	zero,zero,0x3
 340:	cc610001 	lwc3	$1,1(v1)
 344:	e8000000 	swc2	$0,0(zero)
 348:	01000000 	0x1000000
 34c:	00f86100 	0xf86100
 350:	01000000 	0x1000000
 354:	00010000 	sll	zero,at,0x0
 358:	00000061 	0x61
 35c:	00000000 	nop
 360:	00006c00 	sll	t5,zero,0x10
 364:	0000a400 	sll	s4,zero,0x10
 368:	53000100 	0x53000100
 36c:	000000ac 	0xac
 370:	000000e8 	0xe8
 374:	f8530001 	0xf8530001
 378:	00000000 	nop
 37c:	01000001 	0x1000001
 380:	00005300 	sll	t2,zero,0xc
 384:	00000000 	nop
 388:	00d40000 	0xd40000
 38c:	00e00000 	0xe00000
 390:	00010000 	sll	zero,at,0x0
 394:	0000f854 	0xf854
 398:	0000f800 	sll	ra,zero,0x0
 39c:	54000100 	0x54000100
	...
 3a8:	00000034 	0x34
 3ac:	00000080 	sll	zero,zero,0x2
 3b0:	ac600001 	sw	zero,1(v1)
 3b4:	c4000000 	lwc1	$f0,0(zero)
 3b8:	01000000 	0x1000000
 3bc:	00e86000 	0xe86000
 3c0:	00f80000 	0xf80000
 3c4:	00010000 	sll	zero,at,0x0
 3c8:	00000060 	0x60
 3cc:	00000000 	nop
 3d0:	00003c00 	sll	a3,zero,0x10
 3d4:	00004400 	sll	t0,zero,0x10
 3d8:	52000100 	0x52000100
	...
 3e4:	0000004c 	syscall	0x1
 3e8:	00000050 	0x50
 3ec:	506d0001 	0x506d0001
 3f0:	18000000 	blez	zero,3f4 <data_size-0x5f0>
 3f4:	02000001 	0x2000001
 3f8:	00188d00 	sll	s1,t8,0x14
 3fc:	00000000 	nop
 400:	4c000000 	mfc3	zero,$0
 404:	94000000 	lhu	zero,0(zero)
 408:	01000000 	0x1000000
 40c:	00005400 	sll	t2,zero,0x10
 410:	00000000 	nop
 414:	004c0000 	0x4c0000
 418:	007c0000 	0x7c0000
 41c:	00010000 	sll	zero,at,0x0
 420:	00007c55 	0x7c55
 424:	00010800 	sll	at,at,0x0
 428:	5a000100 	0x5a000100
	...
 434:	00000060 	0x60
 438:	000000c4 	0xc4
 43c:	00560001 	0x560001
 440:	00000000 	nop
 444:	Address 0x0000000000000444 is out of bounds.


Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	69616761 	0x69616761
   4:	6f6c006e 	0x6f6c006e
   8:	7520676e 	jalx	4819db8 <data_size+0x48193d4>
   c:	6769736e 	0x6769736e
  10:	2064656e 	addi	a0,v1,25966
  14:	00746e69 	0x746e69
  18:	20554e47 	addi	s5,v0,20039
  1c:	2e342043 	sltiu	s4,s1,8259
  20:	20302e33 	addi	s0,at,11827
  24:	7000672d 	0x7000672d
  28:	746e6972 	jalx	1b9a5c8 <data_size+0x1b99be4>
  2c:	00632e66 	0x632e66
  30:	746e6d2f 	jalx	1b9b4bc <data_size+0x1b9aad8>
  34:	7265702f 	0x7265702f
  38:	616c5f66 	0x616c5f66
  3c:	6c2f3262 	0x6c2f3262
  40:	70006269 	0x70006269
  44:	746e6972 	jalx	1b9a5c8 <data_size+0x1b99be4>
  48:	67740066 	0x67740066
  4c:	75705f74 	jalx	5c17dd0 <data_size+0x5c173ec>
  50:	61686374 	0x61686374
  54:	75700072 	jalx	5c001c8 <data_size+0x5bff7e4>
  58:	61686374 	0x61686374
  5c:	00632e72 	0x632e72
  60:	73747570 	0x73747570
  64:	7000632e 	0x7000632e
  68:	00737475 	0x737475
  6c:	73747570 	0x73747570
  70:	6e697274 	0x6e697274
  74:	72700067 	0x72700067
  78:	62746e69 	0x62746e69
  7c:	2e657361 	sltiu	a1,s3,29537
  80:	61760063 	0x61760063
  84:	0065756c 	0x65756c
  88:	676e6f6c 	0x676e6f6c
  8c:	746e6920 	jalx	1b9a480 <data_size+0x1b99a9c>
  90:	67697300 	0x67697300
  94:	7270006e 	0x7270006e
  98:	62746e69 	0x62746e69
  9c:	00657361 	0x657361
  a0:	7465675f 	jalx	1959d7c <data_size+0x1959398>
  a4:	756f635f 	jalx	5bd8d7c <data_size+0x5bd8398>
  a8:	7400746e 	jalx	1d1b8 <data_size+0x1c7d4>
  ac:	73656d69 	0x73656d69
  b0:	00636570 	0x636570
  b4:	6f6c635f 	0x6f6c635f
  b8:	745f6b63 	jalx	17dad8c <data_size+0x17da3a8>
  bc:	5f767400 	0x5f767400
  c0:	6365736d 	0x6365736d
  c4:	74656700 	jalx	1959c00 <data_size+0x195921c>
  c8:	00736e5f 	0x736e5f
  cc:	656d6974 	0x656d6974
  d0:	5f00632e 	0x5f00632e
  d4:	746e6f63 	jalx	1b9bd8c <data_size+0x1b9b3a8>
  d8:	006c6176 	0x6c6176
  dc:	5f746567 	0x5f746567
  e0:	636f6c63 	0x636f6c63
  e4:	7674006b 	jalx	9d001ac <data_size+0x9cff7c8>
  e8:	6573755f 	0x6573755f
  ec:	76740063 	jalx	9d0018c <data_size+0x9cff7a8>
  f0:	6365735f 	0x6365735f
  f4:	5f767400 	0x5f767400
  f8:	6365736e 	0x6365736e
  fc:	6f6c6300 	0x6f6c6300
 100:	675f6b63 	0x675f6b63
 104:	69747465 	0x69747465
 108:	Address 0x0000000000000108 is out of bounds.

