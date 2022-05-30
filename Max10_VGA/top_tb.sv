`timescale 1 ns / 100 ps

module tb();
	reg clk = 1'b0;
	
	wire v_h_sync;
	wire v_v_sync;
	
	wire [10:0] scan_pos_x;
	wire [10:0] scan_pos_y;
	
	wire [2:0] rgb;

	VGA_Signal_Gen VGA_Signal_Gen_Inst(
		.pixel_clk(clk),
		.scan_x(scan_pos_x),
		.scan_y(scan_pos_y),
		.h_sync(v_h_sync),
		.v_sync(v_v_sync)
	);
	
	VGA_Test_Screen VGA_Test_Screen_Inst(
		.pixel_clk(clk),
		.x(scan_pos_x),
		.y(scan_pos_y),
		.rgb(rgb)
	);
	
	// 25MHz clock
	always #20 clk <= ~clk;
	
	initial begin
		$display($time, " Starting the Simulation");
		#1000
		$finish();
	end
	
endmodule
