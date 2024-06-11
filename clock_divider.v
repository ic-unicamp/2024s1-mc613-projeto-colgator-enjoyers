module clock_divider (
    input wire CLK_50,
    output reg CLK_25
);

reg [24:0] counter;

always @(posedge CLK_50) begin
    if (counter == 24'd0) begin
        counter = 24'd0;
        CLK_25 = ~CLK_25;
    end else begin
        counter = counter + 1;
    end
end

initial begin
    CLK_25 <= 0; 
end

endmodule