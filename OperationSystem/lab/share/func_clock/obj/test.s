
main.elf:     file format elf32-tradlittlemips
main.elf


Disassembly of section .text:

bfc00000 <_ftext>:
/mnt/shared/func_clock/start.S:52
bfc00000:	24100000 	li	s0,0
/mnt/shared/func_clock/start.S:53
bfc00004:	24110005 	li	s1,5
/mnt/shared/func_clock/start.S:54
bfc00008:	24120009 	li	s2,9
/mnt/shared/func_clock/start.S:55
bfc0000c:	24130005 	li	s3,5
/mnt/shared/func_clock/start.S:56
bfc00010:	24140003 	li	s4,3
/mnt/shared/func_clock/start.S:57
bfc00014:	24150002 	li	s5,2
/mnt/shared/func_clock/start.S:67
bfc00018:	24170000 	li	s7,0
/mnt/shared/func_clock/start.S:68
bfc0001c:	241e0000 	li	s8,0
/mnt/shared/func_clock/start.S:72
bfc00020:	24080005 	li	t0,5
/mnt/shared/func_clock/start.S:73
bfc00024:	24090000 	li	t1,0
/mnt/shared/func_clock/start.S:74
bfc00028:	240a0000 	li	t2,0
/mnt/shared/func_clock/start.S:75
bfc0002c:	240b0000 	li	t3,0
/mnt/shared/func_clock/start.S:76
bfc00030:	240c0000 	li	t4,0
/mnt/shared/func_clock/start.S:77
bfc00034:	240d0000 	li	t5,0
/mnt/shared/func_clock/start.S:79
bfc00038:	240e0000 	li	t6,0
/mnt/shared/func_clock/start.S:80
bfc0003c:	240f0000 	li	t7,0
/mnt/shared/func_clock/start.S:81
bfc00040:	24180000 	li	t8,0
/mnt/shared/func_clock/start.S:83
bfc00044:	40906800 	mtc0	s0,c0_cause
/mnt/shared/func_clock/start.S:84
bfc00048:	00000000 	nop
/mnt/shared/func_clock/start.S:86
bfc0004c:	24040258 	li	a0,600
bfc00050:	40845800 	mtc0	a0,c0_compare
bfc00054:	00000000 	nop
bfc00058:	40804800 	mtc0	zero,c0_count
bfc0005c:	00000000 	nop
/mnt/shared/func_clock/start.S:89
bfc00060:	3c041000 	lui	a0,0x1000
bfc00064:	3484ff01 	ori	a0,a0,0xff01
/mnt/shared/func_clock/start.S:90
bfc00068:	40846000 	mtc0	a0,c0_sr
/mnt/shared/func_clock/start.S:91
bfc0006c:	00000000 	nop

bfc00070 <loop>:
/mnt/shared/func_clock/start.S:95
bfc00070:	1000ffff 	b	bfc00070 <loop>
/mnt/shared/func_clock/start.S:96
bfc00074:	00000000 	nop
	...
/mnt/shared/func_clock/start.S:100
bfc00380:	40046000 	mfc0	a0,c0_sr
/mnt/shared/func_clock/start.S:101
bfc00384:	00000000 	nop
/mnt/shared/func_clock/start.S:102
bfc00388:	40056800 	mfc0	a1,c0_cause
/mnt/shared/func_clock/start.S:103
bfc0038c:	00000000 	nop
/mnt/shared/func_clock/start.S:108
bfc00390:	00a42824 	and	a1,a1,a0
/mnt/shared/func_clock/start.S:110
bfc00394:	34068000 	li	a2,0x8000
/mnt/shared/func_clock/start.S:111
bfc00398:	24077f00 	li	a3,32512
/mnt/shared/func_clock/start.S:112
bfc0039c:	00c53024 	and	a2,a2,a1
/mnt/shared/func_clock/start.S:113
bfc003a0:	00e53824 	and	a3,a3,a1
/mnt/shared/func_clock/start.S:117
bfc003a4:	14c00005 	bnez	a2,bfc003bc <time_int>
/mnt/shared/func_clock/start.S:118
bfc003a8:	00000000 	nop
/mnt/shared/func_clock/start.S:119
bfc003ac:	14e000aa 	bnez	a3,bfc00658 <key_int>
/mnt/shared/func_clock/start.S:120
bfc003b0:	00000000 	nop

bfc003b4 <int_eret>:
/mnt/shared/func_clock/start.S:122
bfc003b4:	42000018 	eret
/mnt/shared/func_clock/start.S:123
bfc003b8:	00000000 	nop

bfc003bc <time_int>:
/mnt/shared/func_clock/start.S:127
bfc003bc:	40046000 	mfc0	a0,c0_sr
/mnt/shared/func_clock/start.S:128
bfc003c0:	30848000 	andi	a0,a0,0x8000
/mnt/shared/func_clock/start.S:129
bfc003c4:	14800003 	bnez	a0,bfc003d4 <time_int+0x18>
/mnt/shared/func_clock/start.S:130
bfc003c8:	00000000 	nop
/mnt/shared/func_clock/start.S:131
bfc003cc:	42000018 	eret
/mnt/shared/func_clock/start.S:132
bfc003d0:	00000000 	nop
/mnt/shared/func_clock/start.S:135
bfc003d4:	24040258 	li	a0,600
bfc003d8:	40845800 	mtc0	a0,c0_compare
bfc003dc:	00000000 	nop
bfc003e0:	40804800 	mtc0	zero,c0_count
	...
