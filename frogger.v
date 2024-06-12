module frogger (
  input CLOCK_50,
  output VGA_CLK,
  input move_r,
  input move_l,
  input move_u,
  input move_d,
  output VGA_HS,
  output VGA_VS,
  output VGA_BLANK_N,
  output VGA_SYNC_N,
  output reg [7:0] VGA_R,
  output reg [7:0] VGA_G,
  output reg [7:0] VGA_B,
  output reg [6:0] digito0,
  output reg [6:0] digito1,
  output reg [6:0] digito2
);

bcd converter(
  .entrada(pontuacao),
  .bcd(saida_debugger)
);

bcd_to_7seg_decoder decoder(
	.bcd0(saida_debugger[3:0]),
	.bcd1(saida_debugger[7:4]),
	.bcd2(saida_debugger[11:8]),
	.seg_out0(saida_decoder0),
	.seg_out1(saida_decoder1),
	.seg_out2(saida_decoder2),
);
    
clock_divider divider_25(
  .CLK_50(CLOCK_50),
  .CLK_25(VGA_CLK)
);

ball_refreshrate car01_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider01),
	.clk_out(refreshrate01)
);

ball_refreshrate car02_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider02),
	.clk_out(refreshrate02)
);

ball_refreshrate car03_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider03),
	.clk_out(refreshrate03)
);

ball_refreshrate car04_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider04),
	.clk_out(refreshrate04)
);

ball_refreshrate car05_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider05),
	.clk_out(refreshrate05)
);

ball_refreshrate car06_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider06),
	.clk_out(refreshrate06)
);

ball_refreshrate car07_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider07),
	.clk_out(refreshrate07)
);

