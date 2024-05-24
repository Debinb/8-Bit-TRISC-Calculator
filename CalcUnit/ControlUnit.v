module ControlUnit
(
	input Enter, CLR, CLK,
	output reg A_Load, B_Load, R_Load, OU_Load, RESET, IU_AU
);
	reg[1:0] state, nextstate;

	parameter s0 = 2'b00, s1= 2'b01, s2 = 2'b10, s3 = 2'b11;
	wire connect;

	EdgeDetect EdgeDetection
	(
		.in(~Enter) ,	// input  in_sig
		.clock(CLK) ,	// input  clock_sig
		.out(connect) 	// output  out_sig
	);
	
always@(posedge CLK, negedge CLR)
	if(CLR == 1'b0) state <= s0;
	else state <= nextstate; 
	always @ (state,connect)
	case(state) 
			s0:if(connect) begin nextstate = s1; end else begin nextstate = s0; end
			s1:if(connect) begin nextstate = s2; end else begin nextstate = s1; end
			s2:if(connect) begin nextstate = s3; end else begin nextstate = s2; end
			s3:if(connect) begin nextstate = s3; end else begin nextstate = s3; end
	endcase	

always @ (state,connect)
	case(state) 
			s0:begin RESET = 1'b0; A_Load = 1'b1; B_Load = 1'b1; R_Load = 1'b1;  OU_Load = 1'b1; IU_AU = 1'b0; end
			s1:begin RESET = 1'b1; A_Load = 1'b0; B_Load = 1'b1; R_Load = 1'b1;  OU_Load = 1'b0; IU_AU = 1'b0; end
			s2:begin RESET = 1'b1; A_Load = 1'b1; B_Load = 1'b0; R_Load = 1'b1;  OU_Load = 1'b0; IU_AU = 1'b0; end
			s3:begin RESET = 1'b1; A_Load = 1'b1; B_Load = 1'b1; R_Load = 1'b0;  OU_Load = 1'b0; IU_AU = 1'b1; end   
	endcase		
endmodule 
