module TwoFuncCalc
(
	input Enter, Clear, Clock, AddSub,
	input[3:0] ROW,
	//output[7:0] debug,
	output OVR,
	output reg[1:0] state,
	output reg IUAU, LOAD_A, LOAD_B, LOAD_R, LoadOU, Reset,
	output[3:0] COL,
	output[0:6] HEX0, HEX1, HEX2, HEX3
);
   wire CLK, out, TRIG; 
	wire[7:0] AB, TC, R;
	wire[3:0] VAL;
	reg [1:0]  nextstate;
	//reg IUAU, LOAD_A, LOAD_B, LOAD_R, LoadOU, Reset;
	
	parameter s0 = 2'b00, s1= 2'b01, s2 = 2'b10, s3 = 2'b11;

	EdgeDetect EdgeDetection
	(
		.in(~Enter) ,	// input  in_sig
		.clock(Clock) ,	// input  clock_sig
		.out(out) 	// output  out_sig
	);
	
always @ (posedge Clock, negedge Clear)
	if(Clear == 1'b0) 
		state <= s0;
	else 
		state <= nextstate; 
	
	always @ (state,out)
	case(state) 
			s0:if(out) begin nextstate = s1; end else begin nextstate = s0; end
			s1:if(out) begin nextstate = s2; end else begin nextstate = s1; end
			s2:if(out) begin nextstate = s3; end else begin nextstate = s2; end
			s3:if(out) begin nextstate = s3; end else begin nextstate = s3; end
			    
	endcase	

always @ (state,out)
	case(state) 
			s0:begin Reset = 1'b0; LOAD_A = 1'b1; LOAD_B = 1'b1; LOAD_R = 1'b1;  LoadOU = 1'b1; IUAU = 1'b0; end
			s1:begin Reset = 1'b1; LOAD_A = 1'b0; LOAD_B = 1'b1; LOAD_R = 1'b1;  LoadOU = 1'b0; IUAU = 1'b0; end
			s2:begin Reset = 1'b1; LOAD_A = 1'b1; LOAD_B = 1'b0; LOAD_R = 1'b1;  LoadOU = 1'b0; IUAU = 1'b0; end
			s3:begin Reset = 1'b1; LOAD_A = 1'b1; LOAD_B = 1'b1; LOAD_R = 1'b0;  LoadOU = 1'b0; IUAU = 1'b1; end
 
	endcase	

CalcIU INPUT_UNIT
(
	.ROW(ROW) ,	// input [3:0] ROW_sig
	.reset(Clear) ,	// input  reset_sig
	.CLK(Clock) ,	// input  CLK_sig
	.COL(COL) ,	// output [3:0] COL_sig
	.Final(AB) 	// output [7:0] Final_sig
);

EightBitALU EightBitALU_inst
(
	.reset(Clear) ,	// input  reset_sig
	.LoadA(LOAD_A) ,	// input  LoadA_sig
	.LoadB(LOAD_B) ,	// input  LoadB_sig
	.LoadR(LOAD_R) ,	// input  LoadR_sig
	.AddSubOption(AddSub) ,	// input  AddSubOption_sig
	.DataInput(AB) ,	// input [7:0] DataInput_sig
	.OVR(OVR) ,	// output  OVR_sig
	.result(R) ,	// output [7:0] result_sig
	
);

assign TC = (IUAU == 0) ? AB: R; //MUX

CalcOU OUTPUT_UNIT
(
	.CLK(Clock) ,	// input  CLK_sig
	.Reset(Clear) ,	// input  Reset_sig
	.LoadOU(LoadOU) ,	// input  LoadOU_sig ???
	.testout(TC) ,	// input [7:0] testout_sig
	.hex0(HEX0) ,	// output [0:6] hex0_sig
	.hex1(HEX1) ,	// output [0:6] hex1_sig
	.hex2(HEX2) ,	// output [0:6] hex2_sig
	.hex3(HEX3) 	// output [0:6] hex3_sig
);

endmodule

