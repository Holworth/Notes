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

    assign inst_sram_en=1;
    assign inst_sram_wen=0;
    assign inst_sram_wdata=0;

    assign data_sram_en=1;
    assign data_sram_wen={4{cpu_core.MemWrite}}&cpu_core.Write_strb;

    assign debug_wb_pc=cpu_core.PColdReg;
    assign debug_wb_rf_wen={4{cpu_core.REGwrite}};
    assign debug_wb_rf_wnum=cpu_core.REGwriteaddr;
    assign debug_wb_rf_wdata=cpu_core.REGwritedata;

mips_cpu cpu_core(
    .rst(~resetn),
    .clk(clk),

    //Instruction request channel
    .PC(inst_sram_addr),
    // .PColdReg(debug_wb_pc),

    // output Inst_Req_Valid,//
    .Inst_Req_Ack(1),//

    //Instruction response channel
    .Instruction(inst_sram_rdata),
    .Inst_Valid(1),//
    // .Inst_Ack(),//

    //Memory request channel
    .Address(data_sram_addr),
    // .MemWrite(),TODO
    .Write_data(data_sram_wdata),
    // .Write_strb(),TODO
    // .MemRead(),
    .Mem_Req_Ack(1),//

    //Memory data response channel
    .Read_data(data_sram_rdata),
    .Read_data_Valid(1)//
    // Read_data_Ack,//

);

endmodule