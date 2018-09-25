//pipereg.v
//pipe_reg_interpreter
//Huaqiang Wang (c) 2018
`include "define.v"

module pipe_reg_interpreter(
    input [219:0] datain
);

wire [31:0]inst;
wire [31:0]A_data;
wire [31:0]B_data;
wire [53:0]control_data;
wire [37:0]alucontrol_data;
wire [31:0]PC;

assign
    {
        inst,
        A_data,
        B_data,
        control_data,
        alucontrol_data,
        PC
    }
    =datain;

wire control_jump_short;//1
wire control_jump_long;//1
wire [3:0]control_alu_b_src;//4
wire [15:0]control_aluop;//16
wire [4:0]control_mem_wen_pick;//5
wire control_reg_a_valid;//1
wire control_reg_b_valid;//1
wire control_mem_read;//1
wire control_reg_write;//1
wire [15:0]control_reg_write_src;//16
wire [5:0]control_reg_write_tgt;//6
wire control_r_type;//1
wire [15:0]alucontrol_aluop;//16
wire [3:0]alucontrol_mul_control;//4
wire [4:0]alucontrol_reg_write;//5
wire [4:0]alucontrol_reg_write_src;//5
wire [3:0]alucontrol_reg_write_tgt;//4
wire alucontrol_jmp;//1
wire alucontrol_alu_a_src;//1
wire alucontrol_reg_a_valid;
wire alucontrol_reg_b_valid;

//Recover data

assign
    {
        control_jump_short,
        control_jump_long,
        control_alu_b_src,
        control_aluop,
        control_mem_wen_pick,
        control_reg_a_valid,
        control_reg_b_valid,
        control_mem_read,
        control_reg_write,
        control_reg_write_src,
        control_reg_write_tgt,
        control_r_type
    }
    =control_data;

assign
    {
        alucontrol_aluop,
        alucontrol_mul_control,
        alucontrol_reg_write,
        alucontrol_reg_write_src,
        alucontrol_reg_write_tgt,
        alucontrol_jmp,
        alucontrol_alu_a_src,
        alucontrol_reg_a_valid,
        alucontrol_reg_b_valid
    }
    =alucontrol_data;

//Generate real control logic
wire reg_write;
wire [3:0]mul_control;
wire alu_a_src;
wire [3:0]alu_b_src;
wire [4:0]mem_wen_pick;
wire [15:0]reg_write_src;
wire [5:0]reg_write_tgt;
wire jump_short;
wire jump_long;
wire jump_alu;
wire [15:0]aluop;
wire reg_a_valid;
wire reg_b_valid;
wire mem_read;
wire r_type;
wire [4:0]rs;
wire [4:0]rt;
wire [4:0]rd;

assign rs=inst[25:21];
assign rt=inst[20:16];
assign rd=inst[15:11];


assign reg_write=(r_type?alucontrol_reg_write:control_reg_write);
assign mul_control=(r_type?alucontrol_mul_control:4'b0);
//There is a grammer problem:
//`define alu_a_src_a 1'b0;
assign alu_a_src=(r_type?alucontrol_alu_a_src:1'b0);
//alu_b_src_reg 4'b1000
// assign alu_b_src=(r_type?`alu_b_src_reg:control_alu_b_src);
assign alu_b_src=(r_type?4'b1000:control_alu_b_src);
assign mem_wen_pick=control_mem_wen_pick;
assign reg_write_src=(r_type?{11'b0,alucontrol_reg_write_src}:control_reg_write_src);
assign reg_write_tgt=(r_type?{2'b0,alucontrol_reg_write_tgt}:control_reg_write_tgt);
assign jump_short=control_jump_short;
assign jump_long=control_jump_long;
assign jump_alu=alucontrol_jmp&r_type;
assign aluop=(r_type?alucontrol_aluop:control_aluop);
assign reg_a_valid=(r_type?alucontrol_reg_a_valid:control_reg_a_valid);
assign reg_b_valid=(r_type?alucontrol_reg_b_valid:control_reg_b_valid);
assign mem_read=control_mem_read;
assign reg_write=(r_type?alucontrol_reg_write:control_reg_write);
assign r_type=control_r_type;

wire [4:0]regfile_waddr;

assign regfile_waddr=
    ({5{reg_write_tgt[0]}}&rd)|
    ({5{reg_write_tgt[4]}}&rt)|
    ({5{reg_write_tgt[5]}}&5'd31);

wire mem_write=
    control_mem_wen_pick!=0;

//TODO: move all these logic into decode part

endmodule