/mnt/shared/func_clock/start.S:138
bfc003ec:	26100001 	addiu	s0,s0,1
/mnt/shared/func_clock/start.S:139
bfc003f0:	0ff00114 	jal	bfc00450 <update_time>
/mnt/shared/func_clock/start.S:140
bfc003f4:	00000000 	nop
/mnt/shared/func_clock/start.S:141
bfc003f8:	0ff0017b 	jal	bfc005ec <time_print>
/mnt/shared/func_clock/start.S:142
bfc003fc:	00000000 	nop
/mnt/shared/func_clock/start.S:145
bfc00400:	1608000d 	bne	s0,t0,bfc00438 <noalarm>
/mnt/shared/func_clock/start.S:146
bfc00404:	00000000 	nop
/mnt/shared/func_clock/start.S:147
bfc00408:	1629000b 	bne	s1,t1,bfc00438 <noalarm>
/mnt/shared/func_clock/start.S:148
bfc0040c:	00000000 	nop
/mnt/shared/func_clock/start.S:149
bfc00410:	164a0009 	bne	s2,t2,bfc00438 <noalarm>
/mnt/shared/func_clock/start.S:150
bfc00414:	00000000 	nop
/mnt/shared/func_clock/start.S:151
bfc00418:	166b0007 	bne	s3,t3,bfc00438 <noalarm>
/mnt/shared/func_clock/start.S:152
bfc0041c:	00000000 	nop
/mnt/shared/func_clock/start.S:153
bfc00420:	168c0005 	bne	s4,t4,bfc00438 <noalarm>
/mnt/shared/func_clock/start.S:154
bfc00424:	00000000 	nop
/mnt/shared/func_clock/start.S:155
bfc00428:	16ad0003 	bne	s5,t5,bfc00438 <noalarm>
/mnt/shared/func_clock/start.S:156
bfc0042c:	00000000 	nop
/mnt/shared/func_clock/start.S:157
bfc00430:	0ff0018e 	jal	bfc00638 <show_alarm>
/mnt/shared/func_clock/start.S:158
bfc00434:	00000000 	nop

bfc00438 <noalarm>:
/mnt/shared/func_clock/start.S:160
bfc00438:	00000000 	nop
/mnt/shared/func_clock/start.S:166
bfc0043c:	3c1abfc0 	lui	k0,0xbfc0
bfc00440:	275a0070 	addiu	k0,k0,112
/mnt/shared/func_clock/start.S:167
bfc00444:	409a7000 	mtc0	k0,c0_epc
/mnt/shared/func_clock/start.S:168
bfc00448:	00000000 	nop
/mnt/shared/func_clock/start.S:169
bfc0044c:	42000018 	eret

bfc00450 <update_time>:
/mnt/shared/func_clock/start.S:174
bfc00450:	241a000a 	li	k0,10
/mnt/shared/func_clock/start.S:175
bfc00454:	161a0003 	bne	s0,k0,bfc00464 <update_time+0x14>
/mnt/shared/func_clock/start.S:176
bfc00458:	00000000 	nop
/mnt/shared/func_clock/start.S:177
bfc0045c:	26310001 	addiu	s1,s1,1
/mnt/shared/func_clock/start.S:178
bfc00460:	00008024 	and	s0,zero,zero
/mnt/shared/func_clock/start.S:181
bfc00464:	241a0006 	li	k0,6
/mnt/shared/func_clock/start.S:182
bfc00468:	163a0003 	bne	s1,k0,bfc00478 <update_time+0x28>
/mnt/shared/func_clock/start.S:183
bfc0046c:	00000000 	nop
/mnt/shared/func_clock/start.S:184
bfc00470:	26520001 	addiu	s2,s2,1
/mnt/shared/func_clock/start.S:185
bfc00474:	00008824 	and	s1,zero,zero
/mnt/shared/func_clock/start.S:188
bfc00478:	241a000a 	li	k0,10
/mnt/shared/func_clock/start.S:189
bfc0047c:	165a0003 	bne	s2,k0,bfc0048c <update_time+0x3c>
/mnt/shared/func_clock/start.S:190
bfc00480:	00000000 	nop
/mnt/shared/func_clock/start.S:191
bfc00484:	26730001 	addiu	s3,s3,1
/mnt/shared/func_clock/start.S:192
bfc00488:	00009024 	and	s2,zero,zero
/mnt/shared/func_clock/start.S:195
bfc0048c:	241a0006 	li	k0,6
/mnt/shared/func_clock/start.S:196
bfc00490:	167a0003 	bne	s3,k0,bfc004a0 <update_time+0x50>
/mnt/shared/func_clock/start.S:197
bfc00494:	00000000 	nop
/mnt/shared/func_clock/start.S:198
bfc00498:	26940001 	addiu	s4,s4,1
/mnt/shared/func_clock/start.S:199
bfc0049c:	00009824 	and	s3,zero,zero
/mnt/shared/func_clock/start.S:202
bfc004a0:	241b0002 	li	k1,2
/mnt/shared/func_clock/start.S:203
bfc004a4:	12bb0008 	beq	s5,k1,bfc004c8 <h2x>
/mnt/shared/func_clock/start.S:204
bfc004a8:	00000000 	nop
/mnt/shared/func_clock/start.S:206
bfc004ac:	241a000a 	li	k0,10
/mnt/shared/func_clock/start.S:207
bfc004b0:	169a000a 	bne	s4,k0,bfc004dc <h2x+0x14>
/mnt/shared/func_clock/start.S:208
bfc004b4:	00000000 	nop
/mnt/shared/func_clock/start.S:209
bfc004b8:	26b50001 	addiu	s5,s5,1
/mnt/shared/func_clock/start.S:210
bfc004bc:	0000a024 	and	s4,zero,zero
/mnt/shared/func_clock/start.S:211
bfc004c0:	10000006 	b	bfc004dc <h2x+0x14>
/mnt/shared/func_clock/start.S:212
bfc004c4:	00000000 	nop

bfc004c8 <h2x>:
/mnt/shared/func_clock/start.S:215
bfc004c8:	241a0004 	li	k0,4
/mnt/shared/func_clock/start.S:216
bfc004cc:	169a0003 	bne	s4,k0,bfc004dc <h2x+0x14>
/mnt/shared/func_clock/start.S:217
bfc004d0:	00000000 	nop
/mnt/shared/func_clock/start.S:218
bfc004d4:	26b50001 	addiu	s5,s5,1
/mnt/shared/func_clock/start.S:219
bfc004d8:	0000a024 	and	s4,zero,zero
/mnt/shared/func_clock/start.S:222
bfc004dc:	241a0003 	li	k0,3
/mnt/shared/func_clock/start.S:223
bfc004e0:	16ba0002 	bne	s5,k0,bfc004ec <h2x+0x24>
/mnt/shared/func_clock/start.S:224
bfc004e4:	00000000 	nop
/mnt/shared/func_clock/start.S:225
bfc004e8:	0000a824 	and	s5,zero,zero
/mnt/shared/func_clock/start.S:227
bfc004ec:	00000000 	nop
/mnt/shared/func_clock/start.S:228
bfc004f0:	03e00008 	jr	ra
/mnt/shared/func_clock/start.S:229
bfc004f4:	00000000 	nop

