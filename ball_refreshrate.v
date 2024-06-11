module ball_refreshrate (
    input wire clk_50MHz,
    input [21:0] N,
    output reg clk_out
);

reg next_clk_out;
reg [21:0] counter;
reg [21:0] next_counter;

always @(posedge clk_50MHz) begin
    clk_out = next_clk_out;
    counter = next_counter;
end

always @(*) begin
    if (counter == (N>>1)) begin
        next_clk_out = ~clk_out;
        next_counter = 1'b1;
    end else begin
        next_clk_out = clk_out;
        next_counter = counter + 1;
    end
end


endmodule