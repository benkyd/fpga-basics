// Copyright 2025 Benjamin Kyd, All Rights Reserved

`timescale 1ns / 1ps

module top_tb;

    reg clk_25mhz = 0;

    wire h_sync, v_sync;

    wire [3:0] r;
    wire [3:0] g;
    wire [3:0] b;

    top uut (
        .clk_25mhz(clk_25mhz),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .r(r),
        .g(g),
        .b(b)
    );

    always #20 clk_25mhz = ~clk_25mhz;

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        #500 $finish;
    end

endmodule
