//Testbench ROM
`include "../ROM.vh"

module testbench();
  logic clk = 0;
  logic [11:0] add;
  logic [7:0] content;
  
  ROM MEM_TEST(.address(add), .data(content));
  
  initial
    begin
      $display("address:\tcontent:");
      for (int i=0; i<16; i++)
        begin
          add = i;
          #1 $display("%b\t%b", add, content);
        end
    end
  
  always
    #5 clk = ~clk;
  
  initial
    #200 $finish;
endmodule