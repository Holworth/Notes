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

// assign data_sram_wen=MEM_write;//TODO
//......

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

//alu
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

//TODO

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

//d flipflop of IF_PC
always@(posedge clk)begin
    if(!reset)
        IF_ID_PC_reg<=0;
    end
    else begin
        IF_ID_PC_reg<=(IF_ID_allowout?IF_PC_reg:IF_ID_PC_reg);
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
    else if(IF_ID_valid_in&&IF_ID_allowin)begin
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
wire [31:0]LongJmp={PCReg[31:28],ID_inst_in[25:0],2'b00};

//Additional Data Reg in ID/EX

reg [31:0]Offset00Ext_reg;
reg [31:0]ImmUnsignedExt_reg;
reg [31:0]ImmSignedExt_reg;
reg [31:0]LongJmp_reg;
reg [31:0]LastPC_4;

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

always@(posedge clk)begin
    if(!resetn)begin
        LastPC_4<=32'b0;
    end
    else if(PC_write)
        LastPC_4<=PC_4;
    end
end


//Jump address calc in ID
wire [31:0]jaddr_c;
wire [31:0]jaddr_ac;
wire jump_short;
wire jump_long;
wire jump_ac;


//ID_EX data
pipe_reg ID_EX_reg();

//ID data flow
always@(posedge clk)begin
    if(!resetn)begin
        ID_EX_valid<=1'b0;
    end
    else if(ID_EX_allowin)begin
        ID_EX_valid<=ID_EX_valid_in;
    end
    else if(ID_EX_valid_in&&ID_EX_allowin)begin
        ID_EX_data<=ID_EX_datain;
    end
end

//stage EX--------------------------------------
//EX control
reg EX_MEM_valid;//data in this stage is valid
reg EX_MEM_data;//TODO
wire EX_MEM_valid_in;//input wire: data from last stage is valid
wire EX_MEM_allowin;//data can get in this stage
wire EX_MEM_readygo;//data can get out of this stage
wire EX_MEM_valid_out;//output wire: data from this stage is valid
wire EX_MEM_allowout;//data is getting out of this stage

assign EX_MEM_readygo=TODO;//data can flow out of this stage
assign EX_MEM_allowin=EX_MEM_readygo&&EX_MEM_allowin||!EX_MEM_valid;
assign EX_MEM_valid_out=EX_MEM_valid&&EX_MEM_readygo;
assign EX_MEM_allowout=EX_MEM_readygo&&EX_MEM_allowin;

//EX data

//EX_MEM data
pipe_reg EX_MEM_reg();

//EX data flow
always@(posedge clk)begin
    if(!resetn)begin
        EX_MEM_valid<=1'b0;
    end
    else if(EX_MEM_allowin)begin
        EX_MEM_valid<=EX_MEM_valid_in;
    end
    else if(EX_MEM_valid_in&&EX_MEM_allowin)begin
        EX_MEM_data<=EX_MEM_datain;
    end
end

//stage MEM----------------------------------------
//MEM control
reg MEM_WB_valid;//data in this stage is valid
reg MEM_WB_data;//TODO
wire MEM_WB_valid_in;//input wire: data from last stage is valid
wire MEM_WB_allowin;//data can get in this stage
wire MEM_WB_readygo;//data can get out of this stage
wire MEM_WB_valid_out;//output wire: data from this stage is valid
wire MEM_WB_allowout;//data is getting out of this stage

assign MEM_WB_readygo=TODO;//data can flow out of this stage
assign MEM_WB_allowin=MEM_WB_readygo&&MEM_WB_allowin||!MEM_WB_valid;
assign MEM_WB_valid_out=MEM_WB_valid&&MEM_WB_readygo;
assign MEM_WB_allowout=MEM_WB_readygo&&MEM_WB_allowin;

//MEM data

//MEM_WB data
pipe_reg MEM_WB_reg();

//MEM data flow
always@(posedge clk)begin
    if(!resetn)begin
        MEM_WB_valid<=1'b0;
    end
    else if(MEM_WB_allowin)begin
        MEM_WB_valid<=MEM_WB_valid_in;
    end
    else if(MEM_WB_valid_in&&MEM_WB_allowin)begin
        MEM_WB_data<=MEM_WB_datain;
    end
end

//stage WB-----------------------------------

//Reserved
//---------------------------------

endmodule