ball_refreshrate car08_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider08),
	.clk_out(refreshrate08)
);
wire refreshrate01, refreshrate02, refreshrate03, refreshrate04, refreshrate05, refreshrate06, refreshrate07, refreshrate08;
integer win = 0;
reg [23:0] pontuacao = 0;
wire [23:0] saida_debugger;
wire [6:0] saida_decoder0;
wire [6:0] saida_decoder1;
wire [6:0] saida_decoder2;
reg [21:0] refreshrate_divider01 = 1500000;
reg [21:0] refreshrate_divider02 = 2500000;
reg [21:0] refreshrate_divider03 = 3000000;
reg [21:0] refreshrate_divider04 = 3500000;
reg [21:0] refreshrate_divider05 = 5000000;
reg [21:0] refreshrate_divider06 = 3000000;
reg [21:0] refreshrate_divider07 = 4500000;
reg [21:0] refreshrate_divider08 = 5000000;
integer x, y, estado = 0;
integer frametime = 0.042;
integer x_frog = ((640)/ 2) + 143;
integer y_frog = (480 - 32) + 34;
assign VGA_HS = (x < 96)? 0 : 1;
assign VGA_VS = (y < 2)? 0 : 1;
assign VGA_BLANK_N = 1;
assign VGA_SYNC_N = 0;
reg [10:0] adress01 [0:7];
reg [10:0] adress02 [0:7];
reg [10:0] adress03 [0:7];
reg [10:0] adress04 [0:7];
reg [10:0] adress05 [0:7];
reg [10:0] adress06 [0:7];
reg [10:0] adress07 [0:7];
reg [10:0] adress08 [0:7];
reg [7:0] line01 [0:7];
reg [7:0] line02 [0:7];
reg [7:0] line03 [0:7];
reg [7:0] line04 [0:7];
reg [7:0] line05 [0:7];
reg [7:0] line06 [0:7];
reg [7:0] line07 [0:7];
reg [7:0] line08 [0:7];
integer i, j;
integer reset = 0;
initial begin
	 line01[0] = 8'd1;
	 line01[1] = 8'd3;
	 line01[2] = 8'd2;
	 line01[3] = 8'd0;
	 line01[4] = 8'd0;
	 line01[5] = 8'd3;
	 line01[6] = 8'd2;
	 line01[7] = 8'd3;
	 
	 line02[0] = 8'd2;
	 line02[1] = 8'd0;
	 line02[2] = 8'd1;
	 line02[3] = 8'd0;
	 line02[4] = 8'd3;
	 line02[5] = 8'd1;
	 line02[6] = 8'd0;
	 line02[7] = 8'd3;
	 
	 line03[0] = 8'd2;
	 line03[1] = 8'd2;
	 line03[2] = 8'd0;
	 line03[3] = 8'd0;
	 line03[4] = 8'd0;
	 line03[5] = 8'd2;
	 line03[6] = 8'd2;
	 line03[7] = 8'd0;
	 
	 line04[0] = 8'd1;
	 line04[1] = 8'd0;
	 line04[2] = 8'd1;
	 line04[3] = 8'd0;
	 line04[4] = 8'd1;
	 line04[5] = 8'd0;
	 line04[6] = 8'd1;
	 line04[7] = 8'd0;
	 
	 line05[0] = 8'd0;
	 line05[1] = 8'd1;
	 line05[2] = 8'd2;
	 line05[3] = 8'd0;
	 line05[4] = 8'd1;
	 line05[5] = 8'd2;
	 line05[6] = 8'd0;
	 line05[7] = 8'd0;
	 
	 line06[0] = 8'd0;
	 line06[1] = 8'd3;
	 line06[2] = 8'd0;
	 line06[3] = 8'd3;
	 line06[4] = 8'd0;
	 line06[5] = 8'd3;
	 line06[6] = 8'd0;
	 line06[7] = 8'd3;
	 
	 line07[0] = 8'd1;
	 line07[1] = 8'd2;
	 line07[2] = 8'd0;
	 line07[3] = 8'd1;
	 line07[4] = 8'd0;
	 line07[5] = 8'd3;
	 line07[6] = 8'd2;
	 line07[7] = 8'd0;
	 
	 line08[0] = 8'd0;
	 line08[1] = 8'd1;
	 line08[2] = 8'd0;
	 line08[3] = 8'd2;
	 line08[4] = 8'd0;
	 line08[5] = 8'd3;
	 line08[6] = 8'd0;
	 line08[7] = 8'd1;
	
end

integer idx01 = 0;
integer idx02 = 0;
integer idx03 = 0;
integer idx04 = 0;
integer idx05 = 0;
integer idx06 = 0;
integer idx07 = 0;
integer idx08 = 0;

