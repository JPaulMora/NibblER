module Fetch(
    input clk, reset, enable,
    input [7:0] D,
    output logic [7:0] Q 
);


always @(posedge clk or posedge reset)
        if (reset)
            Q <= 8'h00;
        else if (enable)
            Q <= D;
endmodule