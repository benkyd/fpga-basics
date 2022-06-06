module VGA_Signal_Gen(
	input wire pixel_clk,
	output reg [9:0] hcounter,
	output reg [9:0] vcounter,
	output wire hsync,
	output wire vsync
);
	
	always @(posedge pixel_clk) begin
		if(hcounter == 799) begin
			
		hcounter <= 0;
			
		if(vcounter == 524)
			vcounter <= 0;
		else 
			vcounter <= vcounter + 1'b1;
		 
		end
		else
			hcounter <= hcounter + 1'b1;
	 
		if (vcounter >= 490 && vcounter < 492) 
			vsync <= 1'b0;
		else
			vsync <= 1'b1;

		if (hcounter >= 656 && hcounter < 752) 
			hsync <= 1'b0;
		else
			hsync <= 1'b1;
	end

endmodule
