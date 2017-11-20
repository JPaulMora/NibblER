//                          --    OUT_FF   --                           //
//   y lo despliega en 4 LEDs cuando esta enabled y es sincrono
module out_FF(
// ---------- INPUT -------------- //
    input clk, reset, enable,
    input [3:0] D,
// ---------- OUTPUT ------------- //
    output logic [3:0] Q
);

// ----------  CODE  ------------- //
    always @ (posedge clk or posedge reset) begin
        if (reset)
            Q = 'b0000;
        else if (enable)
            Q <= D;
    end    
endmodule