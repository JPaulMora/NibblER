`include "../PC.vh"
`include "../ROM.vh"
`include "../Phase.vh"
`include "../Fetch.vh"
`include "../microROM.vh"

module test();

//PC
logic [11:0] newaddr = 12'h00A;
logic clk = 0, Rst = 1;
wire [11:0] PC;
wire loadPC, incPC;

// ROM
wire [7:0] data;

// Phase
wire phase;

//Fetch
wire [3:0] instruction, operand;

//uROM
logic C = 0;
logic Z = 0;
wire [10:0] out_data;


PC pc(.newaddr(newaddr), .loadPC(loadPC), .incPC(incPC), .clk(clk), .Rst(Rst), .addr(PC));
rom r(.address(PC), .data(data));
Phase p(.clk(clk), .reset(Rst), .Q(phase));
decode mr(.i(instruction), .C(C), .Z(Z), .phase(phase), .out_data({incPC, loadPC, out_data}));
Fetch f(.clk(clk), .reset(Rst), .enable(phase), .D(data), .Q({instruction,operand}));

initial begin
  $display("Test PC + ROM + Phase + Fetch + uROM");
  $display("phase\tRst\tincPC\tloadPC\tPC\tnewaddr\tdata\tinstruction\toperand\tout_data");
  $monitor("%b\t%b\t%b\t%b\t%d\t%d\t%b\t%b\t%b\t%b", phase, Rst, incPC, loadPC, PC, newaddr, data, instruction, operand, out_data);
  #1 Rst = 0;
  
end

always
  #2 clk = ~clk;

initial
  #58 $finish;
endmodule

