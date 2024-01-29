module arithmetic_right_shift(data_input, ctrl_shiftamt, data_result);
	
	input[31:0] data_input;
	input[4:0] ctrl_shiftamt;
	
	output[31:0] data_result;
	
	wire[31:0] shift_1, shift_2, shift_3, shift_4;
	
	assign shift_1 = ctrl_shiftamt[0] ? {data_input[31], data_input[31:1]} : data_input;
	assign shift_2 = ctrl_shiftamt[1] ? {{2{data_input[31]}}, shift_1[31:2]} : shift_1;
	assign shift_3 = ctrl_shiftamt[2] ? {{4{data_input[31]}}, shift_2[31:4]} : shift_2;
	assign shift_4 = ctrl_shiftamt[3] ? {{8{data_input[31]}}, shift_3[31:8]} : shift_3;
	assign data_result = ctrl_shiftamt[4] ? {{16{data_input[31]}}, shift_4[31:16]} : shift_4;
		
endmodule 