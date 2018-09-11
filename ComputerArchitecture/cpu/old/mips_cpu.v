`timescale 10ns / 1ns

`include "define.v"

module mips_cpu(
	input  rst,
	input  clk,

	//Instruction request channel
	output [31:0] PC,
	output Inst_Req_Valid,//
	input Inst_Req_Ack,//

	//Instruction response channel
	input  [31:0] Instruction,
	input Inst_Valid,//
	output Inst_Ack,//

	//Memory request channel
	output [31:0] Address,
	output MemWrite,
	output [31:0] Write_data,
	output [3:0] Write_strb,
	output MemRead,
	input Mem_Req_Ack,//

	//Memory data response channel
	input  [31:0] Read_data,
	input Read_data_Valid,//
	output Read_data_Ack,//

	//counters
	
    output reg[31:0]	mips_perf_cnt_0,
    output reg[31:0]	mips_perf_cnt_1,
    output reg[31:0]	mips_perf_cnt_2,
    output reg[31:0]	mips_perf_cnt_3,
    output reg[31:0]	mips_perf_cnt_4,
    output reg[31:0]	mips_perf_cnt_5,
    output reg[31:0]	mips_perf_cnt_6,
    output reg[31:0]	mips_perf_cnt_7,
    output reg[31:0]	mips_perf_cnt_8,
    output reg[31:0]	mips_perf_cnt_9,
    output reg[31:0]	mips_perf_cnt_10,
    output reg[31:0]	mips_perf_cnt_11,
    output reg[31:0]	mips_perf_cnt_12,
    output reg[31:0]	mips_perf_cnt_13,
    output reg[31:0]	mips_perf_cnt_14,
    output reg[31:0]	mips_perf_cnt_15,
    output reg[31:0] PColdReg
);

// HeadOld---------------------------------------
// module mips_cpu(
// 	input  rst,
// 	input  clk,

// 	output [31:0] PC,
// 	//should be controlled by lord, to fit the testbench, used PC instead.
// 	input  [31:0] Instruction,

// 	output [31:0] Address,
// 	output MemWrite,
// 	output [31:0] Write_data,
// 	output [3:0] Write_strb,

// 	input  [31:0] Read_data,
// 	output MemRead
// );


//Link wire---------------------------
wire [2:0]ALUop;//8
wire ALUmode;//Control from ALUopC or ALUopAC
wire [2:0]ALUopC;
wire [2:0]ALUopAC;
wire [1:0]ea;
wire [31:0]PCset;
wire [31:0]REGread1;
wire [31:0]REGread2;
wire [31:0]ALUout;
wire [31:0]Shifterout;
wire [12:0]ExtenderControl;
wire [31:0]ExtenderOut;
wire [31:0]ALUin1data;
wire [31:0]ALUin2data;

wire [31:0]CountNextState;


//Enable wire-------------------------
wire PCwrite;
wire MEMread;
wire MEMwrite;
wire REGwrite;
wire Awrite;
wire Bwrite;
wire ALUwrite;
wire Instructionwrite;
wire REGwritesrcbyAC; //Decided wire REGwrite is controlled by: 0: Control 1: ALUControl
wire Branch;//(wire: enable branch)
wire R;//R->REG  else JMP etc
wire EnableShifter;
wire SpecialJump;
wire shift;

assign MemRead=MEMread;

