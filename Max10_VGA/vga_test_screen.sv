module VGA_Test_Screen(
	input wire pixel_clk,
	input wire [10:0] x,
	input wire [10:0] y,
	output reg [2:0] rgb
);


	always @(posedge pixel_clk) begin
		if (x > 20) begin
			rgb[1] <= 1;
		end
	end
	
endmodule
