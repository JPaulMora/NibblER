module Phase(
    input clk, reset,
    output logic Q
);

always @(posedge clk or posedge reset)
    if (reset)
        Q = 0;
    else
        Q <= ~Q;
endmodule