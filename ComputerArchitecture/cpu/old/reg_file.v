`timescale 10 ns / 1 ns

`define DATA_WIDTH 32
`define ADDR_WIDTH 5


module reg_file(
	input clk,
	input rst,
	input [`ADDR_WIDTH - 1:0] waddr,
	input [`ADDR_WIDTH - 1:0] raddr1,
	input [`ADDR_WIDTH - 1:0] raddr2,
	input wen,
	input [`DATA_WIDTH - 1:0] wdata,
	output [`DATA_WIDTH - 1:0] rdata1,
	output [`DATA_WIDTH - 1:0] rdata2
);

	reg [`DATA_WIDTH-1:0]rf[`DATA_WIDTH - 1:0];
	assign rdata1=rf[raddr1];
	assign rdata2=rf[raddr2];
	always@(posedge clk)
	begin
	  	if(rst)
	  	begin
	  		rf[0]<=0;
		end
		else 
		begin
			if(wen&&(waddr!=0))
			begin
				rf[waddr]<=wdata;
			end
		end
	end

endmodule