bfc004f8 <alarm_print>:
/mnt/shared/func_clock/start.S:232
bfc004f8:	241a0000 	li	k0,0
/mnt/shared/func_clock/start.S:233
bfc004fc:	0008d800 	sll	k1,t0,0x0
/mnt/shared/func_clock/start.S:234
bfc00500:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:235
bfc00504:	0009d900 	sll	k1,t1,0x4
/mnt/shared/func_clock/start.S:236
bfc00508:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:237
bfc0050c:	000ada00 	sll	k1,t2,0x8
/mnt/shared/func_clock/start.S:238
bfc00510:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:239
bfc00514:	000bdb00 	sll	k1,t3,0xc
/mnt/shared/func_clock/start.S:240
bfc00518:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:241
bfc0051c:	000cdc00 	sll	k1,t4,0x10
/mnt/shared/func_clock/start.S:242
bfc00520:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:243
bfc00524:	000ddd00 	sll	k1,t5,0x14
/mnt/shared/func_clock/start.S:244
bfc00528:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:245
bfc0052c:	3c1bbfaf 	lui	k1,0xbfaf
bfc00530:	377bf010 	ori	k1,k1,0xf010
/mnt/shared/func_clock/start.S:246
bfc00534:	af7a0000 	sw	k0,0(k1)
/mnt/shared/func_clock/start.S:247
bfc00538:	00000000 	nop
/mnt/shared/func_clock/start.S:248
bfc0053c:	03e00008 	jr	ra
/mnt/shared/func_clock/start.S:249
bfc00540:	00000000 	nop

bfc00544 <update_alarm>:
/mnt/shared/func_clock/start.S:253
bfc00544:	241a000a 	li	k0,10
/mnt/shared/func_clock/start.S:254
bfc00548:	151a0003 	bne	t0,k0,bfc00558 <update_alarm+0x14>
/mnt/shared/func_clock/start.S:255
bfc0054c:	00000000 	nop
/mnt/shared/func_clock/start.S:256
bfc00550:	25290001 	addiu	t1,t1,1
/mnt/shared/func_clock/start.S:257
bfc00554:	00004024 	and	t0,zero,zero
/mnt/shared/func_clock/start.S:260
bfc00558:	241a0006 	li	k0,6
/mnt/shared/func_clock/start.S:261
bfc0055c:	153a0003 	bne	t1,k0,bfc0056c <update_alarm+0x28>
/mnt/shared/func_clock/start.S:262
bfc00560:	00000000 	nop
/mnt/shared/func_clock/start.S:263
bfc00564:	254a0001 	addiu	t2,t2,1
/mnt/shared/func_clock/start.S:264
bfc00568:	00004824 	and	t1,zero,zero
/mnt/shared/func_clock/start.S:267
bfc0056c:	241a000a 	li	k0,10
/mnt/shared/func_clock/start.S:268
bfc00570:	155a0003 	bne	t2,k0,bfc00580 <update_alarm+0x3c>
/mnt/shared/func_clock/start.S:269
bfc00574:	00000000 	nop
/mnt/shared/func_clock/start.S:270
bfc00578:	256b0001 	addiu	t3,t3,1
/mnt/shared/func_clock/start.S:271
bfc0057c:	00005024 	and	t2,zero,zero
/mnt/shared/func_clock/start.S:274
bfc00580:	241a0006 	li	k0,6
/mnt/shared/func_clock/start.S:275
bfc00584:	157a0003 	bne	t3,k0,bfc00594 <update_alarm+0x50>
/mnt/shared/func_clock/start.S:276
bfc00588:	00000000 	nop
/mnt/shared/func_clock/start.S:277
bfc0058c:	258c0001 	addiu	t4,t4,1
/mnt/shared/func_clock/start.S:278
bfc00590:	00005824 	and	t3,zero,zero
/mnt/shared/func_clock/start.S:281
bfc00594:	241b0002 	li	k1,2
/mnt/shared/func_clock/start.S:282
bfc00598:	11bb0008 	beq	t5,k1,bfc005bc <ah2x>
/mnt/shared/func_clock/start.S:283
bfc0059c:	00000000 	nop
/mnt/shared/func_clock/start.S:285
bfc005a0:	241a000a 	li	k0,10
/mnt/shared/func_clock/start.S:286
bfc005a4:	159a000a 	bne	t4,k0,bfc005d0 <ah2x+0x14>
/mnt/shared/func_clock/start.S:287
bfc005a8:	00000000 	nop
/mnt/shared/func_clock/start.S:288
bfc005ac:	25ad0001 	addiu	t5,t5,1
/mnt/shared/func_clock/start.S:289
bfc005b0:	00006024 	and	t4,zero,zero
/mnt/shared/func_clock/start.S:290
bfc005b4:	10000006 	b	bfc005d0 <ah2x+0x14>
/mnt/shared/func_clock/start.S:291
bfc005b8:	00000000 	nop

bfc005bc <ah2x>:
/mnt/shared/func_clock/start.S:294
bfc005bc:	241a0004 	li	k0,4
/mnt/shared/func_clock/start.S:295
bfc005c0:	159a0003 	bne	t4,k0,bfc005d0 <ah2x+0x14>
/mnt/shared/func_clock/start.S:296
bfc005c4:	00000000 	nop
/mnt/shared/func_clock/start.S:297
bfc005c8:	25ad0001 	addiu	t5,t5,1
/mnt/shared/func_clock/start.S:298
bfc005cc:	00006024 	and	t4,zero,zero
/mnt/shared/func_clock/start.S:301
bfc005d0:	241a0003 	li	k0,3
/mnt/shared/func_clock/start.S:302
bfc005d4:	15ba0002 	bne	t5,k0,bfc005e0 <ah2x+0x24>
/mnt/shared/func_clock/start.S:303
bfc005d8:	00000000 	nop
/mnt/shared/func_clock/start.S:304
bfc005dc:	00006824 	and	t5,zero,zero
/mnt/shared/func_clock/start.S:306
bfc005e0:	00000000 	nop
/mnt/shared/func_clock/start.S:307
bfc005e4:	03e00008 	jr	ra
/mnt/shared/func_clock/start.S:308
bfc005e8:	00000000 	nop

