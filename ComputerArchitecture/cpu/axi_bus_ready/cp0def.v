
`define CP0_INDEX           5'd0
`define CP0_RANDOM          5'd1
`define CP0_ENTRYLO0        5'd2
`define CP0_ENTRYLO1        5'd3
`define CP0_CONTEXT         5'd4
`define CP0_PAGEMASK        5'd5
`define CP0_WIRED           5'd6
`define CP0_BADVADDR        5'd8
`define CP0_COUNT           5'd9
`define CP0_ENTRYHI         5'd10
`define CP0_COMPARE         5'd11
`define CP0_STATUS          5'd12

/* --------- CP0_STATUS (low 16bits) ------------ *
 * NAME | IM7~IM0  | 000 | KSU | ERL | EXL | IE |
 * ----------------------------------------------
 * BITS |     8    |  3  |  2  |  1  |  1  |  1 |
 * ----------------------------------------------
 * INIT | 1000 0000| 000 | 00  |  0  |  0  |  1 |
 * ---------------------------------------------- */
`define CP0_CAUSE           5'd13
/* ----- CP0_CAUSE (low 16bits) ------ *
 * NAME |  IP7~IP0  | 0 | ExcCode | 0 |
 * -----------------------------------
 * BITS |     8     | 1 |    5    | 2 |
 * ----------------------------------- */

`define CP0_EPC             5'd14
`define CP0_PRID            5'd15
`define CP0_CONFIG          5'd16
`define CP0_LLADDR          5'd17
`define CP0_WATCHLO         5'd18
`define CP0_WATCHHI         5'd19
`define CP0_XCONTEXT        5'd20
`define CP0_FRAMEMASK       5'd21
`define CP0_DIAGNOSTIC      5'd22
`define CP0_PERFORMANCE     5'd25
`define CP0_ECC             5'd26
`define CP0_CACHEERR        5'd27
`define CP0_TAGLO           5'd28
`define CP0_TAGHI           5'd29
`define CP0_ERROREPC        5'd30
