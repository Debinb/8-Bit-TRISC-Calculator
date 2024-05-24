//Ripple Carry Adder Structural Model
module TwosComplement (    //name the module
	input [7:0] A, B,  //declare input ports
	input C0,
	output [7:0] R, //declare output ports for sum
	output Cout, OVR); //declare carry-out port
	wire [8:0] C; //declare internal nets
		assign C[0] = C0; //assign 0 to least significant carry-in
		assign OVR = C[8] ^ C[7];
		
//instantiate the full adder module for each stage of the ripple carry adder
	FAbehav s0 (A[0], B[0]^C0, C[0], R[0], C[1]); //stage 0
	FAbehav s1 (A[1], B[1]^C0, C[1], R[1], C[2]); //stage 1
	FAbehav s2 (A[2], B[2]^C0, C[2], R[2], C[3]); //stage 2
	FAbehav s3 (A[3], B[3]^C0, C[3], R[3], C[4]); //stage 3
	FAbehav s4 (A[4], B[4]^C0, C[4], R[4], C[5]); //stage 4
	FAbehav s5 (A[5], B[5]^C0, C[5], R[5], C[6]); //stage 3
	FAbehav s6 (A[6], B[6]^C0, C[6], R[6], C[7]); //stage 3
	FAbehav s7 (A[7], B[7]^C0, C[7], R[7], C[8]); //stage 3
		assign Cout = C[8]; //rename carry-out port
endmodule
