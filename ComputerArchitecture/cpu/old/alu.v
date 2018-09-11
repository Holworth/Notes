`timescale 10 ns / 1 ns

`define DATA_WIDTH 32
`define AND 3'b000
`define OR 3'b001
`define ADD 3'b010
`define SUB 3'b110
`define SLT 3'b111
`define XOR 3'b100
`define NOR 3'b101
`define SLTU 3'b011


module alu(
	input [`DATA_WIDTH - 1:0] A,
	input [`DATA_WIDTH - 1:0] B,
	input [2:0] ALUop,
	output Overflow,
	output CarryOut,
	output Zero,
	output reg [`DATA_WIDTH - 1:0] Result
);

	// reg [`DATA_WIDTH - 1:0] Result;

	//公用加法器逻辑
	wire [`DATA_WIDTH+1:0]adder_with_cin;
	wire [`DATA_WIDTH:0]adder;
	wire [`DATA_WIDTH:0]addee;

	//加法器使用的cin
	wire neg1;
	assign neg1=((ALUop==`ADD)?0:1);

	//带cin的共用加法器
	assign addee=((ALUop==`ADD)?B:~B);
	assign adder=adder_with_cin[`DATA_WIDTH+1:1];
	assign adder_with_cin={1'b0,A,neg1}+{addee,neg1}; 

	//标志位(flag)输出逻辑
	assign CarryOut=adder[32];

	assign Zero=({Result}==0);

	assign Overflow=
		((ALUop==`ADD)?
		(A[`DATA_WIDTH - 1]==B[`DATA_WIDTH - 1])&&(adder[`DATA_WIDTH - 1]!=A[`DATA_WIDTH - 1]):
		(A[`DATA_WIDTH - 1]!=B[`DATA_WIDTH - 1])&&(adder[`DATA_WIDTH - 1]!=A[`DATA_WIDTH - 1]));
	
	//选择器逻辑
	always@*
	begin
		case(ALUop[2:0])
			`AND:
				begin
					Result=A&B;			
				end
			`OR:
				begin
					Result=A|B;			
				end
		  	`ADD:
			  	begin
					Result=adder;
				end
		  	`SUB:
			  	begin
					Result=adder;
				end
			`XOR:
				begin
					Result=A^B;
				end
			`NOR:
				begin
					Result=~(A|B);
				end
			`SLTU:
				begin
					Result[`DATA_WIDTH-1:1]=0;
					Result[0]=CarryOut; //????
					
				end

			default:
		  	// `SLT:
			  	begin
					Result[`DATA_WIDTH-1:1]=0;
					Result[0]=adder[`DATA_WIDTH-1]^Overflow;
				end
		endcase
	end

endmodule
