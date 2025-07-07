module top (
    input clk_25mhz,
    output [3:0] led
);
    assign led[0] = clk_25mhz;
endmodule
