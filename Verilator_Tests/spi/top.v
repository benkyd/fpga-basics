module top (
    input wire  clk_25mhz,

    output wire spi_clk,
    output wire spi_mosi,
    input wire  spi_miso,
    output wire spi_cs
);

// we would prefer fifo
wire[7:0] miso;
wire[7:0] mosi = 8'b01101011;

reg busy = 0;
reg start = 0;

always @(posedge clk_25mhz) begin
        start <= 0;
    if (!busy && !start) begin
        start <= 1;
    end
end

spi_master spimaster0(
    .clk(clk_25mhz),
    .spi_clk(spi_clk),
    .start(start),
    .data_out(mosi),
    .spi_mosi(spi_mosi),
    .data_in(miso),
    .spi_miso(spi_miso),
    .busy(busy),
    .spi_cs(spi_cs)
);

endmodule
