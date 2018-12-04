// ----------------------------------------------------------------
//                   sram-like to axi bridge
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

//sram-like to axi bridge
module cpu_axi_interface (
    input clk,
    input resetn,

    //inst sram-like 
    input inst_req,      
    input inst_wr,       
    input [1:0]inst_size,     
    input [31:0]inst_addr,     
    input [31:0]inst_wdata,    
    output reg [31:0]inst_rdata,    
    output reg inst_addr_ok,
    output reg inst_data_ok,
    
    //data sram-like 
    input data_req,      
    input data_wr,       
    input [1:0]data_size,     
    input [31:0]data_addr,     
    input [31:0]data_wdata,    
    output reg [31:0]data_rdata,    
    output reg data_addr_ok,  
    output reg data_data_ok,  

    //axi
    //ar
    output reg [3:0]arid,      
    output reg [31:0]araddr,    
    output [7:0]arlen,     
    output reg [2:0]arsize,    
    output [1:0]arburst,   
    output [1:0]arlock,    
    output [1:0]arcache,   
    output [2:0]arprot,    
    output reg arvalid,   
    input arready,   
    //r              
    input [3:0]rid,       
    input [31:0]rdata,     
    input [1:0]rresp,     
    input rlast,     
    input rvalid,    
    output reg rready,    
    //aw           
    output [3:0]awid,      
    output reg [31:0]awaddr,    
    output [7:0]awlen,     
    output reg [2:0]awsize,    
    output [1:0]awburst,   
    output [1:0]awlock,    
    output [3:0]awcache,   
    output [2:0]awprot,    
    output reg awvalid,   
    input awready,   
    //w          
    output [3:0]wid,       
    output reg [31:0]wdata,     
    output reg [3:0]wstrb,     
    output wlast,     
    output reg wvalid,    
    input wready,    
    //b              
    input [3:0]bid,       
    input [1:0]bresp,     
    input bvalid,    
    output reg bready    
);

//常量定义

assign arlen=8'b0;
assign arburst=2'b01;
assign arlock=2'b0;
assign arcache=4'b0;
assign arprot=3'b0;
assign awid=4'b1;
assign awlen=8'b0;
assign awburst=2'b01;
assign awlock=2'b0;
assign awcache=4'b0;
assign awprot=3'b0;
assign wid=4'b1;
assign wlast=1;

//Data 优先

//SRAM INST---------------------------------
// input inst_req,      
// input inst_wr,       
// input [1:0]inst_size,     
// input [31:0]inst_addr,     
// input [31:0]inst_wdata,    
// output reg [31:0]inst_rdata,    
// output reg inst_addr_ok,
// output reg inst_data_ok,

reg [2:0]sram_inst_state_now;
reg [2:0]sram_inst_state_next;//is wire

wire axi_judge_inst;
// wire axi_read_finished;
wire [31:0]axi_read_data=rdata;
wire axi_data_received=rvalid;
wire axi_data_sent=wready;

`define sram_inst_idle 3'b000
`define sram_inst_busy 3'b001

always@(posedge clk)
begin
    if(!resetn)begin
        sram_inst_state_now<=3'b0;
    end else begin
        sram_inst_state_now<=sram_inst_state_next;
    end
end

always@(*)begin
    case(sram_inst_state_now)
    `sram_inst_idle: 
    begin
        sram_inst_state_next=axi_judge_inst?`sram_inst_busy:`sram_inst_idle;
    end
    `sram_inst_busy: 
    begin
        sram_inst_state_next=axi_judge_inst?`sram_inst_idle:`sram_inst_busy;
    end
    default: 
    begin
        sram_inst_state_next=`sram_inst_idle;
    end
    endcase
end

always@(*)begin
    if(!resetn)begin
        //assign all =0;
        inst_rdata=32'b0;
        inst_addr_ok=1'b0;
        inst_data_ok=1'b0;
    end
    else begin
        case(sram_inst_state_now)
        `sram_inst_idle: 
        begin
            inst_rdata=32'b0;
            inst_addr_ok=axi_judge_inst?1'b1:1'b0;
            inst_data_ok=1'b0;
        end
        `sram_inst_busy: 
        begin
            inst_rdata=axi_data_received?axi_read_data:32'b0;
            inst_addr_ok=1'b0;
            inst_data_ok=axi_data_received;
        end
        default: 
        begin
            inst_rdata=32'b0;
            inst_addr_ok=1'b0;
            inst_data_ok=1'b0;
        end
        endcase
    end
end


//SRAM DATA---------------------------------
// input data_req,      
// input data_wr,       
// input [1:0]data_size,     
// input [31:0]data_addr,     
// input [31:0]data_wdata,    
// output [31:0]data_rdata,    
// output data_addr_ok,  
// output data_data_ok,  

reg [2:0]sram_data_state_now;
reg [2:0]sram_data_state_next;//is wire
reg [3:0]wstrb_reg;
wire axi_judge_dataw;
wire axi_judge_datar;

`define sram_data_idle 3'b000
`define sram_data_read  3'b001
`define sram_data_write 3'b010

