module logical_left_shift(data_input, ctrl_shiftamt, data_result);
	
	input[31:0] data_input;
	input[4:0] ctrl_shiftamt;
	
	output[31:0] data_result;
	
	wire[31:0] shift_1, shift_2, shift_3, shift_4;
	
	assign shift_1 = ctrl_shiftamt[0] ? {data_input[30:0], 1'b0} : data_input;
	assign shift_2 = ctrl_shiftamt[1] ? {shift_1[29:0], {2{1'b0}}} : shift_1;
	assign shift_3 = ctrl_shiftamt[2] ? {shift_2[27:0], 4'b0000} : shift_2;
	assign shift_4 = ctrl_shiftamt[3] ? {shift_3[23:0], 8'b00000000} : shift_3;
	assign data_result = ctrl_shiftamt[4] ? {shift_4[15:0], 16'b0000000000000000} : shift_4;
	
endmodule 