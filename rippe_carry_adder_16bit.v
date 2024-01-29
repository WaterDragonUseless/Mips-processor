module rippe_carry_adder_16bit(a, b, c_in, sum, c_out);
	input [15:0] a, b;
	input c_in;
	output [15:0] sum;
	output c_out;
	
	wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;
	
	full_adder fa0(a[0], b[0], c_in, sum[0], c1);
	full_adder fa1(a[1], b[1], c1, sum[1], c2);
	full_adder fa2(a[2], b[2], c2, sum[2], c3);
	full_adder fa3(a[3], b[3], c3, sum[3], c4);
	full_adder fa4(a[4], b[4], c4, sum[4], c5);
	full_adder fa5(a[5], b[5], c5, sum[5], c6);
	full_adder fa6(a[6], b[6], c6, sum[6], c7);
	full_adder fa7(a[7], b[7], c7, sum[7], c8);
	full_adder fa8(a[8], b[8], c8, sum[8], c9);
	full_adder fa9(a[9], b[9], c9, sum[9], c10);
	full_adder fa10(a[10], b[10], c10, sum[10], c11);
	full_adder fa11(a[11], b[11], c11, sum[11], c12);
	full_adder fa12(a[12], b[12], c12, sum[12], c13);
	full_adder fa13(a[13], b[13], c13, sum[13], c14);
	full_adder fa14(a[14], b[14], c14, sum[14], c15);
	full_adder fa15(a[15], b[15], c15, sum[15], c_out);

endmodule