module top (
	// Main 12M clock
	input logic clk12m,

	// Accelerometer
	output logic acc_sclk,
	output logic acc_mosi,
	input  logic acc_miso,
	output logic acc_cs,
	input  logic acc_int1,
	input  logic acc_int2,

	// Onboard button
	input  logic btn,

	// Header GPIO
	inout  logic [14:0] gpio_d,
	input  logic  [7:0] gpio_a,

	// Onboard LEDs
	output logic  [8:1] led,

	// PMOD header
	inout  logic  [8:1] pmod,

	// Onboard RAM
	output logic        ram_clk,
	inout  logic [15:0] ram_data,
	output logic [13:0] ram_addr,
	output logic  [1:0] ram_dqm,
	output logic  [1:0] ram_bs,
	output logic        ram_cke,
	output logic        ram_ras,
	output logic        ram_cas,
	output logic        ram_we,
	output logic        ram_cs
);

	wire pixel_clk;
	
	PLL p_clk_pll (clk12m, pixel_clk);
	
	wire h_sync, v_sync;
	assign gpio_d[13] = h_sync;
	assign gpio_d[12] = v_sync;
	
	reg [9:0] h_counter;
	reg [9:0] v_counter;
	
	// VGA 640 x 480 @ 60 Hz
	// pixel_clk 25.175MHz
	always @(posedge pixel_clk) begin
		if (h_counter < 799) begin
			h_counter <= h_counter + 1;
		end else begin
			// reset scanline
			h_counter <= 1'b0;
			
			// step v_counter after hline
			if (v_counter < 524) begin
				v_counter <= v_counter + 1;
			end else begin
				v_counter <= 1'b0;
			end
		end
	end
	
	// generate sync pulses
	assign h_sync = (h_counter < 96) ? 1'b1 : 1'b0;
	assign v_sync = (v_counter < 2) ? 1'b1 : 1'b0;
	
	assign led[1] = h_sync;
	assign led[2] = v_sync;
	assign led[3] = pixel_clk;
	assign led[8:4] = v_counter;

endmodule
