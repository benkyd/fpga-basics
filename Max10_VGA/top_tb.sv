`timescale 1 ns / 100 ps

module tb();
	reg clk = 1'b0;
	
	wire v_h_sync;
	wire v_v_sync;
	
	VGA_Controller VGA_Controller_Inst(
		.pixel_clk(clk),
		.h_sync(v_h_sync),
		.v_sync(v_v_sync)
	);

	// 25MHz clock
	always #5 clk <= ~clk;
	
	initial begin
		$display($time, " Starting the Simulation");
		#1000
		$finish();
	end
	
endmodule
