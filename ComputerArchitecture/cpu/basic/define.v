//Define.v
//Huaqiang Wang (c) 2018

//GLOBAL-------------------------------

`define DATA_WIDTH 32
`define ADDR_WIDTH 5

//ALU--------------------------------

`define ALUOP_AND  16'b0000_0000_0000_0001
`define ALUOP_OR   16'b0000_0000_0000_0010
`define ALUOP_ADD  16'b0000_0000_0000_0100
`define ALUOP_SUB  16'b0000_0000_0000_1000
`define ALUOP_SLT  16'b0000_0000_0001_0000
`define ALUOP_XOR  16'b0000_0000_0010_0000
`define ALUOP_NOR  16'b0000_0000_0100_0000
`define ALUOP_SLTU 16'b0000_0000_1000_0000
`define ALUOP_SLL  16'b0000_0001_0000_0000
`define ALUOP_SRL  16'b0000_0010_0000_0000
`define ALUOP_SRA  16'b0000_0100_0000_0000
`define ALUOP_LUI  16'b0000_1000_0000_0000
`define ALUOP_A    16'b0001_0000_0000_0000
`define ALUOP_B    16'b0010_0000_0000_0000

//IF-------------------------------

`define IF_STAGE_0=1'b0;
`define IF_STAGE_1=1'b1;

//ALU control

`define subop_addu	6'b100001
`define subop_and	6'b100100
`define subop_jalr	6'b001001
`define subop_jr	6'b001000
`define subop_movn	6'b001011
`define subop_movz	6'b001010
`define subop_nor	6'b100111
`define subop_or	6'b100101
`define subop_sll	6'b000000
`define subop_sllv	6'b000100
`define subop_slt	6'b101010
`define subop_sltu	6'b101011
`define subop_sra	6'b000011
`define subop_srav	6'b000111
`define subop_srl	6'b000010
`define subop_srlv	6'b000110
`define subop_subu	6'b100011
`define subop_xor	6'b100110
`define subop_add	6'b100000
`define subop_sub	6'b100010
`define subop_div	6'b011010
`define subop_divu	6'b011011
`define subop_mult	6'b011000
`define subop_multu	6'b011001
`define subop_mfhi	6'b010000
`define subop_mflo	6'b010010
`define subop_mthi	6'b010001
`define subop_mtlo	6'b010011

//control
`define beq	6'b000100
`define bgez	6'b000001
`define blez	6'b000110
`define bltz	6'b000001
`define bne	6'b000101
`define addiu	6'b001001
`define andi	6'b001100
`define lb	6'b100000
`define lbu	6'b100100
`define lh	6'b100001
`define lhu	6'b100101
`define lui	6'b001111
`define lw	6'b100011
`define lwl	6'b100010
`define lwr	6'b100110
`define ori	6'b001101
`define sb	6'b101000
`define sh	6'b101001
`define sw	6'b101011
`define swl	6'b101011
`define swr	6'b101110
`define xori	6'b001110
`define j	6'b000010
`define jal	6'b000011
`define slti	6'b001010
`define sltiu	6'b001011
`define addi	6'b001000
`define bgtz	6'b000111
`define bgezal	6'b000001
`define bltzal	6'b000001
`define r	6'b000000

//reg_write------------------
`define regw_rd 5'b00001
`define regw_r20 5'b00010 //not used
`define regw_r21 5'b00100 //not used
`define regw_hi 5'b01000
`define regw_lo 5'b10000
`define regw_nop 5'b00000

//reg_write_src--------------------
//ie: reg_write_fsrc[4:0]
`define regw_src_alu 5'b00001 
`define regw_src_pc 5'b00010 
`define regw_src_rs 5'b00100 
`define regw_src_hi 5'b01000 
`define regw_src_lo 5'b10000 

//reg_write_tgt-------------------
//ie:reg_write_ftgt[3:0]
`define regw_tgt_rd 4'b0001 
`define regw_tgt_hi 4'b0010 
`define regw_tgt_lo 4'b0100 
`define regw_tgt_nop 4'b1000 
 
//mul_control----------------------
`define mult_mc 4'0001
`define multu_mc 4'0010
`define div_mc 4'0100
`define divu_mc 4'1000

//alu_a_src--------------------------
`define alu_a_src_a 0;
`define alu_a_src_sa 1;

//alu_b_src--------------------------
`define alu_b_src_immsigned 4'b0001;
`define alu_b_src_a_immunsigned 4'b0010;
`define alu_b_src_PC_8 4'b0100;
`define alu_b_src_reg 4'b1000;
//reserved

//mem_wen_pick-----------------------
`define sw 5'b00001
`define sh 5'b00010
`define sb 5'b00100
`define swl 5'b01000
`define swr 5'b10000

//reg_write_src------------------------
`define regw_fsrc_alu    16'b0000_0000_0000_0001 
`define regw_fsrc_pc     16'b0000_0000_0000_0010 
`define regw_fsrc_rs     16'b0000_0000_0000_0100 
`define regw_fsrc_hi     16'b0000_0000_0000_1000 
`define regw_fsrc_lo     16'b0000_0000_0001_0000 
`define regw_fsrc_imm16  16'b0000_0000_0010_0000 
`define regw_fsrc_pc8    16'b0000_0000_0100_0000 
`define regw_fsrc_memb   16'b0000_0000_1000_0000 
`define regw_fsrc_membu  16'b0000_0001_0000_0000 
`define regw_fsrc_memh   16'b0000_0010_0000_0000 
`define regw_fsrc_memhu  16'b0000_0100_0000_0000 
`define regw_fsrc_meml   16'b0000_1000_0000_0000 
`define regw_fsrc_memr   16'b0001_0000_0000_0000 

//reg_write_ftgt-------------------
`define regw_ftgt_rd     6'b000001 
`define regw_ftgt_hi     6'b000010 
`define regw_ftgt_lo     6'b000100 
`define regw_ftgt_nop    6'b001000 
`define regw_ftgt_rt     6'b010000 
`define regw_ftgt_31     6'b100000 