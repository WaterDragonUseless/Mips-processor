/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 wire[4:0] op = q_imem[31:27];
	 wire[4:0] rd = q_imem[26:22];
	 wire[4:0] rs = q_imem[21:17];
	 wire[4:0] rt = q_imem[16:12];
	 wire[4:0] shamt = q_imem[11:7];
	 
	 wire[16:0] immediate = q_imem[16:0];
	 
	 wire[26:0] target = q_imem[26:0];
	 
	 wire[21:0] zeroes = q_imem[21:0];
	 
	 wire normalr_op, addi_op, sw_op, lw_op;
	 wire isNotEqual, isLessThan, overflow, c_out, c_out_bne;
	 wire normal_add_op, normal_sub_op;
	 wire j_op, bne_op, jal_op, jr_op, blt_op;
	 wire bex_op, setx_op;
	 wire[31:0] pc, pc_add_res, b_pc, pc_res;
	 wire[11:0] immed_12bits;
	 wire[31:0] immed_32bits, target_32bits, alu_input_A, alu_input_B, alu_output;
	 
	 comparator is_normalr(op, 5'b00000, normalr_op);
	 comparator is_addi(op, 5'b00101, addi_op);
	 comparator is_sw(op, 5'b00111, sw_op);
	 comparator is_lw(op, 5'b01000, lw_op);
	 
	 comparator is_j(op, 5'b00001, j_op);
	 comparator is_bne(op, 5'b00010, bne_op);		//rd != rs, pc + n + 1
	 comparator is_jal(op, 5'b00011, jal_op);		//r31 = PC + 1, PC = T
	 comparator is_jr(op, 5'b00100, jr_op);		//r31 = PC
	 comparator is_blt(op, 5'b00110, blt_op);		//rd < rs, pc + n + 1
	 comparator is_bex(op, 5'b10110, bex_op);		//r30 != 0, PC = T
	 comparator is_setx(op, 5'b10101, setx_op);	//r30 = T
	 
	 wire[4:0] alu_op = normalr_op ? q_imem[6:2] : 5'b00000;
	 
	 comparator is_normal_add(alu_op, 5'b00000, normal_add_op);
	 comparator is_normal_sub(alu_op, 5'b00001, normal_sub_op);
	 
	 assign wren = sw_op;
	 assign ctrl_writeEnable = (~sw_op) & (~j_op) & (~bne_op) & (~jr_op) & (~blt_op) & (~bex_op);
	 
	 assign immed_32bits = {{15{immediate[16]}}, immediate};
	 assign target_32bits = {{5{1'b0}}, target};
	 
	 assign alu_input_A = bex_op ? 32'b0 : data_readRegA;
	 assign alu_input_B = (normalr_op | blt_op | bne_op | bex_op) ? data_readRegB : immed_32bits;
	 
	 alu alu_operation(alu_input_A, alu_input_B, alu_op, shamt, alu_output, isNotEqual, isLessThan, overflow);
	 
	 assign ctrl_readRegA = rs;
	 assign ctrl_readRegB = bex_op ? 5'b11110 : (normalr_op ? rt : rd);  //r30 != 0
	 assign ctrl_writeReg = setx_op ? 5'b11110 : (jal_op ? 5'b11111 : (overflow ? 5'b11110 : rd));//jal, set ,ovf, write to a specific reg30/31
	 
	 assign data = data_readRegB;
	 assign address_dmem = alu_output[11:0];
	 
	 ripple_carry_adder_32bit add1(pc, 32'b1, 1'b0, pc_add_res, c_out);//pc = pc + 1
	 
	 ripple_carry_adder_32bit add_pc(immed_32bits, pc_add_res, 1'b0, b_pc, c_out_bne);//b_pc = b_pc + immediate
	 
	 assign pc_res = 
    (bex_op & isNotEqual) ? immed_32bits : 
    (jal_op ? immed_32bits : 
    (((~isLessThan) & isNotEqual & blt_op) ? b_pc : 
    (jr_op ? data_readRegB : 
    (j_op ? immed_32bits : 
    ((bne_op & isNotEqual) ? b_pc : pc_add_res)
    ))));
	 
	 generate
	
		genvar i;
		for (i = 0; i < 32; i = i + 1) begin : dffe_32
			dffe_ref dffe(pc[i], pc_res[i], clock, 1'b1, reset);
		end
		
	 endgenerate
	 
	 assign data_writeReg = 
    setx_op ? target_32bits : 
    (jal_op ? pc_add_res : 
    (overflow ? 
        (~normalr_op ? 32'd2 : 
        (normal_add_op ? 32'd1 : 
        (normal_sub_op ? 32'd3 : 
        (lw_op ? q_dmem : alu_output)
        ))) : 
    (lw_op ? q_dmem : alu_output)
    ));
	 
	 assign address_imem = pc[11:0];
	 	 
endmodule