always@(posedge clk)
begin
    if(!resetn)begin
        sram_data_state_now<=3'b0;
    end else begin
        sram_data_state_now<=sram_data_state_next;
    end
end

always@(*)begin
    case(sram_data_state_now)
    `sram_data_idle: 
    begin
        sram_data_state_next=axi_judge_dataw?
            `sram_data_write:
            (axi_judge_datar?`sram_data_read:`sram_data_idle);
    end
    `sram_data_read: 
    begin
        sram_data_state_next=axi_data_received?`sram_data_idle:`sram_data_read;
    end
    `sram_data_write: 
    begin
        sram_data_state_next=axi_data_sent?`sram_data_idle:`sram_data_write;
    end
    default: 
    begin
        sram_data_state_next=`sram_data_idle;
    end
    endcase
end

always@(*)begin
    if(!resetn)begin
        //assign all =0;
        data_rdata=32'b0;    
        data_addr_ok=1'b0;
        data_data_ok=1'b0;
    end
    else begin
        case(sram_data_state_now)
        `sram_data_idle: 
        begin
            data_rdata=32'b0;    
            data_addr_ok=axi_judge_dataw|axi_judge_datar;
            data_data_ok=1'b0;
        end
        `sram_data_read: 
        begin
            data_rdata=axi_data_received?rdata:32'b0;    
            data_addr_ok=1'b0;
            data_data_ok=axi_data_received;
        end
        `sram_data_write: 
        begin
            data_rdata=32'b0;    
            data_addr_ok=1'b0;
            data_data_ok=axi_data_sent;
        end
        default: 
        begin
            data_rdata=32'b0;    
            data_addr_ok=1'b0;
            data_data_ok=1'b0;
        end
        endcase
    end
end

//wstrb_reg

wire [3:0] strb_wire=
    {4{(data_addr[1:0]==2'b00)&&(data_size==2'b00)}}&4'b0001|
    {4{(data_addr[1:0]==2'b01)&&(data_size==2'b00)}}&4'b0010|
    {4{(data_addr[1:0]==2'b10)&&(data_size==2'b00)}}&4'b0100|
    {4{(data_addr[1:0]==2'b11)&&(data_size==2'b00)}}&4'b1000|
    {4{(data_addr[1:0]==2'b00)&&(data_size==2'b01)}}&4'b0011|
    {4{(data_addr[1:0]==2'b10)&&(data_size==2'b01)}}&4'b1100|
    {4{(data_addr[1:0]==2'b00)&&(data_size==2'b10)}}&4'b1111;

always@(posedge clk)begin
    wstrb_reg<=(axi_judge_dataw)?
        strb_wire:
        wstrb_reg;
end

