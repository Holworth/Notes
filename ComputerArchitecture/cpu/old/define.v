`timescale 10ns / 1ns

//ALUcontrol
// `define Store 2'b00
// `define Load 2'b00
// `define StoreLoad 2'b00
`define F 2'b00
`define R 2'b10
`define B 2'b01
`define J 2'b11

//ISA
`define op_addiu 6'b001001
`define op_lw    6'b100011
`define op_sw    6'b101011
`define op_bne   6'b000101
`define op_beq   6'b000100
`define op_nop   6'b000000
`define op_j     6'b000010
`define op_jal   6'b000011
`define op_lui   6'b001111
`define op_slti  6'b001010
`define op_sltiu 6'b001011
`define op_andi  6'b001100
`define special  6'b000000
`define regimm   6'b000001
`define op_blez  6'b000110
`define op_lb    6'b100000
`define op_lbu   6'b100100
`define op_lh    6'b100001
`define op_lhu   6'b100101
`define op_lwl   6'b100010
`define op_lwr   6'b100110
`define op_ori   6'b001101
`define op_sb    6'b101000
`define op_sh    6'b101001
`define op_swl   6'b101010
`define op_swr   6'b101110
`define op_xori  6'b001110
`define op_bgez  6'b000001
`define op_blez  6'b000110
`define op_bltz  6'b000001
`define op_bgtz  6'b000111
`define special2 6'b011100

//mem extender control
`define lw   13'b0000000000001
`define lh   13'b0000000000010
`define lhu  13'b0000000000100
`define lb   13'b0000000001000
`define lbu  13'b0000000010000
`define lwl  13'b0000000100000
`define lwr  13'b0000001000000
`define swl  13'b0000010000000
`define swr  13'b0000100000000
`define sb   13'b0001000000000
`define sh   13'b0010000000000
`define lui  13'b0100000000000
`define sw   13'b1000000000000


//ALUops
`define AND 3'b000
`define OR 3'b001
`define ADD 3'b010
`define SUB 3'b110
`define SLT 3'b111
`define XOR 3'b100
`define NOR 3'b101
`define SLTU 3'b011

//shifter
`define left_shift_a 3'b000
`define left_shift_l 3'b001
`define right_shift_a 3'b010
`define right_shift_l 3'b011

`define source_ins 1'b0
`define source_reg 1'b1

//mux
`define ALUin1_PC 1'b1
`define ALUin1_A 1'b0
`define ALUin2_B 3'b000
`define ALUin2_0 3'b001
`define ALUin2_4 3'b010
`define ALUin2_ImmSignedExt 3'b011
`define ALUin2_ImmUnsignedExt 3'b100
`define ALUin2_Offset00Ext 3'b101
`define ALUopsrc_ALUopC 1'b0
`define ALUopsrc_ALUopAC 1'b1
`define PCsrc_ALU 2'b00
`define PCsrc_A 2'b01
`define PCsrc_LongJump 2'b10
`define PCsrc_ALUout 2'b11 
`define REGwritesrc_ALUout 4'b0000
`define REGwritesrc_MEM 4'b0001
`define REGwritesrc_MEMb 4'b0010
`define REGwritesrc_MEMub 4'b0011
`define REGwritesrc_MEMh 4'b0100
`define REGwritesrc_MEMuh 4'b0101
`define REGwritesrc_IMM160 4'b0110
`define REGwritesrc_MEMl 4'b0111
`define REGwritesrc_MEMr 4'b1000
`define REGwritesrc_A 4'b1001
`define REGwritesrc_Shifter 4'b1010
`define REGwritesrc_PC 4'b1011
`define REGwritesrc_ALUnow 4'b1100
`define REGwritesrc_MULreg 4'b1110
`define REGwritesrc_oldPC 4'b1111

`define MEMwritesrc_B 1'b0
`define MEMwritesrc_ALUout 1'b1
`define RegDst_Ins20_16 3'b000
`define RegDst_Ins15_11 3'b001
`define RegDst_31 3'b010
`define RegDst_movn 3'b011
`define RegDst_movz 3'b100
`define RegDst_0 3'b101
`define LorD_PC 1'b0
`define LorD_ALUout 1'b1
`define LoadControl_lb  3'b000
`define LoadControl_lbu 3'b001
`define LoadControl_lh  3'b010
`define LoadControl_lhu 3'b011
`define LoadControl_lui 3'b100
`define LoadControl_lw  3'b101
`define LoadControl_lwl 3'b110
`define LoadControl_lwr 3'b111
`define StoreControl_sb 3'b000
`define StoreControl_sh 3'b001
`define StoreControl_sw 3'b010
`define StoreControl_swl 3'b011
`define StoreControl_swr 3'b100
`define ShiftControl_sll 3'b000
`define ShiftControl_sllv 3'b001
`define ShiftControl_sra 3'b010
`define ShiftControl_srav 3'b011
`define ShiftControl_srl 3'b100
`define ShiftControl_srlv 3'b101

//State
`define State_Fetch 16'b0000_0000_0000_0001
`define State_Decode 16'b0000_0000_0000_0010
`define State_Rexe 16'b0000_0000_0000_0100
`define State_Rreg 16'b0000_0000_0000_1000
`define State_Bexe 16'b0000_0000_0001_0000
`define State_Jexe 16'b0000_0000_0010_0000
// `define State_Jreg 16'b0000_0000_0100_0000
`define State_Lexe 16'b0000_0000_0100_0000
`define State_Sexe 16'b0000_0000_1000_0000
`define State_Lmem 16'b0000_0001_0000_0000
`define State_Lreg 16'b0000_0010_0000_0000
`define State_Smem 16'b0000_0100_0000_0000
`define State_Iexe 16'b0000_1000_0000_0000
`define State_Ireg 16'b0001_0000_0000_0000
`define State_Fwait 16'b0010_0000_0000_0000
`define State_Lwait 16'b0100_0000_0000_0000
`define State_rst 16'b1000_0000_0000_0000

//R Instructions
`define addu 6'b100001
`define and	6'b100100
`define jalr 6'b001001
`define jr 6'b001000
`define movn 6'b001011
`define movz 6'b001010
`define nor	6'b100111
`define or	6'b100101
`define sll	6'b000000
`define sllv 6'b000100
`define slt	6'b101010
`define slti 6'b001010	
`define sltiu 6'b001011	
`define sltu 6'b101011
`define sra	6'b000011
`define srav 6'b000111
`define srl 6'b000010
`define srlv 6'b000110
`define subu 6'b100011
`define xor	6'b100110