`include "define.v"

// State
// `define State_Fetch 16'b0000_0000_0000_0001
// `define State_Decode 16'b0000_0000_0000_0010
// `define State_Rexe 16'b0000_0000_0000_0100
// `define State_Rreg 16'b0000_0000_0000_1000
// `define State_Bexe 16'b0000_0000_0001_0000
// `define State_Jexe 16'b0000_0000_0010_0000
// // `define State_Jreg 16'b0000_0000_0100_0000
// `define State_Lexe 16'b0000_0000_0100_0000
// `define State_Sexe 16'b0000_0000_1000_0000
// `define State_Lmem 16'b0000_0001_0000_0000
// `define State_Lreg 16'b0000_0010_0000_0000
// `define State_Smem 16'b0000_0100_0000_0000
// `define State_Iexe 16'b0000_1000_0000_0000
// `define State_Ireg 16'b0001_0000_0000_0000
// `define State_Fwait 16'b0010_0000_0000_0000
// `define State_Lwait 16'b0100_0000_0000_0000
// `define State_rst 16'b1000_0000_0000_0000


	//Instruction request channel
	// output [31:0] PC,
	// output Inst_Req_Valid,//
	// input Inst_Req_Ack,//

	// //Instruction response channel
	// input  [31:0] Instruction,
	// input Inst_Valid,//
	// output Inst_Ack,//

	// //Memory request channel
	// output [31:0] Address,
	// output MemWrite,
	// output [31:0] Write_data,
	// output [3:0] Write_strb,
	// output MemRead,
	// input Mem_Req_Ack,//

	// //Memory data response channel
	// input  [31:0] Read_data,
	// input Read_data_Valid,//
	// output Read_data_Ack//

module control(
	input rst,
	input clk,
	input [31:0]InstructionReg,
    input Branch,
    input SpecialJump,
	output reg PCwrite,
	output reg MEMread,
	output reg MEMwrite,
	output reg REGwrite,
	output reg Awrite,
	output reg Bwrite,
	output reg Instructionwrite,
	output reg REGwritesrcbyAC, //Decided wire REGwrite is controlled by: 0: Control 1: ALUControl
	// output Branch,//(wire: enable branch)
	output reg ALUin1,// PC A
	output reg [2:0]ALUin2, //B 0 4 (8) ImmSignedExt ImmUnsignedExt Offset00Ext
	output reg ALUopsrc, //ALUopAC ALUopC
    output reg ALUwrite,
	output reg [1:0]PCsrc,// ALU A LongJump
	output reg [3:0]REGwritesrc,// (:REGwritesrcbyAC) ALUout MEM MEMb MEMub MEMh MEMuh IMM160 MEMl MEMr A Shifter
	output reg MEMwritesrc,// B ALUout
	output reg [2:0]RegDst,// Ins20_16 Ins15_11 31 movn movz  
	output reg LorD,// PC ALUout
	input [5:0]BranchCond,// (5)
    output [12:0]ExtenderControl,
	// output reg [2:0]LoadControl,//(3)  lb lbu lh lhu lui lw lwl lwr
	// output reg [2:0]StoreControl,//(3)  sb sh sw swl swr
	// output reg [2:0]ShiftControl,//(3) sll sllv sra srav srl srlv

	// output reg ALUmode,
	output reg [2:0]ALUopC,
	output R,
	output reg [2:0]REGwriteaddrsrc,

    //prj3 added
    output reg Inst_Req_Valid,//
	input Inst_Req_Ack,//

	//Instruction response channel
	input Inst_Valid,//
	output reg Inst_Ack,//

	//Memory request channel
	input Mem_Req_Ack,//

	//Memory data response channel
	input Read_data_Valid,//
	output reg Read_data_Ack,//

    output reg Read_data_write,

    output [15:0]CountNextState,

    //for mul
    output  MUL
    
);

//Wire define--------------------------
    wire _ALUin1;
    reg [2:0]_ALUin2;
    // wire _PCwrite;
    wire [15:0]_NextState;
    wire [4:0]_BranchCond;
    wire [2:0]_RegDst;
    wire [2:0]Iop;

    assign CountNextState=NextState;

