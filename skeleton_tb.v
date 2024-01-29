`timescale 1 ns / 100 ps
module skeleton_tb ();
	
	reg  clock;
	reg  reset;
	wire imem_clock, dmem_clock, processor_clock, regfile_clock;
	
	skeleton test (clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock);
	
	initial
	begin
		clock = 0;
		reset = 0;
		
		#10  reset = 1;
		#50 reset = 0;
		
		#20000 $stop;
		
	end
	
	always #10 clock = ~clock;
	
endmodule 
