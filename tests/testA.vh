`include "../A.vh"

module testA();

logic clk, reset, enable;
logic [3:0] D;
wire [3:0] Q;

initial begin
  D = 4'h3;
  clk = 0;
  reset = 0;
  enable = 0;
end

A a(.clk(clk), .reset(reset), .enable(enable), .D(D), .Q(Q));

initial begin
    //Print table headers 
    $display("\nTesting \"A\" register\n\n");
    $display("clk\treset\tenable\tD\tQ");

    //Start monitor
    $monitor("%b\t%b\t%b\t%b\t%b", clk, reset, enable, D, Q);
    #4 reset = 1;
    #1 reset = 0;
    #5 enable = 1;
    #3 D = 4'h2;
    #4 enable = 0;
       D = 4'h0;
    
end

always
    #2 clk = ~clk;

initial
    #20 $finish;
    
endmodule