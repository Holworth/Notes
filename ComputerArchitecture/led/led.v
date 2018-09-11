module led(
    input [7:0] switch,
    output [7:0] led
);
    assign led=switch;
endmodule