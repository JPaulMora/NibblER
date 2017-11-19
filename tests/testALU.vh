
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
    opcode = `ADD;
end

//Connect to SUB module
 ALU alu(.A(X),.B(Y),.Out(Out),.carry(C), .zero(Z), .opcode(opcode));

initial
  begin
  //Print table headers 
    $display("\nTesting ALU\n");
  
  //Start monitor
    $monitor("%b\t%b\t%b", C, Z, Out);

  //Set input values 
  $display("\nTesting OUT A = 3 and A = 9\n");
  $display("Carry \tZero \tOut");
    opcode = `OUT;
    X = 4'b0011;
    Y = 4'b0000;
    #1;
    X = 4'b1001;
    Y = 4'b0000;
    #5

  $display("\nTesting CMP (10 - 3), (4 - 4) and (9-10)\n");
  $display("Carry \tZero \tOut");
    opcode = `CMP;
    X = 4'b1010;
    Y = 4'b0011;
    #1;
    X = 4'b0100;
    Y = 4'b0100;
    #1;
    X = 4'b1001;
    Y = 4'b1010;
    #5

  $display("\nTesting LD B = 3 and LD = 9\n");
  $display("Carry \tZero \tOut");
    opcode = `LD;
    X = 4'b0000;
    Y = 4'b0011;
    #1;
    X = 4'b0000;
    Y = 4'b1001;
    #5

  $display("\nTesting NOR (5 ~| 2) and (4 ~| 15)\n");
  $display("Carry \tZero \tOut");
    opcode = `NOR;
    X = 4'b0101;
    Y = 4'b0010;
    #1;
    X = 4'b0100;
    Y = 4'b1111;
    #5
    
  $display("\nTesting ADD (3 + 3) and (9 + 10)\n");
  $display("Carry \tZero \tOut");
    opcode = `ADD;
    X = 4'b0011;
    Y = 4'b0011;
    #1;
    X = 4'b1001; 
    Y = 4'b1010;
  end
endmodule