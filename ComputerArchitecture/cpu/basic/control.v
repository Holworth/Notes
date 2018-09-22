//control.v
//Huaqiang Wang (c) 2018

`include "define.v"

module control(
    input [31:0]inst,
    input [31:0]A,
    input [31:0]B,
    output jump_short,
    output jump_long,
    output [3:0]alu_b_src,
    output [15:0] aluop,
    output [3:0]mem_wen,
    output reg_a_valid,
    output reg_b_valid,
    output mem_read,
    output reg_write,
    output [15:0]reg_write_src,
    output [3:0]reg_write_tgt
);

assign inst2016=inst[20:16];
assign opcode=inst[31:26];

//decoder
//----------------------------------

assign beq_op= opcode==6'b000100;
assign bgez_op= (opcode==6'b000001)&(inst2016==00001);
assign blez_op= (opcode==6'b000110)&(inst2016==00000);
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
assign swl_op= opcode==6'b101011;
assign swr_op= opcode==6'b101110;
assign xori_op= opcode==6'b001110;
assign j_op= opcode==6'b000010;
assign jal_op= opcode==6'b000011;
assign slti_op= opcode==6'b001010;
assign sltiu_op= opcode==6'b001011;
assign addi_op= opcode==6'b001000;
assign bgtz_op= (opcode==6'b000111)&(inst2016==00000);
assign bgezal_op= (opcode==6'b000001)&(inst2016==10001);
assign bltzal_op= (opcode==6'b000001)&(inst2016==10000);
assign r_op= opcode==6'b000000;

assign jump_short=
beq_op&(A==B)|
bgez_op&(!A[31])|
blez_op&(A[31]|(A==0))|
bltz_op&(A[31])|
bne_op&(A!=B)|
bgtz_op&((!A[31])&(A!=0))|
bgezal_op&(!A[31])|
bltzal_op&(A[31]);

    output jump_long,
    output [3:0]alu_b_src,
    output [15:0] aluop,
    output [3:0]mem_wen,
    output reg_a_valid,
    output reg_b_valid,
    output mem_read,
    output reg_write,
    output [15:0]reg_write_src,
    output [3:0]reg_write_tgt


endmodule