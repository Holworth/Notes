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

//IF-------------------------------

`define IF_STAGE_0=1'b0;
`define IF_STAGE_1=1'b1;