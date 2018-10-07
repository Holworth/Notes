module mul(
input mul_clk, // 乘法器模块时钟信号
input resetn, // 复位信号，低电平有效
input mul_signed, // 控制有符号乘法和无符号乘法
input [31:0] x, // 被乘数
input [31:0] y, // 乘数
output [63:0] result   //乘法结果，高 32 写入 HI，低 32 位写入LO
);

wire signed [63:0] result_ref;
wire signed [32:0] x_e;
wire signed [32:0] y_e;
assign x_e = {mul_signed & x[31],x};
assign y_e = {mul_signed & y[31],y};
assign result_ref = x_e*y_e;
reg signed[63:0]res;
reg resetn_reg;
always@(posedge mul_clk)begin
    res<=result_ref;
    resetn_reg<=resetn;
end
assign result=(!resetn_reg)?63'b0:res;
endmodule