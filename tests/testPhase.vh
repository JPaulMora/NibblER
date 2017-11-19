`include "../Phase.vh"

module testPhase();

logic clk, reset;
wire Q;

initial begin
  clk = 0;
  reset = 0;
end

Phase p(.clk(clk), .reset(reset), .Q(Q));

initial begin
    $display("Testing Phase");
    $display("clk\treset\tQ");
    $monitor("%b\t%b\t%b",clk, reset, Q);
    #3 reset = 1;
    #1 reset = 0;
end

always
    #2 clk = ~clk;
initial
    #20 $finish;
endmodule