always @(posedge VGA_CLK) begin

	x = x + 1;
	reset = 0;
  win = 0;
	if (x == 800) begin
		x = 0;
		y = y + 1;
		if (y == 525) begin
			y = 0;
		end
	end
  
	if (x > 96 && y > 2 && x > x_frog && x < (x_frog + 32) && y > y_frog && y < (y_frog + 32)) begin
		VGA_R = 0;
		VGA_G = 255;
		VGA_B = 0;
	end else if (x > 96 && y > 2 && ((y > (480 + 34) - 32 && y < (480 + 34)) || (y > (320 + 34) - 32 && y < (320 + 34)) || (y > (160 + 34) - 32 && y < (160 + 34)))) begin
		VGA_R = 255;
		VGA_G = 255;
		VGA_B = 255;
  end else if (x > 96 && y > 2 && y < (96 + 34))begin
    VGA_R = 0;
		VGA_G = 0;
    VGA_B = 255;
	end else begin
		VGA_R = 0;
		VGA_G = 0;
		VGA_B = 0;
		for (i = 0; i < 8; i = i + 1) begin
			if(x > 96 && y > 2 && (y > (448 + 34) - 32 && y < (448 + 34)) && (x > adress01[i] && x < (adress01[i] + (32 * line01[i])))) begin
				VGA_R = 255;
				VGA_G = 0;
				VGA_B = 0;
			end
		end
		for (i = 0; i < 8; i = i + 1) begin
			if(x > 96 && y > 2 && (y > (416 + 34) - 32 && y < (416 + 34)) && (x > adress02[i] && x < (adress02[i] + (32 * line02[i])))) begin
				VGA_R = 0;
				VGA_G = 0;
				VGA_B = 255;
			end
		end
		for (i = 0; i < 8; i = i + 1) begin
			if(x > 96 && y > 2 && (y > (384 + 34) - 32 && y < (384 + 34)) && (x > (adress03[i] - (32 * line03[i])) && x < adress03[i])) begin
				VGA_R = 243;
				VGA_G = 122;
				VGA_B = 32;
			end
		end
		for (i = 0; i < 8; i = i + 1) begin
			if(x > 96 && y > 2 && (y > (352 + 34) - 32 && y < (352 + 34)) && (x > (adress04[i] - (32 * line04[i])) && x < adress04[i])) begin
				VGA_R = 54;
				VGA_G = 45;
				VGA_B = 23;
			end
		end
		for (i = 0; i < 8; i = i + 1) begin
			if(x > 96 && y > 2 && (y > (288 + 34) - 32 && y < (288 + 34)) && (x > adress05[i] && x < (adress05[i] + (32 * line05[i])))) begin
				VGA_R = 27;
				VGA_G = 100;
				VGA_B = 196;
			end
		end
		for (i = 0; i < 8; i = i + 1) begin
			if(x > 96 && y > 2 && (y > (256 + 34) - 32 && y < (256 + 34)) && (x > (adress06[i] - (32 * line06[i])) && x < adress06[i])) begin
				VGA_R = 12;
				VGA_G = 234;
				VGA_B = 112;
			end
		end
		for (i = 0; i < 8; i = i + 1) begin
			if(x > 96 && y > 2 && (y > (224 + 34) - 32 && y < (224 + 34)) && (x > adress07[i] && x < (adress07[i] + (32 * line07[i])))) begin
				VGA_R = 125;
				VGA_G = 125;
				VGA_B = 34;
			end
		end
		for (i = 0; i < 8; i = i + 1) begin
			if(x > 96 && y > 2 && (y > (192 + 34) - 32 && y < (192 + 34)) && (x > (adress08[i] - (32 * line08[i])) && x < adress08[i])) begin
				VGA_R = 255;
				VGA_G = 0;
				VGA_B = 0;
			end
		end
	end
	
	
	
	for (i = 0; i < 8; i = i + 1) begin
		if((y_frog + 16 > (448 + 34) - 32 && y_frog < (448 + 34)) && ((x_frog + 32 > adress01[i] && x_frog + 32 < (adress01[i] + (32 * line01[i]))) || (x_frog > adress01[i] && x_frog < (adress01[i] + (32 * line01[i]))))) begin
			reset = 1;
		end
	end
	
	for (i = 0; i < 8; i = i + 1) begin
		if((y_frog + 16 > (416 + 34) - 32 && y_frog < (416 + 34)) && ((x_frog + 32 > adress02[i] && x_frog + 32 < (adress02[i] + (32 * line02[i]))) || (x_frog > adress02[i] && x_frog < (adress02[i] + (32 * line02[i]))))) begin
			reset = 1;
		end
	end
	
	for (i = 0; i < 8; i = i + 1) begin
		if((y_frog + 16 > (384 + 34) - 32 && y_frog < (384 + 34)) && ((x_frog + 32 < adress03[i] && x_frog + 32 > (adress03[i] - (32 * line03[i]))) || (x_frog < adress03[i] && x_frog > (adress03[i] - (32 * line03[i]))))) begin
			reset = 1;
		end
	end
	
	for (i = 0; i < 8; i = i + 1) begin
		if((y_frog + 16 > (352 + 34) - 32 && y_frog < (352 + 34)) && ((x_frog + 32 < adress04[i] && x_frog + 32 > (adress04[i] - (32 * line04[i]))) || (x_frog < adress04[i] && x_frog > (adress04[i] - (32 * line04[i]))))) begin
			reset = 1;
		end
	end
	
	for (i = 0; i < 8; i = i + 1) begin
		if((y_frog + 16 > (288 + 34) - 32 && y_frog < (288 + 34)) && ((x_frog + 32 > adress05[i] && x_frog + 32 < (adress05[i] + (32 * line05[i]))) || (x_frog > adress05[i] && x_frog < (adress05[i] + (32 * line05[i]))))) begin
			reset = 1;
		end
	end
	
	for (i = 0; i < 8; i = i + 1) begin
		if((y_frog + 16 > (256 + 34) - 32 && y_frog < (256 + 34)) && ((x_frog + 32 < adress06[i] && x_frog + 32 > (adress06[i] - (32 * line06[i]))) || (x_frog < adress06[i] && x_frog > (adress06[i] - (32 * line06[i]))))) begin
			reset = 1;
		end
	end
	
	for (i = 0; i < 8; i = i + 1) begin
		if((y_frog + 16 > (224 + 34) - 32 && y_frog < (224 + 34)) && ((x_frog + 32 > adress07[i] && x_frog + 32 < (adress07[i] + (32 * line07[i]))) || (x_frog > adress07[i] && x_frog < (adress07[i] + (32 * line07[i]))))) begin
			reset = 1;
		end
	end
	
	for (i = 0; i < 8; i = i + 1) begin
		if((y_frog + 16 > (192 + 34) - 32 && y_frog < (192 + 34)) && ((x_frog + 32 < adress08[i] && x_frog + 32 > (adress08[i] - (32 * line08[i]))) || (x_frog < adress08[i] && x_frog > (adress08[i] - (32 * line08[i]))))) begin
			reset = 1;
		end
	end
	
  if (y_frog + 16 < (96 + 34)) begin
    reset = 1;
    win = 1;
  end

  digito0 = (pontuacao == 0) ? 7'b1111111 : saida_decoder0;
  digito1 = (pontuacao < 10) ? 7'b1111111 : saida_decoder1;
  digito2 = (pontuacao < 100) ? 7'b1111111 : saida_decoder2;
	
