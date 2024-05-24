module TwoSignMag (
	input [7:0] A,
	output [7:0] B,
	output Cout, OVR
);
wire [7:0] C; 
assign OVR = C[6] ^ C[7];

//instantiations
	HalfAdder s0 (A[0]^A[7], A[7], B[0], C[0]); //stage 0
	HalfAdder s1 (A[1]^A[7], C[0], B[1], C[1]); //stage 1
	HalfAdder s2 (A[2]^A[7], C[1], B[2], C[2]); //stage 2
	HalfAdder s3 (A[3]^A[7], C[2], B[3], C[3]); //stage 3
	HalfAdder s4 (A[4]^A[7], C[3], B[4], C[4]); //stage 4
	HalfAdder s5 (A[5]^A[7], C[4], B[5], C[5]); //stage 5
	HalfAdder s6 (A[6]^A[7], C[5], B[6], C[6]); //stage 6
	HalfAdder s7 (A[7]     ,   0 , B[7], C[7]); //stage 7
		assign Cout = C[6];
endmodule 