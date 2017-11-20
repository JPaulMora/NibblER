module busDriver(
    input enable,
    input [3:0] A,
    inout [3:0] Y
);

assign Y = (enable) ? A : 4'bz;

endmodule