end


always @(posedge VGA_CLK) begin

  if (reset == 1) begin
    x_frog = ((640)/ 2) + 143;
    y_frog = (480 - 32) + 34;
    if (win == 1) begin
      pontuacao = pontuacao + 1;
    end
  end

  case (estado)
    0: begin
      if (~move_r) begin
        estado = 1;
      end else if (~move_l) begin
        estado = 2;
      end else if (~move_u) begin
        estado = 3;
      end else if (~move_d) begin
        estado = 4;
      end
    end
    1: begin
      x_frog = x_frog + 32;
      if (x_frog > 640 + 141) begin
        x_frog = 141;
      end
      estado = 5;
    end
    2: begin
      x_frog = x_frog - 32;
      if (x_frog < 141) begin
        x_frog = 640 + 141 - 15;
      end
      estado = 5;
    end
    3: begin
		if (y_frog + 32 < 505) begin
			y_frog = y_frog + 32;
		end
      estado = 5;
    end
    4: begin
	 		if (y_frog - 32 > 25) begin
				y_frog = y_frog - 32;
			end
      estado = 5;
    end
    5: begin
      if (move_r && move_l && move_d && move_u) begin
        estado = 0;
      end
    end
  endcase
end

integer counter01 = 0;
always @(posedge refreshrate01) begin
	counter01 = counter01 + 1;

	if(idx01 < 7) begin
		if (counter01 == (40  + (16 * line01[idx01]))) begin
			adress01[idx01] = 11'd783;
			idx01 = idx01 + 1;
			counter01 = 0;
		end
	end

	for (j = 0; j < 8; j = j + 1) begin
		adress01[j] = adress01[j] - 1;
		if (adress01[j] < 45) begin 
			adress01[j] = 11'd783;
		end
	end
	
