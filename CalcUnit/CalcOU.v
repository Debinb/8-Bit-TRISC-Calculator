module CalcOU
(
 input CLK, Reset, LoadOU,
	input [7:0] testout,
	output [0:6] hex0, hex1, hex2, hex3
);
	
	wire [7:0] SignedOut;
	wire [3:0] ONES, TENS;
	wire [1:0] HUNDREDS;
	
	//Instantiations	
	TwoSignMag TwoSignMag_inst
	(
		.A(testout) ,	// input [7:0] A_sig
		.B(SignedOut) ,	// output [7:0] B_sig
		.Cout() ,	// output  Cout_sig
		.OVR() 	// output  OVR_sig
	);
	
	binary2bcd Binary_To_BCD
	(
		.A({1'b0,SignedOut[6:0]}) ,	// input [7:0] A_sig
		.ONES(ONES) ,	// output [3:0] ONES_sig
		.TENS(TENS) ,	// output [3:0] TENS_sig
		.HUNDREDS(HUNDREDS) 	// output [1:0] HUNDREDS_sig
	);

	Binary2Seven HEX_0
	(
		.w(ONES[3]) ,	// input  w_sig
		.x(ONES[2]) ,	// input  x_sig
		.y(ONES[1]) ,	// input  y_sig
		.z(ONES[0]) ,	// input  z_sig
		.a(hex0[0]) ,	// output  a_sig
		.b(hex0[1]) ,	// output  b_sig
		.c(hex0[2]) ,	// output  c_sig
		.d(hex0[3]) ,	// output  d_sig
		.e(hex0[4]) ,	// output  e_sig
		.f(hex0[5]) ,	// output  f_sig
		.g(hex0[6]) 	// output  g_sig
	);

	Binary2Seven HEX_1
	(
		.w(TENS[3]) ,	// input  w_sig
		.x(TENS[2]) ,	// input  x_sig
		.y(TENS[1]) ,	// input  y_sig
		.z(TENS[0]) ,	// input  z_sig
		.a(hex1[0]) ,	// output  a_sig
		.b(hex1[1]) ,	// output  b_sig
		.c(hex1[2]) ,	// output  c_sig
		.d(hex1[3]) ,	// output  d_sig
		.e(hex1[4]) ,	// output  e_sig
		.f(hex1[5]) ,	// output  f_sig
		.g(hex1[6]) 	// output  g_sig
	);

	Binary2Seven HEX_2
	(
		.w(0) ,	// input  w_sig
		.x(0) ,	// input  x_sig
		.y(HUNDREDS[1]) ,	// input  y_sig
		.z(HUNDREDS[0]) ,	// input  z_sig
		.a(hex2[0]) ,	// output  a_sig
		.b(hex2[1]) ,	// output  b_sig
		.c(hex2[2]) ,	// output  c_sig
		.d(hex2[3]) ,	// output  d_sig
		.e(hex2[4]) ,	// output  e_sig
		.f(hex2[5]) ,	// output  f_sig
		.g(hex2[6]) 	// output  g_sig
	);

	assign hex3 = SignedOut[7] ? 7'b1111110 : 7'b1111111;

endmodule 