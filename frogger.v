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
  output reg [6:0] digito0,// digito da direita
  output reg [6:0] digito1,
  output reg [6:0] digito2,
  output reg [6:0] digito3,
  output reg [6:0] digito4,
  output reg [6:0] digito5// digito da esquerda
);
    
clock_divider divider_25(
  .CLK_50(CLOCK_50),
  .CLK_25(VGA_CLK)
);

refreshrate refresh(
  .clk_50MHz(CLOCK_50),
  .clk_25Hz(refreshrate)
);

ball_refreshrate ball_refresh(
	.clk_50MHz(CLOCK_50),
	.N(refreshrate_divider),
	.clk_out(ball_refreshrate)
);

wire refreshrate, ball_refreshrate;
reg [21:0] refreshrate_divider = 2000000;
integer x, y, estado = 0;
integer frametime = 0.042;
integer timelapsed = 0;
integer running = 0;
integer x_speed = 0;
integer y_speed = 5;
integer x_frog = ((640 - 128)/ 2) + 143;
integer y_frog = (480 - 2) + 25;
integer x_bola = ((640 - 16)/ 2) + 143;
integer y_bola = ((480 - 16)/ 2) + 35;
assign VGA_HS = (x < 96)? 0 : 1;
assign VGA_VS = (y < 2)? 0 : 1;
assign VGA_BLANK_N = 1;
assign VGA_SYNC_N = 0;

always @(posedge VGA_CLK) begin

  x = x + 1;
  if (x == 800) begin
    x = 0;
    y = y + 1;
    if (y == 525) begin
      y = 0;
    end
  end
  
  if (x > 96 && y > 2 && x > x_frog && x < (x_frog + 16) && y > y_frog && y < (y_frog + 16)) begin
    VGA_R = 0;
    VGA_G = 255;
    VGA_B = 0;
  end else if (x > 96 && y > 2 && x > x_bola && x < (x_bola + 16) && y > y_bola && y < (y_bola + 16)) begin
    VGA_R = 255;
    VGA_G = 0;
    VGA_B = 0;
  end else begin
    VGA_R = 0;
    VGA_G = 0;
    VGA_B = 0;
  end
  
//   digito0 = (pontuacao_atual == 0) ? 7'b1111111 : saida_decoder0;
//   digito1 = (pontuacao_atual < 10) ? 7'b1111111 : saida_decoder1;
//   digito2 = (pontuacao_atual < 100) ? 7'b1111111 : saida_decoder2;
//   digito3 = (pontuacao_geral == 0) ? 7'b1111111 : saida_decoder3;
//   digito4 = (pontuacao_geral < 10) ? 7'b1111111 : saida_decoder4;
//   digito5 = (pontuacao_geral < 100) ? 7'b1111111 : saida_decoder5;
end

always @(posedge ball_refreshrate) 
  
//   if (~reset) begin
//     x_bola = ((640 - 16)/ 2) + 143;
//     y_bola = ((480 - 16)/ 2) + 35;
//     x_speed = 0;
//     y_speed = 5;
// 	 refreshrate_divider = 2000000;
// 	 running = 0;
//   end
  else if(running) begin
    if((y_bola + 16) >= y_frog - 1 && (x_bola + 16) > x_frog && x_bola < x_frog + 16) begin
	 
		pontuacao_atual = pontuacao_atual + 1; //morrer
		
		if (refreshrate_divider > 800000) begin
			refreshrate_divider = refreshrate_divider - 100000;
		end

    //   if((x_bola + 8) < (x_frog + 42)) begin
    //     y_speed = -y_speed;
    //     x_speed = x_speed - 1;
    //   end else if ((x_bola + 8) > (x_frog + 85)) begin
    //     y_speed = -y_speed;
    //     x_speed = x_speed + 1;
    //   end else begin
    //     y_speed = -y_speed;
    //   end

    // end else if (y_bola < 34) begin 
    //   y_speed = -y_speed;
    // end else if (x_bola + 16 > (640 + 141) || x_bola < 141) begin
    //   x_speed = -x_speed;
    // end else if (y_bola + 16 > (480 + 34)) begin
	 
		// if (pontuacao_atual > pontuacao_geral) begin
		// 	pontuacao_geral = pontuacao_atual;
		// end
		
	// 	refreshrate_divider = 2000000;
	// 	pontuacao_atual = 0;
	// 	running = 0;
	 
    //   x_bola = ((640 - 16)/ 2) + 143;
    //   y_bola = ((480 - 16)/ 2) + 35;
	// 	x_speed = 0;
	// 	y_speed = 5;
    end

    x_bola = x_bola + x_speed;
    y_bola = y_bola + y_speed;
  end else if(~move_r || ~move_l || ~move_d || ~move_u) begin
	running = 1;
  
end

always @(posedge refreshrate) begin

//   if (~reset) begin
//     x_frog = ((640 - 128)/ 2) + 143;
//     y_frog = (480 - 2) + 25;
//   end
  else if(running) begin
    if (~move_r) begin
      x_frog = x_frog + 16;
      if (x_frog > 640 + 141) begin
        x_frog = 141;
      end

    end else if (~move_l) begin
      x_frog = x_frog - 16;
      if (x_frog < 141) begin
        x_frog = 640 + 141 - 15;
      end

    end else if (~move_d) begin
      if (y_frog + 16 < 480 + 25) begin
        y_frog = y_frog - 16;
      end

    end else if (~move_u) begin
      if (y_frog > 25) begin
        y_frog = y_frog - 16;
      end
    end
    
    end
end



endmodule