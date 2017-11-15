// Flip-Flop type D

module ffD(
    input D, clk, Rst,
    output logic Q
);

    // Do stuff when clock is in positive edge
    always @ (posedge clk or posedge Rst)
       if (Rst)
            Q <= 1'b0;
        else
            Q <= D;
endmodule