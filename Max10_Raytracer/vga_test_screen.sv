module VGA_Test_Screen(
	input wire pixel_clk,
	input reg [10:0] x,
	input reg [10:0] y,
	output reg [2:0] rgb
);

	always @ (posedge pixel_clk) begin
	
		 if (x < 80 && y < 480)
			rgb <= 3'b111;
		 else if (x < 160 && y < 480)
			rgb <= 3'b110;
		 else if (x < 240 && y < 480)
			rgb <= 3'b101;
		 else if (x < 320 && y < 480)
			rgb <= 3'b100;
		 else if (x < 400 && y < 480)
			rgb <= 3'b011;
		 else if (x < 480 && y < 480)
			rgb <= 3'b010;
		 else if (x < 560 && y < 480)
		 	rgb <= 3'b001;
		 else if (x < 640 && y < 480)
			rgb <= 3'b000;
		 else 
			rgb <= 3'b000;
			
	end 
	
endmodule
