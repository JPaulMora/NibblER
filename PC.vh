//`include "ffD.vh"

module PC(
    input logic [11:0] newaddr,
    input enable, clk, Rst,
    output logic [11:0] addr
);

    always @ (posedge clk or posedge Rst)
        if (Rst)
            addr = 'h000;
        else
            if (enable)
                addr <= newaddr;
            else
                addr <= addr + 'b1;   
endmodule