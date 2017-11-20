`include "../ALU.vh" 
`include "../microROM.vh" 
`include "../Fetch.vh" 
`include "../PC.vh" 
`include "../ROM.vh" 
`include "../busDriver.vh" 
`include "../Phase.vh" 
`include "../Flags.vh" 
`include "../A.vh" 
`include "../outFF.vh" 
  
  
module uP( 
  input logic clk, reset, 
  input logic [3:0] PUSHBUTTONS, 
  output wire PHASE, C_FLAG, Z_FLAG, 
  output wire [3:0] INSTR, OPERAND, DATA_BUS, FF_OUT, ACCU, 
  output wire [7:0] PROGRAM_BYTE, 
  output wire [11:0] PC, ADDRESS_RAM 
  ); 
  
  wire [11:0] address; 
  wire [11:0] address_con = {operand, program_byte}; 
  wire [7:0] program_byte; 
  wire [3:0] instr, operand, accu_alu, alu_out_wire; 
  wire [2:0] S; 
  wire incPC, loadPC, loadA, loadFlags, csRAM, weRAM, oeALU, oeIN, oeOperand, loadOut; 
  wire Z_alu, C_out_alu, Z_FF, C_out_FF, phase; 
  wire [3:0] data_bus; 
  
  PC program_counter(.clk(clk), .Rst(reset), .incPC(incPC), .loadPC(loadPC), .addr(address), .newaddr(address_con)); 
  rom progRom(.address(address), .data(program_byte));  
  Fetch fetch_FF(.clk(clk), .reset(reset), .D(program_byte), .Q({instr, operand}), .enable(phase)); 
  
  Flags load_flags_FF(.clk(clk), .reset(reset), .enable(loadFlags), .zero(Z_alu), .carry(C_out_alu), .zero_out(Z_FF), .carry_out(C_out_FF)); 
  Phase ph(.clk(clk), .reset(reset), .Q(phase)); 
  decode dc(.phase(phase), .C(C_out_FF), .Z(Z_FF), .i(instr), .out_data({incPC, loadPC, loadA, loadFlags, S,csRAM, weRAM, oeALU, oeIN, oeOperand, loadOut})); 
  
  busDriver operandBuffer(.enable(oeOperand), .A(operand), .Y(data_bus)); 
  ALU ALU(.opcode(S), .A(accu_alu), .B(data_bus), .Out(alu_out_wire), .carry(C_out_alu), .zero(Z_alu));  
  A ACCU_I(.clk(clk), .reset(reset), .enable(loadA), .D(alu_out_wire), .Q(accu_alu)); 
  busDriver aluBuffer(.enable(oeALU), .A(alu_out_wire), .Y(data_bus)); 
  
  out_FF OUT_FF(.clk(clk), .reset(reset), .enable(loadOut), .D(data_bus), .Q(FF_OUT));  //----loadOut es wire 
  
  assign PHASE = phase; 
  assign C_FLAG = C_out_FF; 
  assign Z_FLAG = Z_FF; 
  assign INSTR = instr; 
  assign OPERAND = operand; 
  assign DATA_BUS = data_bus; 
  assign ACCU = accu_alu; 
  assign PROGRAM_BYTE = program_byte; 
  assign PC = address; 
  assign ADDRESS_RAM = {operand, program_byte}; 
  
endmodule