module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire add_operation, sub_operation, and_operation, or_operation, sll_operation, sra_operation;
	
	wire [31:0] sll_result, sra_result, add_sub_result, and_result, or_result;
	wire add_sub_overflow, overflow_sub;
	
	wire [31:0] ab_sub, equal_temp;
	
	adder_subtractor sub(data_operandA, data_operandB, 5'b00001, ab_sub, overflow_sub);
	
	assign isLessThan = overflow_sub ? ~ab_sub[31] : ab_sub[31];
	
	generate
		genvar i;
		assign equal_temp[0] = ab_sub[0];
		for (i = 1; i < 32; i = i + 1) begin : zero_check
			or or_gate(equal_temp[i], equal_temp[i-1], ab_sub[i]);
		end
	endgenerate
	
	assign isNotEqual = overflow_sub ? overflow_sub : equal_temp[31];
	
	comparator is_add(ctrl_ALUopcode, 5'b00000, add_operation);
	comparator is_sub(ctrl_ALUopcode, 5'b00001, sub_operation);
	comparator is_and(ctrl_ALUopcode, 5'b00010, and_operation);
	comparator is_or(ctrl_ALUopcode, 5'b00011, or_operation);
	comparator is_sll(ctrl_ALUopcode, 5'b00100, sll_operation);
	comparator is_sra(ctrl_ALUopcode, 5'b00101, sra_operation);
	
	adder_subtractor add_sub(data_operandA, data_operandB, ctrl_ALUopcode, add_sub_result, add_sub_overflow);
	and_gate and_gate(data_operandA, data_operandB, and_result);
	or_gate or_gate(data_operandA, data_operandB, or_result);
	logical_left_shift sll_gate(data_operandA, ctrl_shiftamt, sll_result);
	arithmetic_right_shift sra_gate(data_operandA, ctrl_shiftamt, sra_result);
	
	assign data_result = add_operation ? add_sub_result :
                      sub_operation ? add_sub_result :
                      and_operation ? and_result :
                      or_operation ? or_result :
                      sll_operation ? sll_result : 
                      sra_operation ? sra_result : 32'b00000000000000000000000000000001;
	
	assign overflow = add_operation ? add_sub_overflow :
							sub_operation ? add_sub_overflow : 1'b0;

endmodule
