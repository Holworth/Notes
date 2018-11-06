/*------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Copyright (c) 2016, Loongson Technology Corporation Limited.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this 
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of Loongson Technology Corporation Limited nor the names of 
its contributors may be used to endorse or promote products derived from this 
software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL LOONGSON TECHNOLOGY CORPORATION LIMITED BE LIABLE
TO ANY PARTY FOR DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
`timescale 1ns / 1ps

`define TRACE_REF_FILE "../../../../../../golden_trace.txt"
`define CONFREG_NUM_REG      soc_lite.confreg.num_data
`define CONFREG_OPEN_TRACE   soc_lite.confreg.open_trace
`define CONFREG_NUM_MONITOR  soc_lite.confreg.num_monitor
`define CONFREG_UART_DISPLAY soc_lite.confreg.write_uart_valid
`define CONFREG_UART_DATA    soc_lite.confreg.write_uart_data
`define END_PC 32'hbfc00100

module tb_top( );
reg resetn;
reg clk;

//goio
wire [15:0] led;
wire [1 :0] led_rg0;
wire [1 :0] led_rg1;
wire [7 :0] num_csn;
wire [6 :0] num_a_g;
wire [7 :0] switch;
wire [3 :0] btn_key_col;
wire [3 :0] btn_key_row;
wire [1 :0] btn_step;
assign switch      = 8'd0;
assign btn_key_row = 4'd0;
assign btn_step    = 2'd3;

initial
begin
    clk = 1'b0;
    resetn = 1'b0;
    #5000;
    resetn = 1'b1;
    #4000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
        #4000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
        #4000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
        #4000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
        #4000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #4000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0040;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0001;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0002;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
    #5000;
    force soc_lite.confreg.btn_key_data[15:0] = 16'h0004;
    #5000;
    release soc_lite.confreg.btn_key_data[15:0];
end
always #5 clk=~clk;
soc_lite_top #(.SIMULATION(1'b1)) soc_lite
(
       .resetn      (resetn     ), 
       .clk         (clk        ),
    
        //------gpio-------
        .num_csn    (num_csn    ),
        .num_a_g    (num_a_g    ),
        .led        (led        ),
        .led_rg0    (led_rg0    ),
        .led_rg1    (led_rg1    ),
        .switch     (switch     ),
        .btn_key_col(btn_key_col),
        .btn_key_row(btn_key_row),
        .btn_step   (btn_step   )
    );   

//soc lite signals
//"soc_clk" means clk in cpu
//"wb" means write-back stage in pipeline
//"rf" means regfiles in cpu
//"w" in "wen/wnum/wdata" means writing
wire soc_clk;
wire [31:0] debug_wb_pc;
wire [3 :0] debug_wb_rf_wen;
wire [4 :0] debug_wb_rf_wnum;
wire [31:0] debug_wb_rf_wdata;
assign soc_clk           = soc_lite.cpu_clk;
assign debug_wb_pc       = soc_lite.debug_wb_pc;
assign debug_wb_rf_wen   = soc_lite.debug_wb_rf_wen;
assign debug_wb_rf_wnum  = soc_lite.debug_wb_rf_wnum;
assign debug_wb_rf_wdata = soc_lite.debug_wb_rf_wdata;

//wdata[i*8+7 : i*8] is valid, only wehile wen[i] is valid
wire [31:0] debug_wb_rf_wdata_v;
assign debug_wb_rf_wdata_v[31:24] = debug_wb_rf_wdata[31:24] & {8{debug_wb_rf_wen[3]}};
assign debug_wb_rf_wdata_v[23:16] = debug_wb_rf_wdata[23:16] & {8{debug_wb_rf_wen[2]}};
assign debug_wb_rf_wdata_v[15: 8] = debug_wb_rf_wdata[15: 8] & {8{debug_wb_rf_wen[1]}};
assign debug_wb_rf_wdata_v[7 : 0] = debug_wb_rf_wdata[7 : 0] & {8{debug_wb_rf_wen[0]}};


endmodule
