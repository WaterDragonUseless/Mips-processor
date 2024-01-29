module decoder_5to32(in, out);


	input [4:0] in;
	output [31:0] out;

	generate
		genvar i;
		for (i = 0; i < 32; i = i + 1) begin : decoder_loop
			assign out[i] = (~(in[0] ^ i[0])) & (~(in[1] ^ i[1])) & (~(in[2] ^ i[2])) & (~(in[3] ^ i[3])) & (~(in[4] ^ i[4]));
		end
	endgenerate
	
endmodule 