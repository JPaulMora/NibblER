//`include "ffD.vh"

module PC(
    input logic [11:0] newaddr,
    input loadPC, incPC, clk, Rst,
    output logic [11:0] addr
);

    always @ (posedge clk or posedge Rst)
        if (Rst)
            addr = 'h000;
        else if (incPC)
            if (loadPC)
                addr <= newaddr;
            else
                addr <= addr + 'b1;   
            
endmodule