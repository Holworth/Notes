//multipler.v
//Huaqiang Wang (c) 2018

module booth_decoder#
(
    parameter WIDTH=34
)
(
    input [WIDTH-1:0]y,
    input [2:0]x,
    output [WIDTH-1+1:0] result
);

wire [WIDTH-1:0]neg_y=~y+1;

assign result=
    {(WIDTH+1){x==3'b000}}&{(WIDTH+1){1'b0}}|
    {(WIDTH+1){x==3'b001}}&{y[WIDTH-1],y}|
    {(WIDTH+1){x==3'b010}}&{y[WIDTH-1],y}|
    {(WIDTH+1){x==3'b011}}&{y,1'b0}|
    {(WIDTH+1){x==3'b100}}&{neg_y,1'b0}|
    {(WIDTH+1){x==3'b101}}&{neg_y[WIDTH-1],neg_y}|
    {(WIDTH+1){x==3'b110}}&{neg_y[WIDTH-1],neg_y}|
    {(WIDTH+1){x==3'b111}}&{(WIDTH+1){1'b0}};

endmodule


module full_adder#
(
    parameter WIDTH = 1
)
(
    input [WIDTH-1:0]Ain,
    input [WIDTH-1:0]Bin,
    input [WIDTH-1:0]Cin,
    output [WIDTH-1:0]Sout,
    output [WIDTH-1:0]Cout
);

genvar i;
generate
    for(i=0;i<WIDTH;i=i+1)
    begin
        // full_bit_adder
        assign Cout[i]=~Ain[i]&~Bin[i]&Cin[i]|~Ain[i]&Bin[i]&~Cin[i]|Ain[i]&~Bin[i]&~Cin[i]|Ain[i]&Bin[i]&Cin[i];
        assign Sout[i]=Ain[i]&Bin[i]|Ain[i]&Bin[i]|Bin[i]&Cin[i];
    end
endgenerate

endmodule


module wallace_tree_17
(
    input [16:0]in,
    input [13:0]Cin,
    output [13:0]Cout,
    output c,
    output s
);
    wire [13:0]S;
    //l1
    full_adder#(1) fa0
    (
        in[16],in[15],in[14],Cout[0],S[0]
    );
    full_adder#(1) fa1
    (
        in[13],in[12],in[11],Cout[1],S[1]
    );
    full_adder#(1) fa2
    (
        in[10],in[9],in[8],Cout[2],S[2]
    );
    full_adder#(1) fa3
    (
        in[7],in[6],in[5],Cout[3],S[3]
    );
    full_adder#(1) fa4
    (
        in[4],in[3],in[2],Cout[4],S[4]
    );
    //l2

endmodule

module multipler
(
input mul_clk, // 乘法器模块时钟信号
input resetn, // 复位信号，低电平有效
input mul_signed, // 控制有符号乘法和无符号乘法
input [31:0] x, // 被乘数
input [31:0] y, // 乘数
output [63:0] result   //乘法结果，高 32 写入 HI，低 32 位写入LO
);

wire [33:0]x_34=mul_signed?{{2{x[31]}},x}:{2'b0,x};
wire [33:0]y_34=mul_signed?{{2{y[31]}},y}:{2'b0,y};
wire [34:0]y_34_ext={x_34,1'b0};

// wire [67:0]x_68={{34{x_34[33]}},x_34};

wire [34:0]booth_result [16:0];

genvar booth_cnt;
generate
    for(booth_cnt=0;booth_cnt<17;booth_cnt=booth_cnt+1)
    begin: booth_decoder
    booth_decoder #(68) booth_decoder(
        x_34,
        y_34_ext[booth_cnt+2:booth_cnt],
        booth_result[booth_cnt]
    );
    end
endgenerate

// Prepare data for Wallace Tree

wire [67:0]wallace_data_l0[16:0];
genvar m;
generate
    for(m=0;m<17;m=m+1)
    begin
        assign wallace_data_l0[m]={{(68-35){booth_result[m][34]}},booth_result[m][34:0]}<<(2*m);
    end
endgenerate

wire [67:0]S;
wire [67:0]C;

genvar p;
generate
for(p=0;p<68;p=p+1)begin: wallace_tree
    S[p]=wallace_tree[p].s;
end
endgenerate

endmodule