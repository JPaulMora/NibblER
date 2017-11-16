//`include "ffD.vh"


module newPC(
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


//PC COUNTER de Santiago
//             ______________
// incPC       |            |
// loadPC      |            |
// SelectRAM   |    PC      | 
// WeRAM       |            |
//             |____________|
// incPC - enables COUNTER
// loadPC - contador load
// SelectRAM - RAM en tri estado
// WeRAM - si en 0 esta leyendo. Si es 1 esta grabando
module pcCounter(clk, reset, incPC, loadPC, outValue, loadValues);
    //------------ OUTPUTS ---------------
    output [11:0] outValue;

     //------------ INPUT ----------------
    input [11:0]  loadValues;
    input clk, reset, loadPC, incPC;

    //------------- CODE ------------------
    always@(posedge clk)
    begin
        if(reset) begin
            outValue <= 12'b0; 
        end else if (incPC) begin
            outValue <= outValue +1;
        end else if (loadPC) beigin
            outValue <= loadValues;
        end     
    end
endmodule