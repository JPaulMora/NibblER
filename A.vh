module A(
    input clk, reset, enable,
    input [3:0] D,
    output logic [3:0] Q
);

always @ (posedge clk or posedge reset)
    if (reset)
        Q = 4'h0;
    else if (enable)
        Q <= D;
endmodule