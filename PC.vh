//`include "ffD.vh"

module PC(
    input logic [11:0] newaddr,
    input enable, clk, Rst,
    output logic [11:0] addr,
    output logic phase
);


    always @(posedge clk or posedge Rst)
        if (Rst)
            phase = 1'b1;
        else
            phase <= ~phase;

    always @ (posedge phase or posedge Rst)
        if (Rst)
            addr = 'h000;
        else
            if (enable)
                addr <= newaddr;
            else
                addr <= addr + 'b1;   
endmodule