bfc005ec <time_print>:
/mnt/shared/func_clock/start.S:312
bfc005ec:	241a0000 	li	k0,0
/mnt/shared/func_clock/start.S:313
bfc005f0:	0010d800 	sll	k1,s0,0x0
/mnt/shared/func_clock/start.S:314
bfc005f4:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:315
bfc005f8:	0011d900 	sll	k1,s1,0x4
/mnt/shared/func_clock/start.S:316
bfc005fc:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:317
bfc00600:	0012da00 	sll	k1,s2,0x8
/mnt/shared/func_clock/start.S:318
bfc00604:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:319
bfc00608:	0013db00 	sll	k1,s3,0xc
/mnt/shared/func_clock/start.S:320
bfc0060c:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:321
bfc00610:	0014dc00 	sll	k1,s4,0x10
/mnt/shared/func_clock/start.S:322
bfc00614:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:323
bfc00618:	0015dd00 	sll	k1,s5,0x14
/mnt/shared/func_clock/start.S:324
bfc0061c:	035bd021 	addu	k0,k0,k1
/mnt/shared/func_clock/start.S:325
bfc00620:	3c1bbfaf 	lui	k1,0xbfaf
bfc00624:	377bf010 	ori	k1,k1,0xf010
/mnt/shared/func_clock/start.S:326
bfc00628:	af7a0000 	sw	k0,0(k1)
/mnt/shared/func_clock/start.S:327
bfc0062c:	00000000 	nop
/mnt/shared/func_clock/start.S:328
bfc00630:	03e00008 	jr	ra
/mnt/shared/func_clock/start.S:329
bfc00634:	00000000 	nop

bfc00638 <show_alarm>:
/mnt/shared/func_clock/start.S:332
bfc00638:	3c1a00ff 	lui	k0,0xff
bfc0063c:	375affff 	ori	k0,k0,0xffff
/mnt/shared/func_clock/start.S:333
bfc00640:	3c1bbfaf 	lui	k1,0xbfaf
bfc00644:	377bf010 	ori	k1,k1,0xf010
/mnt/shared/func_clock/start.S:334
bfc00648:	af7a0000 	sw	k0,0(k1)
/mnt/shared/func_clock/start.S:335
bfc0064c:	00000000 	nop
/mnt/shared/func_clock/start.S:336
bfc00650:	03e00008 	jr	ra
/mnt/shared/func_clock/start.S:337
bfc00654:	00000000 	nop

bfc00658 <key_int>:
/mnt/shared/func_clock/start.S:342
bfc00658:	401b6800 	mfc0	k1,c0_cause
/mnt/shared/func_clock/start.S:343
bfc0065c:	00000000 	nop
/mnt/shared/func_clock/start.S:344
bfc00660:	337bff00 	andi	k1,k1,0xff00
/mnt/shared/func_clock/start.S:345
bfc00664:	001bda82 	srl	k1,k1,0xa
/mnt/shared/func_clock/start.S:348
bfc00668:	24040007 	li	a0,7
/mnt/shared/func_clock/start.S:349
bfc0066c:	149b0010 	bne	a0,k1,bfc006b0 <s7z+0x18>
/mnt/shared/func_clock/start.S:350
bfc00670:	00000000 	nop
/mnt/shared/func_clock/start.S:353
bfc00674:	12e00008 	beqz	s7,bfc00698 <s7z>
/mnt/shared/func_clock/start.S:354
bfc00678:	00000000 	nop
/mnt/shared/func_clock/start.S:355
bfc0067c:	24170000 	li	s7,0
/mnt/shared/func_clock/start.S:356
bfc00680:	3c051000 	lui	a1,0x1000
bfc00684:	34a5ff03 	ori	a1,a1,0xff03
/mnt/shared/func_clock/start.S:357
bfc00688:	40856000 	mtc0	a1,c0_sr
/mnt/shared/func_clock/start.S:358
bfc0068c:	00000000 	nop
/mnt/shared/func_clock/start.S:359
bfc00690:	10000006 	b	bfc006ac <s7z+0x14>
/mnt/shared/func_clock/start.S:360
bfc00694:	00000000 	nop

bfc00698 <s7z>:
/mnt/shared/func_clock/start.S:362
bfc00698:	24170001 	li	s7,1
/mnt/shared/func_clock/start.S:363
bfc0069c:	3c051000 	lui	a1,0x1000
bfc006a0:	34a57f03 	ori	a1,a1,0x7f03
/mnt/shared/func_clock/start.S:364
bfc006a4:	40856000 	mtc0	a1,c0_sr
/mnt/shared/func_clock/start.S:365
bfc006a8:	00000000 	nop
/mnt/shared/func_clock/start.S:367
bfc006ac:	42000018 	eret
/mnt/shared/func_clock/start.S:371
bfc006b0:	24040008 	li	a0,8
/mnt/shared/func_clock/start.S:372
bfc006b4:	149b0013 	bne	a0,k1,bfc00704 <s8z+0x24>
/mnt/shared/func_clock/start.S:373
bfc006b8:	00000000 	nop
/mnt/shared/func_clock/start.S:376
bfc006bc:	13c00008 	beqz	s8,bfc006e0 <s8z>
/mnt/shared/func_clock/start.S:377
bfc006c0:	00000000 	nop
/mnt/shared/func_clock/start.S:378
bfc006c4:	241e0000 	li	s8,0
/mnt/shared/func_clock/start.S:379
bfc006c8:	3c051000 	lui	a1,0x1000
bfc006cc:	34a5ff03 	ori	a1,a1,0xff03
/mnt/shared/func_clock/start.S:380
bfc006d0:	40856000 	mtc0	a1,c0_sr
/mnt/shared/func_clock/start.S:381
bfc006d4:	00000000 	nop
/mnt/shared/func_clock/start.S:382
bfc006d8:	10000008 	b	bfc006fc <s8z+0x1c>
/mnt/shared/func_clock/start.S:383
bfc006dc:	00000000 	nop

