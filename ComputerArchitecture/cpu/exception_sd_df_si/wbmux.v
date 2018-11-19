//memmux.v
//used for choosing data for sx and data from lx
//Huaqiang Wang (c) 2018

`include"define.v"

module wbmux(
    input[15:0]reg_write_src,
    input[4:0]mem_wen_pick,
    input [31:0]reg_input,//from reg
    input [31:0]ins_input,//from ins
    input [31:0]mem_input,//from mem
    input [1:0]ea,
    input [31:0]pc,
    input [31:0]hi,
    input [31:0]lo,
    input [31:0]alu,
    output [31:0] mux_output,
    output [3:0] strb
);

wire[3:0] strb_swl=
    {4{ea==2'b00}}&4'b0001|
    {4{ea==2'b01}}&4'b0011|
    {4{ea==2'b10}}&4'b0111|
    {4{ea==2'b11}}&4'b1111;
wire[3:0] strb_swr=
    {4{ea==2'b00}}&4'b1111|
    {4{ea==2'b01}}&4'b1110|
    {4{ea==2'b10}}&4'b1100|
    {4{ea==2'b11}}&4'b1000;
wire[3:0] strb_sb=
    {4{ea==2'b00}}&4'b0001|
    {4{ea==2'b01}}&4'b0010|
    {4{ea==2'b10}}&4'b0100|
    {4{ea==2'b11}}&4'b1000;
wire[3:0] strb_sh=
    {4{ea[1]==1'b1}}&4'b1100|
    {4{ea[1]==1'b0}}&4'b0011;
wire[3:0] strb_sw=4'b1111;

assign strb=
    ({4{{reg_write_src,mem_wen_pick}==`swl}}&strb_swl)|
    ({4{{reg_write_src,mem_wen_pick}==`swr}}&strb_swr)|
    ({4{{reg_write_src,mem_wen_pick}==`sb}}&strb_sb)|
    ({4{{reg_write_src,mem_wen_pick}==`sh}}&strb_sh)|
    ({4{{reg_write_src,mem_wen_pick}==`sw}}&strb_sw);

wire [31:0]lw_out=mem_input;
wire [31:0]lh_out=
    {32{ea[1]==1'b0}}&(mem_input[15]?{16'b11111111_11111111,mem_input[15:0]}:{16'b0,mem_input[15:0]})|
    {32{ea[1]==1'b1}}&(mem_input[31]?{16'b11111111_11111111,mem_input[31:16]}:{16'b0,mem_input[31:16]});
wire [31:0]lhu_out=
    {32{ea[1]==1'b0}}&({16'b0,mem_input[15:0]})|
    {32{ea[1]==1'b1}}&({16'b0,mem_input[31:16]});
wire [31:0]lb_out=
    {32{(ea==2'b00)}}&(mem_input[7]?{24'b111111_111111_111111_111111,mem_input[7:0]}:{24'b0,mem_input[7:0]})|
    {32{(ea==2'b01)}}&(mem_input[15]?{24'b111111_111111_111111_111111,mem_input[15:8]}:{24'b0,mem_input[15:8]})|
    {32{(ea==2'b10)}}&(mem_input[23]?{24'b111111_111111_111111_111111,mem_input[23:16]}:{24'b0,mem_input[23:16]})|
    {32{(ea==2'b11)}}&(mem_input[31]?{24'b111111_111111_111111_111111,mem_input[31:24]}:{24'b0,mem_input[31:24]});
wire [31:0]lbu_out=
    {32{(ea==2'b00)}}&({24'b0,mem_input[7:0]})|
    {32{(ea==2'b01)}}&({24'b0,mem_input[15:8]})|
    {32{(ea==2'b10)}}&({24'b0,mem_input[23:16]})|
    {32{(ea==2'b11)}}&({24'b0,mem_input[31:24]});
wire [31:0]lwl_out=
    {32{(ea==2'b00)}}&({mem_input[7:0],reg_input[23:0]})|
    {32{(ea==2'b01)}}&({mem_input[15:0],reg_input[15:0]})|
    {32{(ea==2'b10)}}&({mem_input[23:0],reg_input[7:0]})|
    {32{(ea==2'b11)}}&({mem_input[31:0]});
wire [31:0]lwr_out=
    {32{(ea==2'b00)}}&({mem_input[31:0]})|
    {32{(ea==2'b01)}}&({reg_input[31:24],mem_input[31:8]})|
    {32{(ea==2'b10)}}&({reg_input[31:16],mem_input[31:16]})|
    {32{(ea==2'b11)}}&({reg_input[31:8],mem_input[31:24]});
wire [31:0]swl_out=
    {32{(ea==2'b00)}}&({24'b0,reg_input[31:24]})|
    {32{(ea==2'b01)}}&({16'b0,reg_input[31:16]})|
    {32{(ea==2'b10)}}&({8'b0,reg_input[31:8]})|
    {32{(ea==2'b11)}}&({reg_input[31:0]});
wire [31:0]swr_out=
    {32{(ea==2'b00)}}&({reg_input[31:0]})|
    {32{(ea==2'b01)}}&({reg_input[23:0],8'b0})|
    {32{(ea==2'b10)}}&({reg_input[15:0],16'b0})|
    {32{(ea==2'b11)}}&({reg_input[7:0],24'b0});
wire [31:0]sb_out=
    {32{(ea==2'b00)}}&({24'b0,reg_input[7:0]})|
    {32{(ea==2'b01)}}&({16'b0,reg_input[7:0],8'b0})|
    {32{(ea==2'b10)}}&({8'b0,reg_input[7:0],16'b0})|
    {32{(ea==2'b11)}}&({reg_input[7:0],24'b0});
wire [31:0]sh_out=
    {32{ea[1]==1'b0}}&({16'b0,reg_input[15:0]})|
    {32{ea[1]==1'b1}}&({reg_input[15:0],16'b0});
wire [31:0]sw_out={reg_input};
wire [31:0]lui_out={ins_input,16'b0};
wire [31:0]alu_out=alu;
wire [31:0]pc_out={pc+32'd8};
wire [31:0]hi_out=hi;
wire [31:0]lo_out=lo;
wire [31:0]pc8_out={pc+32'd8};

assign mux_output=
    {32{reg_write_src[13]}}&lw_out|
    {32{reg_write_src[7]}}&lb_out|
    {32{reg_write_src[9]}}&lh_out|
    {32{reg_write_src[8]}}&lbu_out|
    {32{reg_write_src[10]}}&lhu_out|
    {32{reg_write_src[11]}}&lwl_out|
    {32{reg_write_src[12]}}&lwr_out|
    {32{mem_wen_pick[3]}}&swl_out|
    {32{mem_wen_pick[4]}}&swr_out|
    {32{mem_wen_pick[2]}}&sb_out|
    {32{mem_wen_pick[1]}}&sh_out|
    {32{mem_wen_pick[0]}}&sw_out|
    {32{reg_write_src[14]}}&lui_out|
    {32{reg_write_src[0]}}&alu_out|
    {32{reg_write_src[1]}}&pc_out|
    {32{reg_write_src[3]}}&hi_out|
    {32{reg_write_src[4]}}&lo_out|
    {32{reg_write_src[5]}}&32'b0|
    {32{reg_write_src[6]}}&pc8_out;
    // {32{({reg_write_src,mem_wen_pick}==`lw)}}&lw_out|

endmodule
