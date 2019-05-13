//multipler.v
//Huaqiang Wang (c) 2018

// module booth_decoder_old#
// (
//     parameter WIDTH=34
// )
// (
//     input [WIDTH-1:0]y,
//     input [2:0]x,
//     output [WIDTH-1+1:0] result
// );

// wire [WIDTH-1:0]neg_y=~y+1;

// assign result=
//     {(WIDTH+1){x==3'b000}}&{(WIDTH+1){1'b0}}|
//     {(WIDTH+1){x==3'b001}}&{y[WIDTH-1],y}|
//     {(WIDTH+1){x==3'b010}}&{y[WIDTH-1],y}|
//     {(WIDTH+1){x==3'b011}}&{y,1'b0}|
//     {(WIDTH+1){x==3'b100}}&{neg_y,1'b0}|
//     {(WIDTH+1){x==3'b101}}&{neg_y[WIDTH-1],neg_y}|
//     {(WIDTH+1){x==3'b110}}&{neg_y[WIDTH-1],neg_y}|
//     {(WIDTH+1){x==3'b111}}&{(WIDTH+1){1'b0}};

// endmodule

module booth_decoder#
(
    parameter WIDTH=34,
    parameter POSITION=0
)
(
    input [WIDTH-1:0]y,
    input [2:0]x,
    output [WIDTH*2-1:0] result,
    output result_plus1
);

wire need_reverse=
    (x==3'b100)|
    (x==3'b101)|
    (x==3'b110);
wire need_y=
    (x==3'b001)|
    (x==3'b010)|
    (x==3'b011);
wire need_0=
    (x==3'b000)|
    (x==3'b111);

wire need_sl=
    (x==3'b011)|
    (x==3'b100);

// wire [WIDTH-1:0]result_34=
//     {(WIDTH+1){x==3'b000}}&{(WIDTH+1){1'b0}}|
//     {(WIDTH+1){x==3'b001}}&{y[WIDTH-1],y}|
//     {(WIDTH+1){x==3'b010}}&{y[WIDTH-1],y}|
//     {(WIDTH+1){x==3'b011}}&{y,1'b0}|
//     {(WIDTH+1){x==3'b100}}&{~y,1'b0}|
//     {(WIDTH+1){x==3'b101}}&{~y[WIDTH-1],~y}|
//     {(WIDTH+1){x==3'b110}}&{~y[WIDTH-1],~y}|
//     {(WIDTH+1){x==3'b111}}&{(WIDTH+1){1'b0}};

// wire [2*WIDTH-1:0]result_68={{WIDTH{result_34[31]}},result_34,{POSITION{1'b0}}};

wire [2*WIDTH-1:0]after_position={{WIDTH{y[WIDTH-1]}},y}<<(POSITION+need_sl);//place data into right position`
wire [2*WIDTH-1:0]after_reverse=
    {(2*WIDTH){need_reverse}}&(~after_position)|
    {(2*WIDTH){need_y}}&(after_position)|
    {(2*WIDTH){need_0}}&(0);

assign result=after_reverse;

assign result_plus1=
    (x==3'b100)|
    (x==3'b101)|
    (x==3'b110);
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
        assign Sout[i]=Ain[i]&Bin[i]|Ain[i]&Cin[i]|Bin[i]&Cin[i];
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
    full_adder#(1) fa5
    (
        S[0],S[1],S[2],Cout[5],S[5]
    );
    full_adder#(1) fa6
    (
        S[3],S[4],in[1],Cout[6],S[6]
    );
    full_adder#(1) fa7
    (
        in[0],Cin[0],Cin[1],Cout[7],S[7]
    );
    full_adder#(1) fa8
    (
        Cin[2],Cin[3],Cin[4],Cout[8],S[8]
    );
    //l3
    full_adder#(1) fa9
    (
        S[5],S[6],S[7],Cout[9],S[9]
    );
    full_adder#(1) fa10
    (
        S[8],Cin[5],Cin[6],Cout[10],S[10]
    );
    //l4
    full_adder#(1) fa11
    (
        S[9],S[10],Cin[7],Cout[11],S[11]
    );
    full_adder#(1) fa12
    (
        Cin[8],Cin[9],Cin[10],Cout[12],S[12]
    );
    //l5
    full_adder#(1) fa13
    (
        S[11],S[12],Cin[11],Cout[13],S[13]
    );
    //l6
    full_adder#(1) fa14
    (
        S[13],Cin[12],Cin[13],c,s
    );

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
wire [34:0]y_34_ext={y_34,1'b0};

// wire [67:0]x_68={{34{x_34[33]}},x_34};

wire [67:0]booth_result [16:0];
wire [16:0]add1;

// wire [63:0]booth_ref_result=
//     booth_result [0]+add1[0]+
//     booth_result [1]+add1[1]+
//     booth_result [2]+add1[2]+
//     booth_result [3]+add1[3]+
//     booth_result [4]+add1[4]+
//     booth_result [5]+add1[5]+
//     booth_result [6]+add1[6]+
//     booth_result [7]+add1[7]+
//     booth_result [8]+add1[8]+
//     booth_result [9]+add1[9]+
//     booth_result [10]+add1[10]+
//     booth_result [11]+add1[11]+
//     booth_result [12]+add1[12]+
//     booth_result [13]+add1[13]+
//     booth_result [14]+add1[14]+
//     booth_result [15]+add1[15]+
//     booth_result [16]+add1[16];

genvar booth_cnt;
generate
    for(booth_cnt=0;booth_cnt<17;booth_cnt=booth_cnt+1)
    begin: booth_decoder
    booth_decoder #(34,booth_cnt*2) booth_decoder(
        x_34,
        y_34_ext[2*booth_cnt+2:2*booth_cnt],
        booth_result[booth_cnt],
        add1[booth_cnt]
    );
    end
endgenerate

//switch
wire [16:0]switched_wallace_data[67:0];
genvar k,l;
generate 
for(k=0;k<68;k=k+1)begin
    for(l=0;l<17;l=l+1)begin
        assign switched_wallace_data[k][l]=booth_result[l][k];
    end
end
endgenerate


wire [67:0]S;
wire [67:0]C;

reg [67:0]S_reg;
reg [67:0]C_reg;
reg add1_14;
reg add1_15;

wire [13:0]wt_C[68:0];
//FIXIT
assign wt_C[0]=add1[13:0];

genvar p;
generate
for(p=0;p<68;p=p+1)begin: wallace_tree
    wallace_tree_17 wt
    (
        switched_wallace_data[p],
        wt_C[p],
        wt_C[p+1],
        C[p],
        S[p]
    );
end
endgenerate

always@(posedge mul_clk)begin
    S_reg<=S;
    C_reg<=C;
    add1_14<=add1[14];
    add1_15<=add1[15];
end

wire [64:0] res_1={S_reg,add1_14};
wire [64:0] res_2={C_reg,add1_15,add1_14};
wire [64:0] res_3=res_1+res_2;

reg resetn_reg;
always@(posedge mul_clk)begin
    resetn_reg<=resetn;
end

assign result=resetn_reg?res_3[64:1]:64'b0;

endmodule