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
	
	VGA_Controller controller(
		.pixel_clk(pixel_clk),
		.h_sync(hsync_pulse),
		.v_sync(vsync_pulse)
	);

	assign v_sync = gpio_d[12];
	assign h_sync = gpio_d[13];

endmodule