//REG------------------------------------
	reg [31:0] PCReg;
	reg [31:0] InstructionReg;
	reg [31:0] AReg;
	reg [31:0] BReg;
	reg [31:0] ALUoutReg;
	reg [31:0] MemReg;
	// reg [16:0] StateReg;
	// wire ALUzero;
	// wire ALUsign;

	assign PC=PCReg;
	assign MemWrite=MEMwrite;

	//计数器说�?
	
	//mips_perf_cnt_0 clk
	//mips_perf_cnt_1 取�?�发送周�?
	//mips_perf_cnt_2 取�?�访存周�?
	//mips_perf_cnt_3 访存发�?�周�?
	//mips_perf_cnt_4 访存周期
	//mips_perf_cnt_5 写存周期
	//mips_perf_cnt_6 总指令数
	//mips_perf_cnt_7 J
	//mips_perf_cnt_8 B
	//mips_perf_cnt_9 R
	//mips_perf_cnt_10 L
	//mips_perf_cnt_11 S
	//mips_perf_cnt_12 I
	//mips_perf_cnt_13
	//mips_perf_cnt_14
	//mips_perf_cnt_15

		// clk触发
		// 周期
		// 取�?�发送周�?
		// 取指仿存周期
		// 仿存周期
		// 写存周期

		// exe阶段
		// 指令�?
		// J�?
		// B
		// R
		// I

		// 硬件信号探针

	//PCReg-------------------------------------

	always@(posedge clk)
	begin
		if(rst)
		begin
			PCReg<=32'hbfc00000;
			PColdReg<=32'hbfc00000;
		end
		else
		if(PCwrite)
		begin
			PCReg<=PCset;
			PColdReg<=PCReg;
		end
	end

	always@(posedge clk)
	begin
		if(Instructionwrite)
			// InstructionReg<=Read_data;(shoulde be)
			InstructionReg<=Instruction;
	end

	always@(posedge clk)
	begin
		if(Awrite)
			AReg<=REGread1;
		if(Bwrite)
			BReg<=REGread2;
	end

    wire MUL;
    
	always@(posedge clk)
	begin
		if(ALUwrite)
			if(EnableShifter&R)
				ALUoutReg<=Shifterout;
			else
			if(MUL)//Added mul here; Is the R cycle.
				ALUoutReg<=ALUin1data*ALUin2data;
			else
				ALUoutReg<=ALUout;
	end
    
    wire Read_data_write;
    
	always@(posedge clk)
	begin
		if(Read_data_write)
			MemReg<=ExtenderOut;
	end

	//Counters---------------------------------
	always@(posedge clk)
	begin
	if(rst)
	begin
		mips_perf_cnt_0<=0;
		mips_perf_cnt_1<=0;
		mips_perf_cnt_2<=0;
		mips_perf_cnt_3<=0;
		mips_perf_cnt_4<=0;
		mips_perf_cnt_5<=0;
		mips_perf_cnt_6<=0;
		mips_perf_cnt_7<=0;
		mips_perf_cnt_8<=0;
		mips_perf_cnt_9<=0;
		mips_perf_cnt_10<=0;
		mips_perf_cnt_11<=0;
		mips_perf_cnt_12<=0;
		mips_perf_cnt_13<=0;
		mips_perf_cnt_14<=0;
		mips_perf_cnt_15<=0;	  
	end
	else
	begin
	  	
		mips_perf_cnt_0<=mips_perf_cnt_0+1; //clk
		if(CountNextState==`State_Fetch)mips_perf_cnt_1<=mips_perf_cnt_1+1; //取�?�发送周�?
		if(CountNextState==`State_Fwait)mips_perf_cnt_2<=mips_perf_cnt_2+1; //取指访存周期
		if(CountNextState==`State_Lmem)mips_perf_cnt_3<=mips_perf_cnt_3+1; //访存发�?�周�?
		if(CountNextState==`State_Lwait)mips_perf_cnt_4<=mips_perf_cnt_4+1; //访存周期
		if(CountNextState==`State_Smem)mips_perf_cnt_5<=mips_perf_cnt_5+1; //写存周期
		if(CountNextState==`State_Decode)mips_perf_cnt_6<=mips_perf_cnt_6+1; //总指令数
		if(CountNextState==`State_Jexe)mips_perf_cnt_7<=mips_perf_cnt_7+1; //J
		if(CountNextState==`State_Bexe)mips_perf_cnt_8<=mips_perf_cnt_8+1; //B
		if(CountNextState==`State_Rexe)mips_perf_cnt_9<=mips_perf_cnt_9+1; //R
		if(CountNextState==`State_Lexe)mips_perf_cnt_10<=mips_perf_cnt_10+1; //L
		if(CountNextState==`State_Sexe)mips_perf_cnt_11<=mips_perf_cnt_11+1; //S
		if(CountNextState==`State_Iexe){mips_perf_cnt_13,mips_perf_cnt_12}<=mips_perf_cnt_12+1; //I
		// if(mips_perf_cnt_0==32'hffffffff)mips_perf_cnt_13<=mips_perf_cnt_13+1;
		if(1)mips_perf_cnt_14<=mips_perf_cnt_14+1;
		if(1)mips_perf_cnt_15<=mips_perf_cnt_15+1;
	end
	end
