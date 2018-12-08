// ----------------------------------------------------------------
//                A 5-level pipelined MIPs32 CPU 
//                      AXI cpu top module
// ----------------------------------------------------------------
//              Copyright (C) 2018 Wang Huaqiang 
//             email : wanghuaqiang16@mails.ucas.ac.cn
// ----------------------------------------------------------------
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
// -----------------------------------------------------------------


module mycpu_top(
    input [5:0] int,   //high active

    input aclk,
    input aresetn,   //low active

    //axi
    //ar
    output [3:0]arid,      
    output [31:0]araddr,    
    output [7:0]arlen,     
    output [2:0]arsize,    
    output [1:0]arburst,   
    output [1:0]arlock,    
    output [1:0]arcache,   
    output [2:0]arprot,    
    output arvalid,   
    input arready,   

    //r            
    input [3:0]rid,       
    input [31:0]rdata,     
    input [1:0]rresp,     
    input rlast,     
    input rvalid,    
    output rready,    

    //aw           
    output [3:0]awid,      
    output [31:0]awaddr,    
    output [7:0]awlen,     
    output [2:0]awsize,    
    output [1:0]awburst,   
    output [1:0]awlock,    
    output [3:0]awcache,   
    output [2:0]awprot,    
    output awvalid,   
    input awready,   

    //w          
    output [3:0]wid,       
    output [31:0]wdata,     
    output [3:0]wstrb,     
    output wlast,     
    output wvalid,    
    input wready,    

    //b              
    input [3:0]bid,       
    input [1:0]bresp,     
    input bvalid,    
    output bready,    

    //debug interface
    output  [31:0] debug_wb_pc,
    output  [3 :0] debug_wb_rf_wen,
    output  [4 :0] debug_wb_rf_wnum,
    output  [31:0] debug_wb_rf_wdata
    );


    // wire           cpu_inst_sram_en;
    // wire  [ 3:0]   cpu_inst_sram_wen;
    // wire  [31:0]   cpu_inst_sram_addr;
    // wire  [31:0]   cpu_inst_sram_wdata;
    // wire  [31:0]   cpu_inst_sram_rdata;

    // wire           cpu_data_sram_en;
    // wire  [ 3:0]   cpu_data_sram_wen;
    // wire  [31:0]   cpu_data_sram_addr;
    // wire  [31:0]   cpu_data_sram_wdata;
    // wire  [31:0]   cpu_data_sram_rdata;

    //inst sram-like 
    wire inst_req;      
    wire inst_wr;       
    wire [1:0]inst_size;     
    wire [31:0]inst_addr;     
    wire [31:0]inst_wdata;    
    wire [31:0]inst_rdata;    
    wire inst_addr_ok;
    wire inst_data_ok;
    
    //data sram-like 
    wire data_req;      
    wire data_wr;       
    wire [1:0]data_size;     
    wire [31:0]data_addr;     
    wire [31:0]data_wdata;    
    wire [31:0]data_rdata;    
    wire data_addr_ok;  
    wire data_data_ok;  

cpu_sram_like cpu(
    aclk,
    aresetn,            //low active

    //inst sram-like 
    inst_req,      
    inst_wr,       
    inst_size,     
    inst_addr,     
    inst_wdata,    
    inst_rdata,    
    inst_addr_ok,
    inst_data_ok,
    
    //data sram-like 
    data_req,      
    data_wr,       
    data_size,     
    data_addr,     
    data_wdata,    
    data_rdata,    
    data_addr_ok,  
    data_data_ok,  

    //debug interface
    debug_wb_pc,
    debug_wb_rf_wen,
    debug_wb_rf_wnum,
    debug_wb_rf_wdata,

    {int,2'b0} //used to=8'b00000000;
);

cpu_axi_interface bridge(
    aclk,
    aresetn,

    //inst sram-like 
    inst_req,      
    inst_wr,       
    inst_size,     
    inst_addr,     
    inst_wdata,    
    inst_rdata,    
    inst_addr_ok,
    inst_data_ok,
    
    //data sram-like 
    data_req,      
    data_wr,       
    data_size,     
    data_addr,     
    data_wdata,    
    data_rdata,    
    data_addr_ok,  
    data_data_ok,  

    //axi
    //ar
    arid,      
    araddr,    
    arlen,     
    arsize,    
    arburst,   
    arlock,    
    arcache,   
    arprot,    
    arvalid,   
    arready,   
    //r              
    rid,       
    rdata,     
    rresp,     
    rlast,     
    rvalid,    
    rready,    
    //aw           
    awid,      
    awaddr,    
    awlen,     
    awsize,    
    awburst,   
    awlock,    
    awcache,   
    awprot,    
    awvalid,   
    awready,   
    //w          
    wid,       
    wdata,     
    wstrb,     
    wlast,     
    wvalid,    
    wready,    
    //b              
    bid,       
    bresp,     
    bvalid,    
    bready    
);

endmodule