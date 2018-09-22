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

//pipeline design

//stage IF
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
reg [31:0] IF_PC_reg;

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
        IF_PC_reg<=(IF_ID_allowout&&(IF_FSM_current_stage==`IF_STAGE_1)?
            IF_PC_in:
            IF_PC_reg;
    end
end


endmodule