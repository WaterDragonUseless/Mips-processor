// set the timescale change
`timescale 1 ns / 100 ps
module wallace_five_tb(); // testbenches take no arguments
	// set up inputs as registers so they can be manipulated at will
	reg [4:0]in1;
	reg [4:0]in2;
	
	// clocks are useful for testbenches because they allow you to check your
	// circuit at regular intervals large enough for signals to propogate
	reg clock;
	
	// set up output as wire
	wire [9:0] out;
	
	// prepare any other variables you want - nothing is off-limits in a TB
	integer num_errors;
	
	// instantiate the WTM
	wallace_five test_WTM (in1, in2, out);
	
	// begin simulation
	initial begin
	$display($time, " simulation start");
	
	clock =1'b0;
	
	@(negedge clock);
	in1 = 5'd0; //5'b00000
	in2 = 5'd20; // 5'b10100
	
	@(negedge clock); // wait for the clock to go negative
	in1 = 5'd25; //5'b11001
	in2 = 5'd16; //5'b10000
	
	@(negedge clock); // wait for the clock to go negative
	in1 = 5'd31; //5'b11111
	in2 = 5'd1; //5'b00001
	
	@(negedge clock); // wait for the clock to go negative
	in1 = 5'd21; //5'b10101
	in2 = 5'd27; //5'b11011
	
	@(negedge clock); // wait for the clock to go negative
	in1 = 5'd17; //5'b10001
	in2 = 5'd19; //5'b00011
	
	@(negedge clock);
	$stop;
	end
	
	always
	#10 clock = ~clock; // toggle clock every 10 timescale units
endmodule