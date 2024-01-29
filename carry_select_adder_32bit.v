module carry_select_adder_32bit(a, b, sum, c_out);
	input[31:0] a, b;
	output[31:0] sum;
	output c_out;
	
	wire c1, c2, c3;
	wire[15:0] sum1, sum2;
	
	rippe_carry_adder_16bit rca1(a[15:0], b[15:0], 1'b0, sum[15:0], c1);
	
	rippe_carry_adder_16bit rca2(a[31:16], b[31:16], 1'b0, sum1, c2);
	rippe_carry_adder_16bit rca3(a[31:16], b[31:16], 1'b1, sum2, c3);
	
	assign sum[31:16] = (c1) ? sum2 : sum1;
	assign c_out = (c1) ? c3 : c2;
endmodule 