//Additional Data Wire-------------------
wire [31:0]Offset00Ext={InstructionReg[15]?14'b11_1111_1111_1111:14'b0,InstructionReg[15:0],2'b00};
wire [31:0]ImmUnsignedExt={16'b0,InstructionReg[15:0]};
wire [31:0]ImmSignedExt={InstructionReg[15]?16'hffff:16'b0,InstructionReg[15:0]};
wire [31:0]LongJmp={PCReg[31:28],InstructionReg[25:0],2'b00};

//Mux-------------------------------------
wire ALUin1;// PC A
// `define ALUin1_PC 1'b0
// `define ALUin1_A 1'b1
assign ALUin1data=(ALUin1==`ALUin1_PC)?PCReg:AReg;

wire [2:0]ALUin2; //B 0 4 (8) ImmSignedExt ImmUnsignedExt Offset00Ext
// `define ALUin2_B 3'b000
// `define ALUin2_0 3'b001
// `define ALUin2_4 3'b010
// `define ALUin2_ImmSignedExt 3'b011
// `define ALUin2_ImmUnsignedExt 3'b100
// `define ALUin2_Offset00Ext 3'b101
assign ALUin2data=	((ALUin2==`ALUin2_B)?BReg:
					((ALUin2==`ALUin2_4)?32'd4:
					((ALUin2==`ALUin2_0)?32'd0:
					((ALUin2==`ALUin2_ImmSignedExt)?ImmSignedExt:
					((ALUin2==`ALUin2_ImmUnsignedExt)?ImmUnsignedExt:
					((ALUin2==`ALUin2_Offset00Ext)?Offset00Ext:BReg
					))))));

wire ALUopsrc; //ALUopAC ALUopC
// `define ALUopsrc_ALUopAC 1'b0
// `define ALUopsrc_ALUopC 1'b1
assign ALUop=(ALUopsrc==`ALUopsrc_ALUopC)?ALUopC:ALUopAC;

wire [1:0]PCsrc;// ALU A LongJump
// `define PCsrc_ALU 2'b00 
// `define PCsrc_A 2'b01
// `define PCsrc_LongJump 2'b10
assign PCset=	(PCsrc==`PCsrc_ALU)?ALUout:
				(PCsrc==`PCsrc_A)?AReg:
				(PCsrc==`PCsrc_LongJump)?LongJmp:
				(PCsrc==`PCsrc_ALUout)?ALUoutReg
				:ALUoutReg;
				
wire [3:0]REGwritesrcC;
wire [3:0]REGwritesrcAC;

wire [3:0]REGwritesrc=(REGwritesrcbyAC?REGwritesrcAC:REGwritesrcC);// (:REGwritesrcbyAC) ALUout MEM MEMb MEMub MEMh MEMuh IMM160 MEMl MEMr A Shifter
// `define REGwritesrc_ALUout 4'b0000 
// `define REGwritesrc_MEM 4'b0001
// `define REGwritesrc_MEMb 4'b0010 
// `define REGwritesrc_MEMub 4'b0011 
// `define REGwritesrc_MEMh 4'b0100 
// `define REGwritesrc_MEMuh 4'b0101 
// `define REGwritesrc_IMM160 4'b0110 
// `define REGwritesrc_MEMl 4'b0111
// `define REGwritesrc_MEMr 4'b1000 
// `define REGwritesrc_A 4'b1001
// `define REGwritesrc_Shifter 4'b1010
// `define REGwritesrc_PC 4'b1011
// `define REGwritesrc_oldPC 4'b1111
wire [31:0]REGwritedata=
	(REGwritesrc==`REGwritesrc_PC)?PCReg:
	(REGwritesrc==`REGwritesrc_ALUout)?ALUoutReg:
	(REGwritesrc==`REGwritesrc_MEM)?MemReg:
	(REGwritesrc==`REGwritesrc_A)?AReg:
	// (REGwritesrc==`REGwritesrc_MULreg)?MULReg:
	ALUout;

wire MEMwritesrc;// B ALUout
// `define MEMwritesrc_B 1'b0 
// `define MEMwritesrc_ALUout 1'b1
wire [31:0]MEMwritedata=(MEMwritesrc==`MEMwritesrc_B)?ExtenderOut:ALUout;
assign Write_data=MEMwritedata;

wire [2:0]RegDst;// Ins20_16 Ins15_11 31 movn movz  
// `define RegDst_Ins20_16 3'b000 
// `define RegDst_Ins15_11 3'b001 
// `define RegDst_31 3'b010
// `define RegDst_movn 3'b011 
// `define RegDst_movz 3'b100 
// `define RegDst_0 3'b101

wire [4:0]Ins15_11=InstructionReg[15:11];
wire [4:0]Ins20_16=InstructionReg[20:16];

wire [2:0]REGwriteaddrsrcC;
// wire [2:0]REGwriteaddrsrcAC;
wire [2:0]REGwriteaddrsrc=(R?RegDst:REGwriteaddrsrcC);

wire[4:0]REGwriteaddr=
	(REGwriteaddrsrc==`RegDst_Ins20_16)?Ins20_16:
	(REGwriteaddrsrc==`RegDst_Ins15_11)?Ins15_11:
	(REGwriteaddrsrc==`RegDst_31)?6'd31:
	(REGwriteaddrsrc==`RegDst_movn)?((REGread2!=0)?Ins15_11:0):
	(REGwriteaddrsrc==`RegDst_movz)?((REGread2==0)?Ins15_11:0):
	0;

wire LorD;// PC ALUout
// `define LorD_PC 1'b0 
// `define LorD_ALUout 1'b1
assign Address=(LorD==`LorD_ALUout)?ALUoutReg:PCReg;

wire [5:0]BranchCond;// (5)
// 			ALUzero(=)
// 			!ALUsign(+)||ALUzero(=),20-16=00001
// 			ALUsign(-)||ALUzero(=)
// 			ALUsign(-),20-16=00000
// 			!ALUzero(!=)

wire REGread1sign=REGread1[31];
wire REGread1zero=REGread1==0;



assign BranchCond[0]=(REGread1==REGread2);
assign BranchCond[1]=(!REGread1sign|REGread1zero)&(InstructionReg[20:16]==5'b00001);
assign BranchCond[2]=(REGread1sign|REGread1zero);
assign BranchCond[3]=REGread1sign&(InstructionReg[20:16]==5'b00000);
assign BranchCond[4]=(REGread1!=REGread2);
assign BranchCond[5]=(!REGread1sign&!REGread1zero);

// use extender to control

// wire [2:0]LoadControl;//(3)  lb lbu lh lhu lui lw lwl lwr
// `define LoadControl_lb  3'b000
// `define LoadControl_lbu 3'b001 
// `define LoadControl_lh  3'b010
// `define LoadControl_lhu 3'b011 
// `define LoadControl_lui 3'b100 
// `define LoadControl_lw  3'b101
// `define LoadControl_lwl 3'b110 
// `define LoadControl_lwr 3'b111

// wire [2:0]StoreControl;//(3)  sb sh sw swl swr
// `define StoreControl_sb 3'b000 
// `define StoreControl_sh 3'b001 
// `define StoreControl_sw 3'b010 
// `define StoreControl_swl 3'b011 
// `define StoreControl_swr 3'b100

// merged with ALUopAC
// wire [2:0]ShiftControl;//(3) sll sllv sra srav srl srlv 
// `define ShiftControl_sll 3'b000 
// `define ShiftControl_sllv 3'b001 
// `define ShiftControl_sra 3'b010
// `define ShiftControl_srav 3'b011 
// `define ShiftControl_srl 3'b100
// `define ShiftControl_srlv 3'b101

//RegFile-------------------------------------
reg_file RegFile(
	.clk(clk),
	.rst(rst),
	.waddr(REGwriteaddr),
	.raddr1(InstructionReg[25:21]),
	.raddr2(InstructionReg[20:16]),
	.wen(REGwrite),
	.wdata(REGwritedata),
	.rdata1(REGread1),
	.rdata2(REGread2)
);

//ALU-------------------------------------
alu ALU(
	.A(ALUin1data),
	.B(ALUin2data),
	.ALUop(ALUop),
	.Overflow(),
	.CarryOut(),
	.Zero(),
	.Result(ALUout)
);

//MULcalc----------------------------------

// reg [31:0] MULReg;
// wire MUL;
// always@(posedge clk)
// begin
// 	if(MUL)
// 	begin
// 		MULReg<=ALUin1data*ALUin2data;
// 	end
// end

//Shifter---------------------------------
shifter Shifter(
	.shiftmode(ALUopAC),
    .source(shift),
    .shiftbit(InstructionReg[10:6]),
    .reg_shiftbit(AReg),
    .shifter_input(BReg),
    .shifter_output(Shifterout)
);

//Extender---------------------------------
extender Extender(
    .extender_control(ExtenderControl),
    .mem_input(Read_data),//from mem
    .reg_input(BReg),//from reg
	.ins_input(InstructionReg[15:0]),
    .ea(ALUoutReg[1:0]),
    .extender_output(ExtenderOut),
    .strb(Write_strb)
);

// Control Logic----------------------------

control Control(
	.rst(rst),
	.clk(clk),
	.InstructionReg(InstructionReg),
    .Branch(Branch),
	.SpecialJump(SpecialJump),
	.PCwrite(PCwrite),
	.MEMread(MEMread),
	.MEMwrite(MEMwrite),
	.REGwrite(REGwrite),
	.Awrite(Awrite),
	.Bwrite(Bwrite),
	.Instructionwrite(Instructionwrite),
	.REGwritesrcbyAC(REGwritesrcbyAC), //Decided wire REGwrite is controlled by: 0: Control 1: ALUControl
	.ALUin1(ALUin1),// PC A
	.ALUin2(ALUin2), //B 0 4 (8) ImmSignedExt ImmUnsignedExt Offset00Ext
	.ALUopsrc(ALUopsrc), //ALUopAC ALUopC
    .ALUwrite(ALUwrite),
	.PCsrc(PCsrc),// ALU A LongJump
	.REGwritesrc(REGwritesrcC),// (:REGwritesrcbyAC) ALUout MEM MEMb MEMub MEMh MEMuh IMM160 MEMl MEMr A Shifter
	.MEMwritesrc(MEMwritesrc),// B ALUout
	.RegDst(),// Ins20_16 Ins15_11 31 movn movz  
	.LorD(LorD),// PC ALUout
	.BranchCond(BranchCond),// (5)
    .ExtenderControl(ExtenderControl),
	.ALUopC(ALUopC),
	.R(R),
	.REGwriteaddrsrc(REGwriteaddrsrcC),
	
	.Inst_Req_Valid(Inst_Req_Valid),//
	.Inst_Req_Ack(Inst_Req_Ack),//
	//Instruction response channel
	.Inst_Valid(Inst_Valid),//
	.Inst_Ack(Inst_Ack),//
	//Memory request channel
	.Mem_Req_Ack(Mem_Req_Ack),//
	//Memory data response channel
	.Read_data_Valid(Read_data_Valid),//
	.Read_data_Ack(Read_data_Ack),//
	.Read_data_write(Read_data_write),
	.CountNextState(CountNextState),

	.MUL(MUL)
);

// ALUcontrol Logic-------------------------
alucontrol ALUcontrol(
    .R(R),
    .Instruction50(InstructionReg[5:0]),
    .ALUopAC(ALUopAC),
    .REGwritesrc(REGwritesrcAC),
    .RegDst(RegDst),
    .shift(shift),
    .enableshifter(EnableShifter),
	.SpecialJump(SpecialJump)
);



// 使用FSM控制各种写信�?
// assign其他信号




endmodule


