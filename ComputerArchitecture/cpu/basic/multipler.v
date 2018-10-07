module multipler(
input mul_clk, // �˷���ģ��ʱ���ź�
input resetn, // ��λ�źţ��͵�ƽ��Ч
input mul_signed, // �����з��ų˷����޷��ų˷�
input [31:0] x, // ������
input [31:0] y, // ����
output [63:0] result   //�˷�������� 32 д�� HI���� 32 λд��LO
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