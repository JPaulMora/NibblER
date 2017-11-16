
//Testbench ALU submodules
`include "../ALU.vh"

//Test SUB
module testALU();

  //Initialize Connections
  logic [2:0] opcode;
  logic [3:0] X;
  logic [3:0] Y;
  wire [3:0] Out;
  wire C;
  wire Z;

initial
    begin
    opcode = 3'b011;
end

//Connect to SUB module
 ALU alu(.A(X),.B(Y),.Out(Out),.carry(C), .zero(Z), .opcode(opcode));

initial
  begin
  //Print table headers 
    $display("\nTesting ALU\n\n");
    $display("Carry \tZero \tO");
  
  //Start monitor
    $monitor("%b\t%b\t%b", C, Z, Out);

  //Set input values 
    X <= 4'b0011;
    Y <= 4'b0011;
    #1;
    X <= 4'b1001; 
    Y <= 4'b1010;

  end
endmodule