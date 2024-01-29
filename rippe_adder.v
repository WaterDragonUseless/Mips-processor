module rippe_adder(a, b, sum, c_out);
	input [3:0] a, b;// Two 4-bit inputs
	output [3:0] sum;
	output c_out;
	wire w1, w2, w3;
	// instantiating 4 1-bit full adders in Verilog
	full_adder u1(a[0], b[0], 1'b0, sum[0], w1);
	full_adder u2(a[1], b[1], w1, sum[1], w2);
	full_adder u3(a[2], b[2], w2, sum[2], w3);
	full_adder u4(a[3], b[3], w3, sum[3], c_out);
endmodule