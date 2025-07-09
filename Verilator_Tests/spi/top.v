module top (
    input wire clk_25mhz,

    output wire spi_clk,
    output wire spi_mosi,
    input wire spi_miso,
    output wire spi_cs
);

reg[7:0] miso;
reg[7:0] mosi = 8'b01101011;

spi_master spimaster0(
    .clk_25mhz(clk_25mhz),
    .spi_clk(spi_clk),
    .data_in(mosi),
    .spi_miso(spi_miso),
    .data_out(mosi),
    .spi_mosi(spi_mosi),
    .spi_cs(spi_cs)
);

endmodule


module spi_master (
    input wire clk_25mhz,

    output reg spi_clk = 0,

    output reg[7:0] data_in,
    output reg spi_miso = 0,

    input reg[7:0] data_out,
    input reg spi_mosi = 0,

    output wire spi_cs
);


assign spi_cs = 0;  // Always selected (for test)

reg [7:0] mosi_shift = 8'b01101011;  // Example byte
reg [3:0] bit_counter = 0;
reg spi_clk_en = 1;

localparam TRANSFERRING = 0, IDLE = 1;
wire spi_state = IDLE;

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

