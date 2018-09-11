module led_tb();
    reg [7:0] switch;
    wire [7:0] led;

    led uut(
        .switch(switch),
        .led(led)
    );

    initial begin
        switch=8'h0;
        #100;
    end

    always #10 begin
        switch={$random}%256;
    end 

endmodule