//control.v
//Huaqiang Wang (c) 2018

`include "define.v"

module control(
	input rst,
	input clk,
	input [31:0]InstructionReg,
    input Branch,
    input SpecialJump,
	output reg PCwrite,
	output reg MEMread,
	output reg MEMwrite,
	output reg REGwrite,
	output reg Awrite,
	output reg Bwrite,
	output reg Instructionwrite,
	output reg REGwritesrcbyAC, //Decided wire REGwrite is controlled by: 0: Control 1: ALUControl
	// output Branch,//(wire: enable branch)
	output reg ALUin1,// PC A
	output reg [2:0]ALUin2, //B 0 4 (8) ImmSignedExt ImmUnsignedExt Offset00Ext
	output reg ALUopsrc, //ALUopAC ALUopC
    output reg ALUwrite,
	output reg [1:0]PCsrc,// ALU A LongJump
	output reg [3:0]REGwritesrc,// (:REGwritesrcbyAC) ALUout MEM MEMb MEMub MEMh MEMuh IMM160 MEMl MEMr A Shifter
	output reg MEMwritesrc,// B ALUout
	output reg [2:0]RegDst,// Ins20_16 Ins15_11 31 movn movz  
	output reg LorD,// PC ALUout
	input [5:0]BranchCond,// (5)
    output [12:0]ExtenderControl,
	// output reg [2:0]LoadControl,//(3)  lb lbu lh lhu lui lw lwl lwr
	// output reg [2:0]StoreControl,//(3)  sb sh sw swl swr
	// output reg [2:0]ShiftControl,//(3) sll sllv sra srav srl srlv

	// output reg ALUmode,
	output reg [2:0]ALUopC,
	output R,
	output reg [2:0]REGwriteaddrsrc,

    //prj3 added
    output reg Inst_Req_Valid,//
	input Inst_Req_Ack,//

	//Instruction response channel
	input Inst_Valid,//
	output reg Inst_Ack,//

	//Memory request channel
	input Mem_Req_Ack,//

	//Memory data response channel
	input Read_data_Valid,//
	output reg Read_data_Ack,//

    output reg Read_data_write,

    output [15:0]CountNextState,

    //for mul
    output  MUL
    
);

endmodule