module spi_master (
    input  wire        clk,

    output reg         spi_clk = 0,

    input  wire        start, // Pulse high to begin transfer
    input reg [7:0]    data_out = 8'd0,
    output reg         spi_mosi = 0,

    output  wire [7:0]  data_in,
    input  wire        spi_miso,

    output reg         busy = 0,
    output reg         spi_cs = 1 // Active low
);
// SPI Mode 0: CPOL = 0, CPHA = 0 (drive on falling, sample on rising)
reg [3:0] bit_cnt = 0;
reg [7:0] shift_reg_in  = 0;
reg [7:0] shift_reg_out = 0;

typedef enum logic [1:0] {
    IDLE,
    CHIP_SEL,
    BUSY,
    DONE
} state_t;

state_t state = IDLE;

always @(posedge clk) begin
    case (state)
        IDLE: begin
            spi_cs  <= 1;
            spi_clk <= 0;
            busy    <= 0;

            if (start) begin
                state         <= CHIP_SEL;
                shift_reg_out <= data_out;
                bit_cnt       <= 0;
            end
        end

        // data is one cycle after CS is brought low
        CHIP_SEL: begin
            spi_cs  <= 0;
            busy    <= 1;
            state   <= BUSY;
        end

        BUSY: begin
            if (clk) begin
                spi_clk <= ~spi_clk;

                // Falling, drive data
                if (!spi_clk) begin
                    spi_mosi <= shift_reg_out[7];
                    shift_reg_out <= {shift_reg_out[6:0], 1'b0};

                end else begin
                    // Rising, sample data
                    shift_reg_in <= {shift_reg_in[6:0], spi_miso};
                    bit_cnt <= bit_cnt + 1;

                    if (bit_cnt == 7) begin
                        state <= DONE;
                    end
                end
            end
        end

        DONE: begin
            spi_cs   <= 1;
            data_in  <= {shift_reg_in[6:0], spi_miso};
            state    <= IDLE;
        end
    endcase
end

endmodule

