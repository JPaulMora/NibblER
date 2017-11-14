
//Testbench ALU submodules
`include "../ALU.vh"

//Test ADD
module testAddop();

  //Initialize Connections
  logic [3:0] X;
  logic [3:0] Y;
  wire [3:0] Out;
  wire C;

//Connect to Adder module
 addop AD(.A(X),.B(Y),.out(Out),.carry(C));

initial
  begin
  //Print table headers 
    $display("\nTesting ADDer addop with (15 + 15) and (14 + 1) \n\n");
    $display("Carry \t\tO");
  
  //Start monitor
    $monitor("%d \t\t%b", C, Out);

  //Set input values 
    X <= 4'b1111;
    Y <= 4'b1111;
    #1;
    X <= 4'b1110;
    Y <= 4'b0001;

  end
endmodule