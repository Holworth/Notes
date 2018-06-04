`include "define.v"

module alucontrol(
    input R,
    input [5:0]Instruction50,
    output reg[2:0]ALUopAC,
    output reg[3:0]REGwritesrc,
    output reg[2:0]RegDst,
    output shift,
    output enableshifter,
    output reg SpecialJump
    
);

// `define source_ins 1'b0
// `define source_reg 1'b1
assign shift=
    (Instruction50==6'b000100)|
    (Instruction50==6'b000111)|
    (Instruction50==6'b000110);

assign enableshifter=
    (Instruction50==6'b000000)|    
    (Instruction50==6'b000100)|
    (Instruction50==6'b000011)|
    (Instruction50==6'b000111)|
    (Instruction50==6'b000010)|
    (Instruction50==6'b000110);    

always@*
begin
case(Instruction50)
    6'b100001:
    begin //addu
        ALUopAC=`ADD;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
    end
    6'b100100:
    begin //and
        ALUopAC=`AND;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b001001:
    begin //jalr
        ALUopAC=`ADD;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=1;
        
    end
    6'b001000:
    begin //jr
        ALUopAC=`ADD;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_0;
        SpecialJump=1;
        
    end
    6'b001011:
    begin //movn
        ALUopAC=`ADD;
        REGwritesrc=`REGwritesrc_A;
        RegDst=`RegDst_movn;
        SpecialJump=0;
        
    end
    6'b001010:
    begin //movz
        ALUopAC=`ADD;
        REGwritesrc=`REGwritesrc_A;
        RegDst=`RegDst_movz;
        SpecialJump=0;
        
    end
    6'b100111:
    begin //nor
        ALUopAC=`NOR;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b100101:
    begin //or
        ALUopAC=`OR;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b000000:
    begin //sll
        ALUopAC=`left_shift_l;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b000100:
    begin //sllv
        ALUopAC=`left_shift_l;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b101010:
    begin //slt
        ALUopAC=`SLT;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11   ;
        SpecialJump=0;
        
    end
    6'b101011:
    begin //sltu
        ALUopAC=`SLTU;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b000011:
    begin //sra
        ALUopAC=`right_shift_a;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b000111:
    begin //srav
        ALUopAC=`right_shift_a;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b000010:
    begin //srl
        ALUopAC=`right_shift_l;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b000110:
    begin //srlv
        ALUopAC=`right_shift_l;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b100011:
    begin //subu
        ALUopAC=`SUB;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    6'b100110:
    begin //xor
        ALUopAC=`XOR;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0;
        
    end
    default:
    begin //xor
        ALUopAC=`XOR;
        REGwritesrc=`REGwritesrc_ALUout;
        RegDst=`RegDst_Ins15_11;
        SpecialJump=0; 
    end
endcase
end

endmodule