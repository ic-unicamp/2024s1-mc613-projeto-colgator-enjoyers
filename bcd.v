module bcd(
  input [23:0] entrada,
  output reg [23:0] bcd
);
    integer i;

    always @(*) begin
      bcd = 0;
		i = 0;
		for (i = 0; i <= 24; i = i + 1) begin
				if(i < 24)
					bcd = { bcd[22:0], entrada[23-i]};
            if (i < 23 &&  bcd[3:0] > 4)
                bcd[3:0] = bcd[3:0] + 3;
            if (i < 23 &&  bcd[7:4] > 4)
                bcd[7:4] = bcd[7:4] + 3;
            if (i < 23 &&  bcd[11:8] > 4)
                bcd[11:8] = bcd[11:8] + 3;
            if (i < 23 &&  bcd[15:12] > 4)
                bcd[15:12] = bcd[15:12] + 3;
            if (i < 23 &&  bcd[19:16] > 4)
                bcd[19:16] = bcd[19:16] + 3;
            if (i < 23 &&  bcd[23:20] > 4)
                bcd[23:20] = bcd[23:20] + 3;
        end
    end

endmodule