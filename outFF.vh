//                          --    OUT_FF   --                           //
// Tambien conocido como "OUT For F*** sake!" es el modulo que recibe informacion 4bits del bus
//   y lo despliega en 4 LEDs cuando esta enabled y es sincrono
module out_FF(
    clk,
    reset,
    enable,
    D,
    Q
);
// ---------- INPUT -------------- //
    input clk, reset, enable;
    input [3:0] D;
// ---------- OUTPUT ------------- //
    output reg [3:0] Q;
// ----------  CODE  ------------- //
    always @ (posedge clk) begin
        if (reset)
            Q <= 'b000;
        else if (enable)
            Q <= D;
    end    
endmodule