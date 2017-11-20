module In(
    input [3:0] A,
    inout [3:0] Y
);

assign Y = (A == 4'b0000) ? 4'bzzzz : A;
endmodule