wire [2:0]cvt_awsize=
    {3{(data_size==2'b00)}}&3'd1|
    {3{(data_size==2'b01)}}&3'd2|
    {3{(data_size==2'b10)}}&3'd4;


//AXI WRITE---------------------------------
// aw           
// output [3:0]awid,      done
// output [31:0]awaddr,    
// output [7:0]awlen,     done
// output [2:0]awsize,    
// output [1:0]awburst,   done
// output [1:0]awlock,    done
// output [3:0]awcache,   done
// output [2:0]awprot,    done
// output awvalid,   
// input awready,   
// w          
// output [3:0]wid,       done
// output [31:0]wdata,     
// output [3:0]wstrb,     
// output wlast,     done
// output wvalid,    
// input wready,    
// b              
// input [3:0]bid,       
// input [1:0]bresp,     
// input bvalid,    
// output bready    

reg [2:0]axi_write_state_now;
reg [2:0]axi_write_state_next;//is wire
reg [31:0] wdata_reg;
// wire axi_judge_dataw;
// wire axi_judge_datar;

`define axi_write_idle 3'b000
`define axi_write_addr 3'b001
`define axi_write_data 3'b010
`define axi_write_bend 3'b100

always@(posedge clk)
begin
    if(!resetn)begin
        axi_write_state_now<=3'b0;
    end else begin
        axi_write_state_now<=axi_write_state_next;
    end
end

always@(*)begin
    case(axi_write_state_now)
    `axi_write_idle: 
    begin
        axi_write_state_next=(data_wr&data_req)?
            `axi_write_addr:
            `axi_write_idle;
    end
    `axi_write_addr: 
    begin
        axi_write_state_next=axi_judge_dataw?`axi_write_data:`axi_write_addr;
    end
    `axi_write_data: 
    begin
        axi_write_state_next=axi_data_sent?`axi_write_bend:`axi_write_data;
    end
    `axi_write_bend: 
    begin
        axi_write_state_next=bvalid?`axi_write_idle:`axi_write_bend;
    end
    default: 
    begin
        axi_write_state_next=`axi_write_idle;
    end
    endcase
end

always@(*)begin
    if(!resetn)begin
        //assign all =0;
        awaddr=32'b0;
        awsize=3'b0;
        awvalid=1'b0;
        wdata=32'b0;
        wstrb=4'b0;
        wvalid=1'b0;
        bready=1'b0;
    end
    else begin
        case(axi_write_state_now)
        `axi_write_idle: 
        begin
            awaddr=32'b0;
            awsize=3'b0;
            awvalid=1'b0;
            wdata=32'b0;
            wstrb=4'b0;
            wvalid=1'b0;
            bready=1'b0;
        end
        `axi_write_addr: 
        begin
            awaddr=data_addr;//from sram
            awsize=cvt_awsize;//TODO
            awvalid=1'b1;
            wdata=32'b0;
            wstrb=strb_wire;//TODO
            wvalid=1'b0;
            bready=1'b0;
        end
        `axi_write_data: 
        begin
            awaddr=32'b0;
            awsize=3'b0;
            awvalid=1'b0;
            wdata=wdata_reg;//fixit
            wstrb=wstrb_reg;
            wvalid=1'b1;
            bready=1'b0;
        end
        `axi_write_bend: 
        begin
            awaddr=32'b0;
            awsize=3'b0;
            awvalid=1'b0;
            wdata=32'b0;
            wstrb=4'b0;
            wvalid=1'b0;
            bready=1'b1;
        end
        default: 
        begin
            awaddr=32'b0;
            awsize=3'b0;
            awvalid=1'b0;
            wdata=32'b0;
            wstrb=4'b0;
            wvalid=1'b0;
            bready=1'b0;
        end
        endcase
    end
end

//wdata_reg
always@(posedge clk)begin
    wdata_reg<=axi_judge_dataw?data_wdata:wdata_reg;
end

//AXI READ---------------------------------
// ar
// output [3:0]arid,      
// output [31:0]araddr,    
// output [7:0]arlen,     done
// output [2:0]arsize,    
// output [1:0]arburst,   done
// output [1:0]arlock,    done
// output [1:0]arcache,   done
// output [2:0]arprot,    done
// output arvalid,   
// input arready,   
// r              
// input [3:0]rid,       
// input [31:0]rdata,     
// input [1:0]rresp,     
// input rlast,     
// input rvalid,    
// output rready,    

reg [2:0]axi_read_state_now;
reg [2:0]axi_read_state_next;//is wire

`define axi_read_idle 3'b000
`define axi_read_addr 3'b001
`define axi_read_data 3'b010
// `define axi_read_bend 3'b100

// wire axi_judge_dataw;
// wire axi_judge_datar;

wire axi_read_affair=inst_req|(data_req&(!data_wr));
reg [1:0]current_affair;

`define affair_none 2'b00
`define affair_inst 2'b01
`define affair_data 2'b10

//judge
always@(posedge clk)begin
    if(!resetn)begin
        current_affair<=2'b0;
    end
    else
    begin
    if(current_affair==`affair_none)
    begin
        current_affair<=
        (data_req&(!data_wr))?
            `affair_data:
            (inst_req)?
                `affair_inst:
                `affair_none;
    end else begin
        current_affair<=rvalid?`affair_none:current_affair;
    end
    end
end

always@(posedge clk)
begin
    if(!resetn)begin
        axi_read_state_now<=3'b0;
    end else begin
        axi_read_state_now<=axi_read_state_next;
    end
end

always@(*)begin
    case(axi_read_state_now)
    `axi_read_idle: 
    begin
        axi_read_state_next=(axi_read_affair)?
            `axi_read_addr:
            `axi_read_idle;
    end
    `axi_read_addr: 
    begin
        axi_read_state_next=arready?`axi_read_data:`axi_read_addr;
    end
    `axi_read_data: 
    begin
        axi_read_state_next=rvalid?`axi_read_idle:`axi_read_data;
    end
    default: 
    begin
        axi_read_state_next=`axi_write_idle;
    end
    endcase
end

always@(*)begin
    if(!resetn)begin
        //assign all =0;
        arid=4'b0;
        araddr=32'b0;
        arsize=3'b0;
        arvalid=1'b0;
        rready=1'b0;
        // arid=(current_affair==`affair_inst)?4'b0:4'b1;
    end
    else begin
        case(axi_read_state_now)
        `axi_read_idle: 
        begin
            arid=4'b0;
            araddr=32'b0;
            arsize=3'b0;
            arvalid=1'b0;
            rready=1'b0;
        end
        `axi_read_addr: 
        begin
            arid=(current_affair==`affair_inst)?4'b0:4'b1;
            araddr=(current_affair==`affair_inst)?inst_addr:data_addr;
            arsize=(current_affair==`affair_inst)?4:4;//TODO???
            arvalid=1'b1;
            rready=1'b0;
        end
        `axi_read_data: 
        begin
            arid=4'b0;
            araddr=32'b0;
            arsize=3'b0;
            arvalid=1'b0;
            rready=1'b1;
        end
        default: 
        begin
            arid=4'b0;
            araddr=32'b0;
            arsize=3'b0;
            arvalid=1'b0;
            rready=1'b0;
        end
    
        endcase
    end
end

assign axi_judge_inst=arready&(current_affair==`affair_inst);
assign axi_judge_dataw=awready&awvalid;
assign axi_judge_datar=arready&(current_affair==`affair_data);

endmodule