/*	$OpenBSD: regdef.h,v 1.3 1999/01/27 04:46:06 imp Exp $	*/

/*
 * Copyright (c) 1992, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Ralph Campbell. This file is derived from the MIPS RISC
 * Architecture book by Gerry Kane.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the University of
 *	California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 *	@(#)regdef.h	8.1 (Berkeley) 6/10/93
 */
#ifndef _MIPS_REGDEF_H_
#define _MIPS_REGDEF_H_

#define zero	$0	/* always zero */
#define AT	$at	/* assembler temp */
#define v0	$2	/* return value */
#define v1	$3
#define a0	$4	/* argument registers */
#define a1	$5
#define a2	$6
#define a3	$7
#define t0	$8	/* temp registers (not saved across subroutine calls) */
#define t1	$9
#define t2	$10
#define t3	$11
#define t4	$12
#define t5	$13
#define t6	$14
#define t7	$15
#define s0	$16	/* saved across subroutine calls (callee saved) */
#define s1	$17
#define s2	$18
#define s3	$19
#define s4	$20
#define s5	$21
#define s6	$22
#define s7	$23
#define t8	$24	/* two more temp registers */
#define t9	$25
#define k0	$26	/* kernel temporary */
#define k1	$27
#define gp	$28	/* global pointer */
#define sp	$29	/* stack pointer */
#define s8	$30	/* one more callee saved */
#define ra	$31	/* return address */
#define fp	$30

/*
 * Copyright (C) 1994, 1995, 1996, 1997, 2000, 2001 by Ralf Baechle
 *
 * Copyright (C) 2001, Monta Vista Software
 * Author: jsun@mvista.com or jsun@junsun.net
 */

#define CP0_INDEX           $0
#define CP0_RANDOM          $1
#define CP0_ENTRYLO0        $2
#define CP0_ENTRYLO1        $3
#define CP0_CONTEXT         $4
#define CP0_PAGEMASK        $5
#define CP0_WIRED           $6
#define CP0_BADVADDR        $8
#define CP0_COUNT           $9
#define CP0_ENTRYHI         $10
#define CP0_COMPARE         $11
#define CP0_STATUS          $12

/* --------- CP0_STATUS (low 16bits) ------------ *
 * NAME | IM7~IM0  | 000 | KSU | ERL | EXL | IE |
 * ----------------------------------------------
 * BITS |     8    |  3  |  2  |  1  |  1  |  1 |
 * ----------------------------------------------
 * INIT | 1000 0000| 000 | 00  |  0  |  0  |  1 |
 * ---------------------------------------------- */
#define CP0_CAUSE           $13
/* ----- CP0_CAUSE (low 16bits) ------ *
 * NAME |  IP7~IP0  | 0 | ExcCode | 0 |
 * -----------------------------------
 * BITS |     8     | 1 |    5    | 2 |
 * ----------------------------------- */

#define CP0_EPC             $14
#define CP0_PRID            $15
#define CP0_CONFIG          $16
#define CP0_LLADDR          $17
#define CP0_WATCHLO         $18
#define CP0_WATCHHI         $19
#define CP0_XCONTEXT        $20
#define CP0_FRAMEMASK       $21
#define CP0_DIAGNOSTIC      $22
#define CP0_PERFORMANCE     $25
#define CP0_ECC             $26
#define CP0_CACHEERR        $27
#define CP0_TAGLO           $28
#define CP0_TAGHI           $29
#define CP0_ERROREPC        $30

#define STATUS_CU0          0x10000000
#define STATUS_IE           0x1
#define CAUSE_IPL           0xff00
#define CAUSE_EXCCODE       0x7c


#endif /* !_MIPS_REGDEF_H_ */
