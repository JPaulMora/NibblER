`include "../PC.vh"
`include "../ROM.vh"

`include "../Phase.vh"
`include "../Fetch.vh"
`include "../microROM.vh"

`include "../ALU.vh"
`include "../A.vh"
`include "../Flags.vh"

module test();

//PC
logic [11:0] newaddr = 12'h00A;
logic clk = 0, Rst = 1;
wire [11:0] PC;

// ROM
wire [7:0] data;

// Phase
wire phase;

//Fetch
wire [3:0] instruction, operand;

//uROM
wire C,Z;

wire  incPC, loadPC, loadA, loadFlags;
wire [2:0] aluopcode;
wire [5:0] out_data;

//ALU
logic [3:0] B = 4'h0;
wire [3:0] aluOut;

//A
wire [3:0] A; 


PC pc(.newaddr(newaddr), .loadPC(loadPC), .incPC(incPC), .clk(clk), .Rst(Rst), .addr(PC));
rom r(.address(PC), .data(data));

Phase p(.clk(clk), .reset(Rst), .Q(phase));
decode mr(.i(instruction), .C(C), .Z(Z), .phase(phase), .out_data({incPC, loadPC, loadA, loadFlags, aluopcode, out_data}));
Fetch f(.clk(clk), .reset(Rst), .enable(phase), .D(data), .Q({instruction,operand}));

ALU alu(.opcode(aluopcode), .A(A), .B(B), .Out(aluOut), .carry(C), .zero(Z));
A ffa(.clk(clk), .reset(Rst), .enable(loadA), .D(aluOut), .Q(A));



initial begin
  $display("Test PC + ROM + Phase + Fetch + uROM + ALU + A");
  $display("phase\tRst\tincPC\tloadPC\tPC\tnewaddr\tprogramByte\tinstr\toperand\taluopcode\t\tA\tC\tZ\tOutAlu");
  $monitor("%b\t%b\t%b\t%b\t%d\t%d\t%b\t%b\t%b\t%b\t\t%b\t%b\t%b\t%b\t%b", phase, Rst, incPC, loadPC, PC, newaddr, data, instruction, operand, aluopcode, loadA, A, C, Z, aluOut);
  #1 Rst = 0;
  #40 newaddr = 5;
end

always
  #2 clk = ~clk;

initial
  #312 $finish;
endmodule

