//divider.v
//Huaqiang Wang (c) 2018

module divider
(
input div_clk, //除法器模块时钟信号
input resetn, //复位信号，低电平有效
input div, //除法运算命令，在除法完成后，如果外界没有新的除法进入，必须将该信号置为 0
input div_signed, //控制有符号除法和无符号除法的信号
input [31:0]x, //被除数
input [31:0]y, //除数
output [31:0]s, //除法结果，商
output [31:0]r, //除法结果，余数
output complete //除法完成信号，除法内部 count 计算达到33
);

reg [6:0]counter;

wire [32:0]x_33=div_signed?{{1{x[31]}},x}:{1'b0,x};
wire [32:0]y_33=div_signed?{{1{y[31]}},y}:{1'b0,y};
wire [32:0]x_33_abs=x_33[32]?(~x_33+1):x_33;
wire [32:0]y_33_abs=y_33[32]?(~y_33+1):y_33;

wire sign=x_33[32]^y_33[32];
reg result_sign;
reg dividend_sign;
reg [32:0]dividend;
reg [32:0]quotient;
reg [32:0]divisor;
reg [32:0]neg_divisor;

always@(posedge div_clk)begin
    if(!resetn)begin
        counter<=6'd0;
    end
    else begin
        if(div)begin
            counter<=counter+1;
        end
        else begin
            counter<=6'b0;
        end
    end

    if(counter==0)begin
        result_sign<=sign;
        dividend_sign<=x_33[32];
        dividend<=x_33_abs;
        quotient<=33'b0;
        divisor<=y_33_abs;
        neg_divisor<=~y_33+1;
    end
    else begin
        if(counter==1)begin
            dividend=dividend+(dividend[32]==divisor[32])?
                neg_divisor:
                divisor;
        end    
        else if(counter<33)begin
            if(dividend[32]!=divisor[32])begin
                dividend<=dividend<<1+divisor;
                quotient<=quotient<<1+0;
            end
            else begin
                dividend<=dividend<<1+neg_divisor;
                quotient<=quotient<<1+1;
            end
        end
    end
end

assign complete=counter==33;
assign s=quotient;
assign r=dividend;

endmodule