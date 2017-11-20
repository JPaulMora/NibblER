
`include "../Phase.vh"
`include "../Fetch.vh"

module testPhaseFetch();

logic clk, reset;
logic [7:0] data = 01001001;

initial begin
  clk = 0;
  reset = 0;
end

wire [3:0] instruction, operand;

Phase p(.clk(clk), .reset(reset), .Q(phase));
Fetch f(.clk(clk), .reset(reset), .enable(phase), .D(data), .Q({instruction,operand}));

initial begin
  $display("Phase + Fetch");
  $display("clk\tphase\treset\tD\t\tinstruction\toperand");
  $monitor("%b\t%b\t%b\t%b\t%b\t\t%b", clk, phase, reset, data, instruction, operand);
  reset = 0;
  
end

always
  #5 clk = ~clk;

initial
  #8 $finish;
endmodule