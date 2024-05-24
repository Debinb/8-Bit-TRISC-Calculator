module HalfAdder (
	input ai, bi,
	output reg si, couti);
	always @ (ai,bi)
		case ({ai,bi})
			3'b00: begin couti = 1'b0; si = 1'b0; end
			3'b01: begin couti = 1'b0; si = 1'b1; end
			3'b10: begin couti = 1'b0; si = 1'b1; end
			3'b11: begin couti = 1'b1; si = 1'b0; end
	endcase
endmodule