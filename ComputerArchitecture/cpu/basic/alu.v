//alu.v
//Huaqiang Wang (c) 2018

`timescale 10 ns / 1 ns

`define DATA_WIDTH 32
// `define AND 3'b000
// `define OR 3'b001
// `define ADD 3'b010
// `define SUB 3'b110
// `define SLT 3'b111
// `define XOR 3'b100
// `define NOR 3'b101
// `define SLTU 3'b011

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


module alu(
    input [`DATA_WIDTH - 1:0] A,
    input [`DATA_WIDTH - 1:0] B,
    input [15:0] ALUop,
    output Overflow,
    output CarryOut,
    output Zero,
    output [`DATA_WIDTH - 1:0] Result
);

    // reg [`DATA_WIDTH - 1:0] Result;

    //公用加法器逻辑
    wire [`DATA_WIDTH+1:0]adder_with_cin;
    wire [`DATA_WIDTH:0]adder;
    wire [`DATA_WIDTH:0]addee;

    //加法器使用的cin
    wire neg1;
    assign neg1=((ALUop==`ALUOP_ADD)?0:1);

    //带cin的共用加法器
    assign addee=((ALUop==`ALUOP_ADD)?B:~B);
    assign adder=adder_with_cin[`DATA_WIDTH+1:1];
    assign adder_with_cin={1'b0,A,neg1}+{addee,neg1}; 

    //标志位(flag)输出逻辑
    assign CarryOut=adder[32];

    assign Zero=({Result}==0);

    assign Overflow=
        ((ALUop==`ALUOP_AND)?
        (A[`DATA_WIDTH - 1]==B[`DATA_WIDTH - 1])&&(adder[`DATA_WIDTH - 1]!=A[`DATA_WIDTH - 1]):
        (A[`DATA_WIDTH - 1]!=B[`DATA_WIDTH - 1])&&(adder[`DATA_WIDTH - 1]!=A[`DATA_WIDTH - 1]));
    
    //移位器逻辑

    wire [63:0]shift_right_64;
    wire [63:0]shift_aright_64;

    wire [31:0]result_sll;
    wire [31:0]result_sr;
    
    wire op_sra;
    assign op_sra=ALUop[10];

    assign shift_right_64={{32{op_sra&B[31]}},B}>>A[4:0];
    
    assign result_sll=B<<A[4:0];
    assign result_sr=shift_right_64[31:0];

    //LUI逻辑

    wire [31:0]result_lui;
    assign result_lui={B[15:0],16'b0};//TODO

    //选择器逻辑

    assign Result=
        ({32{ALUop==`ALUOP_AND}}&(A&B))|
        ({32{ALUop==`ALUOP_OR} }&(A|B))|
        ({32{ALUop==`ALUOP_ADD}}&adder)|
        ({32{ALUop==`ALUOP_SUB}}&adder)|
        ({32{ALUop==`ALUOP_XOR}}&(A^B))|
        ({32{ALUop==`ALUOP_NOR}}&(~(A|B)))|
        ({32{ALUop==`ALUOP_SLTU}}&{31'b0,CarryOut})|
        ({32{ALUop==`ALUOP_SLT}}&{31'b0,adder[`DATA_WIDTH-1]^Overflow})|
        ({32{ALUop==`ALUOP_SLL}}&result_sll)|
        ({32{ALUop==`ALUOP_SRL}}&result_sr)|
        ({32{ALUop==`ALUOP_SRA}}&result_sr)|
        ({32{ALUop==`ALUOP_LUI}}&result_lui)|
        ({32{ALUop==`ALUOP_A}}&A)|
        ({32{ALUop==`ALUOP_B}}&B)
        ;

endmodule
