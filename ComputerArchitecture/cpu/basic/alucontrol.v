//alucontrol.v
//Huaqiang Wang (c) 2018

`include "define.v"

module alucontrol(
    input [31:0]inst,
    output [15:0]aluop,//16
    output [3:0]mul_control,//4
    output [4:0]reg_write,//5
    output [4:0]reg_write_src,//5
    output [3:0]reg_write_tgt,//4
    output jmp,//1
    output alu_a_src,//1
    output reg_a_valid,
    output reg_b_valid
    //38 bit in total
);

wire [5:0]function_op;
assign function_op=inst[5:0];

//reg_write has special control! it may depends on rread2, so data correlation may happen on it!

//decoder
wire addu_sop;
wire and_sop;
wire jalr_sop;
wire jr_sop;
wire movn_sop;
wire movz_sop;
wire nor_sop;
wire or_sop;
wire sll_sop;
wire sllv_sop;
wire slt_sop;
wire sltu_sop;
wire sra_sop;
wire srav_sop;
wire srl_sop;
wire srlv_sop;
wire subu_sop;
wire xor_sop;
wire add_sop;
wire sub_sop;
wire div_sop;
wire divu_sop;
wire mult_sop;
wire multu_sop;
wire mfhi_sop;
wire mflo_sop;
wire mthi_sop;
wire mtlo_sop;

assign addu_sop=function_op==6'b100001;
assign and_sop=function_op==6'b100100;
assign jalr_sop=function_op==6'b001001;
assign jr_sop=function_op==6'b001000;
assign movn_sop=function_op==6'b001011;//not implemented
assign movz_sop=function_op==6'b001010;//not implemented
assign nor_sop=function_op==6'b100111;
assign or_sop=function_op==6'b100101;
assign sll_sop=function_op==6'b000000;
assign sllv_sop=function_op==6'b000100;
assign slt_sop=function_op==6'b101010;
assign sltu_sop=function_op==6'b101011;
assign sra_sop=function_op==6'b000011;
assign srav_sop=function_op==6'b000111;
assign srl_sop=function_op==6'b000010;
assign srlv_sop=function_op==6'b000110;
assign subu_sop=function_op==6'b100011;
assign xor_sop=function_op==6'b100110;
assign add_sop=function_op==6'b100000;
assign sub_sop=function_op==6'b100010;
assign div_sop=function_op==6'b011010;
assign divu_sop=function_op==6'b011011;
assign mult_sop=function_op==6'b011000;
assign multu_sop=function_op==6'b011001;
assign mfhi_sop=function_op==6'b010000;
assign mflo_sop=function_op==6'b010010;
assign mthi_sop=function_op==6'b010001;
assign mtlo_sop=function_op==6'b010011;

//gen output
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

assign and_alu=and_sop;
assign or_alu=or_sop;
assign add_alu=add_sop|addu_sop;
assign sub_alu=subu_sop|sub_sop;
assign slt_alu=slt_sop;
assign xor_alu=xor_sop;
assign nor_alu=nor_sop;
assign sltu_alu=sltu_sop;
assign sll_alu=sll_sop|sllv_sop;
assign srl_alu=srl_sop|srlv_sop;
assign sra_alu=sra_sop|srav_sop;
assign lui_alu=0;
assign a_alu=mthi_sop|mtlo_sop;
assign b_alu=0;
 
assign mul_control= ({4{mult_sop}}&`mult_mc)|
                    ({4{multu_sop}}&`multu_mc)|
                    ({4{div_sop}}&`div_mc)|
                    ({4{divu_sop}}&`divu_mc);

wire reg_write_rd;
wire reg_write_r2;
wire reg_write_hi;
wire reg_write_lo;
wire reg_write_r20;
wire reg_write_r21;

assign reg_write[0]=reg_write_rd;
assign reg_write[1]=reg_write_r20;
assign reg_write[2]=reg_write_r21;
assign reg_write[3]=reg_write_hi;
assign reg_write[4]=reg_write_lo;

assign reg_write_rd=
    addu_sop|
    and_sop|
    jalr_sop|
    nor_sop|
    or_sop|
    sll_sop|
    sllv_sop|
    slt_sop|
    sltu_sop|
    sra_sop|
    srav_sop|
    srl_sop|
    srlv_sop|
    subu_sop|
    xor_sop|
    add_sop|
    sub_sop|
    div_sop|
    divu_sop|
    mfhi_sop|
    mflo_sop;

//Not implemented:
assign reg_write_r20=movn_sop;
assign reg_write_r21=movz_sop;
assign reg_write_hi=mfhi_sop;
assign reg_write_lo=mflo_sop;

// assign reg_write_src,

wire regw_src_alu;
wire regw_src_pc;
wire regw_src_rs;
wire regw_src_hi;
wire regw_src_lo;

assign reg_write_src[0] = regw_src_alu;
assign reg_write_src[1] = regw_src_pc;
assign reg_write_src[2] = regw_src_rs;
assign reg_write_src[3] = regw_src_hi;
assign reg_write_src[4] = regw_src_lo;

assign regw_src_alu=
    addu_sop|
    and_sop|
    nor_sop|
    or_sop|
    slt_sop|
    sltu_sop|
    subu_sop|
    xor_sop|
    add_sop|
    sub_sop|
    sll_sop|
    sllv_sop|
    sra_sop|
    srav_sop|
    srl_sop|
    srlv_sop|
    mthi_sop|//TODO
    mtlo_sop;//TODO

assign regw_src_pc=jalr_sop;

assign regw_src_rs=
    movn_sop|
    movz_sop;//not implemented

assign regw_src_hi=mfhi_sop;
assign regw_src_lo=mflo_sop;

// assign reg_write_tgt,

wire regw_tgt_rd;
wire regw_tgt_hi;
wire regw_tgt_lo;
wire regw_tgt_nop;

assign reg_write_tgt[0]=regw_tgt_rd;
assign reg_write_tgt[1]=regw_tgt_hi;
assign reg_write_tgt[2]=regw_tgt_lo;
assign reg_write_tgt[3]=regw_tgt_nop;

assign regw_tgt_rd=
    addu_sop|
    and_sop|
    jalr_sop|
    nor_sop|
    or_sop|
    sll_sop|
    sllv_sop|
    slt_sop|
    sltu_sop|
    sra_sop|
    srav_sop|
    srl_sop|
    srlv_sop|
    subu_sop|
    xor_sop|
    add_sop|
    sub_sop|
    mfhi_sop|
    mflo_sop;

assign regw_tgt_hi=mthi_sop;
assign regw_tgt_lo=mtlo_sop;
assign regw_tgt_nop=jr_sop;

assign jmp=jalr_sop|jr_sop;

assign alu_a_src = sll_sop|sra_sop|srl_sop;

assign reg_a_valid=
    addu_sop|
    and_sop|
    jalr_sop|
    jr_sop|
    nor_sop|
    or_sop|
    sllv_sop|
    slt_sop|
    sltu_sop|
    srav_sop|
    srlv_sop|
    subu_sop|
    xor_sop|
    add_sop|
    sub_sop|
    div_sop|
    divu_sop|
    mult_sop|
    multu_sop|
    mthi_sop|
    mtlo_sop;

assign reg_b_valid=
    addu_sop|
    and_sop|
    nor_sop|
    or_sop|
    sllv_sop|
    slt_sop|
    sltu_sop|
    srav_sop|
    srlv_sop|
    subu_sop|
    xor_sop|
    add_sop|
    sll_sop|
    sra_sop|
    srl_sop|
    sub_sop|
    div_sop|
    divu_sop|
    mult_sop|
    multu_sop;

endmodule