`include "ALU.vh"
`include "microROM.vh"
`include "Fetch.vh"
`include "PC.vh"
`include "ROM.vh"
`include "RAM.vh"
`include "busDriver.vh"
`include "Phase.vh"
`include "Flags.vh"
`include "A.vh"
`include "outFF.vh"


 module uP(
   input clk, reset,
   input [3:0] PUSHBUTTONS,

   output PHASE, C_FLAG, Z_FLAG,
   output [3:0] INSTR, OPERAND, DATA_BUS, ACCU, FF_OUT,
   output [7:0] PROGRAM_BYTE,
   output [11:0] ADDRESS_RAM, PC
   );

logic [11:0] newaddr;
wire [2:0] aluopcode;
wire [1:0] out_data;
wire [3:0] aluOut, A;

PC pc(.newaddr({OPERAND, PROGRAM_BYTE}), .loadPC(loadPC), .incPC(incPC), .clk(clk), .Rst(reset), .addr(ADDRESS_RAM));
rom r(.address(ADDRESS_RAM), .data(PROGRAM_BYTE));

Phase p(.clk(clk), .reset(reset), .Q(phase));
decode mr(.i(INSTR), .C(carry_to_urom), .Z(zero_to_urom), .phase(phase), .out_data({incPC, loadPC, loadA, loadFlags, aluopcode, out_data, oeALU, oeIN, oeOprnd, loadOut}));
Fetch f(.clk(clk), .reset(reset), .enable(phase), .D(PROGRAM_BYTE), .Q({INSTR,OPERAND}));

ALU alu(.opcode(aluopcode), .A(A), .B(DATA_BUS), .Out(aluOut), .carry(C), .zero(Z));
A ffa(.clk(clk), .reset(reset), .enable(loadA), .D(aluOut), .Q(A));
Flags flags(.clk(clk), .reset(reset), .enable(loadFlags), .zero(Z), .carry(C), .zero_out(zero_to_urom), .carry_out(carry_to_urom));

busDriver fetchDriver(.enable(oeOprnd), .A(OPERAND), .Y(DATA_BUS));
busDriver aluDriver(.enable(oeALU), .A(aluOut), .Y(DATA_BUS));

RAM ram (.we(out_data[1]), .cs(out_data[0]), .address({OPERAND, PROGRAM_BYTE}), .data(DATA_BUS));

out_FF out(.clk(clk), .reset(reset), .enable(loadOut), .D(DATA_BUS), .Q(FF_OUT));

busDriver buttons(.enable(oeIN), .A(PUSHBUTTONS), .Y(DATA_BUS));


always @(*) begin
  newaddr <= {OPERAND, PROGRAM_BYTE};

  end


endmodule