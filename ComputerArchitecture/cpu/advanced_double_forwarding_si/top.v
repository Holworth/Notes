//A 5-level pipelined MIPs32 CPU 
//Huaqiang Wang (c) 2018
//top.v
`include "define.v"

module mycpu_top(
    input            clk,
    input            resetn,            //low active

    output           inst_sram_en,
    output  [ 3:0]   inst_sram_wen,
    output  [31:0]   inst_sram_addr,
    output  [31:0]   inst_sram_wdata,
    input   [31:0]   inst_sram_rdata,
    
    output           data_sram_en,
    output  [ 3:0]   data_sram_wen,
    output  [31:0]   data_sram_addr,
    output  [31:0]   data_sram_wdata,
    input   [31:0]   data_sram_rdata,

    //debug interface
    output  [31:0]   debug_wb_pc,
    output  [3 :0]   debug_wb_rf_wen,
    output  [4 :0]   debug_wb_rf_wnum,
    output  [31:0]   debug_wb_rf_wdata
);

//const wire define
//---------------------------------

wire [31:0]wire_to_IF_PC_reg;
wire [31:0]IF_PC_in;

assign inst_sram_en=1'b1;
assign inst_sram_wen=4'b0000;
assign inst_sram_addr=IF_PC_in;
assign inst_sram_wdata=32'b0;

assign data_sram_en=1'b1;


//----------------------------------------------
//Import modules
//----------------------------------------------

//regfile
//---------------------------------

wire [4:0] regfile_waddr;
wire [4:0] regfile_raddr1;
wire [4:0] regfile_raddr2;
wire regfile_wen;
wire [31:0] regfile_wdata;
wire [31:0] regfile_rdata1;
wire [31:0] regfile_rdata2;

reg_file regfile(
	clk,
	!resetn,
	regfile_waddr,
	regfile_raddr1,
	regfile_raddr2,
	regfile_wen,
	regfile_wdata,
	regfile_rdata1,
	regfile_rdata2
);

//special regs
//---------------------------------

reg [31:0]HI;
reg [31:0]LO;
reg [63:0]mul_result;
reg [63:0]div_result;

//ALU
//---------------------------------

    wire [31:0] A;
    wire [31:0] B;
    wire [15:0] ALUop;
    wire Overflow;
    wire CarryOut;
    wire Zero;
    wire [31:0] Result;

alu alu(
    A,
    B,
    ALUop,
    Overflow,
    CarryOut,
    Zero,
    Result
);

//mul&div
//---------------------------------

//TODO 乘法除法实现

//------------------------------------------
//Pipeline design
//------------------------------------------

//stage pre-IF------------------------------

//deal with ID inst delay when reset:
// reg rst_delay_reg;
// always@(posedge clk)begin
//     if(!resetn)begin
//         rst_delay_reg<=0;
//     end
//     else begin
//         rst_delay_reg<=1;
//     end
// end

// assign inst_sram_addr=IF_PC_in;


//stage IF-----------------------------

//IF control
reg IF_ID_valid;//data in this stage is valid
// reg IF_ID_data;//TODO
wire IF_ID_valid_in;//input wire: data from last stage is valid
wire IF_ID_allowin;//data can get in this stage
wire IF_ID_readygo;//data can get out of this stage
wire IF_ID_valid_out;//output wire: data from this stage is valid
wire IF_ID_allowout;//data is getting out of this stage

assign IF_ID_valid_in=resetn;

assign IF_ID_readygo=1;//data can flow out of this stage
assign IF_ID_allowin=IF_ID_readygo&&ID_EX_allowin||!IF_ID_valid;
assign IF_ID_valid_out=IF_ID_valid&&IF_ID_readygo;
assign IF_ID_allowout=IF_ID_readygo&&ID_EX_allowin;

//IF data
reg [31:0] IF_delayslot;
reg [31:0] IF_inst_reg;

//Wires used for PC jumping
wire [31:0]PC_new;
wire jump;
wire [31:0]PC_4=IF_delayslot+4;

//IF_ID data
reg [31:0] IF_ID_PC_reg;

//Jump control
wire jump_short;
wire jump_long;
wire jump_alu;
wire jump_nop;

// assign jump_nop=~(jump_short|jump_long|jump_alu;

wire [31:0]PC_jump_short;
wire [31:0]PC_jump_long;
wire [31:0]PC_jump_alu;

assign jump_nop=~(jump_short|jump_long|jump_alu);

assign IF_PC_in=(resetn)?
    (bubble|div_stall)?IF_delayslot:
    (
    ({32{jump_short}}&PC_jump_short)|
    ({32{jump_long}}&PC_jump_long)|
    ({32{jump_alu}}&PC_jump_alu)|
    ({32{~(jump_short|jump_long|jump_alu)}}&PC_4)):32'hbfc00000;

//d flipflop of IF_delayslot
always@(posedge clk)begin
    if(!resetn)begin
        IF_delayslot<=32'hbfc00000;
    end
    else begin
        IF_delayslot<=(IF_ID_allowout?IF_PC_in:IF_delayslot);
    end
end


//d flipflop of IF_inst
//IF data flow
always@(posedge clk)begin
    if(!resetn)begin
        IF_ID_valid<=1'b0;
        IF_ID_PC_reg<=32'b0;
        IF_inst_reg<=32'b0;
    end
    else if(IF_ID_allowin)begin
        IF_ID_valid<=IF_ID_valid_in;
    end
    if(IF_ID_valid_in&&IF_ID_allowin)begin
        IF_ID_PC_reg<=IF_delayslot;
        IF_inst_reg<=inst_sram_rdata;
    end
end


//stage ID----------------------------
//ID control
reg ID_EX_valid;//data in this stage is valid
reg [219:0]ID_EX_data;
wire [219:0]ID_EX_datain;
wire ID_EX_valid_in;//input wire: data from last stage is valid
wire ID_EX_allowin;//data can get in this stage
wire ID_EX_readygo;//data can get out of this stage
wire ID_EX_valid_out;//output wire: data from this stage is valid
wire ID_EX_allowout;//data is getting out of this stage

assign ID_EX_valid_in=IF_ID_valid_out;
assign ID_EX_readygo=inst_sent;//data can flow out of this stage
//decode need only 1 clock cycle, yet 
assign ID_EX_allowin=ID_EX_readygo&&EX_MEM_allowin||!ID_EX_valid;

//Always send bubble or inst
assign ID_EX_valid_out=1;

//ID_EX_valid&&ID_EX_readygo;
assign ID_EX_allowout=ID_EX_readygo&&ID_EX_allowin;

wire inst_sent;
wire bubble;
assign inst_sent=~bubble;

//ID data

wire [31:0] ID_inst_in;
assign ID_inst_in=IF_inst_reg;



//ID speical wire:

//Additional Data Wire in ID

wire [31:0]Offset00Ext={ID_inst_in[15]?14'b11_1111_1111_1111:14'b0,ID_inst_in[15:0],2'b00};
wire [31:0]ImmUnsignedExt={16'b0,ID_inst_in[15:0]};
wire [31:0]ImmSignedExt={ID_inst_in[15]?16'hffff:16'b0,ID_inst_in[15:0]};
wire [31:0]LongJmp={IF_delayslot[31:28],ID_inst_in[25:0],2'b00};

//Additional Data Reg in ID/EX

reg [31:0]Offset00Ext_reg;
reg [31:0]ImmUnsignedExt_reg;
reg [31:0]ImmSignedExt_reg;
reg [31:0]LongJmp_reg;

//d-ff with resetn
always@(posedge clk)begin
    if(!resetn)begin
        Offset00Ext_reg<=32'b0;
        ImmUnsignedExt_reg<=32'b0;
        ImmSignedExt_reg<=32'b0;
        LongJmp_reg<=32'b0;
    end
    else begin
        Offset00Ext_reg<=Offset00Ext;
        ImmUnsignedExt_reg<=ImmUnsignedExt;
        ImmSignedExt_reg<=ImmSignedExt;
        LongJmp_reg<=LongJmp;
    end
end

//Link reg read logic here

wire [4:0]ID_rs=ID_inst_in[25:21];
wire [4:0]ID_rt=ID_inst_in[20:16];
wire [4:0]ID_rd=ID_inst_in[15:11];

assign regfile_raddr1=ID_rs;
assign regfile_raddr2=ID_rt;

wire [31:0]A_data;
wire [31:0]B_data;

//Jump address calc in ID


assign PC_jump_short=IF_delayslot+Offset00Ext;
assign PC_jump_long=LongJmp;
assign PC_jump_alu=A_data;


//ID Decode Logic
//Control and ALUcontrol

wire ID_control_jump_short;//1
wire ID_control_jump_long;//1
wire [3:0]ID_control_alu_b_src;//4
wire [15:0]ID_control_aluop;//16
wire [4:0]ID_control_mem_wen_pick;//5
wire ID_control_reg_a_valid;//1
wire ID_control_reg_b_valid;//1
wire ID_control_mem_read;//1
wire ID_control_reg_write;//1
wire [15:0]ID_control_reg_write_src;//16
wire [5:0]ID_control_reg_write_tgt;//6
wire ID_control_r_type;//1
wire [15:0]ID_alucontrol_aluop;//16
wire [3:0]ID_alucontrol_mul_control;//4
wire [4:0]ID_alucontrol_reg_write;//5
wire [4:0]ID_alucontrol_reg_write_src;//5
wire [3:0]ID_alucontrol_reg_write_tgt;//4
wire ID_alucontrol_jmp;//1
wire ID_alucontrol_alu_a_src;//1
wire ID_alucontrol_reg_a_valid;
wire ID_alucontrol_reg_b_valid;

control control(
    ID_inst_in,
    A_data,
    B_data,
    ID_control_jump_short,//1
    ID_control_jump_long,//1
    ID_control_alu_b_src,//4
    ID_control_aluop,//16
    ID_control_mem_wen_pick,//5
    ID_control_reg_a_valid,//1
    ID_control_reg_b_valid,//1
    ID_control_mem_read,//1
    ID_control_reg_write,//1
    ID_control_reg_write_src,//16
    ID_control_reg_write_tgt,//6
    ID_control_r_type//1
    //54 bit in total
);

alucontrol alucontrol(
    ID_inst_in,
    ID_alucontrol_aluop,//16
    ID_alucontrol_mul_control,//4
    ID_alucontrol_reg_write,//5
    ID_alucontrol_reg_write_src,//5
    ID_alucontrol_reg_write_tgt,//4
    ID_alucontrol_jmp,//1
    ID_alucontrol_alu_a_src,//1
    ID_alucontrol_reg_a_valid,
    ID_alucontrol_reg_b_valid
    //38 bit in total
);


//Generate data to be saved

wire [53:0]control_data=
    {
        ID_control_jump_short,
        ID_control_jump_long,
        ID_control_alu_b_src,
        ID_control_aluop,
        ID_control_mem_wen_pick,
        ID_control_reg_a_valid,
        ID_control_reg_b_valid,
        ID_control_mem_read,
        ID_control_reg_write,
        ID_control_reg_write_src,
        ID_control_reg_write_tgt,
        ID_control_r_type
    };

wire [37:0]alucontrol_data=
    {
        ID_alucontrol_aluop,
        ID_alucontrol_mul_control,
        ID_alucontrol_reg_write,
        ID_alucontrol_reg_write_src,
        ID_alucontrol_reg_write_tgt,
        ID_alucontrol_jmp,
        ID_alucontrol_alu_a_src,
        ID_alucontrol_reg_a_valid,
        ID_alucontrol_reg_b_valid
    };

//Need to save:
//inst 32
//a,b 64
//control logic 54+38

wire [219:0]ID_data_gen=
    {
        ID_inst_in,
        A_data,
        B_data,
        control_data,
        alucontrol_data,
        IF_ID_PC_reg
    };
wire [219:0]ID_data_in;

pipe_reg_interpreter ID_control_signal(ID_data_gen);

assign jump_short=ID_control_signal.jump_short;
assign jump_long=ID_control_signal.jump_long;
assign jump_alu=ID_control_signal.jump_alu;

assign ID_EX_datain=ID_data_gen;

//MEM addr calc

wire [31:0]ID_MEM_addr;
assign ID_MEM_addr=A_data+ImmSignedExt;

//ID_EX data
reg [31:0] ID_EX_MEM_addr_reg;
pipe_reg_interpreter ID_EX_reg(ID_EX_data);

//ID data flow
always@(posedge clk)begin
    if(!resetn)begin
        ID_EX_valid<=1'b0;
        ID_EX_MEM_addr_reg<=32'b0;
        ID_EX_data<=220'b0;
    end
    else if(ID_EX_allowin)begin
        ID_EX_valid<=ID_EX_valid_in;
    end
    if(ID_EX_valid_in&&ID_EX_allowin)begin
        ID_EX_data<=(bubble?`bubble:ID_EX_datain);
        ID_EX_MEM_addr_reg<=ID_MEM_addr;
    end
    else 
    begin
        if(!div_stall)begin
            ID_EX_data<=`bubble;
            ID_EX_MEM_addr_reg<=32'b0;
        end
    end
end

//stage EX--------------------------------------
//EX control
reg EX_MEM_valid;//data in this stage is valid
reg [219:0]EX_MEM_data;
wire [219:0]EX_MEM_datain=ID_EX_data;   
wire EX_MEM_valid_in;//input wire: data from last stage is valid
wire EX_MEM_allowin;//data can get in this stage
wire EX_MEM_readygo;//data can get out of this stage
wire EX_MEM_valid_out;//output wire: data from this stage is valid
wire EX_MEM_allowout;//data is getting out of this stage

assign EX_MEM_valid_in=ID_EX_valid_out;
assign EX_MEM_readygo=1;//data can flow out of this stage
//TODO: mul and div
assign EX_MEM_allowin=(EX_MEM_readygo&&MEM_WB_allowin||!EX_MEM_valid)&(!div_stall);//Added control logic in 10.7
// assign EX_MEM_allowin=(EX_MEM_readygo&&MEM_WB_allowin||!EX_MEM_valid);
assign EX_MEM_valid_out=EX_MEM_valid&&EX_MEM_readygo;
assign EX_MEM_allowout=EX_MEM_readygo&&EX_MEM_allowin;

//ALU
    assign A=ID_EX_reg.A_data;
    assign B=ID_EX_reg.B_data;
    assign ALUop=ID_EX_reg.aluop;
    // Overflow,
    // CarryOut,
    // Zero,

//EX data
reg [31:0] EX_result;

//EX memory interaction
assign data_sram_addr=ID_EX_MEM_addr_reg;

wire [31:0]exmux_output;
wire [3:0]strb;

//Used for generating data really used for sxx insts.
wbmux exmux(
    ID_EX_reg.reg_write_src,
    ID_EX_reg.mem_wen_pick,
    ID_EX_reg.B_data,//from reg
    ID_EX_reg.inst,//from ins
    data_sram_rdata,//from mem
    data_sram_addr[1:0],
    ID_EX_reg.PC,
    HI,
    LO,
    EX_result,
    exmux_output,
    strb
);

assign data_sram_wdata=exmux_output;
assign data_sram_wen=strb&{4{ID_EX_reg.mem_wen_pick!=0}};

//EX_MEM data
reg [31:0] EX_MEM_MEM_addr_reg;

pipe_reg_interpreter EX_MEM_reg(EX_MEM_data);

//EX data flow
always@(posedge clk)begin
    if(!resetn)begin
        EX_MEM_valid<=1'b0;
        EX_result<=32'b0;
        EX_MEM_MEM_addr_reg<=32'b0;
        EX_MEM_data<=220'b0;
    end
    else if(EX_MEM_allowin)begin
        EX_MEM_valid<=EX_MEM_valid_in;
    end
    if(EX_MEM_valid_in&&EX_MEM_allowin)begin
        EX_MEM_data<=EX_MEM_datain;
        // EX_result<=Result;
        EX_result<=ID_EX_reg.reg_write_src[1]?(ID_EX_reg.PC+32'd8):Result;
        EX_MEM_MEM_addr_reg<=ID_EX_MEM_addr_reg;
    end
end

//EX: mul and div
//MUL
wire [63:0]mulout;
multipler multipler
(
    clk, // 乘法器模块时钟信�?
    resetn, // 夝佝信坷，低电平有效
    ID_EX_reg.mul_control[0], // 控制有符坷乘法和无符坷乘�?
    ID_EX_reg.A_data, // 被乘�?
    ID_EX_reg.B_data, // 乘数
    mulout   //乘法结果，高 32 写入 HI，低 32 佝写入LO
);

//DIV
wire [63:0]divout;
wire div_complete;
divider divider
(
    clk, //除法器模块时钟信�?
    resetn, //夝佝信坷，低电平有效
    ID_EX_reg.mul_control[2]|ID_EX_reg.mul_control[3], //除法违算命令，在除法完戝坎，如果外界没有新的除法进入，必须将该信坷置�? 0
    ID_EX_reg.mul_control[2], //控制有符坷除法和无符坷除法的信坷
    ID_EX_reg.A_data, //被除�?
    ID_EX_reg.B_data, //除数
    divout[31:0], //除法结果，商
    divout[63:32], //除法结果，余�?
    div_complete //除法完戝信坷，除法内�? count 计算达到33
);



//stage MEM----------------------------------------

//MEM control
reg MEM_WB_valid;//data in this stage is valid
reg [219:0]MEM_WB_data;
wire [219:0]MEM_WB_datain;
wire WB_allowin;
wire MEM_WB_valid_in;//input wire: data from last stage is valid
wire MEM_WB_allowin;//data can get in this stage
wire MEM_WB_readygo;//data can get out of this stage
wire MEM_WB_valid_out;//output wire: data from this stage is valid
wire MEM_WB_allowout;//data is getting out of this stage

assign MEM_WB_valid_in=EX_MEM_valid_out;
assign MEM_WB_readygo=1;//data can flow out of this stage
assign MEM_WB_allowin=MEM_WB_readygo&&WB_allowin||!MEM_WB_valid;
assign MEM_WB_valid_out=MEM_WB_valid&&MEM_WB_readygo;
assign MEM_WB_allowout=MEM_WB_readygo&&MEM_WB_allowin;
assign MEM_WB_datain=EX_MEM_data;

//MEM data
wire [31:0]MEM_result_in;
wire [3:0]useless_strb;
wire [31:0]memmux_output;

//TODO

wbmux memmux(
    EX_MEM_reg.reg_write_src,
    EX_MEM_reg.mem_wen_pick,
    EX_MEM_reg.B_data,//from reg
    EX_MEM_reg.inst,//from ins
    data_sram_rdata,//from mem
    EX_MEM_MEM_addr_reg[1:0],
    EX_MEM_reg.PC,
    HI,
    LO,
    EX_result,
    memmux_output,
    useless_strb
);

assign MEM_result_in=memmux_output;

//MEM_WB data
pipe_reg_interpreter MEM_WB_reg(MEM_WB_data);
reg [31:0]MEM_result;
reg [3:0]WB_reg_control;

//MEM data flow
always@(posedge clk)begin
    if(!resetn)begin
        MEM_WB_valid<=1'b0;
        WB_reg_control<=4'b0;
        MEM_result<=31'b0;
        MEM_WB_data<=220'b0;
    end
    else if(MEM_WB_allowin)begin
        MEM_WB_valid<=MEM_WB_valid_in;
    end
    if(MEM_WB_valid_in&&MEM_WB_allowin)begin
        if(!div_stall)begin
            MEM_WB_data<=MEM_WB_datain;
            MEM_result<=MEM_result_in;
            WB_reg_control<={4{EX_MEM_reg.reg_write}};
        end
        else begin
            MEM_WB_data<=220'b0;
            MEM_result<=32'b0;
            WB_reg_control<=4'b0;
        end
    end 
    //WB need only 1 clk cycle, insert a bubble if the next ins does not come.
    else
    begin
        MEM_WB_data<=220'b0;
        MEM_result<=32'b0;
        WB_reg_control<=4'b0;
    end
end

//MEM: mul and div
//MUL and DIV will return their result here.
//If they DIV need to stall pipeline, it will stall pipeline here.
//Thus there will not be DIV, MUL structure corelation.

always@(posedge clk)begin
    mul_result<=mulout;
end

always@(posedge clk)begin
    if(!resetn)begin
        div_result<=64'b0;
    end
    else begin
        if(div_complete)
            div_result<=divout;
    end
end

wire div_stall=(EX_MEM_reg.mul_control[2]|EX_MEM_reg.mul_control[3])&(!div_complete);

//stage WB-----------------------------------
assign WB_allowin=1;
assign regfile_waddr=MEM_WB_reg.regfile_waddr;

// All operations about hi/lo gathered here, so that corelation can be avoided;
wire mthi_w=MEM_WB_reg.reg_write_tgt[1]; //--> write hi TODO
wire mtlo_w=MEM_WB_reg.reg_write_tgt[2]; //--> write lo TODO
wire mfhi_w=MEM_WB_reg.reg_write_src[3];
wire mflo_w=MEM_WB_reg.reg_write_src[4];

// mul_control shows if mul/div happened
wire mul_w = MEM_WB_reg.mul_control[0]|MEM_WB_reg.mul_control[1];
wire div_w = MEM_WB_reg.mul_control[2]|MEM_WB_reg.mul_control[3];

// HI/LO control
always@(posedge clk)begin
    if(!resetn)begin
        HI<=32'b0;
    end
    else begin
        HI<=
            {32{mthi_w}}&MEM_WB_reg.A_data|
            {32{mul_w}}&mul_result[63:32]|
            {32{div_w}}&div_result[63:32]|
            {32{!(div_w|mul_w|mthi_w)}}&HI;
    end
end

always@(posedge clk)begin
    if(!resetn)begin
        LO<=32'b0;
    end
    else begin
        LO<=
            {32{mtlo_w}}&MEM_WB_reg.A_data|
            {32{mul_w}}&mul_result[31:0]|
            {32{div_w}}&div_result[31:0]|
            {32{!(div_w|mul_w|mtlo_w)}}&LO;
    end
end


//TODO: regfile_wen now is only 1 bit!!! 
assign regfile_wen=WB_reg_control&{4{MEM_WB_valid}};
assign regfile_wdata=
    {32{mfhi_w}}&HI|
    {32{mflo_w}}&LO|
    {32{!(mfhi_w|mflo_w)}}&MEM_result;

//debug interface

assign debug_wb_pc=MEM_WB_reg.PC;
assign debug_wb_rf_wen={4{regfile_wen}};
assign debug_wb_rf_wnum=regfile_waddr;
assign debug_wb_rf_wdata=regfile_wdata;


//-------------------------------------------
//Bypass Logic
//-------------------------------------------

// assign regfile_raddr1=ID_rs; --> A
// assign regfile_raddr2=ID_rt; --> B

wire jump_with_reg=
    (ID_inst_in[31:26]==6'b000100)|
    ((ID_inst_in[31:26]==6'b000001)&(ID_inst_in[20:16]==5'b00001))|
    ((ID_inst_in[31:26]==6'b000110)&(ID_inst_in[20:16]==5'b00000))|
    ((ID_inst_in[31:26]==6'b000001)&(ID_inst_in[20:16]==5'b00000))|
    (ID_inst_in[31:26]==6'b000101)|
    ((ID_inst_in[31:26]==6'b000000)&(ID_inst_in[5:0]==6'b001001))|
    ((ID_inst_in[31:26]==6'b000000)&(ID_inst_in[5:0]==6'b001000))
    ;

wire corelation_A1=ID_control_signal.reg_a_valid&(ID_rs!=0)&(ID_rs==ID_EX_reg.regfile_waddr)&ID_EX_reg.reg_write;
wire corelation_A2=ID_control_signal.reg_a_valid&(ID_rs!=0)&(ID_rs==EX_MEM_reg.regfile_waddr)&EX_MEM_reg.reg_write;
wire corelation_A3=ID_control_signal.reg_a_valid&(ID_rs!=0)&(ID_rs==MEM_WB_reg.regfile_waddr)&MEM_WB_reg.reg_write;
wire corelation_B1=ID_control_signal.reg_b_valid&(ID_rt!=0)&(ID_rt==ID_EX_reg.regfile_waddr)&ID_EX_reg.reg_write;
wire corelation_B2=ID_control_signal.reg_b_valid&(ID_rt!=0)&(ID_rt==EX_MEM_reg.regfile_waddr)&EX_MEM_reg.reg_write;
wire corelation_B3=ID_control_signal.reg_b_valid&(ID_rt!=0)&(ID_rt==MEM_WB_reg.regfile_waddr)&MEM_WB_reg.reg_write;


wire bypass_A1=corelation_A1&(!ID_EX_reg.mem_read)&(ID_EX_reg.reg_write_src[0])&(!jump_with_reg);
wire bypass_A2=corelation_A2&(!EX_MEM_reg.reg_write_src[3])&(!EX_MEM_reg.reg_write_src[4])&(!(jump_with_reg&EX_MEM_reg.mem_read));
wire bypass_A3=corelation_A3;
wire bypass_B1=corelation_B1&(!ID_EX_reg.mem_read)&(ID_EX_reg.reg_write_src[0])&(!jump_with_reg);
wire bypass_B2=corelation_B2&(!EX_MEM_reg.reg_write_src[3])&(!EX_MEM_reg.reg_write_src[4])&(!(jump_with_reg&EX_MEM_reg.mem_read));
wire bypass_B3=corelation_B3;

wire bypass_A1=corelation_A1&(!ID_EX_reg.mem_read)&(ID_EX_reg.reg_write_src[0])&(!jump_with_reg);
wire bypass_A2=corelation_A2&(!EX_MEM_reg.reg_write_src[3])&(!EX_MEM_reg.reg_write_src[4])&(!(jump_with_reg&EX_MEM_reg.mem_read));
wire bypass_A3=corelation_A3;
wire bypass_B1=corelation_B1&(!ID_EX_reg.mem_read)&(ID_EX_reg.reg_write_src[0])&(!jump_with_reg);
wire bypass_B2=corelation_B2&(!EX_MEM_reg.reg_write_src[3])&(!EX_MEM_reg.reg_write_src[4])&(!(jump_with_reg&EX_MEM_reg.mem_read));
wire bypass_B3=corelation_B3;

wire [31:0] bypassed_regfile_rdata1=(bypass_A1?Result:
    (bypass_A2?(EX_MEM_reg.mem_read?MEM_result_in:EX_result):
    (bypass_A3?
        (
        {32{mflo_w}}&LO| 
        {32{mfhi_w}}&HI| 
        {32{~(mfhi_w|mflo_w)}}&MEM_result):
    regfile_rdata1
    )));
wire [31:0] bypassed_regfile_rdata2=(bypass_B1?Result:
    (bypass_B2?(EX_MEM_reg.mem_read?MEM_result_in:EX_result):
    (bypass_B3?
    (
        {32{mflo_w}}&LO| 
        {32{mfhi_w}}&HI| 
        {32{~(mfhi_w|mflo_w)}}&MEM_result):
    regfile_rdata2
    )));

//TODO : add bypass

//alu_a_src--------------------------
// `define alu_a_src_a 1'b0;
// `define alu_a_src_sa 1'b1;
assign A_data=ID_control_signal.alu_a_src?
    {26'b0,ID_inst_in[10:6]}:
    bypassed_regfile_rdata1;

//alu_b_src--------------------------
// `define alu_b_src_immsigned 4'b0001;
// `define alu_b_src_a_immunsigned 4'b0010;
// `define alu_b_src_PC_8 4'b0100;
// `define alu_b_src_reg 4'b1000;
assign B_data=
{32{ID_control_signal.alu_b_src[0]}}&ImmSignedExt|
{32{ID_control_signal.alu_b_src[1]}}&ImmUnsignedExt|
{32{ID_control_signal.alu_b_src[2]}}&(IF_ID_PC_reg+8)|//TODO: maybe it will be a problem
{32{ID_control_signal.alu_b_src[3]}}&bypassed_regfile_rdata2;

// assign bubble = 0;

assign bubble=
    corelation_A1&(~bypass_A1)|
    corelation_A2&(~bypass_A2)|
    corelation_A3&(~bypass_A3)|
    corelation_B1&(~bypass_B1)|
    corelation_B2&(~bypass_B2)|
    corelation_B3&(~bypass_B3);


    

//Reserved
//---------------------------------

endmodule