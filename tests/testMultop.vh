
//Testbench ALU submodules
`include "../ALU.vh"

//Test MULT
module testMultop();

  //Initialize Connections
  logic [3:0] X;
  logic [3:0] Y;
  wire [3:0] Out;
  wire C;

//Connect to MULT module
 multop MT(.A(X),.B(Y),.out(Out),.carry(C));

initial
  begin
  //Print table headers 
    $display("\nTesting MULT multop with (0 * 15) and (9 * 2)\n\n");
    $display("Carry \t\tO");
  
  //Start monitor
    $monitor("%d \t\t%b", C, Out);

  //Set input values 
    X <= 4'b0000;
    Y <= 4'b1111;
    #1;
    X <= 4'b1001; 
    Y <= 4'b0010;

  end
endmodule