end

integer counter02 = 0;
always @(posedge refreshrate02) begin
	counter02 = counter02 + 1;

	if(idx02 < 7) begin
		if (counter02 == (40  + (16 * line02[idx02]))) begin
			adress02[idx02] = 11'd783;
			idx02 = idx02 + 1;
			counter02 = 0;
		end
	end

	for (j = 0; j < 8; j = j + 1) begin
		adress02[j] = adress02[j] - 1;
		if (adress02[j] < 45) begin 
			adress02[j] = 11'd783;
		end
	end
	
end

integer counter03 = 0;
always @(posedge refreshrate03) begin
	counter03 = counter03 + 1;

	if(idx03 < 7) begin
		if (counter03 == (40  + (16 * line03[idx03]))) begin
			adress03[idx03] = 11'd80;
			idx03 = idx03 + 1;
			counter03 = 0;
		end
	end

	for (j = 0; j < 8; j = j + 1) begin
		adress03[j] = adress03[j] + 1;
		if (adress03[j] > 879) begin 
			adress03[j] = 11'd80;
		end
	end
	
end

integer counter04 = 0;
always @(posedge refreshrate04) begin
	counter04 = counter04 + 1;

	if(idx04 < 7) begin
		if (counter04 == (40  + (16 * line04[idx04]))) begin
			adress04[idx04] = 11'd80;
			idx04 = idx04 + 1;
			counter04 = 0;
		end
	end

	for (j = 0; j < 8; j = j + 1) begin
		adress04[j] = adress04[j] + 1;
		if (adress04[j] > 879) begin 
			adress04[j] = 11'd80;
		end
	end
	
end

integer counter05 = 0;
always @(posedge refreshrate05) begin
	counter05 = counter05 + 1;

	if(idx05 < 7) begin
		if (counter05 == (40  + (16 * line05[idx05]))) begin
			adress05[idx05] = 11'd783;
			idx05 = idx05 + 1;
			counter05 = 0;
		end
	end

	for (j = 0; j < 8; j = j + 1) begin
		adress05[j] = adress05[j] - 1;
		if (adress05[j] < 45) begin 
			adress05[j] = 11'd783;
		end
	end
	
end

integer counter06 = 0;
always @(posedge refreshrate06) begin
	counter06 = counter06 + 1;

	if(idx06 < 7) begin
		if (counter06 == (40  + (16 * line06[idx06]))) begin
			adress06[idx06] = 11'd80;
			idx06 = idx06 + 1;
			counter06 = 0;
		end
	end

	for (j = 0; j < 8; j = j + 1) begin
		adress06[j] = adress06[j] + 1;
		if (adress06[j] > 879) begin 
			adress06[j] = 11'd80;
		end
	end
	
end

integer counter07 = 0;
always @(posedge refreshrate07) begin
	counter07 = counter07 + 1;

	if(idx07 < 7) begin
		if (counter07 == (40  + (16 * line07[idx07]))) begin
			adress07[idx07] = 11'd783;
			idx07 = idx07 + 1;
			counter07 = 0;
		end
	end

	for (j = 0; j < 8; j = j + 1) begin
		adress07[j] = adress07[j] - 1;
		if (adress07[j] < 45) begin 
			adress07[j] = 11'd783;
		end
	end
	
end

integer counter08 = 0;
always @(posedge refreshrate08) begin
	counter08 = counter08 + 1;

	if(idx08 < 7) begin
		if (counter08 == (40  + (16 * line08[idx08]))) begin
			adress08[idx08] = 11'd80;
			idx08 = idx08 + 1;
			counter08 = 0;
		end
	end

	for (j = 0; j < 8; j = j + 1) begin
		adress08[j] = adress08[j] + 1;
		if (adress08[j] > 879) begin 
			adress08[j] = 11'd80;
		end
	end
	
end



endmodule