module CalcIU (
	input [3:0] ROW,
	input reset, CLK,
	output [3:0] COL, VAL,
	output TRIG, cout, ovr,
	output[7:0] Final
);

	wire [15:0] OUT, binOUT;
	
//instantiations	
			keypad_input keypad_input_inst
			(
				.clk(CLK) ,	// input  clk_sig
				.reset(reset) ,//input  reset_sig
				.row(ROW) ,	// input [3:0] row_sig
				.col(COL) ,	// output [3:0] col_sig
				.out(OUT) ,	// output [DIGITS*4-1:0] out_sig
				.value(VAL) ,	// output [3:0] value_sig
				.trig(TRIG) 	// output  trig_sig
			);

			BCD2BinarySM BCD2BinarySM_inst
			(
				.BCD(OUT) ,	// input [15:0] BCD_sig
				.binarySM(binOUT) 	// output [N-1:0] binarySM_sig
			);

			TwoSignMag TwoSignMag_inst
			(
				.A(binOUT) ,	// input [7:0] A_sig
				.B(Final) ,	// output [7:0] B_sig
				.Cout(cout) ,	// output  Cout_sig
				.OVR(ovr) 	// output  OVR_sig
			);

endmodule
	