//译码器-----------------------------------
    wire op_addiu=InstructionReg[31:26]==`op_addiu;
    wire op_lw=InstructionReg[31:26]==`op_lw;
    wire op_sw=InstructionReg[31:26]==`op_sw;
    wire op_bne=InstructionReg[31:26]==`op_bne;
    wire op_beq=InstructionReg[31:26]==`op_beq;
    wire op_bgez=InstructionReg[31:26]==`op_bgez;
    wire op_blez=InstructionReg[31:26]==`op_blez;
    wire op_bltz=InstructionReg[31:26]==`op_bltz;
    wire op_bgtz=InstructionReg[31:26]==`op_bgtz;
    wire op_nop=InstructionReg[31:26]==`op_nop;
    wire op_j=InstructionReg[31:26]==`op_j;
    wire op_jal=InstructionReg[31:26]==`op_jal;
    wire op_lui=InstructionReg[31:26]==`op_lui;
    wire op_slti=InstructionReg[31:26]==`op_slti;
    wire op_sltiu=InstructionReg[31:26]==`op_sltiu;
    wire op_andi=InstructionReg[31:26]==`op_andi;
    wire special=InstructionReg[31:26]==`special;
    wire regimm=InstructionReg[31:26]==`regimm;
    
    wire op_lb=InstructionReg[31:26]==`op_lb;
    wire op_lbu=InstructionReg[31:26]==`op_lbu;
    wire op_lh=InstructionReg[31:26]==`op_lh;
    wire op_lhu=InstructionReg[31:26]==`op_lhu;
    wire op_lwl=InstructionReg[31:26]==`op_lwl;
    wire op_lwr=InstructionReg[31:26]==`op_lwr;
    wire op_ori=InstructionReg[31:26]==`op_ori;
    wire op_sb=InstructionReg[31:26]==`op_sb;
    wire op_sh=InstructionReg[31:26]==`op_sh;
    wire op_swl=InstructionReg[31:26]==`op_swl;
    wire op_swr=InstructionReg[31:26]==`op_swr;
    wire op_xori=InstructionReg[31:26]==`op_xori;

    wire jalr=InstructionReg[5:0]==`jalr;

    wire special2=InstructionReg[31:26]==`special2;
    assign MUL=special2&(InstructionReg[5:0]==6'b000010)&((StateReg==`State_Decode)||(StateReg==`State_Rexe));


//FSM State control--------------------
    reg [15:0] StateReg;
	reg [15:0] NextState;

	always@(posedge clk)
	begin
	  if(rst)
		begin
			StateReg<=`State_rst;
		end
		else
		begin
			StateReg<=NextState;
		end
	end

    always@*
    begin
        case(StateReg)
        `State_rst:
        begin
            NextState=`State_Fetch;
        end
        `State_Fetch:
        begin
            NextState=(Inst_Req_Ack?`State_Fwait:`State_Fetch);
        end
        `State_Decode:
        begin
            NextState=_NextState;
        end
        `State_Rexe:
        begin
            NextState=`State_Rreg;
        end
        `State_Rreg:
        begin
            NextState=`State_Fetch;            
        end
        `State_Bexe:
        begin
            NextState=`State_Fetch;            
        end
        `State_Jexe:
        begin
            NextState=`State_Fetch;            
        end
        `State_Sexe:
        begin
            NextState=`State_Smem;            
        end
        `State_Lexe:
        begin
            NextState=`State_Lmem;            
        end
        `State_Lmem:
        begin
            NextState=(Mem_Req_Ack?`State_Lwait:`State_Lmem);            
        end
        `State_Lreg:
        begin
            NextState=`State_Fetch;            
        end
        `State_Smem:
        begin
            NextState=(Mem_Req_Ack?`State_Fetch:`State_Smem);
        end
        `State_Iexe:
        begin
            NextState=`State_Ireg;
        end
        `State_Ireg:
        begin
            NextState=`State_Fetch;            
        end
        `State_Fwait:
        begin
            NextState=(Inst_Valid?`State_Decode:`State_Fwait);
        end
        `State_Lwait:
        begin
            NextState=(Read_data_Valid?`State_Lreg:`State_Lwait);
        end
        default:
        begin
            NextState=0;//Stop at 0 state: for debug;
        end
    endcase
    end


    always@(posedge clk)
    begin

        Inst_Req_Valid<=(((NextState==`State_Fetch)&(!rst))?1:0);
        Inst_Ack<=(((NextState==`State_Fwait)|rst)?1:0);
        Read_data_Ack<=((NextState==`State_Lwait)?1:0);
        Read_data_write<=((NextState==`State_Lwait)?1:0);

        case(NextState)
        `State_Fetch:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;            
            Awrite<=0;
            Bwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_PC;
            ALUin2<=`ALUin2_4;
            ALUwrite<=1;
            ALUopsrc<=`ALUopsrc_ALUopC;
            ALUopC<=`ADD;
            PCsrc<=`PCsrc_ALU;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Decode:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=1;
            Bwrite<=1;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=_ALUin1;
            ALUin2<=_ALUin2;
            ALUopC<=0;
            ALUwrite<=0;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=`PCsrc_ALU;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Rexe:
        begin
            PCwrite<=SpecialJump;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=1;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=_ALUin1;
            ALUin2<=_ALUin2;
            ALUopC<=0;
            ALUopsrc<=`ALUopsrc_ALUopAC;
            PCsrc<=`PCsrc_A;
            REGwritesrc<=`REGwritesrc_ALUout;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=0;
        end
        `State_Rreg:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=1;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=1;
            ALUin1<=0;
            ALUin2<=0;
            ALUopC<=0;
            ALUopsrc<=0;
            PCsrc<=0;
            REGwritesrc<=`REGwritesrc_ALUout;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Bexe:
        begin
            PCwrite<=
                ((BranchCond[0]&op_beq)
                |(BranchCond[1]&op_bgez)
                |(BranchCond[2]&op_blez)
                |(BranchCond[3]&op_bltz)
                |(BranchCond[4]&op_bne)
                |(BranchCond[5]&op_bgtz));
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_PC;
            ALUin2<=`ALUin2_Offset00Ext;
            ALUopC<=`ADD;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=`PCsrc_ALU;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Jexe:
        begin
            PCwrite<=1;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=1;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_PC;
            ALUin2<=`ALUin2_4;
            ALUopC<=`ADD;
            ALUopsrc<=0;
            PCsrc<=`PCsrc_LongJump;
            REGwritesrc<=`REGwritesrc_ALUnow;
            MEMwritesrc<=0;
            RegDst<=_RegDst;
            LorD<=`LorD_ALUout;
        end
        `State_Sexe:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=1;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_A;
            ALUin2<=`ALUin2_ImmSignedExt;
            ALUopC<=`ADD;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=0;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Lexe:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=1;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_A;
            ALUin2<=`ALUin2_ImmSignedExt;
            ALUopC<=`ADD;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=`PCsrc_ALU;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Lmem:
        begin
            PCwrite<=0;
            MEMread<=1;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_A;
            ALUin2<=`ALUin2_4;
            ALUopC<=`ADD;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=`PCsrc_ALU;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Lreg:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=1;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_A;
            ALUin2<=`ALUin2_4;
            ALUopC<=`ADD;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=`PCsrc_ALU;
            REGwritesrc<=`REGwritesrc_MEM;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Smem:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=1;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_A;
            ALUin2<=`ALUin2_4;
            ALUopC<=`ADD;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=`PCsrc_ALU;
            REGwritesrc<=0;
            MEMwritesrc<=`MEMwritesrc_B;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Iexe:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=1;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            REGwritesrc<=0;
            RegDst<=`RegDst_Ins20_16;
            ALUin1<=`ALUin1_A;
            ALUin2<=(op_addiu)?`ALUin2_ImmSignedExt:`ALUin2_ImmUnsignedExt;
            ALUopC<=Iop;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=`PCsrc_ALU;
            MEMwritesrc<=`MEMwritesrc_B;
            LorD<=`LorD_ALUout;
        end
        `State_Ireg:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=1;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=0;
            ALUin2<=0;
            ALUopC<=0;
            ALUopsrc<=0;
            PCsrc<=0;
            REGwritesrc<=`REGwritesrc_ALUout;
            MEMwritesrc<=0;
            RegDst<=0;// controlled by alucontrol
            LorD<=`LorD_ALUout;
        end      
        `State_Fwait:
        begin
            PCwrite<=1;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;            
            Awrite<=0;
            Bwrite<=0;
            Instructionwrite<=1;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_PC;
            ALUin2<=`ALUin2_4;
            ALUwrite<=0;
            ALUopsrc<=`ALUopsrc_ALUopC;
            ALUopC<=`ADD;
            PCsrc<=`PCsrc_ALUout;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_Lwait:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=`ALUin1_A;
            ALUin2<=`ALUin2_4;
            ALUopC<=`ADD;
            ALUopsrc<=`ALUopsrc_ALUopC;
            PCsrc<=`PCsrc_ALU;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;
            LorD<=`LorD_ALUout;
        end
        `State_rst:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=0;
            ALUin2<=0;
            ALUopC<=0;
            ALUopsrc<=0;
            PCsrc<=0;
            REGwritesrc<=`REGwritesrc_ALUout;
            MEMwritesrc<=0;
            RegDst<=0;// : controlled by alucontrol
            LorD<=`LorD_ALUout;
        end
        default:
        begin
            PCwrite<=0;
            MEMread<=0;
            MEMwrite<=0;
            REGwrite<=0;
            Awrite<=0;
            Bwrite<=0;
            ALUwrite<=0;
            Instructionwrite<=0;
            REGwritesrcbyAC<=0;
            ALUin1<=0;
            ALUin2<=0;
            ALUopC<=0;
            ALUopsrc<=0;
            PCsrc<=0;
            REGwritesrc<=0;
            MEMwritesrc<=0;
            RegDst<=0;// : controlled by alucontrol
            LorD<=`LorD_ALUout;
        end
    endcase
    end

	assign R=special&(!StateReg[13])&(!StateReg[15])&(!StateReg[0]);

    assign _ALUin1=op_beq|op_blez|op_bne|op_blez|(special&jalr);
    // `define ALUin1_PC 1'b1
    // `define ALUin1_A 1'b0
    always@*
    begin
        case(InstructionReg[31:26])
            `op_addiu:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_sltiu:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_slti:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_lb:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_lbu:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_lh:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_lhu:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_lw:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_lwl:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_lwr:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_sb:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_sh:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_sw:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_swl:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end
            `op_swr:
            begin
                _ALUin2=`ALUin2_ImmSignedExt;
            end

            `op_andi:
            begin
              _ALUin2=`ALUin2_ImmUnsignedExt;
            end
            `op_ori:
            begin
              _ALUin2=`ALUin2_ImmUnsignedExt;
            end
            `op_xori:
            begin
              _ALUin2=`ALUin2_ImmUnsignedExt;
            end
            `op_jal:
            begin
              _ALUin2=`ALUin2_ImmUnsignedExt;
            end

            default:
            begin
                _ALUin2=(jalr)?`ALUin2_4:`ALUin2_B;
            end
        endcase
    end

// `define ALUin2_B 3'b000
// `define ALUin2_0 3'b001
// `define ALUin2_4 3'b010
// `define ALUin2_ImmSignedExt 3'b011
// `define ALUin2_ImmUnsignedExt 3'b100
// `define ALUin2_Offset00Ext 3'b101

    // assign _PCwrite=;
    // assign [4:0]_BranchCond;
    
    assign _NextState[0]=0;
    assign _NextState[1]=0;
    assign _NextState[2]=(special|special2);//R, and special2 series
    assign _NextState[3]=0;
    assign _NextState[4]=(op_beq|op_bgez|op_blez|op_bltz|op_bne|op_bgtz);//B
    assign _NextState[5]=(op_j|op_jal);//J
    assign _NextState[6]=(op_lb|op_lbu|op_lh|op_lhu|op_lui|op_lw|op_lwl|op_lwr);//L
    assign _NextState[7]=(op_sb|op_sh|op_sw|op_swl|op_swr);//S
    assign _NextState[8]=0;
    assign _NextState[9]=0;
    assign _NextState[10]=0;
    assign _NextState[11]=(op_ori|op_addiu|op_xori|op_andi|op_slti|op_sltiu);//I
    assign _NextState[12]=0;
    assign _NextState[13]=0;
    assign _NextState[14]=0;
    assign _NextState[15]=0;

    assign Iop=
    ({op_xori,op_xori,op_xori}&`XOR)|
    ({op_andi,op_andi,op_andi}&`AND)|
    ({op_ori,op_ori,op_ori}&`OR)|
    ({op_addiu,op_addiu,op_addiu}&`ADD)|
    ({op_slti,op_slti,op_slti}&`SLT)|
    ({op_sltiu,op_sltiu,op_sltiu}&`SLTU)
    ;

// (op_lb|op_lbu|op_lh|op_lhu|op_lui|op_lw|op_lwl|op_lwr)
// (op_sb|op_sh|op_sw|op_swl|op_swr)
// (op_ori|op_addiu|op_xori|op_andi)

    // ExtenderControl
    assign ExtenderControl[0]= op_lw;
    assign ExtenderControl[1]= op_lh;
    assign ExtenderControl[2]= op_lhu;
    assign ExtenderControl[3]= op_lb;
    assign ExtenderControl[4]= op_lbu;
    assign ExtenderControl[5]= op_lwl;
    assign ExtenderControl[6]= op_lwr;
    assign ExtenderControl[7]= op_swl;
    assign ExtenderControl[8]= op_swr;
    assign ExtenderControl[9]= op_sb;
    assign ExtenderControl[10]= op_sh;
    assign ExtenderControl[11]= op_lui;
    assign ExtenderControl[12]= op_sw;

    //REGwriteaddrsrc

    always@*
    begin
        if(op_jal)
        begin
            REGwriteaddrsrc=`RegDst_31;
        end
        else
        if(op_j)
        begin
            REGwriteaddrsrc=`RegDst_0;
        end
        else
        begin
            REGwriteaddrsrc=`RegDst_Ins20_16;
        end
    end

endmodule
