module VGA_Signal_Gen
 #(parameter TOTAL_COLS  = 800, 
   parameter TOTAL_ROWS  = 525,
   parameter ACTIVE_COLS = 640, 
   parameter ACTIVE_ROWS = 480)(
	input wire pixel_clk,
	output wire [10:0] scan_x,
	output wire [10:0] scan_y,
	output wire h_sync,
	output wire v_sync
);
	
	reg [9:0] h_counter;
	reg [9:0] v_counter;
	
	// VGA 640 x 480 @ 60 Hz
	// pixel_clk 25.175MHz
	always @(posedge pixel_clk) begin
		if (h_counter <= 800) begin
			h_counter <= h_counter + 1;
		end else begin
			// reset scanline
			h_counter <= 1'b0;
			
			// step v_counter after hline
			if (v_counter <= 525) begin
				v_counter <= v_counter + 1;
			end else begin
				v_counter <= 1'b0;
			end
		end
	end
	
	// generate sync pulses
	assign h_sync = ~(h_counter <= 96);
	assign v_sync = ~(v_counter <= 2);
	
	assign scan_x = h_counter + 48;
	assign scan_y = v_counter + 33;

endmodule