bfc006e0 <s8z>:
/mnt/shared/func_clock/start.S:385
bfc006e0:	241e0001 	li	s8,1
/mnt/shared/func_clock/start.S:386
bfc006e4:	3c051000 	lui	a1,0x1000
bfc006e8:	34a57f03 	ori	a1,a1,0x7f03
/mnt/shared/func_clock/start.S:387
bfc006ec:	40856000 	mtc0	a1,c0_sr
/mnt/shared/func_clock/start.S:388
bfc006f0:	00000000 	nop
/mnt/shared/func_clock/start.S:389
bfc006f4:	0ff0013e 	jal	bfc004f8 <alarm_print>
/mnt/shared/func_clock/start.S:390
bfc006f8:	00000000 	nop
/mnt/shared/func_clock/start.S:392
bfc006fc:	1000007e 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:393
bfc00700:	00000000 	nop
/mnt/shared/func_clock/start.S:398
bfc00704:	12e0003d 	beqz	s7,bfc007fc <key_set_alarm>
/mnt/shared/func_clock/start.S:399
bfc00708:	00000000 	nop

bfc0070c <key_set_clock>:
/mnt/shared/func_clock/start.S:404
bfc0070c:	24040001 	li	a0,1
/mnt/shared/func_clock/start.S:405
bfc00710:	149b0008 	bne	a0,k1,bfc00734 <key_set_clock+0x28>
/mnt/shared/func_clock/start.S:406
bfc00714:	00000000 	nop
/mnt/shared/func_clock/start.S:407
bfc00718:	26100001 	addiu	s0,s0,1
/mnt/shared/func_clock/start.S:408
bfc0071c:	0ff00114 	jal	bfc00450 <update_time>
/mnt/shared/func_clock/start.S:409
bfc00720:	00000000 	nop
/mnt/shared/func_clock/start.S:410
bfc00724:	0ff0017b 	jal	bfc005ec <time_print>
/mnt/shared/func_clock/start.S:411
bfc00728:	00000000 	nop
/mnt/shared/func_clock/start.S:412
bfc0072c:	10000072 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:413
bfc00730:	00000000 	nop
/mnt/shared/func_clock/start.S:416
bfc00734:	24040002 	li	a0,2
/mnt/shared/func_clock/start.S:417
bfc00738:	149b0008 	bne	a0,k1,bfc0075c <key_set_clock+0x50>
/mnt/shared/func_clock/start.S:418
bfc0073c:	00000000 	nop
/mnt/shared/func_clock/start.S:419
bfc00740:	26310001 	addiu	s1,s1,1
/mnt/shared/func_clock/start.S:420
bfc00744:	0ff00114 	jal	bfc00450 <update_time>
/mnt/shared/func_clock/start.S:421
bfc00748:	00000000 	nop
/mnt/shared/func_clock/start.S:422
bfc0074c:	0ff0017b 	jal	bfc005ec <time_print>
/mnt/shared/func_clock/start.S:423
bfc00750:	00000000 	nop
/mnt/shared/func_clock/start.S:424
bfc00754:	10000068 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:425
bfc00758:	00000000 	nop
/mnt/shared/func_clock/start.S:428
bfc0075c:	24040003 	li	a0,3
/mnt/shared/func_clock/start.S:429
bfc00760:	149b0008 	bne	a0,k1,bfc00784 <key_set_clock+0x78>
/mnt/shared/func_clock/start.S:430
bfc00764:	00000000 	nop
/mnt/shared/func_clock/start.S:431
bfc00768:	26520001 	addiu	s2,s2,1
/mnt/shared/func_clock/start.S:432
bfc0076c:	0ff00114 	jal	bfc00450 <update_time>
/mnt/shared/func_clock/start.S:433
bfc00770:	00000000 	nop
/mnt/shared/func_clock/start.S:434
bfc00774:	0ff0017b 	jal	bfc005ec <time_print>
/mnt/shared/func_clock/start.S:435
bfc00778:	00000000 	nop
/mnt/shared/func_clock/start.S:436
bfc0077c:	1000005e 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:437
bfc00780:	00000000 	nop
/mnt/shared/func_clock/start.S:440
bfc00784:	24040004 	li	a0,4
/mnt/shared/func_clock/start.S:441
bfc00788:	149b0008 	bne	a0,k1,bfc007ac <key_set_clock+0xa0>
/mnt/shared/func_clock/start.S:442
bfc0078c:	00000000 	nop
/mnt/shared/func_clock/start.S:443
bfc00790:	26730001 	addiu	s3,s3,1
/mnt/shared/func_clock/start.S:444
bfc00794:	0ff00114 	jal	bfc00450 <update_time>
/mnt/shared/func_clock/start.S:445
bfc00798:	00000000 	nop
/mnt/shared/func_clock/start.S:446
bfc0079c:	0ff0017b 	jal	bfc005ec <time_print>
/mnt/shared/func_clock/start.S:447
bfc007a0:	00000000 	nop
/mnt/shared/func_clock/start.S:448
bfc007a4:	10000054 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:449
bfc007a8:	00000000 	nop
/mnt/shared/func_clock/start.S:452
bfc007ac:	24040005 	li	a0,5
/mnt/shared/func_clock/start.S:453
bfc007b0:	149b0008 	bne	a0,k1,bfc007d4 <key_set_clock+0xc8>
/mnt/shared/func_clock/start.S:454
bfc007b4:	00000000 	nop
/mnt/shared/func_clock/start.S:455
bfc007b8:	26940001 	addiu	s4,s4,1
/mnt/shared/func_clock/start.S:456
bfc007bc:	0ff00114 	jal	bfc00450 <update_time>
/mnt/shared/func_clock/start.S:457
bfc007c0:	00000000 	nop
/mnt/shared/func_clock/start.S:458
bfc007c4:	0ff0017b 	jal	bfc005ec <time_print>
/mnt/shared/func_clock/start.S:459
bfc007c8:	00000000 	nop
/mnt/shared/func_clock/start.S:460
bfc007cc:	1000004a 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:461
bfc007d0:	00000000 	nop
/mnt/shared/func_clock/start.S:464
bfc007d4:	24040006 	li	a0,6
/mnt/shared/func_clock/start.S:465
bfc007d8:	149b0008 	bne	a0,k1,bfc007fc <key_set_alarm>
/mnt/shared/func_clock/start.S:466
bfc007dc:	00000000 	nop
/mnt/shared/func_clock/start.S:467
bfc007e0:	26b50001 	addiu	s5,s5,1
/mnt/shared/func_clock/start.S:468
bfc007e4:	0ff00114 	jal	bfc00450 <update_time>
/mnt/shared/func_clock/start.S:469
bfc007e8:	00000000 	nop
/mnt/shared/func_clock/start.S:470
bfc007ec:	0ff0017b 	jal	bfc005ec <time_print>
/mnt/shared/func_clock/start.S:471
bfc007f0:	00000000 	nop
/mnt/shared/func_clock/start.S:472
bfc007f4:	10000040 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:473
bfc007f8:	00000000 	nop

