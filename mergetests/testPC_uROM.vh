`include "../PC.vh"
`include "../ROM.vh"

`include "../Phase.vh"
`include "../Fetch.vh"
`include "../microROM.vh"
`include "../RAM.vh"
`include "../ALU.vh"
`include "../A.vh"
`include "../Flags.vh"

`include "../busDriver.vh"

module test();

//PC
logic [11:0] newaddr;
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
wire [1:0] out_data;
wire oeALU, oeIN;
wire oeOprnd, loadOut;

//ALU
wire [3:0] aluOut;

//A
wire [3:0] A; 

//Flags
wire zero_to_urom;
wire carry_to_urom;

//BusDrive
wire [3:0] tri_state_buffer;


PC pc(.newaddr({operand, data}), .loadPC(loadPC), .incPC(incPC), .clk(clk), .Rst(Rst), .addr(PC));
rom r(.address(PC), .data(data));

Phase p(.clk(clk), .reset(Rst), .Q(phase));
decode mr(.i(instruction), .C(carry_to_urom), .Z(zero_to_urom), .phase(phase), .out_data({incPC, loadPC, loadA, loadFlags, aluopcode, out_data, oeALU, oeIN, oeOprnd, loadOut}));
Fetch f(.clk(clk), .reset(Rst), .enable(phase), .D(data), .Q({instruction,operand}));

ALU alu(.opcode(aluopcode), .A(A), .B(tri_state_buffer), .Out(aluOut), .carry(C), .zero(Z));
A ffa(.clk(clk), .reset(Rst), .enable(loadA), .D(aluOut), .Q(A));
Flags flags(.clk(clk), .reset(Rst), .enable(loadFlags), .zero(Z), .carry(C), .zero_out(zero_to_urom), .carry_out(carry_to_urom));

busDriver fetchDriver(.enable(oeOprnd), .A(operand), .Y(tri_state_buffer));
busDriver aluDriver(.enable(oeALU), .A(aluOut), .Y(tri_state_buffer));

RAM ram (.we(out_data[1]), .cs(out_data[0]), .address({operand, data}), .data(tri_state_buffer));

initial begin
  $display("Test PC + ROM + Phase + Fetch + uROM + ALU + A + BusDriver + RAM");
  //$display("phase\tRst\tincPC\tloadPC\tPC\tnewaddr\tprogramByte\tinstr\toperand\taluopcode\t\tA\tC\tZ\tOutAlu\toeOprnd\tbdA\ttri_state_buffer");
  //$monitor("%b\t%b\t%b\t%b\t%d\t%d\t%b\t%b\t%b\t%b\t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", phase, Rst, incPC, loadPC, PC, newaddr, data, instruction, operand, aluopcode, loadA, A, C, Z, aluOut, oeOprnd, bdA, tri_state_buffer);
  $display("Phase\t  PC\tprogrambyte\tinstr\toprnd\twe ws RAM\t\tbus\tA\tC\tZ\tAluOut\tIn");
  $monitor("%b\t%d\t%b\t%b\t%b\t%b  %b  %b\t%b\t%b\t%b\t%b\t%b\t%s",phase, PC, data, instruction, operand, out_data[1], out_data[0],newaddr, tri_state_buffer, A, C, Z, aluOut, "in");
  #1 Rst = 0;
end

always
  #2 clk = ~clk;

always @(*) begin
  newaddr <= {operand, data};

  end

initial
  #1000 $finish;
endmodule

