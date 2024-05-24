module AU 
(
  input reset, LoadA, LoadB, LoadR, ADDSUB, 
  input[7:0] BIT_Input,
  output OVR, Cout,
  output[7:0] result
  //output[6:0] HEX0, HEX1, Bout, Bout1, HEX4, HEX5 
  //output[7:0] result, A_OUT, B_OUT 
  );
  wire [7:0] Rout, A_OUT, B_OUT;
  
//Instantiations 
	register RegisterA    //takes in input A
	(
		.D(BIT_Input) ,	// input [N-1:0] D_sig
		.CLK(~LoadA) ,	// input  CLK_sig
		.CLR(reset) ,	// input  CLR_sig
		.Q(A_OUT) 	// output [N-1:0] Q_sig
	);

	register RegisterB   //takes in input B
	(
		.D(BIT_Input) ,// input [N-1:0] Data
		.CLK(~LoadB) ,	// input  CLK_sig
		.CLR(reset) ,	// input  CLR_sig
		.Q(B_OUT) 	// output [N-1:0] Q_sig
	);
	
	TwosComplement AdderSubtracter
	(
		.A(A_OUT) ,	// input [7:0] A_sig
		.B(B_OUT) ,	// input [7:0] B_sig
		.C0(ADDSUB) ,	// input  C0_sig   
		.R(Rout) ,	// output [7:0] R_sig
		.Cout(Cout) ,	// output  Cout_sig
		.OVR(OVR) 	// output  OVR_sig
	);

	register RegisterR	
	(
		.D(Rout) ,	// input [N-1:0] D_sig
		.CLK(~LoadR) ,	// input  CLK_sig
		.CLR(reset) ,	// input  CLR_sig
		.Q(result) 	// output [N-1:0] Q_sig
	);
/*	
	SevenToHex SevenToHex0     //
	(
		.w(RegAout[3]) ,	// input  w_sig
		.x(RegAout[2]) ,	// input  x_sig
		.y(RegAout[1]) ,	// input  y_sig
		.z(RegAout[0]) ,	// input  z_sig
		.a(HEX0[0]) ,	// output  a_sig
		.b(HEX0[1]) ,	// output  b_sig
		.c(HEX0[2]) ,	// output  c_sig
		.d(HEX0[3]) ,	// output  d_sig
		.e(HEX0[4]) ,	// output  e_sig
		.f(HEX0[5]) ,	// output  f_sig
		.g(HEX0[6]) 	// output  g_sig
	);
	
	SevenToHex SevenToHex1
	(
		.w(RegAout[7]) ,	// input  w_sig
		.x(RegAout[6]) ,	// input  x_sig
		.y(RegAout[5]) ,	// input  y_sig
		.z(RegAout[4]) ,	// input  z_sig
		.a(HEX1[0]) ,	// output  a_sig
		.b(HEX1[1]) ,	// output  b_sig
		.c(HEX1[2]) ,	// output  c_sig
		.d(HEX1[3]) ,	// output  d_sig
		.e(HEX1[4]) ,	// output  e_sig
		.f(HEX1[5]) ,	// output  f_sig
		.g(HEX1[6]) 	// output  g_sig
	);

	
	SevenToHex SevenToHex2
	(
		.w(RegBout[7]) ,	// input  w_sig
		.x(RegBout[6]) ,	// input  x_sig
		.y(RegBout[5]) ,	// input  y_sig
		.z(RegBout[4]) ,	// input  z_sig
		.a(Bout[0]) ,	// output  a_sig
		.b(Bout[1]) ,	// output  b_sig
		.c(Bout[2]) ,	// output  c_sig
		.d(Bout[3]) ,	// output  d_sig
		.e(Bout[4]) ,	// output  e_sig
		.f(Bout[5]) ,	// output  f_sig
		.g(Bout[6]) 	// output  g_sig
	);
	
	SevenToHex SevenToHex3
	(
		.w(RegBout[3]) ,	// input  w_sig
		.x(RegBout[2]) ,	// input  x_sig
		.y(RegBout[1]) ,	// input  y_sig
		.z(RegBout[0]) ,	// input  z_sig
		.a(Bout1[0]) ,	// output  a_sig
		.b(Bout1[1]) ,	// output  b_sig
		.c(Bout1[2]) ,	// output  c_sig
		.d(Bout1[3]) ,	// output  d_sig
		.e(Bout1[4]) ,	// output  e_sig
		.f(Bout1[5]) ,	// output  f_sig
		.g(Bout1[6]) 	// output  g_sig
	);

	SevenToHex SevenToHex4
	(
		.w(result[7]) ,	// input  w_sig
		.x(result[6]) ,	// input  x_sig
		.y(result[5]) ,	// input  y_sig
		.z(result[4]) ,	// input  z_sig
		.a(HEX4[0]) ,	// output  a_sig
		.b(HEX4[1]) ,	// output  b_sig
		.c(HEX4[2]) ,	// output  c_sig
		.d(HEX4[3]) ,	// output  d_sig
		.e(HEX4[4]) ,	// output  e_sig
		.f(HEX4[5]) ,	// output  f_sig
		.g(HEX4[6]) 	// output  g_sig
	);
	
	SevenToHex SevenToHex5
	(
		.w(result[3]) ,	// input  w_sig
		.x(result[2]) ,	// input  x_sig
		.y(result[1]) ,	// input  y_sig
		.z(result[0]) ,	// input  z_sig
		.a(HEX5[0]) ,	// output  a_sig
		.b(HEX5[1]) ,	// output  b_sig
		.c(HEX5[2]) ,	// output  c_sig
		.d(HEX5[3]) ,	// output  d_sig
		.e(HEX5[4]) ,	// output  e_sig
		.f(HEX5[5]) ,	// output  f_sig
		.g(HEX5[6]) 	// output  g_sig
	);
*/

endmodule 