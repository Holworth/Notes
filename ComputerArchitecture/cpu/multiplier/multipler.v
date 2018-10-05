//multipler.v
//Huaqiang Wang (c) 2018

module full_adder#
(
    parameter WIDTH = 34*2
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
wire [34:0]x_34_ext={x_34,1'b0};

wire [34:0]booth_result [16:0];

genvar booth_cnt;
generate
    for(booth_cnt=0;booth_cnt<17;booth_cnt=booth_cnt+1)
    begin: booth_decoder
    booth_decoder #(34) booth_decoder(
        y_34,
        x_34_ext[2*booth_cnt+2:2*booth_cnt],
        booth_result[booth_cnt]
    );
    end
endgenerate

// Prepare data for Wallcae Tree

wire [67:0]wallace_data_l0[16:0];
genvar m;
generate
    for(m=0;m<17;m=m+1)
    begin
        assign wallace_data_l0[m]={{(68-35){booth_result[m][34]}},booth_result[m][34:0]}<<(2*m);
    end
endgenerate

// Wallace Tree

wire [67:0]wallace_data_l1[11:0];
wire [67:0]wallace_data_l2[7:0];
wire [67:0]wallace_data_l3[5:0];

// // Cut for pipeline here
// reg [67:0]wallace_data_l3_reg[5:0];
// always@(posedge mul_clk)begin
//     if(!resetn)begin
//         wallace_data_l3_reg[0]<=68'b0;
//         wallace_data_l3_reg[1]<=68'b0;
//         wallace_data_l3_reg[2]<=68'b0;
//         wallace_data_l3_reg[3]<=68'b0;
//         wallace_data_l3_reg[4]<=68'b0;
//         wallace_data_l3_reg[5]<=68'b0;
//     end
//     else begin
//         wallace_data_l3_reg[0]<=wallace_data_l3[0];
//         wallace_data_l3_reg[1]<=wallace_data_l3[1];
//         wallace_data_l3_reg[2]<=wallace_data_l3[2];
//         wallace_data_l3_reg[3]<=wallace_data_l3[3];
//         wallace_data_l3_reg[4]<=wallace_data_l3[4];
//         wallace_data_l3_reg[5]<=wallace_data_l3[5];
//     end
// end

wire [67:0]wallace_data_l4[3:0];
wire [67:0]wallace_data_l5[2:0];
wire [67:0]wallace_data_l6[1:0];

//l1

genvar wt_l1;
for(wt_l1=0;wt_l1<5;wt_l1=wt_l1+1)
begin: full_adder_l1
    full_adder #(.WIDTH(68)) full_adder
    (
        wallace_data_l0[wt_l1*3],
        wallace_data_l0[wt_l1*3+1],
        wallace_data_l0[wt_l1*3+2],
        wallace_data_l1[wt_l1*2],//Sout
        wallace_data_l1[wt_l1*2+1]//Cout
    );
end

assign wallace_data_l1[10]=wallace_data_l0[15];
assign wallace_data_l1[11]=wallace_data_l0[16];

//l2
    full_adder #(.WIDTH(68)) full_adder_l2_0
    (
        wallace_data_l1[0],
        wallace_data_l1[1]<<1,
        wallace_data_l1[2],
        wallace_data_l2[0],//Sout
        wallace_data_l2[1]//Cout
    );
    full_adder #(.WIDTH(68)) full_adder_l2_1
    (
        wallace_data_l1[3]<<1,
        wallace_data_l1[4],
        wallace_data_l1[5]<<1,
        wallace_data_l2[2],//Sout
        wallace_data_l2[3]//Cout
    );
    full_adder #(.WIDTH(68)) full_adder_l2_2
    (
        wallace_data_l1[6],
        wallace_data_l1[7]<<1,
        wallace_data_l1[8],
        wallace_data_l2[4],//Sout
        wallace_data_l2[5]//Cout
    );
    full_adder #(.WIDTH(68)) full_adder_l2_3
    (
        wallace_data_l1[9]<<1,
        wallace_data_l1[10],
        wallace_data_l1[11],
        wallace_data_l2[6],//Sout
        wallace_data_l2[7]//Cout
    );

//l3
    full_adder #(.WIDTH(68)) full_adder_l3_0
    (
        wallace_data_l2[0],
        wallace_data_l2[1]<<1,
        wallace_data_l2[2],
        wallace_data_l3[0],//Sout
        wallace_data_l3[1]//Cout
    );
    full_adder #(.WIDTH(68)) full_adder_l3_1
    (
        wallace_data_l2[3]<<1,
        wallace_data_l2[4],
        wallace_data_l2[5]<<1,
        wallace_data_l3[2],//Sout
        wallace_data_l3[3]//Cout
    );
    assign wallace_data_l3[4]=wallace_data_l2[6];
    assign wallace_data_l3[5]=wallace_data_l2[7]<<1;

//l4
    full_adder #(.WIDTH(68)) full_adder_l4_0
    (
        wallace_data_l3[0],
        wallace_data_l3[1]<<1,
        wallace_data_l3[2],
        wallace_data_l4[0],//Sout
        wallace_data_l4[1]//Cout
    );
    full_adder #(.WIDTH(68)) full_adder_l4_1
    (
        wallace_data_l3[3]<<1,
        wallace_data_l3[4],
        wallace_data_l3[5],
        wallace_data_l4[2],//Sout
        wallace_data_l4[3]//Cout
    );
//l5
    full_adder #(.WIDTH(68)) full_adder_l5_0
    (
        wallace_data_l4[0],
        wallace_data_l4[1]<<1,
        wallace_data_l4[2],
        wallace_data_l5[0],//Sout
        wallace_data_l5[1]//Cout
    );
    assign wallace_data_l5[2]=wallace_data_l4[3]<<1;

//l6
    full_adder #(.WIDTH(68)) full_adder_l6_0
    (
        wallace_data_l5[0],
        wallace_data_l5[1]<<1,
        wallace_data_l5[2],
        wallace_data_l6[0],//Sout
        wallace_data_l6[1]//Cout
    );

// pipe divide:
reg [67:0]regC;
reg [67:0]regS;
always@(posedge mul_clk)begin
    if(!resetn)begin
        regC<=68'b0;
        regS<=68'b0;
    end
    else begin
        regC<=wallace_data_l6[1];
        regS<=wallace_data_l6[0];
    end
end

//result
    assign result=regS[0]+regC[1]<<1;

endmodule
