//control.v
//Huaqiang Wang (c) 2018

`include "define.v"

module control(
    input [31:0]inst,
    input [31:0]A,
    input [31:0]B,
    output jump_short,//1
    output jump_long,//1
    output [3:0]alu_b_src,//4
    output [15:0] aluop,//16
    output [4:0]mem_wen_pick,//5
    output reg_a_valid,//1
    output reg_b_valid,//1
    output mem_read,//1
    output reg_write,//1
    output [15:0]reg_write_src,//16
    output [5:0]reg_write_tgt,//6
    output r_type//1
    //54 bit in total
);

wire [4:0]inst2016;
wire [5:0]opcode;

assign inst2016=inst[20:16];
assign opcode=inst[31:26];

//decoder
//----------------------------------
wire beq_op;
wire bgez_op;
wire blez_op;
wire bltz_op;
wire bne_op;
wire addiu_op;
wire andi_op;
wire lb_op;
wire lbu_op;
wire lh_op;
wire lhu_op;
wire lui_op;
wire lw_op;
wire lwl_op;
wire lwr_op;
wire ori_op;
wire sb_op;
wire sh_op;
wire sw_op;
wire swl_op;
wire swr_op;
wire xori_op;
wire j_op;
wire jal_op;
wire slti_op;
wire sltiu_op;
wire addi_op;
wire bgtz_op;
wire bgezal_op;
wire bltzal_op;
wire r_op;

assign beq_op= opcode==6'b000100;
assign bgez_op= (opcode==6'b000001)&(inst2016==5'b00001);
assign blez_op= (opcode==6'b000110)&(inst2016==5'b00000);
assign bltz_op= opcode==6'b000001;
assign bne_op= opcode==6'b000101;
assign addiu_op= opcode==6'b001001;
assign andi_op= opcode==6'b001100;
assign lb_op= opcode==6'b100000;
assign lbu_op= opcode==6'b100100;
assign lh_op= opcode==6'b100001;
assign lhu_op= opcode==6'b100101;
assign lui_op= opcode==6'b001111;
assign lw_op= opcode==6'b100011;
assign lwl_op= opcode==6'b100010;
assign lwr_op= opcode==6'b100110;
assign ori_op= opcode==6'b001101;
assign sb_op= opcode==6'b101000;
assign sh_op= opcode==6'b101001;
assign sw_op= opcode==6'b101011;
assign swl_op= opcode==6'b101010;
assign swr_op= opcode==6'b101110;
assign xori_op= opcode==6'b001110;
assign j_op= opcode==6'b000010;
assign jal_op= opcode==6'b000011;
assign slti_op= opcode==6'b001010;
assign sltiu_op= opcode==6'b001011;
assign addi_op= opcode==6'b001000;
assign bgtz_op= (opcode==6'b000111)&(inst2016==5'b00000);
assign bgezal_op= (opcode==6'b000001)&(inst2016==5'b10001);
assign bltzal_op= (opcode==6'b000001)&(inst2016==5'b10000);
assign r_op= opcode==6'b000000;

assign r_type=r_op;

assign jump_short=
beq_op&(A==B)|
bgez_op&(!A[31])|
blez_op&(A[31]|(A==0))|
bltz_op&(A[31])|
bne_op&(A!=B)|
bgtz_op&((!A[31])&(A!=0))|
bgezal_op&(!A[31])|
bltzal_op&(A[31]);

assign jump_long=j_op|jal_op;

wire alu_b_src_immsigned;
wire alu_b_src_a_immunsigned;
wire alu_b_src_PC_8;
wire alu_b_src_reg;

assign alu_b_src[0]=alu_b_src_immsigned;
assign alu_b_src[1]=alu_b_src_a_immunsigned;
assign alu_b_src[2]=alu_b_src_PC_8;
assign alu_b_src[3]=alu_b_src_reg;

assign alu_b_src_immsigned=
    addiu_op|
    lb_op|
    lbu_op|
    lh_op|
    lhu_op|
    lw_op|
    lwl_op|
    lwr_op|
    slti_op|
    sltiu_op|
    addi_op;

assign alu_b_src_a_immunsigned=
    andi_op|
    ori_op|
    xori_op|
    lui_op;

assign alu_b_src_PC_8=jal_op;
assign alu_b_src_reg=
    r_op|
    beq_op|
    bgez_op|
    blez_op|
    bltz_op|
    bne_op|
    bgtz_op|
    bgezal_op|
    bltzal_op|
    sb_op|
    sh_op|
    sw_op|
    swl_op|
    swr_op
;//TODO : not tested yet

// assign aluop=

wire and_alu;
wire or_alu;
wire add_alu;
wire sub_alu;
wire slt_alu;
wire xor_alu;
wire nor_alu;
wire sltu_alu;
wire sll_alu;
wire srl_alu;
wire sra_alu;
wire lui_alu;
wire a_alu;
wire b_alu;

assign aluop[0] = and_alu;
assign aluop[1] = or_alu;
assign aluop[2] = add_alu;
assign aluop[3] = sub_alu;
assign aluop[4] = slt_alu;
assign aluop[5] = xor_alu;
assign aluop[6] = nor_alu;
assign aluop[7] = sltu_alu;
assign aluop[8] = sll_alu;
assign aluop[9] = srl_alu;
assign aluop[10] = sra_alu;
assign aluop[11] = lui_alu;
assign aluop[12] = a_alu;
assign aluop[13] = b_alu;

assign aluop[15:14]=0;//reserved

assign and_alu=andi_op;
assign or_alu=ori_op;
assign sub_alu=0;
assign slt_alu=slti_op;
assign xor_alu=xori_op;
assign nor_alu=0;
assign sltu_alu=sltiu_op;
assign sll_alu=0;
assign srl_alu=0;
assign sra_alu=0;
assign lui_alu=lui_op;
assign a_alu=0;
assign b_alu=
    jal_op|
    sb_op|
    sh_op|
    sw_op|
    swl_op|
    swr_op
;
assign add_alu=
    addiu_op|
    lb_op|
    lbu_op|
    lh_op|
    lhu_op|
    lw_op|
    lwl_op|
    lwr_op|
    sb_op|
    sh_op|
    sw_op|
    swl_op|
    swr_op|
    addi_op;

// output [4:0]mem_wen_pick,

assign mem_wen_pick[0]=sw_op;
assign mem_wen_pick[1]=sh_op;
assign mem_wen_pick[2]=sb_op;
assign mem_wen_pick[3]=swl_op;
assign mem_wen_pick[4]=swr_op;

assign mem_read=
    lb_op|
    lbu_op|
    lh_op|
    lhu_op|
    lw_op|
    lwl_op|
    lwr_op;

assign reg_write=
    xori_op|
    lui_op|
    sltiu_op|
    slti_op|
    ori_op|
    jal_op|
    andi_op|
    addiu_op|
    lb_op|
    lbu_op|
    lh_op|
    lhu_op|
    lw_op|
    lwl_op|
    lwr_op|
    addi_op|
    r_op|
    bgezal_op|
    bltzal_op
;

    // output [15:0]reg_write_src,

wire regw_fsrc_alu;
wire regw_fsrc_pc;
wire regw_fsrc_rs;
wire regw_fsrc_hi;
wire regw_fsrc_lo;
wire regw_fsrc_imm16;
wire regw_fsrc_pc8;
wire regw_fsrc_memb;
wire regw_fsrc_membu;
wire regw_fsrc_memh;
wire regw_fsrc_memhu;
wire regw_fsrc_meml;
wire regw_fsrc_memr;
wire regw_fsrc_mem;
wire regw_fsrc_lui;

assign reg_write_src[0]= regw_fsrc_alu;
assign reg_write_src[1]= regw_fsrc_pc;
assign reg_write_src[2]= regw_fsrc_rs;
assign reg_write_src[3]= regw_fsrc_hi;
assign reg_write_src[4]= regw_fsrc_lo;
assign reg_write_src[5]= regw_fsrc_imm16;
assign reg_write_src[6]= regw_fsrc_pc8;
assign reg_write_src[7]= regw_fsrc_memb;
assign reg_write_src[8]= regw_fsrc_membu;
assign reg_write_src[9]= regw_fsrc_memh;
assign reg_write_src[10]= regw_fsrc_memhu;
assign reg_write_src[11]= regw_fsrc_meml;
assign reg_write_src[12]= regw_fsrc_memr;
assign reg_write_src[13]= regw_fsrc_mem;
assign reg_write_src[14]= regw_fsrc_lui;
assign reg_write_src[15]=1'b0;

assign regw_fsrc_alu=
    lui_op|
    xori_op|
    sltiu_op|
    slti_op|
    ori_op|
    andi_op|
    addiu_op|
    addi_op;
assign regw_fsrc_pc=0;
assign regw_fsrc_rs=0;
assign regw_fsrc_hi=0;
assign regw_fsrc_lo=0;
// assign regw_fsrc_imm16=lui;
assign regw_fsrc_imm16=0;//changed into lui
assign regw_fsrc_pc8=
    jal_op|
    bgezal_op|
    bltzal_op;
assign regw_fsrc_memb=lb_op;
assign regw_fsrc_membu=lbu_op;
assign regw_fsrc_memh=lh_op;
assign regw_fsrc_memhu=lhu_op;
assign regw_fsrc_meml=lwl_op;
assign regw_fsrc_memr=lwr_op;
assign regw_fsrc_mem=lw_op;
assign regw_fsrc_lui=0;//use alu instead. so we can do bypass on lui

// output [3:0]reg_write_tgt
wire regw_ftgt_rd;
wire regw_ftgt_hi;
wire regw_ftgt_lo;
wire regw_ftgt_nop;
wire regw_ftgt_rt;
wire regw_ftgt_31;

assign reg_write_tgt[0]= regw_ftgt_rd;
assign reg_write_tgt[1]= regw_ftgt_hi;
assign reg_write_tgt[2]= regw_ftgt_lo;
assign reg_write_tgt[3]= regw_ftgt_nop;
assign reg_write_tgt[4]= regw_ftgt_rt;
assign reg_write_tgt[5]= regw_ftgt_31;

assign regw_ftgt_rd=0;

assign regw_ftgt_hi=0;
assign regw_ftgt_lo=0;
assign regw_ftgt_nop=0;
assign regw_ftgt_rt=
    lwr_op|
    lwl_op|
    lh_op|
    lhu_op|
    lbu_op|
    lb_op|
    lw_op|
    lui_op|
    xori_op|
    sltiu_op|
    slti_op|
    ori_op|
    addi_op|
    andi_op|
    addiu_op;

assign regw_ftgt_31=
    bgezal_op|
    bltzal_op|
    jal_op;
assign reg_a_valid=
    xori_op|
    sltiu_op|
    slti_op|
    ori_op|
    andi_op|
    addiu_op|
    lb_op|
    lbu_op|
    lh_op|
    lhu_op|
    lw_op|
    lwl_op|
    lwr_op|
    addi_op|
    sb_op|
    sh_op|
    sw_op|
    swl_op|
    swr_op|
    beq_op|
    bgez_op|
    blez_op|
    bltz_op|
    bne_op|
    bgezal_op|
    bltzal_op|
    bgtz_op|
    r_op;

assign reg_b_valid=
    beq_op|
    bne_op|
    lwl_op|//newly added
    lwr_op|//newly added
    sw_op|
    swl_op|
    swr_op|
    sb_op|
    sh_op|
    r_op;



endmodule