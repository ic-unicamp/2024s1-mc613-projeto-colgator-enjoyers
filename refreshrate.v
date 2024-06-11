module refreshrate (
    input wire clk_50MHz,
    output reg clk_25Hz
);

parameter DIVIDE_FACTOR = 2000000; // Fator de divisão para reduzir 50MHz para 25Hz

reg [31:0] counter;

always @(posedge clk_50MHz) begin
    counter <= counter + 1;
    if (counter == DIVIDE_FACTOR - 1) begin
        clk_25Hz <= ~clk_25Hz;
        counter <= 0;
    end
end

endmodule