module top (
    input wire clk_25mhz,

    output reg spi_clk = 0,

    output reg spi_mosi = 0,
    input reg spi_miso = 0,

    output wire spi_cs
);

assign spi_cs = 0;  // Always selected (for test)

reg [7:0] mosi_shift = 8'b01101011;  // Example byte
reg [3:0] bit_counter = 0;
reg spi_clk_en = 0;

always_ff @(posedge clk_25mhz) begin
    spi_clk <= ~spi_clk;

    if (spi_clk == 0) begin
        // Falling edge: shift data
        spi_mosi <= mosi_shift[7];
        mosi_shift <= {mosi_shift[6:0], 1'b0};
        bit_counter <= bit_counter + 1;
    end
end

endmodule
