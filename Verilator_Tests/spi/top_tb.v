// Copyright 2025 Benjamin Kyd, All Rights Reserved

`timescale 1ns / 1ps

module top_tb;

    reg clk_25mhz = 0;
    reg spi_clk, spi_mosi, spi_miso, spi_cs;

    top uut (
        .clk_25mhz(clk_25mhz),
        .spi_clk(spi_clk),
        .spi_mosi(spi_mosi),
        .spi_miso(spi_miso),
        .spi_cs(spi_cs)
    );

    always #20 clk_25mhz = ~clk_25mhz;

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        #500 $finish;
    end

endmodule
