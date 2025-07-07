`timescale 1ns / 1ps

module top_tb;

    reg clk_25mhz = 0;
    wire [3:0] led;

    top uut (
        .clk_25mhz(clk_25mhz),
        .led(led)
    );

    always #20 clk_25mhz = ~clk_25mhz;

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        #500 $finish;
    end

endmodule
