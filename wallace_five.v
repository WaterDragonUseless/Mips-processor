module wallace_five(a, b, result);
	input[4:0] a, b;
	output[9:0] result;
	
	wire s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27;
	wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27;
	wire[4:0] p0, p1, p2, p3, p4;
	
	assign p0 = a & {5{b[0]}};
	assign p1 = a & {5{b[1]}};
	assign p2 = a & {5{b[2]}};
	assign p3 = a & {5{b[3]}};
	assign p4 = a & {5{b[4]}};
	
	// First Stage
	half_adder h1(p0[1], p1[0], s1, c1);
	full_adder f1(p0[2], p1[1], p2[0], s2, c2);
	full_adder f2(p1[2], p2[1], p3[0], s3, c3);
	full_adder f3(p2[2], p3[1], p4[0], s4, c4);
	full_adder f4(p2[3], p3[2], p4[1], s5, c5);
	full_adder f5(p2[4], p3[3], p4[2], s6, c6);
	half_adder f6(p3[4], p4[3], s7, c7);
	
	// Second Stage
	half_adder h2(s2, c1, s8, c8);
	full_adder f7(s3, c2, p0[3], s9, c9);
	full_adder f8(c3, p0[4], p1[3], s10, c10);
	full_adder f9(s5, c4, p1[4], s11, c11);
	full_adder f10(s6, c5, c11, s12, c12);
	full_adder f11(s7, c6, c12, s13, c13);
	full_adder f12(p4[4], c7, c13, s14, c14);
	
	// Third Stage
	half_adder h3(s9, c8, s15, c15);
	full_adder f13(s4, s10, c9, s16, c16);
	full_adder f14(s11, c10, c16, s17, c17);
	half_adder h4(s12, c17, s18, c18);
	half_adder h5(s13, c18, s19, c19);
	half_adder h6(s14, c19, s20, c20);
	half_adder h7(c14, c20, s21, c21);
	
	// Forth Stage
	half_adder h8(s16, c15, s22, c22);
	half_adder h9(s17, c22, s23, c23);
	half_adder h10(s18, c23, s24, c24);
	half_adder h11(s19, c24, s25, c25);
	half_adder h12(s20, c25, s26, c26);
	half_adder h13(s21, c26, s27, c27);
	half_adder h14(c21, c27, s28, c28);
	
	// Result
	assign result[0] = p0[0];
	assign result[1] = s1;
	assign result[2] = s8;
	assign result[3] = s15;
	assign result[4] = s22;
	assign result[5] = s23;
	assign result[6] = s24;
	assign result[7] = s25;
	assign result[8] = s26;
	assign result[9] = s27;
endmodule 