bfc007fc <key_set_alarm>:
/mnt/shared/func_clock/start.S:477
bfc007fc:	00000000 	nop
/mnt/shared/func_clock/start.S:478
bfc00800:	13c0003d 	beqz	s8,bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:479
bfc00804:	00000000 	nop
/mnt/shared/func_clock/start.S:482
bfc00808:	24040001 	li	a0,1
/mnt/shared/func_clock/start.S:483
bfc0080c:	149b0008 	bne	a0,k1,bfc00830 <key_set_alarm+0x34>
/mnt/shared/func_clock/start.S:484
bfc00810:	00000000 	nop
/mnt/shared/func_clock/start.S:485
bfc00814:	25080001 	addiu	t0,t0,1
/mnt/shared/func_clock/start.S:486
bfc00818:	0ff00151 	jal	bfc00544 <update_alarm>
/mnt/shared/func_clock/start.S:487
bfc0081c:	00000000 	nop
/mnt/shared/func_clock/start.S:488
bfc00820:	0ff0013e 	jal	bfc004f8 <alarm_print>
/mnt/shared/func_clock/start.S:489
bfc00824:	00000000 	nop
/mnt/shared/func_clock/start.S:490
bfc00828:	10000033 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:491
bfc0082c:	00000000 	nop
/mnt/shared/func_clock/start.S:494
bfc00830:	24040002 	li	a0,2
/mnt/shared/func_clock/start.S:495
bfc00834:	149b0008 	bne	a0,k1,bfc00858 <key_set_alarm+0x5c>
/mnt/shared/func_clock/start.S:496
bfc00838:	00000000 	nop
/mnt/shared/func_clock/start.S:497
bfc0083c:	25290001 	addiu	t1,t1,1
/mnt/shared/func_clock/start.S:498
bfc00840:	0ff00151 	jal	bfc00544 <update_alarm>
/mnt/shared/func_clock/start.S:499
bfc00844:	00000000 	nop
/mnt/shared/func_clock/start.S:500
bfc00848:	0ff0013e 	jal	bfc004f8 <alarm_print>
/mnt/shared/func_clock/start.S:501
bfc0084c:	00000000 	nop
/mnt/shared/func_clock/start.S:502
bfc00850:	10000029 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:503
bfc00854:	00000000 	nop
/mnt/shared/func_clock/start.S:506
bfc00858:	24040003 	li	a0,3
/mnt/shared/func_clock/start.S:507
bfc0085c:	149b0008 	bne	a0,k1,bfc00880 <key_set_alarm+0x84>
/mnt/shared/func_clock/start.S:508
bfc00860:	00000000 	nop
/mnt/shared/func_clock/start.S:509
bfc00864:	254a0001 	addiu	t2,t2,1
/mnt/shared/func_clock/start.S:510
bfc00868:	0ff00151 	jal	bfc00544 <update_alarm>
/mnt/shared/func_clock/start.S:511
bfc0086c:	00000000 	nop
/mnt/shared/func_clock/start.S:512
bfc00870:	0ff0013e 	jal	bfc004f8 <alarm_print>
/mnt/shared/func_clock/start.S:513
bfc00874:	00000000 	nop
/mnt/shared/func_clock/start.S:514
bfc00878:	1000001f 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:515
bfc0087c:	00000000 	nop
/mnt/shared/func_clock/start.S:518
bfc00880:	24040004 	li	a0,4
/mnt/shared/func_clock/start.S:519
bfc00884:	149b0008 	bne	a0,k1,bfc008a8 <key_set_alarm+0xac>
/mnt/shared/func_clock/start.S:520
bfc00888:	00000000 	nop
/mnt/shared/func_clock/start.S:521
bfc0088c:	256b0001 	addiu	t3,t3,1
/mnt/shared/func_clock/start.S:522
bfc00890:	0ff00151 	jal	bfc00544 <update_alarm>
/mnt/shared/func_clock/start.S:523
bfc00894:	00000000 	nop
/mnt/shared/func_clock/start.S:524
bfc00898:	0ff0013e 	jal	bfc004f8 <alarm_print>
/mnt/shared/func_clock/start.S:525
bfc0089c:	00000000 	nop
/mnt/shared/func_clock/start.S:526
bfc008a0:	10000015 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:527
bfc008a4:	00000000 	nop
/mnt/shared/func_clock/start.S:530
bfc008a8:	24040005 	li	a0,5
/mnt/shared/func_clock/start.S:531
bfc008ac:	149b0008 	bne	a0,k1,bfc008d0 <key_set_alarm+0xd4>
/mnt/shared/func_clock/start.S:532
bfc008b0:	00000000 	nop
/mnt/shared/func_clock/start.S:533
bfc008b4:	258c0001 	addiu	t4,t4,1
/mnt/shared/func_clock/start.S:534
bfc008b8:	0ff00151 	jal	bfc00544 <update_alarm>
/mnt/shared/func_clock/start.S:535
bfc008bc:	00000000 	nop
/mnt/shared/func_clock/start.S:536
bfc008c0:	0ff0013e 	jal	bfc004f8 <alarm_print>
/mnt/shared/func_clock/start.S:537
bfc008c4:	00000000 	nop
/mnt/shared/func_clock/start.S:538
bfc008c8:	1000000b 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:539
bfc008cc:	00000000 	nop
/mnt/shared/func_clock/start.S:542
bfc008d0:	24040006 	li	a0,6
/mnt/shared/func_clock/start.S:543
bfc008d4:	149b0008 	bne	a0,k1,bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:544
bfc008d8:	00000000 	nop
/mnt/shared/func_clock/start.S:545
bfc008dc:	25ad0001 	addiu	t5,t5,1
/mnt/shared/func_clock/start.S:546
bfc008e0:	0ff00151 	jal	bfc00544 <update_alarm>
/mnt/shared/func_clock/start.S:547
bfc008e4:	00000000 	nop
/mnt/shared/func_clock/start.S:548
bfc008e8:	0ff0013e 	jal	bfc004f8 <alarm_print>
/mnt/shared/func_clock/start.S:549
bfc008ec:	00000000 	nop
/mnt/shared/func_clock/start.S:550
bfc008f0:	10000001 	b	bfc008f8 <endkey>
/mnt/shared/func_clock/start.S:551
bfc008f4:	00000000 	nop

