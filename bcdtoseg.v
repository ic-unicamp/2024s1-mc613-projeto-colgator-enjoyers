module bcd_to_7seg_decoder(
  input [3:0] bcd0,
  input [3:0] bcd1,
  input [3:0] bcd2,
  output reg [6:0] seg_out0,
  output reg [6:0] seg_out1,
  output reg [6:0] seg_out2
);

    always @(*) begin
			case(bcd0)
				4'b0000: seg_out0 = 7'b1000000;
				4'b0001: seg_out0 = 7'b1111001;
				4'b0010: seg_out0 = 7'b0100100;
				4'b0011: seg_out0 = 7'b0110000;
				4'b0100: seg_out0 = 7'b0011001;
				4'b0101: seg_out0 = 7'b0010010;
				4'b0110: seg_out0 = 7'b0000010; 
				4'b0111: seg_out0 = 7'b1111000;
				4'b1000: seg_out0 = 7'b0000000;
				4'b1001: seg_out0 = 7'b0011000;
				default: seg_out0 = 7'b0111111;
			endcase
			
			case(bcd1)
				4'b0000: seg_out1 = 7'b1000000;
				4'b0001: seg_out1 = 7'b1111001;
				4'b0010: seg_out1 = 7'b0100100;
				4'b0011: seg_out1 = 7'b0110000;
				4'b0100: seg_out1 = 7'b0011001;
				4'b0101: seg_out1 = 7'b0010010;
				4'b0110: seg_out1 = 7'b0000010; 
				4'b0111: seg_out1 = 7'b1111000;
				4'b1000: seg_out1 = 7'b0000000;
				4'b1001: seg_out1 = 7'b0011000;
				default: seg_out1 = 7'b0111111;
			endcase
			
			case(bcd2)
				4'b0000: seg_out2 = 7'b1000000;
				4'b0001: seg_out2 = 7'b1111001;
				4'b0010: seg_out2 = 7'b0100100;
				4'b0011: seg_out2 = 7'b0110000;
				4'b0100: seg_out2 = 7'b0011001;
				4'b0101: seg_out2 = 7'b0010010;
				4'b0110: seg_out2 = 7'b0000010; 
				4'b0111: seg_out2 = 7'b1111000;
				4'b1000: seg_out2 = 7'b0000000;
				4'b1001: seg_out2 = 7'b0011000;
				default: seg_out2 = 7'b0111111;
			endcase
	end

endmodule