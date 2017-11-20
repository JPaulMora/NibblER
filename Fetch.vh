module Fetch(
    input clk, reset, enable,
    input logic [7:0] D,
    output logic [7:0] Q 
);

    always @(posedge clk or posedge reset) 
        if (~enable)
            Q <= D;
        else if (reset)
            Q <= 'b0;
endmodule