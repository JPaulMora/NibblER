`include "ALU.vh"
`include "microROM.vh"
`include "Fetch.vh"
`include "PC.vh"
`include "ROM.vh"
`include "busDriver.vh"
`include "Phase.vh"
`include "Flags.vh"
`include "A.vh"
`include "outFF.vh"

 module uP(
   input clk, reset,
   input [3:0] PUSHBUTTONS,

   output PHASE, C_FLAG, Z_FLAG, PC,
   output [3:0] INSTR, OPERAND, DATA_BUS, ACCU, FF_OUT,
   output [7:0] PROGRAM_BYTE,
   output [11:0] ADDRESS_RAM
   );


