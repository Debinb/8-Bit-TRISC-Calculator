module Calculator
(
	input Enter, clear, clock, AddSub,
	input[3:0] Rows,
	output OVR,
	output[3:0] COL,
	output[0:6] HEX0, HEX1, HEX2, HEX3
);
   wire CLK, CONNECT; 
	wire[7:0] IU_OUT, MUX, AU_OUT;
	reg IUAU, LdA, LdB, LdR, LdOU, Reset;
	
ControlUnit CU
(
	.Enter(Enter) ,	// input  Enter_sig
	.CLR(clear) ,	// input  CLR_sig
	.CLK(CLK_sig) ,	// input  CLK_sig
	.A_Load(LdA) ,	// output  A_Load_sig
	.B_Load(LdB) ,	// output  B_Load_sig
	.R_Load(LdR) ,	// output  R_Load_sig
	.OU_Load(LdOU) ,	// output  OU_Load_sig
	.RESET(Reset) ,	// output  RESET_sig
	.IU_AU(IUAU) 	// output  IU_AU_sig
);

CalcIU IU
(
	.ROW(Rows) ,	// input [3:0] ROW_sig
	.reset(clear) ,	// input  reset_sig
	.CLK(clock) ,	// input  CLK_sig
	.COL(COL) ,	// output [3:0] COL_sig
	.Final(IU_OUT) 	// output [7:0] Final_sig
);

AU A_U
(
	.reset(clear) ,	// input  reset_sig
	.LoadA(LdA) ,	// input  LoadA_sig
	.LoadB(LdB) ,	// input  LoadB_sig
	.LoadR(LdR) ,	// input  LoadR_sig
	.ADDSUB(AddSub) ,	// input  ADDSUB_sig
	.BIT_Input(IU_OUT) ,	// input [7:0] BIT_Input_sig
	.OVR(OVR_sig) ,	// output  OVR_sig
	.Cout(Cout_sig) ,	// output  Cout_sig
	.result(AU_OUT) 	// output [7:0] result_sig
);

assign MUX = (IUAU == 0) ? IU_OUT : AU_OUT;

CalcOU OU
(
	.CLK(clock) ,	// input  CLK_sig
	.Reset(clear) ,	// input  Reset_sig
	.LoadOU(LdOU) ,	// input  LoadOU_sig ???
	.testout(MUX) ,	// input [7:0] testout_sig
	.hex0(HEX0) ,	// output [0:6] hex0_sig
	.hex1(HEX1) ,	// output [0:6] hex1_sig
	.hex2(HEX2) ,	// output [0:6] hex2_sig
	.hex3(HEX3) 	// output [0:6] hex3_sig
);

endmodule

