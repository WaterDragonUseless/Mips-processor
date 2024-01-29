module half_adder(a, b, sum, c_out);
	input a, b;
	output sum, c_out;
	wire w1, w2, w3, w4, w5;
	
	xor G1(sum, a, b);
	and G2(c_out, a, b);
endmodule	