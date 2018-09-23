//A 5-level pipelined MIPs32 CPU 
//Huaqiang Wang (c) 2018
//top.v

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

assign inst_sram_en=1'b1;
assign inst_sram_wen=4'b0000;
assign inst_sram_addr=IF_PC_reg;
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

//ALU
//---------------------------------

    wire [31:0] A,
    wire [31:0] B,
    wire [15:0] ALUop,
    wire Overflow,
    wire CarryOut,
    wire Zero,
    wire reg [31:0] Result

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

//stage IF-----------------------------
//IF control
reg IF_ID_valid;//data in this stage is valid
reg IF_ID_data;//TODO
wire IF_ID_valid_in;//input wire: data from last stage is valid
wire IF_ID_allowin;//data can get in this stage
wire IF_ID_readygo;//data can get out of this stage
wire IF_ID_valid_out;//output wire: data from this stage is valid
wire IF_ID_allowout;//data is getting out of this stage

assign IF_ID_readygo=IF_stage==`IF_STAGE_1;//data can flow out of this stage
assign IF_ID_allowin=IF_ID_readygo&&ID_EX_allowin||!IF_ID_valid;
assign IF_ID_valid_out=IF_ID_valid&&IF_ID_readygo;
assign IF_ID_allowout=IF_ID_readygo&&ID_EX_allowin;

//IF data
wire [31:0] IF_PC_in;
wire [31:0] IF_inst_in;
reg [31:0] IF_PC_reg;

//Wires used for PC jumping
wire PC_new;
wire jump;
wire PC_4;
assign PC_4=IF_PC_reg+4;

assign IF_inst_in=inst_sram_rdata;

//IF_ID data
reg [31:0] IF_ID_inst_reg;
reg [31:0] IF_ID_PC_reg;
reg [31:0] IF_ID_PC4_reg;

//Jump control
wire jump_short;
wire jump_long;
wire jump_alu;
wire jump_nop;

wire [31:0]PC_jump_short;
wire [31:0]PC_jump_long;
wire [31:0]PC_jump_alu;

assign jump_nop=~(jump_short|jump_long|jump_alu);

assign IF_PC_in=
    {32{jump_short}&PC_jump_short}|
    {32{jump_long}&PC_jump_long}|
    {32{jump_alu}&PC_jump_alu}|
    {32{jump_short}&PC_4};

//TODO : 整理代码

//d flipflop of IF_PC_reg
always@(posedge clk)begin
    if(!reset)begin
        IF_PC_reg<=32'hbfc00000;
    end
    else begin
        IF_PC_reg<=(IF_ID_allowout?IF_PC_in:IF_PC_reg);
    end
end

//d flipflop of IF_ID_PC_reg
always@(posedge clk)begin
    if(!reset)begin
        IF_ID_PC_reg<=0;
        IF_ID_PC4_reg<=0;
    end
    else begin
        IF_ID_PC_reg<=(IF_ID_allowout?IF_PC_reg:IF_ID_PC_reg);
        IF_ID_PC4_reg<=(IF_ID_allowout?PC_4:IF_ID_PC4_reg);
    end
end

//d flipflop of IF_inst
always@(posedge clk)begin
    if(!reset)
        IF_ID_inst_reg<=0;
    end
    else begin
        IF_ID_inst_reg<=(IF_ID_allowout?IF_inst_in:IF_ID_inst_reg);
    end
end

//IF data flow
always@(posedge clk)begin
    if(!resetn)begin
        IF_ID_valid<=1'b0;
    end
    else if(IF_ID_allowin)begin
        IF_ID_valid<=IF_ID_valid_in;
    end
    if(IF_ID_valid_in&&IF_ID_allowin)begin
        IF_ID_data<=IF_ID_datain;
    end
end

//IF FSM
//The stage is used to control the 2 clock cycle of reading instruction memory
reg IF_FSM_current_stage;

assign IF_FSM_next_stage=(IF_FSM_current_stage==`IF_STAGE_0)?
    (`IF_STAGE_1):
    (IF_ID_allowout?`IF_STAGE_0:`IF_STAGE_1);

always@(posedge clk)begin
    if(!resetn)begin
        IF_FSM_current_stage<=0;
    end
    else begin
        IF_FSM_current_stage<=IF_FSM_next_stage;
    end
end

//a data flip-flop with resetn
always@(posedge clk)begin
    if(!resetn)begin
        IF_PC_reg<=32'hbfc00000;
    end
    else begin
        // case(IF_FSM_current_stage)
        // `IF_STAGE_0:
        // begin
        //     IF_PC_reg<=IF_PC_reg;
        // end
        // `IF_STAGE_1:
        // begin
        //     if(IF_ID_allowout)begin
        //         IF_PC_reg<=IF_PC_in;
        //     else
        //         IF_PC_reg<=IF_PC_reg;
        //     end
        // end
        // default:
        // begin
        //     IF_PC_reg<=IF_PC_reg;
        // end
        // endcase
        IF_PC_reg<=(IF_ID_allowout)?
            IF_PC_in:
            IF_PC_reg;
    end
end


//stage ID----------------------------
//ID control
reg ID_EX_valid;//data in this stage is valid
reg ID_EX_data;//TODO
wire ID_EX_valid_in;//input wire: data from last stage is valid
wire ID_EX_allowin;//data can get in this stage
wire ID_EX_readygo;//data can get out of this stage
wire ID_EX_valid_out;//output wire: data from this stage is valid
wire ID_EX_allowout;//data is getting out of this stage

assign ID_EX_readygo=TODO;//data can flow out of this stage
//decode need only 1 clock cycle, yet 
assign ID_EX_allowin=ID_EX_readygo&&ID_EX_allowin||!ID_EX_valid;
assign ID_EX_valid_out=ID_EX_valid&&ID_EX_readygo;
assign ID_EX_allowout=ID_EX_readygo&&ID_EX_allowin;

//ID data
wire [31:0] ID_inst_in;
assign ID_inst_in=IF_ID_inst_reg;

//ID speical wire:

//Additional Data Wire in ID

wire [31:0]Offset00Ext={ID_inst_in[15]?14'b11_1111_1111_1111:14'b0,ID_inst_in[15:0],2'b00};
wire [31:0]ImmUnsignedExt={16'b0,ID_inst_in[15:0]};
wire [31:0]ImmSignedExt={ID_inst_in[15]?16'hffff:16'b0,ID_inst_in[15:0]};
wire [31:0]LongJmp={IF_PC_reg[31:28],ID_inst_in[25:0],2'b00};

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


//Jump address calc in ID
wire [31:0]jaddr_c;
wire [31:0]jaddr_ac;
wire jump_short;
wire jump_long;
wire jump_ac;

assign PC_jump_short=IF_PC_reg+Offset00Ext;
assign PC_jump_long=LongJmp;
assign PC_jump_alu=A_data;

//Link reg read logic here

wire ID_rs=IF_ID_inst_reg[25:21];
wire ID_rt=IF_ID_inst_reg[20:16];
wire ID_rd=IF_ID_inst_reg[15:11];

regfile_raddr1=ID_rs;
regfile_raddr2=ID_rt;

wire [31:0]A_data=regfile_rdata1;
wire [31:0]B_data=regfile_rdata2;

//ID Decode Logic
//Control and ALUcontrol

wire ID_control_jump_short;//1
wire ID_control_jump_long;//1
wire ID_control_alu_b_src;//4
wire ID_control_aluop;//16
wire ID_control_mem_wen_pick;//5
wire ID_control_reg_a_valid;//1
wire ID_control_reg_b_valid;//1
wire ID_control_mem_read;//1
wire ID_control_reg_write;//1
wire ID_control_reg_write_src;//16
wire ID_control_reg_write_tgt;//6
wire ID_control_r_type;/1
wire ID_alucontrol_aluop;//16
wire ID_alucontrol_mul_control;//4
wire ID_alucontrol_reg_write;//5
wire ID_alucontrol_reg_write_src;//5
wire ID_alucontrol_reg_write_tgt;//4
wire ID_alucontrol_jmp;//1
wire ID_alucontrol_alu_a_src;//1
wire ID_alucontrol_reg_a_valid;
wire ID_alucontrol_reg_b_valid;

control control(
    IF_ID_inst_reg,
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
    IF_ID_inst_reg,
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

wire [217:0]ID_data_gen=
    {
        IF_ID_inst_reg,
        A_data,
        B_data,
        control_data,
        alucontrol_data,
        IF_ID_PC_reg
    };


pipe_reg_interpreter ID_control_signal(ID_data_gen);

assign jump_short=ID_control_signal.jump_short;
assign jump_long=ID_control_signal.jump_long;
assign jump_alu=ID_control_signal.jump_alu;

assign ID_EX_datain=ID_data_gen;

//MEM addr calc

wire [31:0]ID_MEM_addr;
assign ID_MEM_addr=A_data+ImmSignedExt;

//ID_EX data
reg [217:0] ID_EX_data;
reg [31:0] ID_EX_MEM_addr_reg;
pipe_reg_interpreter ID_EX_reg(ID_EX_data);

//ID data flow
always@(posedge clk)begin
    if(!resetn)begin
        ID_EX_valid<=1'b0;
        ID_MEM_addr_reg<=32'b0;
    end
    else if(ID_EX_allowin)begin
        ID_EX_valid<=ID_EX_valid_in;
    end
    if(ID_EX_valid_in&&ID_EX_allowin)begin
        ID_EX_data<=ID_EX_datain;
        ID_EX_MEM_addr_reg<=ID_MEM_addr;
    end
end

//stage EX--------------------------------------
//EX control
reg EX_MEM_valid;//data in this stage is valid
reg [217:0]EX_MEM_data;
wire [217:0]EX_MEM_data_in=ID_EX_data;
wire EX_MEM_valid_in;//input wire: data from last stage is valid
wire EX_MEM_allowin;//data can get in this stage
wire EX_MEM_readygo;//data can get out of this stage
wire EX_MEM_valid_out;//output wire: data from this stage is valid
wire EX_MEM_allowout;//data is getting out of this stage

assign EX_MEM_readygo=TODO;//data can flow out of this stage
assign EX_MEM_allowin=EX_MEM_readygo&&EX_MEM_allowin||!EX_MEM_valid;
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

//EX_MEM data
reg [217:0] EX_MEM_data;
reg [31:0] EX_MEM_MEM_addr_reg;

pipe_reg_interpreter EX_MEM_reg(EX_MEM_data);

//EX data flow
always@(posedge clk)begin
    if(!resetn)begin
        EX_MEM_valid<=1'b0;
        EX_result<=32'b0;
        EX_MEM_MEM_addr_reg<=32'b0;
    end
    else if(EX_MEM_allowin)begin
        EX_MEM_valid<=EX_MEM_valid_in;
    end
    if(EX_MEM_valid_in&&EX_MEM_allowin)begin
        EX_MEM_data<=EX_MEM_datain;
        EX_result<=Result;
        EX_MEM_MEM_addr_reg<=ID_EX_MEM_addr_reg;
    end
end

//stage MEM----------------------------------------
//MEM control
reg MEM_WB_valid;//data in this stage is valid
reg [217:0]MEM_WB_data;
wire [217:0]MEM_WB_datain;
wire MEM_WB_valid_in;//input wire: data from last stage is valid
wire MEM_WB_allowin;//data can get in this stage
wire MEM_WB_readygo;//data can get out of this stage
wire MEM_WB_valid_out;//output wire: data from this stage is valid
wire MEM_WB_allowout;//data is getting out of this stage

assign MEM_WB_readygo=TODO;//data can flow out of this stage
assign MEM_WB_allowin=MEM_WB_readygo&&MEM_WB_allowin||!MEM_WB_valid;
assign MEM_WB_valid_out=MEM_WB_valid&&MEM_WB_readygo;
assign MEM_WB_allowout=MEM_WB_readygo&&MEM_WB_allowin;
assign MEM_WB_datain=EX_MEM_data;

//MEM data
//MEM sockets:
    wire [31:0]MEM_addr;
    assign data_sram_addr=EX_MEM_MEM_addr_reg;//TODO
    // data_sram_wen controlled by fsm
    //EX_MEM_reg.B_data
    SMUX(EX_MEM_reg.B_data);//TODO
    LMUX(data_sram_rdata);//TODO
    assign data_sram_wdata=SMUX_result;//TODO

//MEM_WB data
pipe_reg_interpreter MEM_WB_reg(MEM_WB_data);
reg [31:0]MEM_result;

//MEM data flow
always@(posedge clk)begin
    if(!resetn)begin
        MEM_WB_valid<=1'b0;
    end
    else if(MEM_WB_allowin)begin
        MEM_WB_valid<=MEM_WB_valid_in;
    end
    if(MEM_WB_valid_in&&MEM_WB_allowin)begin
        MEM_WB_data<=MEM_WB_datain;
    end
end

//stage WB-----------------------------------

//TODO: Link debug wires
//debug interface
    output  [31:0]   debug_wb_pc,
    output  [3 :0]   debug_wb_rf_wen,
    output  [4 :0]   debug_wb_rf_wnum,
    output  [31:0]   debug_wb_rf_wdata

//Reserved
//---------------------------------

endmodule