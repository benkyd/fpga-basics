module VGA_Test_Screen(
	input wire pixel_clk,
	input wire [10:0] x,
	input wire [10:0] y,
	output wire [2:0] rgb
);

	always @(posedge pixel_clk) begin
		rgb[2:2] = 1;
	end
	
endmodule
