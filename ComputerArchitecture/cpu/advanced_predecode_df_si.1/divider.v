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
reg in_div;

//div_signed!!

wire [31:0]x_abs=div_signed?(x[31]?(~x+1):x):x;
wire [31:0]y_abs=div_signed?(y[31]?(~y+1):y):y;

wire sign=x[31]^y[31];
reg result_sign;
reg dividend_sign;
reg div_signed_reg;
reg [64:0]result_reg;
reg [31:0] x_abs_reg;
reg [31:0] y_abs_reg;
wire [31:0]dividend=result_reg[63:32];
wire [31:0]quotient=result_reg[31:0];

wire [32:0]abssub=result_reg[63:31]+(~{1'b0,y_abs_reg[31:0]})+1;

always@(posedge div_clk)begin
    if(!resetn)begin
        counter<=6'd0;
        in_div<=0;
        x_abs_reg<=32'b0;
        y_abs_reg<=32'b0;
        result_reg<=1'b0;
        result_sign<=1'b0;
        dividend_sign<=1'b0;
        div_signed_reg<=1'b0;
    end
    else begin
        if(in_div)begin
            counter<=counter+1;
        end
        else begin
            counter<=6'b0;
            if(div)begin
                in_div<=1;
                result_sign<=sign;
                dividend_sign<=x[31];
                result_reg<={32'b0,x_abs};
                x_abs_reg<=x_abs;
                y_abs_reg<=y_abs;
                div_signed_reg<=div_signed;
            end
        end
    end

    if(in_div)begin
        if(counter==32)begin
            in_div<=0;
            //todo: get result   
        end
        else begin
            if(abssub[32])begin
                //quotient<-0
                result_reg<={result_reg[63:0],1'b0};
            end
            else
            begin
                //quotient<-1
                result_reg<={abssub,result_reg[30:0],1'b1};
            end
        end 
    end
end



// result_sign//q
// dividend_sign//d

assign complete=counter==32;
assign s=div_signed_reg?
    (result_sign?(~result_reg[31:0]+1):result_reg[31:0]):
    result_reg[31:0];
assign r=div_signed_reg?
    (dividend_sign?(~result_reg[63:32]+1):result_reg[63:32]):
    result_reg[63:32];

endmodule