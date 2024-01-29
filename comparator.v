module comparator(a, b, res);
	input [4:0] a, b;
	output res;

	wire [4:0] w;

	xnor(w[0], a[0], b[0]);
	xnor(w[1], a[1], b[1]);
	xnor(w[2], a[2], b[2]);
	xnor(w[3], a[3], b[3]);
	xnor(w[4], a[4], b[4]);

	and(res, w[0], w[1], w[2], w[3], w[4]);
endmodule 