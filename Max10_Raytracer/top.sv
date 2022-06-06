module top (
	// Main 12M clock
	input logic clk12m,
	// Header GPIO
	inout  logic [14:0] gpio_d,
	// Onboard LEDs
	output logic [8:1] led
);
	wire pixel_clk;
	
	PLL p_clk_pll (clk12m, pixel_clk);
	
	wire [2:0] rgb;

	wire [9:0] hcounter;
	wire [9:0] vcounter;
	
	wire hsync;
	wire vsync;
	
	VGA_Signal_Gen VGA_Signal_Gen_Inst(
		.pixel_clk(pixel_clk),
		.hcounter(hcounter),
		.vcounter(vcounter),
		.hsync(hsync),
		.vsync(vsync)
	);
	
	VGA_Test_Screen VGA_Test_Screen_Inst(
		.pixel_clk(pixel_clk),
		.x(hcounter),
		.y(vcounter),
		.rgb(rgb)
	);
	
	assign gpio_d[14] = hsync;
	assign gpio_d[13] = vsync;
	assign gpio_d[11:9] = rgb;
		
	// OopSS, need a fake ground pin here
	assign gpio_d[6] = 0;

	assign led[1] = vsync;
	
endmodule
