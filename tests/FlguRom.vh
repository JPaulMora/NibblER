`include "../microROM.vh"
`include "../Flags.vh"
module flagconRom();
  logic clk, reset;
  wire [2:0] S; 
  wire incPC, loadPC, loadA, loadFlags, csRAM, weRAM, oeALU, oeIN, oeOperand, loadOut; 
  wire Z_alu, C_out_alu, Z_FF, C_out_FF, phase; //logic
  wire [3:0] instr; //logic

  load_flags load_flags_FF(.clk(clk), .reset(reset), .enable(loadFlags), .zero(Z_alu), .c_out(C_out_alu), .zero_out(Z_FF), .c_out_out(C_out_FF));
  decode dc(.phase(phase), .C(C_out_FF), .Z(Z_FF), .i(instr), .out_data({incPC, loadPC, loadA, loadFlags, S,csRAM, weRAM, oeALU, oeIN, oeOperand, loadOut}));

  initial begin
    clk = 0;
    reset = 0;
    instr = 0;
    phase = 0;
    c_out = 0;
    Z_FF = 0;
    Z_alu = 0;
  end

  initial begin
    $display(clk rst phase inst\t C Z LF ZA decoded);
    $monitor("%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b", clk, reset, phase, instr, c_out, Z_FF, );

  end
  always
    # 5 clk = ~clk;
endmodule