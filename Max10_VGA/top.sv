module top (
	// Main 12M clock
	input logic clk12m,
	// Header GPIO
	inout  logic [14:0] gpio_d,
	// Onboard LEDs
	output logic  [8:1] led
);
	wire pixel_clk;
	
	PLL p_clk_pll (clk12m, pixel_clk);
	
	wire vsync_pulse, hsync_pulse;
	
	wire [10:0] scan_pos_x;
	wire [10:0] scan_pos_y;
	
	wire [2:0] rgb;

	VGA_Signal_Gen VGA_Signal_Gen_Inst(
		.pixel_clk(pixel_clk),
		.scan_x(scan_pos_x),
		.scan_y(scan_pos_y),
		.h_sync(hsync_pulse),
		.v_sync(vsync_pulse)
	);
	
	VGA_Test_Screen VGA_Test_Screen_Inst(
		.pixel_clk(pixel_clk),
		.x(scan_pos_x),
		.y(scan_pos_y),
		.rgb(rgb)
	);
	
	assign gpio_d[14] = hsync_pulse;
	assign gpio_d[13] = vsync_pulse;
	
	assign gpio_d[11:9] = rgb;
	
	// OopSS, need a fake ground pin here
	assign gpio_d[6] = 0;

	assign led[1] = 1;
	
endmodule
