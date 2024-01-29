module adder_subtractor(data_operandA, data_operandB, ctrl_ALUopcode, data_result, overflow);
	
	input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode;
	
	output [31:0] data_result;
	output overflow;
	
	wire[31:0] not_data_operandB, reverse_data_operandB;
	wire[31:0] data_operandB_add;
	wire [31:0] one = 32'b00000000000000000000000000000001;
	wire reverse_out, add_out;
	wire a_sign, b_sign, result_sign, not_a_sign, not_b_sign, not_result_sign;
	wire add_overflow, add_overflow_condition_1, add_overflow_condition_2;
	wire sub_overflow, sub_overflow_condition_1, sub_overflow_condition_2;
	
	generate
	
		genvar i;
		for (i = 0; i < 32; i = i + 1) begin : bit_reverse
			assign not_data_operandB[i] = data_operandB[i] ? 1'b0 : 1'b1;
		end

	endgenerate
	
	carry_select_adder_32bit csa_reverse(not_data_operandB, one, reverse_data_operandB, reverse_out);
	
	assign data_operandB_add = ctrl_ALUopcode ? reverse_data_operandB : data_operandB;
	
	carry_select_adder_32bit csa_add(data_operandA, data_operandB_add, data_result, add_out);
	
	assign a_sign = data_operandA[31];
	assign b_sign = data_operandB[31];
	assign result_sign = data_result[31];
	
	assign not_a_sign = a_sign ? 1'b0 : 1'b1;
	assign not_b_sign = b_sign ? 1'b0 : 1'b1;
	assign not_result_sign = result_sign ? 1'b0 : 1'b1;
	
	and and_add_1(add_overflow_condition_1, a_sign, b_sign, not_result_sign);
	and and_add_2(add_overflow_condition_2, not_a_sign, not_b_sign, result_sign);
	or or_add(add_overflow, add_overflow_condition_1, add_overflow_condition_2);	

	and and_sub_1(sub_overflow_condition_1, a_sign, not_b_sign, not_result_sign);
	and and_sub_2(sub_overflow_condition_2, not_a_sign, b_sign, result_sign);
	or or_sub(sub_overflow, sub_overflow_condition_1, sub_overflow_condition_2);
	
	assign overflow = ctrl_ALUopcode ? sub_overflow : add_overflow;
	
endmodule 