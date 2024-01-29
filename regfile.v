module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
	
	wire [31:0] write_decoded, readA_decoded, readB_decoded, register_data[31:0];
	wire writeEnable;
	
	decoder_5to32 decode_write(ctrl_writeReg, write_decoded);
	decoder_5to32 decode_readA(ctrl_readRegA, readA_decoded);
	decoder_5to32 decode_readB(ctrl_readRegB, readB_decoded);
	
	assign writeEnable = ctrl_writeReg ? ctrl_writeEnable : 1'b0;
	
	generate
		genvar i;
		for (i = 0; i < 32; i = i + 1) begin : write_and_read
			register_32bit register(clock, ctrl_reset, writeEnable & write_decoded[i], data_writeReg, register_data[i]);

			assign data_readRegA = readA_decoded[i] ? register_data[i] : 32'bz;
			assign data_readRegB = readB_decoded[i] ? register_data[i] : 32'bz;
		end
	endgenerate
	

endmodule
