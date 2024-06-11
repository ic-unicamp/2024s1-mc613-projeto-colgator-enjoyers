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
  output reg [7:0] VGA_B
);
    
clock_divider divider_25(
  .CLK_50(CLOCK_50),
  .CLK_25(VGA_CLK)
);

refreshrate refresh(
  .clk_50MHz(CLOCK_50),
  .clk_25Hz(refreshrate)
);

wire refreshrate;
reg [21:0] refreshrate_divider = 2000000;
integer x, y, estado = 0;
integer frametime = 0.042;
integer x_frog = ((640 - 128)/ 2) + 143;
integer y_frog = (480 - 2) + 25;
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
  
  if (x > 96 && y > 2 && x > x_frog && x < (x_frog + 32) && y > y_frog && y < (y_frog + 32)) begin
    VGA_R = 0;
    VGA_G = 255;
    VGA_B = 0;
  end if (x > 96 && y > 2 && ((y > 480 - 32 && y < 480) || (y > 402 - 32 && y < 402))) begin
    VGA_R = 255;
    VGA_G = 255;
    VGA_B = 255;
  end else begin 
    VGA_R = 0;
    VGA_G = 0;
    VGA_B = 0;
  end
end


always @(posedge VGA_CLK) begin

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
      y_frog = y_frog + 32;
      estado = 5;
    end
    4: begin
      y_frog = y_frog - 32;
      estado = 5;
    end
    5: begin
      if (move_r && move_l && move_d && move_u) begin
        estado = 0;
      end
    end
  endcase
end



endmodule