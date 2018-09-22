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

endmodule