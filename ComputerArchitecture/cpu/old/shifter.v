//shifter.v

`timescale 10ns / 1ns

`include "define.v"

module shifter(
    input [2:0]shiftmode,
    input source,
    input [4:0]shiftbit,
    input [31:0]reg_shiftbit,
    input [31:0]shifter_input,
    output reg [31:0]shifter_output
);

// `define source_ins 1'b0
// `define source_reg 1'b1
wire [4:0]realshiftbit=((source==`source_ins)?shiftbit:reg_shiftbit);
wire [63:0]startwith0={32'h0,shifter_input};
wire [63:0]startwith1={32'hffffffff,shifter_input};

always@*
begin
    case(shiftmode)
        `left_shift_a:
        begin
            shifter_output=shifter_input<<realshiftbit;
        end
        `left_shift_l:
        begin
            shifter_output=shifter_input<<realshiftbit;
        end
        `right_shift_a:
        begin
            //shifter_output=shifter_input>>>;
            //ERROR >>>不被支持
            //桶形移位器

            shifter_output=(shifter_input[31])?startwith1[realshiftbit+31-:32]:startwith0[realshiftbit+31-:32];
            //ref:  https://stackoverflow.com/questions/7543592/verilog-barrel-shifter
        end
        `right_shift_l:
        begin
            shifter_output=startwith0[realshiftbit+31-:32];
            //verilog: 逻辑右移 >>            
        end
        default:
        begin
            shifter_output=shifter_input<<realshiftbit;
        end
    endcase
end

endmodule