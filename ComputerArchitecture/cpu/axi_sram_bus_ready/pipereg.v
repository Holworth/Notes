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
wire [31:0]PC;

wire jump_short;//1
wire jump_long;//1
wire jump_alu;//1
wire alu_a_src;//1
wire [3:0]alu_b_src;//4
wire [15:0] aluop;//16
wire [4:0]mem_wen_pick;//5
wire reg_a_valid;//1
wire reg_b_valid;//1
wire mem_read;//1
wire reg_write;//1
wire [15:0]reg_write_src;//16
wire [5:0]reg_write_tgt;//6
wire [3:0]mul_control;//4
wire beq;
wire bgez;
wire blez;
wire bltz;
wire bne;
wire bgtz;
wire bgezal;
wire bltzal;
wire r_type;
wire[4:0]regfile_waddr;

assign
    {
        inst,
        A_data,
        B_data,
        PC,
        jump_short,//1
        jump_long,//1
        jump_alu,//1
        alu_a_src,//1
        alu_b_src,//4
        aluop,//16
        mem_wen_pick,//5
        reg_a_valid,//1
        reg_b_valid,//1
        mem_read,//1
        reg_write,//1
        reg_write_src,//16
        reg_write_tgt,//6
        mul_control,//4
        beq,
        bgez,
        blez,
        bltz,
        bne,
        bgtz,
        bgezal,
        bltzal,
        r_type,
        regfile_waddr
    }
    =datain;

endmodule