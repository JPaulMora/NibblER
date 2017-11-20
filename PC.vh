module PC(
    input logic [11:0] newaddr,
    input loadPC, incPC, clk, Rst,
    output logic [11:0] addr
);

    always @ (posedge clk or posedge Rst)
        if (Rst)
            addr = 'h000;
        else if (incPC)
            addr <= addr + 'b1;
        else if (loadPC)
                addr <= newaddr;       
endmodule