bfc008f8 <endkey>:
/mnt/shared/func_clock/start.S:555
bfc008f8:	00000000 	nop
/mnt/shared/func_clock/start.S:562
bfc008fc:	16e00005 	bnez	s7,bfc00914 <do_wait>
/mnt/shared/func_clock/start.S:563
bfc00900:	00000000 	nop
/mnt/shared/func_clock/start.S:564
bfc00904:	17c00003 	bnez	s8,bfc00914 <do_wait>
/mnt/shared/func_clock/start.S:565
bfc00908:	00000000 	nop
/mnt/shared/func_clock/start.S:566
bfc0090c:	10000003 	b	bfc0091c <no_wait>
/mnt/shared/func_clock/start.S:567
bfc00910:	00000000 	nop

bfc00914 <do_wait>:
/mnt/shared/func_clock/start.S:570
bfc00914:	0ff0024f 	jal	bfc0093c <wait_1s>
/mnt/shared/func_clock/start.S:571
bfc00918:	00000000 	nop

bfc0091c <no_wait>:
/mnt/shared/func_clock/start.S:575
bfc0091c:	24040258 	li	a0,600
bfc00920:	40845800 	mtc0	a0,c0_compare
bfc00924:	00000000 	nop
bfc00928:	40804800 	mtc0	zero,c0_count
	...
/mnt/shared/func_clock/start.S:577
bfc00934:	42000018 	eret
/mnt/shared/func_clock/start.S:578
bfc00938:	00000000 	nop

bfc0093c <wait_1s>:
/mnt/shared/func_clock/start.S:582
bfc0093c:	3c09bfaf 	lui	t1,0xbfaf
bfc00940:	3529fff4 	ori	t1,t1,0xfff4
/mnt/shared/func_clock/start.S:583
bfc00944:	3c080000 	lui	t0,0x0
/mnt/shared/func_clock/start.S:584
bfc00948:	8d2a0000 	lw	t2,0(t1)
/mnt/shared/func_clock/start.S:585
bfc0094c:	15400007 	bnez	t2,bfc0096c <wait_1s+0x30>
/mnt/shared/func_clock/start.S:586
bfc00950:	00000000 	nop
/mnt/shared/func_clock/start.S:587
bfc00954:	3c08bfaf 	lui	t0,0xbfaf
bfc00958:	3508f020 	ori	t0,t0,0xf020
/mnt/shared/func_clock/start.S:588
bfc0095c:	8d080000 	lw	t0,0(t0)
/mnt/shared/func_clock/start.S:589
bfc00960:	240900ff 	li	t1,255
/mnt/shared/func_clock/start.S:590
bfc00964:	01094026 	xor	t0,t0,t1
/mnt/shared/func_clock/start.S:591
bfc00968:	00084400 	sll	t0,t0,0x10
/mnt/shared/func_clock/start.S:593
bfc0096c:	25080001 	addiu	t0,t0,1
/mnt/shared/func_clock/start.S:595
bfc00970:	2508ffff 	addiu	t0,t0,-1
/mnt/shared/func_clock/start.S:596
bfc00974:	1500fffe 	bnez	t0,bfc00970 <wait_1s+0x34>
/mnt/shared/func_clock/start.S:597
bfc00978:	00000000 	nop
/mnt/shared/func_clock/start.S:598
bfc0097c:	03e00008 	jr	ra
/mnt/shared/func_clock/start.S:599
bfc00980:	00000000 	nop
	...
wait_1s():
bfc00990:	cdbffff0 	lwc3	$31,-16(t5)
	...

Disassembly of section .data:

80000000 <__CTOR_LIST__>:
	...

