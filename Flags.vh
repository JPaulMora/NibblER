module Flags(
    input clk, reset, enable, zero, carry,
    output logic zero_out, carry_out
);

always @(posedge clk or posedge reset)
    if (reset)
        begin
        zero_out = 0;
        carry_out = 0;
        end
    else if (enable)
        begin
        zero_out <= zero;
        carry_out <= carry;
        end
endmodule