80000008 <__CTOR_END__>:
	...

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	dmult	zero,zero
   4:	00000002 	srl	zero,zero,0x0
   8:	00040000 	sll	zero,a0,0x0
   c:	00000000 	nop
  10:	bfc00000 	cache	0x0,0(s8)
  14:	00000984 	0x984
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	000001c1 	0x1c1
   4:	001e0002 	srl	zero,s8,0x0
   8:	01010000 	0x1010000
   c:	000d0efb 	dsra	at,t5,0x1b
  10:	01010101 	0x1010101
  14:	01000000 	0x1000000
  18:	00010000 	sll	zero,at,0x0
  1c:	72617473 	0x72617473
  20:	00532e74 	teq	v0,s3,0xb9
  24:	00000000 	nop
  28:	00020500 	sll	zero,v0,0x14
  2c:	03bfc000 	0x3bfc000
  30:	4b4b0133 	c2	0x14b0133
  34:	034b4b4b 	0x34b4b4b
  38:	4e4b4a0a 	c3	0x4b4a0a
  3c:	4b4b4b4b 	c2	0x14b4b4b
  40:	4b4b4c4b 	c2	0x14b4c4b
  44:	084c4b4c 	j	1312d30 <data_size+0x1312d20>
  48:	4e4b833f 	c3	0x4b833f
  4c:	068c024b 	teqi	s4,587
  50:	4b4b4b16 	c2	0x14b4b16
  54:	4b4b4c4f 	c2	0x14b4c4f
  58:	4b4b4e4b 	c2	0x14b4e4b
  5c:	4e4b4c4b 	c3	0x4b4c4b
  60:	4b4b4b4b 	c2	0x14b4b4b
  64:	3d084d4b 	0x3d084d4b
  68:	4b4b4b4c 	c2	0x14b4b4c
  6c:	4b4b4d4b 	c2	0x14b4d4b
  70:	4b4b4b4b 	c2	0x14b4b4b
  74:	4b4b4b4b 	c2	0x14b4b4b
  78:	4c4b4b4b 	0x4c4b4b4b
  7c:	4b4b8350 	c2	0x14b8350
  80:	4b4b4b4f 	c2	0x14b4b4f
  84:	4b4b4d4b 	c2	0x14b4d4b
  88:	4b4d4b4b 	c2	0x14d4b4b
  8c:	4d4b4b4b 	0x4d4b4b4b
  90:	4b4b4b4b 	c2	0x14b4b4b
  94:	4c4b4b4d 	0x4c4b4b4d
  98:	4b4b4b4b 	c2	0x14b4b4b
  9c:	4b4d4b4b 	c2	0x14d4b4b
  a0:	4d4b4b4b 	0x4d4b4b4b
  a4:	4c4b4b4b 	0x4c4b4b4b
  a8:	4b4d4b4b 	c2	0x14d4b4b
  ac:	4b4b4b4b 	c2	0x14b4b4b
  b0:	4b4b4b4b 	c2	0x14b4b4b
  b4:	4b4b4b4b 	c2	0x14b4b4b
  b8:	4b4b4b83 	c2	0x14b4b83
  bc:	4b4b4b4e 	c2	0x14b4b4e
  c0:	4b4b4d4b 	c2	0x14b4d4b
  c4:	4b4d4b4b 	c2	0x14d4b4b
  c8:	4d4b4b4b 	0x4d4b4b4b
  cc:	4b4b4b4b 	c2	0x14b4b4b
  d0:	4c4b4b4d 	0x4c4b4b4d
  d4:	4b4b4b4b 	c2	0x14b4b4b
  d8:	4b4d4b4b 	c2	0x14d4b4b
  dc:	4d4b4b4b 	0x4d4b4b4b
  e0:	4c4b4b4b 	0x4c4b4b4b
  e4:	4b4e4b4b 	c2	0x14e4b4b
  e8:	4b4b4b4b 	c2	0x14b4b4b
  ec:	4b4b4b4b 	c2	0x14b4b4b
  f0:	4b4b4b4b 	c2	0x14b4b4b
  f4:	4b4b4b83 	c2	0x14b4b83
  f8:	4b83834d 	c2	0x183834d
  fc:	4b4f4b4b 	c2	0x14f4b4b
 100:	4b4d4b4b 	c2	0x14d4b4b
 104:	4b4b4d4b 	c2	0x14b4d4b
 108:	4b4b834b 	c2	0x14b834b
 10c:	834b4c4b 	lb	t3,19531(k0)
 110:	4b4e4c4b 	c2	0x14e4c4b
 114:	4b4b4d4b 	c2	0x14b4d4b
 118:	4b4b834b 	c2	0x14b834b
 11c:	834b4c4b 	lb	t3,19531(k0)
 120:	4c4b4b4b 	0x4c4b4b4b
 124:	4f4b4f4b 	c3	0x14b4f4b
 128:	4b4b4b4b 	c2	0x14b4b4b
 12c:	4b4b4b4b 	c2	0x14b4b4b
 130:	4b4b4d4b 	c2	0x14b4d4b
 134:	4b4b4b4b 	c2	0x14b4b4b
 138:	4d4b4b4b 	0x4d4b4b4b
 13c:	4b4b4b4b 	c2	0x14b4b4b
 140:	4b4b4b4b 	c2	0x14b4b4b
 144:	4b4b4d4b 	c2	0x14b4d4b
 148:	4b4b4b4b 	c2	0x14b4b4b
 14c:	4d4b4b4b 	0x4d4b4b4b
 150:	4b4b4b4b 	c2	0x14b4b4b
 154:	4b4b4b4b 	c2	0x14b4b4b
 158:	4b4b4d4b 	c2	0x14b4d4b
 15c:	4b4b4b4b 	c2	0x14b4b4b
 160:	4e4b4b4b 	c3	0x4b4b4b
 164:	4b4d4b4b 	c2	0x14d4b4b
 168:	4b4b4b4b 	c2	0x14b4b4b
 16c:	4b4b4b4b 	c2	0x14b4b4b
 170:	4b4b4b4d 	c2	0x14b4b4d
 174:	4b4b4b4b 	c2	0x14b4b4b
 178:	4b4d4b4b 	c2	0x14d4b4b
 17c:	4b4b4b4b 	c2	0x14b4b4b
 180:	4b4b4b4b 	c2	0x14b4b4b
 184:	4b4b4b4d 	c2	0x14b4b4d
 188:	4b4b4b4b 	c2	0x14b4b4b
 18c:	4b4d4b4b 	c2	0x14d4b4b
 190:	4b4b4b4b 	c2	0x14b4b4b
 194:	4b4b4b4b 	c2	0x14b4b4b
 198:	4b4b4b4d 	c2	0x14b4b4d
 19c:	4b4b4b4b 	c2	0x14b4b4b
 1a0:	514e4b4b 	beql	t2,t6,12ed0 <data_size+0x12ec0>
 1a4:	4b4b4b4b 	c2	0x14b4b4b
 1a8:	4e4b4d4b 	c3	0x4b4d4b
 1ac:	4b4b3d08 	c2	0x14b3d08
 1b0:	4b4b834e 	c2	0x14b834e
 1b4:	4b834b4b 	c2	0x1834b4b
 1b8:	4c4c4b4b 	0x4c4c4b4b
 1bc:	4b4b4b4b 	c2	0x14b4b4b
 1c0:	01000402 	0x1000402
 1c4:	Address 0x00000000000001c4 is out of bounds.


Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	00000044 	0x44
   4:	00000002 	srl	zero,zero,0x0
   8:	01040000 	0x1040000
   c:	00000000 	nop
  10:	bfc00000 	cache	0x0,0(s8)
  14:	bfc00984 	cache	0x0,2436(s8)
  18:	72617473 	0x72617473
  1c:	00532e74 	teq	v0,s3,0xb9
  20:	746e6d2f 	jalx	1b9b4bc <data_size+0x1b9b4ac>
  24:	6168732f 	daddi	t0,t3,29487
  28:	2f646572 	sltiu	a0,k1,25970
  2c:	636e7566 	daddi	t6,k1,30054
  30:	6f6c635f 	ldr	t4,25439(k1)
  34:	47006b63 	c1	0x1006b63
  38:	4120554e 	0x4120554e
  3c:	2e322053 	sltiu	s2,s1,8275
  40:	352e3831 	ori	t6,t1,0x3831
  44:	80010030 	lb	at,48(zero)

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	10001101 	b	4408 <data_size+0x43f8>
   4:	12011106 	beq	s0,at,4420 <data_size+0x4410>
   8:	1b080301 	0x1b080301
   c:	13082508 	beq	t8,t0,9430 <data_size+0x9420>
  10:	00000005 	0x5
